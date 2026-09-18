






local _MODULENAME="MysteryController"



_HexMapManager=CS.HexagonMapManagerInterface
local _Screen=UnityEngine.Screen


gameState.addListener(def_table(_MODULENAME))
MysteryController.name=_MODULENAME
MysteryController.data={}

function Vector3Int(x,y,z)
return _HexMapManager.Vector3ToVector3Int(Vector3(x,y,z))
end

MysteryController.MapLayerLookUp=
{
[HexMapType.Main]=
{
GroundLayer=HexMapLayer.Ground,
DataLayer=HexMapLayer.Data,
},
[HexMapType.Room]=
{
GroundLayer=HexMapLayer.Room,
DataLayer=HexMapLayer.RoomData,
},
[HexMapType.Room2]=
{
GroundLayer=HexMapLayer.Room2,
DataLayer=HexMapLayer.RoomData2,
},
}


local hideObjType=
{
objectType.eRole,
objectType.eStillSundrise,
objectType.eMovementSundrise,
objectType.eFangKe,
objectType.eVisitRole,
objectType.eZMVisitor,
objectType.eXianChong,
objectType.eYunYouMerchant,
}


MysteryController.mapPath="/config/mjmap/map/"


local cameraSize=6.5
local cameraWidth=_Screen.width/_Screen.height*cameraSize
MysteryController.isFixVector=false
local _touch_scale
local _default_dpi=96


local _isDrag
local borderAngle=90
local _camera_begin_pos,_swip_begin_pos,_swip_update_pos



local beforeBgm=nil


function MysteryController:onAppStart()

MysteryModel:on_app_start()



socketManager:register_receiver(4,1,MysteryController.recv_4_1)
socketManager:register_receiver(4,2,MysteryController.recv_4_2)
socketManager:register_receiver(4,3,MysteryController.recv_4_3)
socketManager:register_receiver(4,4,MysteryController.recv_4_4)
socketManager:register_receiver(4,5,MysteryController.recv_4_5)
socketManager:register_receiver(4,6,MysteryController.recv_4_6)
socketManager:register_receiver(4,8,MysteryController.recv_4_8)
socketManager:register_receiver(4,9,MysteryController.recv_4_9)
socketManager:register_receiver(4,11,MysteryController.recv_4_11)
socketManager:register_receiver(4,13,MysteryController.recv_4_13)
socketManager:register_receiver(4,16,MysteryController.recv_4_16)
socketManager:register_receiver(4,20,MysteryController.recv_4_20)
socketManager:register_receiver(4,21,MysteryController.recv_4_21)
socketManager:register_receiver(4,27,MysteryController.recv_4_27)
socketManager:register_receiver(4,36,MysteryController.recv_4_36)
socketManager:register_receiver(4,42,MysteryController.recv_4_42)
socketManager:register_receiver(4,43,MysteryController.recv_4_43)
socketManager:register_receiver(4,51,MysteryController.recv_4_51)
socketManager:register_receiver(4,54,MysteryController.recv_4_54)
socketManager:register_receiver(4,55,MysteryController.recv_4_55)
socketManager:register_receiver(4,56,MysteryController.recv_4_56)
socketManager:register_receiver(4,58,MysteryController.recv_4_58)
socketManager:register_receiver(4,59,MysteryController.recv_4_59)
socketManager:register_receiver(4,60,MysteryController.recv_4_60)
socketManager:register_receiver(4,63,MysteryController.recv_4_63)
socketManager:register_receiver(4,64,MysteryController.recv_4_64)
socketManager:register_receiver(4,65,MysteryController.recv_4_65)
socketManager:register_receiver(4,66,MysteryController.recv_4_66)

socketManager:register_receiver(4,80,MysteryController.recv_4_80)

socketManager:register_receiver(4,81,MysteryController.recv_4_81)
socketManager:register_receiver(4,82,MysteryController.recv_4_82)
socketManager:register_receiver(4,25,MysteryController.recv_4_25)

socketManager:register_receiver(4,83,mysteryTrap.recv_4_83)
socketManager:register_receiver(4,84,mysteryTrap.recv_4_84)
socketManager:register_receiver(4,85,mysteryTrap.recv_4_85)







self.on_mystery_enter=function(fbid,isFirst)


UIManager:showWindow('UIMysteryHUDWin')

beforeBgm=AudioManager.getCurrentBgm()
AudioManager.setGroupMute(SOUND_GROUP_TYPE.scene3d,false)
sceneAudioModel:setAudioShieldState(true)
sceneAudioController:playMysteryBgMusic()

_HexMapManager.SetUseFixVector(true)
notifySystem:listenNotify(notifyConfig.swipeStart,self.on_swipe_start)
notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.swipeEnd,self.on_swipe_end)
notifySystem:listenNotify(notifyConfig.touchUp,self.on_touch_up)
notifySystem:listenNotify(notifyConfig.touchDown,self.on_touch_down)
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:listenNotify(notifyConfig.on_mystery_remove_entity,self.removeEntityCb)
notifySystem:listenNotify(notifyConfig.pinch,self.on_pinch)

if worldController:isInWorld()then
worldController:stopCameraControl()
worldController:showCamera(false)
worldController:displayHUD(false)
end

if mainControl:isInScene(eSceneType.eZongmen)then
isometricMapSystem:enterStoryMode()
isometricMapSystem:setCameraActive(false)

hudControl:setContainerGRActive(hudContainerType.eDefault,false)

MysteryController:showZongMenObj(false)
end

if xianjieModel:isInitScene()then
xianjieController:stopCameraControl()
xianjieController:activeXianJieHud(false)
xianjieController:openCinema(false)
xianjieController:clearScene(false)
end

if guildOrderModel:isOrderSetupOpenEx(GUILD_ORDER_TYPE.eMysteryMoveAcc)then
MysteryModel:setMoveAcc(2)
else
MysteryModel:setMoveAcc(1)
end

if self.enterTimeOut then
self.enterTimeOut:cancel()
end
self.enterTimeOut=timeEventController.delayDo(15,function()
UIManager.error("该秘境暂时无法进入,请稍后重试")
self.on_mystery_quit(true)
baseFullScreenUI:openMain(true)
end)
MysteryController:loadMap(function()
fullScreenUI.closeActiveUI(false,true)

MysteryModel.currentFBData.isFirst=isFirst
if isFirst then
UIManager:showWindow("UIMysteryTargetStartWin")
end
local sizeRange=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"cameraSizeRange")
cameraSize=sizeRange[1]
mysteryCameraController.setCameraSize(cameraSize)
MysteryModel:set_Mystery_enter(true)
local fbId=MysteryModel:get_cur_fbid()

MysteryController.send_4_9(fbId)

MysteryController:loadFBTile(fbId,function()

MysteryController:initMap(fbId)

MysteryController.send_4_21(fbId)

sceneAudioController:playMysteryBgMusic()

mysteryAIManager:set_mystery_state(false)

end)
end)





end

self.on_mystery_quit=function(leaveState)
local fbid=MysteryModel:get_cur_fbid()

if(not MysteryModel:is_enter_Mystery())and(not fbid)then

return
end

mysteryCameraController:disableScreenEffect()
mysteryAIManager:set_mystery_state(false)

if mainControl:isInScene(eSceneType.eZongmen)then
isometricMapSystem:leaveStoryMode()
isometricMapSystem:setCameraActive(true)

hudControl:setContainerGRActive(hudContainerType.eDefault,true)

MysteryController:showZongMenObj(true)
end
if xianjieModel:isInitScene()then
xianjieController:resumeCameraControl()
xianjieController:activeXianJieHud(true)
xianjieController:openCinema(true)
xianjieController:clearScene(true)
end
MysteryGuildOrder:setAutoStart(false)
MysteryGuildOrder:stopAuto()

local finishType=MysteryModel:get_fb_finish()

MysteryModel:set_fb_finish(nil)
local finishPlot
if fbid then
MysteryModel:clearInfo(fbid)
finishPlot=cfgHelper.get2(cfg_secretscenefubenconfig_get,fbid,"finishPlot")
else
loggerUtil.debugErrFMT("退出副本时fbid为nil")
end

UIManager:closeWindow('UIMysteryHUDWin')

MysteryController:stopCreateTimer()
mysteryCameraController:stopCameraTween()
mysteryEntityController.invokeAllModelsFunc("clear_entity_list")
MysteryModel:set_Mystery_enter(false)
mysteryAIManager:stop_ai()


mysteryPlayerController:showGrassWindow(false,true)
UIManager:closeWindow("UIWorldBossWin")
UIFullMysteryMainControl:closeUI()


UIFullMysteryEventControl:closeUIEX()
UIFullMysteryMainControl:closeMysteryMainWindow()
UIFullMysteryShopControl:closeUI()
UIFullStoryBoardControl:closeUI()


if beforeBgm then
AudioManager.playBgMusic(beforeBgm)
end
AudioManager.setGroupMute(SOUND_GROUP_TYPE.scene3d,true)
sceneAudioModel:setAudioShieldState(false)

local startCallback=function()
_HexMapManager.ClearMapAsset()
MysteryModel:set_cur_fbid(nil)
MysteryModel.loadingTile={}

if not finishType then
finishType=eMysteryQuitType.eBreak

end

MysteryModel:call_fb_exit(fbid,finishType,leaveState)
MysteryModel:clear_fb_exit()

if not leaveState then

if mainControl:isInScene(eSceneType.eWorld)and MysteryModel:is_practice_mystery(fbid)and finishType~=eMysteryQuitType.eFinish and worldController:checkNoticiateBlockOpen()then

if not strengthenController.strengthenByMysteryLeaveData then
baseFullScreenUI:openMain(true)
worldExperienceController:retreatExperience(true)
end
end
if finishPlot then
MysteryController.activePlot(finishPlot)
end
end

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
notifySystem:postNotify(notifyConfig.on_mystery_quit_finish,fbid,finishType)
end

local noCloudFlag=MysteryModel:getQuitNoCloudFlag()
if leaveState or(finishPlot and finishPlot[1]==1)or noCloudFlag==true then
startCallback()
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=startCallback,
})
end
MysteryModel:setQuitNoCloudFlag(nil)

