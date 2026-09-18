







socketManager=appLifecycle()
local _ts=serializeHelper.serialize
local _msg=CS.MessageInterface
local path='config/protocol/protocols.bytes'
local _netPacketRecvHandler={}
local _notifyHandler={}
local _notifyCntHandler={}
local gameInterface=CS.GameInterface


local _CS_InitNetWorkProtocolParser=CS.NetworkHelper.InitNetWorkProtocolParser
local _CS_Disconnect=CS.NetworkHelper.Disconnect
local _CS_Connect=CS.NetworkHelper.Connect
local _CS_SetOnSocketCommunicateDelegate=CS.NetworkHelper.SetOnSocketCommunicateDelegate
local _CS_SetOnSocketErrorEventDelegate=CS.NetworkHelper.SetOnSocketErrorEventDelegate
local _CS_SetOnSocketTimeoutDelegate=CS.NetworkHelper.SetOnSocketTimeoutDelegate
local _CS_SendNetPacket=CS.SendNetPacket
local _CS_SendNetPacket_ORG=CS.SendNetPacket
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
AllowReconnect=true

function socketManager:onAppStart()
self.lastDisconnectTime=0


_CS_InitNetWorkProtocolParser(path)
local showdata=
{
type='UIDialougeHighest',
}
socketManager.errorDialog=UIDialogManager.newDialog(showdata)
local function OnSocketConnectDelegate()

end

local function OnSocketCommunicateDelegate()
loggerUtil.log('连上服务器：',loginModel.userid)

socketManager.connecting=true
loginControl:loginServer()
loginControl:stopConnectTimer()
end

local function OnSocketErrorEventDelegate(typo,codeStr,err)

local connecting=socketManager.connecting
loggerUtil.log('断开连接：',typo,codeStr,err,LuaApplication.state.name)
if not loginControl.logined then
loginControl.logined=true
logPoint.UploadLog(logPoint.logExtType.connectSocketFail,typo)
end
socketManager:onDisConnect(typo,codeStr,err)
end





















































_CS_SetOnSocketCommunicateDelegate(OnSocketCommunicateDelegate)
_CS_SetOnSocketErrorEventDelegate(OnSocketErrorEventDelegate)










end

function socketManager:onDisConnnectCommon(typo,codeStr,err)
socketManager.connecting=false
initProControl.onSocketError()
loginControl:resetBuildConnectFlag()
reconnectState:onLostConnection()
local inGame=LuaApplication.state==gameState
if inGame then
gameState:onLostConnection()
end
gameState:windowLostConnection()
end

function socketManager:onDisConnect(typo,codeStr,err)
if deviceHelper.isRunWebGL()or webGLHelper:checkNetProtocolType(1)then
socketManager:onDisConnectWebGL(typo,codeStr,err)
else
socketManager:onDisConnectNormal(typo,codeStr,err)
end
end

function socketManager:onDisConnectNormal(typo,codeStr,err)

socketManager:onDisConnnectCommon(typo,codeStr,err)

local inGame=LuaApplication.state==gameState
if loginModel:isOtherLogin()then
loggerUtil.log('正在展示被顶号')
elseif UIManager:isActive('UILoading')then
loggerUtil.log('UILoading时断开')
socketManager:showBackDialogue()
elseif not inGame then
loggerUtil.log('重连 不在gamestate')
socketManager:showBackDialogue()
else
if UIManager:isActive('UILogin')then
loggerUtil.log('登陆界面断开')
socketManager:showBackDialogue()
elseif deviceHelper.isRunEditor()then
loggerUtil.log('编辑器断开')
socketManager:showDisConnectDialogue()
elseif codeStr=='SocketError'then
loggerUtil.log('重连 被挤下线')
loginModel:setOtherLogin(true)
socketManager:showBackDialogue()
else
reconnectState:tryAgain()
end
end
end















function socketManager:onDisConnectWebGL(typo,codeStr,err)
if webGLHelper:isRunDouYinNative()or webGLHelper:isRunDouYin()or webGLHelper:isRunHuaWeiMiniGame()then
if LuaApplication.state==loginState then
loggerUtil.log('未进游戏不显示弹窗')
return
end
end

if not webGLHelper:isRunWebGL()and webGLHelper:checkNetProtocolType(1)then
local ctime=Time.unscaledTime
local dtime=ctime-self.lastDisconnectTime

if math.abs(dtime)<0.1 then
return
end
self.lastDisconnectTime=ctime
else
if err~=''and err~='interrupted'then
loggerUtil.logFMT('websock返回错误消息{0}，不处理！',err)
return
end
end

socketManager:onDisConnnectCommon(typo,codeStr,err)

