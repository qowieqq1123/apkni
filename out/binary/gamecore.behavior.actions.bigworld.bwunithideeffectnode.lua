








bwUnitHideEffectNode=simple_class(baseNode)

function bwUnitHideEffectNode:update(interval)
self.unitKey=self:getData('unitKey')
self.hide=self:getData('hide')or true

if unitKey==nil then
return nodeState.failure
end

worldController:hideUnitEffect(self.unitKey,not self.hide)
return nodeState.success
end