notifySystem:removelistener(notifyConfig.swipeStart,self.on_swipe_start)
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.swipeEnd,self.on_swipe_end)
notifySystem:removelistener(notifyConfig.touchUp,self.on_touch_up)
notifySystem:removelistener(notifyConfig.touchDown,self.on_touch_down)
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:removelistener(notifyConfig.on_mystery_remove_entity,self.removeEntityCb)
notifySystem:removelistener(notifyConfig.pinch,self.on_pinch)

UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eShangGuXianDi)
end

notifySystem:listenNotify(notifyConfig.on_mystery_enter,self.on_mystery_enter)
notifySystem:listenNotify(notifyConfig.on_mystery_quit,self.on_mystery_quit)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)
notifySystem:listenNotify(notifyConfig.onStopMissionInWorld,self.onStopMissionInWorld)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)

notifySystem:listenNotify(notifyConfig.on_mystery_config_load,self.onMysteryConfigLoad)




worldController:registerSceneState(1,1,function()
MysteryController:showWorldAllUnit(worldModel.world)
end)



end


function MysteryController:onEnterState()

local dpi=_Screen.dpi
_touch_scale=dpi>0 and _default_dpi/dpi or 1

MysteryController.isPassMysteryAreaCheck=false

MysteryModel:on_enter_state()
end


function MysteryController:onLeaveState(isReconnet)

if isReconnet then
MysteryController:removeAllUnit()
end

if MysteryModel:is_enter_Mystery()then
self.on_mystery_quit(true)
end

mysteryAIManager:reset_pause()

MysteryModel:on_leave_state()



self.data={}
_camera_begin_pos=nil
_swip_begin_pos=nil

MysteryController.isPassMysteryAreaCheck=nil
MysteryController.isClearMysteryCloud=nil
end

function MysteryController.setTreasureMap()
local temp=userActorSetting.get("treasureMapData",nil)

if temp then

for k,v in pairs(temp)do

MysteryModel:setTreasureMapUseCount(tostring(v),true)
end
end
end

function MysteryController:showZongMenObj(flag)
for i,v in ipairs(hideObjType)do
_MapManager.SetObjectDisplay(v,flag)
end
end

function MysteryController:onProtocolReq()

end

function MysteryController:onLostConnection()
if MysteryModel:is_in_mystery()then
if mysteryAIManager.is_on_round()then
mysteryAIManager:set_mystery_state(true)
mysteryAIManager:stop_ai()
end
end
end


function MysteryController.activePlot(params)
local activeType=params[1]
local param1=params[2]
local sceneType=mainControl:getSceneType()
if activeType==1 then

if sceneType==eSceneType.eZongmen then
storyAIManager:startStoryBehavior(param1)
else
mainControl:enterHome({eSceneType.eZongmen,{callback=function()
storyAIManager:startStoryBehavior(param1)
end}})
end
end
end

function MysteryController.onStopMissionInWorld(key,unitType,fbid)







end

function MysteryController:refreshTime()
local FBCreateTime=MysteryModel:get_mysteryFB_create_CD()

if FBCreateTime>0 then
local curTime=timeHelper.getServerShortTime()
local FBCreateCD=FBCreateTime==-1 and FBCreateTime or FBCreateTime-curTime
local cd=FBCreateCD
if cd>0 then
if self.addTimer then
self.addTimer:cancel()
self.addTimer=nil
end
self.addTimer=timeEventController.delayDo(cd,function()MysteryController:refreshTime()end)
else
MysteryController.send_4_2()
end
end
end



function MysteryController:loadMap(callback)
_HexMapManager.LoadMap('tilemap/map/hexgrid.ab','HexGrid',function()
if callback then
callback()
end
local fbid=MysteryModel:get_cur_fbid()
if fbid then
local backgroundColor=cfg_secretscenefubenconfig_get(fbid).backgroundcolor or'#c8ebd1'
_HexMapManager.SetCameraBackgroudColor(backgroundColor)
end
end)
end

function MysteryController:loadTile(groupid,callback)
local cfg_surfacegroup=cfg_secretscentsurfacegroupconfig_get(groupid)
if cfg_surfacegroup then

MysteryModel.loadingTile[groupid]=true
_HexMapManager.LoadTile(cfg_surfacegroup.abname,cfg_surfacegroup.resname,function()
if next(MysteryModel.loadingTile)then
MysteryModel.loadingTile[groupid]=nil
if not next(MysteryModel.loadingTile)then
if callback then
timeEventController.delayDo(0.02,callback)
end
end
end
end)
end
end

function MysteryController:Paint(pos,groupid,configid,layer,height)
height=height or 0
_HexMapManager.Paint(pos,groupid,configid,layer,height)
end

function MysteryController:setGridSize(x,y,z)
_HexMapManager.SetGridSize(x,y,z)
end

function MysteryController:screenToMapPos(screenpoint,layer)
return _HexMapManager.ScreenPointToCell(screenpoint,0,layer)
end

function MysteryController:setCamera(bpos,spos,epos)
local camera=_HexMapManager.GetMainCameratransform()
if camera then
local worldpos=_HexMapManager.ScreenToWorldPoint(epos);
local beginPos=_HexMapManager.ScreenToWorldPoint(spos);
local is_border,pos=mysteryCameraController:checkCameraPosition(bpos-worldpos+beginPos)
camera.position=pos
end


end


function MysteryController:loadFBTile(fbID,callback)
MysteryController:loadTile(0,callback)

local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
if cfg_fb then
for i,v in ipairs(cfg_fb.blocksurface)do
MysteryController:loadTile(v[1],callback)
end
if cfg_fb.roomsurface then
for i,v in ipairs(cfg_fb.roomsurface)do
MysteryController:loadTile(v[1],callback)
end
end
for i,v in ipairs(cfg_fb.walksurface)do
MysteryController:loadTile(v[1],callback)
end
end
end

function MysteryController:loadAllFBTile()
local cfg_surfacegroup=cfg_secretscentsurfacegroupconfig()
if cfg_surfacegroup then
for id,v in pairs(cfg_surfacegroup)do
MysteryController:loadTile(id)
end
end
end



function MysteryController:setCameraBorder(mapType)






local angle=borderAngle
local cfg_fb=cfg_secretscenefubenconfig_get(MysteryModel:get_cur_fbid())
local grid_size=cfg_fb.gridsize
local gridX=grid_size[1]
local gridY=grid_size[2]-(grid_size[2])/4
local roomID=mysteryRoomModel:get_cur_roomID()
local map_size=mysteryRoomModel:get_room_map_area(roomID)
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
local WorldPos=_HexMapManager.GetCellCenterWorld(Vector3(0,0,0),groundLayer)
if mapType==HexMapType.Main then
local map_size=mysteryRoomModel:get_room_map_area(0)
local length=gridX*(map_size[1])
local width=gridY*(map_size[2]+2)
if cfg_fb.border then
_HexMapManager.SetMapBorder(gridX*cfg_fb.border[1],gridY*cfg_fb.border[3]-99999,gridX*cfg_fb.border[2],gridY*cfg_fb.border[4],WorldPos.x,WorldPos.y,90)
mysteryCameraController:setMapBorder(gridX*cfg_fb.border[1],gridY*cfg_fb.border[3],gridX*cfg_fb.border[2],gridY*cfg_fb.border[4],WorldPos.x,WorldPos.y,0)
mysteryCameraController:setCameraBorder(0,0,0,0)
else
_HexMapManager.SetMapBorder(0,0,length,width,WorldPos.x,WorldPos.y,angle)
mysteryCameraController:setMapBorder(0,0,length,width,WorldPos.x,WorldPos.y,angle)
local leftOffset=0
if angle==90 then
leftOffset=width/math.tan(angle*180/math.pi)
end
if map_size[1]<5 and map_size[2]<5 then
_HexMapManager.SetMoveCameraBorder(leftOffset,0,0,0)
mysteryCameraController:setCameraBorder(leftOffset,0,0,0)
else
_HexMapManager.SetMoveCameraBorder(-cameraWidth/2+leftOffset+5,-cameraSize/2,-cameraWidth/2,-cameraSize/2)
mysteryCameraController:setCameraBorder(-cameraWidth/2+leftOffset+5,-cameraSize/2,-cameraWidth/2,-cameraSize/2)
end
end


elseif mapType==HexMapType.Room or mapType==HexMapType.Room2 then
local length=gridX*(map_size[1])
local width=gridY*(map_size[2]+1)
_HexMapManager.SetMapBorder(0,0,length,width,WorldPos.x,WorldPos.y,angle)
mysteryCameraController:setMapBorder(0,0,length,width,WorldPos.x,WorldPos.y,angle)
local leftOffset=0
if angle==90 then
leftOffset=width/math.tan(angle*180/math.pi)
end
if map_size[1]<5 and map_size[2]<5 then
_HexMapManager.SetMoveCameraBorder(leftOffset,0,0,0)
mysteryCameraController:setCameraBorder(leftOffset,0,0,0)
else
_HexMapManager.SetMoveCameraBorder(-cameraWidth/2+leftOffset,-cameraSize/2,-cameraWidth/2,-cameraSize/2)
mysteryCameraController:setCameraBorder(-cameraWidth/2+leftOffset,-cameraSize/2,-cameraWidth/2,-cameraSize/2)
end
elseif mapType==nil then
_HexMapManager.SetMapBorder(0,0,0,0,0,0,0)
mysteryCameraController:setMapBorder(0,0,0,0,0,0,0)
end
end

function MysteryController:getPath(beginPos,endPos,steps,layer)
local beginPoint=Vector3(beginPos.x,beginPos.y,0)
local endPoint=Vector3(endPos.x,endPos.y,0)

