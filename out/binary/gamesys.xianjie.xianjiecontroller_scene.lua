







local _cameraParam1=30
local _cameraParam2=8
local _cameraParam3=1.5
local _maxCameraY=105
local _pinchMax=10
local _isDraging=false
local _touchCount=0
local _cameraCanBeControlled=true
local _dragLookup={}
local _drayEntityDelay=nil
local _drayEntityDelayTime=0.2

local _dragEntityOffset={120,-120,120,-120}
local _dragEntitySpeed={4,4}

local _mapEntityHeight=0
local _mapResPos={0,_mapEntityHeight,0}
local _mapGridSize=2.5

local _enterParam=nil
local _swipe_begin_screen_point
local _swipe_begin_source_pos
local _cameraYClick

local _waitLoadMap
local _isChangeMap

local _map_data={
[xianjienSceneType.eXianJie]={
checkOpen=function(sceneType,isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eJiuChongTianJieComplete)
UIManager.error(tips)
end
return false
end
return true
end,




},
[xianjienSceneType.eMoJie]={
checkOpen=function(sceneType,isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eJiuChongTianJieComplete)
UIManager.error(tips)
end
return false
end
if not xianjieModel:checkMoJieEnterTime(sceneType)then
if isWarning then
UIManager.error("魔界未开启")
end
return false
end

if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then
if isWarning then
UIManager.error("魔界还未破开")
end
return false
end
return true
end,




},
[xianjienSceneType.eXianYu_1]={
checkOpen=function(sceneType,isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianYuEnter)
UIManager.error(tips)
end
return false
end
if not xianjieController:checkXianYuOpen(true)then
return false
end
return true
end,




},
[xianjienSceneType.eMoGongZhengDuo]={
checkOpen=function(sceneType,isWarning)
return true
end,




},
}

function xianjieController:onAppStart_scene()
local sceneData={
enter=function(o,sceneType,enterParam)self:onIntoScene(sceneType,enterParam,false)end,
leave=function(o,...)self:onExitScene()end,
load=function(o,sceneType,enterParam)self:onLoadScene(sceneType,enterParam)end,
}
mainControl:regSceneTypo(eSceneType.eXianJie,sceneData)
end

function xianjieController:getMapGridSize()
return _mapGridSize
end

function xianjieController:getCameraYClick()
return _cameraYClick
end

function xianjieController:isSceneOpen(sceneType,warning,withAPI)
if withAPI==nil then withAPI=true end

if withAPI and not api_Available_SetBeautifyTone()then
UIManager.info('请前往对应平台更新至最新版本')
return false
end

local data=xianjieController:getMapLocalData(sceneType)

if data.checkOpen then
return data.checkOpen(sceneType,warning)
end
return true
end

function xianjieController:getMapLocalData(sceneType)
if xianjienSceneType:isXianYu(sceneType)then
return _map_data[xianjienSceneType.eXianYu_1]
elseif xianjienSceneType:isMoJie(sceneType)then
return _map_data[xianjienSceneType.eMoJie]
elseif xianjienSceneType:isMoGongZhengDuo(sceneType)then
return _map_data[xianjienSceneType.eMoGongZhengDuo]
else
return _map_data[sceneType]
end
end

function xianjieController:getDefaultPos(sceneType,enterParam)
local data=xianjieController:getMapLocalData(sceneType)

local lookpos
if enterParam then
local pos_=enterParam.defaultPos
if pos_ then
local sceneidx=xianjieModel:getSceneIndex(sceneType)
lookpos=xianjieController:worldGridPos2WorldPos4(pos_[1],pos_[2],sceneidx)
end
end
if lookpos==nil then
if data.getDefaultPos then
lookpos=data.getDefaultPos()
else

local sceneidx=xianjieModel:getSceneIndex(sceneType)
local pos=xianjieModel:getZongmenOutPosBySceneIdx(sceneidx)
if pos~=nil and pos[1]==sceneidx then
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(pos[2],pos[3],gridWidth,gridHeight)
lookpos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c,pos[1])
end
end
end
return lookpos
end

function xianjieController:calculateMapSize(sceneidxcfg)
local mapSize=sceneidxcfg.mapSize
local mapSize_w=Vector2(mapSize[1]*_mapGridSize,mapSize[2]*_mapGridSize)
local mapOffset={-mapSize_w.x/2,-mapSize_w.y/2}
return mapSize,mapSize_w,mapOffset
end

function xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
local gridX_c=gridX+width/2
local gridZ_c=gridZ+height/2
return gridX_c,gridZ_c
end

function xianjieController:worldGridCenterPos2WorldGridPos(gridX_c,gridZ_c,width,height)
local gridX=gridX_c-width/2
local gridZ=gridZ_c-height/2
return gridX,gridZ
end

function xianjieController:worldGridPos2WorldPos1(gridX,gridZ,width,height,sceneidx)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos3(gridX_c,gridZ_c,sceneidx)
return Vector3(worldX,worldY,worldZ)
end

function xianjieController:worldGridPos2WorldPos11(gridX,gridZ,width,height,sceneidx)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos31(gridX_c,gridZ_c,sceneidx)
return Vector3(worldX,worldY,worldZ)
end

function xianjieController:worldGridPos2WorldPos3(gridX,gridZ,sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local mapOffset=xianjieModel:getMapSize2(sceneidx)
local mapResPos=xianjieController:get_mapResPos()
local worldX=mapResPos[1]+gridX*_mapGridSize+mapOffset[1]
local worldZ=mapResPos[3]+gridZ*_mapGridSize+mapOffset[2]
return worldX,mapResPos[2],worldZ
end

function xianjieController:worldGridPos2WorldPos31(gridX,gridZ,sceneidx)
local sceneidx_=xianjieModel:getSceneIndex()
sceneidx=sceneidx or sceneidx_
local mapOffset=xianjieModel:getMapSize2(sceneidx)
local mapResPos=xianjieController:get_mapResPos()
local worldX=mapResPos[1]+gridX*_mapGridSize+mapOffset[1]
local worldZ=mapResPos[3]+gridZ*_mapGridSize+mapOffset[2]

local height
if sceneidx==sceneidx_ then
local gridX_=math.floor(gridX)
local gridZ_=math.floor(gridZ)
height=xianjieController:GetPosHeight(gridX_,gridZ_)or mapResPos[2]
else



height=mapResPos[2]
end
return worldX,height,worldZ
end

function xianjieController:worldGridPos2WorldPos4(gridX,gridZ,sceneidx)
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos3(gridX,gridZ,sceneidx)
return Vector3(worldX,worldY,worldZ)
end

function xianjieController:worldGridPos2WorldPos41(gridX,gridZ,sceneidx)
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos31(gridX,gridZ,sceneidx)
return Vector3(worldX,worldY,worldZ)
end

function xianjieController:worldPos2WorldGridPos(worldX,worldZ,sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local mapOffset=xianjieModel:getMapSize2(sceneidx)
local mapResPos=xianjieController:get_mapResPos()
local gridX=math.floor((worldX-mapResPos[1]-mapOffset[1])/_mapGridSize)
local gridZ=math.floor((worldZ-mapResPos[3]-mapOffset[2])/_mapGridSize)
return gridX,gridZ
end

function xianjieController:worldPos2worldPos(worldX,worldZ,sceneidx)
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(worldX,worldZ,sceneidx)
local sceneidx_=xianjieModel:getSceneIndex()
sceneidx=sceneidx or sceneidx_
local mapResPos=xianjieController:get_mapResPos()

local height
if sceneidx==sceneidx_ then
height=xianjieController:GetPosHeight(gridX,gridZ)or mapResPos[2]
else



height=mapResPos[2]
end
return Vector3(worldX,height,worldZ)
end

function xianjieController:gridSize2WorldSize(gridwidth,gridheight)
local width=gridwidth*_mapGridSize
local height=gridheight*_mapGridSize
return width,height
end

function xianjieController:worldSize2GridSize(width,height)
local gridwidth=width/_mapGridSize
local gridheight=height/_mapGridSize
return gridwidth,gridheight
end

function xianjieController:gridSize2WorldSize2(gridwidth,gridheight)
local width,height=xianjieController:gridSize2WorldSize(gridwidth,gridheight)
return Vector2(width,height)
end

function xianjieController:getCameraZoomRange(sceneCfg)
if sceneCfg==nil then
local sceneType=xianjieModel:getScenceType()
sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
end

if webGLHelper:isWebGLOptimization()then
return sceneCfg.cameraZoom_MiniGame
end
return sceneCfg.cameraZoom
end

function xianjieController:getCameraZoomRange2(sceneType)
sceneType=sceneType or xianjieModel:getScenceType()
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
return xianjieController:getCameraZoomRange(sceneCfg)
end

function xianjieController:getCameraLodRange(sceneCfg)
if sceneCfg==nil then
local sceneType=xianjieModel:getScenceType()
sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
end
if webGLHelper:isWebGLOptimization()then
return sceneCfg.lodRange_MiniGame
end
return sceneCfg.lodRange
end

function xianjieController:getDefaultCamerPos(sceneCfg,sceneType)
if sceneCfg==nil then
sceneType=sceneType or xianjieModel:getScenceType()
sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
end
if webGLHelper:isWebGLOptimization()then
return sceneCfg.cameraPos_MiniGame or sceneCfg.cameraPos
end
return sceneCfg.cameraPos
end

function xianjieController:getDefaultCamerY(sceneType)
local pos=xianjieController:getDefaultCamerPos(nil,sceneType)
return pos[2]
end

function xianjieController:get_mapResPos()
return _mapResPos
end

function xianjieController:getSceneIndexGroup(sceneIdx)
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
return eXianJieLogicSceneType.eMoGong
elseif xianjienSceneIndexType:isMoJie(sceneIdx)then
return eXianJieLogicSceneType.eMoJie
else
return eXianJieLogicSceneType.eXianJie
end
end


function xianjieController:checkGridInMapEx(gridX,gridZ,sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local mapSize=xianjieModel:getMapSize(sceneidx)
return gridX>=0 and gridX<mapSize[1]and gridZ>=0 and gridZ<mapSize[2]
end

function xianjieController:checkGridInMap(gridX,gridZ,sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local mapSize=xianjieModel:getMapSize(sceneidx)
local mapRadius,mapCenterGrid=xianjieModel:getMapRadius(sceneidx)
if mapRadius==nil then
return gridX>=0 and gridX<mapSize[1]and gridZ>=0 and gridZ<mapSize[2]
else
if gridX>=0 and gridX<mapSize[1]and gridZ>=0 and gridZ<mapSize[2]then
if not xianjienSceneIndexType:isMoJie(sceneidx)then
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,1,1)
local dis=mathHelper.distance(gridX_c,gridZ_c,mapCenterGrid[1],mapCenterGrid[2])
return dis<=mapRadius
end
return true
end
end
return false
end

function xianjieController:checkGridInMap2(gridX,gridZ,sizeX,sizeZ,sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local mapSize=xianjieModel:getMapSize(sceneidx)
local maxX=mapSize[1]-1
local maxZ=mapSize[2]-1
if sizeX>0 then
maxX=maxX-(sizeX-1)
end
if sizeZ>0 then
maxZ=maxZ-(sizeZ-1)
end
local mapRadius,mapCenterGrid=xianjieModel:getMapRadius(sceneidx)
if mapRadius==nil then
return gridX>=0 and gridX<=maxX and gridZ>=0 and gridZ<=maxZ
else
if gridX>=0 and gridX<=maxX and gridZ>=0 and gridZ<=maxZ then
if not xianjienSceneIndexType:isMoJie(sceneidx)then
for gridX_=gridX,gridX+sizeX-1 do
for gridZ_=gridZ,gridZ+sizeZ-1 do
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX_,gridZ_,1,1)
local dis=mathHelper.distance(gridX_c,gridZ_c,mapCenterGrid[1],mapCenterGrid[2])
if dis>mapRadius then
return false
end
end
end
end
return true
end
end
return false
end



function xianjieController:jumpXianJie(sceneType,enterParam,enterCall)
if sceneType==nil then
if xianjieController:checkXianYuOpen()then
local sceneidx_=xianjieModel:getXianYuSceneIndex()
sceneType=xianjieModel:sceneIndex2SceneType(sceneidx_)
else
sceneType=xianjienSceneType.eXianJie
end
end
if xianjieController:isSceneOpen(sceneType,true)then
return xianjieController:enterXianJie(sceneType,enterParam,enterCall)
end
return false
end

function xianjieController:enterXianJie(sceneType,enterParam,enterCall,preCheckRecord)
if sceneControl:getLoadingState()==eSceneLoadState.Loading then
return false
end
if _isChangeMap==true then
return false
end
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
if sceneCfg==nil then
loggerUtil.logErrFMT("进入仙界失败，没有配置对应的仙界场景:{0}",sceneType)
return false
end

local preCheckResult=xianjieController:enterXianJiePreCheck(preCheckRecord,sceneType,enterParam,enterCall)
if not preCheckResult then
return false
end

if xianjienSceneType:isMoJie(sceneType)and not xianjieModel:checkJoin_mojie()then
xianjieController:reqCreateZMPos_mojie(enterCall,enterParam)
return false
end


if(not xianjienSceneType:isMoGongZhengDuo(sceneType))and moGongZhengDuoActModel:checkInSceneFlag()then
moGongZhengDuoActController:reqUpdateActState(0,function()
enterParam=enterParam or{}
enterParam.isSkipChangeSceneCheck=true
xianjieController:reqCreateZMPos_mojie(enterCall,enterParam)
end)
return false
end


if xianjienSceneType:isMoGongZhengDuo(sceneType)and not xianjieModel:checkRecvInitScenePos()then
if moGongZhengDuoActModel:checkInSceneFlag()then
local flag=moGongZhengDuoActModel:getActInSceneFlag()
moGongZhengDuoActController:reqUpdateActState(flag)
else
if xianjieModel:checkJoin_mogongzhengduo()then
if xianjieController:checkCanEnterMoGongZhengDuo()then
xianjieController:reqCreateZMPos_mogongzhengduo(enterCall,enterParam)
end
else
xianjieController:reqCreateZMPos_mogongzhengduo(enterCall,enterParam)
end
return false
end
end

local sceneType_=xianjieModel:getScenceType()
if sceneType_~=sceneType then
local isLoad=false
if sceneType_==nil then
isLoad=true
else
local sceneCfg_=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType_)
if sceneCfg.sceneid~=sceneCfg_.sceneid then
isLoad=true
end
end
if isLoad then
if not xianjieModel:isOpenHuJianXianJieEx()then
if mainControl:enterXianJie({sceneType,enterParam},enterCall)then
return true
end
else
if mainControl:enterXianJie({sceneType,enterParam},nil)then
if enterCall then
self.enterCall=function()
enterCall()
xianjieController.enterCall=nil
end
socketManager:addNotify(35,4,self.enterCall,1)
end
return true
end
end
return false
else


_isChangeMap=true
local callback=function()
xianjieController:onExitScene(true)
xianjieController:onIntoScene(sceneType,enterParam,true)
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=callback,endCallback=enterCall})
return true
end
end
return false
end


