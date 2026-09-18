







mysteryAIManager={}


mysteryAIManager.queue=
{

{
func=function()

for i,v in ipairs(eMysteryAIEntityType)do
mysteryEntityController.invokeControllerFuncByMysteryEntityType(v,'update_monster')
end

mysteryPlayerController.update_player()

end
},

{
func=function()
mysteryTreasureController.update_treasure()
end
},

{
func=function()
mysteryInteractionController.update_interaction()
end
},

{
func=function()
mysteryPortalController.update_portal()
end
},

{
func=function()
mysteryCurePointController.update_cure()
end
},

{
func=function()
mysteryRelivePointController.update_relive()
end
},

{
func=function()
mysteryChallengePointController.update_challengepoint()
end
},

{
func=function()
mysteryShopController.update_shop()
end
},

{
func=function()
mysteryLittleGamePointController.update_littlegamepoint()
end
},

{
func=function()
mysteryTriggerPointController.update_queue()
end
},

{
func=function()
mysteryYaranzoController.update_queue()
end
},


{
func=function()
mysterySelectGridController:update_queue()
end
},


{
func=function()
mysteryPlayerController:wing_move()
end
},

}


mysteryAIManager.oneQueue=
{

{
func=function()
return mysteryTreasureController.handle_meet()
end,
}
}



mysteryAIManager.autoQueue=
{

{
func=function()

for i,v in ipairs(eMysteryAIEntityType)do
mysteryEntityController.invokeControllerFuncByMysteryEntityType(v,'update_monster')
end

mysteryPlayerController.update_player()

end
},

{
func=function()
mysteryTreasureController.update_treasure()
end
},

{
func=function()
mysteryCurePointController.update_cure()
end
},

{
func=function()
mysteryYaranzoController.update_queue()
end
},

}

mysteryAIManager.ePauseType=
{
[eMysteryPauseType.eGlobal]=function()
return mysteryAIManager.isPause
end,
[eMysteryPauseType.eCameraMove]=function()
return mysteryCameraController.isCameraMove
end,
[eMysteryPauseType.eCameraMoveFlag]=function()
return mysteryTriggerManager.getCameraMoveFlag()
end,
[eMysteryPauseType.ePlayerRunBehavior]=function()
return mysteryPlayerController.isPlayerRunBehavior()
end,
[eMysteryPauseType.eWaitToMoveRecv]=function()
return mysteryEntityController.isWaitToMove()
end,
[eMysteryPauseType.eWaitToRoomInit]=function()
return mysteryRoomModel.data.isInitRoom
end,
[eMysteryPauseType.eInitJumpRoom]=function()
return mysteryRoomModel.data.needJumpMap
end,
[eMysteryPauseType.eTeamDead]=function()
return MysteryModel:get_team_dead()
end,
[eMysteryPauseType.eFireBomb]=function()
return mysteryBoomMonsterController:isBooming()
end,
[eMysteryPauseType.eTrap]=function()
return mysteryTrap:isTrapPause()
end,
[eMysteryPauseType.eLingShou]=function()
return MysteryLingshouModel.lingShouCatch
end,
}

mysteryAIManager.ePauseTypeTips=
{
[eMysteryPauseType.eTeamDead]="请点击左下方的布阵按钮重新上阵弟子",
}


mysteryAIManager.queueIndex=0


mysteryAIManager.startEventFlag=false


mysteryAIManager.isRunAI=false


mysteryAIManager.isPause=false




function mysteryAIManager:start_ai()
local hideInSamePosList=MysteryModel:get_hide_in_same_pos_type()
if hideInSamePosList then
for eType,_ in pairs(hideInSamePosList)do
local controller=mysteryEntityController.getControllerByEntityType(eType)
if controller then
controller:clear_entity_count_hud()
end
end
end

self.isRunAI=true
self.queueIndex=0
self:update_queue()
end


function mysteryAIManager:stop_ai()

