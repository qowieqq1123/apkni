# -*- coding: utf-8 -*-
"""瑙ｆ瀽 config.ab 閲岀殑 protocol.protocols 鍗忚瀹氫箟琛?

鏍煎紡鏉ユ簮锛歭ibil2cpp.so 鍙嶆眹缂栵紙capstone锛夛紝闈炵寽娴嬶細
  NetBitStream.ReadByte  = 1 瀛楄妭
  NetBitStream.ReadInt   = 灏忕 i32锛圔itConverter.ToInt32锛?
  RawFile.ReadString     = u16 LE 闀垮害 n; n==0 -> 绌轰覆(涓嶆秷璐圭粓姝㈢);
                           鍚﹀垯璇?n 瀛楄妭 UTF-8锛屽啀璺宠繃 1 瀛楄妭 '\0'

椤跺眰锛圕reateNetWorkProtocolInfo @0x105C898锛?
  ReadString -> "protos begin\n"
  ReadString -> "netstruct\n"
  CreatePFunction (count=0, 绌鸿〃)
  CreatePFunction (count=1066) -> 缁撴瀯瀹氫箟琛紙PFunction = 缁撴瀯锛?
  ReadString -> "proto\n"
  ReadInt    -> protocel 鏁伴噺 N
  N 脳 CreateProtocel: ReadInt key; CreatePFunction 琛ˋ; CreatePFunction 琛˙
  ReadString -> "protos end\n"

CreatePFunction锛園0x105F440锛? ReadInt count; count 脳:
  ReadInt funcId; ReadInt paramCount; ReadString name;
  paramCount 脳 ProtocelParams锛園0x105F644 璧凤級:
    ReadByte type; ReadByte subtype; ReadInt count; ReadString name;
    ReadInt typename_id; ReadInt condition;
    if condition != 0: ReadInt index; ReadInt n; n 脳 ReadInt args
"""
import argparse
import csv
import os
import sys


class Reader:
    def __init__(self, d, pos=0):
        self.d = d
        self.p = pos

    def byte(self):
        v = self.d[self.p]
        self.p += 1
        return v

    def int(self):
        v = int.from_bytes(self.d[self.p:self.p + 4], 'little', signed=True)
        self.p += 4
        return v

    def string(self):
        n = int.from_bytes(self.d[self.p:self.p + 2], 'little')
        self.p += 2
        if n == 0:
            return ''
        s = self.d[self.p:self.p + n].decode('utf-8', 'replace')
        self.p += n
        # 终止符 '\0' 仅当确实存在时才跳过（文件末尾 protos end 后即无终止符）
        if self.p < len(self.d) and self.d[self.p] == 0:
            self.p += 1
        return s


def parse_pfunction(r):
    """CreatePFunction: 杩斿洖 dict(funcId -> PFunction)"""
    count = r.int()
    out = {}
    for _ in range(count):
        func_id = r.int()
        param_count = r.int()
        name = r.string()
        params = []
        for _ in range(param_count):
            ptype = r.byte()
            subtype = r.byte()
            pcnt = r.int()
            pname = r.string()
            typename_id = r.int()
            condition = r.int()
            skip = None
            if condition != 0:
                idx = r.int()
                n = r.int()
                skip = {'index': idx, 'n': n, 'args': [r.int() for _ in range(n)]}
            params.append(dict(type=ptype, subtype=subtype, count=pcnt,
                               name=pname, typename_id=typename_id,
                               condition=condition, skip=skip))
        out[func_id] = dict(func_id=func_id, name=name, params=params)
    return out


