







mysteryMonsterModel=mysteryEntityBase.new(eMysteryEntityType.eMonster,mysteryEntityBase)

mysteryMonsterModel.entityType=eMysteryEntityType.eMonster

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject


mysteryMonsterModel.lastPath={}

mysteryMonsterModel.steps={}

mysteryMonsterModel.state={}

mysteryMonsterModel.mergeCount={}

mysteryMonsterModel.mergeList={}



function mysteryMonsterModel:get_config(id)
local config=cfgHelper.get(cfg_monstergroup_get,id)
return config
end

function mysteryMonsterModel.get_monster_group_config(id)
local config=cfgHelper.get(cfg_monstergroup_get,id)
return config
end

function mysteryMonsterModel.get_monster_config(id)
local config=cfgHelper.get(cfg_monsterconfig_get,id)
return config
end

function mysteryMonsterModel.get_ai_config(id)
local config=cfgHelper.get(cfg_secretsceneaiconfig_get,id)
return config
end

function mysteryMonsterModel:get_monster_type(id)
local config=self.get_monster_group_config(id)
if config then
return config.monType
end
end



function mysteryMonsterModel:init_data()
self.steps={}
self.state={}
self.lastPath={}
self.mergeCount={}
self.mergeList={}
self.selectList={}
end

function mysteryMonsterModel:dealServerData(data)
local newData=data.etComm
newData.gwReward=data.gwReward
newData.blood=data.blood
newData.stepNum=data.stepNum
newData.etType=data.etType
newData.guid=newData.etGuid
return newData
end

function mysteryMonsterModel:get_monster_by_origin_pos(pos,roomId)
local list={}
for i,monster in pairs(self:get_entity_list())do
if mysteryPosHelper.is_same_pos(monster.data.origin_pos,pos,monster.roomId,roomId)then
table.insert(list,monster)
end
end
return list
end


function mysteryMonsterModel:set_sim_pos(guid,pos)
local entity=self:get_entity(guid)
if entity then
entity.data.sim_pos=pos
else
logErr(FMT.fmt("找不到怪物entity",guid))
end
end


function mysteryMonsterModel:reset_sim_pos()
for i,monster in pairs(self:get_entity_list())do
self:set_sim_pos(monster.guid,monster.pos)
end
end


function mysteryMonsterModel:get_monster_fight_value(guid)
return self:get_entity(guid).data.fight_value
end


function mysteryMonsterModel:flash(guid,pos)
local entity=mysteryMonsterModel:get_entity(guid)
mysteryMonsterController:move_begin_callback(entity,pos)
mysteryMonsterController:stop_move(entity,{pos})

mysteryMonsterModel:play_animation(entity.guid,eAnimationID.jump3,MysteryModel:getMoveAnimSpeed())
end

function mysteryMonsterModel:get_monster_view(guid,roomId,monsterPos)
local player=mysteryPlayerModel:get_player()
local playerPos=mysteryPlayerModel:get_player_pos()
local monsterAICfg=mysteryMonsterModel:get_entity_ai_config(guid)

local isInAlertRange=mysteryPosHelper.is_in_check_range(monsterPos,playerPos,monsterAICfg.alert_range,roomId,player.roomId)

local hasHide=mysterySkillModel:has_sim_hide_steps()
return isInAlertRange and not hasHide
end




















function mysteryMonsterModel:has_monster()
for i,v in pairs(self:get_entity_list())do
return true
end
return false
end


function mysteryMonsterModel:is_move_inteval(guid)
local monsterCfg=mysteryMonsterModel:get_entity_ai_config(guid)
local moveInteval=monsterCfg.move_inteval
local playerSteps=mysteryPlayerModel:get_sim_steps()
local isMoveInteval=(playerSteps%moveInteval~=0)
return isMoveInteval
end


function mysteryMonsterModel:is_steps_limit(guid)
local monsterCfg=mysteryMonsterModel:get_entity_ai_config(guid)
return self:get_steps(guid)>=monsterCfg.steps
end


function mysteryMonsterModel:is_in_same_room(guid)
local monsterRoomID=self:get_entity(guid).roomId
local roomID=mysteryRoomModel:get_cur_roomID()
return monsterRoomID==roomID
end






