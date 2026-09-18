require'lua.anyTable'
appLifecycle=function()return{}end
LoadingLogic={}

require'tolua.launcher.main'
if enable_strict then
strict_if_strict(false)
end
function LuaApplication.SetRightBottomText(text)
logInfo(text)
end

local _msg_handle=CS.MessageInterface
require'tolua.launcher.simple_class'
require('tolua.launcher.enum')
local serverid=1
local serverip='10.10.4.241'
local serverport=9001
local account='test902'

function LuaApplication.start()


math.randomseed(os.time())
require('lua.network.__init')



local _CS_InitNetWorkProtocolParser=CS.NetworkHelper.InitNetWorkProtocolParser
local _CS_SetOnSocketCommunicateDelegate=CS.NetworkHelper.SetOnSocketCommunicateDelegate
local _CS_SetOnSocketErrorEventDelegate=CS.NetworkHelper.SetOnSocketErrorEventDelegate
local _CS_SetOnSocketTimeoutDelegate=CS.NetworkHelper.SetOnSocketTimeoutDelegate

_CS_InitNetWorkProtocolParser('config/protocol/protocols.bytes')

_CS_SetOnSocketCommunicateDelegate(function(...)

local sid=serverid;
local username=account;
local password='';
socketManager:send_255_1(tonumber(sid),tostring(username),tostring(password),0)
end)

_CS_SetOnSocketErrorEventDelegate(function(...)

logErr(...)
end)

socketManager:register_receiver(255,1,function(result_code)
if result_code==0 then
socketManager:send_255_4(serverid);
else
logErr(result_code)
end
end)

socketManager:register_receiver(255,4,function(account_id,role_num,roleArray,defualt)
defualt=defualt+1

if roleArray[defualt]then
local role=roleArray[defualt]
local role_id=role.id
LoadingLogic.RoleLevel=role.level;

local time_str=uint64.new(os.time())
local pfid=1

local udid=''
socketManager:send_255_5(role_id,time_str,pfid,udid,0,{})
end
end)
socketManager:Connect(serverip,serverport);
end