steps=steps or 0
layer=layer or HexMapLayer.Ground
isometricMapSystem:enableFindPathLimit(false)
local pathObj=_HexMapManager.GetMovePath(beginPoint,endPoint,steps,layer)
isometricMapSystem:enableFindPathLimit(true)
local posList={}
local roomId=mysteryRoomModel:get_cur_roomID()
local isEndPosSurfaceHide=false
local endPosSurface=mysteryRoomModel:get_grid_pos_data(roomId,endPos.x,endPos.y)
if endPosSurface then
local surfaceCfg=cfgHelper.get(cfg_secretscentsurfaceconfig_get,endPosSurface.surfaceId)
local hideId=surfaceCfg.hide
if hideId then
isEndPosSurfaceHide=true
end
end
if pathObj then
local index=1
local iter=pathObj:GetEnumerator()
while iter:MoveNext()do
local point=iter.Current
if point then
local surfaceData=mysteryRoomModel:get_grid_pos_data(roomId,point.x,point.y)
if surfaceData then
local surfaceCfg=cfgHelper.get(cfg_secretscentsurfaceconfig_get,surfaceData.surfaceId)
local hideId=surfaceCfg.hide
if hideId then

if not isEndPosSurfaceHide then
return{}
end
table.insert(posList,point)
if index~=1 then
if not mysteryPosHelper.is_same_pos(point,endPos)then
posList={}
end
break
end
else
table.insert(posList,point)
end
else
break
end
end
index=index+1
end
end

return posList
end

function MysteryController:playMoveToPath(GUID,pathObj,steps,callback,pointCallBack,layer,beginCallBack,prepareCallBack,outSequence)
layer=layer==nil and HexMapLayer.Ground or layer

return mysteryEntityController.entityMoveTo(GUID,pathObj,steps,callback,pointCallBack,layer,beginCallBack,prepareCallBack,outSequence)
end




function MysteryController:initFBStage(fbID,roomId)
if not fbID then
fbID=MysteryModel:get_cur_fbid()
end
local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
if cfg_fb.bgStage then
local sType=roomId==0 and 1 or 2
if cfg_fb.bgStage[sType]then
local stageName=cfg_secretscenestageconfig_get(cfg_fb.bgStage[sType]).abname
_HexMapManager.LoadStage(stageName)
end
end
end




function MysteryController.initUI()

MysteryController:stopCreateTimer()


MysteryController.targetEffect()
end


function MysteryController:slideUI()
UIManager:invokeUIMethod("UIMysteryWin","onButtonTeamHide")
UIManager:invokeUIMethod("UIMysteryWin","onButtonSkillHide")
UIManager:invokeUIMethod("UIMysteryTargetWin","onHideButton")
UIManager:invokeUIMethod("UIMysteryMiniWin","onShowButton")
end




function MysteryController:CreateMapBackGround(roomID,worldPos)
local id=_HexMapManager.CreateFogObject(1,worldPos)
if id~=-1 then
mysteryFogModel:insert_room_fog_effect(roomID,id)
end
end



