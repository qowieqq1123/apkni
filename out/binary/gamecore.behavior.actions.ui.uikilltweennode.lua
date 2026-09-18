UIKillTweenNode=simple_class(baseNode)

function UIKillTweenNode:reset()
self._base.reset(self)
end

function UIKillTweenNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local component=self:getData('component')
local complete=self:getData('complete')or false
local trans=widget:GetCommonComponent(wIndex,component)
Lua.DOTweenProxyExtensions.DOKill(trans,complete)
return nodeState.success
end


function UIKillTweenNode:skip()
return self:update()
end