self.isRunAI=false
end


function mysteryAIManager:is_running()
return self.isRunAI
end

function mysteryAIManager:set_mystery_state(isPause,never,waitDelay)
if isPause then
if self.PauseTimer then
self.PauseTimer:cancel()
self.PauseTimer=nil
end
end

self.isPause=isPause
if isPause then
waitDelay=waitDelay or 5
self.PauseTimer=timer.new()
self.PauseTimer:start(waitDelay,function()
self.isPause=false
self.PauseTimer=nil
end,1)
end
end


function mysteryAIManager:is_pause(excludeList,warring)
excludeList=excludeList or{}
for t,v in pairs(mysteryAIManager.ePauseType)do
if not excludeList[t]and v()then
if warring then
local tips=mysteryAIManager.ePauseTypeTips[t]
if tips then
UIManager.error(tips)
end
end
return true,t
end
end
return false
end

function mysteryAIManager:check_pause_type(pauseType)
if mysteryAIManager.ePauseType[pauseType]then
return mysteryAIManager.ePauseType[pauseType]()
end
return false
end

function mysteryAIManager:reset_pause()
self.isPause=false
self.neverPause=false
self.PauseTimer=nil
end

function mysteryAIManager:set_start_event_flag(flag)
self.startEventFlag=flag
end

function mysteryAIManager:get_start_event_flag()
return self.startEventFlag
end


function mysteryAIManager:update_queue()
if self.isPause then
return
end
if(not self.queueIndex==0)and self.is_on_round()then
return
end

self.queueIndex=self.queueIndex+1

if MysteryGuildOrder:isInAuto()then
if self.autoQueue[self.queueIndex]then
self.autoQueue[self.queueIndex].func()
end
else
if self.queue[self.queueIndex]then
self.queue[self.queueIndex].func()
end
end
end


function mysteryAIManager:start_one_meet()
for i,v in ipairs(mysteryAIManager.oneQueue)do
if v.func()then
break
end
end
end




function mysteryAIManager.is_on_round()
local hasMonsterMove=MysteryModel:have_moving_entity()








local hasPlayerMove=mysteryPlayerModel:is_move_complete()==false
local is_on_around=(hasMonsterMove or hasPlayerMove)
return is_on_around
end






function mysteryAIManager.meet(originEntity,originPos,targetEntity,targetPos,callback,range)
range=range or 0
local originRoom=originEntity.roomId
local targetRoom=targetEntity.roomId

if mysteryPosHelper.check_in_round(originPos,targetPos,range,originRoom,targetRoom)then
if callback then
callback(originEntity,targetEntity)
end
return true
end
return false
end


function mysteryAIManager.meet_player(entity,pos,callback,range)

local player=mysteryPlayerModel:get_player()
local playerPos=mysteryPlayerModel:get_player_pos()

if mysteryAIManager.meet(entity,pos,player,playerPos,callback,range)then
return true
end
return false
end


function mysteryAIManager.meet_other_camp(monster,callback)
if not monster then
return false
end
if monster.entityType~=eMysteryEntityType.eMonster then
return false
end

local monsterGroupCfg=mysteryMonsterModel.get_monster_group_config(monster.id)
local monsters=mysteryMonsterModel:get_entity_list()
for i,v in pairs(monsters)do
local camp=mysteryMonsterModel.get_monster_group_config(v.id).camp

local isOtherMonster=v.guid~=monster.guid
local isOtherCamp=camp~=monsterGroupCfg.camp
if isOtherMonster and isOtherCamp then
if mysteryAIManager.meet(monster,monster.pos,v,v.pos,callback)then
return true
end
end
end
return false
end


function mysteryAIManager.meet_same_camp(guid)
local monster=mysteryMonsterModel:get_entity(guid)
if not monster then
return false
end
local monsterGroupCfg=mysteryMonsterModel.get_monster_group_config(monster.id)
local path=MysteryModel:get_last_path(monster.guid)

