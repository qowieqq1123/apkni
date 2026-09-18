# -*- coding: utf-8 -*-
"""
Il2Cpp 符号提取工具

从 script.json / dump.cs 中提取网络协议相关符号，生成：
  1. NetWorkProtocolParser 方法地址映射
  2. eDataType 枚举与协议 type 码对照
  3. 网络相关类层次结构
  4. struct_id 前缀含义分析（10000=RECV, 11000=SEND, 3000=ATTR）
  5. 协议 struct 与 Il2Cpp 方法交叉引用
"""
import argparse
import csv
import json
import os
import re
import sys
from collections import defaultdict

# 从 dump.cs 提取类型定义的 pattern
CLASS_PATTERN = re.compile(
    r'(public|private|internal|protected)\s+'
    r'(static\s+)?(class|struct|enum|interface)\s+'
    r'(\S+)'
    r'(?:\s*:\s*(.*?))?'
    r'\s*(?://\s*TypeDefIndex:\s*(\d+))?'
)
METHOD_PATTERN = re.compile(
    r'//\s*RVA:\s*(0x[0-9A-Fa-f]+)\s+Offset:\s*(0x[0-9A-Fa-f]+)'
    r'\s+VA:\s*(0x[0-9A-Fa-f]+)'
    r'\s*\n\s*(?:public|private|internal|protected|static)?\s*'
    r'(?:.*?\s+)?(\w+)\(.*?\)\s*\{\}',
    re.MULTILINE
)
CONST_PATTERN = re.compile(
    r'public\s+const\s+\w+\s+(\w+)\s*=\s*([-\d]+)'
)
ENUM_FIELD_PATTERN = re.compile(
    r'public\s+const\s+\S+\s+(\w+)\s*=\s*(\d+)'
)


def parse_script_json(path):
    """读取 script.json，返回 dict: Address -> {Name, Signature}"""
    with open(path, 'r', encoding='utf-8') as fp:
        data = json.load(fp)
    methods = {}
    for m in data.get('ScriptMethod', []):
        addr = m.get('Address')
        if addr:
            methods[addr] = {
                'Name': m.get('Name', ''),
                'Signature': m.get('Signature', ''),
            }
    return methods


def find_network_classes(dump_path):
    """
    从 dump.cs 提取网络协议相关的类/枚举定义
    返回 dict
    """
    results = {
        'classes': {},
        'enums': {},
        'constants': {},
        'struct_readers': [],
    }

    with open(dump_path, 'r', encoding='utf-8') as fp:
        lines = fp.readlines()

    i = 0
    n = len(lines)
    current_class = None
    current_type = None
    in_enum = False
    enum_name = None

    while i < n:
        line = lines[i]

        # 检测 class / struct / enum 定义
        m = CLASS_PATTERN.search(line)
        if m:
            visibility = m.group(1)
            is_static = m.group(2) or ''
            kind = m.group(3)  # class, struct, enum, interface
            name = m.group(4)
            inherit = m.group(5) or ''
            type_idx = m.group(6) or ''

            if 'Network' in name or 'Protocol' in name or 'Packet' in name or 'Socket' in name:
                current_class = {
                    'name': name,
                    'kind': kind,
                    'visibility': visibility,
                    'static': is_static.strip(),
                    'inherit': inherit.strip(),
                    'type_idx': type_idx,
                    'fields': [],
                    'methods': [],
                    'consts': {},
                }
                if kind == 'enum':
                    results['enums'][name] = {'fields': {}}
                    enum_name = name
                    in_enum = True
                else:
                    results['classes'][name] = current_class
                    in_enum = False
                    enum_name = None
            else:
                current_class = None
                in_enum = False
                enum_name = None
            i += 1
            continue

        # 在 enum 中提取字段
        if in_enum and enum_name:
            fm = ENUM_FIELD_PATTERN.search(line)
            if fm:
                fname = fm.group(1)
                fval = int(fm.group(2))
                results['enums'][enum_name]['fields'][fname] = fval
            # enum 结束
            if '}' in line and not line.strip().startswith('//'):
                in_enum = False
                enum_name = None
                i += 1
                continue

        # 在 class 中提取常量
        if current_class and not in_enum:
            cm = CONST_PATTERN.search(line)
            if cm:
                cname = cm.group(1)
                cval = cm.group(2)
                current_class['consts'][cname] = cval

            # 检测方法 (RVA 行 + 方法签名行)
            mm = re.match(
                r'//\s*RVA:\s*(0x[0-9A-Fa-f]+)\s+Offset:\s*(0x[0-9A-Fa-f]+)'
                r'\s+VA:\s*(0x[0-9A-Fa-f]+)',
                line
            )
            if mm:
                rva = mm.group(1)
                offset = mm.group(2)
                va = mm.group(3)
                # 下一行应该是方法签名
                if i + 1 < n:
                    sig_line = lines[i + 1].strip()
                    method_name = sig_line.split('(')[0].split()[-1] if '(' in sig_line else sig_line
                    current_class['methods'].append({
                        'rva': rva,
                        'offset': offset,
                        'va': va,
                        'signature': sig_line,
                        'name': method_name,
                    })

            # 检测字段
            field_match = re.match(
                r'\s*public\s+(\S+)\s+(\w+)\s*;\s*(?://\s*0x(\w+))?',
                line
            )
            if field_match:
                ftype = field_match.group(1)
                fname = field_match.group(2)
                current_class['fields'].append({
                    'type': ftype,
                    'name': fname,
                })

        i += 1

    # 查找 RawFileReader 中的 struct reader 方法
    print('  搜索 RawFileReader struct 读取方法...')
    in_rawfilereader = False
    for i, line in enumerate(lines):
        if 'class RawFileReader' in line:
            in_rawfilereader = True
        if in_rawfilereader:
            m = re.search(r'static\s+(\S+)\s+(\w+)Read\(RawFile', line)
            if m:
                return_type = m.group(1)
                method_name = m.group(2)
                results['struct_readers'].append({
                    'return_type': return_type,
                    'method': method_name,
                })
            if in_rawfilereader and '}' in line and line.strip() == '}':
                # RawFileReader 类的结束大括号是独立一行
                # 但为了安全，只在遇到下一个 class 定义时退出
                pass
            if in_rawfilereader and re.search(r'^(public|private|internal|protected)\s', line) and 'class ' in line and 'RawFileReader' not in line:
                break

    return results


