







mysteryMoveTreasureModel=mysteryEntityBase.new(eMysteryEntityType.eMoveTreasure,{})

mysteryMoveTreasureModel.entityType=eMysteryEntityType.eMoveTreasure


mysteryMoveTreasureModel.lastPath={}

mysteryMoveTreasureModel.steps={}

mysteryMoveTreasureModel.state={}



function mysteryMoveTreasureModel:get_config(id)
local config=cfgHelper.get(cfg_ssentityjiangliguaiconfig_get,id)
return config
end

function mysteryMoveTreasureModel.get_ai_config(id)
local config=cfg_secretsceneaiconfig_get(id)
return config
end



function mysteryMoveTreasureModel:init_data()
self.steps={}
self.state={}
self.lastPath={}
end

function mysteryMoveTreasureModel:dealServerData(data)
local newData=data.etComm
newData.gwReward=data.gwReward
newData.blood=data.blood
newData.stepNum=data.stepNum
newData.etType=data.etType
newData.guid=newData.etGuid
return newData
end

function mysteryMoveTreasureModel:get_monster_by_origin_pos(pos,roomId)
local list={}
for i,monster in pairs(self:get_entity_list())do
if mysteryPosHelper.is_same_pos(monster.data.origin_pos,pos,monster.roomId,roomId)then
table.insert(list,monster)
end
end
return list
end


function mysteryMoveTreasureModel:set_sim_pos(guid,pos)
local entity=self:get_entity(guid)
if entity then
entity.data.sim_pos=pos
else
logErr(FMT.fmt("找不到怪物entity",guid))
end
end


function mysteryMoveTreasureModel:reset_sim_pos()
for i,monster in pairs(self:get_entity_list())do
self:set_sim_pos(monster.guid,monster.pos)
end
end


function mysteryMoveTreasureModel:get_monster_fight_value()
return 0
end


function mysteryMoveTreasureModel:flash(guid,pos)
local entity=self:get_entity(guid)
mysteryMoveTreasureController:move_begin_callback(entity,pos)
mysteryMoveTreasureController:move_point_callback(entity,pos)
mysteryMoveTreasureController:move_complete_callback(entity)
end

function mysteryMoveTreasureModel:get_monster_view(guid,roomId,monsterPos)
local player=mysteryPlayerModel:get_player()
local playerPos=mysteryPlayerModel:get_player_pos()
local monsterAICfg=mysteryMoveTreasureModel:get_entity_ai_config(guid)

local isInAlertRange=mysteryPosHelper.is_in_check_range(monsterPos,playerPos,monsterAICfg.alert_range,roomId,player.roomId)

local hasHide=mysterySkillModel:has_sim_hide_steps()
return isInAlertRange and not hasHide
end



function mysteryMoveTreasureModel:has_monster()
for i,v in pairs(self:get_entity_list())do
return true
end
return false
end


function mysteryMoveTreasureModel:is_move_inteval(guid)
local monsterCfg=self:get_entity_ai_config(guid)
local moveInteval=monsterCfg.move_inteval
local playerSteps=mysteryPlayerModel:get_sim_steps()
local isMoveInteval=(playerSteps%moveInteval~=0)
return isMoveInteval
end


function mysteryMoveTreasureModel:is_steps_limit(guid)
local monsterCfg=self:get_entity_ai_config(guid)
return self:get_steps(guid)>=monsterCfg.steps
end


function mysteryMoveTreasureModel:is_in_same_room(guid)
local monsterRoomID=self:get_entity(guid).roomId
local roomID=mysteryRoomModel:get_cur_roomID()
return monsterRoomID==roomID
end






function mysteryMoveTreasureModel:set_steps(guid,steps)
self.steps[guid]=steps
end

function mysteryMoveTreasureModel:add_steps(guid,steps)
if not self.steps[guid]then
self.steps[guid]=0
end
self.steps[guid]=self.steps[guid]+steps
end

function mysteryMoveTreasureModel:get_steps(guid)
if not self.steps[guid]then
self.steps[guid]=0
end
return self.steps[guid]
end

function mysteryMoveTreasureModel:set_disappear_steps(guid,num,increase)
local entity=self.entityList[guid]
if entity then
if increase then
if entity.data.stepNum>0 then
entity.data.stepNum=entity.data.stepNum-1
else
entity.data.stepNum=0
end
else
entity.data.stepNum=num
end
end
end

function mysteryMoveTreasureModel:is_disappear(guid)
local entity=self.entityList[guid]
if entity then
return entity.data.stepNum<=0
end
end



function mysteryMoveTreasureModel:set_state(guid,state)
self.state[guid]=state
end

function mysteryMoveTreasureModel:get_state(guid)
if not self.state[guid]then
self.state[guid]=eMysteryMonsterState.eIdle
end
return self.state[guid]
end



function mysteryMoveTreasureModel:update_patrol_index()
for i,monster in pairs(self:get_entity_list())do
self:set_patrol_index(monster.guid,monster.data.sim_patrol_index)
end
end

function mysteryMoveTreasureModel:set_patrol_index(guid,index)
self:get_entity(guid).data.patrol_index=index
end

function mysteryMoveTreasureModel:get_patrol_index(guid)
return self:get_entity(guid).data.patrol_index
end


function mysteryMoveTreasureModel:reset_sim_patrol_index()
for i,monster in pairs(self:get_entity_list())do
self:set_sim_patrol_index(monster.guid,monster.data.patrol_index)
end
end


function mysteryMoveTreasureModel:set_sim_patrol_index(guid,index)
self:get_entity(guid).data.sim_patrol_index=index
end

function mysteryMoveTreasureModel:get_sim_patrol_index(guid)
return self:get_entity(guid).data.sim_patrol_index
end



function mysteryMoveTreasureModel:refresh_all_hud()
for i,v in pairs(self:get_entity_list())do
self:refresh_hud(v.guid)
end
end


function mysteryMoveTreasureModel:refresh_hud(guid)

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



function mysteryMoveTreasureModel:hide_hud(guid)
local entity=self:get_entity(guid)
local hud=entity.hud
if not hud then
return
end
hud:refreshVisible(false)
end


function mysteryMoveTreasureModel:bind_hud(guid,hud)
local monster=self:get_entity(guid)
if not monster then
return
end
monster.hud=hud
return monster
end




function mysteryMoveTreasureModel:set_lock_player(guid,isLock)
self:get_entity(guid).data.isLockPlayer=isLock
end


function mysteryMoveTreasureModel:is_lock_player(guid)
return self:get_entity(guid).data.isLockPlayer
end

