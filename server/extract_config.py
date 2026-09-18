#!/usr/bin/env python3
"""
提取并修改 Unity AssetBundle (config.ab)

功能:
  1. 列出 config.ab 中的所有资源
  2. 提取配置文本
  3. 修补 infoURL 指向本地服务器
  4. 重新打包
"""

import os
import sys
from UnityPy import Environment
from UnityPy.enums import ClassIDType

CONFIG_AB = os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), 'ZQZS', 'ZQZS', 'assets', 'Android', 'config.ab')
OUTPUT_DIR = os.path.join(os.path.dirname(
    os.path.abspath(__file__)), 'config_patch')

LOCAL_INFO_URL = 'http://127.0.0.1:8080/cysh/api/getpfinfo'


def list_assets():
    """列出 config.ab 中的所有资源"""
    env = Environment(CONFIG_AB)
    print(f"=== config.ab 资源清单 ===")
    for path, obj in env.container.items():
        print(f"  {path} -> type={obj.type.name}")

        if obj.type == ClassIDType.TextAsset:
            data = obj.read()
            # 使用 .m_Script 或直接 bytes
            script = data.m_Script if hasattr(data, 'm_Script') else str(data)
            print(f"    大小: {len(script)} 字节")
            # 处理 bytes 或 str
            if isinstance(script, bytes):
                preview = script[:200].decode('utf-8', errors='replace')
            elif isinstance(script, str):
                preview = script[:200]
            elif script is None:
                preview = "(None)"
            elif isinstance(script, bytearray):
                preview = bytes(script)[:200].decode('utf-8', errors='replace')
            else:
                preview = str(script)[:200]
            print(f"    预览: {preview}")
            print()


def extract_text():
    """提取所有 TextAsset 内容"""
    env = Environment(CONFIG_AB)
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    for path, obj in env.container.items():
        if obj.type == ClassIDType.TextAsset:
            data = obj.read()
            safe_name = path.replace('/', '_').replace('\\', '_').replace(':', '_')

            text = ''
            if hasattr(data, 'm_Script') and data.m_Script is not None:
                raw = data.m_Script
                if isinstance(raw, bytes):
                    text = raw.decode('utf-8', errors='replace')
                elif isinstance(raw, str):
                    text = raw

            out_path = os.path.join(OUTPUT_DIR, f'{safe_name}.txt')
            with open(out_path, 'w', encoding='utf-8') as f:
                f.write(text)
            print(f"[EXTRACT] {path} -> {out_path} ({len(text)} chars)")


def patch_info_url():
    """
    修补 config.ab:
    1. 在 TextAsset 中搜索 infoURL
    2. 替换为 LOCAL_INFO_URL
    3. 保存为新的 .ab 文件
    """
    env = Environment(CONFIG_AB)
    patched = False

    for path, obj in env.container.items():
        if obj.type == ClassIDType.TextAsset:
            data = obj.read()

            if not hasattr(data, 'm_Script') or data.m_Script is None:
                continue

            raw = data.m_Script
            if isinstance(raw, bytes):
                text = raw.decode('utf-8', errors='replace')
            elif isinstance(raw, str):
                text = raw
            else:
                continue

            # 搜索 infoURL
            lines = text.split('\n')
            modified_lines = []
            changed = False

            for i, line in enumerate(lines):
                if 'infoURL' in line and '=' in line and 'http' in line:
                    parts = line.split('=', 1)
                    if len(parts) == 2:
                        key = parts[0].strip()
                        old_url = parts[1].strip().strip('"').strip("'")
                        print(f"[PATCH] {path}:{i+1}  {key} = {old_url}")
                        print(f"         → {key} = {LOCAL_INFO_URL}")
                        new_line = f'{key} = "{LOCAL_INFO_URL}"'
                        modified_lines.append(new_line)
                        changed = True
                        patched = True
                        continue
                modified_lines.append(line)

            if changed:
                new_text = '\n'.join(modified_lines)
                if isinstance(raw, bytes):
                    data.m_Script = new_text.encode('utf-8')
                else:
                    data.m_Script = new_text
                data.save()

    if patched:
        out_path = CONFIG_AB.replace('.ab', '_patched.ab')
        with open(out_path, 'wb') as f:
            f.write(env.file.save())
        print(f"\n[SUCCESS] 已保存修补后的文件: {out_path}")
        print(f"[INFO] 使用修补文件: copy /Y {out_path} {CONFIG_AB}")
        return True
    else:
        print("[WARN] 未找到 infoURL 配置项")
        return False


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='config.ab 提取/修补工具')
    parser.add_argument('--list', action='store_true', help='列出资源')
    parser.add_argument('--extract', action='store_true', help='提取文本')
    parser.add_argument('--patch', action='store_true', help='修补 infoURL')
    args = parser.parse_args()

    if args.list:
        list_assets()
    elif args.extract:
        extract_text()
    elif args.patch:
        patch_info_url()
    else:
        list_assets()
        print("\n" + "=" * 60)
        extract_text()