local monsters=mysteryMonsterModel:get_entity_list()
for i,monster2 in pairs(monsters)do
local monsterGroupCfg2=mysteryMonsterModel.get_monster_group_config(monster2.id)
local path2=MysteryModel:get_last_path(monster2.guid)

local isSameCamp=monsterGroupCfg.camp==monsterGroupCfg2.camp
local isSamePos=false
if path and path2 and#path>0 and#path2>0 then
isSamePos=mysteryPosHelper.is_same_pos(path[#path],path2[#path2],monster.roomId,monster2.roomId)
if isSameCamp and isSamePos then
return true
end
end
end
return false
end


function mysteryAIManager.meet_boom_monster(etType,entity,callback,posIndex)
local isboomType=false
for i,v in pairs(eMysteryBoomEntityType)do
if v==etType then
isboomType=true
break
end
end
if not isboomType then
return false
end
if not entity then
return false
end







local monsters=mysteryBoomMonsterModel:get_entity_list()
for i,v in pairs(monsters)do
if v.data.stepNum-posIndex+2<=0 then
local isOtherMonster=v.guid~=entity.guid
if isOtherMonster then
if mysteryAIManager.meet(entity,entity.pos,v,v.pos,callback,0)then
return true
end
end
end
end
return false
end

function mysteryAIManager.meet_trigger_collider(entity,pos)


local collider=mysteryRoomModel:get_pos_entityType(entity.roomId,pos,eMysteryEntityType.eTriggerPoint)
if collider then

local cfg=mysteryTriggerPointModel:get_config(collider.id)
if not(cfg.hide and collider.data.status>=cfg.hide)and cfg.grass~=1 then
if mysteryTriggerPointModel:have_collider_ent(entity)then

return 2
else
return 1
end
end
end
return 0
end




function mysteryAIManager:set_target_pos(pos)
self.targetPos=pos
end


function mysteryAIManager:get_target_pos()
return self.targetPos
end




function mysteryAIManager.is_to_do(originFight,targetFight)
return originFight>=targetFight
end



function mysteryAIManager.handle_monster_behavior(monster,playerPos)
local monster_behavior=mysteryAIManager.check_monster_behavior(monster,playerPos)


if monster_behavior==eMysteryMonsterBehavior.eChase then
return mysteryAIManager.chase(monster)
elseif monster_behavior==eMysteryMonsterBehavior.eHoming then
return mysteryAIManager.homing(monster)
elseif monster_behavior==eMysteryMonsterBehavior.eEscape then
return mysteryAIManager.escape(monster)
elseif monster_behavior==eMysteryMonsterBehavior.ePatrol then
return mysteryAIManager.patrol(monster)
else
return mysteryAIManager.stand(monster)
end
end


function mysteryAIManager.check_monster_behavior(monster,playerPos)

local entityType=monster.entityType

local model=mysteryEntityController.getModelByEntityType(entityType)

if not model then
return eMysteryMonsterBehavior.eStand
end


if model:is_move_inteval(monster.guid)then
return eMysteryMonsterBehavior.eStand
end

if not model:is_in_same_room(monster.guid)then
return eMysteryMonsterBehavior.eStand
end


local hasHold=mysterySkillModel:has_hold_steps(monster.guid)
if hasHold then
return eMysteryMonsterBehavior.eStand
end


if entityType==eMysteryEntityType.eMonster then
local selected=mysteryMonsterModel:get_monster_select(monster.guid)
if selected then
return eMysteryMonsterBehavior.eStand
end

if MysteryGuildOrder:isInAuto()then
return eMysteryMonsterBehavior.eStand
end
end




local player=mysteryPlayerModel:get_player()



local isPlayerInGrass=mysteryTriggerPointModel:haveGrass(playerPos)


local monsterAICfg=model:get_entity_ai_config(monster.guid)

if isPlayerInGrass then
model:set_state(monster.guid,eMysteryMonsterState.eIdle,monster)
return monsterAICfg.is_patrol and eMysteryMonsterBehavior.ePatrol or eMysteryMonsterBehavior.eStand
end



local monsterState=model:get_state(monster.guid)

local isInAlertRange=mysteryPosHelper.is_in_check_range(monster.data.sim_pos,playerPos,monsterAICfg.alert_range,monster.roomId,player.roomId)


local hasHide=mysterySkillModel:has_sim_hide_steps()

local isInView=isInAlertRange and not hasHide

local isInHomingRange=mysteryPosHelper.is_in_check_range(monster.data.origin_pos,monster.data.sim_pos,monsterAICfg.homing_range)


local monsterFight=model:get_monster_fight_value(monster.guid)
local playerFight=mysteryPlayerModel:get_player_fight_value()

local willChase=true
if monsterAICfg.chase_fighting_percent then
willChase=mysteryAIManager.is_to_do(monsterFight*(1+monsterAICfg.chase_fighting_percent),playerFight)
end

local willEscape=false
if monsterAICfg.escape_fighting_percent then
willEscape=mysteryAIManager.is_to_do(playerFight,monsterFight*(1-monsterAICfg.escape_fighting_percent))
end




local buddhaFunc=function()
return monsterAICfg.is_patrol and eMysteryMonsterBehavior.ePatrol or eMysteryMonsterBehavior.eStand
end



if monsterState==eMysteryMonsterState.eIdle then
if isInView or model:is_lock_player(monster.guid)then
model:set_state(monster.guid,eMysteryMonsterState.eAlert,monster)

else
return buddhaFunc()
end

elseif monsterState==eMysteryMonsterState.eAlert then
if not model:is_lock_player(monster.guid)then
if not isInView then

model:set_state(monster.guid,eMysteryMonsterState.eIdle,monster)

if mysteryPosHelper.is_same_pos(monster.data.sim_pos,monster.data.origin_pos)then
return buddhaFunc()
elseif(not monsterAICfg.is_chase_homing and willChase)then
return eMysteryMonsterBehavior.eChase
else
return eMysteryMonsterBehavior.eHoming
end


elseif not isInHomingRange then
if(monsterAICfg.is_chase_homing and willChase)or(monsterAICfg.is_escape_homing and willEscape)then
return eMysteryMonsterBehavior.eHoming
end
end
end

else
return eMysteryMonsterBehavior.eStand

end


if monsterAICfg.is_chase and willChase then
return eMysteryMonsterBehavior.eChase
elseif monsterAICfg.is_escape and willEscape then
return eMysteryMonsterBehavior.eEscape
end


return buddhaFunc()
end


function mysteryAIManager.chase(monster)
local entityType=monster.entityType

local targetPos=mysteryAIManager:get_target_pos()

local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_per_steps',monster.guid)
local layer=mysteryRoomModel:get_GroundLayer(monster.roomId)
local posList=MysteryController:getPath(monster.data.sim_pos,targetPos,monsterPerSteps,layer)

return posList
end


function mysteryAIManager.homing(monster)
if mysteryPosHelper.is_same_pos(monster.data.sim_pos,monster.data.origin_pos)then
return
end
local entityType=monster.entityType


local nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_patrol_point',monster.guid)
if nextPoint then
if mysteryPosHelper.is_same_pos(nextPoint,monster.pos)then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'update_entity_patrol_point',monster.guid)
nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_patrol_point',monster.guid)
end
local haveMap=mysteryRoomModel:get_grid_pos_data(monster.roomId,nextPoint.x,nextPoint.y)
if not haveMap then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'update_entity_patrol_point',monster.guid)
nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_patrol_point',monster.guid)
end
end