function xianjieController:onLoadScene(sceneType,enterParam)
sceneType=sceneType or xianjieModel:getDefaultScene()
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
local sceneId=sceneCfg.sceneid
sceneControl:startLoading({sceneId=sceneId,closeLoading=false})
end


function xianjieController:onIntoScene(sceneType,enterParam,ischange)
sceneType=sceneType or xianjieModel:getDefaultScene()
xianjieModel:setScenceType(sceneType)
mainViewsControl.onChangeSceneMap(eSceneType.eXianJie,sceneType)
_enterParam=enterParam
xianjieController:freezeCameraControl()

if not ischange then

buildlightController:setBLState(false)

self.lineManager=CS.SceneLineManager.Instance
xianjieController:setLineSortingGroup('Entity',19)

baseFullScreenUI:openWindowOnEnterScene()
else

baseFullScreenUI:openMain(true)
end

_waitLoadMap=true
xianjieController:handleInitData(ischange)


end


function xianjieController:onIntoScene_finish(ischange)
if _waitLoadMap==nil then return end
_waitLoadMap=nil
xpcall(function()
xianjieController:onEnterMap(ischange,_enterParam)
end,xianjieController.pcallError)

xpcall(function()
xianjieController:handleEnterParam(ischange)
end,xianjieController.pcallError)

