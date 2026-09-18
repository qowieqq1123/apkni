







local _MODULENAME="mysteryPlayerController"
gameState.addListener(def_table(_MODULENAME))
mysteryPlayerController.name=_MODULENAME


local _HexMapManager=CS.HexagonMapManagerInterface
local CreateRole=_HexMapManager.CreateRole
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local Vector3IntToVector3=_HexMapManager.Vector3IntToVector3
local ResumeMove=_HexMapManager.ResumeMove
local PauseMove=_HexMapManager.PauseMove
local StopMove=_HexMapManager.StopMove
local _Screen=UnityEngine.Screen

local size={0.1,0.17}
local _grassBgWinNameList={
[1]="UIMysteryGrassBgWin",
[2]="UIMysteryGrassBg2Win",
}



function mysteryPlayerController:onAppStart()

end

function mysteryPlayerController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_created,self.on_mystery_created)
mysteryPlayerModel:init_data()
end

function mysteryPlayerController:onLeaveState()

end





function mysteryPlayerController.create_player(x,y)
if mysteryPlayerModel:has_player()then

return
end

local probeTeam=MysteryModel:get_fb_probeTeam()

local discipleOutsideInfo=mysteryPlayerModel:get_player_model_info()

if not discipleOutsideInfo then
if not MysteryModel:canUseAllDisciple(MysteryModel:get_cur_fbid())then
MysteryController:fightCommonDeal()
end
error('全员死亡')
return
end

local baseCfg=mysteryPlayerModel.get_base_config()
local roomId=mysteryRoomModel:get_cur_roomID()
local playerId=1
local playerPos=Vector3(x,y,0)

local model=
{
id=discipleOutsideInfo.body,
components=discipleOutsideInfo.componets,
layer=SortingLayers.ITBuilding,
scale=discipleOutsideInfo.scale or baseCfg.model[2],
}


local disciples=UIDiscipleModel:getAllDiscipleDataX()
local fightValue=0
for i,v in pairs(probeTeam)do
local guid=tostring(v.unitId)
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
fightValue=fightValue+tonumber(tostring(disciples[guid].netData.net.fightvalue))
elseif v.unitType==fightPreSelectModel.teamEntityType.npc then
fightValue=fightValue+fightPreSelectModel.getNPCFightValue(tonumber(guid))
end
end

local data=
{
move_complete=true,
per_steps=1,
fight_value=fightValue,
showInFog=1,
useTree=true
}

local playerGuid=mysteryPlayerModel:create_entity(eMysteryEntityType.ePlayer,playerId,playerPos,roomId,model,data)

local area=mysteryRoomModel:get_room_map_area(roomId)
if area then
mysteryPlayerModel:set_entity_forward(playerGuid,Vector3(area[1]/2,area[2],0))
end


mysteryCameraController:setCamaraPosition(_HexMapManager.GetCellCenterWorld(playerPos,HexMapLayer.Ground))

UIManager:invokeUIMethod("UIMysteryMiniWin","focusPlayer",100)


timeEventController.delayDo(1,function()
local fbId=MysteryModel:get_cur_fbid()
if MysteryModel:have_wing(fbId)then
local player=mysteryPlayerModel:get_player()
player.data.stepNum=MysteryModel:have_wing_step()
MysteryController.addUIHUD(eMysteryHUDType.eMoveTreasure,{etType=eMysteryEntityType.ePlayer,guid=playerGuid})
end
end)
end

function mysteryPlayerController.init_map_player()
local brith_pos=MysteryModel:get_player_birth_pos()
if MysteryModel:get_player_birth_pos()then
mysteryPlayerController.create_player(brith_pos[1],brith_pos[2])
end
end


function mysteryPlayerController.on_mystery_created()

local pos=mysteryPlayerModel:get_player_pos()
mysteryPlayerController:inGrassFade(pos)
end



function mysteryPlayerController.update_player()
return mysteryPlayerController:move_player()
end



function mysteryPlayerController:move_player()
local posList=mysteryPlayerModel:get_last_path()

