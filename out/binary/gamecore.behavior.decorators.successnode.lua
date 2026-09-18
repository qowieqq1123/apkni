

successNode=simple_class(decoratorNode)

function successNode:update(interval)
local v=self:getChild(1)
if v:canExecute()then
v:tick(interval)
end
if v:isComplete()then
return nodeState.success
end
return v:getState()
end