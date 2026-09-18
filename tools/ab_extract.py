# -*- coding: utf-8 -*-
"""UnityFS (.ab) 解包器 —— 解出 AssetBundle 内部的 TextAsset（Lua / JSON / 二进制配置）

背景：本项目的游戏逻辑是 Lua，被塞进 4 个 AssetBundle（base/config/data/binary.ab）。
UnityFS 结构：块信息用 LZ4 压缩，数据块用 LZMA（块 flags & 0x3F == 1）。

用法:
  python tools/ab_extract.py <bundle.ab> [更多 bundle ...] -o out
  python tools/ab_extract.py <bundle.ab> --list      # 只列资产名
"""
import argparse
import csv
import lzma
import os
import re
import sys

NAME_RE = re.compile(rb'^[A-Za-z0-9_./-]{1,120}$')


def u32be(buf):
    return int.from_bytes(buf, 'big')


def lz4_decompress(src):
    """纯 Python LZ4 block 解压（只用于几 KB 的块信息）"""
    dst = bytearray()
    i = 0
    n = len(src)
    while i < n:
        token = src[i]
        i += 1
        lit = token // 16
        if lit == 15:
            while True:
                b = src[i]
                i += 1
                lit += b
                if b < 255:
                    break
        dst += src[i:i + lit]
        i += lit
        if i >= n:
            break
        off = src[i] | (src[i + 1] * 256)
        i += 2
        ml = token % 16
        if ml == 15:
            while True:
                b = src[i]
                i += 1
                ml += b
                if b < 255:
                    break
        ml += 4
        start = len(dst) - off
        if start < 0:
            raise ValueError('lz4: 非法 offset')
        for j in range(ml):
            dst.append(dst[start + j])
    return bytes(dst)


def lzma_decompress(blob):
    """Unity 的 LZMA 块 = 5 字节 props + 裸流，补 8 字节 0xFF 当 FORMAT_ALONE 头"""
    return lzma.LZMADecompressor(format=lzma.FORMAT_ALONE).decompress(
        blob[:5] + b'\xff' * 8 + blob[5:])


def read_unityfs(path):
    """解析 UnityFS，返回 (解压后的完整 payload, bundle 内文件名列表)"""
    with open(path, 'rb') as fp:
        data = fp.read()
    if data[:8] != b'UnityFS\x00':
        raise ValueError('%s 不是 UnityFS bundle' % path)
    pos = 12
    for _ in range(2):                       # unityVersion / unityRevision
        while data[pos] != 0:
            pos += 1
        pos += 1
    pos += 8                                 # size
    blocks_info_size = u32be(data[pos:pos + 4])
    flags = u32be(data[pos + 8:pos + 12])
    pos += 12
    if pos % 16:
        pos += 16 - pos % 16
    blocks_info = lz4_decompress(data[pos:pos + blocks_info_size])
    pos += blocks_info_size
    if flags & 0x200:
        pos += (16 - pos % 16) % 16

    block_count = u32be(blocks_info[16:20])
    o = 20
    blocks = []
    for _ in range(block_count):
        blocks.append((u32be(blocks_info[o:o + 4]),
                       u32be(blocks_info[o + 4:o + 8]),
                       u32be(blocks_info[o + 8:o + 10])))
        o += 10
    node_count = u32be(blocks_info[o:o + 4])
    o += 4
    nodes = []
    for _ in range(node_count):
        o += 20
        end = blocks_info.index(b'\x00', o)
        nodes.append(blocks_info[o:end].decode('utf-8', 'replace'))
        o = end + 1

    raw = bytearray()
    for _uncompressed, compressed, bflags in blocks:
        comp = bflags & 0x3F
        blob = data[pos:pos + compressed]
        if comp == 0:
            raw += blob
        elif comp == 1:
            raw += lzma_decompress(blob)
        elif comp in (2, 3):
            raw += lz4_decompress(blob)
        else:
            raise ValueError('未知块压缩类型 %d' % comp)
        pos += compressed
    return bytes(raw), nodes


def _printable_ratio(data):
    if not data:
        return 0.0
    ok = sum(1 for b in data if 9 <= b <= 13 or 32 <= b <= 126 or b >= 128)
    return ok / float(len(data))


def classify(name, data):
    """判断资产类型：lua / json / txt / bin"""
    head = data[:64].lstrip(b'\r\n\t ')
    if head[:1] in (b'{', b'['):
        return 'json'
    if (b'function' in data or b'local ' in data or b'require' in data
            or b'end\n' in data) and _printable_ratio(data[:4096]) > 0.9:
        return 'lua'
    if name.endswith('.json'):
        return 'json'
    if _printable_ratio(data[:4096]) > 0.95:
        return 'txt'
    return 'bin'


def _is_text(data):
    return _printable_ratio(data[:8192]) > 0.9


STRICT_RE = re.compile(rb'^[A-Za-z0-9_][A-Za-z0-9_./-]{2,119}$')