function MysteryController.on_swipe_start(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if pause then
return
end
if MysteryModel:is_enter_Mystery()and touchCount==1 then

mysteryPlayerModel:set_focus_flag(nil)
_swip_update_pos=nil
_swip_begin_pos=screenPoint
_camera_begin_pos=mysteryCameraController.GetCamaraPosition()
end
end

function MysteryController.on_swipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if touchCount~=1 then
return
end
if not MysteryModel.currentFBData.isMapInit then
return
end
if not MysteryModel:is_enter_Mystery()then
return
end

local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if pause then
return
end
if(not _camera_begin_pos)or(not _swip_begin_pos)then
return
end
_isDrag=true
if MysteryModel:is_enter_Mystery()then

MysteryController:setCamera(_camera_begin_pos,_swip_begin_pos,screenPoint)
if not _swip_update_pos then
_swip_update_pos=screenPoint
end
if screenPoint.x<_swip_update_pos.x then
mysteryCameraController:setBgCameraRotate(0,-0.05,0)
elseif screenPoint.x>_swip_update_pos.x then
mysteryCameraController:setBgCameraRotate(0,0.05,0)
end
_swip_update_pos=screenPoint

end

end

function MysteryController.on_swipe_end(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
_swip_begin_pos=nil
_camera_begin_pos=nil
end

function MysteryController.isDrag()
return _isDrag
end

function MysteryController.on_touch_down(fingerIndex,touchCount,screenPoint)
if touchCount~=1 then
return
end
if not MysteryModel:is_enter_Mystery()then
return
end
end

function MysteryController.on_touch_up(fingerIndex,touchCount,screenPoint,guid)
if touchCount~=1 then
return
end
if not MysteryModel:is_enter_Mystery()then
return
end










local roomID=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer

local point=MysteryController:screenToMapPos(screenPoint,groundLayer)
if not point then
return
end

local pos=_HexMapManager.Vector3IntToVector3(point)
MysteryController.onMapClick(pos)
end

function MysteryController.on_pinch(fingerIndex,touchCount,screenPoint,deltaPinch,deltaTime)
if not MysteryModel:is_enter_Mystery()then
return
end

if mysteryCameraController.isCameraMove then
return
end
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if pause then
return
end

local size=mysteryCameraController.getCameraSize()
size=size-deltaPinch*deltaTime*_touch_scale
mysteryCameraController.setCameraSize(size)
end


function MysteryController.onMapClick(pos,checkMonster)
if _isDrag then
_isDrag=false
return
end

if not MysteryModel:is_enter_Mystery()then
return
end

if not MysteryModel.currentFBData.isMapInit then
return
end


if not MysteryModel.currentFBData.isMysteryInit then
return
end

if mysteryTriggerManager.isInTrigger then

local plotData=mysteryTriggerGamePlot:getGamePlotData()
if plotData then
local now=timeHelper.getServerShortTime()
local plotStartTime=plotData[1]
if now-plotStartTime>5 then
mysteryTriggerGamePlot:showGamePlotDialog()
end
end
return
end

local pause=mysteryAIManager:is_pause(nil,true)
if pause then
return
end

if mysteryCameraController.isCameraMove then
return
end

local fbid=MysteryModel:get_cur_fbid()
if MysteryModel:is_use_power(fbid)and MysteryModel:get_fb_power()<=0 then
MysteryController:showPowerWarring()
return
end

if UIManager:isActive("UIWorldBossWin")then
UIFullMysteryMainControl:closeWindow("UIWorldBossWin")
end

local roomID=mysteryRoomModel:get_cur_roomID()


if not mysteryPlayerModel:has_player()then
return
end

local vec3Int=Vector3Int(pos.x,pos.y,pos.z)


if MysteryModel:is_border(roomID,pos)then
return
end


if not mysteryFogModel:get_fog_data(roomID,pos.x,pos.y)then
UIManager.error("前方迷雾重重，无法前往")
return
end


if(#mysteryPlayerModel:get_last_path()==mysteryPlayerModel:get_last_steps()+2)then
return
end

if MysteryGuildOrder:isInAuto()then
UIManager.info("自动探索中...")
return
end


if mysteryAIManager.is_on_round()then
mysteryAIManager:stop_ai()
return
end


local is_flash=mysterySkillModel:is_in_skill_effect(eMysterySkillType.eFlash)
if is_flash then
mysterySkillEffectManager:use_skill(is_flash,{point=vec3Int,pos=pos})
return
end


local is_hold=mysterySkillModel:is_in_skill_effect(eMysterySkillType.eHold)
if is_hold then
mysterySkillEffectManager:use_skill(is_hold,{point=vec3Int,pos=pos})
return
end

local is_yfhy=mysterySkillModel:is_in_skill_effect(eMysterySkillType.eYuFengHanYing)
if is_yfhy then
mysterySkillEffectManager:use_skill(is_yfhy,{point=vec3Int,pos=pos})
return
end

local is_tys=mysterySkillModel:is_in_skill_effect(eMysterySkillType.eTanYunShou)
if is_tys then
mysterySkillEffectManager:use_skill(is_tys,{point=vec3Int,pos=pos})
return
end


if not checkMonster then
mysteryMonsterModel:clear_monster_select()
local monsterList=mysteryMonsterModel:get_all_entity_list_by_pos(pos,roomID)
if monsterList and next(monsterList)then
mysteryMonsterController.showInfoWin(monsterList)
return
end
end

local lingshouList=mysteryLingShou:get_all_entity_list_by_pos(pos,roomID)
if lingshouList and next(lingshouList)then
if lingshouList[1]and lingshouList[1].data then
local lingshou=lingshouList[1].data.lingshou
if lingshou or lingshouList[1].data.hulu then

MysteryLingshouModel:dealCatch()
return
end
end
end





if mysteryTriggerPointController.handle_click(pos,roomID)then
return
end

if mysteryPosHelper.is_same_pos(mysteryPlayerModel:get_player_pos(),pos,roomID,roomID)then
return
end



if mysteryAIManager.create_path(pos)then

mysteryAIManager:start_ai()

local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
UIManager:invokeUIMethod("UIMysteryHUDWin","addEndPointHUD",pos,groundLayer)
else
UIManager.error("此处无法通行")
end
end


function MysteryController.onClickObjectInWorld(args)

if args and args[1]==worldModel.UNITTYPE.MYSTERY and args[2]then

AudioManager.playBtnClick()
MysteryController:openEnterWin(args[2])
end
end




function MysteryController.send_4_1(fbid,multi)




if MysteryController:checkFbMjShowType(fbid,5)then
if bagControl.checkShowFullEquipBagTips('无法继续探索')then
return
end
end


local zhenfa=MysteryModel:get_select_zhenFa()
socketManager:send_4_1(fbid,zhenfa,multi or 1)
end


function MysteryController.send_4_2()
socketManager:send_4_2()
end


function MysteryController.send_4_3(fbid)
socketManager:send_4_3(fbid)
end


function MysteryController.send_4_4(fbid)
socketManager:send_4_4(fbid)
end


function MysteryController.send_4_5(fbid,dontRefreshPos)

if not fbid then
return
end
MysteryModel.send_close_data=MysteryModel.send_close_data or{}
if dontRefreshPos then
MysteryModel.send_close_data[fbid]=dontRefreshPos
end


socketManager:send_4_5(fbid)
end


function MysteryController.select_dizi_and_skill(fbid,guidList,callback,selectZhenFa)
local ret,errType=downAssetManager:needDownLoadMiJing(fbid)
if ret then return end
local skillList={}
for i=1,3 do
local skillId=MysteryModel.data.tempSkillSelectSlot[i]
if skillId then
local skillCfg=mysterySkillModel.get_skill_config(skillId)
local needUnlock=skillCfg.unlock and skillCfg.unlock==1
if not(needUnlock and not QianJiGeModel:is_skill_unlock(skillId))then
table.insert(skillList,skillId)
end
end
end

local sendList={}
for i,v in ipairs(guidList)do
local data=v
data[3]=10000
data[4]=data[1]==1 and data[2]or int64.zero
table.insert(sendList,data)
end

socketManager:send_4_6(fbid,#skillList,skillList,#guidList,guidList)
if not callback then
callback=function(fbid,finishType,leaveState)
MysteryController.normal_finish(fbid,finishType,leaveState)
end
end
MysteryModel:set_select_zhenFa(selectZhenFa)
MysteryModel:set_fb_exit(callback)
end



function MysteryController.send_4_8(fbid,ruleid)
socketManager:send_4_8(fbid,ruleid)
end


function MysteryController.send_4_9(fbid)
socketManager:send_4_9(fbid)
end



function MysteryController.send_4_13(fbid)
socketManager:send_4_13(fbid)
end


function MysteryController.send_4_16(arg1,arg2)
socketManager:send_4_16(arg1,arg2)
end



function MysteryController.send_4_20()
socketManager:send_4_20()
end


function MysteryController.send_4_21(fbid)
socketManager:send_4_21(fbid)
end


function MysteryController.send_4_27()
socketManager:send_4_27()
end


function MysteryController.send_mystery_start()
socketManager:send_4_36()
end


function MysteryController.send_4_54(id)
socketManager:send_4_54(id)
end


function MysteryController.send_4_55()
socketManager:send_4_55()
end


function MysteryController.send_4_56(fbid)
socketManager:send_4_56(fbid)
end


function MysteryController.send_4_59(fbid,teamList,zhenfaId)
local len=#teamList
if len>0 then
socketManager:send_4_59(fbid,len,teamList,zhenfaId)
end
end


function MysteryController.send_4_63()
socketManager:send_4_63()
end


function MysteryController.send_4_65(itemGuid,num,etGuid,sendStatus)
socketManager:send_4_65(itemGuid,num,etGuid,sendStatus)
end


function MysteryController.send_4_66(x,y,etGuid)
socketManager:send_4_66(x,y,etGuid)
end


function MysteryController.recv_4_1(argtable)
if argtable[1]==0 then
MysteryGuildOrder:setAutoStart(false)
local fbId=argtable[2]
local fbIdx=argtable[15]
local curId=MysteryModel:get_cur_fbid()
if curId==argtable[2]then
return
end


UIFullFightPrepareControl:closeUI(false)

baseFullScreenUI:openMain(false)

MysteryModel:set_cur_fbid(argtable[2])

MysteryModel:clear_fb_data()

MysteryModel:updateMysteryFB_list_data(argtable[2],{tzStatus=1})

local roomID=argtable[3]
mysteryRoomModel:set_cur_roomID(0)
mysteryRoomModel:set_cur_birth_roomID(roomID)





if(argtable[6]>0)then
mysterySkillModel:set_fb_probeSkill(argtable[7])
end

if(argtable[8]>0)then
MysteryModel:set_fb_probeTeam(argtable[9])
end



MysteryModel:set_fb_power(argtable[12])
MysteryModel:set_fb_max_power(argtable[12])





MysteryModel:set_player_birth_pos(argtable[11],argtable[12])

UIManager:invokeUIMethod("UIMysteryWin","initData")

if not MysteryModel:get_fb_exit()then
local callback=function(fbid,finishType,leaveState)
MysteryController.normal_finish(fbid,finishType,leaveState)
end
MysteryModel:set_fb_exit(callback)
end

local first=argtable[13]==1
if first then
mysteryTreasureModel:clearRecordItemList(fbId)
end
local targetShowEnter=cfgHelper.get2(cfg_secretscenefubenconfig_get,argtable[2],"targetShowEnter")
if not targetShowEnter then
first=false
end

if MysteryModel:getMapConfig(fbId,fbIdx)then
MysteryModel:set_main_grid_data(fbId,fbIdx,argtable[5])
if(argtable[16]>0)then
MysteryModel:set_main_ent_birth_data(argtable[17])
end
notifySystem:postNotify(notifyConfig.on_mystery_enter,argtable[2],first)
else
MysteryModel:set_temp_grid_data(argtable[5],first,argtable[17])
MysteryController.req_4_80(fbId,0,fbIdx)
end



MysteryModel:set_select_zhenFa(argtable[14])




mysteryTriggerManager.req_4_57(argtable[2])

mysteryLinShiDiscipleController.req_4_17(argtable[2])
local cfg=cfg_secretscenefubenconfig_get(argtable[2])
local triggerItem=cfg.triggerItem
if triggerItem then
MysteryController.send_4_63()
end


mysteryWeekActivityModel:updateMysteryById(argtable[2],{tzStatus=1})
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eShangGuXianDi)
if systemModel.isOpen(SYSTEM_DEFINE.eMiJingRand)then
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(argtable[2])
if group then
MysteryController.send_4_3(argtable[2])
mysteryZiYuanFuBenModel:setZiYuanMysteryDataCurLayer(group[1],group[3])
mysteryZiYuanFuBenModel:setFbDataFBId(group[1],argtable[2])
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,table.concat({group[1],group[2]},'-')})
worldHUDModel:onUpdateHUD(unitKey)
end
end
end
end

function MysteryController.onMysteryConfigLoad(fbId,roomId,mapIndex)
if roomId==0 then
local gridData=MysteryModel:get_temp_grid_data()
local first=MysteryModel:get_temp_enter_first()
local birthData=MysteryModel:get_temp_birthData()
MysteryModel:set_main_grid_data(fbId,mapIndex,gridData)
if birthData then
MysteryModel:set_main_ent_birth_data(birthData)
end
notifySystem:postNotify(notifyConfig.on_mystery_enter,fbId,first)
end
end


function MysteryController.recv_4_2(countdown,currentFbid,fbListLen,fbList)
chatGGModel.initMijing(fbList)
MysteryModel:set_mysteryFB_list_data(countdown,currentFbid,fbList)
MysteryController:refreshTime()
UIManager:invokeUIMethod("UIMysteryListWin","refreshFBList")
fbList=fbList or{}
local fbLookUp={}
local posList={}
local refreshfbid111=false
if fbListLen>0 then
for i,v in ipairs(fbList)do


if v.ssFrom==eMysteryFromType.eItem then
MysteryModel:setTreasureMapUseCount(tostring(v.id),true)
end

local sence_type=MysteryModel:get_mystery_sence_type(v.id)
if sence_type==MysterySenceType.World or sence_type==MysterySenceType.ShangGuXianDi then
local areaId=v.quyuId
local arearCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
if arearCfg then
if arearCfg.fixPos then
if arearCfg.worldBlock then
fbLookUp[v.id]=v
table.insert(posList,v.guidPos)
end
else
if arearCfg.randomPos then
fbLookUp[v.id]=v
table.insert(posList,v.guidPos)
end
end
else

end
end
if v.id==111 then
refreshfbid111=true
end

if v.ssFrom==eMysteryFromType.eZongMen then
MysteryController:checkZongMenSundries(v)
end

MysteryModel:updateFBInfoData(v.id,{[2]=v.percent,[3]=v.difficulty})
end
end
local mysteryFB_unit=MysteryModel:get_all_mysteryFB_unit()or{}
for id,v in pairs(mysteryFB_unit)do
if not fbLookUp[id]then
MysteryController:remove_World_Mystery_unit(id)
end
end

worldPositionLibrary:checkData(eWorldUnitTpye.MYSTERY,posList)
for i,v in pairs(fbLookUp)do
local fbId=v.id
local posGuid=v.guidPos
local areaId=v.quyuId
MysteryController:add_World_Mystery_unit(fbId,areaId,posGuid)
end
worldModel:finishInit(eWorldUnitTpye.MYSTERY)

mysteryZiYuanFuBenModel:checkPosition()

UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eShangGuXianDi)
UIManager:invokeUIMethod("UIWorldFunctionButtonWin","refreshMjActBtn")

end

function MysteryController:checkZongMenSundries(mjData)
local id=mjData.id
local percent=mjData.percent

if percent==100 then
local cfg=cfgHelper.get(cfg_secretscenefubenconfig_get,id)
local sceneParam=cfg.sceneParam
local hasSundries=false
if sceneParam then
local sId=sceneParam[4]
local sundries=isometricMapSystem:getAllSundriesDataByType(-1,sundriseType.eMiJing)
if next(sundries)then
for i,v in pairs(sundries)do
if v.id==sId then
hasSundries=true
end
end
end
end
if not hasSundries then
MysteryController.send_4_5(id)
end
end
end


function MysteryController.recv_4_3(argtable)
local fbid=argtable[1]

MysteryModel:setTempSkillData(fbid,argtable[6]or{})

MysteryModel:set_mysteryFB_ndLevel(fbid,argtable[10])

MysteryModel:set_mysteryFB_environmentEffect(fbid,argtable[14])

MysteryModel:setFBInfoData(fbid,argtable)

mysteryWeekActivityModel:updateMysteryById(fbid,{percent=argtable[2],tzStatus=argtable[18],targetList=argtable[8]})

if UIManager:isActive("UIMysteryEnterWin")then
UIManager:invokeUIMethod("UIMysteryEnterWin","refreshWin",argtable)
end

if UIManager:isActive("UIMiJingWin")then
UIManager:invokeUIMethod("UIMiJingWin","refreshState",argtable)
end

UIManager:invokeUIMethod("UIMysteryWeekEnterWin","refreshWin",argtable)
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eShangGuXianDi)
UIManager:callWindowFunc("UIWorldFunctionButtonWin","refreshMjActBtn")
UIManager:invokeUIMethod("UIMysteryTargetStartWin","refreshTargetList",argtable[7],argtable[8])

local qiyuFunc=MysteryEventModel:getAfterMysteryInfoFunc()
if qiyuFunc then
qiyuFunc(argtable)
MysteryEventModel:afterGetMysteryInfoFunc()
end
end


function MysteryController.recv_4_4(arg1,fbid)
if arg1==0 then
MysteryModel:set_mysteryFB_currentOutId(0)
MysteryModel:set_fb_probeTeam(nil)
mysterySkillModel:set_fb_probeSkill(nil)
MysteryModel:setTempSkillSelectSlot({})
UIManager:invokeUIMethod("UIMysteryEnterWin","refreshWin")


