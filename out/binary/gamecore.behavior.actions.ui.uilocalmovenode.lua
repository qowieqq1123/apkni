UILocalMoveNode=simple_class(baseNode)

function UILocalMoveNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
if self.tweener then
self.tweener:Kill(false)
end
self.tweener=nil
end

function UILocalMoveNode:update(interval)
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

if type(val)=='table'then
val=Vector3(val[1],val[2],val[3]or 0)
end

if duration>0 then
self.isplaying=true
local tweener=widget:SetChildDOLocalMove(wIndex,val,duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
local delay=self:getData('delay')
if delay then
tweener:SetDelay(delay)
end
self.tweener=tweener
else
widget:SetChildLocalPosition(wIndex,val)
return nodeState.success
end

return nodeState.running
end

function UILocalMoveNode:skip()
if self.tweener then
self.tweener:Kill(false)
end
self.tweener=nil
if self.bComplete then
return nodeState.success
end
local widget=self:getData('widget')
local wIndex=self:getData('target')
local val=self:getData('value')

widget:SetChildLocalPosition(wIndex,val)
return nodeState.success
end