








bwUnitShowNode=simple_class(baseNode)

function bwUnitShowNode:update(interval)

local unitKey=self:getData('unitKey')
local show=self:getData('show')

if unitKey==nil then
return nodeState.failure
end

worldController:showUnitModel(unitKey,show)

return nodeState.success
end