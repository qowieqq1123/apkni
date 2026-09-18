local _recv_5_12_handle={
[eExperiencePonitState.Init]=function(id,state)
local oPoint=worldExperienceModel:getCurrentPoint()
local oState=worldExperienceModel:getCurrentState()

if oState<eExperiencePonitState.Finish and oPoint~=id then
worldExperienceController:doFinishProgress()
end

worldExperienceModel:addPointState(id,state)
worldExperienceModel:setTarget()

worldExperienceController:changeToCloseUnit(oPoint)

worldExperienceController:showOpenPointUnit(id)

worldExperienceController:showPathSegmentUnit(oPoint,id,false)


if worldExperienceModel:checkScene()then
UIManager:showWindow("UIWorldExperienceWin")
local oCfg=cfgHelper.get1(cfg_experienceconfig_get,oPoint)
if oCfg.autoNext then
worldExperienceController:doContinue()
end
end
end,
[eExperiencePonitState.PreStory]=function(id,state)




worldExperienceModel:addPointState(id,state)
worldExperienceModel:setTarget()
if worldExperienceModel:checkScene()then
worldExperienceController:doContinue()
end










end,
[eExperiencePonitState.Content]=function(id,state)

worldExperienceModel:addPointState(id,state)
worldExperienceModel:setTarget()
if worldExperienceModel:checkScene()then
worldExperienceController:doContinue()
end
end,
[eExperiencePonitState.PostStory]=function(id,state)

worldExperienceModel:addPointState(id,state)
worldExperienceModel:setTarget()
if worldExperienceModel:checkScene()then
if not worldExperienceModel:isBattlePlaying()then
worldExperienceController:doContinue()
end
end
end,
[eExperiencePonitState.Finish]=function(id,state)
worldExperienceModel:addPointState(id,state)
worldExperienceModel:setTarget()
if worldExperienceModel:checkScene()then
worldExperienceController:doContinue()
end
end,
}

local _comminication=false




function worldExperienceController:send_5_12(id,state)
_comminication=true
socketManager:send_5_12(id,state)
end


function worldExperienceController.recv_5_11(passLen,passArray,lastState)
_comminication=false
if worldController:isInWorld()then
worldExperienceController:onExitWorldEvent(worldModel.world)
end
worldExperienceModel:setData(passArray,lastState)
worldModel:finishInit(eWorldUnitTpye.EXPERIENCE)
if initProControl.isDone()then
worldExperienceController:checkReConnection()
end
end




function worldExperienceController.recv_5_12(id,state)
_comminication=false
_recv_5_12_handle[state](id,state)
end



function worldExperienceController:isInCommunication()
return _comminication
end




function worldExperienceController.recv_5_7(area,error)
if error==0 then
worldExperienceModel:setReward(area,true)
notifySystem:postNotify(notifyConfig.onWorldAreaReward,area)


elseif error==1 then
UIManager.error("奖励已领取过了")
elseif error==2 then
UIManager.error("奖励还不能领取")
end
end



function worldExperienceController:send_5_7(area)
socketManager:send_5_7(area)
end