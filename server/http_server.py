"""
HTTP API 服务器 (模拟 PHP 配置服)

处理客户端 HTTP 请求:
  - /cysh/api/getpfinfo  — PHP 配置入口
  - 服务器列表查询
  - PHP 登录
  - 大区列表
  - CDN 配置
  - /api/recharge  — 充值模拟 (POST)
  - /api/cdk/create — CDK 创建 (POST)
  - /api/cdk/list   — CDK 列表查询
"""

import json
import re
import logging
import time
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
from typing import Dict, Any

from database import (
    get_account_by_username, get_roles_by_account, get_role_by_id,
    add_player_attr, add_recharge_log, get_total_recharge,
    create_cdk, list_cdks,
)

logger = logging.getLogger('HTTPServer')


# ─── 配置 ──────────────────────────────────────────────────────

class ServerConfig:
    """本地私服配置"""

    # TCP 游戏服务器地址
    TCP_HOST = '127.0.0.1'
    TCP_PORT = 9003

    # HTTP 服务自身地址
    HTTP_PORT = 8080

    # SDK 登录参数 (本地私服固定值)
    SDK_PARAMS = {
        'userId': '1000001',
        'event': 'login',
        'expired': '9999999999',
        'accessToken': 'local_private_server_token',
        'sign': '0123456789abcdef',
        'timestamp': str(int(time.time())),
    }

    # 测试服务器列表
    SERVERS = [
        {
            'name': '本地私服',
            'server_id': 290001,
            'ip': '127.0.0.1',
            'port': 9003,
            'server_status': 1,
            'online': 1,
            'mergeid': 0,
        },
    ]

    # PHP 参数 (随服务器列表下发，用于构造 login URL)
    PHP_PARAMS = 'time={time}&sign=localdev&pfid=100&chid=1'.format(time=int(time.time()))


config = ServerConfig()


# ─── HTTP 请求处理器 ──────────────────────────────────────────

