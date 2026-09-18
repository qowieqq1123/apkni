






UISetActiveNode=simple_class(baseNode)

function UISetActiveNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local isAct=self:getData('isActive')
widget:SetChildActive(wIndex,isAct)
return nodeState.success
end

function UISetActiveNode:skip()
return self:update()
end