if mysteryPosHelper.is_invalid_path(#posList)then
return
end
local player=mysteryPlayerModel:get_player()
local roomID=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer

local completeCB=function(path)
mysteryPlayerController:move_complete_callback(path)
end
local pointCB=function(pos,pathIndex,path,isLast)
mysteryPlayerController:move_point_callback(pos,pathIndex,path,isLast)
end
local beginCB=function(pos)

UIManager:invokeUIMethod("UIMysteryMiniWin","moveItem",player.guid,pos,0.02)
mysteryPlayerController:move_begin_callback(pos)

end
local prepareCB=function(pos)

mysteryPlayerModel:set_move_complete(mysteryPlayerModel:get_player_guid(),false)
mysteryPlayerController:move_prepare_callback(pos)
end



local baseCfg=cfg_secretscenebaseconfig_get(1)
local cameraSpeed=baseCfg.camera_move_speed

local FocusCB=function()

if mysteryPlayerController.checkScreen and posList[1]then
local foucusPathTweener=MysteryController.set_camera_to_pos(posList[1],nil,5)
mysteryPlayerModel:set_focus_flag(true)
end

mysteryPlayerController.sequence=MysteryController:playMoveToPath(player.guid,posList,player.data.per_steps,completeCB,pointCB,groundLayer,beginCB,prepareCB,mysteryPlayerController.sequence)

end
local playerScreenPoint=_HexMapManager.WorldToScreenPoint(_HexMapManager.GetCellCenterWorld(posList[#posList],groundLayer))
local playerScreenPoint2=_HexMapManager.WorldToScreenPoint(_HexMapManager.GetCellCenterWorld(posList[1],groundLayer))


local check1=playerScreenPoint.x<_Screen.width*size[1]or playerScreenPoint.x>_Screen.width*(1-size[1])or playerScreenPoint.y<_Screen.height*size[2]or playerScreenPoint.y>_Screen.height*(1-size[2])
local check2=playerScreenPoint2.x<_Screen.width*size[1]or playerScreenPoint2.x>_Screen.width*(1-size[1])or playerScreenPoint2.y<_Screen.height*size[2]or playerScreenPoint2.y>_Screen.height*(1-size[2])
mysteryPlayerController.checkScreen=check1 or check2
if check2 then
if not mysteryCameraController:getCameraTween()then
mysteryCameraController:setCamaraFocusEntity(eMysteryEntityType.ePlayer,mysteryPlayerModel:get_player_guid(),FocusCB,cameraSpeed[2])
end
else
FocusCB()
end



UIManager:invokeUIMethod("UIMysteryMiniWin","playerMovePath",posList)






end





function mysteryPlayerController:move_complete_callback(path)
if not mysteryPlayerModel:has_player()then
return
end
mysteryPlayerModel:set_focus_flag(nil)
local guid=mysteryPlayerModel:get_player_guid()


mysteryPlayerModel:play_animation(guid,eAnimationID.jump3,MysteryModel:getMoveAnimSpeed())



local roomID=mysteryRoomModel:get_cur_roomID()
local fogList=mysteryFogModel:get_update_fog_data_list(roomID)
mysteryFogModel:clear_update_fog_data(roomID)
if fogList and next(fogList)then
mysteryFogController.send_4_24(fogList)
end



mysteryPlayerModel:set_move_complete_path(guid,path)
mysteryPlayerModel:set_move_complete(guid,true)



UIManager:invokeUIMethod("UIMysteryHUDWin","removeEndPointHUD")

mysteryPlayerController.checkScreen=nil


local posPath=mysteryPlayerModel:get_last_path()or{}
if(posPath[#posPath-1])then
mysteryPlayerModel:set_last_pos(posPath[#posPath-1])
end
mysteryPlayerModel:set_last_path({})

mysteryPlayerModel:set_last_steps(0)

mysteryPlayerController.sequence=nil

if not mysteryPlayerModel:isPlayerInGrass()then
mysteryPlayerController:showGrassWindow(false)
end
end


function mysteryPlayerController:move_point_callback(pos,pathIndex,path,isLast)
if not mysteryPlayerModel:has_player()then
return
end

local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
_HexMapManager.RunSurfaceSpriteAnimator(pos,groundLayer,"CreateAnim3",0,nil)



mysteryFogController:updateFog(MysteryModel:get_cur_fbid(),mysteryPlayerModel:get_player_pos())


if mysteryPlayerController.checkScreen and mysteryPlayerModel:get_focus_flag()then
MysteryController.set_camera_to_pos(pos)
end


if(not mysteryAIManager:is_running())or self.haveHideSurface or self.wing_stop then
mysteryPlayerController.stop_move(path)
end
self.haveHideSurface=false


mysteryPlayerController:inGrassFade(pos)

notifySystem:postNotify(notifyConfig.mystery_player_move,pos)

mysteryPlayerController:playOtherAnimationInRound(roomID,pos)

mysteryDiscipleEffectModel:check_find_hidden()

if not isLast and not mysteryPlayerModel:is_move_complete()then
mysteryEntityController.handle_one_meet()
end


local trapAllData=mysteryTrapModel:getAllTrapMapData()
for i,trapData in pairs(trapAllData)do
local hudList=trapData.hudList
if hudList then
local data=mysteryTrapModel:getTrapData(trapData.trapId)
if data and data.rstIndex==0 then
if data.times<=trapData.times then
local subIndex=pathIndex==1 and pathIndex or pathIndex-1
for guid,v in pairs(hudList)do
MysteryController.refreshUIHUD(guid,"refreshStep",trapData.waittime-(data.fdStep+subIndex))
end
end
end
end
end

end

function mysteryPlayerController:playOtherAnimationInRound(roomID,pos)

for round=0,3 do
local pos_list=mysteryPosHelper.get_round_pos_list(pos,round)
for _,ePos in ipairs(pos_list)do
local entityList=mysteryRoomModel:get_pos_entityList(roomID,ePos,true)
if entityList then
for _,ent in pairs(entityList)do
if ent.entityType~=eMysteryEntityType.ePlayer then
local model=mysteryEntityController.getModelByEntityType(ent.entityType)
local config=model:get_config(ent.id)
local playAnimRound=config.playAnimRound
if playAnimRound then
for i,v in ipairs(playAnimRound)do
if round<=v[1]then
local last=model:get_last_animation(ent.guid)
if last~=v[2]then
model:play_animation(ent.guid,v[2])
end
break
end
end
end
end
end
end
end
end

end


function mysteryPlayerController:move_begin_callback(pos)

local fbid=MysteryModel:get_cur_fbid()


notifySystem:postNotify(notifyConfig.on_mystery_player_move_start,pos)
if mysteryPlayerModel:get_player_guid()then

mysteryPlayerModel:set_entity_forward(mysteryPlayerModel:get_player_guid(),pos)

mysteryPlayerModel:play_animation(mysteryPlayerModel:get_player_guid(),eAnimationID.jump2,MysteryModel:getMoveAnimSpeed())
end


mysteryPlayerModel:add_last_steps(1)
mysteryPlayerModel:add_total_steps(1)


mysterySkillController:update_skill_steps()

mysteryPlayerModel:set_player_pos(pos)

if mysteryPlayerController.check_hide_surface()then
self.haveHideSurface=true
end


if MysteryModel:have_wing(fbid)then
local wingMaxStep=MysteryModel:get_wing_max_step(fbid)
local wing_step=MysteryModel:get_wing_step()
MysteryModel:set_wing_step(MysteryModel:get_wing_step()+1,MysteryModel:get_wing_direct())

mysteryEntityController.send_4_69()
local player=mysteryPlayerModel:get_player()
player.data.stepNum=MysteryModel:have_wing_step()
if player.hud then
player.hud:updateStep(player.data.stepNum)
end
if wing_step+1>=wingMaxStep then
self.wing_stop=true
end
end
end


function mysteryPlayerController:move_prepare_callback(pos)

if mysteryPlayerModel:get_player_guid()and pos~=mysteryPlayerModel:get_player_pos()then
mysteryPlayerModel:play_animation(mysteryPlayerModel:get_player_guid(),eAnimationID.jump1,MysteryModel:getMoveAnimSpeed())
end
end

function mysteryPlayerController:onRecvMove(moveData)
local pathStep=mysteryEntityController:get_move_step(0)
mysteryTrap:updateTrapStep(pathStep)

local roomId=mysteryRoomModel:get_cur_roomID()
local pos=mysteryPlayerModel:get_player_pos()
local checkTrap=mysteryTrap:checkTrap(roomId,pos)
if checkTrap then
mysteryTrap.req_4_84(checkTrap)
end

local checkTrap2=mysteryTrap:checkTrapExe(roomId,pos)
if checkTrap2 and next(checkTrap2)then
local list={}
for i,v in pairs(checkTrap2)do
table.insert(list,i)
end
mysteryTrap.req_4_85(list)
end
end


function mysteryPlayerController.pause_move()
if mysteryPlayerController.sequence then
mysteryPlayerController.sequence:Pause()
end


end


function mysteryPlayerController.resume_move()


if mysteryPlayerController.sequence then
mysteryPlayerController.sequence:Play()
end
end


function mysteryPlayerController.stop_move(path)
local player=mysteryPlayerModel:get_player()
StopMove(player.guid)
if mysteryPlayerController.sequence then
mysteryPlayerController.sequence:Kill()
mysteryPlayerController.sequence=nil
end

local roomID=mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomID)
SetPosition(player.guid,mysteryPlayerModel:get_player_pos(),layer)

UIManager:invokeUIMethod("UIMysteryMiniWin","stopCameraMove")
UIManager:invokeUIMethod("UIMysteryMiniWin","moveCamera",player.pos,0.02)
UIManager:invokeUIMethod("UIMysteryMiniWin","moveItem",player.guid,player.pos,0.02)

mysteryCameraController:stopCameraTween()


mysteryPlayerController:move_complete_callback(path)
end

function mysteryPlayerController.check_hide_surface()
local player=mysteryPlayerModel:get_player()
local gridData=mysteryRoomModel:get_grid_pos_data(mysteryRoomModel:get_cur_roomID(),player.pos.x,player.pos.y)
if gridData then
local surfaceCfg=cfgHelper.get(cfg_secretscentsurfaceconfig_get,gridData.surfaceId)
if surfaceCfg and surfaceCfg.hide then
local hideid=surfaceCfg.hide
socketManager:send_4_68(mysteryRoomModel:get_cur_roomID(),1,{{player.pos.x,player.pos.y,hideid}})
mysteryAIManager:stop_ai()
return true
end
end
end


function mysteryPlayerController.runBehavior(btName,_onBahaviroEvent)
local player=mysteryPlayerModel:get_player()
if not player then
return
end
mysteryPlayerModel:runBehavior(player.guid,btName,_onBahaviroEvent)
end

function mysteryPlayerController.isPlayerRunBehavior()
local player=mysteryPlayerModel:get_player()
if not player then
return false
end
return mysteryPlayerModel:isRunBehavior(player.guid)
end

function mysteryPlayerController.setPlayerModel()
local baseCfg=mysteryPlayerModel.get_base_config()
local player=mysteryPlayerModel:get_player()
if player then
local role=_HexMapManager.GetRole(player.guid)
local newModel=mysteryPlayerModel:get_player_model_info()
if newModel then
local scale=newModel.scale or baseCfg.model[2]
role:ChangeBody(newModel.body,newModel.componets,false,scale)
end
end
end


function mysteryPlayerController.resetPlayerPos()
local player=mysteryPlayerModel:get_player()
if player then
local role=_HexMapManager.GetRole(player.guid)
local roleTrans=role:GetActorTransform()
if roleTrans then
roleTrans.position=_HexMapManager.GetCellCenterWorld(player.pos,mysteryRoomModel:get_GroundLayer(player.roomId),false)
end
end
end


function mysteryPlayerController:inGrassFade(pos)
local roomId=mysteryRoomModel:get_cur_roomID()
local player=mysteryPlayerModel:get_player()
local grass=mysteryTriggerPointModel:haveGrass(pos)
if grass then

local oldGrass=player.inGrass
player.inGrass=grass.guid
if oldGrass then
mysteryTriggerPointController:clearGrassState(oldGrass,player.guid)
end
mysteryTriggerPointModel:setEntGrass(grass.guid,player.guid,true)
mysteryTriggerPointModel:play_animation(grass.guid,2018)

local grassType=mysteryTriggerPointModel:getGrassType(grass.id)
mysteryPlayerController:showGrassWindow(true,nil,grassType)

mysteryPlayerModel:fade_to_color(player.guid,Color.New(1,1,1,0.5),0.5,nil,0)
local nearPosList=mysteryTriggerPointModel:getNearGrass(pos)
if next(nearPosList)then
for i,v in pairs(nearPosList)do
local entityList=mysteryRoomModel:get_pos_entityList(roomId,v)
for i,ent in pairs(entityList)do
if ent.entityType~=eMysteryEntityType.eTriggerPoint and ent.entityType~=eMysteryEntityType.ePlayer then
if not mysteryTriggerPointModel:isInGrassList(ent.guid)then
mysteryTriggerPointModel:playerCanSeeTheEntityInGrass(ent)
local controller=mysteryEntityController.getControllerByEntityType(ent.entityType)
if controller then
controller:inGrassBehavior(ent.guid,ent.pos)
end

end
end
end
end
end
else
local oldGrass=player.inGrass
player.inGrass=nil
if oldGrass then
mysteryTriggerPointController:clearGrassState(oldGrass,player.guid)
end

if not mysterySkillModel:has_hide_steps()then
mysteryPlayerModel:fade_to_color(player.guid,Color.New(1,1,1,1),0.5,nil,0)
end
local grassEntList=mysteryTriggerPointModel:getGrassList()
if next(grassEntList)then
for i,v in pairs(grassEntList)do
local controller=mysteryEntityController.getControllerByEntityType(v.entityType)
if controller then
controller:inGrassBehavior(v.guid,v.pos,false)
end
end
end
mysteryTriggerPointModel:clearGrassList()
end
end


function mysteryPlayerController:showGrassWindow(isOpen,mustExe,grassType)
local grassBgWinName=grassType and _grassBgWinNameList[grassType]or _grassBgWinNameList[1]
if isOpen then
if mustExe or isOpen~=self.isOpenGrassWindow then

UIFullMysteryMainControl:showWindow(grassBgWinName)
mysteryPlayerModel.isOpenGrassWindow=true
mysteryPlayerModel.isOpenGrassWindowName=grassBgWinName
end
else
if mustExe or isOpen~=self.isOpenGrassWindow then

grassBgWinName=mysteryPlayerModel.isOpenGrassWindowName or _grassBgWinNameList[1]
UIFullMysteryMainControl:closeWindow(grassBgWinName)
mysteryPlayerModel.isOpenGrassWindow=nil
mysteryPlayerModel.isOpenGrassWindowName=nil
end
end
end



function mysteryPlayerController:wing_move()
local player=mysteryPlayerModel:get_player()
if player then
mysteryPlayerController:wing_entity_move(player)
end
end

function mysteryPlayerController:wing_entity_move(entity)
local fbid=MysteryModel:get_cur_fbid()
if not MysteryModel:have_wing(fbid)then
self.wing_stop=false
return
end
if self.wing_stop then
local d=MysteryModel:get_wing_direct(true)
MysteryModel:set_wing_step(0,d)

mysteryEntityController.send_4_69()
entity.data.stepNum=MysteryModel:have_wing_step()
if entity.hud then
entity.hud:updateStep(entity.data.stepNum)
end
local effect=MysteryModel:get_wing_effect(MysteryModel:get_cur_fbid())

UIManager:invokeUIMethod("UIMysteryWin","showEffect",effect,true)

timeEventController.delayDo(2,function()
UIManager:invokeUIMethod("UIMysteryWin","refreshWingDir")
end)


local posList=mysteryPosHelper.getLinePosList(entity.pos,d==1 and mysteryPosHelper.ArrowType.Left or mysteryPosHelper.ArrowType.Right,1)
local path={}

local roomID=entity.roomId

table.insert(path,entity.pos)
for i,pos in ipairs(posList)do
if MysteryModel:is_border(roomID,pos)then
break
else
if _HexMapManager.IsCanMove(pos)then
table.insert(path,pos)
else
break
end
end
end
if#path>1 then

local completeCB=function(path)
self:wing_move_complete_callback(entity,path)
end

local pointCB=function(pos,index)
self:wing_move_point_callback(entity)
end
local beginCB=function(pos)
if mysteryPosHelper.is_same_pos(pos,entity.pos)then
return
end

UIManager:invokeUIMethod("UIMysteryMiniWin","moveItem",entity.guid,pos,0.02)
self:wing_move_begin_callback(entity,pos)
end
local prepareCB=function(pos)
if mysteryPosHelper.is_same_pos(pos,entity.pos)then
return
end
self:wing_move_prepare_callback(entity)
end
local layer=mysteryRoomModel:get_GroundLayer(entity.roomId)
mysteryAIManager:set_mystery_state(true)
timeEventController.delayDo(0.5,function()
mysteryAIManager:set_mystery_state(false,false)
self.sequence=MysteryController:playMoveToPath(entity.guid,path,1,completeCB,pointCB,layer,beginCB,prepareCB,self.sequence)
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'set_move_complete',entity.guid,false)
end)
end
end
self.wing_stop=false
end


function mysteryPlayerController:wing_move_complete_callback(entity,path)
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'play_animation',entity.guid,eAnimationID.jump3)


mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'set_move_complete_path',entity.guid,path)
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'set_move_complete',entity.guid,true)
end


function mysteryPlayerController:wing_move_point_callback(entity,pos,index)

end


function mysteryPlayerController:wing_move_begin_callback(entity,pos)

mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'play_animation',entity.guid,eAnimationID.jump2)








mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'set_entity_pos',entity.guid,pos)
end


function mysteryPlayerController:wing_move_prepare_callback(entity)
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'play_animation',entity.guid,eAnimationID.jump1)
end

