









local _timeoutInterval=15
local _delayLoading=1
local _enterCameraMove=nil
local _enterCameraMoveEase=DG.Tweening.Ease.Linear
local _enterParam=nil
local _finishParam={}
local _closePanel={
'UIWorldHUDWin',
'UIWorldSymbolWin',
'UIWorldWin',
'UIWorldFunctionButtonWin',
'UIWorldUnitListWin2',
'UIWorldExperienceWin',
'UIMysteryListWin',
'UIWorldMonsterListWin',
'UIWorldXiuZhenJiaZuListWin',
'UISystemZongMenListWin',
'UIWorldNPCListWin',
'UIMysteryEnterWin',
'UINPCInteractWin',
'UIWorldBossWin',
'UIWorldXiuZhenJiaZuInfoWin',
'UIWorldBigBossActivityChallengeWIn',
'UIWeekUnitListWin',
'UIMysteryEnterZiYuanWin',
'UIChuanSongZhenBlockWin',
'UISystemZongMenOutgoerInteractWin',
}
local _this=worldController
















function worldController:enterWorld(id,args)
if sceneControl:getLoadingState()==eSceneLoadState.Loading then
return false
end
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,id)
if worldCfg==nil then
loggerUtil.logErrFMT("进入大世界失败，没有对应配置的大世界:{0}",id)
return false
end
if mainControl:enterWorld({id,args})then
self:postEnterMessage(eWorldEnterPhase.StartEnter,id)
return true
end
return false
end


function worldController:onLoadScene(id,args)

local world=id or worldBlockModel:getDefaultWorld()
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local sceneId=worldCfg.sceneid
sceneControl:startLoading({sceneId=sceneId,closeLoading=false})
end


function worldController:onIntoScene(id,args)

worldModel.world=id or worldBlockModel:getDefaultWorld()
mainViewsControl.onChangeSceneMap(eSceneType.eWorld,id)
_enterParam=args or{}
_finishParam={}
self:startTimeOutCheck()
self:postEnterMessage(eWorldEnterPhase.SceneReady,id)
self:freezeCameraControl()

_this:initView()
worldController:openNeedPanel()
if _this:checkNeedPanels()then
_this:onEnterReadyPanel()
end
end


function worldController:onEnterReadyPanel()
self:postEnterMessage(eWorldEnterPhase.PanelReady,worldModel.world)
baseFullScreenUI:openWindowOnEnterScene()

self:doEnterDataInit()

self:doEnterAnimation()
end


function worldController:doEnterAnimation()
_enterCameraMove={}

if _enterParam.mystery then
self:resumeCameraControl()
MysteryController:enterMysteryFB(worldModel.enterMystery)
self:openCloud(0)
return
elseif _enterParam.block then
self:resumeCameraControl()
local world=worldModel.world
local block=_enterParam.block
worldTaskController:fakeExperienceTask(world,block)
worldExperienceController:enterExperience(true)
self:openCloud(0)
return
elseif _enterParam.position then
self:setCameraPosition(_enterParam.position,true,nil)
self:openCloud(_delayLoading)
return
elseif _enterParam.lookAt then
self:lookAtPosition(_enterParam.lookAt,nil,true)
self:openCloud(_delayLoading)
return
elseif _enterParam.lookAtUnit then
local paramType=type(_enterParam.lookAtUnit)
if paramType=='table'then
for i,v in ipairs(_enterParam.lookAtUnit)do
if self:haveUnit(v)then
self:lookAtUnit(v,nil,true)
self:openCloud(_delayLoading)
return
end
end
elseif paramType=='string'then
if self:haveUnit(_enterParam.lookAtUnit)then
self:lookAtUnit(_enterParam.lookAtUnit,nil,true)
self:openCloud(_delayLoading)
return
end
end
elseif _enterParam.clickUnit then
if self:haveUnit(_enterParam.clickUnit)then
self:clickUnit(_enterParam.clickUnit)
else

end
self:openCloud(_delayLoading)
return
elseif _enterParam.storyBTName then
worldStoryAIManager:startStoryBehavior(_enterParam.storyBTName,nil,_enterParam.storyBTCallback)
self:openCloud(_delayLoading)
return
end


local cameraConfig=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local pos=self:getCameraPosition()
local addCfg=cameraConfig.cameraPosAdd
local add=Vector3.New(0,addCfg[1],addCfg[2])
local duration=cameraConfig.cameraTimeAdd or 0
self:setCameraPosition(pos+add,true)
_enterCameraMove[1]=pos
_enterCameraMove[2]=duration
self:openCloud(_delayLoading)
end

function worldController:openCloud(delay,callback)

self:stopTimeOutCheck()
sceneControl:closeLoading(delay,callback)
end


function worldController.endCloud(typo)
if _enterCameraMove and worldController:isInWorld()then

if#_enterCameraMove>0 then
_this:moveCameraPosition(_enterCameraMove[1],_enterCameraMove[2],function()
_this:onEnterFinishAnimation()
end,_enterCameraMoveEase)
else
_this:onEnterFinishAnimation()
end
_enterCameraMove=nil
end
end

function worldController:doEnterDataInit()

self.manager=CS.WorldObjectManager.Instance

self:clearSpecailHeightLineOver()

if not self.isRegisterTouch then
notifySystem:listenNotify(notifyConfig.swipeStart,worldController.on_swipe_start)
notifySystem:listenNotify(notifyConfig.swipe,worldController.on_swipe)
notifySystem:listenNotify(notifyConfig.swipeEnd,worldController.on_swipe_end)
notifySystem:listenNotify(notifyConfig.pinch,worldController.on_pinch)
notifySystem:listenNotify(notifyConfig.touchStart,worldController.on_touch_start)
notifySystem:listenNotify(notifyConfig.touchUp,worldController.on_touch_up)
self.isRegisterTouch=true
else



