








bwUnitScaleNode=simple_class(baseNode)

function bwUnitScaleNode:update(interval)

local unitKey=self:getData('unitKey')
local scale=self:getData('scale')

if unitKey==nil or scale==nil then
return nodeState.failure
end

worldController:setModelScale(unitKey,scale)

return nodeState.success
end