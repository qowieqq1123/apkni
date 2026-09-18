




setGlobalVarNode=simple_class(baseNode)

function setGlobalVarNode:update(interval)
local key=self:getData('key')
local val=self:getData('value')
self:setGlobalVar(key,val)
return nodeState.success
end