







eXMRedPacketStatus={
eNormal=0,
eGetted=1,
eNotTimes=2,
eNotLeast=3,
}

eXMRedPacketStatusCanChange={
[eXMRedPacketStatus.eNormal]=true,
[eXMRedPacketStatus.eNotTimes]=true,
}

activitiesHandle_xianmenghongbao=new_activitiesHandle('activitiesHandle_xianmenghongbao',activitiesHandle)

function activitiesHandle_xianmenghongbao:onInit()

end

function activitiesHandle_xianmenghongbao:reqShareRedPacket(actId,subId,hbId,blessIdx)
local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao
local jstr=jsonHelper.encode({1,hbId,blessIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xianmenghongbao:reqOpenRedPacket(actId,subId,hbGuid)
local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao
local jstr=jsonHelper.encode({2,hbGuid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xianmenghongbao:reqGetScoreReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao
local jstr=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_xianmenghongbao.recv_247_123(args)
local actId=args[1]
local subId=args[2]
local score=args[3]
local scoreGotRewardIdx=args[4]

local sendHBListLen=args[6]
local sendHBList=args[7]
local xmhbListLen=args[8]
local xmhbList=args[9]
local hbGotCountListLen=args[10]
local hbGotCountList=args[11]

local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:initAllData(sendHBList or{},xmhbList or{},score,scoreGotRewardIdx,hbGotCountListLen,hbGotCountList)


end





function activitiesHandle_xianmenghongbao.recv_247_124(actId,subId,hbInfo)
local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:addGuildData(hbInfo)


end


function activitiesHandle_xianmenghongbao.recv_247_125(actId,subId,actorId,guidHBData)
local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:addReceiverData(actorId,guidHBData)


end


function activitiesHandle_xianmenghongbao.recv_247_126(actId,subId,gotIdx)
local subType=SUB_ACTIVITY_TYPE.eXianMengHongBao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setScoreGotRewardIdx(gotIdx)


UIManager:invokeUIMethod("UISubAct_XMHB_mainWin","refreshProgressPanel")
end