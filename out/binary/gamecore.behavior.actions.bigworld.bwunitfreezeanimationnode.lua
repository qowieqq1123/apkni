








bwUnitFreezeAnimationNode=simple_class(baseNode)

function bwUnitFreezeAnimationNode:update(interval)

local unitKey=self:getData('unitKey')
local animation=self:getData('animation')
local progress=self:getData('progress')or 0

worldController:freezeAnimation(unitKey,animation,progress)

return nodeState.success
end