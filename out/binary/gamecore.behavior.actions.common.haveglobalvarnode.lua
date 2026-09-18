




haveGlobalVarNode=simple_class(baseNode)

function haveGlobalVarNode:update(interval)
local key=self:getData('key')
local value=behaviorManager:getGlobalVar(key)
if value then
return nodeState.success
end
return nodeState.failure
end