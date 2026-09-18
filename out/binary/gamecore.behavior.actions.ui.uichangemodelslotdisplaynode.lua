









UIChangeModelSlotDisplayNode=simple_class(baseNode)

function UIChangeModelSlotDisplayNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local slot=self:getData('slot')or"face"
local attachment=self:getData('attachment')or"face"
local id=self:getData('id')

widget:SetChildChangeSlotDisplay(wIndex,slot,attachment,id)

return nodeState.success
end

function UIChangeModelSlotDisplayNode:skip()
return self:update()
end