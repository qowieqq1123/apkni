










UIChangeModelColorNode=simple_class(baseNode)

function UIChangeModelColorNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UIChangeModelColorNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local color=self:getData('color')
color=Color.New(color[1],color[2],color[3],color[4])
local duration=self:getData('duration')or 0
local delay=self:getData('delay')or 0
local wait=self:getData('wait')

if duration>0 then
if wait then
self.isplaying=true
widget:SetChildUIModelShowFadeToColor(wIndex,color,duration,delay,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
return nodeState.running
else
self.bComplete=true
widget:SetChildUIModelShowFadeToColor(wIndex,color,duration,delay,nil)
return nodeState.success
end
else
widget:SetChildUIModelShowColor(wIndex,color)
return nodeState.success
end
end

function UIChangeModelColorNode:skip()
if self.bComplete then
return nodeState.success
end
local widget=self:getData('widget')
local wIndex=self:getData('target')
local color=self:getData('color')
color=Color.New(color[1],color[2],color[3],color[4])
widget:SetChildUIModelShowColor(wIndex,color)
self.isplaying=false
self.bComplete=true
return nodeState.success
end