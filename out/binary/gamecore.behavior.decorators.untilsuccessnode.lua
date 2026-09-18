

untilSuccessNode=simple_class(decoratorNode)

function untilSuccessNode:update(interval)
local v=self:getChild(1)
if v:getState()==nodeState.failure then
v:reset()
end
v:tick(interval)
if v:getState()==nodeState.success then
return nodeState.success
end
return nodeState.running
end