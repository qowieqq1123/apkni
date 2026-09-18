

untilFailureNode=simple_class(decoratorNode)

function untilFailureNode:update(interval)
local v=self:getChild(1)
if v:getState()==nodeState.success then
v:reset()
end
v:tick(interval)
if v:getState()==nodeState.failure then
return nodeState.failure
end
return nodeState.running
end