MysteryModel:set_mysteryFB_currentOutId(0)


MysteryModel:clearInfo(fbid)

MysteryModel:updateMysteryFB_list_data(fbid,{tzStatus=0})

mysteryWeekActivityModel:updateMysteryById(fbid,{percent=0,tzStatus=0})

UIManager:callWindowFunc("UIWorldFunctionButtonWin","refreshMjActBtn")

local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbid)
if group then
UIManager.info("弟子队伍已撤离秘境")
mysteryZiYuanFuBenModel:setZiYuanMysteryDataCurLayer(group[1],0)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,table.concat({group[1],group[2]},'-')})
worldHUDModel:onUpdateHUD(unitKey)
end

UIManager:invokeUIMethod("UIMysteryListWin","refreshFBList")
UIManager:invokeUIMethod("UIMysteryEnterZiYuanWin","refreshWin")

xianjieController:clearResPointMysteryJson(fbid)
end
end


function MysteryController.recv_4_5(arg1,fbid)
if arg1==0 then
MysteryModel:set_mysteryFB_currentOutId(0)
MysteryController:remove_World_Mystery_unit(fbid)
MysteryModel:romove_mysteryFB_list_data(fbid)
mysteryTreasureModel:clearRecordItemList(fbid)

notifySystem:postNotify(notifyConfig.on_mystery_close,fbid)

MysteryController.send_4_2()

MysteryModel:setPercentListData(fbid,nil)
MysteryModel:clearInfo(fbid)

mysteryWeekActivityModel:removeMysteryById(fbid)


MysteryModel:setTreasureMapUseCount(tostring(fbid),false)

local isRefreshListWin=true

local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbid)
if group then
MysteryModel.send_close_data=MysteryModel.send_close_data or{}
local dontRefreshPos=MysteryModel.send_close_data[fbid]
if dontRefreshPos then
mysteryZiYuanFuBenModel:setZiYuanMysteryDataCurLayer(group[1],0)
MysteryModel.send_close_data[fbid]=nil
else
mysteryZiYuanFuBenModel:remove_World_Mystery_unit(group[1],group[2])
mysteryZiYuanFuBenModel:setZiYuanMysteryDataCurLayer(group[1],0)
mysteryZiYuanFuBenModel:resetFbDataByFbid(fbid)
end
mysteryZiYuanFuBenController.send_4_78()
mysteryZiYuanFuBenModel:setFbDataFBId(group[1],nil)
UIManager.info("秘境已关闭")
if mysteryZiYuanFuBenModel.data.waitToCloseAndEnter then
UIManager:callWindowFunc("UIMysteryEnterZiYuanWin","afterOhterCloseFB")
isRefreshListWin=nil
mysteryZiYuanFuBenModel.data.waitToCloseAndEnter=nil
end
end

if isRefreshListWin then
UIManager:callWindowFunc("UIMysteryListWin","refreshFBList")
end

UIManager:invokeUIMethod("UIWorldFunctionButtonWin","refreshMjActBtn")
end
end



function MysteryController.recv_4_6(arg1,FBid,guidlen,guidList)
if arg1==0 then
MysteryModel:set_fb_task_team(guidList)
local multi=mysteryZiYuanFuBenModel:get_temp_Multi()or 1
mysteryZiYuanFuBenModel:set_temp_Multi(nil)
MysteryController:enterMysteryFB(FBid,multi)
else
MysteryModel:set_fb_task_team(nil)
mysterySkillModel:set_fb_probeSkill(nil)


if arg1==2 then
MysteryModel:call_fb_exit(FBid,eMysteryQuitType.eFinish)
MysteryModel:clear_fb_exit()
end
end
UIManager:closeWindow("UIFightPrepareWin")
UIManager:closeWindow("UIMysterySkillSelectWin")
end


function MysteryController.recv_4_8(arg1,resultId,nextFlag,fzLevel)
if arg1==0 then
return
end


if not MysteryEventModel:have_event_flag()then
UIManager:closeWindow("UIMysteryEventDiceWin")
UIManager:closeWindow("UIMysteryEventWin")
end
UIFullMysteryMainControl:closeWindow("UIMysteryRuleSelectWin")

if arg1==1 then


MysteryModel:add_rule_bag_data({id=resultId,level=fzLevel})


local name=cfgHelper.getSSlawRule(resultId,"name")
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local color_cfg=qualityDesc[fzLevel or 1]
UIManager.info(FMT.fmt("获得法则<color=#{0}>【{1}】</color>",color_cfg[2],name))

AudioManager.playAudio(545)
end


if nextFlag==0 then

if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
else
MysteryController.send_4_20()
end


mysteryAIManager:update_queue()
end

function MysteryController.recv_4_9(arg1,arg2)

if arg1>0 then
local config,envId
for i,v in ipairs(arg2)do
envId=v.id
config=mysteryEnvironmentEffectModel.getConfigById(envId)
if config then
if config.envType then
mysteryEnvironmentEffectController.invokeFunc(config.envType,"setEnvironmentEffect",config.envParam)
end
end
end
end

MysteryModel:set_rule_bag_data(arg1,arg2)
UIManager:invokeUIMethod("UIMysteryRuleBagWin","onShow")
end

function MysteryController.recv_4_54(fzId,fzLevel)
MysteryModel:add_rule_bag_data({id=fzId,level=fzLevel})
UIManager:invokeUIMethod("UIMysteryRuleBagWin","onShow")
end

function MysteryController.recv_4_11(len,list)
if list then
for i,v in ipairs(list)do
MysteryModel:add_rule_bag_data({id=v.id,level=v.level})
end
end
UIManager:invokeUIMethod("UIMysteryRuleBagWin","onShow")
end


function MysteryController.recv_4_13(fbid)

MysteryModel:set_team_dead(nil)

MysteryModel:set_cur_fbid(nil)
MysteryModel:clearInfo(fbid)

MysteryController:stopCreateTimer()
mysteryCameraController:stopCameraTween()
mysteryEntityController.invokeAllModelsFunc("clear_entity_list")
MysteryModel:set_Mystery_enter(false)
mysteryAIManager:stop_ai()

UIFullMysteryMainControl:closeUI()
UIManager:closeWindow('UIMysteryHUDWin')
UIFullMysteryEventControl:closeUIEX()
UIFullMysteryMainControl:closeMysteryMainWindow()
UIFullMysteryShopControl:closeUI()
UIFullStoryBoardControl:closeUI()

_HexMapManager.ClearMapAsset()

MysteryController.send_4_1(fbid)
end


function MysteryController.recv_4_16(result,resultListLen,resultList)
if result==1 then
return
end

if resultListLen<=0 then
return
end
end



function MysteryController.recv_4_20(ruleListLen,ruleList,ruleListCount)
if ruleListLen<=0 then
return
end
if mysteryFightModel:is_fighting()then
mysteryFightModel:set_rule_callback(function()
if MysteryModel:get_cur_fbid()==111 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.miJing111_selectRule)
end
UIFullMysteryMainControl:showWindow("UIMysteryRuleSelectWin",{enterType=MysteryRuleEnterType.Choice,list=ruleList})
end)
else
if MysteryModel:get_cur_fbid()==111 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.miJing111_selectRule)
end
UIFullMysteryMainControl:showWindow("UIMysteryRuleSelectWin",{enterType=MysteryRuleEnterType.Choice,list=ruleList})
end
end


function MysteryController.recv_4_21(fbid,percent,targetListLen,targetList,percent2)
MysteryModel:set_fb_target_progress(targetListLen,targetList)
MysteryModel:set_fb_progress(percent)
UIManager:invokeUIMethod("UIMysteryTargetWin","refreshTargetList",targetListLen,targetList)
UIManager:invokeUIMethod("UIMysteryTargetStartWin","refreshTargetList",targetListLen,targetList)
UIManager:invokeUIMethod("UIMysteryMiniWin","refreshPercent",percent)
if percent==100 then
notifySystem:postNotify(notifyConfig.on_mystery_target_finish,fbid)
end
MysteryModel:updateFBInfoData(fbid,{[2]=percent})
mysteryWeekActivityModel:updateMysteryById(fbid,{percent=percent,targetList=targetList,percent2=percent2})
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eShangGuXianDi)
UIManager:callWindowFunc("UIWorldFunctionButtonWin","refreshMjActBtn")
end


function MysteryController.recv_4_27(arg1)
notifySystem:postNotify(notifyConfig.on_mystery_quit)
end

function MysteryController.initCB()
MysteryController.isInitingEntity=nil
if not MysteryModel.currentFBData.isFirst then
MysteryModel.currentFBData.isMysteryInit=nil
MysteryController.send_mystery_start()
end

local roomID=mysteryRoomModel:get_cur_birth_roomID()
if roomID and roomID~=0 then
mysteryRoomModel.data.needJumpMap=false
mysteryRoomController.send_4_18(0,0,0,roomID)
end
end


function MysteryController.recv_4_36()

local fbID=MysteryModel:get_cur_fbid()
if fbID==111 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.miJing111_enter)
end
local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
mysteryCameraController:initCameraEffect(cfg_fb)

baseFullScreenUI:openMain(true)

timeEventController.delayDo(0.5,function()
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end)


if not mysteryRoomModel:isInitRoom()then
mysteryEntityController.handle_meet()
end
MysteryModel.currentFBData.isMysteryInit=true

notifySystem:postNotify(notifyConfig.on_mystery_created)

local isPosHaveEntity=mysteryRoomModel:is_pos_have_entity(mysteryRoomModel:get_cur_roomID(),mysteryPlayerModel:get_player_pos())

local progress=MysteryModel:get_fb_progress()or 0

if progress>=100 and((not isPosHaveEntity)or MysteryModel:is_practice_mystery(fbID))then
MysteryController.quitMysteryFuBen()
end
end

function MysteryController:afterCreateMap()

mysteryFogController:initFog()

MysteryController.isInitingEntity=true

local roomID=mysteryRoomModel:get_cur_birth_roomID()
if roomID and roomID~=0 then
mysteryRoomModel.data.needJumpMap=true
end

