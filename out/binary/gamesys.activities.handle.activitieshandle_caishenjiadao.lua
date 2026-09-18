







eCSJDRedPacketStatus={
eNormal=0,
eGetted=1,
eNotTimes=2,
eNotLeast=3,
}

eCSJDRedPacketStatusCanChange={
[eCSJDRedPacketStatus.eNormal]=true,
[eCSJDRedPacketStatus.eNotTimes]=true,
}

activitiesHandle_caishenjiadao=new_activitiesHandle('activitiesHandle_caishenjiadao',activitiesHandle)

function activitiesHandle_caishenjiadao:onInit()

end

function activitiesHandle_caishenjiadao:reqShareRedPacket(actId,subId,hbId,blessIdx)
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao
local jstr=jsonHelper.encode({1,hbId,blessIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_caishenjiadao:reqReceiveRedPacket(actId,subId,hbGuid)
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao
local jstr=jsonHelper.encode({2,hbGuid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_caishenjiadao:reqOpenFreeRedPacket(actId,subId,hbId)
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao
local jstr=jsonHelper.encode({3,hbId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_caishenjiadao.recv_247_29(args)
local actId=args[1]
local subId=args[2]
local playerLen=args[3]
local playerList=args[4]
local guildLen=args[5]
local guildList=args[6]
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:initAllData(playerList or{},guildList or{})


end





function activitiesHandle_caishenjiadao.recv_247_30(actId,subId,hbInfo)
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:addGuildData(hbInfo)


end







function activitiesHandle_caishenjiadao.recv_247_31(actId,subId,actorId,hbGuid,rewardIdx)
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:addReceiverData(hbGuid,actorId,rewardIdx)


end





function activitiesHandle_caishenjiadao.recv_247_32(actId,subId,hbId)
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:addPlayerBuy(hbId)
end

function activitiesHandle_caishenjiadao:onTriggerClickEntity(guid)
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)or{}
for i,v in ipairs(subList)do
local entityData=v:getEntityData()
if entityData and entityData.guid==guid then
v:onClickEntity()
return
end
end
end