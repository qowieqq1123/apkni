









local subActivityInfo_targetActivity4={name='targetActivity4'}

function subActivityInfo_targetActivity4:onInit()
end

function subActivityInfo_targetActivity4:onStart()

end

function subActivityInfo_targetActivity4:onDelete()

end

function subActivityInfo_targetActivity4:checkReddot()
if not self.data then

return false
end
return self:checkHasTaskReward()
end

function subActivityInfo_targetActivity4:checkHasTaskReward()
local allTaskData=self.data and self.data.taskData or{}
local taskAllCfg=self:getSubActConfig('tasks')
local showTaskLine_lookup={}
for i,cfg in ipairs(taskAllCfg)do
local taskId=i
local isUnlock=self:checkTaskUnlockById(taskId)
if isUnlock then
local data=allTaskData[taskId]or{}
local targetValue=cfg[1]
local nowValue=isUnlock and data.task_progress or 0
local isFinish=nowValue>=targetValue
local isGot=data.task_state==3
local isShow=true
local taskLineId=cfg[8]
if taskLineId and taskLineId~=-1 then
if showTaskLine_lookup[taskLineId]then

isShow=false
elseif not isGot then
showTaskLine_lookup[taskLineId]=taskId
end
end

if isShow and isFinish and not isGot then

return true
end
end
end
return false
end

function subActivityInfo_targetActivity4:checkTaskUnlockById(taskId)
local taskAllCfg=self:getSubActConfig('tasks')
local taskCfg=taskAllCfg[taskId]
if taskCfg then
local unlockDayCount=taskCfg[2]
local beginTime_Zero=timeHelper.getServerZeroStamp(self.start_time_l)
local unlockTimeStamp=beginTime_Zero+(unlockDayCount-1)*86400
local nowTimeStamp=timeHelper.getServerLongTime()
if unlockTimeStamp<=nowTimeStamp then
return true
end
end

return false
end

function subActivityInfo_targetActivity4:reqGetTaskReward(taskId)
local json_str=jsonHelper.encode({1,taskId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_targetActivity4