mysteryTrap:initTrap()


mysteryEntityController:initEntity(0,MysteryController.initCB)

timeEventController.delayDo(5,function()
if MysteryController.isInitingEntity then
MysteryController.initCB()
end
end)

mysteryFogController:updateFog(MysteryModel:get_cur_fbid(),mysteryPlayerModel:get_player_pos())


end


function MysteryController.recv_4_42(roomId,gridData)
mysteryEntityController.update_grid_Entity_data(roomId,gridData)
end


function MysteryController.recv_4_43(gridListLen,gridList)
if gridListLen>0 then
local roomId=mysteryRoomModel:get_cur_roomID()
for i,v in ipairs(gridList)do
local key=table.concat({v.param_1,v.param_2},"-")
local dataList=MysteryModel:get_mystery_hide_cache(key)
if dataList then
for i,v in ipairs(dataList)do
mysteryEntityController.invokeFuncByMysteryEntityType(v.entityType,"remove_hide_entity",v.guid)
mysteryEntityController:createEntity(v.entityType,{guid=v.guid,etId=v.id,x=v.pos.x,y=v.pos.y,roomId=roomId,hideFlag=0})
end
end
end
MysteryModel:clear_mystery_hide_cache()

mysteryEntityController.handle_meet()
end
end



function MysteryController.recv_4_51(teamListLen,teamList)
local trapDelay=mysteryTrap:getTrapEffectDelay()or 0

if teamListLen>0 then
local changeFirst
local isRebirth=false
local isDead=false
local indexOne=nil
for i,v in ipairs(teamList)do
local unitType=v.unitType
local guid=v.unitId
local newBlood=tonumber(tostring(v.blood))
local oldBlood=MysteryModel:get_fb_probeTeam_blood(unitType,guid)
local index=MysteryModel:change_fb_probeTeam_blood(unitType,guid,newBlood)
if index then
if newBlood-oldBlood~=0 then
if trapDelay>0 then
timeEventController.delayDo(trapDelay,function()
UIManager:invokeUIMethod("UIMysteryWin","bloodChange",index,newBlood-oldBlood,oldBlood<=0 and newBlood>0)
end)
else
UIManager:invokeUIMethod("UIMysteryWin","bloodChange",index,newBlood-oldBlood,oldBlood<=0 and newBlood>0)
end

end
if oldBlood<=0 and newBlood>0 then
local name=UIDiscipleModel:getDiscipleName(guid)or""
UIManager.info(FMT.fmt("<color=#7D3B17>{0}</color>已重新加入战斗",name))
isRebirth=true
end
if oldBlood>0 and newBlood<=0 then
isDead=true
if not indexOne then
indexOne=index
end
end
if newBlood~=oldBlood and not changeFirst then
changeFirst=newBlood-oldBlood
end
end
end



if isRebirth or isDead then

timeEventController.delayDo(2,function()
mysteryPlayerController.setPlayerModel()
end)
end

UIManager:invokeUIMethod("UIMysteryWin","initTeamList")

if(mysteryBoomMonsterController.waitToBoom or mysteryTrap:getTrapEffectDelay())and changeFirst then
if not mysteryPlayerModel.isShowBlood then
mysteryPlayerModel.isShowBlood=true
if trapDelay>0 then
timeEventController.delayDo(trapDelay,function()
mysteryTriggerRoleTalk.resultRoleBloodNum(FMT.fmt("{0}%",changeFirst/100))
timeEventController.delayDo(1,function()
mysteryPlayerModel.isShowBlood=false
end)
end)
else
mysteryTriggerRoleTalk.resultRoleBloodNum(FMT.fmt("{0}%",changeFirst/100))
timeEventController.delayDo(1,function()
mysteryPlayerModel.isShowBlood=false
end)
end

end
end

if MysteryModel:canUseAllDisciple(MysteryModel:get_cur_fbid())and indexOne then
UIManager:invokeUIMethod("UIMysteryWin","talk",nil,nil,"点击头像更换弟子",indexOne)
end

MysteryController:checkTeamDead(teamList)



MysteryController:bloodCheck()


mysteryBoomMonsterController.waitToBoom=false
end
end


function MysteryController.recv_4_55(a)
local getFlag,itemListLen,itemList,autoItemListLen,autoItemList,effectFlag=a[1],a[2],a[3],a[4],a[5],a[6]
local lingshoulen,lingshoulist=a[7],a[8]
if not lingshoulen or lingshoulen==0 then
MysteryController:jiesuanReward(getFlag,itemListLen,itemList,autoItemListLen,autoItemList,effectFlag)
MysteryController:SetStopAutoFlag(true)
else

for k,v in ipairs(lingshoulist)do
lingshouController:addLingShou(v)
end
MysteryLingshouModel:SetLingShouEntity(lingshoulen,lingshoulist)
MysteryLingshouModel:recordRecvData(getFlag,itemListLen,itemList,autoItemListLen,autoItemList,effectFlag)
end

end


function MysteryController:SetStopAutoFlag(flag)
self.stopautoFlag=flag
end

function MysteryController:GetStopAutoFlag()
return self.stopautoFlag
end

function MysteryController:jiesuanReward(getFlag,itemListLen,itemList,autoItemListLen,autoItemList,effectFlag,islingshou)

local list={}
local lookUp={}

local itemListClient=mysteryTreasureModel:getRecordItemList()

if next(itemListClient)then
for i,v in ipairs(itemListClient)do
local itemId=v[1]
local handle
local guid=tostring(v[3])
if v[3]and guid~='0'and guid~='nil'then
handle=guid
else
handle=itemId
end
local data=lookUp[handle]
if not data then
lookUp[handle]=v
else
local num=data[2]
lookUp[handle]={itemId,num+v[2],v[3]}
end
end
end


if autoItemListLen>0 then

mysteryAIManager:set_mystery_state(true)


for i,v in pairs(lookUp)do
table.insert(list,{v[1],v[2],guid=v[3]})
end
MysteryController.sortItemList(list)
mysteryTreasureController:autoRemove(lookUp)
timeEventController.delayDo(3,function()
if not islingshou then
MysteryController:autoRemoveReward(lookUp,list,true)
else

MysteryLingshouModel:recordJieSuanData(lookUp,list,true)
MysteryLingshouModel:ShowLingShouData()
end
end)

else
for i,v in pairs(lookUp)do
table.insert(list,{v[1],v[2],guid=v[3]})
end
MysteryController.sortItemList(list)



if not islingshou then
MysteryController:autoRemoveReward(lookUp,list,false)
else

MysteryLingshouModel:recordJieSuanData(lookUp,list,false)
MysteryLingshouModel:ShowLingShouData()
end


end
end

function MysteryController:autoRemoveReward(lookUp,list,needAuto)






UIManager:showWindow("UIMysteryFinishWin",{itemList=list})

if needAuto then
local fbId=MysteryModel:get_cur_fbid()
local pos=mysteryPlayerModel:get_player_pos()
if pos then
mysteryFogController:updateFog(fbId,pos,30)
end
end
end

function MysteryController.onShowPrize(prizeType,rewards_,effectData)
if prizeType==ePrizeType.eMysteryResult then
local lookUp={}
for i,v in ipairs(rewards_)do
local itemId=v.itemid
local handle
local itemGuid=v.itemguid
if tostring(v.itemguid)=='0'then
itemGuid=nil
end
if itemGuid then
handle=tostring(itemGuid)
else
handle=itemId
end
local data=lookUp[handle]
if not data then
lookUp[handle]={v.itemid,v.num,itemGuid}
else
local num=data[2]
lookUp[handle]={itemId,num+v.num,itemGuid}
end

mysteryTreasureModel:recordItem(itemId,v.num,itemGuid)
end

end
end

function MysteryController.sortItemList(list)
table.sort(list,function(a,b)
local aConfig=itemsConfig.getConfig(a[1])
local bConfig=itemsConfig.getConfig(b[1])
local aRareLv=itemsConfig.getRareLv(a[1])
local bRareLv=itemsConfig.getRareLv(b[1])
local aScore=aRareLv*10000
local bScore=bRareLv*10000
aScore=aScore+aConfig.color*1000
bScore=bScore+bConfig.color*1000
if itemsConfig.isEquip(a[1])then
aScore=aScore+100
end
if itemsConfig.isEquip(b[1])then
bScore=bScore+100
end
return aScore>bScore
end)
end

function MysteryController.recv_4_56(fbId)

end

function MysteryController.recv_4_58()

end

function MysteryController.recv_4_59(id,teamListLen,teamList,zhenfa)
if teamListLen>0 then
MysteryModel:change_fb_probeTeamX(teamList)

UIManager:invokeUIMethod("UIMysteryWin","initTeamList")

mysteryPlayerController.setPlayerModel()

MysteryController:checkTeamDead(teamList)

mysteryEntityController.handle_meet()
end
end


function MysteryController.recv_4_60(ssListItem)
local fbId=ssListItem.id
chatGGModel.changeMijingData(fbId,true)

MysteryModel:setPercentListData(fbId,ssListItem.percent)

MysteryModel:add_mysteryFB_list_data(ssListItem)

UIManager:invokeUIMethod("UIMysteryListWin","refreshFBList")

local sence_type=MysteryModel:get_mystery_sence_type(fbId)

if sence_type==MysterySenceType.World or sence_type==MysterySenceType.ShangGuXianDi then
local fbData=MysteryModel:get_mysteryFB_unit(fbId)
if not fbData then
local areaId=ssListItem.quyuId
local arearCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
if not arearCfg then

end


local posGuid=ssListItem.guidPos
local areaId=ssListItem.quyuId
MysteryController:add_World_Mystery_unit(fbId,areaId,posGuid)
end
end

if ssListItem.ssFrom==eMysteryFromType.eItem then
local fbid=ssListItem.id
local fbData=MysteryModel:get_mysteryFB_unit(fbid)
if fbData then
local world=fbData[1]
local x=fbData[2]
local z=fbData[3]


MysteryModel:setTreasureMapUseCount(tostring(fbid),true)