xianjieController:resumeCameraControl()

local sceneType=xianjieModel:getScenceType()
xpcall(function()
notifySystem:postNotify(notifyConfig.enterXianJie,sceneType)
end,xianjieController.pcallError)
if not ischange then

sceneControl:closeLoading()
else

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
_isChangeMap=nil
end
end







function xianjieController:setWaitLoadMap(flag)
_waitLoadMap=flag
end


function xianjieController:listenNotifyTouch()
notifySystem:listenNotify(notifyConfig.swipeStart,xianjieController.on_swipe_start)
notifySystem:listenNotify(notifyConfig.swipe,xianjieController.on_swipe)
notifySystem:listenNotify(notifyConfig.swipeEnd,xianjieController.on_swipe_end)
notifySystem:listenNotify(notifyConfig.pinch,xianjieController.on_pinch)
notifySystem:listenNotify(notifyConfig.touchStart,xianjieController.on_touch_start)
notifySystem:listenNotify(notifyConfig.touchUp,xianjieController.on_touch_up)

end

function xianjieController:removelistenerTouch()
notifySystem:removelistener(notifyConfig.swipeStart,xianjieController.on_swipe_start)
notifySystem:removelistener(notifyConfig.swipe,xianjieController.on_swipe)
notifySystem:removelistener(notifyConfig.swipeEnd,xianjieController.on_swipe_end)
notifySystem:removelistener(notifyConfig.pinch,xianjieController.on_pinch)
notifySystem:removelistener(notifyConfig.touchStart,xianjieController.on_touch_start)
notifySystem:removelistener(notifyConfig.touchUp,xianjieController.on_touch_up)
end