def parse(path):
    d = open(path, 'rb').read()
    r = Reader(d, 0)
    tag1 = r.string()
    tag2 = r.string()
    parse_pfunction(r)               # 绌鸿〃 (count=0)
    netstruct = parse_pfunction(r)   # 缁撴瀯瀹氫箟琛?
    tag3 = r.string()
    protocel_count = r.int()
    protocels = []
    for _ in range(protocel_count):
        key = r.int()
        table_a = parse_pfunction(r)
        table_b = parse_pfunction(r)
        protocels.append(dict(key=key, table_a=table_a, table_b=table_b))
    tag_end = r.string()
    return dict(size=len(d), pos=r.p, tag1=tag1, tag2=tag2, tag3=tag3,
                tag_end=tag_end, netstruct=netstruct, protocels=protocels)
import argparse
import csv
import os
import sys




def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('table', help='protocol.protocols.bin 路径')
    ap.add_argument('-o', '--outdir', default='out')
    args = ap.parse_args()

    r = parse(args.table)
    print('文件大小 %d, 解析结束位置 %d (差值 %d)' % (r['size'], r['pos'], r['size'] - r['pos']))
    print('tag1=%r tag2=%r tag3=%r tag_end=%r' % (r['tag1'], r['tag2'], r['tag3'], r['tag_end']))
    print('netstruct 结构数: %d' % len(r['netstruct']))
    print('protocel 数: %d' % len(r['protocels']))
    ok = (r['tag1'].strip() == 'protos begin' and r['tag2'].strip() == 'netstruct'
          and r['tag3'].strip() == 'proto' and r['tag_end'].strip() == 'protos end'
          and r['pos'] == r['size'])
    print('校验: %s' % ('PASS' if ok else 'FAIL'))
    if not ok:
        sys.exit(1)

    os.makedirs(args.outdir, exist_ok=True)

    with open(os.path.join(args.outdir, 'structs.csv'), 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['struct_id', 'struct', 'index', 'field', 'type', 'subtype', 'count', 'typename_id', 'condition'])
        for sid, pf in sorted(r['netstruct'].items()):
            for k, p in enumerate(pf['params']):
                w.writerow([sid, pf['name'], k, p['name'], '0x%02x' % p['type'], p['subtype'], p['count'], p['typename_id'], p['condition']])

    with open(os.path.join(args.outdir, 'structs.txt'), 'w', encoding='utf-8-sig') as fp:
        for sid, pf in sorted(r['netstruct'].items()):
            fp.write('%s [id=%d] (%d fields)\n' % (pf['name'], sid, len(pf['params'])))
            for p in pf['params']:
                extra = ''
                if p['type'] & 0xFF == 12 and p['typename_id']:
                    extra = ' -> struct %d' % p['typename_id']
                if p['condition'] != 0:
                    extra += '  cond=%s skip=%r' % (p['condition'], p['skip'])
                fp.write('    %-28s type=0x%02x/%d cnt=%d tid=%d%s\n' % (p['name'], p['type'], p['subtype'], p['count'], p['typename_id'], extra))
            fp.write('\n')

    with open(os.path.join(args.outdir, 'protocels.csv'), 'w', newline='', encoding='utf-8-sig') as fp:
        w = csv.writer(fp)
        w.writerow(['protocel_key', 'table', 'func_id', 'struct', 'nparams'])
        for pc in r['protocels']:
            for tname, tb in (('A', pc['table_a']), ('B', pc['table_b'])):
                for fid, pf in sorted(tb.items()):
                    w.writerow([pc['key'], tname, fid, pf['name'], len(pf['params'])])

    with open(os.path.join(args.outdir, 'protocels.txt'), 'w', encoding='utf-8-sig') as fp:
        for pc in r['protocels']:
            fp.write('==== protocel key=%d ====\n' % pc['key'])
            for tname, tb in (('A', pc['table_a']), ('B', pc['table_b'])):
                fp.write('  [table %s] %d entries\n' % (tname, len(tb)))
                for fid, pf in sorted(tb.items()):
                    fp.write('    %d_%d  %s (%d params)\n' % (pc['key'], fid, pf['name'], len(pf['params'])))
            fp.write('\n')

    print('已写出 structs.csv/structs.txt/protocels.csv/protocels.txt')


if __name__ == '__main__':
    sys.exit(main())
