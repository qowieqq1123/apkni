









local _cameraParam1=30
local _cameraParam2=6
local _cameraParam3=1.5
local _pinchMax=10
local _isDraging=false
local _touchCount=0
local _cameraCanBeControlled=true

local _normal_scenemap_camera_time={0.6,0.8}
local _camera_bezier_ease=DG.Tweening.Ease.OutSine







local _camera_bezier_scale1=50
local _camera_bezier_scale2=10

local _zoomOverMin={
[eWorldCameraState.SceneMap]={eWorldCameraState.Normal,"zoomOverMin_atSceneMap"},
[eWorldCameraState.WorldMap]={eWorldCameraState.SceneMap,"zoomOverMin_atWorldMap"},
}

local _zoomOverMax={
[eWorldCameraState.Normal]={eWorldCameraState.SceneMap,"zoomOverMax_atNormal"},
[eWorldCameraState.SceneMap]={eWorldCameraState.WorldMap,"zoomOverMax_atSceneMap"},
}

local _onZoomHandle={
[eWorldCameraState.Experience]="onZoomHandle_atExperience",
[eWorldCameraState.Normal]="onZoomHandle_atNormal",
[eWorldCameraState.SceneMap]="onZoomHandle_atSceneMap",
[eWorldCameraState.WorldMap]="onZoomHandle_atWorldMap",
}

local _beginDragPoint={
[eWorldCameraState.Experience]="beginDragPoint_atExperience",
[eWorldCameraState.Normal]="beginDragPoint_atNormal",
[eWorldCameraState.SceneMap]="beginDragPoint_atSceneMap",
[eWorldCameraState.WorldMap]="beginDragPoint_atWorldMap",
}

local _onDragHandle={
[eWorldCameraState.Experience]="onDragHandle_atExperience",
[eWorldCameraState.Normal]="onDragHandle_atNormal",
[eWorldCameraState.SceneMap]="onDragHandle_atSceneMap",
[eWorldCameraState.WorldMap]="onDragHandle_atWorldMap",
}

local _onClickHandle={
[eWorldCameraState.Experience]="onClickHandle_atExperience",
[eWorldCameraState.Normal]="onClickHandle_atNormal",
[eWorldCameraState.SceneMap]="onClickHandle_atSceneMap",
}
local _getCameraZoomRange={
[eWorldCameraState.Experience]="getCameraZoomRange_Experience",
[eWorldCameraState.Normal]="getCameraZoomRange_Normal",
}

local _specailHeightLineOverHandle={
[eWorldSpecialHeightLineType.eFreezeUnitAnimation]=function(oldVal,newVal)

local unitList=worldController:getAllUnit()
for i=1,unitList.Count do
local unit=unitList[i-1]
unit:SetModelFreeze(newVal)
end
end,
}

local _camera_state=nil
local _overlook_temp=nil

local _swipe_begin_screen_point
local _swipe_begin_source_pos

local _specailHeightLineOverCache={}

local _this=worldController

function worldController:stopCameraControl()

_cameraCanBeControlled=false
_touchCount=-1
end

function worldController:freezeCameraControl()
_cameraCanBeControlled=false
_touchCount=0
_isDraging=false
end

function worldController:resumeCameraControl()

_cameraCanBeControlled=true
end

function worldController:getCameraControl()

local checkMiJing=not MysteryModel:is_in_mystery()
return _cameraCanBeControlled and checkMiJing
end

function worldController:getCameraTransform()
if _this.manager then
return _this.manager:GetCamera()
end
end


