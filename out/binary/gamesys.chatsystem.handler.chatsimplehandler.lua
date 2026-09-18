





chatSimpleHandler=simple_class(refObject)

local _guid=0
function chatSimpleHandler.create()
local object=refObject.get('chatSimpleHandler')
return object
end

function chatSimpleHandler:init()
_guid=_guid+1
self.guid=_guid
chatControl.selectHandler(self)
end

function chatSimpleHandler:onRelease()
self.guid=0
end

function chatSimpleHandler:onRecvMesg(chatInfo)

end

function chatSimpleHandler:getNowChannel()
return self.channelId
end

function chatSimpleHandler:setNowActorInfo()

end

function chatSimpleHandler:getNowActorInfo()

end
