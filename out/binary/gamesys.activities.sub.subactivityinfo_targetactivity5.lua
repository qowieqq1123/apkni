









local subActivityInfo_targetActivity5={name='subActivityInfo_targetActivity5'}

function subActivityInfo_targetActivity5:onInit()
self._listenerTaskProgress=function(...)
self:refreshTaskProgress(...)
end
taskController:registerTaskCount(self._listenerTaskProgress)
end

function subActivityInfo_targetActivity5:onStart()

end

function subActivityInfo_targetActivity5:onDelete()
if self.data then
local chapterDataList_lookup=self.data.chapterData
for chapterId,chapterData in pairs(chapterDataList_lookup)do
local taskDataList_lookup=chapterData.taskData
for taskId,taskData in pairs(taskDataList_lookup)do
if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
end
end
end
end
if self._listenerTaskProgress then
taskController:unregisterTaskCount(self._listenerTaskProgress)
end
end

function subActivityInfo_targetActivity5:checkReddot()
if not self:hasData()then return false end
local chapterDataList_lookup=self.data.chapterData
for chapterId,chapterData in pairs(chapterDataList_lookup)do
if chapterData.chapter_state==taskModel.taskRewardState then
return true
end

local taskDataList_lookup=chapterData.taskData
for taskId,taskData in pairs(taskDataList_lookup)do
if taskData.task_state==taskModel.taskRewardState then
return true
end
end
end

return false
end

function subActivityInfo_targetActivity5:getInitOpenChapter()
if not self:hasData()then return 1 end
local chapterIdx
local chapterDataList_lookup=self.data.chapterData
for chapterId,chapterData in pairs(chapterDataList_lookup)do
if chapterData.chapter_state~=taskModel.taskFinishState and not chapterIdx then
chapterIdx=chapterId
end
if chapterData.chapter_state==taskModel.taskRewardState then
return chapterId
end
local taskDataList_lookup=chapterData.taskData
for taskId,taskData in pairs(taskDataList_lookup)do
if taskData.task_state==taskModel.taskRewardState then
return chapterId
end
end
end

return chapterIdx or 1
end

function subActivityInfo_targetActivity5:initData(chapterList)
if not self.data then
self.data={
chapterData={},
}
end
local config=self:getSubActConfig()
local _sortWeight={2,1,3}
if chapterList then
for i,v in ipairs(chapterList)do
local chapterId=v.chapter_id
local chapterData=self.data.chapterData[chapterId]
if not chapterData then
self.data.chapterData[chapterId]={
taskData={}
}
end
if v.task_len and v.task_len>0 then
for _,taskData in ipairs(v.taskList)do
local taskId=taskData.param_1
local task_progress=taskData.param_2
local flag=taskData.param_3
local taskCfg=config.tasks[chapterId].tasklist[taskId]
local taskType=taskCfg[1]
local taskParam=taskCfg[2]
local taskTarget=taskCfg[3]
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil
local listenGuid=nil
local taskProgress=-1
local taskState
if flag==1 then
taskState=taskModel.taskFinishState
else
listenGuid=nil
if check then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,chapterId=chapterId,taskId=taskId}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)

taskProgress=taskController:getTaskCount(taskType,taskParam)or-1
if not needSave then
taskState=taskProgress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState
end
else
taskState=task_progress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState
end
end
local sortWeight=_sortWeight[taskState]*10000+taskId
self.data.chapterData[chapterId].taskData[taskId]={
chapter_id=chapterId,
task_id=taskId,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=task_progress,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
sortWeight=sortWeight,
}
end
end

self.data.chapterData[chapterId].chapter_rw_flag=v.chapter_rw_flag
end
end

for chapterId,v in pairs(config.tasks)do
local chapterData=self.data.chapterData[chapterId]
if not chapterData then
self.data.chapterData[chapterId]={
taskData={}
}
end
for taskId,taskCfg in pairs(v.tasklist)do
local taskType=taskCfg[1]
local taskParam=taskCfg[2]
local taskTarget=taskCfg[3]
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil

local taskData=self.data.chapterData[chapterId].taskData[taskId]
if not taskData then
local listenGuid=nil
if check then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,chapterId=chapterId,taskId=taskId}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)
end
local taskProgress=taskController:getTaskCount(taskType,taskParam)or-1
local taskState=taskModel.taskDoingState
if check and not needSave then
taskState=taskProgress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState

if taskProgress>=taskTarget then
self:reqSaveTaskProgress(chapterId,taskId)
end
end
local sortWeight=_sortWeight[taskState]*10000+taskId
self.data.chapterData[chapterId].taskData[taskId]={
chapter_id=chapterId,
task_id=taskId,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=-1,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
sortWeight=sortWeight,
}
end

local taskData=self.data.chapterData[chapterId].taskData[taskId]
if check and needSave then
if taskData.client_progress>=taskData.task_target and taskData.server_progress<taskData.task_target then
taskController:pushTempStorage(taskData.task_type,taskData.task_params,taskData.client_progress)
end
end
end
self:refreshChapterData(chapterId)
end
end

function subActivityInfo_targetActivity5:refreshChapterData(chapterId)
local config=self:getSubActConfig()
self.data.chapterData[chapterId]=self.data.chapterData[chapterId]or{}
self.data.chapterData[chapterId].taskData=self.data.chapterData[chapterId].taskData or{}
local chapter_rw_flag=self.data.chapterData[chapterId].chapter_rw_flag or 0

local chapterState
if chapter_rw_flag==1 then
chapterState=taskModel.taskFinishState
else
local check=true
local taskDataList=self.data.chapterData[chapterId].taskData
for taskId,_ in ipairs(config.tasks[chapterId].tasklist)do
local taskData=taskDataList[taskId]
if not taskData or taskData.task_state~=taskModel.taskFinishState then
check=false
break
end
end
chapterState=check and taskModel.taskRewardState or taskModel.taskDoingState
end
self.data.chapterData[chapterId].chapter_state=chapterState
end

function subActivityInfo_targetActivity5:checkChapterState(chapterId,chapterState)
return self.data.chapterData[chapterId].chapter_state==chapterState
end

function subActivityInfo_targetActivity5:refreshTaskProgress(list)
if not self:hasData()then return end
local _sortWeight={2,1,3}
local ids={}
local chapterIdLookup={}
local enoughs={}
for i,v in ipairs(list)do
local otherArgs=v.otherArgs
if self:compare(otherArgs.actId,otherArgs.subType,otherArgs.subId)then
local chapterId=otherArgs.chapterId
local taskId=otherArgs.taskId
local taskData=self.data.chapterData[chapterId].taskData[taskId]
if taskData and taskData.task_state~=taskModel.taskFinishState and v.current~=taskData.client_progress then
local current=v.current
local previous=taskData.client_progress
taskData.client_progress=current
if taskData.count_flag and not mathHelper.getBitValue(taskData.count_flag,2)then
local oState=taskData.task_state
local nState=current>=taskData.task_target and taskModel.taskRewardState or taskModel.taskDoingState
taskData.task_state=nState
if oState~=nState then
taskData.sortWeight=_sortWeight[nState]*10000+taskId
table.insert(enoughs,taskId)

if nState==taskModel.taskRewardState then
self:reqSaveTaskProgress(taskData.chapter_id,taskId)

if not chapterIdLookup[taskData.chapter_id]then
chapterIdLookup[taskData.chapter_id]=chapterIdLookup[taskData]
end
end
end
table.insert(ids,taskId)
end
end
end
end

for chapter_id,v in pairs(chapterIdLookup)do
self:refreshChapterData(chapter_id)
end

if#enoughs>0 then
UIManager:invokeUIMethod("UISubAct_TargetActivityWin5","refreshView")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
else
UIManager:invokeUIMethod("UISubAct_TargetActivityWin5","refreshTaskDescList",ids)
end
end

function subActivityInfo_targetActivity5:reqGetTaskReward(chapterId,taskId)
local json_str=jsonHelper.encode({1,chapterId,taskId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_targetActivity5:reqGetChapterReward(chapterId)
local json_str=jsonHelper.encode({2,chapterId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_targetActivity5:reqSaveTaskProgress(chapterId,taskId)
local json_str=jsonHelper.encode({3,chapterId,taskId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_targetActivity5