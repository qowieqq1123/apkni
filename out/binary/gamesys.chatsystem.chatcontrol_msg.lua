


function chatControl.getReadIdx(channelId,actorId)
local holder=chatControl.getHolder(channelId)
if channelId==CHAT_CHANNNEL.ePrivate then
return holder:getPrivateReadIdx(channelId)
else
return holder:getPublicReadIdx()
end
end


function chatControl.getTotalInfoList(channelId,actorId)
local holder=chatControl.getHolder(channelId)
if channelId==CHAT_CHANNNEL.ePrivate then
return holder:getPrivateTotalInfoList(actorId)
else
return holder:getPublicTotalInfoList()
end
end



function chatControl.getLastPageInfoList(channelId,len,endIdx,actorId)
local holder=chatControl.getHolder(channelId)
if channelId==CHAT_CHANNNEL.ePrivate then
return holder:getPrivateLastInfoList(len,endIdx,actorId)
else
return holder:getPublicLastInfoList(len,endIdx)
end
end


function chatControl.clearChannelMesg(channelId)
local holder=chatControl.getHolder(channelId)
if holder then
return holder:clearData()
end
end


function chatControl.deletePlayerAllMsg(actorId)
local holders=chatControl.getAllHolder()
for _,v in pairs(holders)do
local holder=v
holder:onDeletePlayerAllMesg(actorId)
end
chatControl.onInvokeAllMainHolder('onDeletePlayerMesg',actorId)
end


function chatControl.deletePlayerMsg(actorId,msg)
local holders=chatControl.getAllHolder()
for _,holder in pairs(holders)do
holder:onDeletePlayerMesg(actorId,msg)
end
chatControl.onInvokeAllMainHolder('onDeletePlayerMesg',actorId,msg)
end



function chatControl.deleteMsgByID(msgID)
local holders=chatControl.getAllHolder()
for _,holder in pairs(holders)do
holder:onHandleDelete(msgID)
end
chatControl.onInvokeAllMainHolder('onHandleDelete',msgID)
end


function chatControl.hasNewMesg()
local configs=chatConfig.getAllChannelConfig()
for channelId,_ in ipairs(configs)do
if chatControl.hasNewMesgByChannel(channelId)then
return true
end
end
return false
end


function chatControl.hasNewMesgByChannel(channelId)
if not chatCommonHelper.isChannelUnlock(channelId)then return false end
local holder=chatControl.getHolder(channelId)
if holder then
return holder:hasNewMesgByChannel()
end
return false
end


function chatControl.hasNewMesgByPlayer(actorId)
if not chatCommonHelper.isChannelUnlock(CHAT_CHANNNEL.ePrivate)then return false end
if actorId==nil then return false end

if chatModel.checkLiuYanReddotByActorId(actorId)then

return true
end

local channelId=CHAT_CHANNNEL.ePrivate
local holder=chatControl.getHolder(channelId)
if holder then
return holder:hasNewMesgByPlayer(actorId)
end
return false
end


function chatControl.readLiuYanMesgByChannel(actorId)

chatModel.clearLiuYanReddotByActorId(actorId)

local channelId=CHAT_CHANNNEL.ePrivate

chatControl.freshMain('onReadNewestMesg',channelId)
chatControl.freshChatMain('onReadNewestMesg',channelId)
chatControl.freshWorldChatMain('onReadNewestMesg',channelId)
end


function chatControl.readNewestMesgByChannel(channelId)
local holder=chatControl.getHolder(channelId)
if holder then
holder:readNewestMesgByChannel()
end
UIManager:callWindowFunc('UIFightMainTop','onReadNewestMesg')
chatControl.freshMain('onReadNewestMesg',channelId)
chatControl.freshChatMain('onReadNewestMesg',channelId)
chatControl.freshWorldChatMain('onReadNewestMesg',channelId)

if channelId==CHAT_CHANNNEL.eXianmeng then

xianmengdigongController:clearAllNotReadMsgList()
xianmengdigongController:checkReadAddAuctionMsgNum()
xianmengdigongController:clearGLChatNotice()
end
end


function chatControl.readNewestMesgByPlayer(channelId,actorId)
local holder=chatControl.getHolder(channelId)
if holder then
holder:readNewestMesgByPlayer(actorId)
end
UIManager:callWindowFunc('UIFightMainTop','onReadNewestMesg')
chatControl.freshMain('onReadNewestMesg',channelId,actorId)
chatControl.freshChatMain('onReadNewestMesg',channelId,actorId)
chatControl.freshWorldChatMain('onReadNewestMesg',channelId,actorId)
end


function chatControl.getNewestMesgNumByChannel(channelId)
if not chatCommonHelper.isChannelUnlock(channelId)then return 0 end
local holder=chatControl.getHolder(channelId)
if holder then
return holder:getNewMesgNumByChannel(channelId)
end
return 0
end


function chatControl.getNewestMesgNumByPlayer(channelId,actorId)
if not chatCommonHelper.isChannelUnlock(CHAT_CHANNNEL.ePrivate)then return 0 end

local liuyanCount=0
if channelId==CHAT_CHANNNEL.ePrivate then
liuyanCount=chatModel.getLiuYanCountByActorId(actorId)
end


local holder=chatControl.getHolder(channelId)
if holder then
local num=holder:getNewMesgNumByPlayer(actorId)
local mesgNum=liuyanCount+(num or 0)
if mesgNum<0 then
mesgNum=nil
end
return mesgNum
end
return 0
end


function chatControl.setNewestMesgNumByChannel(channelId,num)
local holder=chatControl.getHolder(channelId)
if holder then
holder:setNewMesgNumByChannel(channelId,num)
end
end


function chatControl.getNewestMesgStampByChannel(channelId)
local holder=chatControl.getHolder(channelId)
if holder then
return holder:getNewMesgStampByChannel(channelId)
end
end


function chatControl.getNewestMesgStampByPlayer(actorId)
local channelId=CHAT_CHANNNEL.ePrivate
local holder=chatControl.getHolder(channelId)
if holder then
return holder:getNewMesgStampByPlayer(actorId)
end
end

function chatControl.getMainTotalInfoList()
return chatControl.onInvokeMainHolder(MAIN_HOLD_TYPE.eMain,'getCacheList')
end