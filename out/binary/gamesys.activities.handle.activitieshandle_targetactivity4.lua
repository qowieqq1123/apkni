







activitiesHandle_targetActivity4=new_activitiesHandle('activitiesHandle_targetActivity4',activitiesHandle)

function activitiesHandle_targetActivity4:onInit()
self.refreshTimer={}
end

function activitiesHandle_targetActivity4:onDelete()
self:clearAllNextRefreshReddotTimer()
end

function activitiesHandle_targetActivity4:checkHasNextRefreshReddotTime(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTargetTask4
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local actConfig=activitiesModel:getSubActivityConfig(subType,subId)
local taskAllCfg=actConfig.tasks
local minTaskUnlockTime
local nowTimeStamp=timeHelper.getServerLongTime()
if taskAllCfg then
for i,taskCfg in ipairs(taskAllCfg)do
local unlockDayCount=taskCfg[2]
local beginTime_Zero=timeHelper.getServerZeroStamp(info.start_time_l)
local unlockTimeStamp=beginTime_Zero+(unlockDayCount-1)*86400
if unlockTimeStamp>nowTimeStamp then
if not minTaskUnlockTime or minTaskUnlockTime<unlockTimeStamp then
minTaskUnlockTime=unlockTimeStamp
end
end
end
end

if minTaskUnlockTime then
return self:setNextRefreshReddotTimer(actId,subId,minTaskUnlockTime)
end
end
end

function activitiesHandle_targetActivity4:setNextRefreshReddotTimer(actId,subId,refreshTime)
local activityKey=FMT.fmt("{0}_{1}",actId,subId)
self:clearNextRefreshReddotTimer(activityKey)
local nowTime=timeHelper.getServerLongTime()
local delta=refreshTime-nowTime

if not self.refreshTimer then
self.refreshTimer={}
end
self.refreshTimer[activityKey]=timer.new()
self.refreshTimer[activityKey]:start(delta,function()

local subType=SUB_ACTIVITY_TYPE.eTargetTask4
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


self:clearNextRefreshReddotTimer(activityKey)
return self:checkHasNextRefreshReddotTime(actId,subId)
end,1)
end

function activitiesHandle_targetActivity4:clearNextRefreshReddotTimer(activityKey)
if self.refreshTimer then
if self.refreshTimer[activityKey]then
self.refreshTimer[activityKey]:cancel()
self.refreshTimer[activityKey]=nil
end
end
end

function activitiesHandle_targetActivity4:clearAllNextRefreshReddotTimer()
if self.refreshTimer then
for activityKey,timer in pairs(self.refreshTimer)do
timer:cancel()
self.refreshTimer[activityKey]=nil
end
end
self.refreshTimer=nil
end

function activitiesHandle_targetActivity4.recv_249_171(actId,subId,len,taskList)
local subType=SUB_ACTIVITY_TYPE.eTargetTask4
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end
local taskDataList_lookup={}
if len and len>0 then
for i,v in ipairs(taskList)do
local taskId=v.task_id
taskDataList_lookup[taskId]=v
end
end
data.taskData=taskDataList_lookup
local isInit=data.isInit
data.isInit=true

activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_TargetActivityWin4')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

if not isInit then


call_activitiesHandle_func('activitiesHandle_targetActivity4','checkHasNextRefreshReddotTime',actId,subId)
end
end

function activitiesHandle_targetActivity4.recv_249_172(actId,subId,len,updateTaskList)
local subType=SUB_ACTIVITY_TYPE.eTargetTask4
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end

local isInit=data.isInit
if isInit then
local taskDataList_lookup=data.taskData
if len and len>0 then
for i,v in ipairs(updateTaskList)do
local taskId=v.param_1
local task_progress=v.param_2
local task_state=v.param_3
taskDataList_lookup[taskId]={
task_id=taskId,
task_progress=task_progress,
task_state=task_state,
}
end
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)

local win=UIManager:findActiveWindow('UISubAct_TargetActivityWin4')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

end