





chatSystemStruct=simple_class(chatStructBase)

function chatSystemStruct.create(stamp,channelId,mesg,args)
local object=refObject.get('chatSystemStruct',channelId)
object:initChild(false,stamp,CHAT_MESSAGE_TYPE.eSystem,mesg,false,args)
return object
end

function chatSystemStruct:init(channelId)
self.channelId=channelId
end

function chatSystemStruct:isSelfActor()
return false
end

function chatSystemStruct:getActorId()

end

function chatSystemStruct:isActorId()
return false
end

function chatSystemStruct:getHolderId()

end

function chatSystemStruct:onRelease()
self.channelId=nil
end


