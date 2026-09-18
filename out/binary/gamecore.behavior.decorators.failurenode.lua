

failureNode=simple_class(decoratorNode)

function failureNode:update(interval)
local v=self:getChild(1)
if v:canExecute()then
v:tick(interval)
end
if v:isComplete()then
return nodeState.failure
end
return v:getState()
end