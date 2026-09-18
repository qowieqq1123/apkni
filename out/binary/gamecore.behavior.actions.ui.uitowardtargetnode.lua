







UITowardTargetNode=simple_class(baseNode)

function UITowardTargetNode:reset()
UITowardTargetNode._base.reset(self)
end

function UITowardTargetNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local tpos=self:getData('inPos')

local spoint=widget:GetChildLocalPosition(wIndex)
local spos=mathHelper.convertVectorToArray(spoint)

local disX=tpos[1]-spos[1]
local disY=tpos[2]-spos[2]
local rotate=math.deg(math.atan2(disY,disX))
if disX<=0 then
rotate=rotate-180
end
widget:SetChildRotation(wIndex,0,0,rotate)

return nodeState.success
end

function UITowardTargetNode:skip()
return self:update()
end