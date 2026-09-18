"""
NetBitStream — 游戏二进制序列化协议

与客户端 C# NetBitStream (ReadInt/ReadByte/ReadString/ReadUInt 等) 完全兼容。
小端字节序。

Type codes (eDataType):
    0x00 None       — void
    0x01 Char       — sbyte (1 byte)
    0x02 UChar      — byte (1 byte)
    0x03 Short      — short (2 bytes)
    0x04 UShort     — ushort (2 bytes)
    0x05 Int        — int (4 bytes)
    0x06 UInt       — uint (4 bytes)
    0x07 Int64      — long (8 bytes)
    0x08 UInt64     — ulong (8 bytes)
    0x09 Float      — float (4 bytes)
    0x0a String     — string (变长: u16 len + UTF-8 + '\0')
    0x0b Struct     — 内嵌结构体
    0x0c Array      — 数组 (前有 len 字段)
"""

import struct
from typing import Any, List, Optional
import logging

logger = logging.getLogger('NetBitStream')


class NetBitStreamReader:
    """从字节流中按类型读取数据 (对应 C# ReadByte/ReadInt/ReadString 等)"""

    def __init__(self, data: bytes):
        self.data = data
        self.pos = 0

    def remaining(self) -> int:
        return len(self.data) - self.pos

    def tell(self) -> int:
        return self.pos

    def seek(self, pos: int):
        self.pos = pos

    def skip(self, n: int):
        self.pos += n

    def read_byte(self) -> int:
        """Read UChar / byte"""
        val = self.data[self.pos]
        self.pos += 1
        return val

    def read_sbyte(self) -> int:
        """Read Char / sbyte"""
        val = struct.unpack_from('<b', self.data, self.pos)[0]
        self.pos += 1
        return val

    def read_short(self) -> int:
        val = struct.unpack_from('<h', self.data, self.pos)[0]
        self.pos += 2
        return val

    def read_ushort(self) -> int:
        val = struct.unpack_from('<H', self.data, self.pos)[0]
        self.pos += 2
        return val

    def read_int(self) -> int:
        val = struct.unpack_from('<i', self.data, self.pos)[0]
        self.pos += 4
        return val

    def read_uint(self) -> int:
        val = struct.unpack_from('<I', self.data, self.pos)[0]
        self.pos += 4
        return val

    def read_long(self) -> int:
        val = struct.unpack_from('<q', self.data, self.pos)[0]
        self.pos += 8
        return val

    def read_ulong(self) -> int:
        val = struct.unpack_from('<Q', self.data, self.pos)[0]
        self.pos += 8
        return val

    def read_float(self) -> float:
        val = struct.unpack_from('<f', self.data, self.pos)[0]
        self.pos += 4
        return val

    def read_string(self) -> str:
        """ReadString: u16 LE length, then UTF-8 bytes, then skip 1 byte '\\0'"""
        length = self.read_ushort()
        if length == 0:
            return ''
        raw = self.data[self.pos:self.pos + length]
        self.pos += length
        # skip terminating null byte
        if self.pos < len(self.data) and self.data[self.pos] == 0:
            self.pos += 1
        return raw.decode('utf-8', errors='replace')

    def read_bytes(self, n: int) -> bytes:
        raw = self.data[self.pos:self.pos + n]
        self.pos += n
        return raw


class NetBitStreamWriter:
    """写入字节流 (对应 C# WriteByte/WriteInt/WriteString 等)"""

    def __init__(self):
        self.buf = bytearray()

    def write_byte(self, val: int):
        """Write UChar / byte"""
        self.buf.append(val & 0xFF)

    def write_sbyte(self, val: int):
        self.buf.extend(struct.pack('<b', val))

    def write_short(self, val: int):
        self.buf.extend(struct.pack('<h', val))

    def write_ushort(self, val: int):
        self.buf.extend(struct.pack('<H', val))

    def write_int(self, val: int):
        self.buf.extend(struct.pack('<i', val))

    def write_uint(self, val: int):
        self.buf.extend(struct.pack('<I', val))

    def write_long(self, val: int):
        self.buf.extend(struct.pack('<q', val))

    def write_ulong(self, val: int):
        self.buf.extend(struct.pack('<Q', val))

    def write_float(self, val: float):
        self.buf.extend(struct.pack('<f', val))

    def write_string(self, val: str):
        """WriteString: u16 LE length + UTF-8 + '\\0'"""
        encoded = val.encode('utf-8')
        self.write_ushort(len(encoded))
        self.buf.extend(encoded)
        self.buf.append(0)  # terminating null

    def write_bytes(self, data: bytes):
        self.buf.extend(data)

    def to_bytes(self) -> bytes:
        return bytes(self.buf)


# ─── TCP 封包格式 ──────────────────────────────────────────────

def pack_tcp_message(key: int, func_id: int, payload: bytes) -> bytes:
    """
    打包 TCP 消息帧:
      [4 bytes] 总长度 (小端 int32) — 包含自身
      [2 bytes] protocel key
      [2 bytes] funcId
      [N bytes] 消息体 (NetBitStream payload)
    """
    frame_size = 4 + 2 + 2 + len(payload)
    buf = bytearray()
    buf.extend(struct.pack('<i', frame_size))   # 总长度
    buf.extend(struct.pack('<H', key))           # key
    buf.extend(struct.pack('<H', func_id))       # funcId
    buf.extend(payload)                          # 消息体
    return bytes(buf)


def unpack_tcp_message(data: bytes) -> Optional[tuple]:
    """
    解包 TCP 消息帧。
    返回 (key, func_id, payload_bytes) 或 None (数据不足)
    """
    if len(data) < 4:
        return None
    total_len = struct.unpack_from('<i', data, 0)[0]
    if len(data) < total_len:
        return None
    if total_len < 8:
        return None
    key = struct.unpack_from('<H', data, 4)[0]
    func_id = struct.unpack_from('<H', data, 6)[0]
    payload = data[8:total_len]
    return (key, func_id, payload)