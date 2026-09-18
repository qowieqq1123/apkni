









local subActivityInfo_limitInvestor={name='subActivityInfo_limitInvestor'}

function subActivityInfo_limitInvestor:onInit()

end

function subActivityInfo_limitInvestor:onStart()

end

function subActivityInfo_limitInvestor:onDelete()

end

function subActivityInfo_limitInvestor:checkReddot()
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local dayOut=self:getDayOut()
local count=#config.reward
local isOpenEx=self:isOpenEx()
for i=1,count do
local isFinish=dayOut>=i
local taskGotState=self:isGotReward(i)
local taskGotExState=self:isGotExReward(i)
local get=isFinish and((not taskGotState)or(isOpenEx and not taskGotExState))
if get then
return true
end
end
return false
end

function subActivityInfo_limitInvestor:isGotReward(rewardIdx)
if not self.data then
return false
end
local flag=self.data.flag
return bitHelper.check_pos(flag,rewardIdx-1)
end

function subActivityInfo_limitInvestor:isGotExReward(rewardIdx)
if not self.data then
return false
end
local flag=self.data.exflag
return bitHelper.check_pos(flag,rewardIdx-1)
end

function subActivityInfo_limitInvestor:isOpenEx()
if not self.data then
return false
end

return self.data.ex==1
end

function subActivityInfo_limitInvestor:getDayOut()
local start_time=self.start_time
local longTime=timeHelper.getServerShortTime()
local et=longTime-start_time

local day=1
if et<0 then
day=1
else
local cc=math.ceil(et/60)
cc=math.floor(cc/60)
cc=math.floor(cc/24)
local DD=cc
day=DD+1
end
return day
end







return subActivityInfo_limitInvestor