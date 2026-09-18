#!/usr/bin/env python3
"""在 config.ab 中搜索 infoURL/URL 相关配置"""
import os
from UnityPy import Environment
from UnityPy.enums import ClassIDType

CONFIG_AB = r'C:\Desktop\apkni\ZQZS\ZQZS\assets\Android\config.ab'
OUTPUT_DIR = r'C:\Desktop\apkni\server\config_patch'
os.makedirs(OUTPUT_DIR, exist_ok=True)

env = Environment(CONFIG_AB)
count = 0

for path, obj in env.container.items():
    count += 1
    data = obj.read()
    raw = None

    # 尝试获取文本
    if hasattr(data, 'm_Script') and data.m_Script is not None:
        raw = data.m_Script
    elif hasattr(data, 'text') and data.text is not None:
        raw = data.text

    if raw is None:
        continue

    if isinstance(raw, bytes):
        text = raw.decode('utf-8', errors='replace')
    elif isinstance(raw, (str, bytearray)):
        if isinstance(raw, bytearray):
            text = bytes(raw).decode('utf-8', errors='replace')
        else:
            text = raw
    else:
        continue

    # 保存所有文本用于检查
    safe_name = path.replace('/', '_').replace('\\', '_').replace(':', '_')
    out_path = os.path.join(OUTPUT_DIR, f'{safe_name}.txt')

    # 只检查包含关键字的
    keywords_lower = text.lower()
    if any(kw in keywords_lower for kw in ['infourl', 'http://', 'https://', 'cdn', 'loginurl', 'serverlist', 'getpfinfo', 'appconfig']):
        print(f"\n=== {path} (len={len(text)}) ===")
        print(text[:2000])
        with open(out_path, 'w', encoding='utf-8') as f:
            f.write(text)

print(f"\n\n共扫描 {count} 个资源")

# 如果没有找到，在全文件中搜索 infoURL
print("\n\n=== 直接搜索 infoURL 字节 ===")
with open(CONFIG_AB, 'rb') as f:
    raw_data = f.read()

import re
for m in re.finditer(b'.{0,50}infoURL.{0,100}', raw_data, re.IGNORECASE):
    print(f"  offset {m.start():08X}: {m.group()[:120]}")