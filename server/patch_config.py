#!/usr/bin/env python3
"""
config.ab 修补工具

将 Unity AssetBundle 中的 infoURL 替换为本地服务器地址。
"""

import os
import re
import shutil
import sys

# 配置文件路径
CONFIG_AB_PATH = os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), 'ZQZS', 'ZQZS', 'assets', 'Android', 'config.ab')

BACKUP_SUFFIX = '.bak'
LOCAL_INFO_URL = b'http://127.0.0.1:8080/cysh/api/getpfinfo'


def patch_config_ab(ab_path: str = CONFIG_AB_PATH) -> bool:
    """
    修补 config.ab:
    1. 备份原文件
    2. 搜索所有 URL 字符串并替换为本地地址
    """
    if not os.path.exists(ab_path):
        print(f"[ERROR] 文件不存在: {ab_path}")
        return False

    # 读取
    with open(ab_path, 'rb') as f:
        data = bytearray(f.read())

    print(f"[INFO] 文件大小: {len(data)} 字节")

    # 搜索所有 HTTP URL
    url_pattern = re.compile(b'http[s]?://[^\x00\"\'<> \t\r\n]+')
    urls = []
    for m in url_pattern.finditer(data):
        url = m.group()
        urls.append((m.start(), url))

    if not urls:
        print("[WARN] 未在 config.ab 中找到任何 URL")
        return False

    print(f"[INFO] 共发现 {len(urls)} 个 URL:")

    # 备份
    backup_path = ab_path + BACKUP_SUFFIX
    if not os.path.exists(backup_path):
        shutil.copy2(ab_path, backup_path)
        print(f"[INFO] 已备份: {backup_path}")

    # 替换
    patched_count = 0
    for offset, old_url in urls:
        old_str = old_url.decode('utf-8', errors='replace')
        print(f"  [{offset:08X}] {old_str}")

        # 替换为本地地址 (保持长度一致或更短)
        new_url = LOCAL_INFO_URL

        if len(new_url) <= len(old_url):
            # 用新 URL 覆盖，剩余填充 \0
            data[offset:offset + len(new_url)] = new_url
            if len(new_url) < len(old_url):
                data[offset + len(new_url):offset + len(old_url)] = b'\x00' * \
                    (len(old_url) - len(new_url))
            patched_count += 1
            print(f"    → 已替换: {new_url.decode()}")
        else:
            print(f"    ⚠ 跳过: 新 URL 更长 ({len(new_url)} > {len(old_url)})")

    if patched_count > 0:
        # 写入
        with open(ab_path, 'wb') as f:
            f.write(data)
        print(f"\n[SUCCESS] 已修补 {patched_count}/{len(urls)} 个 URL")
        print(f"[INFO] 如需恢复，请删除 {ab_path} 并重命名 {backup_path} 为 config.ab")
        return True
    else:
        print("[WARN] 没有 URL 被替换")
        return False


def restore_config_ab(ab_path: str = CONFIG_AB_PATH):
    """从备份恢复"""
    backup_path = ab_path + BACKUP_SUFFIX
    if os.path.exists(backup_path):
        shutil.copy2(backup_path, ab_path)
        os.remove(backup_path)
        print(f"[INFO] 已从备份恢复: {backup_path} -> {ab_path}")
    else:
        print(f"[ERROR] 备份文件不存在: {backup_path}")


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='config.ab 修补工具')
    parser.add_argument('--restore', action='store_true', help='恢复备份')
    parser.add_argument('--path', default=CONFIG_AB_PATH, help='config.ab 路径')
    args = parser.parse_args()

    if args.restore:
        restore_config_ab(args.path)
    else:
        patch_config_ab(args.path)