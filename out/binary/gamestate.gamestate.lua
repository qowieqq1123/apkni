


































gameState=appLifecycle({name='gameState'})

local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _msg_handle=CS.MessageInterface
local _msg_type=GlobalEventType
local _listeners={}
local _listenerAddIndex={}
local _is_init=false;
local _ApplicationStateController=CS.ApplicationStateController
local _is_enter=false;
local _idx=0
local _lostStamp=0
local _getIdx=function()
_idx=_idx+1
return _idx
end

local _listenerType=
{
eOnEntertate=_getIdx(),
eOnLeavetate=_getIdx(),
eOnLostConnection=_getIdx(),
eOnReConnection=_getIdx(),
eOnAppStart=_getIdx(),
eOnAppPause=_getIdx(),
eOnAppResume=_getIdx(),
eOnPlayerCreate=_getIdx(),
eOnSystemInit=_getIdx(),
eOnProtocolReq=_getIdx(),
eOnProtocolReqKF=_getIdx(),
eOnProtocolLargeXJKF=_getIdx(),
eOnProtocolReqLarge3v3KF=_getIdx(),
eOnProtocolReqLargeZZSHKF=_getIdx(),
eOnEnterScene=_getIdx(),
eOnLeaveScene=_getIdx(),
eOnOpenView=_getIdx(),
eOnHandleErrData=_getIdx(),

eOnStartReconnect=_getIdx(),
}

local _listenerEventType=
{
[_listenerType.eOnEntertate]='onEnterState',
[_listenerType.eOnLeavetate]='onLeaveState',
[_listenerType.eOnLostConnection]='onLostConnection',
[_listenerType.eOnReConnection]='onReConnection',
[_listenerType.eOnAppStart]='onAppStart',
[_listenerType.eOnAppPause]='onAppPause',
[_listenerType.eOnAppResume]='onAppResume',
[_listenerType.eOnPlayerCreate]='onPlayerCreate',
[_listenerType.eOnSystemInit]='onSystemInit',
[_listenerType.eOnProtocolReq]='onProtocolReq',
[_listenerType.eOnProtocolReqKF]='onProtocolReqKF',
[_listenerType.eOnProtocolLargeXJKF]='onProtocolReqLargeXJKF',
[_listenerType.eOnProtocolReqLarge3v3KF]='onProtocolReqLarge3V3KF',
[_listenerType.eOnProtocolReqLargeZZSHKF]='onProtocolReqLargeZZSHKF',
[_listenerType.eOnEnterScene]='onEnterScene',
[_listenerType.eOnLeaveScene]='onLeaveScene',
[_listenerType.eOnOpenView]='onOpenView',
[_listenerType.eOnHandleErrData]='onHandleErrData',
[_listenerType.eOnStartReconnect]='onStartReconnect'
}
local _listenersOnState={}














