







activitiesHandle_gubaoshilian=new_activitiesHandle('activitiesHandle_gubaoshilian',activitiesHandle)

function activitiesHandle_gubaoshilian:onInit()

end

function activitiesHandle_gubaoshilian:reqRankData(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eGuBaoShiLian
local jstr=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_gubaoshilian.recv_247_53(actId,subId,layer)
local subType=SUB_ACTIVITY_TYPE.eGuBaoShiLian
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setData(layer)
end

function activitiesHandle_gubaoshilian.recv_247_54(actId,subId,rankLen,rankList,myRank)
local subType=SUB_ACTIVITY_TYPE.eGuBaoShiLian
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setRankData(rankList,myRank)
end