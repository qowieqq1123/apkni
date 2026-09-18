# -*- coding: utf-8 -*-
"""反汇编 il2cpp 函数并解析 bl 调用目标 → 方法名（用于还原协议表读取逻辑）"""
import json
import sys

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN

SO = r'C:\Desktop\apkni\ZQZS\ZQZS\lib\arm64-v8a\libil2cpp.so'
SCRIPT = r'C:\Desktop\apkni\out\il2cpp\script.json'


def load_map():
    data = json.load(open(SCRIPT, encoding='utf-8'))
    # ScriptMethod: [{Address, Name}], ScriptString 等
    lst = data.get('ScriptMethod', [])
    pairs = sorted((m['Address'], m['Name']) for m in lst)
    addrs = [a for a, _ in pairs]
    return pairs, addrs


def find_func(addrs, rva):
    import bisect
    i = bisect.bisect_right(addrs, rva) - 1
    return i if i >= 0 else None


def disasm_func(so, pairs, addrs, rva, max_instr=400):
    idx = find_func(addrs, rva)
    if idx is None:
        print('未找到函数 @0x%x' % rva)
        return
    start, name = pairs[idx]
    end = pairs[idx + 1][0] if idx + 1 < len(pairs) else start + 0x2000
    code = so[start:end]
    md = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
    print('=== %s @0x%x (len 0x%x) ===' % (name, start, end - start))
    n = 0
    for ins in md.disasm(code, start):
        line = '0x%x:\t%s\t%s' % (ins.address, ins.mnemonic, ins.op_str)
        # 解析 bl 目标
        if ins.mnemonic in ('bl', 'b') and ins.op_str.startswith('#'):
            try:
                tgt = int(ins.op_str[1:], 16)
            except ValueError:
                tgt = None
            if tgt is not None:
                j = find_func(addrs, tgt)
                if j is not None and abs(pairs[j][0] - tgt) < 4:
                    line += '   ; -> %s' % pairs[j][1]
        print(line)
        n += 1
        if n >= max_instr:
            print('...(截断)')
            break


def main():
    so = open(SO, 'rb').read()
    pairs, addrs = load_map()
    targets = [int(x, 16) for x in sys.argv[1:]] or [0x105C898, 0x105F8F4, 0x105F440]
    for t in targets:
        disasm_func(so, pairs, addrs, t)
        print()


if __name__ == '__main__':
    main()