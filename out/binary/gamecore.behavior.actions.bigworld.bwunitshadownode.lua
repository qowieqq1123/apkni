








bwUnitShadowNode=simple_class(baseNode)

function bwUnitShadowNode:update(interval)
local unitKey=self:getData('unitKey')
local show=self:getData('show')or true

if unitKey==nil then return nodeState.failure end

worldController:setModelShadow(unitKey,show)

return nodeState.success
end