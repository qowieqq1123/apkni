








bwUnitSetAnimationNode=simple_class(baseNode)

function bwUnitSetAnimationNode:update(interval)

local unitKey=self:getData('unitKey')
local animation=self:getData('animation')

worldController:setAnimation(unitKey,animation)

return nodeState.success
end