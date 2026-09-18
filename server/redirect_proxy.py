"""
透明重定向代理 — HTTP + TCP 双协议

在手机代理模式下工作：
  - HTTP 请求: 拦截官方域名/IP，重定向到本地 HTTP 服务器 (127.0.0.1:8080)
  - TCP 连接:  拦截官方游戏服务器 IP:端口，重定向到本地 TCP (127.0.0.1:9003)

手机设置代理 → 笔记本 IP:8888
"""

import asyncio
import logging
from typing import Dict, Tuple, Optional

logger = logging.getLogger('RedirectProxy')

# ─── 重定向映射 ──────────────────────────────────────────────
# 目标地址 → 本地地址

TARGET_MAP: Dict[str, Tuple[str, int]] = {
    # HTTP 配置服 (如果客户端直接连 IP)
    '10.10.1.49:89': ('127.0.0.1', 8080),
    # 可能还有其他域名/IP
}

# 转发 TCP 连接时也映射
TCP_TARGET_MAP: Dict[str, Tuple[str, int]] = {
    '10.10.1.49:89': ('127.0.0.1', 9003),  # 游戏 TCP
}


def _get_redirect(host: str, port: int) -> Optional[Tuple[str, int]]:
    """查找重定向目标"""
    key = f'{host}:{port}'
    if key in TARGET_MAP:
        return TARGET_MAP[key]
    if key in TCP_TARGET_MAP:
        return TCP_TARGET_MAP[key]
    return None


# ─── HTTP 代理处理器 ─────────────────────────────────────────

class HTTPRedirectHandler(asyncio.Protocol):
    """处理 HTTP CONNECT 和普通 HTTP 请求"""

    def __init__(self):
        self.buf = bytearray()
        self.transport = None
        self.remote_transport = None
        self.is_connect = False

    def connection_made(self, transport):
        self.transport = transport

    def data_received(self, data):
        self.buf.extend(data)

        if not self.is_connect:
            # 解析 HTTP 请求行
            if b'\r\n' not in self.buf:
                return
            first_line = self.buf.split(b'\r\n')[0].decode('utf-8', errors='replace')
            parts = first_line.split()

            if len(parts) >= 2 and parts[0] == 'CONNECT':
                # HTTPS CONNECT 隧道
                self._handle_connect(parts[1])
                return

            # 普通 HTTP 请求
            self._handle_http(first_line)

    def _handle_http(self, first_line: str):
        """处理普通 HTTP 请求"""
        parts = first_line.split()
        if len(parts) < 2:
            self.transport.close()
            return

        method = parts[0]
        uri = parts[1]

        # 解析主机和端口
        from urllib.parse import urlparse
        parsed = urlparse(uri)
        host = parsed.hostname or '127.0.0.1'
        port = parsed.port or 80

        # 检查是否需要重定向
        redirect = _get_redirect(host, port)
        if redirect:
            target_host, target_port = redirect
            logger.info(f"[HTTP] {host}:{port} → {target_host}:{target_port}  (原始: {first_line})")
            # 修改请求行
            old_uri = uri.encode()
            new_uri = f'http://{target_host}:{target_port}{parsed.path or "/"}'
            if parsed.query:
                new_uri += f'?{parsed.query}'
            new_uri = new_uri.encode()
            self.buf = bytearray(self.buf.replace(old_uri, new_uri))
            host, port = target_host, target_port

        # 转发到目标
        self._forward_to(host, port)

    def _handle_connect(self, target: str):
        """处理 CONNECT 隧道 (HTTPS)"""
        self.is_connect = True
        host_port = target.split(':')
        host = host_port[0]
        port = int(host_port[1]) if len(host_port) > 1 else 443

        redirect = _get_redirect(host, port)
        if redirect:
            target_host, target_port = redirect
            logger.info(f"[CONNECT] {host}:{port} → {target_host}:{target_port}")
            host, port = target_host, target_port

        self._forward_to(host, port, is_connect=True)

    def _forward_to(self, host: str, port: int, is_connect: bool = False):
        """转发数据到目标服务器"""
        loop = asyncio.get_event_loop()

        class RemoteProtocol(asyncio.Protocol):
            def __init__(self, handler):
                self.handler = handler

            def connection_made(self, transport):
                self.handler.remote_transport = transport
                if is_connect:
                    # 回复 200 Connection Established
                    self.handler.transport.write(b'HTTP/1.1 200 Connection Established\r\n\r\n')
                # 转发已缓冲的数据
                if self.handler.buf:
                    transport.write(bytes(self.handler.buf))
                    self.handler.buf.clear()

            def data_received(self, data):
                if self.handler.transport:
                    self.handler.transport.write(data)

            def connection_lost(self, exc):
                if self.handler.transport:
                    self.handler.transport.close()

        coro = loop.create_connection(lambda: RemoteProtocol(self), host, port)
        asyncio.ensure_future(coro)

    def connection_lost(self, exc):
        if self.remote_transport:
            self.remote_transport.close()


# ─── TCP 端口转发 ────────────────────────────────────────────

class TCPRedirectProxy:
    """TCP 级别端口转发，将官方服务器端口映射到本地"""

    def __init__(self, listen_port: int, target_host: str, target_port: int):
        self.listen_port = listen_port
        self.target_host = target_host
        self.target_port = target_port

    async def handle_client(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        addr = writer.get_extra_info('peername')
        logger.info(f"[TCP转发] {addr} → {self.target_host}:{self.target_port}")

        try:
            remote_reader, remote_writer = await asyncio.open_connection(
                self.target_host, self.target_port
            )

            async def forward(src, dst, name):
                try:
                    while True:
                        data = await src.read(4096)
                        if not data:
                            break
                        dst.write(data)
                        await dst.drain()
                except:
                    pass
                finally:
                    try:
                        dst.close()
                    except:
                        pass

            await asyncio.gather(
                forward(reader, remote_writer, 'C→S'),
                forward(remote_reader, writer, 'S→C'),
            )
        except Exception as e:
            logger.error(f"[TCP转发] 异常: {e}")
        finally:
            try:
                writer.close()
            except:
                pass

    async def start(self):
        server = await asyncio.start_server(
            self.handle_client,
            '0.0.0.0',
            self.listen_port
        )
        addr = server.sockets[0].getsockname()
        logger.info(f"TCP 端口转发: 0.0.0.0:{self.listen_port} → {self.target_host}:{self.target_port}")
        async with server:
            await server.serve_forever()


# ─── 主启动 ──────────────────────────────────────────────────

async def main():
    # 启动 HTTP 代理 (端口 8888)
    http_proxy = await asyncio.start_server(
        lambda r, w: HTTPRedirectHandler(),  # 简化处理
        '0.0.0.0',
        8888
    )
    logger.info("HTTP 代理服务器启动: 0.0.0.0:8888")
    logger.info("手机代理设置 → 笔记本IP:8888")

    # 启动 TCP 端口转发 (如果官方端口和 HTTP 端口不同)
    # 例如: 官方 TCP 端口是 89，映射到本地 9003
    tcp_tasks = []
    for key, (target_host, target_port) in TCP_TARGET_MAP.items():
        official_port = int(key.split(':')[1])
        if official_port != 8888:  # 避免冲突
            proxy = TCPRedirectProxy(official_port, target_host, target_port)
            tcp_tasks.append(asyncio.create_task(proxy.start()))

    # 保持运行
    await asyncio.gather(
        http_proxy.serve_forever(),
        *tcp_tasks,
    )


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(name)s] %(levelname)s: %(message)s')
    asyncio.run(main())