function worldController.on_swipe_start(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
if not worldController:getCameraControl()then return end

_swipe_begin_screen_point=screenPoint
_swipe_begin_source_pos=_this[_beginDragPoint[_camera_state]](_this,screenPoint)

end

function worldController:setCameraParam(pv1,pv2)
_cameraParam1=pv1
_cameraParam2=pv2
end

function worldController.on_swipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if not worldController:getCameraControl()or not _swipe_begin_screen_point or not _swipe_begin_source_pos then
return
end

if touchCount==1 then
_this:onDragEvent(screenPoint)
end

_isDraging=true
end

function worldController.on_swipe_end(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)

_swipe_begin_screen_point=nil
_swipe_begin_source_pos=nil


end

function worldController.on_pinch(fingerIndex,touchCount,screenPoint,deltaPinch,deltaTime)
if not worldController:getCameraControl()then return end
if _touchCount>=0 and math.abs(deltaPinch*deltaTime)<_pinchMax then
_this:onZoomEvent(deltaPinch,deltaTime)
end
end

function worldController.on_touch_start(fingerIndex,touchCount,screenPoint,guid)
_isDraging=touchCount>1
_touchCount=math.max(_touchCount+1,1)
end

function worldController.on_touch_up(fingerIndex,touchCount,screenPoint,guid)
_touchCount=math.max(_touchCount-1,0)
if not worldController:getCameraControl()then return end
if touchCount==1 then
if not _isDraging then
_this:onClickEvent(screenPoint)
else
_isDraging=false
end
end
end


function worldController:onClickEvent(screenPoint)
local cbName=_onClickHandle[_camera_state]
if cbName then
_this[cbName](_this,screenPoint)
end
end

function worldController:onDragEvent(screenPoint)
local cbName=_onDragHandle[_camera_state]
if cbName then
_this[cbName](_this,screenPoint)
end
end

function worldController:onZoomEvent(deltaPinch,deltaTime)

local cbName=_onZoomHandle[_camera_state]
if cbName then
_this[cbName](_this,deltaPinch,deltaTime)
end
end

function worldController.onCameraZoomMax()
local zoomOverMaxSet=_zoomOverMax[_camera_state]
if zoomOverMaxSet then
local cbName=zoomOverMaxSet[2]
local pass=_this[cbName](_this)
if pass then
_camera_state=zoomOverMaxSet[1]
notifySystem:postNotify(notifyConfig.onWorldCameraStateChanged,_camera_state)
end
end
end

function worldController.onCameraZoomMin()
local zoomOverMinSet=_zoomOverMin[_camera_state]
if zoomOverMinSet then
local cbName=zoomOverMinSet[2]
local pass=_this[cbName](_this)
if pass then
_camera_state=zoomOverMinSet[1]
notifySystem:postNotify(notifyConfig.onWorldCameraStateChanged,_camera_state)
end
end
end



function worldController:zoomOverMin_atSceneMap()
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
self:breakOverTopBackEnter(worldCfg.cameraPos[2])
worldMapController:exitMapModel()
return true
end

function worldController:zoomOverMin_atWorldMap()
UIManager:hideWindow("UIWorlMapWin")
return true
end

function worldController:zoomOverMax_atSceneMap()
if systemModel.isOpen(SYSTEM_DEFINE.eWorldMap)then
UIManager:callWindowFunc("UIWorldSceneWin","doAnimationScale",function()

end)
UIManager:showWindow("UIWorldMapWin")
UIManager:invokeUIMethod("UIWorldMapTabWin","setSelected",1)
return true
end
return false
end

function worldController:zoomOverMax_atNormal(force)
if not systemModel.isOpen(SYSTEM_DEFINE.eWorldSceneMap)then
return false
end

if not force and webGLHelper:isRunMiniGame()then
return
end

local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,worldCfg.sceneMap)
local targetPosition=mathHelper.convertArrayToVector(mapCfg.cameraPos)
_overlook_temp=_this:getCameraPosition()
local callback=function()
worldController:resumeCameraControl()
end
worldMapController:enterMapModel(worldModel.world)
_this:stopCameraControl()

local path=self:getEnterOverTopWayPoints(targetPosition)
_this:moveCameraPath(path,_normal_scenemap_camera_time[1],DG.Tweening.PathType.CubicBezier,_camera_bezier_ease,callback)


local qualityLevel=UISettingModel:getQualityLevel()
if qualityLevel~=GraphicsQualityLevel.Low then
_this:SetLODThingVisible(2,false)
_this:SetLODThingVisible(3,false)
end

return true
end

function worldController:onZoomHandle_atExperience(deltaPinch,deltaTime)
if fullScreenUI.isActiveBaseFull()then
_this.manager:ZoomCameraByScreenSpacing(-deltaPinch*deltaTime*_cameraParam3)
end
end