class APIHandler(BaseHTTPRequestHandler):

    def log_message(self, format, *args):
        logger.info(f"[{self.client_address[0]}] {format % args}")

    def _read_body(self) -> Dict:
        content_len = int(self.headers.get('Content-Length', 0))
        if content_len == 0:
            return {}
        raw = self.rfile.read(content_len)
        ct = self.headers.get('Content-Type', '')
        if 'json' in ct:
            return json.loads(raw)
        # form encoded
        from urllib.parse import parse_qs
        parsed = parse_qs(raw.decode('utf-8', errors='replace'))
        return {k: v[0] if len(v) == 1 else v for k, v in parsed.items()}

    def _send_json(self, data: Dict[str, Any], status: int = 200):
        body = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(body)))
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        self.wfile.write(body)

    def _send_error(self, msg: str):
        self._send_json({'code': -1, 'msg': msg}, 400)

    def _get_query(self) -> Dict[str, list]:
        return parse_qs(urlparse(self.path).query)

    # ── 路由 ────────────────────────────────────────────────

    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path.rstrip('/')

        routes = {
            '/cysh/api/getpfinfo': self._handle_getpfinfo,
            '/api/getpfinfo': self._handle_getpfinfo,
            '/lastServerList': self._handle_last_server_list,
            '/serverZone': self._handle_server_zone,
            '/serverList': self._handle_server_list,
            '/login': self._handle_login,
            '/serverInfo': self._handle_server_info,
            '/recommendServerList': self._handle_recommend_server,
            '/roleList': self._handle_role_list,
            '/notice': self._handle_notice,
            '/noticeNum': self._handle_notice_num,
            '/api/cdk/list': self._handle_cdk_list,
        }

        handler = routes.get(path)
        if handler:
            handler()
        else:
            # 尝试匹配带参数的路径
            if 'getpfinfo' in path:
                self._handle_getpfinfo()
            elif 'lastserver' in path.lower() or 'last_server' in path.lower():
                self._handle_last_server_list()
            elif 'serverzone' in path.lower() or 'zone' in path.lower():
                self._handle_server_zone()
            elif 'login' in path.lower():
                self._handle_login()
            elif 'serverinfo' in path.lower():
                self._handle_server_info()
            elif 'serverlist' in path.lower() or 'server_list' in path.lower():
                self._handle_server_list()
            elif 'recommend' in path.lower():
                self._handle_recommend_server()
            elif 'rolelist' in path.lower() or 'role_list' in path.lower():
                self._handle_role_list()
            elif 'notice' in path.lower():
                self._handle_notice()
            else:
                logger.warning(f"未处理的路径: {path}")
                self._send_error(f'未知路径: {path}')

    def do_POST(self):
        parsed = urlparse(self.path)
        path = parsed.path.rstrip('/')

        routes = {
            '/api/recharge': self._handle_recharge,
            '/api/cdk/create': self._handle_cdk_create,
        }

        handler = routes.get(path)
        if handler:
            handler()
        else:
            self._send_error(f'未知路径: {path}')

    # ── Handler 实现 ────────────────────────────────────────

    def _handle_getpfinfo(self):
        """
        PHP 配置入口。
        返回：cdnURL, loginURL, serverListURL, lastServerListURL 等
        """
        base_url = f'http://127.0.0.1:{config.HTTP_PORT}'
        data = {
            'cdnURL': f'{base_url}/cdn/',
            'cdnVersion': 1,
            'cdnVersionURL': f'{base_url}/cdn/version.txt',
            'loginURL': f'{base_url}/login',
            'serverZoneURL': f'{base_url}/serverZone',
            'lastServerListURL': f'{base_url}/lastServerList',
            'serverListURL': f'{base_url}/serverList',
            'noticeURL': f'{base_url}/notice',
            'noticeNumURL': f'{base_url}/noticeNum',
            'roleListURL': f'{base_url}/roleList',
            'recommendServerListURL': f'{base_url}/recommendServerList',
            'serverInfoURL': f'{base_url}/serverInfo',
            'APPEntryURL': f'{base_url}/cdn/',
            'APPVersion': '1.0.0',
            'chid': 1,
            'pfid': 100,
            'pfname': 'local',
            'code': 0,
        }
        self._send_json(data)

    def _handle_last_server_list(self):
        """
        最近服务器列表。
        请求参数: ?userId=xxx&...
        返回: lastserver, params, sdkParams
        """
        qs = self._get_query()

        last_server = []
        for srv in config.SERVERS:
            last_server.append({
                'name': srv['name'],
                'server_id': srv['server_id'],
                'ip': srv['ip'],
                'port': srv['port'],
                'server_status': srv['server_status'],
            })

        data = {
            'lastserver': {
                'last_server': last_server,
                'default_server': last_server[0] if last_server else {},
            },
            'params': config.PHP_PARAMS,
            'sdkParams': config.SDK_PARAMS,
        }
        self._send_json(data)

    def _handle_server_zone(self):
        """
        大区列表。
        请求参数: ?account=xxx&chid=xxx
        """
        data = {
            'server_zone_info': [
                {
                    'name': '本地大区',
                    'zone_id': 1,
                    'start_id': 290001,
                    'end_id': 290099,
                    'server_type': 0,
                }
            ],
        }
        self._send_json(data)

    def _handle_server_list(self):
        """
        大区服务器列表。
        请求参数: ?zone_id=xxx&account=xxx
        """
        server_list = []
        for srv in config.SERVERS:
            server_list.append({
                'name': srv['name'],
                'server_id': srv['server_id'],
                'ip': srv['ip'],
                'port': srv['port'],
                'server_status': srv['server_status'],
            })

        data = {
            'serverlist': server_list,
        }
        self._send_json(data)

    def _handle_login(self):
        """
        PHP 登录验证。
        请求参数: ?serverId=xxx&time=xxx&sign=xxx&...
        返回: srvaddr, srvport, 登录信息
        """
        qs = self._get_query()
        server_id = int(qs.get('serverId', [290001])[0])

        # 找到匹配的服务器
        srv = None
        for s in config.SERVERS:
            if s['server_id'] == server_id:
                srv = s
                break
        if not srv:
            srv = config.SERVERS[0]

        data = {
            'code': 0,
            'srvaddr': config.TCP_HOST,
            'srvport': config.TCP_PORT,
            'server_status': 1,
            'isWhiteList': 0,
            'isBan': 0,
            'wss_host': '',
            'wss_port': 0,
            'isnew': 1,
            'srvtime': int(time.time()),
            'login_ip': f'{config.TCP_HOST}:{config.TCP_PORT}',
            'nickname': '测试角色',
            'roleCount': 1,
            'user': config.SDK_PARAMS['userId'],
            'pwd': '',
            'srvid': srv['server_id'],
            'srvaddr': config.TCP_HOST,
            'srvport': config.TCP_PORT,
            'serverid': srv['server_id'],
            'server_status': 1,
        }
        self._send_json(data)

    def _handle_server_info(self):
        """服务器详细信息"""
        qs = self._get_query()
        sids = qs.get('sids', [])
        data_list = []
        if sids:
            sid_list = [int(x) for x in sids[0].split(',')]
            for sid in sid_list:
                for srv in config.SERVERS:
                    if srv['server_id'] == sid:
                        data_list.append({
                            'name': srv['name'],
                            'server_id': srv['server_id'],
                            'ip': srv['ip'],
                            'port': srv['port'],
                            'server_status': srv['server_status'],
                            'online': srv['online'],
                        })
        data = {
            'code': 0,
            'data': data_list,
        }
        self._send_json(data)

    def _handle_recommend_server(self):
        """推荐服务器列表"""
        data = {
            'code': 0,
            'data': config.SERVERS,
        }
        self._send_json(data)

    def _handle_role_list(self):
        """
        角色列表。
        请求参数: ?account=xxx&sids=xxx
        """
        # 简单角色数据
        data = {
            str(config.SERVERS[0]['server_id']): [
                {
                    'user': config.SDK_PARAMS['userId'],
                    'name': '本地测试角色',
                    'level': 1,
                    'role_id': 10001,
                    'server_id': config.SERVERS[0]['server_id'],
                }
            ]
        }
        self._send_json(data)

    def _handle_notice(self):
        """公告"""
        data = {
            'code': 0,
            'title': '本地私服公告',
            'content': '欢迎来到本地私服！',
        }
        self._send_json(data)

    def _handle_notice_num(self):
        """公告未读数"""
        data = {'num': 1}
        self._send_json(data)

    # ── 充值模拟 ──────────────────────────────────────────

    def _handle_recharge(self):
        """
        充值模拟 (POST)
        Body: { "username": "...", "amount": 64800, "item_id": 1001, "item_count": 6480 }
        或:   { "role_id": 1, "amount": 64800, ... }
        """
        body = self._read_body()
        username = body.get('username', '')
        role_id = body.get('role_id', 0)
        amount = int(body.get('amount', 0))
        item_id = int(body.get('item_id', 1001))
        item_count = int(body.get('item_count', amount // 10))

        if not role_id and username:
            # 通过用户名查找角色
            account = get_account_by_username(username)
            if account:
                roles = get_roles_by_account(account['id'], 290001)
                if roles:
                    role_id = roles[0]['id']

        if not role_id:
            self._send_json({'code': -1, 'msg': '角色不存在'}, 400)
            return

        # 发放物品
        new_balance = add_player_attr(role_id, item_id, item_count)
        add_recharge_log(role_id, amount, item_id, item_count)

        total = get_total_recharge(role_id)
        self._send_json({
            'code': 0,
            'msg': '充值成功',
            'data': {
                'role_id': role_id,
                'item_id': item_id,
                'added': item_count,
                'new_balance': new_balance,
                'total_recharge': int(total),
            }
        })
        logger.info(f"HTTP 充值: role_id={role_id}, item={item_id}, count={item_count}, amount={amount}")

    # ── CDK 管理 ──────────────────────────────────────────

    def _handle_cdk_create(self):
        """
        创建 CDK 礼包码 (POST)
        Body: { "code": "MYGIFT", "items": [[1001,10],[2001,1]], "max_use": 100 }
        """
        body = self._read_body()
        code = body.get('code', '').upper()
        items = body.get('items', [])
        max_use = int(body.get('max_use', 1))
        expires_at = body.get('expires_at', None)

        if not code or not items:
            self._send_json({'code': -1, 'msg': '参数不完整'}, 400)
            return

        ok = create_cdk(code, items, max_use, expires_at)
        if ok:
            self._send_json({'code': 0, 'msg': f'CDK {code} 创建成功'})
            logger.info(f"HTTP CDK 创建: {code}, items={items}, max_use={max_use}")
        else:
            self._send_json({'code': -1, 'msg': f'CDK {code} 已存在'}, 400)

    def _handle_cdk_list(self):
        """CDK 列表查询 (GET)"""
        cdks = list_cdks()
        self._send_json({'code': 0, 'cdks': cdks})


# ─── 启动 ──────────────────────────────────────────────────────

def run_http_server(port: int = 8080):
    server = HTTPServer(('0.0.0.0', port), APIHandler)
    logger.info(f"HTTP API 服务器启动: 0.0.0.0:{port}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        logger.info("HTTP 服务器关闭")
        server.server_close()


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(name)s] %(levelname)s: %(message)s')
    run_http_server()