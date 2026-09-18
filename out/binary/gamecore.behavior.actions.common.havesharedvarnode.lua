




haveSharedVarNode=simple_class(baseNode)

function haveSharedVarNode:update(interval)
local key=self:getData('key')
local value=self:getSharedVar(key)
if value then
return nodeState.success
end
return nodeState.failure
end