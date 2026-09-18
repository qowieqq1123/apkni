








bwUnitFlipXNode=simple_class(baseNode)

function bwUnitFlipXNode:update(interval)
local unitKey=self:getData('unitKey')
local flip=self:getData('flip')

if unitKey==nil then return nodeState.failure end

worldController:setUnitFlipX(unitKey,flip)

return nodeState.success
end