function xianjieController:onExitScene(ischange)
_waitLoadMap=nil
if self.enterCall then
socketManager:removeNotify(35,4,self.enterCall)
self.enterCall=nil
end
local sceneType=xianjieModel:getScenceType()
if not ischange then

buildlightController:setBLState(true)

xianjieController:removeLineSortingGroup()
xianjieController:onLeaveMap(ischange)
pcall(function()
if self.manager then
self.manager:LeaveMap(ischange)
end
end)
self.manager=nil
self.lineManager=nil

if self.isRegisterTouch then
xianjieController:removelistenerTouch()
self.isRegisterTouch=nil
end


xianjieModel:setScenceType(nil)

pcall(function()
notifySystem:postNotify(notifyConfig.leaveXianJie,sceneType)
end)
else
xianjieController:onLeaveMap(ischange)
pcall(function()
if self.manager then
self.manager:LeaveMap(ischange)
end
end)

baseFullScreenUI:openMain(false)
xianjieModel:setScenceType(nil)
end
end


function xianjieController:handleInitData(ischange)
if ischange==nil then ischange=false end
local sceneType=xianjieModel:getScenceType()
if self.manager==nil then
self.manager=CS.XianJieSystem.Instance
self.manager:BindLuaCallback(xianjieController.callLuaFunc)
end
if not self.isRegisterTouch then
xianjieController:listenNotifyTouch()
self.isRegisterTouch=true
end


xianjieController:initHudParams()

xianjieController:init2DMapCfg()

local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
local xjSetting=CS.XJSetting.New()
xjSetting.defaultPosition=mathHelper.convertArrayToVector(xianjieController:getDefaultCamerPos(sceneCfg))
xjSetting.deflectionAngle=mathHelper.convertArrayToVector(sceneCfg.cameraAngle)
xjSetting.moveSpeed=mathHelper.convertArrayToVector(sceneCfg.speedRate)
xjSetting.fov=sceneCfg.cameraFOV
xjSetting.zoomRange=mathHelper.convertArrayToVector(xianjieController:getCameraZoomRange(sceneCfg))
xjSetting.lodRange=table.weakCopy(xianjieController:getCameraLodRange(sceneCfg))
xjSetting.lodLevelRange=table.weakCopy(sceneCfg.lodLevelRange)
xjSetting.moveRange=mathHelper.convertArrayToVector(sceneCfg.cameraMove)
xjSetting.mapID=sceneCfg.sceneMapID
xjSetting.mapPos=mathHelper.convertArrayToVector(xianjieController:get_mapResPos())
local sceneidxcfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,sceneCfg.mapIndex)
local mapSize_w=xianjieModel:getMapSize3(sceneCfg.mapIndex)
xjSetting.mapSize=mapSize_w
xjSetting.mapQuadTreeMaxDepth=sceneidxcfg.mapQuadTreeMaxDepth
self.manager:InitSettingData(xjSetting,ischange)
pcall(function()
self.manager:EnterMap(ischange)
end)
if webGLHelper:isRunMiniGame()then
_cameraYClick=sceneCfg.cameraYClick_MiniGame
else
_cameraYClick=sceneCfg.cameraYClick
end
end


function xianjieController:handleEnterParam(ischange)
local sceneType=xianjieModel:getScenceType()

