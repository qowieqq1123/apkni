# -*- coding: utf-8 -*-
"""
Lua do_protocol_* 交叉核对工具

扫描 out/binary/ 下所有 .lua 文件，提取 do_protocol_{key}_{funcId} 模式，
与 out/protocels.csv 协议表对照，标出：
  - Lua 用到但协议表缺失的 (key, funcId)
  - 协议表中有但 Lua 未引用的 (key, funcId)
  - 按 protocel_key 汇总的完整覆盖报告
"""
import argparse
import csv
import os
import re
import sys
from collections import defaultdict

# do_protocol_{key}_{funcId} 匹配模式
PROTO_PATTERN = re.compile(r'do_protocol_(\d+)_(\d+)')


def scan_lua_files(binary_dir):
    """
    扫描 binary 目录下所有 .lua 文件，
    返回 dict: (key, funcId) -> [file1, file2, ...]
    """
    pairs = defaultdict(list)
    for root, dirs, files in os.walk(binary_dir):
        for fname in files:
            if not fname.endswith('.lua'):
                continue
            fpath = os.path.join(root, fname)
            relpath = os.path.relpath(fpath, binary_dir)
            try:
                with open(fpath, 'r', encoding='utf-8-sig') as fp:
                    content = fp.read()
            except Exception as e:
                print(f'  [WARN] 读取失败: {relpath} -> {e}', file=sys.stderr)
                continue
            for m in PROTO_PATTERN.finditer(content):
                key = int(m.group(1))
                fid = int(m.group(2))
                pairs[(key, fid)].append(relpath)
    return pairs


def load_protocels(csv_path):
    """
    加载 protocels.csv
    返回 set of (protocel_key, func_id)
    """
    proto_set = set()
    with open(csv_path, 'r', encoding='utf-8-sig') as fp:
        reader = csv.DictReader(fp)
        for row in reader:
            key = int(row['protocel_key'])
            fid = int(row['func_id'])
            proto_set.add((key, fid))
    return proto_set


def load_protocel_keys_tables(csv_path):
    """
    加载 protocels.csv 完整信息
    返回 dict: protocel_key -> { table: [func_id, ...] }
    """
    keys = defaultdict(lambda: defaultdict(set))
    with open(csv_path, 'r', encoding='utf-8-sig') as fp:
        reader = csv.DictReader(fp)
        for row in reader:
            key = int(row['protocel_key'])
            tbl = row['table']  # 'A' or 'B'
            fid = int(row['func_id'])
            keys[key][tbl].add(fid)
    return keys


