







activitiesHandle_targetActivity2=new_activitiesHandle('activitiesHandle_targetActivity2',activitiesHandle)

local _windows={
"UISubAct_TargetActivityWin1","UISubAct_TargetActivityWin2",
}

function activitiesHandle_targetActivity2:onInit()

end

function activitiesHandle_targetActivity2:callWindowFunc(funcName,...)
for index,winName in ipairs(_windows)do
UIManager:invokeUIMethod(winName,funcName,...)
end
end

function activitiesHandle_targetActivity2:reqTaskReward(actId,subId,taskId)
local subType=SUB_ACTIVITY_TYPE.eTargetTask2
local jstr=jsonHelper.encode({1,taskId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_targetActivity2:reqGroupReward(actId,subId,groupid)
local subType=SUB_ACTIVITY_TYPE.eTargetTask2
local jstr=jsonHelper.encode({2,groupid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_targetActivity2.recv_249_109(actId,subId,len,tasks,bits)
local subType=SUB_ACTIVITY_TYPE.eTargetTask2

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

info:initData(tasks,bits)

for index,winName in ipairs(_windows)do
UIManager:invokeUIMethod(winName,"on_249_109",actId,subId)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_targetActivity2.recv_249_110(actId,subId,len,progressList)
if len<=0 then return end

local subType=SUB_ACTIVITY_TYPE.eTargetTask2
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local data=info:getData()
local taskConfig=info:getSubActConfig("tasks")
local ids={}
local enoughs={}
for i,v in ipairs(progressList)do
local taskId=v.param_1
local taskProgress=v.param_2
local progressMax=taskConfig[taskId][1]
local taskData=data.taskList[taskId]
taskData.server_progress=taskProgress
if taskData.task_state~=taskModel.taskFinishState then
local check=taskProgress>=progressMax
local oldState=taskData.task_state
taskData.task_state=check and taskModel.taskRewardState or taskModel.taskDoingState
if oldState~=taskData.task_state then
table.insert(enoughs,taskId)
end
end
if taskData.progress_listen and taskData.task_state==taskModel.taskRewardState then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
taskData.progress_listen=nil
end
table.insert(ids,taskId)
end

for index,winName in ipairs(_windows)do
UIManager:invokeUIMethod(winName,"on_249_110",actId,subId,enoughs,ids)
end

if#enoughs>0 then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_targetActivity2.recv_249_111(actId,subId,taskId)
local subType=SUB_ACTIVITY_TYPE.eTargetTask2

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local data=info:getData()
local taskData=data.taskList[taskId]
taskData.task_state=taskModel.taskFinishState

if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
taskData.progress_listen=nil
end

for index,winName in ipairs(_windows)do
UIManager:invokeUIMethod(winName,"on_249_111",actId,subId,taskId)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_targetActivity2.recv_249_112(actId,subId,group)
local subType=SUB_ACTIVITY_TYPE.eTargetTask2

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local data=info:getData()
data.bits=mathHelper.setbit(data.bits,group)

for index,winName in ipairs(_windows)do
UIManager:invokeUIMethod(winName,"on_249_112",actId,subId,group)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end