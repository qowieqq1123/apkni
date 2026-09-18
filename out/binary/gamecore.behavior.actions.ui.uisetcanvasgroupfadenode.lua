








UISetCanvasGroupFadeNode=simple_class(baseNode)

function UISetCanvasGroupFadeNode:reset()
UISetCanvasGroupFadeNode._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UISetCanvasGroupFadeNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local val=self:getData('value')
local duration=self:getData('duration')
if duration>0 then
self.isplaying=true
local tweener=widget:SetChildCanvasGroupDOFade(wIndex,val,duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
local delay=self:getData('delay')
if delay and delay>0 then
tweener:SetDelay(delay)
end
else
widget:SetChildCanvasGroupAlpha(wIndex,val)
return nodeState.success
end

return nodeState.running
end

function UISetCanvasGroupFadeNode:skip()
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local val=self:getData('value')
widget:SetChildCanvasGroupAlpha(wIndex,val)
return nodeState.success
end