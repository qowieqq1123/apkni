UIPlayEffectNode=simple_class(baseNode)

function UIPlayEffectNode:reset()
self._base.reset(self)
end

function UIPlayEffectNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local effectId=self:getData('effect')
local show=self:getData('show')
if widget==nil then return nodeState.success end
widget:SetChildShowEffect(wIndex,effectId,show)
return nodeState.success
end

function UIPlayEffectNode:skip()
return self:update()
end