def find_starts(raw):
    """找出所有 TextAsset 记录起点：s = u32 LE 名字长度，raw[s+1:s+4] == 00 00 00，随后是名字"""
    starts = []
    n = len(raw)
    k = raw.find(b'\x00\x00\x00', 1)
    while k != -1:
        v = raw[k - 1]
        if 1 <= v <= 120 and k + 3 + v <= n:
            name = raw[k + 3:k + 3 + v]
            if STRICT_RE.match(name) and b'\x00' not in name:
                starts.append([k - 1, name.decode('latin1'), k + 3 + v])
        k = raw.find(b'\x00\x00\x00', k + 1)
    return starts


def _region_ok(raw, doff, end):
    """名字之后到 end 之间应包含 [对齐填充][u32 数据长度][数据]

    真记录的结束位置必然紧贴下一条记录的起点（0..7 字节对齐填充），
    据此可在 4 种对齐偏移里挑出正确的那一个；文本类资产再做可打印校验。
    """
    if end <= doff:
        return None
    cands = []
    for pad in range(4):
        p = doff + pad
        if p + 4 > end:
            break
        dlen = int.from_bytes(raw[p:p + 4], 'little')
        dend = p + 4 + dlen
        if dlen < 8 or dend > end:
            continue
        cands.append((end - dend, raw[p + 4:dend]))
    cands.sort(key=lambda x: x[0])
    for gap, data in cands:
        if gap <= 8 or _printable_ratio(data[:8192]) > 0.9:
            return data
    return None


def build_records(raw):
    """用“起点 + 下一起点”作为边界，精确切出每条记录的数据（单趟，不做级联剔除）"""
    starts = find_starts(raw)
    if not starts:
        return []
    n = len(raw)
    recs = []
    for i, (s, name, doff) in enumerate(starts):
        nxt = starts[i + 1][0] if i + 1 < len(starts) else n
        data = _region_ok(raw, doff, nxt)
        if data is not None:
            recs.append((s, name, data))
    return recs
    """找出所有候选记录：s = u32 LE 名字长度, raw[s+1:s+4] == 00 00 00, 名字紧随其后

    为避免拷贝大块数据，这里只抽样校验首尾片段；完整数据在链式筛选后才切片。
    """
    cands = []
    k = raw.find(b'\x00\x00\x00', 1)
    n = len(raw)
    while k != -1:
        v = raw[k - 1]
        if 1 <= v <= 120 and k + 3 + v <= n:
            name = raw[k + 3:k + 3 + v]
            if NAME_RE.match(name) and b'\x00' not in name:
                for pad in range(4):               # 字符串按 4 字节对齐
                    off = k + 3 + v + pad
                    if off + 4 > n:
                        break
                    dlen = int.from_bytes(raw[off:off + 4], 'little')
                    end = off + 4 + dlen
                    if dlen < 8 or end > n:
                        continue
                    head = raw[off + 4:off + 4 + min(dlen, 4096)]
                    tail = raw[max(off + 4, end - 64):end]
                    if _printable_ratio(head) > 0.9 and _printable_ratio(tail) > 0.9:
                        cands.append((k - 1, name.decode('latin1'), off + 4, end))
                        break
        k = raw.find(b'\x00\x00\x00', k + 1)
    return cands


def iter_textassets(raw):
    """返回 [(名字, 数据, 类型, 原始偏移)]"""
    recs = []
    for start, name, data in build_records(raw):
        data = data.rstrip(b'\x00')
        if len(data) < 8:
            continue
        recs.append((name, data, classify(name, data), start))
    return recs


def safe_rel(name, kind):
    rel = name.replace('\\', '/').lstrip('/')
    rel = re.sub(r'[^A-Za-z0-9_./-]', '_', rel)
    if not rel.endswith('.' + kind):
        rel += '.' + kind
    return rel


def extract(bundle, outdir, list_only=False):
    raw, nodes = read_unityfs(bundle)
    assets = iter_textassets(raw)
    tag = os.path.splitext(os.path.basename(bundle))[0]
    print('%-14s 解压 %10d 字节 | bundle 内文件 %d | TextAsset %d'
          % (os.path.basename(bundle), len(raw), len(nodes), len(assets)))
    if list_only:
        for name, data, kind, off in assets:
            print('   %-60s %8d %s' % (name, len(data), kind))
        return []
    rows = []
    base = os.path.join(outdir, tag)
    for name, data, kind, off in assets:
        rel = safe_rel(name, kind)
        dst = os.path.join(base, rel.replace('/', os.sep))
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        with open(dst, 'wb') as fp:
            fp.write(data)
        rows.append((tag, name, kind, len(data), off, os.path.relpath(dst, outdir)))
    return rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('bundles', nargs='+')
    ap.add_argument('-o', '--outdir', default='out')
    ap.add_argument('--list', action='store_true', help='只列出资产名，不写文件')
    args = ap.parse_args()

    all_rows = []
    for b in args.bundles:
        all_rows += extract(b, args.outdir, args.list)

    if all_rows:
        os.makedirs(args.outdir, exist_ok=True)
        idx = os.path.join(args.outdir, 'asset_index.csv')
        new = not os.path.exists(idx)
        with open(idx, 'a', newline='', encoding='utf-8') as fp:
            w = csv.writer(fp)
            if new:
                w.writerow(['bundle', 'asset_name', 'kind', 'size', 'raw_offset', 'file'])
            w.writerows(all_rows)
        print('索引已写入 %s（本次 %d 条）' % (idx, len(all_rows)))


if __name__ == '__main__':
    sys.exit(main())
