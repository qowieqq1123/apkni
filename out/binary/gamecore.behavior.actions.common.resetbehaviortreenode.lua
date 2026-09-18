





resetBehaviorTreeNode=simple_class(baseNode)

function resetBehaviorTreeNode:update(interval)
local owner=self:getOwner()
owner:broke()
owner:reset()
return nodeState.success
end