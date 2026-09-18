"""
TCP 游戏服务器 — 完整私服实现

协议体系:
  Key=255: 系统 (登录/角色/心跳)
  Key=0:   玩家 (信息/数据)
  Key=254: 系统功能 (初始化/属性)
  Key=15:  充值/礼包
  Key=1-14,16-46: 游戏系统 (逐步添加)
  Key=247-255: 内部系统
"""

import asyncio
import struct
import logging
import json
import time
from typing import Dict, Optional, List, Any
from datetime import datetime

from net_bit_stream import (
    NetBitStreamReader,
    NetBitStreamWriter,
    pack_tcp_message,
    unpack_tcp_message,
)
from database import (
    create_account, verify_account, get_account_by_id, get_account_by_username,
    get_roles_by_account, get_role_by_id, create_role,
    update_role_login, get_player_attrs, set_player_attr, add_player_attr,
    get_inventory, add_item, add_recharge_log, get_total_recharge,
    redeem_cdk, list_cdks,
    init_db,
)

logger = logging.getLogger('TCPServer')


# ═══════════════════════════════════════════════════════════════
# 工具函数
# ═══════════════════════════════════════════════════════════════

def build_role_array(roles: List[Dict]) -> bytes:
    """序列化角色数组 (255_4 协议)"""
    w = NetBitStreamWriter()
    w.write_byte(len(roles))  # 角色数量
    for role in roles:
        w.write_long(role['id'])             # role_id (int64)
        w.write_string(role['name'])         # name
        w.write_byte(role['sex'])            # sex
        w.write_uint(role.get('icon', 0))    # icon
        w.write_ushort(role['level'])        # level
        w.write_uint(role.get('fight_value', 0))  # fight value
    return w.to_bytes()


# ═══════════════════════════════════════════════════════════════
# 玩家会话
# ═══════════════════════════════════════════════════════════════

