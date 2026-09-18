







local _MODULENAME="mysterySkillController"
gameState.addListener(def_table(_MODULENAME))
mysterySkillController.name=_MODULENAME



function mysterySkillController:onAppStart()
self:register_receiver()
end

function mysterySkillController:onEnterState()
mysterySkillModel:init_data()
end

function mysterySkillController:onLeaveState()

end




function mysterySkillController:register_receiver()
socketManager:register_receiver(4,14,mysterySkillController.recv_4_14)
socketManager:register_receiver(4,86,mysterySkillController.recv_4_86)
end


function mysterySkillController.req_use_skill(fbid,args)
mysterySkillModel.data.sendArgs=args
socketManager:send_4_14(fbid,args.skillId)
mysteryAIManager:set_mystery_state(true,false,5)
end









function mysterySkillController.recv_4_14(result,skillId,skillTimes,crit)


mysterySkillModel:clear_ready_skill()
mysteryAIManager:set_mystery_state(false)

if result==1 then
error('使用技能失败',skillId)
return
end

if mysterySkillModel.data.sendArgs then
mysterySkillEffectManager:recv_skill(skillId,mysterySkillModel.data.sendArgs)
mysterySkillModel.data.sendArgs=nil
end


mysterySkillModel:set_fb_probeSkill_use_count(skillId,skillTimes)

UIManager:invokeUIMethod("UIMysteryWin","initSkillList")

end


function mysterySkillController.recv_4_86(len,skillList)
if len>0 then
for i,v in ipairs(skillList)do
mysterySkillModel:set_fb_probeSkill_use_count(v.param_1,v.param_2)
end
UIManager:invokeUIMethod("UIMysteryWin","initSkillList")
end
end


function mysterySkillController:set_hide_steps(steps)
mysterySkillModel:set_hide_steps(steps)
local guid=mysteryPlayerModel:get_player_guid()
if guid~=nil then
if steps>0 then

mysteryPlayerModel:fade_to_color(guid,Color.New(1,1,1,0.5),1,nil,0)
else

if not mysteryPlayerModel:isPlayerInGrass()then
mysteryPlayerModel:fade_to_color(guid,Color.New(1,1,1,1),1,nil,0)
end
UIManager:invokeUIMethod("UIMysteryWin","showEffect",0,false)
end
end
end

function mysterySkillController:update_skill_steps()
local hideSteps=mysterySkillModel:get_hide_steps()
mysterySkillModel:update_skill_steps()
local afterHideSteps=mysterySkillModel:get_hide_steps()
if afterHideSteps<=0 and afterHideSteps<hideSteps then

mysteryPlayerModel:fade_to_color(mysteryPlayerModel:get_player_guid(),Color.New(1,1,1,1),1,nil,0)
UIManager:invokeUIMethod("UIMysteryWin","showEffect",0,false)
end
end