"""
数据库层 — SQLite

表结构:
  - accounts: 账号
  - roles: 角色
  - player_attrs: 玩家属性（货币、等级等）
  - inventory: 背包
  - recharge_log: 充值记录
  - cdk_codes: CDK 礼包码
  - cdk_redemptions: CDK 兑换记录
"""

import sqlite3
import os
import logging
import json
import time
from datetime import datetime
from typing import Optional, List, Dict, Any
from contextlib import contextmanager

logger = logging.getLogger('Database')

DB_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'private_server.db')


@contextmanager
def get_db():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    try:
        yield conn
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


def init_db():
    """初始化数据库表"""
    with get_db() as conn:
        c = conn.cursor()
        c.executescript('''
            CREATE TABLE IF NOT EXISTS accounts (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                username    TEXT NOT NULL UNIQUE,
                password    TEXT NOT NULL,
                platform    TEXT DEFAULT 'local',
                pfid        INTEGER DEFAULT 100,
                created_at  INTEGER NOT NULL,
                last_login  INTEGER,
                is_banned   INTEGER DEFAULT 0
            );

            CREATE TABLE IF NOT EXISTS roles (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                account_id  INTEGER NOT NULL,
                server_id   INTEGER DEFAULT 290001,
                name        TEXT NOT NULL,
                sex         INTEGER DEFAULT 0,
                icon        INTEGER DEFAULT 0,
                level       INTEGER DEFAULT 1,
                exp         INTEGER DEFAULT 0,
                fight_value INTEGER DEFAULT 0,
                created_at  INTEGER NOT NULL,
                last_login  INTEGER,
                is_deleted  INTEGER DEFAULT 0,
                FOREIGN KEY (account_id) REFERENCES accounts(id)
            );

            CREATE TABLE IF NOT EXISTS player_attrs (
                role_id     INTEGER NOT NULL,
                attr_type   INTEGER NOT NULL,
                attr_value  INTEGER DEFAULT 0,
                PRIMARY KEY (role_id, attr_type),
                FOREIGN KEY (role_id) REFERENCES roles(id)
            );

            CREATE TABLE IF NOT EXISTS inventory (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                role_id     INTEGER NOT NULL,
                item_id     INTEGER NOT NULL,
                item_count  INTEGER DEFAULT 1,
                FOREIGN KEY (role_id) REFERENCES roles(id)
            );

            CREATE TABLE IF NOT EXISTS recharge_log (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                role_id     INTEGER NOT NULL,
                amount      REAL DEFAULT 0,
                item_id     INTEGER,
                item_count  INTEGER,
                order_id    TEXT,
                status      INTEGER DEFAULT 1,
                created_at  INTEGER NOT NULL,
                FOREIGN KEY (role_id) REFERENCES roles(id)
            );

            CREATE TABLE IF NOT EXISTS cdk_codes (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                code        TEXT NOT NULL UNIQUE,
                item_json   TEXT NOT NULL,
                max_use     INTEGER DEFAULT 1,
                use_count   INTEGER DEFAULT 0,
                expires_at  INTEGER,
                is_active   INTEGER DEFAULT 1,
                created_at  INTEGER NOT NULL
            );

            CREATE TABLE IF NOT EXISTS cdk_redemptions (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                cdk_id      INTEGER NOT NULL,
                role_id     INTEGER NOT NULL,
                redeemed_at INTEGER NOT NULL,
                FOREIGN KEY (cdk_id) REFERENCES cdk_codes(id),
                FOREIGN KEY (role_id) REFERENCES roles(id)
            );
        ''')

        # 插入默认 CDK
        default_cdks = [
            ('VIP888', json.dumps({'items': [[1001, 10], [2001, 1], [3001, 5]]}, ensure_ascii=False), 'VIP 礼包'),
            ('FL555', json.dumps({'items': [[1001, 5], [3001, 2]]}, ensure_ascii=False), '福利礼包'),
            ('GIFT999', json.dumps({'items': [[1001, 50], [2001, 5], [4001, 3]]}, ensure_ascii=False), '豪华礼包'),
        ]
        for code, items, desc in default_cdks:
            try:
                c.execute(
                    'INSERT OR IGNORE INTO cdk_codes (code, item_json, max_use, created_at) VALUES (?, ?, 999, ?)',
                    (code, items, int(time.time()))
                )
            except Exception:
                pass

        logger.info(f"数据库初始化完成: {DB_PATH}")


