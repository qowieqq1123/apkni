







activitiesHandle_liangouhaoliRole=new_activitiesHandle('activitiesHandle_liangouhaoliRole',activitiesHandle)

function activitiesHandle_liangouhaoliRole:onInit()

end

function activitiesHandle_liangouhaoliRole:reqDailyReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLiRole
local jstr=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_liangouhaoliRole:reqFinalReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLiRole
local jstr=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_liangouhaoliRole:reqSelectAim(actId,subId,aimIndex)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLi
local jstr=jsonHelper.encode({3,aimIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_liangouhaoliRole:reqBuyReward(actId,subId,rechargeId,rewardIdx)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLiRole
local info={rewardIdx}
local params=payControl.getActivityPayParams(actId,subType,subId,info)
payControl.reqPay(rechargeId,1,params)
end

function activitiesHandle_liangouhaoliRole.recv_249_159(actId,subId,flag,dailySec,aimIndex)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLiRole

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

if info:hasData()then
info.data.flag=flag
info.data.dailySec=dailySec
info.data.aimIndex=aimIndex
else
local data={
flag=flag,
dailySec=dailySec,
aimIndex=aimIndex,
}
info:setData(data)
end

UIManager:invokeUIMethod("UISubAct_LianGouHaoLiWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_LianGouHaoLiNewWin","refreshView",actId,subType,subId)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end