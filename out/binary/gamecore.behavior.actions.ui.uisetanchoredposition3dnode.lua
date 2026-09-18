






UISetAnchoredPosition3DNode=simple_class(baseNode)

function UISetAnchoredPosition3DNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local tpos=self:getData('pos')
local nextPos=Vector3.New(tpos[1],tpos[2],tpos[3])
widget:SetChildAnchoredPosition3D(wIndex,nextPos)

return nodeState.success
end

function UISetAnchoredPosition3DNode:skip()
return self:update()
end