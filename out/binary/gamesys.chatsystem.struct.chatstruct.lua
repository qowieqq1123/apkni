





chatStruct=simple_class(chatStructBase)

function chatStruct.create(isTop,stamp,channelId,msgType,mesg,actorInfo,sendguid,holderId,args)
local object=refObject.get('chatStruct',channelId,actorInfo,sendguid,holderId,args)
object:initChild(isTop,stamp,msgType,mesg,true,args)
if object.lost==true then return end
return object
end

function chatStruct:init(channelId,actorInfo,sendguid,holderId)
self.holderId=holderId
self.channelId=channelId
self.actorInfo=actorInfo
self.isRead=false
self.sendguid=sendguid
end


function chatStruct:isSelfActor()
return playerModel:checkActorId(self:getActorId())
end


function chatStruct:getActorId()
if self.actorInfo==nil then
return 0
end
return self.actorInfo.actorId
end

function chatStruct:isActorId(actorId)
return tostring(self.actorInfo.actorId)==tostring(actorId)
end


function chatStruct:getHolderId()
return self.holderId
end

function chatStruct:onRelease()
self.channelId=CHAT_CHANNNEL.eNone
self.isRead=false
self.actorInfo=nil
self.holderId=nil
end

function chatStruct:isReadMesg()
return self.isRead
end