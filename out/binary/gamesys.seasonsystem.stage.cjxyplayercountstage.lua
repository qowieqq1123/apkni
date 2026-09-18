cjxyPlayerCountStage=simple_class(seasonStage)

function cjxyPlayerCountStage:onRefresh(serverData,isInit)
self.free=serverData.free_reward_flag or 0
self.score=serverData.score or 0
self.flag=serverData.score_reward_idx or 0

local auto_complete_times=self:getConfig("auto_complete_times")
if self.endTime<=0 and auto_complete_times~=nil and auto_complete_times>0 then
self.endTime=self.beginTime+auto_complete_times
end

if self:getConfig("free_reward")==nil then
self.free=1
end
end

function cjxyPlayerCountStage:onDelete()

end

function cjxyPlayerCountStage:getReddot()
return self:getTargetReddot()
end

function cjxyPlayerCountStage:isFinish()
local rewards=self:getConfig("score_reward")
local maxScore=rewards[#rewards][1]
return self.score>=maxScore
end

function cjxyPlayerCountStage:isOver()
local rewards=self:getConfig("score_reward")
local canGet=0
for i,v in ipairs(rewards)do
if self.score>=v[1]then
canGet=i
else
break
end
end
return self.flag>=canGet and self.free==1
end

function cjxyPlayerCountStage:getProgress()
local score_reward=self:getConfig("score_reward")
local max=score_reward[#score_reward][1]
return math.floor(self.score/max*10000)
end

function cjxyPlayerCountStage:getTargetReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end

if self.free==0 then
return true
end

local rewards=self:getConfig("score_reward")
local rewardCfg=rewards[self.flag+1]
if rewardCfg then
local score=rewardCfg[1]
return self.score>=score
end
return false
end

function cjxyPlayerCountStage:getRankReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end
return self.free==0
end

function cjxyPlayerCountStage:on_39_2(param1,param2,param3)

if param1==1 then
self.free=1

elseif param1==2 then
self.flag=param2
elseif param1==5 then
self.buff_flag=param2
end
end

function cjxyPlayerCountStage:on_39_3(score,param1)
self.score=score

local config=self:getConfig()
local score_reward=config.score_reward
local max=score_reward[#score_reward][1]
local auto_complete_times=config.auto_complete_times
if score>=max then
local nowTime=timeHelper.getServerShortTime()
if self.endTime<=0 or self.endTime>nowTime then
self.endTime=nowTime
end
end
end

return cjxyPlayerCountStage