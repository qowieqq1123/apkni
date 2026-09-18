cjxyMonsterCountStage=simple_class(seasonStage)

function cjxyMonsterCountStage:onRefresh(serverData,isInit)
self.free=serverData.free_reward_flag or 0
self.score=serverData.score or 0
self.flag=serverData.score_reward_idx or 0

if self:getConfig("free_reward")==nil then
self.free=1
end
end

function cjxyMonsterCountStage:onDelete()

end

function cjxyMonsterCountStage:getReddot()
return self:getTargetReddot()
end

function cjxyMonsterCountStage:isFinish()
local rewards=self:getConfig("score_reward")
local maxScore=rewards[#rewards][1]
return self.score>=maxScore
end

function cjxyMonsterCountStage:isOver()
local rewards=self:getConfig("score_reward")
return self.flag>=#rewards and self.free==1
end

function cjxyMonsterCountStage:getProgress()
local score_reward=self:getConfig("score_reward")
local max=score_reward[#score_reward][1]
return math.floor(self.score/max*10000)
end

function cjxyMonsterCountStage:getTargetReddot()
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

function cjxyMonsterCountStage:getRankReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end

return self.free==0
end

function cjxyMonsterCountStage:on_39_2(param1,param2,param3)

if param1==1 then
self.free=1

elseif param1==2 then
self.flag=param2
elseif param1==5 then
self.buff_flag=param2
end
end

function cjxyMonsterCountStage:on_39_3(score,param1)
self.score=score

local score_reward=self:getConfig("score_reward")
local max=score_reward[#score_reward][1]
if score>=max then
local nowTime=timeHelper.getServerShortTime()
if self.endTime<=0 or self.endTime>nowTime then
self.endTime=nowTime
end
end
end

return cjxyMonsterCountStage