UIManager:showWindow('UIWorldSceneWinEx',{world=world,list={{x=x,y=z,icon=1}},openType=1,callback=function()
UIManager.info("大世界上出现了新的秘境")
end})
else
logErr(FMT.fmt('没有秘境数据，秘境id：{0}',fbid))
end
end
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eShangGuXianDi)
UIManager:invokeUIMethod("UIWorldFunctionButtonWin","refreshMjActBtn")

if sence_type==MysterySenceType.ShangGuXianDi then
mysteryWeekActivityModel:setNewMytery(true)
if worldController:isInWorld()and MysteryModel:get_cur_fbid()==nil then
UIManager:showWindow("UISGXDTieLianWin")
end
end

end


function MysteryController.recv_4_63(listLen,itemList)
MysteryModel:init_fake_item(itemList)
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end


function MysteryController.recv_4_64(fakeItem)
MysteryModel:update_fake_item(fakeItem)
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end


function MysteryController.recv_4_65(result,fakeItem)
if result==1 then
return
end
MysteryModel:update_fake_item(fakeItem)
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end


function MysteryController.recv_4_66(argtable)
local fakeItemList=argtable[6]
if argtable[5]>0 then
for i,v in ipairs(fakeItemList)do
MysteryModel:update_fake_item(v)
end
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end
end


function MysteryController.send_4_81()
socketManager:send_4_81()
end


function MysteryController.send_4_82(ccmjId)
socketManager:send_4_82(ccmjId)
end


function MysteryController.recv_4_81(opType,len,ssList,txNum)


if opType==0 then
if len>0 then
MysteryModel:setWanBaoXunBaoDuiInit(ssList)
else

end
else
if len>0 then
MysteryModel:setWanBaoXunBaoDuiNewlist(ssList)
else

end
end
if txNum then
MysteryModel:setWanBaoXunBaoDuiTXNum(txNum)
end
end


function MysteryController.recv_4_82(ccmjId)
MysteryModel:setWanBaoXunBaoDuiReward(ccmjId)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MiJinRiJinWin","refreshScrollerViewSingle",ccmjId)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MiJinWin","refreshrijireddot")
UIManager:invokeUIMethod("UIWanBaoJumpWin","refreshreddotsecond")
end


function MysteryController.recv_4_25(useNum)
MysteryModel:setMJbuffUseNum(useNum)
end


function MysteryController:checkFbMjShowType(fbId,type)
local mjShowType=cfgHelper.get2(cfg_secretscenefubenconfig_get,fbId,'mjShowType')
if mjShowType then
return mjShowType==type
end
return false
end



function MysteryController:jumpToMystery(fbId,worldId,blockId,pos)
local posData=MysteryModel:get_mysteryFB_unit(fbId)
if posData then
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
if worldId and pos and blockId then
local minZoom=worldController:getCameraZoomRange_Normal(worldId)[1]
worldController:lookAtPosition(Vector3.New(pos.x,pos.y,pos.z),minZoom,false)
else
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbId})
if key then
worldController:lookAtUnit(key)
end
end
MysteryController:openEnterWin(fbId)
return true
else
local position=nil
if worldId and pos and blockId then
position=Vector3.New(pos.x,pos.y,pos.z)
else
worldId=posData[1]
position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
end

if not position then
return false
end
local worldName=cfgHelper.get2(cfg_worldconfig_get,worldId,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
local args={lookAt=position}
local flag=mainControl:enterWorld({worldId,args},function()
MysteryController:openEnterWin(fbId)
end)
end,
showclosebtn=false,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()


return true
end
else
if worldId and pos and blockId then

local cState=worldBlockModel:getBlockState(worldId,blockId)
local isOpenBlock=cState==worldBlockModel.BLOCKSTATE.OPEN
if worldModel:isSameWorld(worldId)then
local minZoom=worldController:getCameraZoomRange_Normal(worldId)[1]
worldController:lookAtPosition(Vector3.New(pos.x,pos.y,pos.z),minZoom,false)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,worldId,blockId)
if blockCfg and not isOpenBlock then
UIManager.error(FMT.fmt("{0}未解锁",blockCfg.name))
else
UIManager.error("暂无该秘境")
end
return true
else
local args={lookAt=Vector3.New(pos.x,pos.y,pos.z),}

local flag=mainControl:enterWorld({worldId,args},function()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,worldId,blockId)
if blockCfg and not isOpenBlock then
UIManager.error(FMT.fmt("{0}未解锁",blockCfg.name))
else
UIManager.error("暂无该秘境")
end
end)
return flag or false
end
else
UIManager.error("暂无该秘境")
end
end
return false
end


function MysteryController:openEnterWin(fbId)
local sceneType=MysteryModel:get_mystery_sence_type(fbId)
if sceneType==MysterySenceType.ShangGuXianDi then
mysteryWeekActivityController:openWeekEnterWin(fbId)
elseif sceneType==MysterySenceType.XianJieResPoint then
local winParams={
id=fbId,
}
xianjieController:openWin("UIMysteryEnterWin",winParams)
else
if UIManager:isActive("UIMysteryEnterWin")then
UIManager:invokeUIMethod("UIMysteryEnterWin","onShow",{id=fbId})
else
worldController:changeRightView("UIMysteryEnterWin",{id=fbId})
end
end
end




function MysteryController:enterMysteryFbEx(fbId,probeStatus)
local ret,errType=downAssetManager:needDownLoadMiJing(fbId)
if ret then return end
if not probeStatus then
local selectCallBack=function(guidList,zhenfaId)

fightController:closeSelectStage(false)

MysteryController.select_dizi_and_skill(fbId,guidList,nil,zhenfaId)

local fakeTask=worldTaskController:fakeZongMenMysteryTask(fbId,guidList,zhenfaId)
worldTaskModel:setTask(fakeTask)
worldTaskController:send_5_82(fakeTask)
wanBaoXunBaoDuiController:setCatMiJinState(false)
end

local cancelCallBack=function()
UIManager:closeWindow("UIMysterySkillSelectWin")
local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing
if systemModel.isOpen(cat_sysid)then
local catmjid=wanBaoXunBaoDuiController:getCatMiJinState()
if catmjid then
wanBaoXunBaoDuiController:jumpCatMijin()
end
end
wanBaoXunBaoDuiController:setCatMiJinState(false)
end
local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing
local catmjid=false
if systemModel.isOpen(cat_sysid)then
catmjid=wanBaoXunBaoDuiController:getCatMiJinState()
end
local cfg_fb=cfg_secretscenefubenconfig_get(fbId)
local winArgs=
{
enterCallBack=selectCallBack,
enterTxt="秘境",
cancelCallBack=cancelCallBack,
catCatMiJing=catmjid,
npcList=cfg_fb.tmpNPC,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.mystery,winArgs,function()
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbId})
end
end
end)
else

MysteryController.send_4_1(fbId)
end
end


function MysteryController:enterMysteryFB(fbId,multiNum)
local ret,errType=downAssetManager:needDownLoadMiJing(fbId)
if ret then return end
local typo=MysteryModel:get_mystery_sence_type(fbId)
if typo==MysterySenceType.World or typo==MysterySenceType.ResPoint or typo==MysterySenceType.ZiYuan then
local worldData=worldController:getCameraPosition()
if worldData then
MysteryModel:set_mysteryFB_enter_world_data(worldData)
mysteryMissionManager:startMission(fbId,multiNum)
else
MysteryController.send_4_1(fbId,multiNum)
end

else
MysteryController.send_4_1(fbId,multiNum)
end
end


function MysteryController:add_World_Mystery_unit(fbId,areaId,posGuid)
local unit=MysteryModel:get_mysteryFB_unit(fbId)
local areaCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
local worldId=nil
local blockId=nil
local position,x,z,flip
local checkGuid=worldPositionLibrary:containData(posGuid)
local valid=true

if checkGuid then
valid=false
local data=worldPositionLibrary:getData(posGuid)
x=data.x
z=data.z
flip=data.flip
worldId=data.world
position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

if position~=Vector3.zero then
if not unit then
MysteryModel:add_mysteryFB_unit(fbId,worldId,x,z,blockId,posGuid,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.MYSTERY,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
MysteryController:showUnitImp(fbId,worldId,x,z,flip)
end
end
return
else
loggerUtil.logErrFMT("本地存在错误秘境旧坐标数据:{0},({1},{2}),{3}",worldId,x,z,tostring(posGuid))
worldPositionLibrary:eraseData(posGuid)
end

end
if areaCfg.fixPos then
x=areaCfg.fixPos[1]
z=areaCfg.fixPos[2]
flip=areaCfg.fixPos[3]or false
worldId=areaCfg.worldBlock[1]
blockId=areaCfg.worldBlock[2]
else
local randomPos=areaCfg.randomPos
local posList={}
for i,v in ipairs(randomPos)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
local world=cfg.world
local block=cfg.blockId
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(posList,v)
end
end

if next(posList)then
local check,temp=worldPositionLibrary:extract(posList)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
worldId=temp[1].world

position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("秘境{0}坐标随机库抽取失败,秘境区域：{1},GUID:{2}",fbId,areaId,tostring(posGuid))
end
else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("秘境{0}坐标随机库无已解锁坐标,秘境区域：{1},GUID:{2}",fbId,areaId,tostring(posGuid))
end
end


if not worldId then
return
end
if not unit then
MysteryModel:add_mysteryFB_unit(fbId,worldId,x,z,blockId,posGuid,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.MYSTERY,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
MysteryController:showUnitImp(fbId,worldId,x,z,flip)
end
end
end


function MysteryController:remove_World_Mystery_unit(fbId)
local posData=MysteryModel:get_mysteryFB_unit(fbId)
if not posData then

return
end

local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,fbId})
local taskKey=worldTaskModel:findTaskKey_ByTargetProgress(unitKey,eWorldTripProgress.Work)
if taskKey then

worldTaskController:returnMission(taskKey)
end
MysteryModel:remove_mysteryFB_unit(fbId)
worldPositionLibrary:eraseData(posData[5])
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
MysteryController:hideUnitImp(fbId)

end
end

function MysteryController:removeAllUnit(notClearData)

local unitDatas=MysteryModel:get_all_mysteryFB_unit()
if unitDatas then
for fbId,posData in pairs(unitDatas)do
if not notClearData then
MysteryModel:remove_mysteryFB_unit(fbId)
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
MysteryController:hideUnitImp(fbId)
end
end
end
end

