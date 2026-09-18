# 修仙游戏本地私服 · 架构全景文档

> 文档版本: 2026-09-19
> 数据来源标记说明 (按可信度从高到低):
>   🔴 **真实提取** — 直接从 APK / AssetBundle 提取的原始字节/文本，100% 真实
>   🔵 **真实映射** — 从反编译代码/CSV 中直接映射的字段名和结构，完全可靠
>   🟠 **推导** — 通过上下文、命名惯例、代码逻辑推测的含义，可能有问题
>   🟢 **自行设计** — 我们编写的私服逻辑，非原游戏数据
>
> ⚠️ **重要声明**: 本项目所有数据均来自 APK 解包和反编译，从未进行任何网络抓包操作。

---

## 目录

1. [项目概述](#1-项目概述)
2. [数据来源分级说明](#2-数据来源分级说明)
3. [文件清单与职责](#3-文件清单与职责)
4. [系统架构](#4-系统架构)
5. [客户端连接流程](#5-客户端连接流程)
6. [TCP 协议参考](#6-tcp-协议参考)
7. [HTTP API 参考](#7-http-api-参考)
8. [数据库结构](#8-数据库结构)
9. [属性/物品 ID 对照](#9-属性物品-id-对照)
10. [已知局限与风险](#10-已知局限与风险)

---

## 1. 项目概述

本地私服的目的是在不依赖官方服务器的情况下运行 Android 修仙游戏客户端。核心策略是 **劫持客户端的 HTTP 请求** 和 **模拟游戏服务器 TCP 协议**，让客户端认为自己连接的是官方服务器。

| 维度 | 说明 |
|------|------|
| 游戏名 | ZQZS (修仙手游) |
| 客户端 | `C:\Desktop\apkni\ZQZS\` — 原始 APK 解压目录 |
| 配置文件 | `config.ab` — Unity AssetBundle (从 APK 内部提取) |
| 官方地址 | 🔴 `10.10.1.49:89` (从 config.ab 二进制搜索提取) |
| 协议 CSV | 🔴 `out/protocels.csv` / `out/protocols.csv` (IL2CPP 反编译导出) |
| 本地服务 | HTTP `0.0.0.0:8080` + TCP `0.0.0.0:9003` |
| 代理端口 | `0.0.0.0:8888` (手机代理入口) |

---

## 2. 数据来源分级说明

### 🔴 真实提取 (直接从 APK 文件中提取)

这些数据是从原始游戏文件中直接提取的，**100% 真实**：

| 数据项 | 来源方式 | 详情 |
|--------|---------|------|
| `config.ab` 文件 | APK 解压 → `assets/Android/config.ab` | Unity AssetBundle 配置包 |
| `infoURL = /cysh/api/getpfinfo` | config.ab 二进制搜索 | 客户端的 HTTP 配置入口路径 |
| `10.10.1.49:89` | config.ab 二进制搜索 | 官方服务器地址和端口 |
| 服务器 ID `290001` | config.ab 文本提取 | 大区 ID 范围 `290001~290099` |
| `csdefine.txt` | config.ab → TextAsset 提取 | `{"3000.map":"2bdf2269..."}` |
| `protocels.csv` | IL2CPP 反编译导出 | 协议 key/func_id/table 映射, 共 1198 行 |
| `protocols.csv` | IL2CPP 反编译导出 | 协议 struct 字段定义 (字段名/类型/偏移) |
| `lua_protocol_coverage.csv` | IL2CPP 反编译导出 | 协议 → Lua 脚本处理函数映射 |
| `il2cpp_net_classes.csv` | IL2CPP 反编译导出 | C# 网络层类列表 |
| `il2cpp_net_methods.csv` | IL2CPP 反编译导出 | C# 网络层方法列表 |
| `structs.csv` | IL2CPP 反编译导出 | 全部游戏 struct 定义 |
| `protocol_types.csv` | IL2CPP 反编译导出 | 协议类型枚举 |
| `asset_index.csv` | IL2CPP 反编译导出 | 资源索引 |
| Lua 脚本路径 | `lua_protocol_coverage.csv` 提取 | 如 `gamecore.player.playercontroller.lua` |

### 🔵 真实映射 (从反编译代码/CSV 中直接映射)

这些数据是直接从反编译结果中**复制字段名和结构**的，没有加入主观判断，**完全可靠**：

| 数据项 | 直接来源 | 说明 |
|--------|---------|------|
| **TCP 帧结构**: `[4B 总长][2B key][2B func_id][payload]` | C# 网络层 `SendMessage/OnReceive` 方法 | 封包/解包逻辑直接可见 |
| **NetBitStream 格式**: 小端序, 类型码前缀 | C# `NetBitStream` 类 `WriteByte/WriteInt32` 等方法 | 编码方式直接可见 |
| **类型码表**: `0x01=SByte, 0x02=Byte, 0x05=Int32, 0x0a=String` | C# 枚举定义 | 二进制枚举值逐一对应 |
| **String 编码**: `[u16 length][UTF-8 bytes][\0]` | C# `WriteString` 方法 | 直接读取方法实现 |
| **所有 key/func_id 映射** | `out/protocels.csv` | CSV 文件直接记录 |
| **所有 struct 字段名/类型** | `out/protocols.csv` | CSV 文件直接记录 |
| **255_1 登录参数**: `user_id, password, pfid, version` | protocols.csv 中对应 struct 字段名 | 字段名就是原文 |
| **255_2 创建角色参数**: `name, sex, icon, pf, server_id` | protocols.csv 对应 struct | 字段名就是原文 |
| **255_4 角色列表**: 返回 `account_id + 角色数组` | protocols.csv 对应 struct | 字段名就是原文 |
| **255_5 进入游戏参数**: `role_id, time, pfid, udid, reconnect` | protocols.csv 对应 struct | 字段名就是原文 |
| **15_1 充值面板**: `{id, status, extra} 数组` | protocols.csv 对应 struct | 字段名就是原文 |
| **15_2/15_3 充值**: `recharge_id, order_id` | protocols.csv 字段名 | 字段名就是原文 |
| **15_31 CDK 兑换**: `code → result + items[]` | protocols.csv 字段名 | 字段名就是原文 |
| **15_41 累计充值**: 返回 `total_recharge` | protocols.csv 字段名 | 字段名就是原文 |
| **Lua handler 映射**: 协议→`playercontroller.lua` 等 | `out/lua_protocol_coverage.csv` | CSV 文件直接记录 |

### 🟠 推导 (通过上下文/命名惯例/代码逻辑推测)

这些数据是我们**推测**出来的，**可能和实际游戏行为不符**：

| 数据项 | 推测依据 | 可信度 | 可能偏差 |
|--------|---------|--------|---------|
| **协议分组命名**: `key=255`=系统, `key=15`=充值 | protocels.csv 分布 + Lua handler 命名方式 | 🟡 较高 | 分组边界可能不对 |
| **255_3 心跳**: 参数含义 `ping` | `playercontroller.lua` 中变量名 | 🟡 较高 | 变量名可能是别的含义 |
| **254_39/40**: "初始化开始/结束" | Lua handler 前后关系推断 | 🟡 较高 | 名称可能有偏差 |
| **254_42 格式**: `[u16 count][u16 type][i64 value]` | `bagprotocolcontrol.lua` 数据分析 | 🟡 较高 | 类型/长度可能不同 |
| **15_1~15_3**: "面板→发起→确认"流程 | Lua handler 链 + struct 字段名组合 | 🟡 较高 | 字段含义可能有偏差 |
| **协议时序**: 254_39→40→0_1→254_42→254_84 | 多个独立 CSV 组合推断 | ⭐⭐ 中等 | 客户端可能不按此顺序 |
| **属性 ID 含义**: 1001=元宝, 1002=绑定元宝, 1003=铜钱 | Lua 脚本中属性名惯例 | ⭐⭐ 中等 | 可能完全不对 |
| **254_77/82/84/115/116 回复格式** | 这些协议在 CSV 中无对应 struct, 自行设计 | 无依据 | 最可能不匹配客户端 |
| **充值档位**: `{1:60, 2:300, ..., 6:6480}` | 常见手游 6 档位 | ⭐ 较低 | 档位/价格全错 |
| **物品 ID > 2000 的含义** | 无任何官方数据 | ⭐ 很低 | 名称和效果均为猜测 |

### 🟢 自行设计 (我们编写的私服逻辑)

这些是整个私服中 **完全由我们设计实现** 的部分，原始游戏没有这些逻辑：

| 组件 | 说明 |
|------|------|
| **SQLite 数据库全部表结构** | 7 张表的 schema 均为自行设计 |
| **全部 HTTP 响应数据** | getpfinfo/服务器列表/登录返回等所有 JSON |
| **账号自动注册机制** | 登录时若账号不存在则自动创建 |
| **CDK 礼包码系统** | 创建/列表/兑换/防重复/次数限制 |
| **充值模拟** | HTTP 接口充值 + 元宝发放 |
| **重定向代理** | HTTP + TCP 透明转发 |
| **所有协议处理器的具体实现** | 33 个 handler 的逻辑内容 |
| **玩家会话管理** | PlayerSession 的状态跟踪 |
| **角色初始化默认属性** | 默认初始值均为自行设定 |
| **协议回复中的数据内容** | 场景坐标、充值面板 item id、礼包列表等 |
| **客户端连接指南** | 操作步骤文档 |

---

## 3. 文件清单与职责

```
apkni/
│
├── ZQZS/                           🔴 原始 APK 解压目录 (不修改)
│   ├── AndroidManifest.xml
│   └── assets/Android/
│       └── config.ab               🔴 游戏配置文件 (Unity AssetBundle)
│
├── out/                            🔴 IL2CPP 反编译导出数据
│   ├── protocels.csv               🔴 协议 key/func_id 映射表 (1198 条)
│   ├── protocols.csv               🔴 协议 struct 字段定义
│   ├── lua_protocol_coverage.csv   🔴 协议 → Lua 脚本映射
│   ├── il2cpp_net_classes.csv      🔴 C# 网络层类列表
│   ├── il2cpp_net_methods.csv      🔴 C# 网络层方法列表
│   ├── il2cpp_struct_methods.csv   🔴 Struct 方法列表
│   ├── structs.csv                 🔴 所有游戏 struct 定义
│   ├── protocol_types.csv          🔴 协议类型枚举
│   └── asset_index.csv             🔴 资源索引
│
├── tools/
│   └── ab_extract.py               🟢 config.ab 提取工具
│
└── server/                         🟢 私服代码 (全部自行开发)
    ├── start_server.py             🟢 启动入口 (HTTP + TCP 双服务)
    ├── http_server.py              🟢 HTTP API 服务器 (模拟 PHP 配置服)
    ├── tcp_server.py               🟢 TCP 游戏服务器 (33 个协议处理器)
    ├── database.py                 🟢 SQLite 数据库层
    ├── net_bit_stream.py           🟡 NetBitStream 序列化 (C# 代码复现)
    ├── redirect_proxy.py           🟢 重定向代理 (HTTP + TCP 转发)
    ├── extract_config.py           🟢 config.ab 提取/修补工具
    ├── patch_config.py             🟢 config.ab 二进制修补工具
    ├── search_in_config.py         🟢 config.ab URL 搜索工具
    ├── analyze_config.py           🟢 config.ab 结构分析工具
    ├── client_guide.md             🟢 客户端连接指南
    ├── ARCHITECTURE.md             🟢 本文件 (架构全景文档)
    ├── private_server.db           🟢 SQLite 数据库 (运行时自动生成)
    └── config_patch/               🔴 从 config.ab TextAsset 提取的原始文本
        ├── assets_prefabs_data_config_csdefine.txt.txt     🔴 配置定义
        ├── ..._2danimation_sprites.bytes.txt               🔴 (空文件)
        └── ..._dragonbones.bytes.txt                       🔴 (空文件)
```

---

## 4. 系统架构

```
┌──────────────────────────────────────────────────────────────────┐
│                        手机 (热点)                                │
│   ┌──────────────────────┐    HTTP 代理 (8888)   ┌─────────────┐│
│   │                      │ ◄──────────────────── │             ││
│   │  游戏客户端 (APK)     │                       │  笔记本      ││
│   │                      │ ────────────────────► │  (hotspot)  ││
│   │  infoURL =           │    TCP 直连 (9003)    │             ││
│   │  /cysh/api/getpfinfo │                       │             ││
│   └──────────────────────┘                       └─────────────┘│
└──────────────────────────────────────────────────────────────────┘

笔记本内部服务:
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│  HTTP :8080 ────────► 重定向代理 :8888 ◄───── 手机 HTTP      │
│   (配置/充值/CDK)        (透明转发)                           │
│                                                              │
│  TCP :9003 ◄────────────────────────────────────── 手机 TCP   │
│   (游戏服务器)                                               │
│       │                                                      │
│       ▼                                                      │
│  SQLite (private_server.db)                                  │
│   ├─ accounts      ─ 账号                                    │
│   ├─ roles         ─ 角色                                    │
│   ├─ player_attrs  ─ 属性(元宝/铜钱)                          │
│   ├─ inventory     ─ 背包道具                                 │
│   ├─ recharge_log  ─ 充值记录                                 │
│   ├─ cdk_codes     ─ CDK 礼包码                               │
│   └─ cdk_redemptions ─ CDK 兑换记录                           │
└──────────────────────────────────────────────────────────────┘
```

### 数据流总览

```
┌─────────── APK 解包阶段 ───────────┐
│                                    │
│  ZQZS.apk                          │
│    │                               │
│    ├─ 解压 → ZQZS/                 │
│    │    └─ config.ab               │
│    │       ├─ 提取 TextAsset       │
│    │       └─ 搜索 infoURL / IP     │
│    │                               │
│    └─ IL2CPP 反编译 → out/*.csv    │
│         ├─ protocels.csv           │
│         ├─ protocols.csv           │
│         └─ lua_protocol_coverage   │
│                                    │
└─────────── 服务器运行阶段 ──────────┘
                                    │
  手机(代理:笔记本:8888)              │
       │                             │
       ▼                             │
  ┌──────────────┐                   │
  │ redirect_    │                  │
  │ proxy.py    │ ──► http_server  │
  │ :8888       │ ──► tcp_server   │
  └──────────────┘                   │
       │                             │
       ▼                             │
  tcp_server.py                      │
   │                                 │
   ├─ 反查 CSV → 确定 key/func_id    │
   ├─ 查找注册的 handler             │
   ├─ 执行逻辑 (读库/计算/写库)       │
   └─ 回复 NetBitStream 编码包       │
                                     │
  http_server.py                     │
   ├─ PHP 配置服 (getpfinfo等)        │
   ├─ 充值接口 (/api/recharge)       │
   └─ CDK 管理 (/api/cdk/*)          │
                                     │
  database.py                        │
   └─ SQLite 读写                    │
                                    │
└────────────────────────────────────┘
```

---

## 5. 客户端连接流程 (详细时序)

### 5.1 预置条件

游戏客户端内置了 🔴 `infoURL` (从 config.ab 二进制搜索提取):

```
http://10.10.1.49:89/cysh/api/getpfinfo
```

通过**手机设置代理**到笔记本 `IP:8888`，重定向代理 `redirect_proxy.py` 拦截请求并转发到本地 `127.0.0.1:8080`。

### 5.2 HTTP 配置获取 🟢 全部自行设计

```
客户端 → 本地 :8080  GET /cysh/api/getpfinfo
客户端 ← 本地 :8080  JSON {
    cdnURL:          "http://127.0.0.1:8080/cdn/",
    loginURL:        "http://127.0.0.1:8080/login",
    serverZoneURL:   "http://127.0.0.1:8080/serverZone",
    lastServerListURL: "http://127.0.0.1:8080/lastServerList",
    serverListURL:   "http://127.0.0.1:8080/serverList",
    roleListURL:     "http://127.0.0.1:8080/roleList",
    serverInfoURL:   "http://127.0.0.1:8080/serverInfo",
    noticeURL:       "http://127.0.0.1:8080/notice",
    noticeNumURL:    "http://127.0.0.1:8080/noticeNum",
    recommendServerListURL: "http://127.0.0.1:8080/recommendServerList",
    iosInfoURL:      "about:blank",
    sdkParams:       { ... 固定值 ... },
    code:            0
}
```

> 🔴 **真实**: 路径 `/cysh/api/getpfinfo` 来自 config.ab 文本搜索
> 🟢 **自行设计**: 所有返回的 JSON 内容、子 URL 路径、SDK 参数

### 5.3 服务器列表获取 🟢 全部自行设计

```
客户端 → 本地 :8080  GET /lastServerList?userId=xxx
客户端 ← 本地 :8080  JSON {
    lastserver: [{ name:"本地私服", server_id:290001, ip:"127.0.0.1", port:9003 }],
    ... SDK params ...
}

客户端 → 本地 :8080  GET /serverZone?account=xxx
客户端 ← 本地 :8080  JSON { server_zone_info: [{ name:"本地大区", zone_id:1,
                           start_id:290001, end_id:290099 }] }

客户端 → 本地 :8080  GET /login?serverId=290001&time=...&sign=...
客户端 ← 本地 :8080  JSON { code:0, srvaddr:"127.0.0.1", srvport:9003, ... }
```

> 🔴 **真实**: 服务器 ID `290001` (来自 config.ab)
> 🟢 **自行设计**: 服务器列表 JSON、大区配置、SDK 参数、登录响应体

### 5.4 TCP 游戏协议序列 🔵 CSV 结构 + 🟠 时序推导 + 🟢 回复设计

```
TCP 连接建立后:

服务端 → 客户端  254_77     (连接确认)

客户端 → 服务端  255_1      (登录请求 🔵 4 参数: user_id, password, pfid, version)
服务端 → 客户端  255_1      (登录结果 🟢 0=成功)
服务端 → 客户端  255_4      (角色列表 🟢 account_id + 角色数组)

客户端 → 服务端  255_2      (创建角色 🔵 5 参数: name, sex, icon, pf, server_id)
服务端 → 客户端  255_2      (创建结果 🟢 role_id, result_code, create_time)

客户端 → 服务端  255_5      (进入游戏 🔵 5 参数: role_id, time, pfid, udid, reconnect)
服务端 → 客户端  255_5      (进入游戏结果 🟢 0=成功)

客户端 → 服务端  254_39     (初始化开始 🟠 名称由 Lua handler 推导)
服务端 → 客户端  254_39     🟢 回复空包
服务端 → 客户端  254_115    🟢 时间同步
服务端 → 客户端  254_116    🟢 系统配置(空)
服务端 → 客户端  254_82     🟢 配置数据(固定值)

客户端 → 服务端  254_40     (初始化结束 🟠 名称由 Lua handler 推导)
服务端 → 客户端  254_40     🟢 初始化完成
服务端 → 客户端  0_1        🟢 玩家信息 (role_id, name, sex, server_time)
服务端 → 客户端  254_42     🟢 属性同步 (元宝初始值)
服务端 → 客户端  15_1       🟢 充值面板 (6 档)
服务端 → 客户端  15_41      🟢 累计充值 (0)
服务端 → 客户端  254_84     🟢 进入场景 (固定坐标)

╌╌╌╌╌╌ 游戏中 ╌╌╌╌╌╌╌╌╌╌╌

客户端 → 服务端  255_3      (心跳, 持续)
服务端 → 客户端  255_3      🟢 心跳回复

客户端 → 服务端  15_2       (发起充值 🔵 recharge_id)
服务端 → 客户端  15_2       🟢 充值成功
客户端 → 服务端  15_3       (确认到账 🔵 recharge_id, order_id)
服务端 → 客户端  15_3       🟢 到账成功 + 元宝增加

客户端 → 服务端  15_31      (CDK 兑换 🔵 code)
服务端 → 客户端  15_31      🟢 兑换结果 + 物品发放
```

> **来源说明**:
> - 🔵 协议编号、参数个数、字段名 — 直接从 `protocels.csv` + `protocols.csv` 提取 (字段名就是原文)
> - 🟠 协议顺序、"初始化"等名称含义 — 从 `lua_protocol_coverage.csv` 中 Lua handler 前后关系推测
> - 🟢 每个 handler 回复的具体数据内容 — 自行设计，无官方依据

---

## 6. TCP 协议参考

### 6.1 帧格式 🔵 (C# 网络层代码直接映射)

```
┌─────────────────────────────────────────────────────┐
│ 字段           类型    大小    说明                    │
├─────────────────────────────────────────────────────┤
│ TotalLength   Int32   4B      包含自身在内的总长度     │
│ Key           UInt16  2B      协议主分类 (protocel_key) │
│ FuncId        UInt16  2B      功能编号 (func_id)       │
│ Payload       Bytes   N       NetBitStream 消息体    │
└─────────────────────────────────────────────────────┘
```

> **来源**: C# 网络层代码 `SendMessage` / `OnReceive` 方法中封包/解包逻辑直接映射。

### 6.2 NetBitStream 序列化格式 🔵 (C# 类直接映射)

```
类型码表:
  0x00 = None       0x01 = SByte/Char   (1 字节)
  0x02 = Byte/UChar  (1 字节)   0x03 = Int16/Short    (2 字节)
  0x04 = UInt16/UShort (2 字节) 0x05 = Int32/Int      (4 字节)
  0x06 = UInt32/UInt  (4 字节)  0x07 = Int64/Long     (8 字节)
  0x08 = UInt64/ULong (8 字节)  0x09 = Float          (4 字节)
  0x0a = String      (变长)

String 编码: [u16 length (2B)][UTF-8 bytes][\0 (1B)]
所有整数: 小端序 (Little Endian)
```

> **来源**: 反编译 C# `NetBitStream` 类，`WriteByte/WriteInt32/WriteString` 等方法逻辑直接映射。

### 6.3 完整协议清单

| Key | FuncId | 来源 | 方向 | 名称 | 服务端回复 (🟢 自行设计) |
|-----|--------|------|------|------|------------------------|
| **系统 (255)** |||||
| 255 | 1 | 🔵 CSV | C→S | 登录 | `result_code(int)` |
| 255 | 2 | 🔵 CSV | C→S | 创建角色 | `role_id(i64) + result(int) + create_time(uint)` |
| 255 | 3 | 🔵 CSV | C→S | 心跳 | `result(int) + server_time(uint) + ping(int)` |
| 255 | 4 | 🔵 CSV | C→S | 请求角色列表 | `account_id(uint) + role_num(int) + roles[...]` |
| 255 | 5 | 🔵 CSV | C→S | 进入游戏 | `result_code(int)` |
| 255 | 9 | 🔵 CSV | C→S | Ping | `ping(int) + unk(int)` |
| **玩家 (0)** |||||
| 0 | 1 | 🔵 CSV | C→S | 请求玩家信息 | `actorHandle(i64) + actorID(i64) + name(str)...` |
| 0 | 2 | 🔵 CSV | C→S | 时间同步 | `server_time(uint)` |
| **系统功能 (254)** |||||
| 254 | 39 | 🔵 CSV | C→S | 初始化开始 | (空包) |
| 254 | 40 | 🔵 CSV | C→S | 初始化结束 | `result(int)` |
| 254 | 42 | 🟠 推导 | C↔S | 属性同步 | `count(u16) + {type(u16),value(i64)}...` |
| 254 | 77 | 🔵 CSV | C→S | 连接确认 | `server_time(uint)` |
| 254 | 82 | 🟠 推导 | C→S | 请求配置 | `6 个固定 int` |
| 254 | 84 | 🟠 推导 | C→S | 进入场景 | `scene_id(int) + line(int) + x/y/z(float)` |
| 254 | 115 | 🟠 推导 | C→S | 时间同步 | `server_time(uint) + unk(short)` |
| 254 | 116 | 🟠 推导 | C→S | 系统配置 | (空包) |
| **充值/礼包 (15)** |||||
| 15 | 1 | 🔵 CSV | C→S | 充值面板 | `count(u16) + {id(uint),status(byte),extra(byte)}...` |
| 15 | 2 | 🔵 CSV | C→S | 发起充值 | `result_code(int)` |
| 15 | 3 | 🔵 CSV | C→S | 确认到账 | `result_code(int)` |
| 15 | 11 | 🔵 CSV | C→S | 礼包列表 | `count(u16) + {id(uint),status(byte),countdown(int)}...` |
| 15 | 31 | 🔵 CSV | C→S | CDK 兑换 | `result(int) + count(u16) + {item_id(uint),count(uint)}...` |
| 15 | 41 | 🔵 CSV | C→S | 累计充值 | `total_recharge(int)` |
| 15 | 51 | 🔵 CSV | C→S | 礼包列表 | 同 15_11 |
| 15 | 52 | 🔵 CSV | C→S | 礼包购买 | (空包) |
| 15 | 53 | 🔵 CSV | C→S | 礼包领取 | (空包) |
| 15 | 22 | 🔵 CSV | C→S | 购买 | (空包) |
| 15 | 32 | 🔵 CSV | C→S | 购买 | (空包) |
| 15 | 42 | 🔵 CSV | C→S | 购买 | (空包) |
| 15 | 62 | 🔵 CSV | C→S | 购买 | (空包) |
| 15 | 61 | 🔵 CSV | C→S | 首充奖励 | (空包) |
| 15 | 72 | 🔵 CSV | C→S | 月卡 | (空包) |
| 15 | 73 | 🔵 CSV | C→S | 月卡 | (空包) |
| 15 | 81 | 🔵 CSV | C→S | 订阅 | (空包) |
| 15 | 82 | 🔵 CSV | C→S | 订阅 | (空包) |

> **来源说明**:
> - 🔵 **CSV 真实映射**: `protocels.csv` 中 key + func_id + struct 映射; `protocols.csv` 中字段名/类型/偏移 — 字段名就是原文，完全可靠
> - 🟠 **推导**: 254 系列无 CSV struct 的协议，回复格式为自行设计，最可能不匹配客户端
> - 🟢 **设计**: 回复中的具体数值 (场景坐标=101/100/200、充值面板 item_id、初始属性值) 均为自行设定，无任何官方依据

---

## 7. HTTP API 参考

### 7.1 客户端接口 (模拟 PHP 配置服) 🟢 全部自行设计

| 端点 | 方法 | 说明 |
|------|------|------|
| `/cysh/api/getpfinfo` | GET | 配置入口，返回所有子 URL (🔴 此路径来自 config.ab) |
| `/lastServerList` | GET | 最近服务器列表 |
| `/serverZone` | GET | 大区列表 |
| `/serverList` | GET | 服务器列表 |
| `/login` | GET | PHP 登录验证，返回 TCP 地址 |
| `/serverInfo` | GET | 服务器详细信息 |
| `/recommendServerList` | GET | 推荐服务器 |
| `/roleList` | GET | 角色列表 |
| `/notice` | GET | 公告 |
| `/noticeNum` | GET | 公告未读数 |

### 7.2 管理接口 🟢 全部自行设计

| 端点 | 方法 | Body | 说明 |
|------|------|------|------|
| `/api/recharge` | POST | `{"role_id":1, "amount":64800, "item_id":1001, "item_count":6480}` | 充值模拟 |
| `/api/cdk/create` | POST | `{"code":"MYGIFT", "items":[[1001,10]], "max_use":100}` | 创建 CDK |
| `/api/cdk/list` | GET | - | CDK 列表 |

---

## 8. 数据库结构 🟢 全部自行设计

```
┌──────────────────────────────────────────────────────────────────┐
│ accounts                           roles                          │
│───────────────────                 ───────────────────            │
│ id (PK, AUTO)                      id (PK, AUTO)                  │
│ username (UNIQUE)                  account_id (FK→accounts.id)    │
│ password           ◄──────────────│ server_id (290001)            │
│ platform ('local')                 name                           │
│ pfid (100)                         sex                            │
│ created_at (timestamp)             icon                           │
│ last_login                         level                          │
│ is_banned                          exp                            │
└───────────────────                 fight_value                    │
       │                             created_at                     │
       │                             last_login                     │
       │                             is_deleted                     │
       │                             ───────────────────            │
       │                             │       ▲                      │
       │                             │       │                      │
       ▼                             ▼       │                      │
┌───────────────────                 ───────────────────            │
│ player_attrs                       inventory                      │
│───────────────────                 ───────────────────            │
│ role_id (PK, FK→roles.id)          id (PK, AUTO)                  │
│ attr_type (PK)                     role_id (FK→roles.id)          │
│ attr_value                         item_id                        │
└───────────────────                 item_count                     │
                                     ───────────────────            │
┌───────────────────                 │       ▲                      │
│ recharge_log                       │       │                      │
│───────────────────                 ▼       │                      │
│ id (PK, AUTO)                 ───────────────────                 │
│ role_id (FK→roles.id)         cdk_redemptions                    │
│ amount                        ───────────────────                │
│ item_id                        id (PK, AUTO)                     │
│ item_count                     cdk_id (FK→cdk_codes.id)          │
│ order_id                       role_id (FK→roles.id)            │
│ status                         redeemed_at                       │
│ created_at                     ───────────────────               │
└───────────────────                     ▲                         │
                                          │                         │
┌───────────────────                      │                         │
│ cdk_codes                               │                         │
│───────────────────                      │                         │
│ id (PK, AUTO) ──────────────────────────┘                         │
│ code (UNIQUE)                                                    │
│ item_json (JSON: {"items":[[id,cnt],...]})                       │
│ max_use                                                          │
│ use_count                                                        │
│ expires_at                                                       │
│ is_active                                                        │
│ created_at                                                       │
└───────────────────                                                │
└──────────────────────────────────────────────────────────────────┘
```

### 默认 CDK 🟢 自行设计

| CDK 码 | 物品 | 最大使用次数 |
|--------|------|------------|
| `VIP888` | 1001(元宝)×10, 2001(道具)×1, 3001(道具)×5 | 999 |
| `FL555` | 1001(元宝)×5, 3001(道具)×2 | 999 |
| `GIFT999` | 1001(元宝)×50, 2001(道具)×5, 4001(道具)×3 | 999 |

---

## 9. 属性/物品 ID 对照

| ID | 名称 | 来源 | 说明 |
|----|------|------|------|
| 1 | 充值总金额 | 🟠 推导 | `recharge_log.amount` 字段名含义推测 |
| 4 | 充值档位 | 🟠 推导 | Lua 脚本中档位变量名推测 |
| 1001 | 元宝 | 🟠 推导 | Lua 脚本中货币属性名惯例推测 |
| 1002 | 绑定元宝 | 🟠 推导 | Lua 脚本中货币属性名惯例推测 |
| 1003 | 铜钱 | 🟠 推导 | Lua 脚本中货币属性名惯例推测 |
| 2001~9999 | 各类道具 | 🟠 推导 | 具体物品名称和效果无官方数据 |

> **警告**: 以上所有 ID 含义均为 **推导**，无任何 CSV struct 字段名或 C# 代码直接标注。
> 实际游戏中这些 ID 可能对应完全不同的物品或功能。

---

## 10. 已知局限与风险

### 10.1 功能缺失

| 功能 | 状态 | 原因 |
|------|------|------|
| 游戏任务系统 | ❌ 未实现 | 协议 key=1~14 的 handler 未注册 |
| 战斗系统 | ❌ 未实现 | 协议 key=16~46 的 handler 未注册 |
| NPC/场景交互 | ❌ 未实现 | 未实现场景内协议 |
| 装备/强化 | ❌ 未实现 | 背包物品无实际效果 |
| 好友/社交 | ❌ 未实现 | 未注册社交类协议 |
| 拍卖行 | ❌ 未实现 | 未注册交易类协议 |
| CDN 资源下载 | ❌ 未实现 | cdnURL 返回 404，需自行搭建 |
| SDK 真实登录 | ❌ 未实现 | SDK 参数为固定值，无 SDK 服务 |

### 10.2 已知风险

| 风险 | 严重度 | 说明 |
|------|--------|------|
| `TCP_HOST` 配置错误 | 🟡 中 | 热点模式下必须改为笔记本实际 IP，否则手机连不上 TCP 服务器 |
| 数据库重置 | 🟢 低 | 删除 `private_server.db` 会丢失全部账号/角色/充值数据 |
| 端口冲突 | 🟢 低 | 8080/9003/8888 被占用时启动失败 |
| 防火墙拦截 | 🟡 中 | 需要管理员权限放行端口 |
| 协议兼容性 | 🔴 高 | handler 的回复格式可能与客户端预期不匹配 |
| CSV 数据完整性 | 🟡 中 | protocels.csv 和 protocols.csv 的 struct 字段名含义依赖猜测 |

### 10.3 未实现的协议域 (CSV 中已识别但未处理)

来自 protocels.csv 的 key 分布:

| Key 范围 | 条目数 | 可能用途 | 实现状态 |
|----------|--------|---------|---------|
| 0 | ~6 | 玩家信息 | ✅ (2 个) |
| 1~14 | ~200+ | 地图/场景/NPC/背包 | ⬜ 未实现 |
| 15 | ~50 | 充值/礼包/CDK | ✅ (18 个已注册) |
| 16~46 | ~400+ | 战斗/技能/活动 | ⬜ 未实现 |
| 47~246 | ~500+ | 各种游戏系统 | ⬜ 未实现 |
| 247~249 | 少量 | 排队/频道 | ⬜ 未实现 |
| 254 | ~15 | 系统功能 | ✅ (8 个已注册) |
| 255 | ~10 | 系统(登录/角色) | ✅ (5 个已注册) |

---

## 附录 A：数据溯源总表

| 模块/功能 | 来源 | 关键依据文件 | 可信度 |
|-----------|------|-------------|--------|
| infoURL 路径 `/cysh/api/getpfinfo` | 🔴 config.ab 二进制搜索 | `config.ab` | ✅ 100% |
| 官方服务器 IP `10.10.1.49:89` | 🔴 config.ab 二进制搜索 | `config.ab` | ✅ 100% |
| 服务器 ID `290001` | 🔴 config.ab 文本提取 | `config.ab` | ✅ 100% |
| 协议 key/func_id 映射 | 🔵 CSV 真实映射 | `out/protocels.csv` | ✅ 100% |
| 协议 struct 字段定义 | 🔵 CSV 真实映射 | `out/protocols.csv` | ✅ 100% |
| 协议 → Lua 脚本映射 | 🔵 CSV 真实映射 | `out/lua_protocol_coverage.csv` | ✅ 100% |
| C# 网络层类/方法 | 🔵 反编译直接映射 | `out/il2cpp_net_classes/methods.csv` | ✅ 100% |
| TCP 帧结构 `[4B+2B+2B+N]` | 🔵 C# `SendMessage` 方法直接映射 | C# 网络层代码 | ✅ 100% |
| NetBitStream 序列化格式 | 🔵 C# 类方法直接映射 | `NetBitStream` 类 | ✅ 100% |
| 类型码 (0x01=SByte 等) | 🔵 C# 枚举定义直接映射 | 枚举定义 | ✅ 100% |
| **协议分组命名** (key=255=系统) | 🟠 Lua handler 命名推测 | `lua_protocol_coverage.csv` | ⚠️ 可能偏差 |
| **255_3 参数"ping"含义** | 🟠 Lua 变量名推测 | `playercontroller.lua` | ⚠️ 可能偏差 |
| **254_39/40 "初始化"含义** | 🟠 Lua handler 前后关系推测 | 多个 CSV 组合 | ⚠️ 可能偏差 |
| **协议时序** (谁先谁后) | 🟠 多个 CSV struct 组合推测 | 多个 CSV 文件 | ⚠️ 可能不对 |
| **属性 ID 含义** (1001=元宝) | 🟠 Lua 货币变量名惯例推测 | Lua 脚本 | ⚠️ 可能全错 |
| **254_77/82/84/115/116 格式** | 🟠 无 CSV struct, 纯个人设计 | 无依据 | ❌ 最可能不匹配 |
| **充值档位** (60/300/980...) | 🟠 常见手游惯例推测 | 无依据 | ❌ 可能全错 |
| **所有数据库表结构** | 🟢 自行设计 | 纯原创 | 🔧 自用 |
| **所有 HTTP JSON 响应** | 🟢 自行设计 | 纯原创 | 🔧 自用 |
| **33 个协议 handler 逻辑** | 🟢 自行设计 | 纯原创 | 🔧 自用 |
| **CDK 礼包码系统** | 🟢 自行设计 | 纯原创 | 🔧 自用 |
| **充值模拟** | 🟢 自行设计 | 纯原创 | 🔧 自用 |
| **重定向代理** | 🟢 自行设计 | 纯原创 | 🔧 自用 |
| **自动注册机制** | 🟢 自行设计 | 纯原创 | 🔧 自用 |