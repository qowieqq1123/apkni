local _task={}
local _inited=false

function seasonModel:isInitTaskData()
return _inited
end

function seasonModel:clearTaskData()
for i,v in pairs(_task)do
if v.progress_listen then
taskController:unlistenTaskCount(v.task_type,v.task_params,v.progress_listen)
end
end
table.clear(_task)
_inited=false
end

function seasonModel:setTaskData(taskid,progress,flag)
local data=_task[taskid]
if data then
local taskType=data.task_type
local taskParam=data.task_params
local taskTarget=data.task_target
local check=data.count_flag
local taskProgress=-1
local taskState=flag==0 and(progress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState)or taskModel.taskFinishState
if taskState==taskModel.taskDoingState and check then
local needSave=check and mathHelper.getBitValue(check,2)or nil
local taskAim=needSave and taskTarget or nil
taskProgress=taskController:getTaskCount(taskType,taskParam)
if not needSave and taskProgress>=taskTarget then
taskState=taskModel.taskRewardState
end
end
data.cleint_progress=taskProgress
data.server_progress=progress
data.task_state=taskState
else
local taskCfg=cfgHelper.get1(cfg_fairylandseasontaskconfig_get,taskid)
local taskType=taskCfg.task_type
local taskParam=taskCfg.param1
local taskTarget=taskCfg.complete_cnt
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil
local listenGuid=nil
local taskProgress=-1
local taskState=flag==0 and(progress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState)or taskModel.taskFinishState
if flag==0 and check then
local funcArgs={taskid=taskid}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)
taskProgress=taskController:getTaskCount(taskType,taskParam)
if not needSave and taskProgress>=taskTarget then
taskState=taskModel.taskRewardState
end
end
data={
task_id=taskid,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=progress,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
}
_task[taskid]=data
end
_inited=true
end

function seasonModel:deleteTaskData(taskId)
local taskData=_task[taskid]
if taskData then
if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
end
_task[taskid]=nil
end
end

function seasonModel:getTaskData(taskid)





return _task[taskid]
end

function seasonModel:setTaskFlag(taskid)
local taskData=_task[taskid]
if taskData then
taskData.task_state=taskModel.taskFinishState
if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
taskData.progress_listen=nil
end
end
end
