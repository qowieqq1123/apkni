

inverterNode=simple_class(decoratorNode)

function inverterNode:update(interval)
local v=self:getChild(1)
if v:canExecute()then
v:tick(interval)
end
local state=v:getState()
if state==nodeState.failure then
return nodeState.success
elseif state==nodeState.success then
return nodeState.failure
end
return state
end