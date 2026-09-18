





setSharedVarNode=simple_class(baseNode)

function setSharedVarNode:update(interval)
local key=self:getData('key')
local val=self:getData('value')
self:setSharedVar(key,val)
return nodeState.success
end