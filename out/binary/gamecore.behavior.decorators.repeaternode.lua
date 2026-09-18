








repeaterNode=simple_class(decoratorNode)

function repeaterNode:init()
self.repeatForever=self:getData('repeatForever')
self.endOnFailure=self:getData('endOnFailure')
self.count=self:getData('count')
self.runCount=0
end

function repeaterNode:update(interval)
local v=self:getChild(1)
if v:isComplete()then
v:reset()
end

v:tick(interval)

if not self.repeatForever then
if v:isComplete()then
self.runCount=self.runCount+1
if self.runCount>=self.count then
return nodeState.success
end
end
end

if self.endOnFailure and v.state==nodeState.failure then
return nodeState.failure
end

return nodeState.running
end