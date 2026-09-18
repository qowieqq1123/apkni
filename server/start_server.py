#!/usr/bin/env python3
"""
本地私服启动入口

同时启动:
  - HTTP API 服务器 (端口 8080) — 模拟 PHP 配置服
  - TCP 游戏服务器 (端口 9003) — 游戏逻辑

一键启动:
  python server/start_server.py
"""

import asyncio
import logging
import sys
import os
import threading

# 确保可以 import server 包
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from http_server import run_http_server, config as http_config
from tcp_server import GameServer
from database import init_db

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(name)s] %(levelname)s: %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
    ]
)
logger = logging.getLogger('ServerLauncher')


def main():
    # 初始化数据库
    init_db()

    # HTTP 服务器配置
    http_port = int(os.environ.get('HTTP_PORT', '8080'))
    tcp_port = int(os.environ.get('TCP_PORT', '9003'))
    http_config.TCP_PORT = tcp_port

    logger.info("=" * 50)
    logger.info("  修仙游戏本地私服启动")
    logger.info(f"  HTTP API  : 0.0.0.0:{http_port}")
    logger.info(f"  TCP Game  : 0.0.0.0:{tcp_port}")
    logger.info(f"  客户端配置: infoURL=http://127.0.0.1:{http_port}/cysh/api/getpfinfo")
    logger.info("=" * 50)

    # ── 在单独线程中启动 HTTP 服务器 ──
    http_thread = threading.Thread(
        target=run_http_server,
        args=(http_port,),
        daemon=True,
    )
    http_thread.start()

    # ── 在主线程中启动 TCP 服务器 ──
    tcp_server = GameServer(port=tcp_port)

    try:
        asyncio.run(tcp_server.start())
    except KeyboardInterrupt:
        logger.info("收到停止信号，关闭服务器...")
        tcp_server.stop()
        logger.info("服务器已关闭")


if __name__ == '__main__':
    main()