
activitiesHandle_xianxuanbaoxia=new_activitiesHandle('activitiesHandle_xianxuanbaoxia',activitiesHandle)


function activitiesHandle_xianxuanbaoxia.recv_247_16(actid,act2id,reward_idx,unlock_flag)
local subType=SUB_ACTIVITY_TYPE.eXianXuanBaoXia
local actID=actid
local subID=act2id
local data={}
data.reward_idx=reward_idx
data.unlock_flag=unlock_flag
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod("UISubAct_XXBX_Win","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_xianxuanbaoxia:reqReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXianXuanBaoXia
local jstr=jsonHelper.encode({})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end