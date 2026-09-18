# -*- coding: utf-8 -*-
import sys, traceback
sys.path.insert(0, 'tools')
import protocol_parser as P

d = open('out/config/protocol.protocols.bin', 'rb').read()
log = open('out/dbg.log', 'w', encoding='utf-8')
log.write('filesize %d\n' % len(d))
try:
    r = P.parse('out/config/protocol.protocols.bin')
    ids = {s[1] for s in r['structs']}
    refs = set()
    for _, _, fs in r['structs']:
        for fn, ft, ex, t8 in fs:
            if t8 != b'\x00' * 8:
                refs.add(int.from_bytes(t8[:4], 'little'))
    log.write('structs=%d fieldTotal=%d actual=%d\n' % (
        len(r['structs']), r['field_total'],
        sum(len(f) for _, _, f in r['structs'])))
    log.write('end=%d filesize=%d tail=%r\n' % (r['pos'], len(d), r['tail'][:24]))
    log.write('refs_not_in_ids=%s\n' % sorted(refs - ids)[:12])
    log.write('s0=%r\n' % (r['structs'][0][0],))
    log.write('last=%r\n' % (r['structs'][-1][0],))
except Exception:
    log.write('ERR: %s\n' % traceback.format_exc().splitlines()[-1])
    log.close()
    # 重跑一次只到出错点，dump 现场字节
    import re
    m = re.search(r'@(\d+): (.*)', traceback.format_exc())
    if m:
        pos = int(m.group(1))
        d2 = open('out/config/protocol.protocols.bin', 'rb').read()
        hexs = ' '.join('%02x' % b for b in d2[pos - 96:pos + 48])
        txt = ''.join(chr(b) if 32 <= b < 127 else '.' for b in d2[pos - 96:pos + 48])
        h2 = open('out/dbg_ctx.txt', 'w', encoding='utf-8')
        h2.write(hexs + '\n' + txt + '\n')
        h2.close()
    print('done-err')
    sys.exit(0)
log.close()
print('done')

import sys
sys.path.insert(0, 'tools')
import protocol_parser as P
print('module file:', P.__file__)

d = open('out/config/protocol.protocols.bin', 'rb').read()
print('filesize', len(d))
i = d.find(b'protos begin')
j = d.find(b'netstruct', i)
p0 = d.index(b'\x00', j) + 1
print('i', i, 'j', j, 'p0', p0)
print('u32@p0+4', P.u32(d, p0 + 4), 'u32@p0+8', P.u32(d, p0 + 8))
print('u32@p0+0', P.u32(d, p0), 'u32@p0+12', P.u32(d, p0 + 12))
r = P.parse('out/config/protocol.protocols.bin')
print('parse -> struct_count', r['struct_count'], 'len', len(r['structs']),
      'end', r['pos'])
if r['structs']:
    s = r['structs'][0]
    print('s0', s[0], 'sid', s[1], 'nf', len(s[2]))
    print('s0 fields:', s[2][:3])
