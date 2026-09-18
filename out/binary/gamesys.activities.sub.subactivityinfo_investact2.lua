









local subActivityInfo_InvestAct2={name='subActivityInfo_InvestAct2'}

function subActivityInfo_InvestAct2:onInit()

end

function subActivityInfo_InvestAct2:onStart()

end

function subActivityInfo_InvestAct2:onDelete()

end


function subActivityInfo_InvestAct2:checkReddot()
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local times=self:getTimes()
local count=#config.taskaim
local isOpenEx=self:isOpenEx()
for i=1,count do
local isFinish=times>=config.taskaim[i][1]
local taskGotState=self:isGotReward(i)
local taskGotExState=self:isGotExReward(i)
local get=isFinish and((not taskGotState)or(isOpenEx and not taskGotExState))
if get then
return true
end
end
return false
end

function subActivityInfo_InvestAct2:checkNewDay()

end


function subActivityInfo_InvestAct2:isOpenEx()
if not self.data then
return false
end

return self.data.ex==1
end

function subActivityInfo_InvestAct2:getTimes()
if not self.data then
return 0
end

return self.data.times or 0
end

function subActivityInfo_InvestAct2:isGotReward(rewardIdx)
if not self.data then
return false
end
local flagList=self.data.flagList
if flagList then
local bei=math.floor(rewardIdx/32)
local flag=flagList[bei+1]
if flag then
return bitHelper.check_pos(flag,(rewardIdx-bei*32)-1)
end
end
return false
end

function subActivityInfo_InvestAct2:isGotExReward(rewardIdx)
if not self.data then
return false
end
local flagList=self.data.exflagList
if flagList then
local bei=math.floor(rewardIdx/32)
local flag=flagList[bei+1]
if flag then
return bitHelper.check_pos(flag,(rewardIdx-bei*32)-1)
end
end
return false
end

return subActivityInfo_InvestAct2