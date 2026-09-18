










UIStopAnimatorNode=simple_class(baseNode)

function UIStopAnimatorNode:reset()
self._base.reset(self)
end

function UIStopAnimatorNode:update(interval)

local widget=self:getData('widget')
local wIndex=self:getData('target')
local animId=self:getData('animId')
local progress=self:getData('progress')or 0

if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

widget:SetChildModelAnimationStop(wIndex,animId,progress)

return nodeState.success
end

function UIStopAnimatorNode:skip()
return self:update()
end