function worldController:onZoomHandle_atNormal(deltaPinch,deltaTime)
if not fullScreenUI.isActiveFull()then
_this.manager:ZoomCameraByScreenSpacing(-deltaPinch*deltaTime*_cameraParam3)
end
end

function worldController:onZoomHandle_atSceneMap(deltaPinch,deltaTime)

if deltaPinch>0 then
worldController.onCameraZoomMin()
else
worldController.onCameraZoomMax()
end
end

function worldController:onZoomHandle_atWorldMap(deltaPinch,deltaTime)

end

function worldController:onDragHandle_atExperience(screenPoint)
_this.manager:MoveCameraByScreenSpacing(_swipe_begin_source_pos,_swipe_begin_screen_point,screenPoint,_cameraParam1,_cameraParam2)
end

function worldController:onDragHandle_atNormal(screenPoint)
_this.manager:MoveCameraByScreenSpacing(_swipe_begin_source_pos,_swipe_begin_screen_point,screenPoint,_cameraParam1,_cameraParam2)
end

function worldController:onDragHandle_atSceneMap(screenPoint)



end

function worldController:onDragHandle_atWorldMap(screenPoint)

end

function worldController:onClickHandle_atExperience(screenPoint)
if not _this.manager:ClickCameraByScreenSpacing(screenPoint,
bit.lshift(1,helper.LAYER_ACTOR)+
bit.lshift(1,helper.LAYER_TOUCH_GROUND))then
worldController:selectCloud()
end
end

function worldController:onClickHandle_atNormal(screenPoint)
if not _this.manager:ClickCameraByScreenSpacing(screenPoint,
bit.lshift(1,helper.LAYER_ACTOR)+
bit.lshift(1,helper.LAYER_TOUCH_GROUND))then
worldController:selectCloud()
notifySystem:postNotify(notifyConfig.onClickEmptyInWorld)
end
end






function worldController:onClickHandle_atSceneMap(screenPoint)
if not worldMapController:isMapModel()or not UIManager:isActive("UIWorldSceneWin",false)then return end
local cMapScene=worldMapController:getCurrentScene()

local uiPos=worldSceneMapModel:screen2ui_position(screenPoint.x,screenPoint.y,cMapScene)

local point=worldSceneMapModel:rechangePosition(uiPos.x,uiPos.y,cMapScene)

local dest=worldSceneMapModel:clampMoveRect(point.x,point.y,cMapScene)

local lookAt=Vector3.New(dest.x,0,dest.y)

if cMapScene~=worldModel.world then
if worldController:enterWorld(cMapScene,{lookAt=lookAt})then
worldMapController:exitMapModel()
end
return
end

worldController:breakOverTopLookAtCamera_Position(lookAt)
worldMapController:exitMapModel()
self:setCameraState(eWorldCameraState.Normal)
end

function worldController:beginDragPoint_atExperience(screenPoint)
return _this.manager:GetCameraPosition()
end

function worldController:beginDragPoint_atNormal(screenPoint)
return _this.manager:GetCameraPosition()
end

function worldController:beginDragPoint_atSceneMap(screenPoint)
return screenPoint

end

function worldController:beginDragPoint_atWorldMap(screenPoint)
return nil
end

function worldController:setCameraState(state)
local oldState=_camera_state
_camera_state=state
notifySystem:postNotify(notifyConfig.onWorldCameraStateChanged,state,oldState)
if state<eWorldCameraState.SceneMap then
_overlook_temp=nil
end
end

function worldController:checkCameraState(state)
return _camera_state==state
end

function worldController:getCameraState()
return _camera_state
end

function worldController:isOverTop()
return _overlook_temp~=nil
end

function worldController:breakOverTopLookAtCamera_Unit(unitKey)

local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local heightMin=worldCfg.cameraPos[2]
_this:stopCameraControl()
local callback=function()
worldController:resumeCameraControl()
end
local targetPosition=self:getCameraPosition_WhenLookAtUnit(unitKey,heightMin)
if not targetPosition then return loggerUtil.logErrFMT("无法找到目标单位{0}",unitKey)end
local path=self:getExitOverTopWayPoint(targetPosition)
_this:moveCameraPath(path,_normal_scenemap_camera_time[2],DG.Tweening.PathType.CubicBezier,_camera_bezier_ease,callback)

