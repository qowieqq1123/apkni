#!/usr/bin/env python3
"""分析 config.ab 结构"""
import re
import struct

data = open(r'C:\Desktop\apkni\ZQZS\ZQZS\assets\Android\config.ab', 'rb').read()

print(f"文件大小: {len(data)} 字节")

# Unity AssetBundle 签名
print(f"\n前 64 字节 (hex): {data[:64].hex()}")
print(f"前 64 字节 (raw): {data[:64]}")

# 搜索常见模式
for pattern in [b'infoURL', b'InfoURL', b'info', b'http', b'HTTP',
                b'cdn', b'login', b'server', b'www.', b'.com', b'.cn',
                b'10.10', b'127.0', b'175.178', b'zqzss']:
    idx = data.find(pattern)
    if idx >= 0:
        print(f"\n找到 '{pattern.decode()}' at offset {idx} (0x{idx:08X}):")
        print(f"  上下文: {data[max(0,idx-8):idx+64]}")

# 搜索所有可打印字符串
print("\n\n=== 可打印字符串 (长度>=8) ===")
strings = re.findall(b'[\x20-\x7e]{8,}', data)
for s in strings:
    decoded = s.decode('ascii', errors='replace')
    if any(kw in decoded.lower() for kw in ['url', 'http', 'cdn', 'login', 'server', 'host', 'port', 'api']):
        print(f"  {decoded}")