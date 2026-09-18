







weightNode=simple_class(baseNode)

function weightNode:update(interval)
local weight=self:getData('weight')or 0
local score=math.random(0,1000)
if score<weight then
return nodeState.success
else
return nodeState.failure
end
end