end


local callbacks={
worldController.onClickUnit,
worldHUDModel.onHUDCreate,
worldHUDModel.onHUDDestory,
worldSymbolModel.onSymbolCreate,
worldSymbolModel.onSymbolDestory,
worldHUDModel.onHUDFlipX,
worldController.onTipsRange,
nil,
worldController.onCameraBlockChange,
worldController.onCameraZoomMax,
worldController.onCameraZoomMin,
worldController.onCameraSpecialHeightOver,
}
self.manager:BindLuaCallback(callbacks)
local cameraConfig=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local cameraSetting=CS.WorldCameraSetting.New()
cameraSetting.defaultPosition=mathHelper.convertArrayToVector(cameraConfig.cameraPos)
cameraSetting.deflectionAngle=mathHelper.convertArrayToVector(cameraConfig.cameraAngle)
cameraSetting.fov=cameraConfig.cameraFOV
cameraSetting.moveSpeed=mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"speedRate","value"))
cameraSetting.zoomRange=mathHelper.convertArrayToVector(worldController:getCameraZoomRange_Normal_Imp(cameraConfig))
cameraSetting.moveRange=mathHelper.convertArrayToVector(cameraConfig.cameraMove)
cameraSetting.moveTipsRange=mathHelper.convertArrayToVector(cameraConfig.cameraMoveTips)
cameraSetting.visibleRange=mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"showRange","value"))
cameraSetting.visibleInterval=1
cameraSetting.symbolRange=mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"symbolShowRange","value"))
cameraSetting.symbolEdge=mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"symbolSetRange","value"))
cameraSetting.blockInterval=cfgHelper.get3(cfg_worldglobalconfig_get,"checkCameraBlock","value",1)
if api_Available_specialHeightLine()then
local freezeLine=webGLHelper:isRunMiniGame()and cameraConfig.freezeLine_MiniGame or cameraConfig.freezeLine
cameraSetting.specialHeightLine={freezeLine}
end
self.manager:InitCameraData(cameraSetting,cameraSetting.defaultPosition)
local symbolwin=UIManager:findActiveWindow("UIWorldSymbolWin")
local hudwin=UIManager:findActiveWindow("UIWorldHUDWin")
self.manager:BindHUDPanel(hudwin.winlua,1,0)
self.manager:BindSymbolPanel(symbolwin.winlua,0)
self.manager:SetQuit(false)
self:setCameraState(eWorldCameraState.Normal)
self:onCameraEffectHandle(worldModel.world)
self:onEnterReadyData()

local qualityLevel=UISettingModel:getQualityLevel()
if qualityLevel==GraphicsQualityLevel.Low then
_this:SetLODThingVisible(2,false)
_this:SetLODThingVisible(3,false)
end
end


function worldController:onEnterReadyData()

self:doSceneState(1)
self:postEnterMessage(eWorldEnterPhase.DataReady,worldModel.world)
end


function worldController:onEnterFinishAnimation()

self:resumeCameraControl()
self:postEnterMessage(eWorldEnterPhase.Animation,worldModel.world)
self:onEnterComplete()
end


function worldController:onEnterComplete()

self:postEnterMessage(eWorldEnterPhase.Completed,worldModel.world)
_enterParam=nil
self:doMidwayHandle()
end

function worldController:checkEnterParam()
return _enterParam~=nil
end

function worldController:pushMidwayHandle(func)
table.insert(_finishParam,func)
end

function worldController:doMidwayHandle()
for i,v in ipairs(_finishParam)do
v(worldModel.world)
end
_finishParam={}
end


function worldController:exitWorld()
if worldController:getCameraControl()then
return mainControl:enterHome()
end
return false
end


function worldController:onExitScene()


self:doSceneState(2)

worldModel.world=nil
worldExperienceModel:outScene()
worldController:setCameraState(eWorldCameraState.Normal)
pcall(function()
if self.manager then
self.manager:SetQuit(true)
end
end)
worldHUDModel:clearAllHUD()
worldController:releaseCloudMask()
self.manager=nil

if self.isRegisterTouch then
notifySystem:removelistener(notifyConfig.swipeStart,worldController.on_swipe_start)
notifySystem:removelistener(notifyConfig.swipe,worldController.on_swipe)
notifySystem:removelistener(notifyConfig.swipeEnd,worldController.on_swipe_end)
notifySystem:removelistener(notifyConfig.pinch,worldController.on_pinch)
notifySystem:removelistener(notifyConfig.touchStart,worldController.on_touch_start)
notifySystem:removelistener(notifyConfig.touchUp,worldController.on_touch_up)
self.isRegisterTouch=nil
end

self:exitPanel()

pcall(function()
notifySystem:postNotify(notifyConfig.exitWorld,worldModel.world)
end)
end

function worldController:exitPanel()
baseFullScreenUI:openMain(false)
for i,v in ipairs(_closePanel)do
UIManager:closeWindow(v)
end
self:clearCheckPanel()
end

function worldController:postEnterMessage(step,world)
pcall(function()
notifySystem:postNotify(notifyConfig.enterWorld,step,world)
end)
end

function worldController:startTimeOutCheck()
self.timeout=timer.new()
self.timeout:start(_timeoutInterval,function()
self:stopTimeOutCheck()
self:triggerTimeOut()
end,1)
end

function worldController:stopTimeOutCheck()
if self.timeout then
self.timeout:cancel()
self.timeout=nil
end
end

function worldController:triggerTimeOut()
UIManager.error("进入大世界失败")
loggerUtil.logErrFMT("进入大世界超时")
_enterCameraMove=nil
mainControl:enterHome()
end
