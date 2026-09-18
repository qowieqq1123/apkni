







UISetModelFlipNode=simple_class(baseNode)

function UISetModelFlipNode:update(interval)
local xValue=self:getData('xValue')
local widget=self:getData('widget')
local wIndex=self:getData('target')
widget:SetChildUIModelShowFlipX(wIndex,xValue)

return nodeState.success
end

function UISetModelFlipNode:skip()
return self:update()
end