local lookpos=xianjieController:getDefaultPos(sceneType,_enterParam)
if lookpos then
xianjieController:lookAtPosition(lookpos,nil,0,nil,nil)
end
if _enterParam then
local isPlot=false
if sceneType==xianjienSceneType.eXianJie then
if not xianjieController:checkInPlotScene2()then
isPlot=true
xianjieController:handleEnterParam_xianjie(_enterParam,ischange)
else
xianjieController:handleEnterParam_plot(_enterParam,ischange)
end
elseif xianjienSceneType:isMoJie(sceneType)then
xianjieController:handleEnterParam_mojie(_enterParam,ischange)
else
xianjieController:handleEnterParam_xianyu(_enterParam,ischange)
end
if not isPlot then
xianjieController:handleEnterParam_pvp(_enterParam,ischange)
end
end
_enterParam=nil
end


function xianjieController:clearScene(flag)

xianjieController:setLogicShow(flag)

xianjieController:activeScene(flag)
end




function xianjieController.on_swipe_start(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
if not xianjieController:getCameraControl()then return end
_swipe_begin_screen_point=screenPoint
_swipe_begin_source_pos=xianjieController.manager:GetCameraPosition()
end

function xianjieController:setCameraParam(pv1,pv2,pv3)
_cameraParam1=pv1
_cameraParam2=pv2
_maxCameraY=pv3
end

function xianjieController:setCameraScaleSpeed(param3)
_cameraParam3=param3
end

function xianjieController.on_swipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if not xianjieController:getCameraControl()or not _swipe_begin_screen_point or not _swipe_begin_source_pos then
return
end

local check=false
local stateType=_dragLookup[fingerIndex]
if stateType~=nil then
if xianjieModel:checkSceneState(stateType)then
check=true
local ent=xianjieModel:getSceneStateEntity(stateType)
xianjieController:onDrayEntity(ent,screenPoint)
else
_dragLookup[fingerIndex]=nil
_drayEntityDelay=nil
end
end
if check==false then
if touchCount==1 then
xianjieController:onDragEvent(screenPoint)
end
end
_isDraging=true
end

function xianjieController.on_swipe_end(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
_swipe_begin_screen_point=nil
_swipe_begin_source_pos=nil
end

function xianjieController.on_pinch(fingerIndex,touchCount,screenPoint,deltaPinch,deltaTime)

if next(_dragLookup)then
table.clear(_dragLookup)
_drayEntityDelay=nil
end
if not xianjieController:getCameraControl()then return end
if _touchCount>=0 and math.abs(deltaPinch*deltaTime)<_pinchMax then
xianjieController:onZoomEvent(deltaPinch,deltaTime)
end
end

function xianjieController.on_touch_start(fingerIndex,touchCount,screenPoint,guid)
_isDraging=touchCount>1
_touchCount=math.max(_touchCount+1,1)

if xianjieModel:checkSceneState(xjSceneStateType.eMoveZongMen)then
local pos=xianjieController.manager:GetScreenPos2PlanePos(screenPoint)
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
local ent=xianjieModel:getSceneStateEntity(xjSceneStateType.eMoveZongMen)
if ent~=nil and ent:checkInRange(gridX,gridZ)then
_dragLookup[fingerIndex]=xjSceneStateType.eMoveZongMen
end
elseif xianjieModel:checkSceneState(xjSceneStateType.eMoveXianMeng)then
local pos=xianjieController.manager:GetScreenPos2PlanePos(screenPoint)
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
local ent=xianjieModel:getSceneStateEntity(xjSceneStateType.eMoveXianMeng)
if ent~=nil and ent:checkInRange(gridX,gridZ)then
_dragLookup[fingerIndex]=xjSceneStateType.eMoveXianMeng
end
end
end

function xianjieController.on_touch_up(fingerIndex,touchCount,screenPoint,guid)
_touchCount=math.max(_touchCount-1,0)

_dragLookup[fingerIndex]=nil
_drayEntityDelay=nil
if not xianjieController:getCameraControl()then return end
if touchCount==1 then
if not _isDraging then
xianjieController:onClickEvent(screenPoint)
else
_isDraging=false
end
end
end





function xianjieController:stopCameraControl()

_cameraCanBeControlled=false
_touchCount=-1
end

function xianjieController:freezeCameraControl()
_cameraCanBeControlled=false
_touchCount=0
_isDraging=false
end

function xianjieController:resumeCameraControl()

_cameraCanBeControlled=true
end

function xianjieController:getCameraControl()

local checkMiJing=not MysteryModel:is_in_mystery()
return _cameraCanBeControlled and
checkMiJing and
not xianjieController:check2DMapModel()and
not self.isInStoryModel
end

function xianjieController:onClickEvent(screenPoint)
if xianjieModel:checkSceneState_clickScene()then
return
end

local clickDataList=self.manager:ClickCameraAllByScreenSpacing(screenPoint,bit.lshift(1,helper.LAYER_ACTOR))
if clickDataList~=nil and clickDataList.Length>0 then
xianjieController:triggerClickEntities(clickDataList)
else
local pos=self.manager:GetScreenPos2PlanePos(screenPoint)
local mapResPos=xianjieController:get_mapResPos()
if pos.y~=mapResPos[2]then return end
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)

local sceneidx=xianjieModel:getSceneIndex()
local isValid=xianjieController:checkGridInMap(gridX,gridZ,sceneidx)






if xianjieModel:checkClickSceneState(sceneidx,gridX,gridZ,xjSceneStateType.eMoveZongMen,isValid)then

elseif xianjieModel:checkClickSceneState(sceneidx,gridX,gridZ,xjSceneStateType.eMoveXianMeng,isValid)then

elseif xianjieModel:checkClickSceneState(sceneidx,gridX,gridZ,xjSceneStateType.eClickEmpty,isValid)then


elseif xianjieController:checkClickCloud(sceneidx,gridX,gridZ,isValid)then

elseif xianjieModel:checkClickLeyLine(sceneidx,gridX,gridZ)then

elseif xianjieModel:checkClickPosisForce(sceneidx,gridX,gridZ)then


elseif xianjieController:findTouchEntityWithGrid(sceneidx,gridX,gridZ,pos)then

elseif xianjieController:checkClickCloseSideWin()then


elseif xianjieController:checkClickEmptyPos(sceneidx,gridX,gridZ,pos,isValid)then

end
end
end

function xianjieController:onDragEvent(screenPoint)
if not xianjieModel:checkSceneState_moveScene()then
local campos=xianjieController:getCameraPosition()
local heightFixed=1-math.min(campos.y/_maxCameraY,0.8)
self.manager:MoveCameraByScreenSpacing(_swipe_begin_source_pos,_swipe_begin_screen_point,screenPoint,_cameraParam1,_cameraParam2*heightFixed)
notifySystem:postNotify(notifyConfig.onXianJieCameraMove)
end
end

function xianjieController:onZoomEvent(deltaPinch,deltaTime)
if not fullScreenUI.isActiveFull()then
if not xianjieModel:checkSceneState_zoomScene()then
self.manager:ZoomCameraByScreenSpacing(-deltaPinch*deltaTime*_cameraParam3)
notifySystem:postNotify(notifyConfig.onXianJieCameraZoom)
end
end
end













function xianjieController:onDrayEntity(ent,screenPoint)
local w=UnityEngine.Screen.width
local h=UnityEngine.Screen.height

local topLeftX=0
local topLeftY=h
local bottomRightX=w
local bottomRightY=0
local scaleFactor=xianjieController:getUIScaleFactor()
topLeftX=topLeftX+_dragEntityOffset[1]*scaleFactor.x
bottomRightX=bottomRightX+_dragEntityOffset[2]*scaleFactor.x
bottomRightY=bottomRightY+_dragEntityOffset[3]*scaleFactor.y
topLeftY=topLeftY+_dragEntityOffset[4]*scaleFactor.y

local vx,vy
if screenPoint.x>=topLeftX and screenPoint.x<=bottomRightX then
vx=0
elseif screenPoint.x<topLeftX then
vx=-1
else
vx=1
end
if screenPoint.y>=bottomRightY and screenPoint.y<=topLeftY then
vy=0
elseif screenPoint.y<bottomRightY then
vy=-1
else
vy=1
end

local pos=self.manager:GetScreenPos2PlanePos(screenPoint)
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
if vx==0 and vy==0 then
ent:refreshPos(gridX,gridZ)
_drayEntityDelay=nil
else
local cur=Time.realtimeSinceStartup
if _drayEntityDelay==nil or cur>=_drayEntityDelay then
_drayEntityDelay=cur+_drayEntityDelayTime
vx=vx*_dragEntitySpeed[1]
vy=vy*_dragEntitySpeed[2]
local pos_=self.manager:GetScreenPos2PlanePos(Vector2(w/2,h/2))
local gridX_,gridZ_=xianjieController:worldPos2WorldGridPos(pos_.x,pos_.z)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX_+vx,gridZ_+vy,1,1)
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c)
xianjieController:lookAtPositionChangeHeight(lookpos,nil,_drayEntityDelayTime,nil,DG.Tweening.Ease.Linear)
ent:refreshPos(gridX,gridZ)
end
end
end