local function reg(o)
for type,eventType in pairs(_listenerEventType)do
if o[eventType]then
if _listenersOnState[type]==nil then _listenersOnState[type]={}end
local listenerOnState=_listenersOnState[type]
listenerOnState[#listenerOnState+1]=o
end
end































end














function gameState.addListener(o)








_listeners[o]=true
_listenerAddIndex[#_listenerAddIndex+1]=o



if _is_enter then

if not o._is_onAppStart then
o._is_onAppStart=true

o:onAppStart()
end


o:onEnterState()
end

return o
end


function gameState:enter()
if _is_enter==true then return end
_msg_handle.AddEventListener(_msg_type.GSTATE_LOADSCENE_START,gameState.onLoadSceneStart)
_msg_handle.AddEventListener(_msg_type.GSTATE_LOADSCENE_FINISH,gameState.onLoadSceneFinish)

_ApplicationStateController.ChangeState(eApplicationState.eGame)
self:onEnterState()
local version=_GetResourceVersion()
socketManager:send_254_37(version)
mainControl:enter()
_is_enter=true
end

function gameState:leave()
if _is_enter==false then
return
end
timer.cancel_all()
_is_enter=false
_msg_handle.RemoveEventListener(_msg_type.GSTATE_LOADSCENE_START,gameState.onLoadSceneStart)
_msg_handle.RemoveEventListener(_msg_type.GSTATE_LOADSCENE_FINISH,gameState.onLoadSceneFinish)
self:onLeaveState()
end



function gameState:onInitProtocol(...)

local type=_listenerType.eOnProtocolReq
gameState.onInvokeListener(type,...)
end


function gameState:onInitProtocolKF(...)

local type=_listenerType.eOnProtocolReqKF
gameState.onInvokeListener(type,...)
end

function gameState:onInitProtocolLargeXJKF(...)

local type=_listenerType.eOnProtocolLargeXJKF
gameState.onInvokeListener(type,...)
end

function gameState:onInitProtocolLarge3v3KF(...)

local type=_listenerType.eOnProtocolReqLarge3v3KF
gameState.onInvokeListener(type,...)
end

function gameState:onInitProtocolLargeZZSHKF(...)

local type=_listenerType.eOnProtocolReqLargeZZSHKF
gameState.onInvokeListener(type,...)
end

function gameState:onStartReconnect(...)
local type=_listenerType.eOnStartReconnect
gameState.onInvokeListener(type,...)
end

function gameState:onHandleErrData(...)
local type=_listenerType.eOnHandleErrData
gameState.onInvokeListener(type,...)
end



function gameState:onEnterState(...)

timeEventController.init()
local type=_listenerType.eOnEntertate
gameState.onInvokeListener(type,...)

end


function gameState:onLeaveState(...)


local type=_listenerType.eOnLeavetate
if logPoint.checkHasRole then
logPoint.checkHasRole(true)
end
timer.pauseAll(true)
UIManager:setCloseing(true)
timeEventController.clear()
gameState.onInvokeListener(type,...)
UIManager:setCloseing(false)
mainViewsControl.onLeaveState()
jumpManager:onLeaveState()
downAssetManager:onLeaveState_()
fullScreenUI.closeActiveUI(false,false)
gameUtilityModel.clearPlotBatchConfig()
timer.pauseAll(false)
end

function gameState:invokeEnterState(...)

local type=_listenerType.eOnEntertate
timeEventController.init(true)
gameState.onInvokeListener(type,true)
end

function gameState:invokeLeaveState()

local type=_listenerType.eOnLeavetate
timeEventController.clear(true)
gameState.onInvokeListener(type,true)
end



function gameState:onReConnection()

local type=_listenerType.eOnReConnection
gameState.onInvokeListener(type,true)
end


function gameState:onLostConnection(...)
local type=_listenerType.eOnLostConnection
gameState.onInvokeListener(type,...)
_lostStamp=timeHelper.getServerShortTime()
end


function gameState:onPlayerCreate(...)
local type=_listenerType.eOnPlayerCreate
gameState.onInvokeListener(type,...)
end

function gameState:onSystemInit(...)
local type=_listenerType.eOnSystemInit
gameState.onInvokeListener(type,...)
end



function gameState:onEnterScene(...)
local type=_listenerType.eOnEnterScene
gameState.onInvokeListener(type,...)
end


function gameState:onLeaveScene(...)
local type=_listenerType.eOnLeaveScene
gameState.onInvokeListener(type,...)
end


function gameState:onOpenView(isReconnect)
local type=_listenerType.eOnOpenView
gameState.onInvokeListener(type,isReconnect)
end


function gameState:onAppStart()
for k,v in ipairs(_listenerAddIndex)do
reg(v)
end

local type=_listenerType.eOnAppStart
if _listenersOnState[type]==nil then _listenersOnState[type]={}end
for i,v in ipairs(_listenersOnState[type])do

v._is_onAppStart=true
v:onAppStart()





end

UnityEngine.Shader.DisableKeyword("_LUM_SCHEN_LIGHT");
UnityEngine.Shader.SetGlobalFloat("_SceneLightIntensity",0);
UnityEngine.Shader.SetGlobalColor("_SceneLightColor",Color.New(1,1,1,1));
end

function gameState:onAppPause()

local type=_listenerType.eOnAppPause
gameState.onInvokeListener(type)
end

function gameState:onAppResume()

local type=_listenerType.eOnAppResume
gameState.onInvokeListener(type)
end


function gameState:onAppQuit()

end






function gameState.onLoadSceneStart()

LuaApplication.gc_collect()
end


function gameState.onLoadSceneFinish()
LuaApplication.gc_collect()
end

function gameState.onInvokeListener(type,...)
if _listenersOnState[type]==nil then _listenersOnState[type]={}end
local eventType=_listenerEventType[type]
local args={...}
for i,v in ipairs(_listenersOnState[type])do
xpcall(function()
v[eventType](v,unpack(args))
end,function(err)
logErr(FMT.fmt('gameState InvokeListener type {0} err:{1}',type,err))
end)
end
end

function gameState.isEnter()
return _is_enter
end

function gameState.isLeaveState()
return not gameState.isEnter()or
not reconnectState:isEnterState()
end


function gameState:windowLostConnection()
xpcall(function()
UIManager:callAllWindowFunc('onLostConnectionEx')
UICloneObject.callAllFunction('onLostConnectionEx')
end,function(err)
logErr(FMT.fmt('gameState windowLostConnection err:{0}',err))
end)
end


function gameState:windowReConnection()
xpcall(function()
UIManager:callAllWindowFunc('onReConnectionEx')
UICloneObject.callAllFunction('onReConnectionEx')
end,function(err)
logErr(FMT.fmt('gameState windowReConnection err:{0}',err))
end)
end