def find_net_script_methods(script_methods):
    """从 script.json 中筛选网络相关方法"""
    net_keywords = [
        'NetWork', 'Protocol', 'Network', 'Packet', 'Socket',
        'RawFile', 'CreatePFunction', 'CreateProtocel',
    ]
    net_methods = {}
    for addr, info in script_methods.items():
        name = info['Name']
        for kw in net_keywords:
            if kw in name:
                net_methods[addr] = info
                break
    return net_methods


def create_type_mapping():
    """从 dump.cs 中提取的 eDataType 枚举"""
    return {
        0: ('None', '无类型'),
        1: ('Char', '有符号字节'),
        2: ('UChar', '无符号字节'),
        3: ('Short', '有符号短整型'),
        4: ('UShort', '无符号短整型'),
        5: ('Int', '有符号整型'),
        6: ('UInt', '无符号整型'),
        7: ('Int64', '有符号长整型'),
        8: ('UInt64', '无符号长整型'),
        9: ('Float', '浮点数'),
        10: ('String', '字符串(UTF-8)'),
        11: ('Struct', '内嵌结构体'),
        12: ('Array', '数组(低字节type=0x12)'),
        255: ('EndOfAttr', '属性结束标记'),
    }


def main():
    ap = argparse.ArgumentParser(description='Il2Cpp 符号提取工具')
    ap.add_argument('--script-json', default='out/il2cpp/script.json',
                    help='script.json 路径')
    ap.add_argument('--dump-cs', default='out/il2cpp/dump.cs',
                    help='dump.cs 路径')
    ap.add_argument('--structs-csv', default='out/structs.csv',
                    help='structs.csv 路径')
    ap.add_argument('-o', '--outdir', default='out',
                    help='输出目录')
    args = ap.parse_args()

    script_path = os.path.join(os.getcwd(), args.script_json) if not os.path.isabs(args.script_json) else args.script_json
    dump_path = os.path.join(os.getcwd(), args.dump_cs) if not os.path.isabs(args.dump_cs) else args.dump_cs
    structs_path = os.path.join(os.getcwd(), args.structs_csv) if not os.path.isabs(args.structs_csv) else args.structs_csv
    outdir = os.path.join(os.getcwd(), args.outdir) if not os.path.isabs(args.outdir) else args.outdir

    os.makedirs(outdir, exist_ok=True)

    print('=' * 60)
    print('Il2Cpp 符号提取')
    print('=' * 60)

    # 1. 读取 script.json
    print(f'\n[1] 读取 script.json: {script_path}')
    script_methods = parse_script_json(script_path)
    print(f'    共 {len(script_methods)} 个方法')

    # 2. 筛选网络相关方法
    net_script_methods = find_net_script_methods(script_methods)
    print(f'\n[2] 网络相关方法: {len(net_script_methods)} 个')

    # 3. 解析 dump.cs 中的网络类
    print(f'\n[3] 解析 dump.cs 网络类: {dump_path}')
    net_info = find_network_classes(dump_path)
    print(f'    网络类: {len(net_info["classes"])} 个')
    print(f'    枚举: {len(net_info["enums"])} 个')
    print(f'    RawFileReader 方法: {len(net_info["struct_readers"])} 个')

    # 4. 类型映射
    type_map = create_type_mapping()
    print(f'\n[4] 协议类型码映射: {len(type_map)} 种')

    # 5. 加载 structs.csv
    print(f'\n[5] 加载 structs.csv: {structs_path}')
    struct_ids = set()
    struct_names = {}
    with open(structs_path, 'r', encoding='utf-8-sig') as fp:
        reader = csv.DictReader(fp)
        for row in reader:
            sid = int(row['struct_id'])
            sname = row['struct']
            struct_ids.add(sid)
            struct_names[sid] = sname
    # 按 id 范围分类
    recv_structs = {sid: struct_names[sid] for sid in struct_ids if 10000 <= sid < 11000 and sid in struct_names}
    send_structs = {sid: struct_names[sid] for sid in struct_ids if 11000 <= sid < 12000 and sid in struct_names}
    attr_structs = {sid: struct_names[sid] for sid in struct_ids if 3000 <= sid < 4000 and sid in struct_names}
    other_structs = {sid: struct_names[sid] for sid in struct_ids if sid not in recv_structs and sid not in send_structs and sid not in attr_structs and sid in struct_names}

    print(f'    RECV 结构 (10000-10999): {len(recv_structs)}')
    print(f'    SEND 结构 (11000-11999): {len(send_structs)}')
    print(f'    ATTR 结构 (3000-3999):  {len(attr_structs)}')
    print(f'    其他: {len(other_structs)}')

    # 6. 输出文件

    # 6a. 网络方法映射 CSV
    net_map_path = os.path.join(outdir, 'il2cpp_net_methods.csv')
    with open(net_map_path, 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['address', 'name', 'signature'])
        for addr in sorted(net_script_methods.keys()):
            info = net_script_methods[addr]
            w.writerow([addr, info['Name'], info['Signature']])
    print(f'\n[6a] 网络方法映射: {net_map_path}')

    # 6b. 协议类型码参考 CSV
    type_path = os.path.join(outdir, 'protocol_types.csv')
    with open(type_path, 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['type_code', 'enum_name', 'description', 'csharp_type'])
        cs_type_map = {
            0: 'void', 1: 'sbyte', 2: 'byte', 3: 'short', 4: 'ushort',
            5: 'int', 6: 'uint', 7: 'long', 8: 'ulong', 9: 'float',
            10: 'string', 11: 'struct', 12: 'array', 255: 'EndOfAttr'
        }
        for code in sorted(type_map.keys()):
            name, desc = type_map[code]
            cs_type = cs_type_map.get(code, 'unknown')
            w.writerow([code, name, desc, cs_type])
    print(f'[6b] 类型码映射: {type_path}')

    # 6c. Il2Cpp 网络类层次 CSV
    class_path = os.path.join(outdir, 'il2cpp_net_classes.csv')
    with open(class_path, 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['class_name', 'kind', 'visibility', 'inherit', 'type_idx', 'method_count', 'field_count'])
        for cname, info in sorted(net_info['classes'].items()):
            w.writerow([
                cname, info['kind'], info['visibility'],
                info['inherit'], info['type_idx'],
                len(info['methods']), len(info['fields'])
            ])
    print(f'[6c] 网络类层次: {class_path}')

    # 6d. Il2Cpp 协议映射报告 TXT
    report_path = os.path.join(outdir, 'il2cpp_protocol_report.txt')
    with open(report_path, 'w', encoding='utf-8-sig') as fp:
        fp.write('Il2Cpp 符号提取报告\n')
        fp.write('=' * 60 + '\n\n')

        # 网络类详情
        fp.write('一、网络协议相关类\n')
        fp.write('-' * 60 + '\n')
        for cname, info in sorted(net_info['classes'].items()):
            fp.write(f'\n  {info["visibility"]} {info["static"]} {info["kind"]} {cname}')
            if info['inherit']:
                fp.write(f' : {info["inherit"]}')
            if info['type_idx']:
                fp.write(f'  [TypeDefIndex: {info["type_idx"]}]')
            fp.write('\n')

            if info['consts']:
                fp.write(f'    常量:\n')
                for cname_c, cval in info['consts'].items():
                    fp.write(f'      {cname_c} = {cval}\n')

            if info['fields']:
                fp.write(f'    字段 ({len(info["fields"])}):\n')
                for f in info['fields'][:20]:
                    fp.write(f'      {f["type"]} {f["name"]}\n')
                if len(info['fields']) > 20:
                    fp.write(f'      ... 共 {len(info["fields"])} 个\n')

            if info['methods']:
                fp.write(f'    方法 ({len(info["methods"])}):\n')
                for m in info['methods'][:30]:
                    fp.write(f'      RVA={m["rva"]} {m["signature"]}\n')
                if len(info['methods']) > 30:
                    fp.write(f'      ... 共 {len(info["methods"])} 个\n')

        # eDataType 枚举
        fp.write('\n\n二、eDataType 类型枚举\n')
        fp.write('-' * 60 + '\n')
        for code in sorted(type_map.keys()):
            name, desc = type_map[code]
            fp.write(f'  0x{code:02x} ({code:3d}) = {name:12s}  {desc}\n')

        # struct_id 范围分析
        fp.write('\n\n三、struct_id 范围分析\n')
        fp.write('-' * 60 + '\n')
        fp.write(f'\n  RECV 结构体 (struct_id 10000-10999): {len(recv_structs)} 个\n')
        fp.write(f'    说明: 客户端接收(服务端→客户端)的数据结构\n')
        for sid in sorted(recv_structs.keys())[:20]:
            fp.write(f'      {sid}: {recv_structs[sid]}\n')
        if len(recv_structs) > 20:
            fp.write(f'      ... 共 {len(recv_structs)} 个\n')

        fp.write(f'\n  SEND 结构体 (struct_id 11000-11999): {len(send_structs)} 个\n')
        fp.write(f'    说明: 客户端发送(客户端→服务端)的数据结构\n')
        for sid in sorted(send_structs.keys())[:20]:
            fp.write(f'      {sid}: {send_structs[sid]}\n')
        if len(send_structs) > 20:
            fp.write(f'      ... 共 {len(send_structs)} 个\n')

        fp.write(f'\n  ATTR 结构体 (struct_id 3000-3999): {len(attr_structs)} 个\n')
        fp.write(f'    说明: 角色属性/变量定义\n')
        for sid in sorted(attr_structs.keys())[:20]:
            fp.write(f'      {sid}: {attr_structs[sid]}\n')
        if len(attr_structs) > 20:
            fp.write(f'      ... 共 {len(attr_structs)} 个\n')

        if other_structs:
            fp.write(f'\n  其他结构体: {len(other_structs)} 个\n')
            for sid in sorted(other_structs.keys()):
                fp.write(f'      {sid}: {other_structs[sid]}\n')

        # RawFileReader 中的结构体
        fp.write('\n\n四、RawFileReader 结构体读取方法\n')
        fp.write('-' * 60 + '\n')
        fp.write('  这些是 C# 端直接读取的自定义数据结构，与协议无关：\n')
        for sr in net_info['struct_readers']:
            fp.write(f'    {sr["return_type"]} {sr["method"]}\n')

        # 关键网络方法
        fp.write('\n\n五、关键网络方法（script.json）\n')
        fp.write('-' * 60 + '\n')
        key_methods = [
            'NetWorkProtocolParser$$CreatePFunction',
            'NetWorkProtocolParser$$CreateProtocel',
            'NetWorkProtocolParser$$CreateNetWorkProtocolInfo',
            'NetWorkProtocolParser$$Parse',
            'NetWorkProtocolParser$$ParseOnePass',
            'NetWorkProtocolParser$$RecvOnePass',
            'NetWorkProtocolParser$$Init',
            'NetWorkProtocolParser$$Load',
            'NetWorkProtocolParser$$.ctor',
        ]
        for km in key_methods:
            found = False
            for addr, info in net_script_methods.items():
                if km in info['Name']:
                    sig = info['Signature'][:100]
                    fp.write(f'  {info["Name"]}\n')
                    fp.write(f'    Address: {addr}\n')
                    fp.write(f'    Signature: {sig}\n')
                    found = True
                    break
            if not found:
                fp.write(f'  {km}  [未找到]\n')

    print(f'\n[6d] Il2Cpp 协议报告: {report_path}')

    # 6e. struct_id 到 Il2Cpp 方法映射
    struct_method_map_path = os.path.join(outdir, 'il2cpp_struct_methods.csv')
    with open(struct_method_map_path, 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['struct_id', 'struct_name', 'range_type', 'il2cpp_methods'])
        for sid in sorted(struct_ids):
            sname = struct_names.get(sid, '')
            if 10000 <= sid < 11000:
                range_type = 'RECV'
            elif 11000 <= sid < 12000:
                range_type = 'SEND'
            elif 3000 <= sid < 4000:
                range_type = 'ATTR'
            else:
                range_type = 'OTHER'
            w.writerow([sid, sname, range_type, ''])
    print(f'[6e] struct 映射: {struct_method_map_path}')

    print('\n提取完成！')
    return 0


if __name__ == '__main__':
    sys.exit(main())