# ─── 账号操作 ──────────────────────────────────────────────

def create_account(username: str, password: str, pfid: int = 100) -> Optional[int]:
    """创建账号，返回 account_id 或 None"""
    with get_db() as conn:
        try:
            c = conn.cursor()
            now = int(time.time())
            c.execute(
                'INSERT INTO accounts (username, password, pfid, created_at) VALUES (?, ?, ?, ?)',
                (username, password, pfid, now)
            )
            return c.lastrowid
        except sqlite3.IntegrityError:
            return None


def verify_account(username: str, password: str) -> Optional[int]:
    """验证账号密码，返回 account_id 或 None"""
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT id, is_banned FROM accounts WHERE username=? AND password=?', (username, password))
        row = c.fetchone()
        if row and row['is_banned'] == 0:
            # 更新最后登录
            c.execute('UPDATE accounts SET last_login=? WHERE id=?', (int(time.time()), row['id']))
            return row['id']
        return None


def get_account_by_id(account_id: int) -> Optional[Dict]:
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT * FROM accounts WHERE id=?', (account_id,))
        row = c.fetchone()
        return dict(row) if row else None


def get_account_by_username(username: str) -> Optional[Dict]:
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT * FROM accounts WHERE username=?', (username,))
        row = c.fetchone()
        return dict(row) if row else None


# ─── 角色操作 ──────────────────────────────────────────────

def create_role(account_id: int, name: str, sex: int, icon: int, server_id: int, pf: int) -> Optional[int]:
    """创建角色，返回 role_id 或 None"""
    with get_db() as conn:
        try:
            c = conn.cursor()
            now = int(time.time())
            c.execute(
                '''INSERT INTO roles (account_id, server_id, name, sex, icon, created_at)
                   VALUES (?, ?, ?, ?, ?, ?)''',
                (account_id, server_id, name, sex, icon, now)
            )
            role_id = c.lastrowid

            # 初始化默认属性: 元宝(100), 铜钱(200), 灵石(300)
            default_attrs = [
                (role_id, 1, 0),    # 充值金额 (recharge total)
                (role_id, 4, 0),    # 充值档位
                (role_id, 1001, 0), # 元宝
                (role_id, 1002, 0), # 绑定元宝
                (role_id, 1003, 0), # 铜钱
            ]
            c.executemany(
                'INSERT OR IGNORE INTO player_attrs (role_id, attr_type, attr_value) VALUES (?, ?, ?)',
                default_attrs
            )
            return role_id
        except sqlite3.IntegrityError:
            return None


def get_roles_by_account(account_id: int, server_id: int) -> List[Dict]:
    """获取账号在某个服务器的角色列表"""
    with get_db() as conn:
        c = conn.cursor()
        c.execute(
            'SELECT * FROM roles WHERE account_id=? AND server_id=? AND is_deleted=0',
            (account_id, server_id)
        )
        return [dict(row) for row in c.fetchall()]


def get_role_by_id(role_id: int) -> Optional[Dict]:
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT * FROM roles WHERE id=?', (role_id,))
        row = c.fetchone()
        return dict(row) if row else None


def update_role_login(role_id: int):
    with get_db() as conn:
        c = conn.cursor()
        c.execute('UPDATE roles SET last_login=? WHERE id=?', (int(time.time()), role_id))


# ─── 玩家属性 ──────────────────────────────────────────────

def get_player_attrs(role_id: int) -> Dict[int, int]:
    """获取角色所有属性"""
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT attr_type, attr_value FROM player_attrs WHERE role_id=?', (role_id,))
        return {row['attr_type']: row['attr_value'] for row in c.fetchall()}


def set_player_attr(role_id: int, attr_type: int, value: int):
    with get_db() as conn:
        c = conn.cursor()
        c.execute(
            'INSERT OR REPLACE INTO player_attrs (role_id, attr_type, attr_value) VALUES (?, ?, ?)',
            (role_id, attr_type, value)
        )


