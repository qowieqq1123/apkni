







mysteryWeirdBoxModel=mysteryEntityBase.new(eMysteryEntityType.eWeirdBox,mysteryEntityBase)

mysteryWeirdBoxModel.entityType=eMysteryEntityType.eWeirdBox


mysteryWeirdBoxModel.lastPath={}

mysteryWeirdBoxModel.steps={}

mysteryWeirdBoxModel.state={}



function mysteryWeirdBoxModel:get_config(id)
local config=cfgHelper.get(cfg_ssentityweirdboxconfig_get,id)
return config
end

function mysteryWeirdBoxModel.get_ai_config(id)
local config=cfg_secretsceneaiconfig_get(id)
return config
end



function mysteryWeirdBoxModel:init_data()
self.steps={}
self.state={}
self.lastPath={}
end

function mysteryWeirdBoxModel:get_monster_by_origin_pos(pos,roomId)
local list={}
for i,monster in pairs(self:get_entity_list())do
if mysteryPosHelper.is_same_pos(monster.data.origin_pos,pos,monster.roomId,roomId)then
table.insert(list,monster)
end
end
return list
end


function mysteryWeirdBoxModel:set_sim_pos(guid,pos)
local entity=self:get_entity(guid)
if entity then
entity.data.sim_pos=pos
else
logErr(FMT.fmt("找不到怪物entity",guid))
end
end


function mysteryWeirdBoxModel:reset_sim_pos()
for i,monster in pairs(self:get_entity_list())do
self:set_sim_pos(monster.guid,monster.pos)
end
end


function mysteryWeirdBoxModel:get_monster_fight_value()
return 0
end


function mysteryWeirdBoxModel:flash(guid,pos)
local entity=mysteryWeirdBoxModel:get_entity(guid)
mysteryWeirdBoxController:move_begin_callback(entity,pos)
mysteryWeirdBoxController:move_point_callback(entity,pos)
mysteryWeirdBoxController:move_complete_callback(entity)
end

function mysteryWeirdBoxModel:get_monster_view(guid,roomId,monsterPos)
local player=mysteryPlayerModel:get_player()
local playerPos=mysteryPlayerModel:get_player_pos()
local monsterAICfg=mysteryWeirdBoxModel:get_entity_ai_config(guid)

local isInAlertRange=mysteryPosHelper.is_in_check_range(monsterPos,playerPos,monsterAICfg.alert_range,roomId,player.roomId)

local hasHide=mysterySkillModel:has_sim_hide_steps()
return isInAlertRange and not hasHide
end



function mysteryWeirdBoxModel:has_monster()
for i,v in pairs(self:get_entity_list())do
return true
end
return false
end


function mysteryWeirdBoxModel:is_move_inteval(guid)
local monsterCfg=self:get_entity_ai_config(guid)
local moveInteval=monsterCfg.move_inteval
local playerSteps=mysteryPlayerModel:get_sim_steps()
local isMoveInteval=(playerSteps%moveInteval~=0)
return isMoveInteval
end


function mysteryWeirdBoxModel:is_steps_limit(guid)
local monsterCfg=self:get_entity_ai_config(guid)
return self:get_steps(guid)>=monsterCfg.steps
end


function mysteryWeirdBoxModel:is_in_same_room(guid)
local monsterRoomID=self:get_entity(guid).roomId
local roomID=mysteryRoomModel:get_cur_roomID()
return monsterRoomID==roomID
end





function mysteryWeirdBoxModel:set_steps(guid,steps)
self.steps[guid]=steps
end

function mysteryWeirdBoxModel:add_steps(guid,steps)
if not self.steps[guid]then
self.steps[guid]=0
end
self.steps[guid]=self.steps[guid]+steps
end

function mysteryWeirdBoxModel:get_steps(guid)
if not self.steps[guid]then
self.steps[guid]=0
end
return self.steps[guid]
end



function mysteryWeirdBoxModel:set_state(guid,state)
self.state[guid]=state
end

function mysteryWeirdBoxModel:get_state(guid)
if not self.state[guid]then
self.state[guid]=eMysteryMonsterState.eIdle
end
return self.state[guid]
end



function mysteryWeirdBoxModel:update_patrol_index()
for i,monster in pairs(self:get_entity_list())do
self:set_patrol_index(monster.guid,monster.data.sim_patrol_index)
end
end

function mysteryWeirdBoxModel:set_patrol_index(guid,index)
self:get_entity(guid).data.patrol_index=index
end

function mysteryWeirdBoxModel:get_patrol_index(guid)
return self:get_entity(guid).data.patrol_index
end


function mysteryWeirdBoxModel:reset_sim_patrol_index()
for i,monster in pairs(self:get_entity_list())do
self:set_sim_patrol_index(monster.guid,monster.data.patrol_index)
end
end


function mysteryWeirdBoxModel:set_sim_patrol_index(guid,index)
self:get_entity(guid).data.sim_patrol_index=index
end

function mysteryWeirdBoxModel:get_sim_patrol_index(guid)
return self:get_entity(guid).data.sim_patrol_index
end




function mysteryWeirdBoxModel:set_lock_player(guid,isLock)
self:get_entity(guid).data.isLockPlayer=isLock
end


function mysteryWeirdBoxModel:is_lock_player(guid)
return self:get_entity(guid).data.isLockPlayer
end

