
activitiesHandle_zixuantouzi=new_activitiesHandle('activitiesHandle_zixuantouzi',activitiesHandle)


function activitiesHandle_zixuantouzi.recv_247_87(act_id,act2_id,invest_idx,reward_idx,score)
local subType=SUB_ACTIVITY_TYPE.eTargetTask6
local actID=act_id
local subID=act2_id
local data={}
data.invest_idx=invest_idx
data.reward_idx=reward_idx
data.score=score
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod("UISubAct_zixuantouzi_Win","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zixuantouzi.recv_247_88(act_id,act2_id,reward_idx)
local subType=SUB_ACTIVITY_TYPE.eTargetTask6
local actID=act_id
local subID=act2_id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
data.reward_idx=reward_idx
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod("UISubAct_zixuantouzi_Win","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zixuantouzi.recv_247_89(act_id,act2_id,score)
local subType=SUB_ACTIVITY_TYPE.eTargetTask6
local actID=act_id
local subID=act2_id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
data.score=score
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod("UISubAct_zixuantouzi_Win","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_zixuantouzi:reqGetReward(actId,subId,rewardIdx)
local subType=SUB_ACTIVITY_TYPE.eTargetTask6
local jstr=jsonHelper.encode({rewardIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


