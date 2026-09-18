cjxyTaskCountStage=simple_class(seasonStage)

function cjxyTaskCountStage:onRefresh(serverData,isInit)
self.free=serverData.free_reward_flag or 0
self.score=serverData.score or 0
self.flag=serverData.score_reward_idx or 0
self.daily=serverData.dayTaskList or{}
self.access=serverData.flush_day_task_flag or 0
self.add_task_flag=serverData.add_task_flag or 0

if self:getConfig("free_reward")==nil then
self.free=1
end

if self.add_task_flag==0 then
seasonController:send_39_2(self.handle.id,self.index,4)
end
end

function cjxyTaskCountStage:onDelete()

end

function cjxyTaskCountStage:getReddot()
return self:getTargetReddot()
end

function cjxyTaskCountStage:isFinish()
local rewards=self:getConfig("score_reward")
local maxScore=rewards[#rewards][1]
return self.score>=maxScore
end

function cjxyTaskCountStage:isOver()
if not self:isOverEnd()and not seasonModel:isInitTaskData()then return false end
















local rewards=self:getConfig("score_reward")
return self.flag>=#rewards and self.free==1
end

function cjxyTaskCountStage:getTargetReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end

if self.free==0 then
return true
end

if self:getChapterTaskReddot()then
return true
end

if self:getDailyTaskReddot()then
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

function cjxyTaskCountStage:getRankReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end
return self.free==0
end

function cjxyTaskCountStage:getDailyTaskReddot()
if not self:isOverBegin()and not self:checkOpen()or self:isOverEnd()then return false end
if self.access==0 then
return true
end

if not seasonModel:isInitTaskData()then return false end

for index,taskId in pairs(self.daily)do
local taskData=seasonModel:getTaskData(taskId)
if taskData and taskData.task_state==taskModel.taskRewardState then
return true
end
end
return false
end

function cjxyTaskCountStage:getChapterTaskReddot()
if not self:isOverBegin()and not self:checkOpen()or self:isOverEnd()then return false end
if not seasonModel:isInitTaskData()then return false end

local task_conf=self:getConfig("task_conf")
for taskId,temp in pairs(task_conf)do
local taskData=seasonModel:getTaskData(taskId)
if taskData and taskData.task_state==taskModel.taskRewardState then
return true
end
end
return false
end

function cjxyTaskCountStage:getProgress()
local score_reward=self:getConfig("score_reward")
local max=score_reward[#score_reward][1]
return math.floor(self.score/max*10000)
end

function cjxyTaskCountStage:on_39_2(param1,param2,param3)

if param1==1 then
self.free=1

elseif param1==2 then
self.flag=param2
elseif param1==3 then
self.access=1
elseif param1==5 then
self.buff_flag=param2
end
end

function cjxyTaskCountStage:on_39_3(score,param1)
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

function cjxyTaskCountStage:onStoryComplete()
if self.access==0 then
seasonController:send_39_2(self.handle.id,self.index,3)
end
end

function cjxyTaskCountStage:onNewDay()
local nowTime=timeHelper.getServerShortTime()
if not timeHelper.checkInSameDay2(nowTime,self.beginTime)then
self.access=0
end
return true
end

function cjxyTaskCountStage:containTask(taskId)
local task_conf=self:getConfig("task_conf")
return task_conf[taskId]or table.containsValue(self.daily,taskId)
end

function cjxyTaskCountStage:onBegin()
if self:checkOpen()then
socketManager:send_35_95()

seasonController:checkMountainOpen(self.handle.id,self.index)
end
end

function cjxyTaskCountStage:onEnd()
if self:checkOpen()then
seasonController:checkMountainOpen(self.handle.id,self.index)
end
end

return cjxyTaskCountStage