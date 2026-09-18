












chatMessageMainHandler=simple_class(chatSimpleHandler)

function chatMessageMainHandler.create(creater,parentIdx,luaObject)
local object=refObject.get('chatMessageMainHandler',creater,parentIdx,luaObject)
object:initChild()
return object
end


function chatMessageMainHandler:init(creater,parentIdx,luaObject)
self.creater=creater
self.parentIdx=parentIdx
self.luaObject=luaObject
self.cloneList={}
self.isPauseRecvMsg=false
self.recvStamp=0
self.pauseStamp=0
end

function chatMessageMainHandler:onRelease()
self.creater=nil
self.parentIdx=nil
self.luaObject=nil
self.cloneList={}
end

function chatMessageMainHandler:getLuaId(msgID)
return self.cloneList[msgID]
end



function chatMessageMainHandler:onHandleMesgList(mesgList)
for i,v in ipairs(mesgList or{})do
self:onRecvMesg(v)
end
end

function chatMessageMainHandler:onRecvMesg(chatInfo)
self.recvStamp=timeHelper.getServerShortTime()

if self.creater==nil then return end
if self.isPauseRecvMsg then return end
local creater=self.creater
local parentIdx=self.parentIdx
local msgID=chatInfo.msgID
local msgType=chatInfo.msgType
local isVoice=chatInfo.isVoice
local cmpTypeName=isVoice and CHAT_COM_TYPE.eChatMainVoice
or CHAT_COM_TYPE.eChatMain
local compName=chatConfig.getCmpSrcName(cmpTypeName)

local luaid=creater:createObject(compName,parentIdx,msgID,chatInfo)
self.cloneList[msgID]=luaid
end

function chatMessageMainHandler:onDeleteMsg(msgID)
local luaid=self.cloneList[msgID]
if luaid==nil then return end
if self.luaObject and self.luaObject.releaseObject then
self.luaObject:releaseObject(luaid)
end
end

function chatMessageMainHandler:onDeleteMsgList(msgIDlist)
if msgIDlist==nil then return end
for i,v in ipairs(msgIDlist)do
self:onDeleteMsg(v)
end
end

function chatMessageMainHandler:clearCurMsgList()
if self.cloneList then
for msgID,luaID in pairs(self.cloneList)do
self:onDeleteMsg(msgID)
end
end
end


function chatMessageMainHandler:pauseRecvMsg()
self.isPauseRecvMsg=true
self.pauseStamp=timeHelper.getServerShortTime()
end

function chatMessageMainHandler:resumeRecvMsg()
if self.isPauseRecvMsg then
self.isPauseRecvMsg=false
if self.recvStamp>self.pauseStamp then
self:clearCurMsgList()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self)
end
end
end