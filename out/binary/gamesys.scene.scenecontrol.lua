












sceneControl=gameState.addListener({})

local _LoadScene=CS.MapHelper.LoadScence
local _msg_handle=CS.MessageInterface
local _msg_type=GlobalEventType

local _customID=0
local genCustomID=function()
_customID=_customID+1
return FMT.fmt("s_{0}",_customID)
end

local _loadingState=eSceneLoadState.None
local _loadInfoArray={}
local _enterInfo={}
local _enterFlag={}
local _isEnterScene=false



function sceneControl:onEnterState(isReconnect)
sceneControl:init(isReconnect)
_msg_handle.AddEventListener(_msg_type.EVT_ACTIVE_SCENE_LOADED_DONE,sceneControl.onLoadSceneFinish)
end


function sceneControl:onLeaveState(...)
_msg_handle.RemoveEventListener(_msg_type.EVT_ACTIVE_SCENE_LOADED_DONE,sceneControl.onLoadSceneFinish)
end

function sceneControl:onProtocolReq()
if#_loadInfoArray>0 and initProControl.isDone()then
for _,args in ipairs(_loadInfoArray)do
sceneControl.onLoadSceneFinish(args)
end
_loadInfoArray={}
end
end

function sceneControl:init(isReconnect)
if isReconnect then return end
_loadingState=eSceneLoadState.None
self.sceneInfo=nil
self.loadingInfo=nil
_loadInfoArray={}
_enterInfo={}
_enterFlag={}
end

function sceneControl:isLoadingState()
return _loadingState==eSceneLoadState.Loading
end

function sceneControl:getLoadingState()
return _loadingState
end


function sceneControl:setLoadCallBack(onLoadStart,onLoadFinish)
local cahceCallback={}
cahceCallback.onLoadStart=onLoadStart
cahceCallback.onLoadFinish=onLoadFinish
self.cahceCallback=cahceCallback
end


function sceneControl:setEnterArgs(args)
_enterInfo=args
end

function sceneControl:startLoading(args)
if _loadingState==eSceneLoadState.Loading then

return false
end
local sceneId=args.sceneId

local sceneCfg=cfg_sceneconfig_get(sceneId)
local abName=sceneCfg.abname
local sceneName=sceneCfg.assetname




args.abName=abName
args.sceneName=sceneName

local loadInfo=sceneControl:createLoadInfo(args)
self.cahceCallback={}
self.loadingInfo=loadInfo
UIManager:showWindow('UILoading',loadInfo)
_loadingState=eSceneLoadState.Loading
_isEnterScene=false

return true
end

function sceneControl:createLoadInfo(args)
local startCall=args.startCall
local endCall=args.endCall
local closeLoading=args.closeLoading
if closeLoading==nil then closeLoading=true end

local cahceCallback=self.cahceCallback or{}
local loadInfo={}
loadInfo.id=genCustomID()
loadInfo.abName=args.abName
loadInfo.sceneName=args.sceneName
loadInfo.closeLoading=closeLoading

loadInfo.onLoadStart=function()
if cahceCallback.onLoadStart then
cahceCallback.onLoadStart()
end
if startCall then
startCall()
end

sceneControl:loadScene()
end

loadInfo.onLoadFinish=function()
if cahceCallback.onLoadFinish then
cahceCallback.onLoadFinish()
end
if endCall then
endCall()
end

resourceUtility.releaseAll()
resourceUtility.clearAllCache(false)
resourceUtility.clearPoolCache()
notifySystem:postNotify(notifyConfig.loadingEnd)
end
return loadInfo
end

function sceneControl:setCurrentSceneInfo(sceneName,loadMode,customID)
local sceneInfo={}
sceneInfo.sceneName=sceneName
sceneInfo.loadMode=loadMode
sceneInfo.customID=customID
self.sceneInfo=sceneInfo
end

function sceneControl:getCurrentSceneInfo()
return self.sceneInfo
end

function sceneControl:loadScene()
assert(self.loadingInfo,'没有加载场景的信息')
LuaApplication.gc_collect()
local loadInfo=self.loadingInfo
loadControl.startLoadScene(loadInfo)

CS.MapHelper.LoadScence(loadInfo.abName,loadInfo.sceneName,true,0,loadInfo.id)
end

function sceneControl.onLoadSceneFinish(args)
LuaApplication.gc_collect()
if not initProControl.isDone()then
_loadInfoArray[#_loadInfoArray+1]=args
else
local sceneName=args[0]
local loadMode=args[1]
local customID=args[2]
loadControl.onLoadedScene(sceneName)
sceneControl:setCurrentSceneInfo(sceneName,loadMode,customID)
_loadingState=eSceneLoadState.None
local loadingInfo=sceneControl.loadingInfo
if loadingInfo and loadingInfo.id==customID then
if loadingInfo.onLoadFinish~=nil then
loadingInfo.onLoadFinish()
end
sceneControl.loadingInfo=nil
end
end
end

function sceneControl:closeLoading(delayTime,onCloseLoading)
delayTime=delayTime or 0
if self.delayCloseTimer~=nil then
self.delayCloseTimer:cancel()
self.delayCloseTimer=nil
end
loadingControl.playEndProgress(delayTime)
if delayTime>0 then
local delayCloseLoading=function()
UIManager:callWindowFunc('UILoading','endAni')
self.delayCloseTimer=nil
if onCloseLoading~=nil then
onCloseLoading()
end
sceneControl.onEnterFinish()
end
self.delayCloseTimer=timer.new()
self.delayCloseTimer:start(delayTime,delayCloseLoading,1)
else
UIManager:callWindowFunc('UILoading','endAni')
sceneControl.onEnterFinish()
end
loadControl.stoptimer()
end


function sceneControl.onEnterFinish()
if _enterInfo then
local enterCall=_enterInfo.enterCall
if enterCall then
enterCall()
end
local sceneType=_enterInfo.sceneType
if sceneType then
gameState:onEnterScene(sceneType,_enterFlag[sceneType]==nil,next(_enterFlag)==nil)
logPoint.UploadLog(logPoint.logType.enterGameSuccess)
_enterFlag[sceneType]=true
end
end
_isEnterScene=true
_enterInfo=nil
end

function sceneControl:isEnter()
return _isEnterScene
end