local qualityLevel=UISettingModel:getQualityLevel()
if qualityLevel~=GraphicsQualityLevel.Low then
_this:SetLODThingVisible(2,true)
_this:SetLODThingVisible(3,true)
end
_overlook_temp=nil
end

function worldController:breakOverTopLookAtCamera_Position(position)

local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local heightMin=worldCfg.cameraPos[2]
_this:stopCameraControl()
local callback=function()
worldController:resumeCameraControl()
end
local targetPosition=self:getCameraPosition_WhenLookAtPosition(position,heightMin)
local path=self:getExitOverTopWayPoint(targetPosition)
_this:moveCameraPath(path,_normal_scenemap_camera_time[2],DG.Tweening.PathType.CubicBezier,_camera_bezier_ease,callback)

local qualityLevel=UISettingModel:getQualityLevel()
if qualityLevel~=GraphicsQualityLevel.Low then
_this:SetLODThingVisible(2,true)
_this:SetLODThingVisible(3,true)
end
_overlook_temp=nil
end

function worldController:breakOverTopBackEnter(height)
local targetPosition=Vector3.New(_overlook_temp.x,height or _overlook_temp.y,_overlook_temp.z)
_this:stopCameraControl()
local callback=function()
worldController:resumeCameraControl()
end
local path=self:getExitOverTopWayPoint(targetPosition)
_this:moveCameraPath(path,_normal_scenemap_camera_time[2],DG.Tweening.PathType.CubicBezier,_camera_bezier_ease,callback)



local qualityLevel=UISettingModel:getQualityLevel()
if qualityLevel~=GraphicsQualityLevel.Low then
_this:SetLODThingVisible(2,true)
_this:SetLODThingVisible(3,true)
end
_overlook_temp=nil
end

function worldController:getEnterOverTopWayPoints(targetPosition)
local currentPosition=self:getCameraPosition()
local delta=self:getCameraCurveDelta2(0.01,currentPosition.y)

local tangentOut=currentPosition+Vector3.New(0,_camera_bezier_scale1,delta*_camera_bezier_scale1*100)
local tangentIn=targetPosition+Vector3.Normalize(currentPosition-targetPosition)*_camera_bezier_scale2
return{targetPosition,tangentOut,tangentIn}
end

function worldController:getExitOverTopWayPoint(targetPosition)
local currentPosition=self:getCameraPosition()
local delta=self:getCameraCurveDelta2(0.01,targetPosition.y)

local tangentOut=targetPosition+Vector3.New(0,_camera_bezier_scale1,delta*_camera_bezier_scale1*100)
local tangentIn=currentPosition+Vector3.back*_camera_bezier_scale2
return{targetPosition,tangentIn,tangentOut}
end

function worldController:getCameraZoomRange()
local func=_getCameraZoomRange[_camera_state]
if func and self[func]then
return self[func](self)
end
end

function worldController:getCameraZoomRange_Normal(world)
world=world or worldModel.world
local cameraConfig=cfgHelper.get1(cfg_worldconfig_get,world)
return self:getCameraZoomRange_Normal_Imp(cameraConfig)
end

function worldController:getCameraZoomRange_Normal_Imp(cameraConfig)
if webGLHelper:isRunMiniGame()then
return cameraConfig.cameraZoom_MiniGame
end
return cameraConfig.cameraZoom
end

function worldController:getCameraZoomRange_Experience()
local experienceHeight=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceCameraHeight","value")
return{experienceHeight[1],experienceHeight[1]}
end

function worldController.onCameraSpecialHeightOver(index,isOVer,isInit)

local old=_specailHeightLineOverCache[index]
_specailHeightLineOverCache[index]=isOVer
if old~=isOVer then
local handle=_specailHeightLineOverHandle[index]
if handle then
handle(old,isOVer)
end
end
end

function worldController:getSpecailHeightLineOver(index)
return _specailHeightLineOverCache[index]
end

function worldController:clearSpecailHeightLineOver()
table.clear(_specailHeightLineOverCache)
end

function worldController:gm_change_CameraParam3(value)
_cameraParam3=value
end