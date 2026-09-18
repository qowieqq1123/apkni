





probabilityNode=simple_class(baseNode)

function probabilityNode:update(interval)
local val=self:getData('value')or 0
if math.random()<val then
return nodeState.success
else
return nodeState.failure
end
end