def add_player_attr(role_id: int, attr_type: int, delta: int) -> int:
    """增减属性，返回新值"""
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT attr_value FROM player_attrs WHERE role_id=? AND attr_type=?', (role_id, attr_type))
        row = c.fetchone()
        cur = row['attr_value'] if row else 0
        new_val = max(0, cur + delta)
        c.execute(
            'INSERT OR REPLACE INTO player_attrs (role_id, attr_type, attr_value) VALUES (?, ?, ?)',
            (role_id, attr_type, new_val)
        )
        return new_val


# ─── 背包 ──────────────────────────────────────────────────

def add_item(role_id: int, item_id: int, count: int = 1):
    """添加道具"""
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT item_count FROM inventory WHERE role_id=? AND item_id=?', (role_id, item_id))
        row = c.fetchone()
        if row:
            c.execute('UPDATE inventory SET item_count=item_count+? WHERE role_id=? AND item_id=?',
                      (count, role_id, item_id))
        else:
            c.execute('INSERT INTO inventory (role_id, item_id, item_count) VALUES (?, ?, ?)',
                      (role_id, item_id, count))


def get_inventory(role_id: int) -> List[Dict]:
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT * FROM inventory WHERE role_id=? AND item_count>0', (role_id,))
        return [dict(row) for row in c.fetchall()]


# ─── 充值 ──────────────────────────────────────────────────

def add_recharge_log(role_id: int, amount: float, item_id: int = None, item_count: int = None, order_id: str = None):
    with get_db() as conn:
        c = conn.cursor()
        c.execute(
            'INSERT INTO recharge_log (role_id, amount, item_id, item_count, order_id, created_at) VALUES (?, ?, ?, ?, ?, ?)',
            (role_id, amount, item_id, item_count, order_id, int(time.time()))
        )


def get_total_recharge(role_id: int) -> float:
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT COALESCE(SUM(amount), 0) FROM recharge_log WHERE role_id=? AND status=1', (role_id,))
        row = c.fetchone()
        return row[0]


# ─── CDK 礼包码 ────────────────────────────────────────────

def redeem_cdk(code: str, role_id: int) -> Dict:
    """兑换 CDK，返回 {'success': True, 'items': [...]} 或 {'success': False, 'msg': '...'}"""
    with get_db() as conn:
        c = conn.cursor()
        now = int(time.time())

        # 查找 CDK
        c.execute('SELECT * FROM cdk_codes WHERE code=? AND is_active=1', (code,))
        cdk = c.fetchone()
        if not cdk:
            return {'success': False, 'msg': 'CDK 不存在或已失效'}

        cdk = dict(cdk)

        # 检查过期
        if cdk['expires_at'] and now > cdk['expires_at']:
            return {'success': False, 'msg': 'CDK 已过期'}

        # 检查使用次数
        if cdk['use_count'] >= cdk['max_use']:
            return {'success': False, 'msg': 'CDK 已达最大使用次数'}

        # 检查是否已兑换
        c.execute('SELECT id FROM cdk_redemptions WHERE cdk_id=? AND role_id=?', (cdk['id'], role_id))
        if c.fetchone():
            return {'success': False, 'msg': '该角色已兑换过此 CDK'}

        # 解析物品
        data = json.loads(cdk['item_json'])
        items = data.get('items', [])

        # 发放物品
        for item_id, count in items:
            add_item(role_id, item_id, count)

        # 记录
        c.execute(
            'INSERT INTO cdk_redemptions (cdk_id, role_id, redeemed_at) VALUES (?, ?, ?)',
            (cdk['id'], role_id, now)
        )
        c.execute('UPDATE cdk_codes SET use_count=use_count+1 WHERE id=?', (cdk['id'],))

        return {'success': True, 'items': items}


def list_cdks() -> List[Dict]:
    with get_db() as conn:
        c = conn.cursor()
        c.execute('SELECT id, code, item_json, max_use, use_count, is_active FROM cdk_codes')
        return [dict(row) for row in c.fetchall()]


def create_cdk(code: str, items: List[List[int]], max_use: int = 1, expires_at: int = None) -> bool:
    """创建 CDK 礼包码"""
    with get_db() as conn:
        try:
            c = conn.cursor()
            c.execute(
                'INSERT INTO cdk_codes (code, item_json, max_use, expires_at, created_at) VALUES (?, ?, ?, ?, ?)',
                (code, json.dumps({'items': items}), max_use, expires_at, int(time.time()))
            )
            return True
        except sqlite3.IntegrityError:
            return False