local inGame=LuaApplication.state==gameState
if loginModel:isOtherLogin()then
loggerUtil.log('正在展示被顶号')
elseif UIManager:isActive('UILoading')then
loggerUtil.log('UILoading时断开')
socketManager:showBackDialogue()
elseif not inGame then
loggerUtil.log('重连 不在gamestate')
socketManager:showBackDialogue()
else
if UIManager:isActive('UILogin')then
loggerUtil.log('登陆界面断开')
socketManager:showBackDialogue()
elseif deviceHelper.isRunEditor()then
loggerUtil.log('编辑器断开')
socketManager:showDisConnectDialogue()
else
reconnectState:tryAgain()
end
end
end

function socketManager:showBackDialogue()
local errorDialog=socketManager.errorDialog
errorDialog.title='提示'
errorDialog.content='很抱歉，服务器连接异常'
errorDialog.oktext='确定'
errorDialog.canceltext=nil
errorDialog.allowclickBG=false
errorDialog.checkOkCallBackRet=false
errorDialog.okcallback=function()

loginControl:doLoginOutByDisconnect()
end
errorDialog.closecallback=function()

loginControl:doLoginOutByDisconnect()
end
errorDialog:show()
end

function socketManager:showDisConnectDialogue()
if LuaApplication.state==gameState then
local errorDialog=socketManager.errorDialog
errorDialog.title='提示'
errorDialog.allowclickBG=false

if reconnectState.isReconneting then
errorDialog.content='重新连接服务器失败，请检查网络环境'
else
if AllowReconnect then
errorDialog.content='您已断开链接，是否重新连接服务器？'
else
errorDialog.content='您已断开链接，请重新登录'
end
end

if AllowReconnect then
errorDialog.oktext='重新连接'
errorDialog.checkOkCallBackRet=true
errorDialog.okcallback=function()


reconnectState:tryAgain()
return true
end

errorDialog.canceltext='返回登录'
errorDialog.cancelcallback=function()

if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end
errorDialog.closecallback=function()

if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end
else
errorDialog.oktext='返回登录'
errorDialog.okcallback=function()
if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end
end
errorDialog:show()

else
socketManager:showBackDialogue()
end
end

function socketManager:closeDialogue()
if socketManager.errorDialog then
socketManager.errorDialog:closeOK()
end
end

function socketManager:onAppQuit()
end


function socketManager:Connect(addr,port)

_CS_Connect(addr,port,0)
end


function socketManager:Disconnect()

_CS_Disconnect(0)
socketManager.connecting=false
loginControl:resetBuildConnectFlag()
loginControl:stopConnectTimer()
loggerUtil.log('主动断开连接')
end


function socketManager:isConneting()
return socketManager.connecting==true
end









































function socketManager:send(sid,pid,...)
if initProControl.canReq(sid,pid,...)then



_CS_SendNetPacket(sid,pid,0,...)
end
end

function socketManager:sendempty(sid,pid)
if initProControl.canReq(sid,pid)then



_CS_SendNetPacket(sid,pid,0)
end
end

function socketManager:sendTable(sid,pid,targs)
if initProControl.canReq(sid,pid,targs)then



_CS_SendNetPacket(sid,pid,0,targs)
end
end

function socketManager:register_receiver(sid,pid,func)
local cc=_netPacketRecvHandler[sid]
if not cc then
cc={}
_netPacketRecvHandler[sid]=cc
end

assert(func,string.format('sid %s, pid %s function is unavaiable',sid,pid))
assert(cc[pid]==nil,string.format('pid already registered %d %d',sid,pid))

cc[pid]=func
end

function OnRecvPacket(sid,pid,...)









local sys=_netPacketRecvHandler[sid]
if sys==nil then
logErr(string.format('no system handler for %d %d',sid,pid))
return
end


if verifyManager:checkSkipActivity(sid,pid)then
return
end

local func=sys[pid]
if func==nil then




if appUtils.enableDebug then
logErr(FMT.fmt("没有定义协议【{0}:{1}】的处理函数",sid,pid))
return
end






return
end
func(...)
socketManager:invokeNotify(sid,pid,...)
end

