# 本地私服客户端连接指南

## 网络架构

```
┌──────────────┐       HTTP 代理 (8888)       ┌──────────────────┐
│  手机 (热点)  │ ──── 设置代理到笔记本 ────▶  │  笔记本           │
│  游戏客户端   │                              │  ├─ HTTP :8080   │
│              │                              │  │  (账号/充值)   │
│              │       TCP 直连 (9003)         │  ├─ TCP  :9003   │
│              │ ◀───────────────────────────  │  │  (游戏服务器)  │
└──────────────┘                              └──────────────────┘
```

## 你的网络环境

| 设备 | 角色 | 说明 |
|------|------|------|
| **手机** | 开热点 + 运行游戏客户端 | 热点默认网关 `192.168.43.1` |
| **笔记本** | 连接手机热点 + 运行私服 | IP 由手机分配，如 `192.168.43.xxx` |

## 前置准备

### 防火墙放行端口

以管理员身份打开 PowerShell，执行：

```powershell
# HTTP 服务
netsh advfirewall firewall add rule name="PrivateServer-HTTP" dir=in action=allow protocol=TCP localport=8080

# TCP 游戏服务器
netsh advfirewall firewall add rule name="PrivateServer-TCP" dir=in action=allow protocol=TCP localport=9003

# HTTP 代理 (手机通过代理连接)
netsh advfirewall firewall add rule name="PrivateServer-Proxy" dir=in action=allow protocol=TCP localport=8888
```

## 完整操作步骤

### Step 1：获取笔记本 IP

```powershell
ipconfig
# 找到 "无线局域网适配器" 的 IPv4 地址，如 192.168.43.xxx
```

### Step 2：配置服务器 IP

编辑 `server/http_server.py`，找到 `ServerConfig` 类，修改 `TCP_HOST`：

```python
# 原来是 127.0.0.1，改成笔记本在热点网络中的实际 IP
TCP_HOST = '192.168.43.xxx'  # ← 改成你的实际 IP
```

> ⚠️ **如果只在本地 127.0.0.1 测试，手机连不上 TCP 游戏服务器**

### Step 3：启动私服

```powershell
python server\start_server.py
```

正常输出：
```
数据库初始化完成
HTTP API  : 0.0.0.0:8080
TCP Game  : 0.0.0.0:9003
已注册 33 个协议处理器
```

### Step 4：启动重定向代理

```powershell
python server\redirect_proxy.py
```

### Step 5：手机设置代理

1. 手机连接笔记本开的热点
2. 进入 WLAN 设置 → 代理 → 手动
3. 服务器：笔记本 IP（如 `192.168.43.xxx`）
4. 端口：`8888`

### Step 6：手机启动游戏

正常进入游戏，账号自动注册。

## 充值管理

浏览器访问 HTTP API 充值（手机连热点时）：

```powershell
# 给 role_id=1 的角色充值 6480 元宝
curl -X POST http://192.168.43.xxx:8080/api/recharge `
  -H "Content-Type: application/json" `
  -d '{"role_id":1,"amount":64800,"item_id":1001,"item_count":6480}'
```

或通过浏览器访问：
- 充值: `POST http://192.168.43.xxx:8080/api/recharge`

## CDK 礼包码管理

### 内置 CDK（可直接在游戏内兑换）

| CDK 码 | 内容 |
|--------|------|
| `VIP888` | 元宝×10, 道具2001×1, 道具3001×5 |
| `FL555` | 元宝×5, 道具3001×2 |
| `GIFT999` | 元宝×50, 道具2001×5, 道具4001×3 |

游戏内 → 礼包系统 → 输入 CDK 码兑换

### 创建新的 CDK

```powershell
curl -X POST http://192.168.43.xxx:8080/api/cdk/create `
  -H "Content-Type: application/json" `
  -d '{"code":"MYGIFT","items":[[1001,100],[2001,5]],"max_use":50}'
```

### 查看所有 CDK

```
GET http://192.168.43.xxx:8080/api/cdk/list
```

## 协议支持状态 (2026-09-19)

| 协议 | 状态 | 说明 |
|------|------|------|
| 255_1 (登录) | ✅ | 自动注册/密码验证 |
| 255_2 (创建角色) | ✅ | 名字/性别/服务器 |
| 255_3 (心跳) | ✅ | 双向心跳 |
| 255_4 (角色列表) | ✅ | 返回角色数组 |
| 255_5 (进入游戏) | ✅ | 角色验证+初始化 |
| 255_9 (Ping) | ✅ | Pong 回复 |
| 0_1 (玩家数据) | ✅ | 角色信息+初始属性 |
| 0_2 (时间同步) | ✅ | 服务端时间返回 |
| 254_39 (初始化开始) | ✅ | 触发初始化序列 |
| 254_40 (初始化结束) | ✅ | 进入游戏主界面 |
| 254_42 (属性变化) | ✅ | 双端同步 |
| 254_77 (连接确认) | ✅ | 连接握手 |
| 254_82 (系统配置) | ✅ | 配置下发 |
| 254_84 (进入场景) | ✅ | 场景坐标下发 |
| 254_115/116 (时间配置) | ✅ | 系统数据 |
| 15_1 (充值面板) | ✅ | 6 档充值选项 |
| 15_2 (发起充值) | ✅ | 直接成功 |
| 15_3 (确认到账) | ✅ | 发放元宝 |
| 15_31 (CDK兑换) | ✅ | 礼包码验证发放 |
| 15_41 (累计充值) | ✅ | 查询返额 |
| 15_51/52/53 (礼包) | ✅ | 基础空桩 |
| 其他协议 | ⬜ | 等待添加 |

## 常见问题

### Q: 登录提示"服务器连接超时"
A: 检查 `TCP_HOST` 是否为笔记本的实际 IP，防火墙是否放行了 9003 端口。

### Q: 创建角色失败
A: 检查数据库 `roles` 表，确认没有同名角色。清空数据库可删除 `server/private_server.db`。

### Q: 充值不到账
A: 检查 HTTP 充值接口返回，查看 `TCPServer` 日志是否收到 `15_3` 协议。