






UISetAnchoredPositionNode=simple_class(baseNode)

function UISetAnchoredPositionNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local tpos=self:getData('pos')
local nextPos=Vector2.New(tpos[1],tpos[2])
widget:SetChildAnchoredPosition(wIndex,nextPos)

return nodeState.success
end

function UISetAnchoredPositionNode:skip()
return self:update()
end