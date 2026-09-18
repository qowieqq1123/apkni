







activitiesHandle_targetActivity5=new_activitiesHandle('activitiesHandle_targetActivity5',activitiesHandle)

function activitiesHandle_targetActivity5:onInit()

end

function activitiesHandle_targetActivity5:onDelete()

end

function activitiesHandle_targetActivity5.recv_247_33(actId,subId,chapter_len,chapterList)
local subType=SUB_ACTIVITY_TYPE.eTargetActivity5

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

info:initData(chapterList)


UIManager:invokeUIMethod("UISubAct_TargetActivityWin5","refreshView")


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_targetActivity5.recv_247_34(args)
local actId=args[1]
local subId=args[2]
local chapter_id=args[3]
local task_id=args[4]
local complete_cnt=args[5]
local flag=args[6]

local subType=SUB_ACTIVITY_TYPE.eTargetActivity5

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local data=info:getData()

local _sortWeight={2,1,3}

local isResetTask=false
if chapter_id and chapter_id>0 then
local chapterData=data.chapterData[chapter_id]
local oldChapterState=chapterData.chapter_state
if task_id and task_id>0 then
local taskData=chapterData.taskData[task_id]
local oldState=taskData.task_state
taskData.server_progress=complete_cnt

if flag==1 then
taskData.task_state=taskModel.taskFinishState
else
local check=complete_cnt>=taskData.task_target
taskData.task_state=check and taskModel.taskRewardState or taskModel.taskDoingState
end

if oldState~=taskData.task_state then
local sortWeight=_sortWeight[taskData.task_state]*10000+task_id
taskData.sortWeight=sortWeight
isResetTask=true
end
else
chapterData.chapter_rw_flag=flag
end
info:refreshChapterData(chapter_id)

if not info:checkChapterState(chapter_id,oldChapterState)or isResetTask then

UIManager:invokeUIMethod("UISubAct_TargetActivityWin5","refreshView")


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
else
UIManager:invokeUIMethod("UISubAct_TargetActivityWin5","refreshTaskDescList",task_id)
end
end
end