local targetPos=nextPoint or monster.data.origin_pos

local layer=mysteryRoomModel:get_GroundLayer(monster.roomId)
local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_per_steps',monster.guid)
local posList=MysteryController:getPath(monster.data.sim_pos,targetPos,monsterPerSteps,layer)



return posList
end


function mysteryAIManager.escape(monster)
local entityType=monster.entityType

local playerPos=mysteryPlayerModel:get_player_pos()

local targetPos


local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_per_steps',monster.guid)
local monster_near_list=mysteryPosHelper.get_passable_near_pos_list(monster.data.sim_pos,monsterPerSteps)
local distance
for i,v in ipairs(monster_near_list)do
local newDistance=mysteryPosHelper.get_pos_distance(v,playerPos)
if not distance or newDistance>distance then
distance=newDistance
targetPos=v
end
end
local layer=mysteryRoomModel:get_GroundLayer(monster.roomId)
local posList=MysteryController:getPath(monster.data.sim_pos,targetPos,monsterPerSteps,layer)

return posList
end


function mysteryAIManager.patrol(monster)
local entityType=monster.entityType

local nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_patrol_point',monster.guid)
if nextPoint then
if mysteryPosHelper.is_same_pos(nextPoint,monster.pos)then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'update_entity_patrol_point',monster.guid)
nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_patrol_point',monster.guid)
end
local haveMap=mysteryRoomModel:get_grid_pos_data(monster.roomId,nextPoint.x,nextPoint.y)
if not haveMap then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'update_entity_patrol_point',monster.guid)
nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_patrol_point',monster.guid)
end