def main():
    ap = argparse.ArgumentParser(description='Lua do_protocol_* 交叉核对工具')
    ap.add_argument('--binary', default='out/binary',
                    help='Lua 代码目录 (默认 out/binary)')
    ap.add_argument('--protocels', default='out/protocels.csv',
                    help='协议表 CSV (默认 out/protocels.csv)')
    ap.add_argument('-o', '--outdir', default='out',
                    help='输出目录 (默认 out)')
    args = ap.parse_args()

    binary_dir = os.path.join(os.getcwd(), args.binary) if not os.path.isabs(args.binary) else args.binary
    protocels_path = os.path.join(os.getcwd(), args.protocels) if not os.path.isabs(args.protocels) else args.protocels
    outdir = os.path.join(os.getcwd(), args.outdir) if not os.path.isabs(args.outdir) else args.outdir

    print('=' * 60)
    print('Lua do_protocol_* 交叉核对')
    print('=' * 60)

    # 1. 加载协议表
    print(f'\n[1] 加载协议表: {protocels_path}')
    proto_set = load_protocels(protocels_path)
    proto_keys = load_protocel_keys_tables(protocels_path)
    print(f'    协议表共 {len(proto_set)} 条映射 ({len(proto_keys)} 个 protocel key)')

    # 2. 扫描 Lua
    print(f'\n[2] 扫描 Lua 文件: {binary_dir}')
    lua_pairs = scan_lua_files(binary_dir)
    print(f'    在 {len(lua_pairs)} 个 (key,funcId) 中找到引用')

    # 3. 交叉核对
    lua_set = set(lua_pairs.keys())
    only_in_lua = lua_set - proto_set       # Lua 有但协议表无
    only_in_proto = proto_set - lua_set     # 协议表有但 Lua 无
    intersection = lua_set & proto_set      # 两者都有

    print(f'\n[3] 核对结果:')
    print(f'    共同覆盖: {len(intersection)} 条')
    print(f'    Lua 独有(表缺失): {len(only_in_lua)} 条')
    print(f'    协议表独有(Lua未用): {len(only_in_proto)} 条')

    # 4. 按 protocel_key 汇总覆盖率
    print(f'\n[4] 按 protocel key 覆盖率:')
    coverage_rows = []
    for key in sorted(proto_keys.keys()):
        tbl_a = proto_keys[key].get('A', set())
        tbl_b = proto_keys[key].get('B', set())
        all_fids = tbl_a | tbl_b
        used_fids = {fid for (k, fid) in lua_set if k == key and fid in all_fids}
        missing_fids = all_fids - used_fids
        pct = len(used_fids) / len(all_fids) * 100 if all_fids else 0
        coverage_rows.append((key, len(all_fids), len(used_fids), len(missing_fids), pct))
        status = 'PASS' if pct == 100 else '部分'
        if pct == 100:
            print(f'    key={key:3d}: {len(all_fids):3d} 全部覆盖 ({pct:.0f}%) [{status}]')
        else:
            print(f'    key={key:3d}: {len(used_fids):3d}/{len(all_fids):3d} 缺失 {len(missing_fids):3d} ({pct:.0f}%) [{status}]')

    # 5. 输出详细文件

    # 5a. 完整对照 CSV
    csv_path = os.path.join(outdir, 'lua_protocol_coverage.csv')
    with open(csv_path, 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['protocel_key', 'func_id', 'in_protocol', 'in_lua', 'lua_files'])
        for key in sorted(proto_keys.keys()):
            for tbl in ('A', 'B'):
                for fid in sorted(proto_keys[key].get(tbl, set())):
                    in_lua = 'Y' if (key, fid) in lua_set else 'N'
                    files = ';'.join(sorted(lua_pairs.get((key, fid), [])))
                    w.writerow([key, fid, f'table_{tbl}', in_lua, files])
        # Lua 独有条目
        for (key, fid) in sorted(only_in_lua):
            files = ';'.join(sorted(lua_pairs[(key, fid)]))
            w.writerow([key, fid, 'NONE', 'Y', files])
    print(f'\n[5a] 完整对照表: {csv_path}')

    # 5b. 差异报告 TXT
    txt_path = os.path.join(outdir, 'lua_protocol_report.txt')
    with open(txt_path, 'w', encoding='utf-8-sig') as fp:
        fp.write('Lua do_protocol_* 交叉核对报告\n')
        fp.write('=' * 60 + '\n\n')
        fp.write(f'协议表总条目: {len(proto_set)}\n')
        fp.write(f'Lua 引用总条目: {len(lua_set)}\n')
        fp.write(f'共同覆盖: {len(intersection)}\n')
        fp.write(f'Lua 独有(协议表缺失): {len(only_in_lua)}\n')
        fp.write(f'协议表独有(Lua未引用): {len(only_in_proto)}\n\n')

        # 按 key 汇总
        fp.write('按 protocel key 覆盖率\n')
        fp.write('-' * 60 + '\n')
        fp.write(f'{"key":>5}  {"总数":>5}  {"已用":>5}  {"缺失":>5}  {"覆盖率":>8}\n')
        fp.write('-' * 60 + '\n')
        for key, total, used, missing, pct in coverage_rows:
            fp.write(f'{key:5d}  {total:5d}  {used:5d}  {missing:5d}  {pct:7.1f}%\n')
        fp.write('\n')

        # Lua 独有条目详情
        if only_in_lua:
            fp.write('\nLua 独有条目（协议表缺失，需人工关注）\n')
            fp.write('=' * 60 + '\n')
            for (key, fid) in sorted(only_in_lua):
                files = lua_pairs[(key, fid)]
                fp.write(f'  key={key}, funcId={fid}: {len(files)} 处引用\n')
                for f in sorted(files)[:10]:
                    fp.write(f'    - {f}\n')
                if len(files) > 10:
                    fp.write(f'    ... 共 {len(files)} 处\n')
            fp.write('\n')

        # 协议表独有条目详情
        if only_in_proto:
            fp.write('\n协议表独有条目（Lua 未引用，可能是 C# 端或已废弃）\n')
            fp.write('=' * 60 + '\n')
            # 按 key 分组
            by_key = defaultdict(list)
            for (key, fid) in only_in_proto:
                by_key[key].append(fid)
            for key in sorted(by_key.keys()):
                fids = sorted(by_key[key])
                fp.write(f'  key={key}: {len(fids)} 个 funcId: {fids[:20]}\n')
                if len(fids) > 20:
                    fp.write(f'    ... 共 {len(fids)} 个\n')
            fp.write('\n')

        # 每个 key 的详细对比
        fp.write('\n每个 protocel key 详细对比\n')
        fp.write('=' * 60 + '\n')
        for key in sorted(proto_keys.keys()):
            all_fids = set()
            for tbl in ('A', 'B'):
                all_fids |= proto_keys[key].get(tbl, set())
            used_fids = {fid for (k, fid) in lua_set if k == key and fid in all_fids}
            fp.write(f'\n--- key={key} ---\n')
            for tbl in ('A', 'B'):
                fids = sorted(proto_keys[key].get(tbl, set()))
                if not fids:
                    continue
                fp.write(f'  [table {tbl}] {len(fids)} 个 funcId\n')
                for fid in fids:
                    in_lua = (key, fid) in lua_set
                    marker = '  OK' if in_lua else '  !!缺失'
                    files = lua_pairs.get((key, fid), [])
                    fname = os.path.basename(files[0]) if files else '-'
                    fp.write(f'    {marker}  {key}_{fid}  {fname}\n')
    print(f'[5b] 差异报告: {txt_path}')

    # 5c. Lua 引用完整列表
    lua_list_path = os.path.join(outdir, 'lua_do_protocol_list.txt')
    with open(lua_list_path, 'w', encoding='utf-8-sig') as fp:
        fp.write('Lua do_protocol_* 全部引用列表\n')
        fp.write('=' * 60 + '\n\n')
        for (key, fid) in sorted(lua_pairs.keys()):
            files = lua_pairs[(key, fid)]
            fp.write(f'{key}_{fid}: {len(files)} 处\n')
            for f in sorted(files):
                fp.write(f'    {f}\n')
            fp.write('\n')
    print(f'[5c] Lua 引用列表: {lua_list_path}')

    print('\n核对完成！')
    return 0


if __name__ == '__main__':
    sys.exit(main())