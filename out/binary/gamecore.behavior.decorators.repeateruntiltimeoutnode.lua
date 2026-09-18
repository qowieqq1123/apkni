







repeaterUntilTimeoutNode=simple_class(decoratorNode)

function repeaterUntilTimeoutNode:init()
self.waitTime=self:getData('waitTime')
self.endOnFailure=self:getData('endOnFailure')
self.endTime=nil
end

function repeaterUntilTimeoutNode:update(interval)
local stime=gameUtilityModel.getServerShortTime()
if not self.endTime then
self.endTime=stime+self.waitTime
end
if stime>=self.endTime then
return nodeState.success
end

local v=self:getChild(1)
if v:isComplete()then
v:reset()
end

v:tick(interval)

if self.endOnFailure and v.state==nodeState.failure then
return nodeState.failure
end

return nodeState.running
end