if nextPoint then
local layer=mysteryRoomModel:get_GroundLayer(monster.roomId)
local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_per_steps',monster.guid)
local posList=MysteryController:getPath(monster.data.sim_pos,nextPoint,monsterPerSteps,layer)

return posList
end
end


local targetPos

local newPatrolIndex=0


local nearList=monster.data.patrol_path


local patrolIndex=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_sim_patrol_index',monster.guid)
if#nearList<=0 then
newPatrolIndex=#nearList
targetPos={monster.data.sim_pos}
else
newPatrolIndex=patrolIndex%#nearList+1
targetPos=nearList[newPatrolIndex]
end


mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'set_sim_patrol_index',monster.guid,newPatrolIndex)


local layer=mysteryRoomModel:get_GroundLayer(monster.roomId)

local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_per_steps',monster.guid)
local tempPosList=MysteryController:getPath(monster.data.sim_pos,targetPos,1,layer)
local posList={tempPosList[1]}
for i=1,monsterPerSteps do
posList[#posList+1]=tempPosList[2]
end

return posList
end


function mysteryAIManager.stand(monster)
local entityType=monster.entityType

local targetPos=monster.data.sim_pos
local layer=mysteryRoomModel:get_GroundLayer(monster.roomId)
local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_per_steps',monster.guid)
local tempPosList=MysteryController:getPath(monster.data.sim_pos,targetPos,monsterPerSteps,layer)
local posList={tempPosList[1],tempPosList[1]}


return posList
end





function mysteryAIManager.calculate_target_index(playerPosList)

mysteryPlayerModel:set_ori_path(playerPosList)
local player=mysteryPlayerModel:get_player()
local roomId=player.roomId
local playerPosListLength=#playerPosList
for posIndex=2,playerPosListLength do
local playerPos=playerPosList[posIndex]
mysteryAIManager:set_target_pos(playerPos)


local tp_list=mysteryTriggerPointModel:get_entity_list()
for guid,entity in pairs(tp_list)do
local cfg=mysteryTriggerPointModel:get_config(entity.id)
if not(cfg.hide and entity.data.status>=cfg.hide)and not(cfg.grass~=nil and cfg.grass~=0)then
local isMeetPlayer=mysteryAIManager.meet(entity,entity.pos,player,playerPos)
if isMeetPlayer then
if mysteryTriggerPointModel:have_collider_ent(entity)then
return posIndex-1
else
if(cfg.trigger~=nil)or(cfg.state~=nil)then
return posIndex
end
end
end
end
end

local entityList=mysteryRoomModel:get_pos_entityList(player.roomId,playerPos)
for guid,entity in pairs(entityList)do
if not mysteryEntityBase:isAiType(entity.entityType)then
if entity.entityType~=eMysteryEntityType.eTriggerPoint then
local check=true
if entity.entityType==eMysteryEntityType.eTreasure and not mysteryTreasureModel.is_treasure_rare(entity.id)then
check=false
end
if check then

local isMeetPlayer=mysteryAIManager.meet(entity,entity.pos,player,playerPos)
if isMeetPlayer then
return posIndex
end
end
end
end
end


local triggerList=mysteryTriggerManager:get_check_pos_trigger_list()
if next(triggerList)then
for tri,v in pairs(triggerList)do
if not mysteryTriggerManager:getBanTri(tri)and not mysteryTriggerManager.checkAreaDontStop(tri)then
for i,round in ipairs(v[1])do
if round.areaType==1 then
local pos=Vector3.New(round[1],round[2],0)
if roomId==0 and mysteryPosHelper.is_near_pos(pos,playerPos,round[3])then
return posIndex
end
elseif round.areaType==2 then
if roomId~=0 then
local pos=Vector3.New(round[1],round[2],0)
if mysteryPortalModel:checkDoorAndPortal(roomId,round[4])and mysteryPosHelper.is_near_pos(pos,playerPos,round[3])then
return posIndex
end
end
end
end
end
end
end


if mysteryTrap:checkTrapStop(roomId,playerPos,posIndex)then
return posIndex
end



mysterySkillModel:update_sim_skill_steps()
end

return#playerPosList
end


function mysteryAIManager.create_monster_path()
local playerPath=mysteryPlayerModel:get_last_path()

MysteryModel:clear_all_last_path()
local length=#playerPath
local playerPathNewLast=length
local distance=mysteryPosHelper.get_pos_distance(playerPath[1],playerPath[2])
for posIndex=2,length do
local playerPos=playerPath[posIndex]
local isMeetPlayer,updateMonList=mysteryAIManager.create_monster_next_pos(playerPos,posIndex,length,distance)

if isMeetPlayer then
playerPathNewLast=posIndex
break
end
end
if playerPathNewLast~=length then
local newPath={}
for i,v in ipairs(playerPath)do
if i>playerPathNewLast then
break
end
table.insert(newPath,v)

end
mysteryPlayerModel:set_last_path(newPath)
end






end


function mysteryAIManager.create_monster_next_pos(playerPos,posIndex,last,distance)
local playerLastIndex=nil

posIndex=posIndex or 2
local player=mysteryPlayerModel:get_player()

mysteryAIManager:set_target_pos(playerPos)

for _,AIEntityType in pairs(eMysteryAIEntityType)do
local model=mysteryEntityController.getModelByEntityType(AIEntityType)
if model then
local list=model:get_entity_list()
if list then
for i,monster in pairs(list)do
local nextPoint=mysteryEntityController.invokeFuncByMysteryEntityType(AIEntityType,'get_entity_patrol_point',monster.guid)
local checkPos=mysteryPosHelper.get_pos_distance(monster.pos,playerPos)<=distance+5

if not monster.data.isRemoving and monster.roomId==player.roomId and(nextPoint~=nil or checkPos)then
if not monster.data.simStepNum then
monster.data.simStepNum=monster.data.stepNum
end

local isMeetOtherCamp=mysteryAIManager.meet_other_camp(monster)

local posList=mysteryAIManager.handle_monster_behavior(monster,playerPos)
local length=#posList
local _next=posList[length]
local isMeetPlayer=false

if(not isMeetOtherCamp)then
if length>0 then
if _next then
local triggerPoint=mysteryAIManager.meet_trigger_collider(monster,_next)
if triggerPoint==0 then
if model.set_sim_pos then
model:set_sim_pos(monster.guid,_next)
end
MysteryModel:insert_last_path(monster.guid,posList,posIndex)
end
else
if model.set_sim_pos then
model:set_sim_pos(monster.guid,_next)
end
MysteryModel:insert_last_path(monster.guid,posList,posIndex)
end

if _next then
if monster.entityType==eMysteryEntityType.eBoomMonster then
monster.data.simStepNum=monster.data.simStepNum-1
if monster.data.simStepNum<=0 then
isMeetPlayer=true
else
isMeetPlayer=mysteryAIManager.meet(monster,_next,player,playerPos)
end
else
isMeetPlayer=mysteryAIManager.meet(monster,_next,player,playerPos,nil,monster.data.range)
end
end
else
if monster.entityType==eMysteryEntityType.eBoomMonster then
if monster.data.simStepNum<=0 then
isMeetPlayer=true
else
isMeetPlayer=mysteryAIManager.meet(monster,monster.pos,player,playerPos)
end
else
isMeetPlayer=mysteryAIManager.meet(monster,monster.pos,player,playerPos,nil,monster.data.range)
end
end
end

if isMeetPlayer then
playerLastIndex=posIndex
end
if posIndex>=last then
monster.data.stop=nil
end

end
end
end
end
end


mysterySkillModel:update_sim_skill_steps()

if playerLastIndex then
return playerLastIndex
end
return nil
end


function mysteryAIManager.create_player_path(targetIndex,playerPosList)
local posList={}
for i,playerPos in pairs(playerPosList)do
if i>targetIndex then
break
end
posList[#posList+1]=playerPos
end
mysteryPlayerModel:set_last_path(posList)
mysteryPlayerModel:add_sim_steps(#posList)
end


function mysteryAIManager.reset_sim_data()

mysteryPlayerModel:reset_sim_steps()
for _,AIEntityType in pairs(eMysteryAIEntityType)do

mysteryEntityController.invokeFuncByMysteryEntityType(AIEntityType,'reset_sim_pos')

mysteryEntityController.invokeFuncByMysteryEntityType(AIEntityType,'reset_sim_patrol_index')
end





mysterySkillModel:reset_sim_skill_steps()
end


function mysteryAIManager.create_path(targetPos,isPlayerStand)

if isPlayerStand then

mysteryAIManager.reset_sim_data()

local playerPos=mysteryPlayerModel:get_player_pos()

mysteryAIManager.create_monster_next_pos(playerPos)
for _,AIEntityType in pairs(eMysteryAIEntityType)do

mysteryEntityController.invokeFuncByMysteryEntityType(AIEntityType,'update_patrol_index')
end


return true
end
local roomId=mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomId)

local playerPosListPrefab=MysteryController:getPath(mysteryPlayerModel:get_player_pos(),targetPos,0,layer)
if mysteryPosHelper.is_invalid_path(#playerPosListPrefab)then
return false
end

local playerPosList={}
local step=1
local stop_surface=MysteryModel:get_stop_surface()
for _,v in ipairs(playerPosListPrefab)do
local grid_data=MysteryModel:get_grid_data(roomId,v.x,v.y)
if grid_data then
if stop_surface[grid_data.surfaceId]then
step=stop_surface[grid_data.surfaceId]or 1
for i=1,step do
table.insert(playerPosList,v)
end
else
table.insert(playerPosList,v)
end
end
end





local targetIndex=mysteryAIManager.calculate_target_index(playerPosList)
if mysteryPosHelper.is_invalid_path(targetIndex)then
return false
end


mysteryAIManager.reset_sim_data()


mysteryAIManager.create_player_path(targetIndex,playerPosList)

mysteryAIManager.create_monster_path()




for _,AIEntityType in pairs(eMysteryAIEntityType)do

mysteryEntityController.invokeFuncByMysteryEntityType(AIEntityType,'update_patrol_index')
end

return true
end

