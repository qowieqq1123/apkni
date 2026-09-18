





eventBaseAction=simple_class(refObject)

local _guid=0
function eventBaseAction:init()
_guid=_guid+1
self.guid=_guid
end

function eventBaseAction:onRelease()
self.guid=nil
end

function eventBaseAction:update()
return self.leaveState
end

function eventBaseAction:leave()
refObject.release(self)
end

function eventBaseAction:isNext()
return false
end

