initProControl=gameState.addListener({})

eInitProType=
{
eLocal=0,
eKF=1,
eBigKF=2,
e3V3kF=3,
eZZSHkF=4,
}

local _cache={}
local _state
local _kfstate
local _largetkfxjstate
local _largekf3v3state
local _largekfZZSHstate
local _outNum=10
local _timer
local markReconnet
function initProControl:onAppStart(...)
socketManager:register_receiver(254,39,self.onInitStart)
socketManager:register_receiver(254,40,self.onInitEnd)
end

function initProControl:onEnterState()
_state=INIT_PRO_STATE.eUnStart
_kfstate=INIT_PRO_STATE.eUnStart
_largetkfxjstate=INIT_PRO_STATE.eUnStart
_largekf3v3state=INIT_PRO_STATE.eUnStart
_largekfZZSHstate=INIT_PRO_STATE.eUnStart
reconnectState:enterState()
end

function initProControl:onLeaveState(isReconnet)
markReconnet=nil
_state=INIT_PRO_STATE.eUnStart
_kfstate=INIT_PRO_STATE.eUnStart
_largetkfxjstate=INIT_PRO_STATE.eUnStart
_largekf3v3state=INIT_PRO_STATE.eUnStart
_largekfZZSHstate=INIT_PRO_STATE.eUnStart
_cache={}
if not isReconnet then
initProControl.stopTimer()
end
end

function initProControl.onInitStart(...)
_state=INIT_PRO_STATE.eDoing
_kfstate=INIT_PRO_STATE.eDoing
_largetkfxjstate=INIT_PRO_STATE.eDoing
_largekf3v3state=INIT_PRO_STATE.eDoing
_largekfZZSHstate=INIT_PRO_STATE.eDoing
notifySystem:postNotify(notifyConfig.initPro,_state)
end

function initProControl.onInitEnd(servertype)

if servertype==eInitProType.eLocal then
gameState:onHandleErrData()
initProControl.setInitEnd(servertype)
local isReconnet=reconnectState.waitResueGame
markReconnet=isReconnet
gameState:onInitProtocol(isReconnet)
loginLocal.fresh_role_list()
elseif servertype==eInitProType.eKF then
initProControl.setInitEnd(servertype)
local isReconnet=markReconnet
if isReconnet==nil then
isReconnet=false
end
gameState:onInitProtocolKF(isReconnet)
elseif servertype==eInitProType.eBigKF then
initProControl.setInitEnd(servertype)
local isReconnet=markReconnet
if isReconnet==nil then
isReconnet=false
end
gameState:onInitProtocolLargeXJKF(isReconnet)
elseif servertype==eInitProType.e3V3kF then
initProControl.setInitEnd(servertype)
local isReconnet=markReconnet
if isReconnet==nil then
isReconnet=false
end
gameState:onInitProtocolLarge3v3KF(isReconnet)
elseif servertype==eInitProType.eZZSHkF then
initProControl.setInitEnd(servertype)
local isReconnet=markReconnet
if isReconnet==nil then
isReconnet=false
end
gameState:onInitProtocolLargeZZSHKF(isReconnet)
end
reconnectState:onResueGame(servertype)
end

function initProControl.onSocketError()
_state=INIT_PRO_STATE.eUnStart
_kfstate=INIT_PRO_STATE.eUnStart
_largetkfxjstate=INIT_PRO_STATE.eUnStart
_largekf3v3state=INIT_PRO_STATE.eUnStart
end

function initProControl.setInitEnd(servertype)
if servertype==0 then
_state=INIT_PRO_STATE.eDone
elseif servertype==1 then
_kfstate=INIT_PRO_STATE.eDone
elseif servertype==2 then
_largetkfxjstate=INIT_PRO_STATE.eDone
elseif servertype==3 then
_largekf3v3state=INIT_PRO_STATE.eDone
end
end

function initProControl.isDoneKF()
return _kfstate==INIT_PRO_STATE.eDone
end

function initProControl.isDone()
return _state==INIT_PRO_STATE.eDone
end

function initProControl.isDoneLargeKFXJ()
return _largetkfxjstate==INIT_PRO_STATE.eDone
end

function initProControl.isDoneLargeKF3v3()
return _largekf3v3state==INIT_PRO_STATE.eDone
end

function initProControl.isDoing()
return _state==INIT_PRO_STATE.eDoing
end

function initProControl.canReq(sid,pid,...)



if initProConfig.ignore(sid,pid)then return true end
if not initProControl.isDone()then
_cache[#_cache+1]={sid,pid,{...}}



initProControl.startTimer()
return false
end
return true
end

local _tick=function()
if not initProControl.isDone()then return end
if#_cache==0 then
initProControl.stopTimer()
return
end
local len=math.min(#_cache,_outNum)
while len>0 do
local v=table.remove(_cache,1)
local sid=v[1]
local pid=v[2]
local args=v[3]



CS.SendNetPacket(sid,pid,0,unpack(args))
len=len-1



end
end

function initProControl.send(v)
local sid=v[1]
local pid=v[2]
local args=v[3]



CS.SendNetPacket(sid,pid,0,unpack(args))
end

function initProControl.startTimer()
if _timer then
return
end
_timer=FrameTimer.New(_tick,0,-1)
_timer:Start()
end

function initProControl.stopTimer()
if _timer then
_timer:Stop()
end
_timer=nil
end
