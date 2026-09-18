







activitiesHandle_targetActivity7=new_activitiesHandle('activitiesHandle_targetActivity7',activitiesHandle)

function activitiesHandle_targetActivity7:onInit()
end

function activitiesHandle_targetActivity7:onDelete()
end

function activitiesHandle_targetActivity7.recv_247_98(actId,subId,tasks_len,tasksList)
local subType=SUB_ACTIVITY_TYPE.eTargetTask7

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

info:initData(tasksList)


UIManager:invokeUIMethod("UISubAct_TargetActivityWin7","refreshView")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_targetActivity7.recv_247_99(actId,subId,taskIdx,completeCnt,rewardCnt)
local subType=SUB_ACTIVITY_TYPE.eTargetTask7

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local data=info:getData()
data.tasksData[taskIdx]={completeCnt=completeCnt,rewardCnt=rewardCnt}
info:setData(data)


UIManager:invokeUIMethod("UISubAct_TargetActivityWin7","refreshView")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end