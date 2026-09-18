








bwUnitSlotIconNode=simple_class(baseNode)

function bwUnitSlotIconNode:update(interval)
self.unitKey=self:getData('unitKey')
self.slotName=self:getData('slotName')
self.iconName=self:getData('iconName')

if unitKey==nil or slotName==nil or iconName==nil then
return nodeState.failure
end

worldController:setModelSlotIcon(self.unitKey,slotName,iconName)
return nodeState.success
end