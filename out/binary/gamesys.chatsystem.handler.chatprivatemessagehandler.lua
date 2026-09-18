





chatPrivateMessageHandler=simple_class(chatSimpleHandler)

function chatPrivateMessageHandler.create(channelId,luaObject)
local object=refObject.get('chatPrivateMessageHandler',channelId,luaObject)
object:initChild()
return object
end


function chatPrivateMessageHandler:init(channelId,luaObject,listView)
self.mesgType=CHAT_MESSAGE_TYPE.ePublic
self.luaObject=luaObject
self.channelId=CHAT_CHANNNEL.ePrivate
end


function chatPrivateMessageHandler:onRelease()
self.channelId=CHAT_CHANNNEL.eNone
self.luaObject=nil
end


function chatPrivateMessageHandler:addMesg(typo,val)
if self.luaObject and self.luaObject.addMesg then
self.luaObject:addMesg(typo,val)
end
end


function chatPrivateMessageHandler:sendMesg(mesg)
if self.luaObject and self.luaObject.sendMesg then
self.luaObject:sendMesg(mesg)
end
end



function chatPrivateMessageHandler:setNowActorInfo(formType,actorInfo)
local oldFormType=self.formType
local oldPlayerInfo=self.playerInfo
self.formType=formType
self.playerInfo=actorInfo
if actorInfo then

chatControl.readNewestMesgByPlayer(self.channelId,actorInfo.actorId)
end



end


function chatPrivateMessageHandler:checkActorSend(actorInfo)
if self.playerInfo==nil then return false end
if actorInfo==nil then return false end
return tostring(self.playerInfo.actorId)==tostring(actorInfo.actorId)
end


function chatPrivateMessageHandler:checkActorId(actorId)
if self.playerInfo==nil then return false end
return tostring(self.playerInfo.actorId)==tostring(actorId)
end



function chatPrivateMessageHandler:checkActor(chatInfo)
if self.playerInfo==nil then return false end
local actorId=chatInfo:getHolderId()
return self:checkActorId(actorId)
end


function chatPrivateMessageHandler:getNowActorInfo()
return self.formType,self.playerInfo
end



function chatPrivateMessageHandler:onRecvMesg(chatInfo)
local channelId=self.channelId

local actorInfo=chatInfo.actorInfo
local isSelf=chatInfo:isSelfActor()
local actorId=chatInfo:getHolderId()
local isCurActor=self:checkActor(chatInfo)

if isCurActor then
chatControl.readNewestMesgByPlayer(channelId,actorId)
end

local sendguid=chatInfo.sendguid
if self.luaObject then
if isSelf and self.luaObject.clearInput then
self.luaObject:clearInput(sendguid)
end


if isCurActor and self.luaObject.onRecvPublicMessage then
self.luaObject:onRecvPublicMessage(channelId,chatInfo,actorId)
end


if self.luaObject.onRecvPrivateMessage then
self.luaObject:onRecvPrivateMessage(channelId,chatInfo.actorInfo)
end
end
end



function chatPrivateMessageHandler:onRecvMesgList(chatInfoList,isTop)
if self.playerInfo==nil then return end
if chatInfoList==nil then return end
local list={}
local actorInfo
for i,v in ipairs(chatInfoList or{})do
if self:checkActor(v)then
list[#list+1]=v
if self:checkActorSend(v.actorInfo)then
actorInfo=v.actorInfo
end
end
end

local len=#list

local has=len>0

local actorId=self.playerInfo.actorId

local channelId=self.channelId


if has then
chatControl.readNewestMesgByPlayer(channelId,actorId)
end

if self.luaObject and actorInfo then


if has and self.luaObject.onRecvPublicMessage then
self.luaObject:onRecvPublicMessageList(channelId,list)
end


if self.luaObject.onRecvPrivateMessage then
self.luaObject:onRecvPrivateMessage(channelId,actorInfo)
end
end
end

function chatPrivateMessageHandler:getNowChannel()
return self.channelId
end

function chatPrivateMessageHandler:onDeleteMsg(msgID)
self.luaObject:onDeleteMesgListByMsgID(self.channelId,{msgID})
end

function chatPrivateMessageHandler:onDeleteMsgByIndex(index)
self.luaObject:onDeleteMesgListByIndex(self.channelId,{index})
end

function chatPrivateMessageHandler:onDeleteMsgList(msgIDlist)
if msgIDlist==nil then return end
self.luaObject:onDeleteMesgListByMsgID(self.channelId,msgIDlist)
end