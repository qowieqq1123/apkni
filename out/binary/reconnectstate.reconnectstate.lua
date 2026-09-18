













reconnectState=appLifecycle({name='reconnectState'})



local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
reconnectState.isReconneting=false
reconnectState.waitResueGame=false
reconnectState.reconnetNum=0
local _maxReconnetNum=3

local _ignoreLookup={}

local _fastTime=-1
local _lastLoginStamp
local _canReConnect=true
local _isLeaveState=false
local _enterAppPauseTime=0

reconnectState.backToLoginTime=3600*4

function reconnectState:onAppStart()

end
function reconnectState:onAppPause()
_enterAppPauseTime=os.time()
loggerUtil.log('reconnectState onAppPause',_enterAppPauseTime)
end

function reconnectState:onAppResume()
local curTime=os.time()
loggerUtil.log('reconnectState onAppResume',curTime,curTime-_enterAppPauseTime,socketManager.connecting,LuaApplication.state==gameState)
if socketManager.connecting==false then
socketManager:closeDialogue()
reconnectState:stop()

if(curTime-_enterAppPauseTime)>reconnectState.backToLoginTime and LuaApplication.state==gameState then
loginControl:doLoginOutByDisconnect()
else
if not loginModel:isOtherLogin()then
reconnectState:tryAgain()
end
end

end
end
function reconnectState:onAppQuit()

end

function reconnectState:tryAgain()
if loginModel:isOtherLogin()then
loggerUtil.log('正在展示被顶号，无法重连')
return
end
timer.pauseAll(false)
reconnectState:tryReconnect()
self:startRetryReConnectTimer()
end


function reconnectState:tryReconnect()
loggerUtil.log('尝试重连')
local inGame=LuaApplication.state==gameState
if not inGame then
reconnectState:stop()
loggerUtil.log('不在gamestate不能重连')
return
end
if reconnectState.isReconneting then
reconnectState.reconnetNum=reconnectState.reconnetNum+1
end
loggerUtil.log('重连次数：',reconnectState.reconnetNum)
if reconnectState.reconnetNum>_maxReconnetNum then
reconnectState.reconnetNum=0
self:stopRetryReConnectTimer()
socketManager:showDisConnectDialogue()
return
end

reconnectState.isReconneting=true
reconnectState.waitResueGame=true


UIManager:showWindow('UIReconnectWin')


if socketManager.connecting then
socketManager:Disconnect()
end

_isLeaveState=true
gameState:invokeLeaveState()

if deviceHelper.isRunNoneOrEditor()then

loginControl:connect_server(loginModel.server_ip,loginModel.server_port)
else
loginControl:requestLogin()
end
end


function reconnectState:setEnoughServerInitProTag(tag)
self.serverInitProTag=tag
self.serverInitProTempTag=tag
end

function reconnectState:flushServerInitProTempTag()
self.serverInitProTempTag=self.serverInitProTag
end

function reconnectState:resumeGameByServerPro(servertype)
if self.serverInitProTempTag==nil then
return servertype==eInitProType.eLocal
end
if self.serverInitProTempTag==0 and servertype==eInitProType.eLocal then
return true
end


local old=self.serverInitProTempTag
self.serverInitProTempTag=mathHelper.clrbit(self.serverInitProTempTag,servertype)
if old==self.serverInitProTempTag then return false end
return self.serverInitProTempTag==0
end

function reconnectState:isReconnect()
return reconnectState.isReconneting or
reconnectState.waitResueGame
end

function reconnectState:isDisConnectOrReconnect()
return not socketManager.connecting or reconnectState:isReconnect()
end


function reconnectState:giveupReconnect()
reconnectState.isReconneting=false
reconnectState.waitResueGame=false
UIManager:closeWindow('UIReconnectWin')
end


function reconnectState:reconnectSuccess()
local _roleid=loginHelper.getActorID()
local time_str=uint64.new(os.time())
UICreateRoleController:requreEnterGame(_roleid,time_str,1)

end


function reconnectState:reconnectFail()
loginModel.isLogin=false
reconnectState:leave()
UIManager:closeWindow('UIReconnectWin')
socketManager:Disconnect()
LuaApplication.changeState(loginState)
end


function reconnectState:reconnetEnd()
reconnectState.waitResueGame=false
UIManager:closeWindow('UIReconnectWin')

gameState:invokeEnterState()
reconnectState:resueGame()

updateControl.checkUpdate()
end


function reconnectState:resueGame()
if not reconnectState.isReconneting then return end
reconnectState.isReconneting=false
reconnectState.waitResueGame=true
gameState:onStartReconnect()
if reconnectConfig.needCloseUI()then
UIDialogManager.closeAll()



xpcall(function()
baseFullScreenUI:closeAllActiveWindow()
end,function(err)
logErr(FMT.fmt('reconnectState resueGame err err:{0}',err))
end)
end
local version=_GetResourceVersion()
socketManager:send_254_37(version)
end




function reconnectState:onResueGame(servertype)
if not reconnectState:resumeGameByServerPro(servertype)then return end
reconnectState:flushServerInitProTempTag()

local waitResueGame=reconnectState.waitResueGame
if waitResueGame then
reconnectState.waitResueGame=false

end
reconnectState:leave()
_isLeaveState=false
if waitResueGame then
gameState:windowReConnection()
gameState:onReConnection()
mainControl:jumpMain()
gameState:onOpenView(true)
end
return waitResueGame
end


function reconnectState:onLostConnection()
reconnectState.lostConnectStamp=os.time()
if mainControl:isWaitSceneChange()then
reconnectState:setReLogin()
end
end

function reconnectState:setReLogin()
_canReConnect=false
end


function reconnectState:stop()
reconnectState:leave()
UIManager:closeWindow('UIReconnectWin')
end

function reconnectState:enterState()
_isLeaveState=false
end

function reconnectState:isEnterState()
return _isLeaveState==false
end


function reconnectState:isReconnectLeaveState(name)
if _isLeaveState==true then

if name and reconnectConfig.ignoreNotFresh(name)then return false end
return true
end
return false
end

function reconnectState:leave()
reconnectState.isReconneting=false
reconnectState.waitResueGame=false
reconnectState.reconnetNum=0
_canReConnect=true

self:stopRetryReConnectTimer()
loggerUtil.log('退出重连')
end


function reconnectState:startRetryReConnectTimer()
self:stopRetryReConnectTimer()
self.retryTimer=timer:new()
self.retryTimer:start(5,function()
if reconnectState.isReconneting then
loggerUtil.log('正在进行重连:',socketManager.connecting)
if not socketManager.connecting then
reconnectState:tryReconnect()
end
end


end)
end

function reconnectState:stopRetryReConnectTimer()
if self.retryTimer then
self.retryTimer:cancel()
end
self.retryTimer=nil
end















