function socketManager:addNotify(sid,pid,func,cnt)
if cnt and cnt<=0 then cnt=nil end
local isTemp=false
if _notifyHandler[sid]==nil then
_notifyHandler[sid]={}
isTemp=true
end
if _notifyHandler[sid][pid]==nil then
_notifyHandler[sid][pid]={}
isTemp=true
end
local cTable=_notifyHandler[sid][pid]
for i,v in ipairs(cTable)do
if v[1]==func then
return
end
end
cTable[#cTable+1]={func,cnt}
end

function socketManager:removeNotify(sid,pid,func)
if _notifyHandler[sid]==nil then return end
if _notifyHandler[sid][pid]==nil then return end
local cTable=_notifyHandler[sid][pid]
for i,v in ipairs(cTable)do
if v[1]==func then
table.remove(cTable,i)
return
end
end
end

function socketManager:invokeNotify(sid,pid,...)
if _notifyHandler[sid]==nil then return end
if _notifyHandler[sid][pid]==nil then return end
local temp={}
for i,info in ipairs(_notifyHandler[sid][pid])do
local func=info[1]
func(...)


local cnt=info[2]
if cnt then
cnt=cnt-1
if cnt<=0 then
temp[#temp+1]=i
end
end
end

if#temp>0 then
for i=#temp,1,-1 do
_notifyHandler[sid][pid][temp[i]]=nil
end
end
end


local _rep=string.rep
function Serialize(o,nl,tgap,isnl)
local table_concat=table.concat
local string_find=string.find
local string_format=string.format
local t={}

nl=nl or'\n'
tgap=tgap or'\t'
isnl=isnl or false
local function serialize(o,depth)
assert(depth<255,'serialize to deep')
local tab=_rep(tgap,depth)
if type(o)=='number'then
t[#t+1]=tostring(o)
isnl=false
elseif tonumber(o)then
if string_find(o,'+')then
t[#t+1]=string_format('%q',o)
else
t[#t+1]=tostring(o)
end
isnl=false
elseif type(o)=='string'then
t[#t+1]=string_format('%q',o)
isnl=false
elseif type(o)=='table'then
t[#t+1]='{'
t[#t+1]=nl
for k,v in pairs(o)do
if type(k)=='number'then
t[#t+1]=string_format('%s [%s]=',tab,k)
else
t[#t+1]=string_format('%s [\'%s\']=',tab,k)
end
serialize(v,depth+1)
if not isnl then
t[#t+1]=','
t[#t+1]=nl
end
end
t[#t+1]=tab
t[#t+1]='}'
t[#t+1]=','
t[#t+1]=nl
isnl=true
elseif type(o)=='boolean'then
if o then
t[#t+1]='true'
else
t[#t+1]='false'
end
isnl=false
else
t[#t+1]=tostring(o)
isnl=false
end
end
serialize(o,0)

return table_concat(t)
end

local printProtol=_AppConfig_GetBool('printProtcolData',false)
local showDebugTCP=_AppConfig_GetBool('showDebugTCP',false)
if printProtol or showDebugTCP then
local printProtocol=Debugger.Log
socketManager.filterProtocol={}
if printProtol==false then
printProtocol=function(...)
end
end
local sendFunc=socketManager.send
socketManager.send=function(self,sid,pid,...)
printProtocol(string.format('_pdx_ Send %d_%d %s',sid,pid,Serialize({...})))
sendFunc(self,sid,pid,...)
end

local sendEmptyFunc=socketManager.sendempty
socketManager.sendempty=function(self,sid,pid)
printProtocol(string.format('_pdx_ Send %d_%d',sid,pid))
sendEmptyFunc(self,sid,pid)
end

local sendTableFunc=socketManager.sendTable
socketManager.sendTable=function(self,sid,pid,...)
printProtocol(string.format('_pdx_ Send %d_%d %s',sid,pid,Serialize({...})))
sendTableFunc(self,sid,pid,...)
end






local oldOnRecvPacket=OnRecvPacket
printProtocol('_pdx_ OnRecvPacket %d_%d %s')
OnRecvPacket=function(sid,pid,...)
printProtocol(string.format('_pdx_ OnRecvPacket %d_%d %s',sid,pid,Serialize({...})))
local sysProtocol=socketManager.filterProtocol[sid]
if sysProtocol~=nil and sysProtocol[pid]then
return
end
oldOnRecvPacket(sid,pid,...)
end





end

function socketManager.filterRecvFunc(sid,pid,filter)
local sysProtocol=socketManager.filterProtocol[sid]or{}
sysProtocol[pid]=filter
socketManager.filterProtocol[sid]=sysProtocol
end

function OnPrintPacket(sid,pid,data)



end

function TestPacket()
local packet=CS.CreateNetPacket(1,5,0,{1,2,2,{{int64.new(123),0,0},{int64.new(123),1,1}}})
packet:Unwind()
CS.NetworkHelper.PrintSendPack(1,5,packet)
end

local repeateSendProtcolTimes=_AppConfig_GetInt('repeateSendProtcolTimes',0)
function socketManager.enaleRepeatSendProtocol(repeatTimes)
repeateSendProtcolTimes=repeatTimes
if repeateSendProtcolTimes>0 then
logErr(FMT.fmt('开启重复发送协议模式,每条协议重复发送{0}次',repeateSendProtcolTimes))
_CS_SendNetPacket=function(sid,pid,arg,...)
local sys=repeatSendProtocolFilter[sid]
if sys~=nil and(sys.all or sys[pid]~=nil)then
_CS_SendNetPacket_ORG(sid,pid,arg,...)
else
for i=1,repeateSendProtcolTimes do
_CS_SendNetPacket_ORG(sid,pid,arg,...)
end
end
end
else
_CS_SendNetPacket=_CS_SendNetPacket_ORG
end
end

function socketManager.getProtocolSendRempeatTimes()
return repeateSendProtcolTimes
end

socketManager.enaleRepeatSendProtocol(repeateSendProtcolTimes)
























