function xianjieController:getEntitysByScreenPoint(screenPoint)
local clickDataList=self.manager:ClickCameraAllByScreenSpacing(screenPoint,bit.lshift(1,helper.LAYER_ACTOR))
if clickDataList~=nil and clickDataList.Length>0 then
local list={}
for i=1,clickDataList.Length do
local clickData=clickDataList[i-1]
local boxParams=clickData.args
local paramsCnt=#boxParams
local ent_key=boxParams[paramsCnt]
list[i]=ent_key
end
return list
end
end

function xianjieController:getXJClientBuildSceneIndex(xjClientBuildID)
local config=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,xjClientBuildID)
if config then
if config.sceneidx then
return config.sceneidx
end
if config.devildom then
return xianjieModel:getCurrentMoJieSceneIndex()
end
end



end

local _preCheckType={
eInMoGongZhengDuo=1
}

function xianjieController:enterXianJiePreCheck(preCheckRecord,sceneType,enterParam,enterCall)
local isSkip=enterParam and enterParam.isSkipChangeSceneCheck or false
if isSkip then return true end


preCheckRecord=preCheckRecord or{}

local tsceneidx=xianjieModel:getSceneIndex(sceneType)
local sceneIdx=xianjieModel:getSceneIndex()
if(not xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx))and(not xianjienSceneIndexType:isMoGongZhengDuo(tsceneidx))then
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eMoGongZhengDuo)and moGongZhengDuoActModel:checkInSceneFlag()then
local logicName=xianjieController:getSceneIdxLogicName(tsceneidx)
local content=FMT.fmt("宗门正在魔尊宝库,暂无法前往{0}",logicName)
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end
end

