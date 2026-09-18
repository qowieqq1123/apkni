





chatMessageHandler=simple_class(chatSimpleHandler)

function chatMessageHandler.create(channelId,luaObject)
local object=refObject.get('chatMessageHandler',channelId,luaObject)
object:initChild()
return object
end


function chatMessageHandler:init(channelId,luaObject,listView)
self.mesgType=CHAT_MESSAGE_TYPE.ePublic
self.channelId=channelId
self.luaObject=luaObject
chatControl.readNewestMesgByChannel(channelId)
end


function chatMessageHandler:onRelease()
self.channelId=CHAT_CHANNNEL.eNone
self.luaObject=nil
end


function chatMessageHandler:addMesg(typo,val)
if self.luaObject and self.luaObject.addMesg then
self.luaObject:addMesg(typo,val)
end
end


function chatMessageHandler:sendMesg(mesg)
if self.luaObject and self.luaObject.sendMesg then
self.luaObject:sendMesg(mesg)
end
end


function chatMessageHandler:onRecvMesg(chatInfo)
local channelId=self.channelId

chatControl.readNewestMesgByChannel(channelId)

if self.luaObject then
if self.luaObject.clearInput then
self.luaObject:clearInput(chatInfo.sendguid)
end
self.luaObject:onRecvPublicMessage(channelId,chatInfo)
end
end


function chatMessageHandler:onRecvMesgList(chatInfoList,isTop)
local channelId=self.channelId

chatControl.readNewestMesgByChannel(channelId)

if self.luaObject then
self.luaObject:onRecvPublicMessageList(channelId,chatInfoList,isTop)
end
end

function chatMessageHandler:getNowChannel()
return self.channelId
end

function chatMessageHandler:onDeleteMsg(msgID)
self.luaObject:onDeleteMesgListByMsgID(self.channelId,{msgID})
end

function chatMessageHandler:onDeleteMsgByIndex(index)
self.luaObject:onDeleteMesgListByIndex(self.channelId,{index})
end

function chatMessageHandler:onDeleteMsgList(msgIDlist)
if msgIDlist==nil then return end
self.luaObject:onDeleteMesgListByMsgID(self.channelId,msgIDlist)
end


function chatMessageHandler:onTestRecvMesg(index,chatInfo)
local channelId=self.channelId

if self.luaObject then
if self.luaObject.clearInput then
self.luaObject:clearInput(chatInfo.sendguid)
end
self.luaObject:onInsertMesgList(index,{chatInfo})
end
end