function mysteryMonsterModel:set_steps(guid,steps)
self.steps[guid]=steps
end

function mysteryMonsterModel:add_steps(guid,steps)
if not self.steps[guid]then
self.steps[guid]=0
end
self.steps[guid]=self.steps[guid]+steps
end

function mysteryMonsterModel:get_steps(guid)
if not self.steps[guid]then
self.steps[guid]=0
end
return self.steps[guid]
end



function mysteryMonsterModel:set_state(guid,state,monster)
self.state[guid]=state

if state==eMysteryMonsterState.eAlert then
if monster.hud and(not monster.appearHUD)then
monster.hud:entityAppear()
end
elseif state==eMysteryMonsterState.eIdle then
if monster.hud then
monster.hud:entityPlayerNotFound()
end
monster.appearHUD=false
end
end

function mysteryMonsterModel:get_state(guid)
if not self.state[guid]then
self.state[guid]=eMysteryMonsterState.eIdle
end
return self.state[guid]
end



function mysteryMonsterModel:set_entity_forward(guid,pos)
mysteryEntityBase.set_entity_forward(self,guid,pos)
local entity=self:get_entity(guid)
if not entity then
return
end
if entity.hud then
local isRightward=entity.isRightward
entity.hud:setRightward(isRightward)
end
end

function mysteryMonsterModel:set_monster_select(guid)
self.selectList[guid]=true
end

function mysteryMonsterModel:get_monster_select(guid)
return self.selectList[guid]
end

function mysteryMonsterModel:clear_monster_select()
self.selectList={}
end


function mysteryMonsterModel:update_patrol_index()
for i,monster in pairs(self:get_entity_list())do
self:set_patrol_index(monster.guid,monster.data.sim_patrol_index)
end
end

function mysteryMonsterModel:set_patrol_index(guid,index)
self:get_entity(guid).data.patrol_index=index
end

function mysteryMonsterModel:get_patrol_index(guid)
return self:get_entity(guid).data.patrol_index
end


function mysteryMonsterModel:reset_sim_patrol_index()
for i,monster in pairs(self:get_entity_list())do
self:set_sim_patrol_index(monster.guid,monster.data.patrol_index)
end
end


function mysteryMonsterModel:set_sim_patrol_index(guid,index)
self:get_entity(guid).data.sim_patrol_index=index
end

function mysteryMonsterModel:get_sim_patrol_index(guid)
return self:get_entity(guid).data.sim_patrol_index
end



function mysteryMonsterModel:refresh_all_hud()
for i,v in pairs(self:get_entity_list())do
self:refresh_hud(v.guid)
end
end


function mysteryMonsterModel:refresh_hud(guid)

local entity=self:get_entity(guid)
if not entity then
return
end

local hud=entity.hud
if not hud then
return
end




hud:refreshVisible(entity.isVisible)


end



function mysteryMonsterModel:hide_hud(guid)
local entity=self:get_entity(guid)
local hud=entity.hud
if not hud then
return
end
hud:refreshVisible(false)
end


function mysteryMonsterModel:bind_hud(guid,hud)
local monster=self:get_entity(guid)
if not monster then
return
end
monster.hud=hud
return monster
end




function mysteryMonsterModel:get_my_range_count(entity)
local count=1

if entity.data.child then
for i,v in pairs(entity.data.child)do
count=count+1
end
end
return count
end



function mysteryMonsterModel:set_merge_entity_parent(myEntity,parentEntity)
if myEntity.data.parent then
myEntity.data.parent.data.child[myEntity.guid]=nil
end
if parentEntity then
if parentEntity.data.parent~=myEntity then
myEntity.data.parent=parentEntity
if not parentEntity.data.child then
parentEntity.data.child={}
end
parentEntity.data.child[myEntity.guid]=myEntity
end
else
myEntity.data.parent=nil
end
end

function mysteryMonsterModel:get_merge_entity_parent(myEntity)
return myEntity.data.parent
end




function mysteryMonsterModel:set_lock_player(guid,isLock)
self:get_entity(guid).data.isLockPlayer=isLock
end


function mysteryMonsterModel:is_lock_player(guid)
return self:get_entity(guid).data.isLockPlayer
end