if sceneIdx==nil then return true end

if preCheckRecord[_preCheckType.eInMoGongZhengDuo]~=1 then
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then

local num=xianjieModel:getWaiPaiTeamNum()

if num>0 then
local show_data={
type='UIDialouge',
title='提示',
content="有队伍在外，无法退出活动",
oktext='确定',
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

local yzNum=YingXianGeModel:getWithMyYZTotal()

if yzNum>0 then
local show_data={
type='UIDialouge',
title='提示',
content="存在援助自己的队伍，无法退出活动",
oktext='确定',
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

local show_data={
type='UIDialouge',
title='提示',
content="确定要退出活动？\n<color=#c82c2c>（积分不会清除，10分钟后可再次进入）</color>",
oktext='确定',
canceltext='取消',
okcallback=function()
preCheckRecord[_preCheckType.eInMoGongZhengDuo]=1
xianjieController:enterXianJie(sceneType,enterParam,enterCall,preCheckRecord)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()


return false
end
preCheckRecord[_preCheckType.eInMoGongZhengDuo]=1
end

return true
end

function xianjieController:transSceneIdxToLogicSceneType(sceneIdx)
if sceneIdx then
if xianjienSceneIndexType:isMoJie(sceneIdx)then
return eXianJieLogicSceneType.eMoJie
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
return eXianJieLogicSceneType.eMoGong
else
return eXianJieLogicSceneType.eXianJie
end
end

end

function xianjieController:getSceneIdxLogicName(sceneIdx)
if xianjienSceneIndexType:isMoJie(sceneIdx)then
return"魔界"
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
return"魔宫"
else
if xianjienSceneIndexType:isXianYu(sceneIdx)then
return"仙域"
else
return"仙界"
end
end
end

function xianjieController:checkInMoGongZhengDuo(sceneIdx)
sceneIdx=sceneIdx or xianjieModel:getSceneIndex()
if sceneIdx==nil then return false end
return xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)
end

function xianjieController:getLampLookAtCameraheight(val,lod)
local dval=val

local sceneType=xianjieModel:getScenceType()
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)

local lodRange=sceneCfg.lodRange
local lodRange_MiniGame=sceneCfg.lodRange_MiniGame

local rate=val/lodRange[lod]
dval=rate*lodRange_MiniGame[lod]


local range=xianjieController:getCameraZoomRange()
if range then
dval=Mathf.Clamp(dval,range[1],range[2])
end

return dval
end

