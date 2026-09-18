







activitiesHandle_liangouhaoli=new_activitiesHandle('activitiesHandle_liangouhaoli',activitiesHandle)

function activitiesHandle_liangouhaoli:onInit()

end

function activitiesHandle_liangouhaoli:reqDailyReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLi
local jstr=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_liangouhaoli:reqFinalReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLi
local jstr=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_liangouhaoli:reqSelectAim(actId,subId,aimIndex)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLi
local jstr=jsonHelper.encode({3,aimIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_liangouhaoli:reqBuyReward(actId,subId,rechargeId,rewardIdx)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLi
local info={rewardIdx}
local params=payControl.getActivityPayParams(actId,subType,subId,info)
payControl.reqPay(rechargeId,1,params)
end

function activitiesHandle_liangouhaoli.recv_249_60(actId,subId,flag,dailySec,aimIndex)
local subType=SUB_ACTIVITY_TYPE.eLianGouHaoLi

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

UIManager:invokeUIMethod("UISubAct_LianGouHaoLiWin","refreshSelectPanel")
UIManager:invokeUIMethod("UISubAct_LianGouHaoLiWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_LianGouHaoLiNewWin","refreshView",actId,subType,subId)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end