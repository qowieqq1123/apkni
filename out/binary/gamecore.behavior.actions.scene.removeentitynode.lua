





removeEntityNode=simple_class(baseNode)

function removeEntityNode:update()
local entityId=self:getData('entityId')
_EntityManager:RemoveEntity(entityId)

return nodeState.success
end