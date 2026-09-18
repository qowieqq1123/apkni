








bwUnitDeleteNode=simple_class(baseNode)

function bwUnitDeleteNode:update(interval)
local unitKey=self:getData('unitKey')

if unitKey==nil then return nodeState.failure end

worldController:popUnit(unitKey)

return nodeState.success
end