function MysteryController:showWorldAllUnit(worldId)
local unitDatas=MysteryModel:get_all_mysteryFB_unit()
if unitDatas then
for fbId,data in pairs(unitDatas)do
local world=data[1]
local block=data[4]
if worldId==world and worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
self:showUnitImp(fbId,world,data[2],data[3],data[6])
end
end
end
end

function MysteryController:showBlockAllUnits(worldId,blockId)
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
local unitDatas=MysteryModel:get_all_mysteryFB_unit()
if unitDatas then
for fbId,data in pairs(unitDatas)do
local world=data[1]
local block=data[4]
if worldId==world and block==blockId then
self:showUnitImp(fbId,world,data[2],data[3],data[6])
end
end
end
end
end

function MysteryController:showUnitImp(fbId,world,x,z,flip)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,fbId})
local cfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,fbId)
local modelSettings=worldModel:getModelSettings(cfg.modelRes,eWorldUnitTpye.MYSTERY)
local hudSettings=worldModel:getHUDSetting(cfg.hudRes)
local luaData={eWorldUnitTpye.MYSTERY,fbId}
local position=worldPositionConfig:getPosition(world,{x,z})
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
worldController:setUnitFlipX(unitKey,flip or false)
end

function MysteryController:hideUnitImp(fbId)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,fbId})
worldController:popUnit(unitKey)
end

function MysteryController.onWorldBlockDataChanged(world,block,state)
MysteryController:showBlockAllUnits(world,block)
end

function MysteryController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.MYSTERY then
local guid=int64.new(rData.key)
local fbData=MysteryModel:find_mysteryFBdata_byPosGuid(guid)or mysteryWeekActivityModel:getMystery(guid)
local fbId=fbData.id
local areaId=fbData.quyuId
local areaCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
local worldId=nil
local blockId=nil
local position,x,z,flip
local valid=true
if areaCfg.fixPos then
loggerUtil.logErrFMT("固定秘境位置被顶替：{0}， {1}",serializeHelper.serialize(rData),serializeHelper.serialize(aData))
return
else
local randomPos=areaCfg.randomPos
local posList={}
for i,v in ipairs(randomPos)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
local world=cfg.world
local block=cfg.blockId
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(posList,v)
end
end
if next(posList)then
local check,temp=worldPositionLibrary:extract(posList)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip

worldId=temp[1].world

position,blockId=worldPositionConfig:getPosition(worldId,{x,z})
else
valid=false
x=0
z=0
flip=false
position=Vector3.zero
worldId=0
blockId=0
end
else
worldId=0
blockId=0
valid=false
x=0
z=0
flip=false
position=Vector3.zero
end
local mysteryUnit=MysteryModel:get_mysteryFB_unit(fbId)
mysteryUnit[2]=x
mysteryUnit[3]=z
mysteryUnit[4]=blockId
worldPositionLibrary:eraseData(guid)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,fbId})
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.MYSTERY,guid)
worldTaskModel:changeTaskTargetDestination(unitKey)
end
if worldController:isInWorld()and worldModel:isSameWorld(worldId)then
worldController:setUnitPosition(unitKey,position)
end
end
end
end

function MysteryController.onWorldBlockDataInited(reInit)
if initProControl.isDone()and worldController:isInWorld()then
MysteryController:removeAllUnit(true)
MysteryController:showWorldAllUnit(worldModel.world)
end
end








function MysteryController.normal_finish(fbid,finishType,leaveState)
fbid=fbid or MysteryModel:get_cur_fbid()
if finishType==eMysteryQuitType.eFinish then

MysteryController.send_4_5(fbid)
mysteryMissionManager:stopMission(fbid)
MysteryController.send_4_4(fbid)
elseif finishType==eMysteryQuitType.eFail then
MysteryController.send_4_4(fbid)
end
worldController:resumeCameraControl()
worldController:showCamera(true)

if not leaveState then
baseFullScreenUI:openMain(true)
end
end


function MysteryController.quitMysteryFuBen(fbid)
fbid=fbid or MysteryModel:get_cur_fbid()

local cfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid)
if not cfg then
error(FMT.fmt('找不到秘境:{0}',fbid))
return
end
local haveQuit=true
if cfg.uiOpen then
local uiOpenCfg=cfg_secretsceneuishowconfig_get(cfg.uiOpen)
if uiOpenCfg then
haveQuit=uiOpenCfg.finishPanel
end
end
if haveQuit then

if MysteryModel:get_continue_flag()then
return
end

MysteryController.send_4_55()

else

mysteryAIManager:set_mystery_state(true)
local quitTimer=timer.new()
quitTimer:start(1,function()
MysteryModel:set_fb_finish(eMysteryQuitType.eFinish)
notifySystem:postNotify(notifyConfig.on_mystery_finish,fbid)
MysteryController.send_4_27()
quitTimer=nil
end,1)
end
end


function MysteryController:showPowerWarring()
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='可移动步数已耗尽',
oktext='确定',
allowclickBG='false',
okcallback=function(...)
MysteryModel:set_fb_finish(eMysteryQuitType.eFail)
MysteryController.send_4_27()

end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end








function MysteryController.set_camera_to_pos(pos,callBack,moveSpeed)
local path=mysteryPlayerModel:get_last_path()
local nextPos
for i,v in ipairs(path)do
if pos==v then
nextPos=path[i+1]
break
end
end
if nextPos then
local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
local cameraPosition=mysteryCameraController.GetCamaraPosition()
cameraPosition.z=0
local target=_HexMapManager.GetCellCenterWorld(nextPos,groundLayer)
target.z=0
local targetWorldPos={cameraPosition,target}
local baseCfg=cfg_secretscenebaseconfig_get(1)
local cameraSpeed=baseCfg.camera_move_speed
moveSpeed=moveSpeed or cameraSpeed[1]

mysteryCameraController.isCameraMove=false

_HexMapManager.SetCameraPositionByPath(targetWorldPos,callBack,cameraSpeed[1])

end
end


function MysteryController.set_camera_fcous_pos(roomID,pos,moveSpeed,callBack,mustExt,ease)

if not pos then
return
end
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
local position=mysteryCameraController.GetCamaraPosition()
local p=_HexMapManager.GetCellCenterWorld(pos,groundLayer)-position
local time=p:Magnitude()/moveSpeed
mysteryCameraController:setCamaraPositionMove(_HexMapManager.GetCellCenterWorld(pos,groundLayer),time,ease,nil,callBack,mustExt)
end


function MysteryController.set_camera_move_path(roomID,posList,moveSpeed,callBack,ease,useCurPos,isBack)

local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
local position=mysteryCameraController.GetCamaraPosition()

local worldPosList={}

if useCurPos then
table.insert(worldPosList,position)
end
local worldPos,p
local time=0
for i,pos in ipairs(posList)do
worldPos=_HexMapManager.GetCellCenterWorld(pos,groundLayer)
table.insert(worldPosList,worldPos)
end

if isBack then
table.insert(worldPosList,position)
end

if#worldPosList>2 then
for i,pos in ipairs(worldPosList)do
p=pos-position
time=time+p:Magnitude()/moveSpeed
end
mysteryCameraController:setCamaraPositionPath(worldPosList,time,nil,ease,nil,callBack)

end
end


function MysteryController.upload_player_pos()

local fbid=MysteryModel:get_cur_fbid()


local pos=mysteryPlayerModel:get_player_pos()

mysteryEntityController:upload_move_pos(mysteryPlayerModel:get_player(),pos)



mysteryTriggerManager:sendFbRangeEntity(fbid)
end


function MysteryController.createEntityCb(guid,pos,entityType,entityId)
local win=UIManager:isActive("UIMysteryMiniWin")
if win then
UIManager:invokeUIMethod("UIMysteryMiniWin","createEntity",guid,pos,entityType,entityId)
else
MysteryModel:add_mini_entity_cache(guid,pos,entityType,entityId)
end
end


function MysteryController.removeEntityCb(guid)
local win=UIManager:isActive("UIMysteryMiniWin")
if win then
UIManager:invokeUIMethod("UIMysteryMiniWin","removeEntity",guid)
else
MysteryModel:remove_mini_entity_cache(guid)
end
end


function MysteryController.targetEffect()
local fbId=MysteryModel:get_cur_fbid()
local targetConfig=cfgHelper.get2(cfg_secretscenefubenconfig_get,fbId,"target")
if targetConfig then
if targetConfig then
for i,v in ipairs(targetConfig)do
if v[1]==5 then
MysteryController.addUIHUD(eMysteryHUDType.eModel,{pos=Vector3.New(v[2],v[3]),layer=HexMapLayer.Ground,effectArgs={effectId=4}})
end
end
end
end
end


function MysteryController.addUIHUD(winName,args)
return UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",winName,args)
end


function MysteryController.removeUIHUD(guid)
UIManager:invokeUIMethod("UIMysteryHUDWin","removeUIHUD",guid)
end

function MysteryController.refreshUIHUD(guid,funcname,...)
return UIManager:invokeUIMethod("UIMysteryHUDWin","refreshUIHUD",guid,funcname,...)
end


function MysteryController.addModelHUD(pos,layer,modelArgs)
UIManager:invokeUIMethod("UIMysteryHUDWin","addModelHUD",pos,layer,modelArgs)
end


function MysteryController.addEffectHUD(pos,layer,effectArgs)
UIManager:invokeUIMethod("UIMysteryHUDWin","addEffectHUD",pos,layer,effectArgs)
end


function MysteryController.removeModelHUDByPos(pos,layer)
UIManager:invokeUIMethod("UIMysteryHUDWin","removeModelHUDByPos",pos,layer)
end

function PassMysteryAreaCheck()
if deviceHelper.isRunEditor()then
if strict_if_strict then
strict_if_strict(false)
end
MysteryController.isPassMysteryAreaCheck=true
if strict_if_strict then
strict_if_strict(true)
end
end
end

function MysteryController.ClearMysteryCloud(flag)
if deviceHelper.isRunEditor()then
if strict_if_strict then
strict_if_strict(false)
end
MysteryController.isClearMysteryCloud=flag
if strict_if_strict then
strict_if_strict(true)
end
end
end

