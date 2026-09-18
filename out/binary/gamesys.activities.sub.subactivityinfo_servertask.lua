









local subActivityInfo_servertask={name='subActivityInfo_servertask'}

function subActivityInfo_servertask:onInit()

end

function subActivityInfo_servertask:onStart()

end

function subActivityInfo_servertask:onDelete()

end

function subActivityInfo_servertask:onUpdate()
if self.data then
self.reqTime=self.reqTime or 0
self.reqTime=self.reqTime+1
if self.reqTime>=60 then
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.act_id,self.sub_act_type,self.sub_act_id)
self.reqTime=0
end
end
end

function subActivityInfo_servertask:checkReddot()
if not self.data then

return false
end
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local goalList=self.data.goalList or{}

local jdReward=self.data.jdReward or 0
local finishNum=self.data.finishNum or 0

for i,v in ipairs(config.jdRewards)do
local isSignIn=v[1]<=finishNum
local isGot=v[1]<=jdReward
if isSignIn and not isGot then
return true
end
end

local allGoal=config.allGoal

for i,v in ipairs(allGoal)do
local taskGoldData=goalList[i]
local cur=taskGoldData and tonumber(tostring(taskGoldData.jdVal))or 0
local isGot=taskGoldData and taskGoldData.rewardFlag==1
local need=v[3]
if cur>=need and not isGot then
return true
end
end

return false
end


return subActivityInfo_servertask