class PlayerSession:
    """单个客户端连接的游戏状态"""

    def __init__(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        self.reader = reader
        self.writer = writer
        self.addr = writer.get_extra_info('peername')
        self.account_id: Optional[int] = None
        self.role_id: Optional[int] = None
        self.server_id: int = 290001
        self.username: str = ''
        self.logined = False
        self.in_game = False
        self.heartbeat_count = 0
        self.created_at = datetime.now()

    # ─── 通用发送 ────────────────────────────────────────

    async def send_message(self, key: int, func_id: int, writer: NetBitStreamWriter):
        payload = writer.to_bytes()
        frame = pack_tcp_message(key, func_id, payload)
        try:
            self.writer.write(frame)
            await self.writer.drain()
        except Exception as e:
            logger.error(f"[{self.addr}] 发送失败: {e}")

    async def send_empty(self, key: int, func_id: int):
        """发送空消息体"""
        await self.send_message(key, func_id, NetBitStreamWriter())

    # ─── 255 系统协议 ────────────────────────────────────

    async def send_255_1(self, result_code: int):
        """发送登录结果"""
        w = NetBitStreamWriter()
        w.write_int(result_code)
        await self.send_message(255, 1, w)

    async def send_255_4(self, account_id: int, roles: List[Dict]):
        """发送角色列表"""
        w = NetBitStreamWriter()
        w.write_uint(account_id)          # account_id (uint32)
        w.write_int(len(roles))           # role_num (≥0 正常, <0 错误码)
        # 写入角色数组
        w.write_byte(len(roles))
        for role in roles:
            w.write_long(role['id'])              # role_id (int64)
            w.write_string(role['name'])          # name
            w.write_byte(role['sex'])             # sex (0=男, 1=女)
            w.write_uint(role.get('icon', 0))     # icon
            w.write_ushort(role['level'])         # level
            w.write_uint(role.get('fight_value', 0))  # fight
            w.write_uint(role.get('created_at', 0))   # create_time
        await self.send_message(255, 4, w)

    async def send_255_2_result(self, role_id: int, result_code: int, create_time: int):
        """发送创建角色结果"""
        w = NetBitStreamWriter()
        w.write_long(role_id)          # role_id
        w.write_int(result_code)       # result_code (0=成功)
        w.write_uint(create_time)      # create_time
        await self.send_message(255, 2, w)

    async def send_255_5(self, result_code: int):
        """发送进入游戏结果"""
        w = NetBitStreamWriter()
        w.write_int(result_code)
        await self.send_message(255, 5, w)

    async def send_255_3(self, ping_val: int):
        """发送心跳回复"""
        w = NetBitStreamWriter()
        w.write_int(0)              # result_code
        w.write_uint(int(time.time()))  # server_time
        w.write_int(ping_val)       # echo ping
        await self.send_message(255, 3, w)

    async def send_255_9(self, ping_val: int):
        """Ping/Pong"""
        w = NetBitStreamWriter()
        w.write_int(ping_val)
        w.write_int(0)
        await self.send_message(255, 9, w)

    # ─── 254 系统功能 ────────────────────────────────────

    async def send_254_39(self):
        """初始化开始"""
        await self.send_empty(254, 39)

    async def send_254_40(self, result: int = 0):
        """初始化完成"""
        w = NetBitStreamWriter()
        w.write_int(result)
        await self.send_message(254, 40, w)

    async def send_254_77(self, server_time: int = None):
        """连接成功通知"""
        w = NetBitStreamWriter()
        w.write_uint(server_time or int(time.time()))
        await self.send_message(254, 77, w)

    async def send_254_82(self, unk1: int = 0, unk2: int = 0):
        """系统配置数据"""
        w = NetBitStreamWriter()
        w.write_int(unk1)  # 未知字段
        w.write_int(unk2)  # 未知字段
        w.write_int(0)
        w.write_int(0)
        w.write_int(1)
        w.write_int(0)
        await self.send_message(254, 82, w)

    async def send_254_84(self):
        """进入场景"""
        w = NetBitStreamWriter()
        # 场景 ID
        w.write_int(101)          # scene_id
        w.write_int(1)            # line
        w.write_float(100.0)      # x
        w.write_float(200.0)      # y
        w.write_float(0.0)        # z
        await self.send_message(254, 84, w)

    async def send_254_115(self):
        """系统时间同步"""
        w = NetBitStreamWriter()
        w.write_uint(int(time.time()))
        w.write_short(0)
        await self.send_message(254, 115, w)

    async def send_254_116(self):
        """系统配置"""
        await self.send_empty(254, 116)

    async def send_254_42(self, attrs: Dict[int, int]):
        """属性变化通知"""
        w = NetBitStreamWriter()
        w.write_ushort(len(attrs))  # 属性数量
        for attr_type, attr_value in attrs.items():
            w.write_ushort(attr_type)     # attr_type
            w.write_long(attr_value)      # attr_value (int64)
        await self.send_message(254, 42, w)

    # ─── 0 玩家协议 ──────────────────────────────────────

    async def send_0_1(self, role: Dict):
        """玩家初始化数据"""
        attrs = get_player_attrs(role['id'])
        w = NetBitStreamWriter()
        w.write_long(role['id'])                  # actorHandle (int64)
        w.write_long(role['id'])                  # actorID (int64) 
        w.write_string(role['name'])              # actorName
        w.write_uint(role['server_id'])           # serverID
        w.write_byte(role['sex'])                 # sex
        w.write_uint(0)                           # platform
        w.write_uint(0)                           # gameUtility1
        w.write_uint(0)                           # gameUtility2
        w.write_uint(int(time.time()))            # serverTime (时区)
        w.write_uint(0)                           # onlineTimer
        await self.send_message(0, 1, w)

    async def send_0_2(self, server_time: int = None):
        """心跳/时间同步"""
        w = NetBitStreamWriter()
        w.write_uint(server_time or int(time.time()))
        await self.send_message(0, 2, w)

    # ─── 15 充值/礼包 ────────────────────────────────────

    async def send_15_1(self, recharge_data: List[Dict]):
        """充值面板数据"""
        w = NetBitStreamWriter()
        w.write_ushort(len(recharge_data))
        for item in recharge_data:
            w.write_uint(item.get('id', 0))          # 充值项 ID
            w.write_byte(item.get('status', 0))      # 状态 (0=可购买, 1=已购买)
            w.write_byte(item.get('extra', 0))       # 额外标记
        await self.send_message(15, 1, w)

    async def send_15_2(self, result_code: int):
        """充值请求结果"""
        w = NetBitStreamWriter()
        w.write_int(result_code)
        await self.send_message(15, 2, w)

    async def send_15_3(self, result_code: int):
        """充值确认结果"""
        w = NetBitStreamWriter()
        w.write_int(result_code)
        await self.send_message(15, 3, w)

    async def send_15_11(self, gift_data: List[Dict]):
        """礼包列表"""
        w = NetBitStreamWriter()
        w.write_ushort(len(gift_data))
        for g in gift_data:
            w.write_uint(g.get('id', 0))
            w.write_byte(g.get('status', 0))
            w.write_int(g.get('countdown', 0))
        await self.send_message(15, 11, w)

    async def send_15_31(self, cdk_result: Dict):
        """CDK 兑换结果"""
        w = NetBitStreamWriter()
        if cdk_result.get('success'):
            w.write_int(0)  # 成功
            items = cdk_result.get('items', [])
            w.write_ushort(len(items))
            for item_id, count in items:
                w.write_uint(item_id)
                w.write_uint(count)
        else:
            w.write_int(-1)  # 失败
        await self.send_message(15, 31, w)

    async def send_15_41(self, total_recharge: int):
        """累计充值"""
        w = NetBitStreamWriter()
        w.write_int(total_recharge)
        await self.send_message(15, 41, w)

    # ─── 清理 ─────────────────────────────────────────────

    def close(self):
        try:
            self.writer.close()
        except:
            pass


# ═══════════════════════════════════════════════════════════════
# 协议分发器
# ═══════════════════════════════════════════════════════════════

class ProtocolDispatcher:
    def __init__(self, server: 'GameServer'):
        self.server = server
        self._handlers = {}

    def register(self, key: int, func_id: int, handler):
        self._handlers[(key, func_id)] = handler

    async def dispatch(self, session: PlayerSession, key: int, func_id: int, reader: NetBitStreamReader):
        handler = self._handlers.get((key, func_id))
        if handler:
            await handler(session, reader)
        else:
            logger.warning(f"[{session.addr}] 未注册的协议: key={key}, funcId={func_id}")


# ═══════════════════════════════════════════════════════════════
# 游戏服务器
# ═══════════════════════════════════════════════════════════════

class GameServer:
    def __init__(self, host: str = '0.0.0.0', port: int = 9003):
        self.host = host
        self.port = port
        self.dispatcher = ProtocolDispatcher(self)
        self.sessions: Dict[str, PlayerSession] = {}
        self._register_handlers()

    def _register_handlers(self):
        """注册所有协议处理器"""

        # ═══════════════════════════════════════════════════
        # 255_1: 登录
        # ═══════════════════════════════════════════════════
        async def handle_255_1(session: PlayerSession, r: NetBitStreamReader):
            """
            客户端登录请求 (4 params):
              arg1: user_id (账号/用户名)
              arg2: password (密码)
              arg3: pfid (平台 ID, 如 100)
              arg4: version (客户端版本)
            """
            user_id = r.read_string() if r.remaining() > 1 else str(r.read_int())
            password = ''
            pfid = 100
            version = 0

            # 尝试按协议解析
            if r.remaining() > 0:
                try:
                    password = r.read_string()
                    pfid = r.read_int() if r.remaining() >= 4 else 100
                    version = r.read_int() if r.remaining() >= 4 else 0
                except:
                    pass

            # 如果 user_id 是纯数字, 转为字符串
            if isinstance(user_id, int):
                user_id = str(user_id)

            logger.info(f"[{session.addr}] 登录请求: user={user_id}, pfid={pfid}")

            # 验证账号 (自动注册)
            account = None
            db_account = get_account_by_username(user_id)
            if db_account:
                # 账号存在, 验证密码
                if password and db_account['password'] != password:
                    await session.send_255_1(1)  # 1 = 密码错误
                    return
                account = db_account
            else:
                # 自动注册
                aid = create_account(user_id, password or 'local', pfid)
                if aid:
                    session.username = user_id
                    account = get_account_by_id(aid)
                else:
                    await session.send_255_1(2)  # 2 = 没有这个账号
                    return

            if not account:
                await session.send_255_1(5)  # 5 = 服务器忙
                return

            session.account_id = account['id']
            session.username = account['username']
            session.logined = True

            # 登录成功
            await session.send_255_1(0)  # 0 = 登录成功
            logger.info(f"[{session.addr}] 登录成功: account_id={session.account_id}")

            # 发送角色列表 (255_4)
            roles = get_roles_by_account(session.account_id, session.server_id)
            logger.info(f"[{session.addr}] 角色列表: {len(roles)} 个角色")
            for r_data in roles:
                logger.info(f"  角色: id={r_data['id']}, name={r_data['name']}, level={r_data['level']}")
            await session.send_255_4(session.account_id, roles)

        # ═══════════════════════════════════════════════════
        # 255_2: 创建角色
        # ═══════════════════════════════════════════════════
        async def handle_255_2(session: PlayerSession, r: NetBitStreamReader):
            """
            创建角色请求 (5 params):
              arg1: name (角色名)
              arg2: sex (性别 0=男 1=女)
              arg3: icon (头像)
              arg4: pf (平台)
              arg5: serverid (服务器 ID)
            """
            if not session.logined:
                await session.send_255_2_result(0, -2, 0)  # -2 = USER_NOT_LOGGED_IN
                return

            name = r.read_string()
            sex = r.read_byte() if r.remaining() >= 1 else 0
            icon = r.read_uint() if r.remaining() >= 4 else 0
            pf = r.read_uint() if r.remaining() >= 4 else 100
            server_id = r.read_uint() if r.remaining() >= 4 else session.server_id

            logger.info(f"[{session.addr}] 创建角色: name={name}, sex={sex}, server_id={server_id}")

            # 创建角色
            role_id = create_role(session.account_id, name, sex, icon, server_id, pf)
            if role_id:
                now = int(time.time())
                await session.send_255_2_result(role_id, 0, now)  # 0 = OK
                logger.info(f"[{session.addr}] 角色创建成功: role_id={role_id}")
            else:
                await session.send_255_2_result(0, -6, 0)  # -6 = DUPLICATE_CHARACTER_NAME

        # ═══════════════════════════════════════════════════
        # 255_3: 心跳
        # ═══════════════════════════════════════════════════
        async def handle_255_3(session: PlayerSession, r: NetBitStreamReader):
            session.heartbeat_count += 1
            ping_val = r.read_int() if r.remaining() >= 4 else 0
            await session.send_255_3(ping_val)

        # ═══════════════════════════════════════════════════
        # 255_4: 请求角色列表
        # ═══════════════════════════════════════════════════
        async def handle_255_4(session: PlayerSession, r: NetBitStreamReader):
            """
            请求角色列表 (1 param):
              arg1: server_id
            """
            if r.remaining() >= 4:
                session.server_id = r.read_uint()
            logger.info(f"[{session.addr}] 请求角色列表: server_id={session.server_id}")

            if session.logined:
                roles = get_roles_by_account(session.account_id, session.server_id)
                await session.send_255_4(session.account_id, roles)

        # ═══════════════════════════════════════════════════
        # 255_5: 进入游戏
        # ═══════════════════════════════════════════════════
        async def handle_255_5(session: PlayerSession, r: NetBitStreamReader):
            """
            进入游戏请求 (5 params):
              arg1: role_id
              arg2: time (uint64)
              arg3: pfid
              arg4: udid
              arg5: isReconneting (0/1)
            """
            role_id = r.read_long() if r.remaining() >= 8 else 0
            time_val = r.read_ulong() if r.remaining() >= 8 else 0
            pfid = r.read_int() if r.remaining() >= 4 else 100
            udid = ''
            is_reconnect = 0
            if r.remaining() > 0:
                try:
                    udid = r.read_string()
                    is_reconnect = r.read_byte() if r.remaining() >= 1 else 0
                except:
                    pass

            logger.info(f"[{session.addr}] 进入游戏: role_id={role_id}, pfid={pfid}")

            # 验证角色
            role = get_role_by_id(role_id)
            if not role or role['is_deleted']:
                await session.send_255_5(-7)  # CHARACTER_NOT_FOUND
                return

            session.role_id = role_id
            session.in_game = True
            update_role_login(role_id)

            # 进入游戏成功
            await session.send_255_5(0)
            logger.info(f"[{session.addr}] 进入游戏成功: role={role['name']}")

            # 启动进入游戏后的初始化序列
            # 注意: 在 255_5 回复后, 客户端会陆续发送 254_39/40 等协议
            # 我们在收到 254_39 时再回复初始化数据和玩家信息

        # ═══════════════════════════════════════════════════
        # 255_9: Ping
        # ═══════════════════════════════════════════════════
        async def handle_255_9(session: PlayerSession, r: NetBitStreamReader):
            ping = r.read_int() if r.remaining() >= 4 else 0
            await session.send_255_9(ping)

        # ═══════════════════════════════════════════════════
        # 0_1: 客户端请求玩家信息
        # ═══════════════════════════════════════════════════
        async def handle_0_1(session: PlayerSession, r: NetBitStreamReader):
            """客户端请求玩家初始数据"""
            if session.role_id:
                role = get_role_by_id(session.role_id)
                if role:
                    await session.send_0_1(role)
                    # 同步推送属性
                    attrs = get_player_attrs(session.role_id)
                    if attrs:
                        await session.send_254_42(attrs)

        # ═══════════════════════════════════════════════════
        # 0_2: 客户端时间同步
        # ═══════════════════════════════════════════════════
        async def handle_0_2(session: PlayerSession, r: NetBitStreamReader):
            client_time = r.read_uint() if r.remaining() >= 4 else 0
            await session.send_0_2()

        # ═══════════════════════════════════════════════════
        # 254_39: 初始化开始
        # ═══════════════════════════════════════════════════
        async def handle_254_39(session: PlayerSession, r: NetBitStreamReader):
            """客户端通知开始初始化"""
            logger.info(f"[{session.addr}] 客户端初始化开始")
            await session.send_254_39()

            # 批量发送初始化数据
            await session.send_254_115()              # 时间同步
            await session.send_254_116()              # 系统配置
            await session.send_254_82(0, 1)           # 系统配置数据

        # ═══════════════════════════════════════════════════
        # 254_40: 初始化结束
        # ═══════════════════════════════════════════════════
        async def handle_254_40(session: PlayerSession, r: NetBitStreamReader):
            """客户端通知初始化结束"""
            logger.info(f"[{session.addr}] 初始化完成")

            # 回复初始化完成
            await session.send_254_40(0)

            # 发送玩家基础信息
            if session.role_id:
                role = get_role_by_id(session.role_id)
                if role:
                    await session.send_0_1(role)

                    # 发送属性
                    attrs = get_player_attrs(session.role_id)
                    if attrs:
                        await session.send_254_42(attrs)

                    # 发送充值面板 (可以充值)
                    recharge_items = [
                        {'id': 1, 'status': 0, 'extra': 0},
                        {'id': 2, 'status': 0, 'extra': 0},
                        {'id': 3, 'status': 0, 'extra': 0},
                    ]
                    await session.send_15_1(recharge_items)

                    # 发送累计充值
                    total = get_total_recharge(session.role_id)
                    await session.send_15_41(int(total))

                    # 发送场景
                    await session.send_254_84()

        # ═══════════════════════════════════════════════════
        # 254_42: 属性同步 (客户端 -> 服务端)
        # ═══════════════════════════════════════════════════
        async def handle_254_42(session: PlayerSession, r: NetBitStreamReader):
            """客户端同步属性"""
            if r.remaining() >= 2:
                count = r.read_ushort()
                for _ in range(count):
                    if r.remaining() < 2 + 8:
                        break
                    attr_type = r.read_ushort()
                    attr_value = r.read_long()
                    if session.role_id:
                        set_player_attr(session.role_id, attr_type, attr_value)

        # ═══════════════════════════════════════════════════
        # 254_77: 连接确认
        # ═══════════════════════════════════════════════════
        async def handle_254_77(session: PlayerSession, r: NetBitStreamReader):
            """客户端确认连接"""
            await session.send_254_77()

        # ═══════════════════════════════════════════════════
        # 15_1: 请求充值面板
        # ═══════════════════════════════════════════════════
        async def handle_15_1(session: PlayerSession, r: NetBitStreamReader):
            """客户端请求充值面板数据"""
            recharge_items = [
                {'id': 1, 'status': 0, 'extra': 0},
                {'id': 2, 'status': 0, 'extra': 0},
                {'id': 3, 'status': 0, 'extra': 0},
                {'id': 4, 'status': 0, 'extra': 0},
                {'id': 5, 'status': 0, 'extra': 0},
                {'id': 6, 'status': 0, 'extra': 0},
            ]
            await session.send_15_1(recharge_items)

        # ═══════════════════════════════════════════════════
        # 15_2: 发起充值
        # ═══════════════════════════════════════════════════
        async def handle_15_2(session: PlayerSession, r: NetBitStreamReader):
            """
            客户端发起充值请求 (3 params):
              arg1: recharge_id (充值项 ID)
              arg2: count (数量)
              arg3: extra (额外参数)
            """
            recharge_id = r.read_int() if r.remaining() >= 4 else 0
            count = r.read_int() if r.remaining() >= 4 else 1
            extra = r.read_int() if r.remaining() >= 4 else 0

            logger.info(f"[{session.addr}] 充值请求: recharge_id={recharge_id}, count={count}")

            # 本地充值直接成功
            await session.send_15_2(0)

        # ═══════════════════════════════════════════════════
        # 15_3: 确认充值到账
        # ═══════════════════════════════════════════════════
        async def handle_15_3(session: PlayerSession, r: NetBitStreamReader):
            """
            客户端确认充值到账 (3 params):
              arg1: recharge_id
              arg2: order_id
              arg3: extra
            """
            recharge_id = r.read_int() if r.remaining() >= 4 else 0
            order_id = 0
            extra = 0
            if r.remaining() >= 4:
                order_id = r.read_int()
            if r.remaining() >= 4:
                extra = r.read_int()

            logger.info(f"[{session.addr}] 充值确认: recharge_id={recharge_id}")

            # 发放充值奖励
            if session.role_id:
                # 发放元宝 (根据充值档位)
                amount_map = {1: 60, 2: 300, 3: 980, 4: 1980, 5: 3280, 6: 6480}
                amount = amount_map.get(recharge_id, 100)

                # 加元宝 (attr_type=1001)
                new_balance = add_player_attr(session.role_id, 1001, amount)
                add_recharge_log(session.role_id, float(recharge_id), 1001, amount)

                # 通知客户端属性变化
                await session.send_254_42({1001: new_balance})

                # 发送累计充值
                total = get_total_recharge(session.role_id)
                await session.send_15_41(int(total))

            await session.send_15_3(0)

        # ═══════════════════════════════════════════════════
        # 15_31: CDK 兑换
        # ═══════════════════════════════════════════════════
        async def handle_15_31(session: PlayerSession, r: NetBitStreamReader):
            """CDK 兑换请求"""
            cdk_code = r.read_string() if r.remaining() > 1 else ''

            logger.info(f"[{session.addr}] CDK 兑换: code={cdk_code}")

            if not session.role_id or not cdk_code:
                await session.send_15_31({'success': False, 'items': []})
                return

            result = redeem_cdk(cdk_code.upper(), session.role_id)
            await session.send_15_31(result)

            if result.get('success'):
                logger.info(f"[{session.addr}] CDK 兑换成功: {result['items']}")

                # 通知背包变化 (实际物品在 database 中已发放)
                # 属性通知
                attrs_to_send = {}
                for item_id, count in result.get('items', []):
                    if item_id < 10000:  # 非货币类物品
                        continue
                    attrs_to_send[item_id] = get_player_attrs(session.role_id).get(item_id, count)
                if attrs_to_send:
                    await session.send_254_42(attrs_to_send)

        # ═══════════════════════════════════════════════════
        # 15_41: 请求累计充值
        # ═══════════════════════════════════════════════════
        async def handle_15_41(session: PlayerSession, r: NetBitStreamReader):
            """请求累计充值"""
            if session.role_id:
                total = get_total_recharge(session.role_id)
                await session.send_15_41(int(total))

        # ═══════════════════════════════════════════════════
        # 15_51: 请求礼包列表
        # ═══════════════════════════════════════════════════
        async def handle_15_51(session: PlayerSession, r: NetBitStreamReader):
            """请求礼包列表"""
            gift_data = [
                {'id': 1, 'status': 0, 'countdown': 0},
                {'id': 2, 'status': 0, 'countdown': 0},
                {'id': 3, 'status': 0, 'countdown': 0},
            ]
            await session.send_15_11(gift_data)

        # ═══════════════════════════════════════════════════
        # 15_52/53: 礼包购买
        # ═══════════════════════════════════════════════════
        async def handle_15_52(session: PlayerSession, r: NetBitStreamReader):
            """礼包购买请求"""
            await session.send_empty(15, 52)

        async def handle_15_53(session: PlayerSession, r: NetBitStreamReader):
            """礼包领取"""
            await session.send_empty(15, 53)

        # ═══════════════════════════════════════════════════
        # 15_22/32/42/62: 购买
        # ═══════════════════════════════════════════════════
        async def handle_15_22(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 22)

        async def handle_15_32(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 32)

        async def handle_15_42(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            arg2 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 42)

        async def handle_15_62(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 62)

        # ═══════════════════════════════════════════════════
        # 15_61: 请求首充奖励
        # ═══════════════════════════════════════════════════
        async def handle_15_61(session: PlayerSession, r: NetBitStreamReader):
            """请求首充信息"""
            await session.send_empty(15, 61)

        # ═══════════════════════════════════════════════════
        # 15_72/73/81/82: 月卡/订阅
        # ═══════════════════════════════════════════════════
        async def handle_15_72(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            arg2 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 72)

        async def handle_15_73(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 73)

        async def handle_15_81(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            arg2 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 81)

        async def handle_15_82(session: PlayerSession, r: NetBitStreamReader):
            arg1 = r.read_int() if r.remaining() >= 4 else 0
            await session.send_empty(15, 82)

        # ═══════════════════════════════════════════════════
        # 254_84: 进入场景 (客户端请求)
        # ═══════════════════════════════════════════════════
        async def handle_254_84(session: PlayerSession, r: NetBitStreamReader):
            """客户端进入场景"""
            await session.send_254_84()

        # ═══════════════════════════════════════════════════
        # 254_115/116: 时间/配置
        # ═══════════════════════════════════════════════════
        async def handle_254_115(session: PlayerSession, r: NetBitStreamReader):
            await session.send_254_115()

        async def handle_254_116(session: PlayerSession, r: NetBitStreamReader):
            await session.send_254_116()

        # ═══════════════════════════════════════════════════
        # 注册所有处理器
        # ═══════════════════════════════════════════════════

        # 系统
        self.dispatcher.register(255, 1, handle_255_1)
        self.dispatcher.register(255, 2, handle_255_2)
        self.dispatcher.register(255, 3, handle_255_3)
        self.dispatcher.register(255, 4, handle_255_4)
        self.dispatcher.register(255, 5, handle_255_5)
        self.dispatcher.register(255, 9, handle_255_9)

        # 玩家
        self.dispatcher.register(0, 1, handle_0_1)
        self.dispatcher.register(0, 2, handle_0_2)

        # 系统功能
        self.dispatcher.register(254, 39, handle_254_39)
        self.dispatcher.register(254, 40, handle_254_40)
        self.dispatcher.register(254, 42, handle_254_42)
        self.dispatcher.register(254, 77, handle_254_77)
        self.dispatcher.register(254, 84, handle_254_84)
        self.dispatcher.register(254, 115, handle_254_115)
        self.dispatcher.register(254, 116, handle_254_116)

        # 充值/礼包
        self.dispatcher.register(15, 1, handle_15_1)
        self.dispatcher.register(15, 2, handle_15_2)
        self.dispatcher.register(15, 3, handle_15_3)
        self.dispatcher.register(15, 11, handle_15_51)  # 礼包列表
        self.dispatcher.register(15, 31, handle_15_31)  # CDK
        self.dispatcher.register(15, 41, handle_15_41)  # 累计充值
        self.dispatcher.register(15, 51, handle_15_51)
        self.dispatcher.register(15, 52, handle_15_52)
        self.dispatcher.register(15, 53, handle_15_53)
        self.dispatcher.register(15, 22, handle_15_22)
        self.dispatcher.register(15, 32, handle_15_32)
        self.dispatcher.register(15, 42, handle_15_42)
        self.dispatcher.register(15, 62, handle_15_62)
        self.dispatcher.register(15, 61, handle_15_61)
        self.dispatcher.register(15, 72, handle_15_72)
        self.dispatcher.register(15, 73, handle_15_73)
        self.dispatcher.register(15, 81, handle_15_81)
        self.dispatcher.register(15, 82, handle_15_82)

        logger.info(f"已注册 {len(self.dispatcher._handlers)} 个协议处理器")

    async def handle_client(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        session = PlayerSession(reader, writer)
        self.sessions[session.addr] = session
        logger.info(f"[{session.addr}] 新连接")

        # 发送连接成功通知
        await session.send_254_77()

        buf = bytearray()
        try:
            while True:
                chunk = await reader.read(4096)
                if not chunk:
                    break

                buf.extend(chunk)

                while True:
                    if len(buf) < 4:
                        break
                    total_len = struct.unpack_from('<i', bytes(buf), 0)[0]
                    if len(buf) < total_len:
                        break

                    frame = bytes(buf[:total_len])
                    buf = buf[total_len:]

                    result = unpack_tcp_message(frame)
                    if result is None:
                        continue

                    key, func_id, payload = result
                    payload_reader = NetBitStreamReader(payload)
                    logger.debug(f"[{session.addr}] << key={key}, funcId={func_id}, payload_len={len(payload)}")

                    await self.dispatcher.dispatch(session, key, func_id, payload_reader)

        except asyncio.CancelledError:
            pass
        except ConnectionResetError:
            logger.warning(f"[{session.addr}] 连接重置")
        except Exception as e:
            logger.error(f"[{session.addr}] 异常: {e}", exc_info=True)
        finally:
            session.close()
            self.sessions.pop(session.addr, None)
            logger.info(f"[{session.addr}] 断开连接 (心跳: {session.heartbeat_count})")

    async def start(self):
        server = await asyncio.start_server(
            self.handle_client,
            self.host,
            self.port
        )
        self.server = server
        addr = server.sockets[0].getsockname()
        logger.info(f"TCP 游戏服务器启动: {addr[0]}:{addr[1]}")
        logger.info(f"已注册协议数: {len(self.dispatcher._handlers)}")

        async with server:
            await server.serve_forever()

    def stop(self):
        for session in list(self.sessions.values()):
            session.close()
        self.sessions.clear()


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(name)s] %(levelname)s: %(message)s')
    init_db()
    server = GameServer(port=9003)
    try:
        asyncio.run(server.start())
    except KeyboardInterrupt:
        logger.info("TCP 服务器关闭")