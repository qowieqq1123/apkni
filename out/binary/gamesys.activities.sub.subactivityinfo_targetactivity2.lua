









local subActivityInfo_targetActivity2={name='subActivityInfo_targetActivity2'}

local _fakeTaskTemp={
tasktype=-1,
aimnum=-1,
cfg={
params={},
}
}

function subActivityInfo_targetActivity2:onInit()
self._listenerTaskProgress=function(...)
self:refreshTaskProgress(...)
end
taskController:registerTaskCount(self._listenerTaskProgress)
end

function subActivityInfo_targetActivity2:onStart()

end

function subActivityInfo_targetActivity2:onDelete()
if self.data then
for taskId,taskData in pairs(self.data.taskList)do
if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
end
end
end
if self._listenerTaskProgress then
taskController:unregisterTaskCount(self._listenerTaskProgress)
end
end

function subActivityInfo_targetActivity2:checkReddot()
if not self:hasData()then return false end

for taskId,taskData in pairs(self.data.taskList)do
if taskData.task_state==taskModel.taskRewardState then
return true
end
end

local config=self:getSubActConfig()
for i,v in ipairs(config.grouprewards)do
if not mathHelper.getBitValue(self.data.bits,i)then
local tasks=v[1]
local taskCnt=0
for index,taskId in ipairs(tasks)do
local taskData=self.data.taskList[taskId]
if taskData.task_state==taskModel.taskFinishState then
taskCnt=taskCnt+1
end
end
if taskCnt>=(v[4]or#tasks)then
return true
end
end
end

return false
end

function subActivityInfo_targetActivity2:initData(tasks,bits)
self.data={
taskList={},
bits=bits,
}
local needCorrect={}
local config=self:getSubActConfig()
if tasks then
for i,v in ipairs(tasks)do
local taskId=v.task_id
local taskCfg=config.tasks[taskId]
local taskType=taskCfg[3]
local taskParam=table.weakCopy(taskCfg[4])
local taskTarget=taskCfg[1]
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil
local listenGuid=nil
local taskProgress=-1
local taskState=v.task_state
if v.task_state~=taskModel.taskFinishState then
listenGuid=nil
if check then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskId}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)

taskProgress=taskController:getTaskCount(taskType,taskParam)
if not needSave then
taskState=taskProgress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState
end
end
end
self.data.taskList[taskId]={
task_id=taskId,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=v.task_progress,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
}
end
end

for taskId,taskCfg in pairs(config.tasks)do
local taskType=taskCfg[3]
local taskParam=table.weakCopy(taskCfg[4])
local taskTarget=taskCfg[1]
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil

if not self.data.taskList[taskId]then
local listenGuid=nil
if check then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskId}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)
end
local taskProgress=taskController:getTaskCount(taskType,taskParam)or-1
local taskState=taskModel.taskDoingState
if check and not needSave then
taskState=taskProgress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState
end
self.data.taskList[taskId]={
task_id=taskId,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=-1,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
}
end

local taskData=self.data.taskList[taskId]
if check and needSave then
if taskData.client_progress>=taskData.task_target and taskData.server_progress<taskData.task_target then
taskController:pushTempStorage(taskData.task_type,taskData.task_params,taskData.client_progress)
end
end
end
end

function subActivityInfo_targetActivity2:refreshTaskProgress(list)
if not self:hasData()then return end
local ids={}
local enoughs={}
for i,v in ipairs(list)do
local otherArgs=v.otherArgs
if self:compare(otherArgs.actId,otherArgs.subType,otherArgs.subId)then
local taskId=otherArgs.taskId
local taskData=self.data.taskList[taskId]
if taskData and taskData.task_state~=taskModel.taskFinishState and v.current~=taskData.client_progress then
local current=v.current
local previous=taskData.client_progress
taskData.client_progress=current
if taskData.count_flag and not mathHelper.getBitValue(taskData.count_flag,2)then
local oState=taskData.task_state
local nState=current>=taskData.task_target and taskModel.taskRewardState or taskModel.taskDoingState
taskData.task_state=nState
if oState~=nState then
table.insert(enoughs,taskId)
end
table.insert(ids,taskId)
end
end
end
end
if#enoughs>0 then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
call_activitiesHandle_func('activitiesHandle_targetActivity2','callWindowFunc',"on_249_110",self.act_id,self.sub_act_id,enoughs,ids)
end

return subActivityInfo_targetActivity2