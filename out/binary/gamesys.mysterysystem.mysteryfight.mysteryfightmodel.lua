







mysteryFightModel={}

mysteryFightModel.data={}

mysteryFightModel.battle={}

mysteryFightModel.battleType=
{
monster=1,
event=2,
}



function mysteryFightModel:init_data()
self.data=
{
team={},
is_fighting=false,
}

mysteryFightModel.after_queue=queue.New()

mysteryFightModel.result_queue=queue.New()
end


function mysteryFightModel:add_fight_team(teamData)
self.data.team[#self.data.team+1]=teamData
end


function mysteryFightModel:remove_fight_team(index)
table.remove(self.data.team,index)
end


function mysteryFightModel:get_fight_team()
return self.data.team
end


function mysteryFightModel:clear_fight_team()
self.data.team={}
end


function mysteryFightModel:set_team()
self.data.team={}
end


function mysteryFightModel:set_fighting_reward(reward)
self.data.fightingReward=reward
end


function mysteryFightModel:get_fighting_reward()
return self.data.fightingReward
end




function mysteryFightModel:set_battle_id(battleId)
mysteryFightModel.battle.id=battleId
end


function mysteryFightModel:get_battle_id()
return mysteryFightModel.battle.id
end


function mysteryFightModel:has_battle_playing()



return fightController:isBattlePlaying(mysteryFightModel.battle.id)
end




function mysteryFightModel:set_fighting(isFighting)
self.data.is_fighting=isFighting
end


function mysteryFightModel:is_fighting()
return self.data.is_fighting
end




function mysteryFightModel:set_rule_callback(callback)
self.data.ruleCallback=callback
end



function mysteryFightModel:on_rule_callback()
if self.data.ruleCallback then
self.data.ruleCallback()
self.data.ruleCallback=nil
return true
end
return false
end



function mysteryFightModel:enqueue_after_callback(callback,...)
local value={callback=callback,args={...}}
mysteryFightModel.after_queue:enqueue(value)
end

function mysteryFightModel:dequeue_after_callback()
local value=mysteryFightModel.after_queue:dequeue()
if value then
if value.callback then
value.callback(unpack(value.args))
end
end
end

function mysteryFightModel:clear_after_queue()
mysteryFightModel.after_queue:clear()
end

function mysteryFightModel:get_after_queue_size()
return mysteryFightModel.after_queue:size()
end



function mysteryFightModel:enqueue_result_callback(callback,...)
local value={callback=callback,args={...}}
mysteryFightModel.result_queue:enqueue(value)
end

function mysteryFightModel:dequeue_result_callback()
local value=mysteryFightModel.result_queue:dequeue()
if value then
if value.callback then
value.callback(unpack(value.args))
end
end
end

function mysteryFightModel:clear_result_queue()
mysteryFightModel.result_queue:clear()
end

function mysteryFightModel:get_result_queue_size()
return mysteryFightModel.result_queue:size()
end

