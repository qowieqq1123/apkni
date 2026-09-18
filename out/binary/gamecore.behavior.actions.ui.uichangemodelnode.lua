













UIChangeModelNode=simple_class(baseNode)

function UIChangeModelNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UIChangeModelNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local model=self:getData('model')
local size=self:getData('scale')or 1
local componnets=self:getData('componnets')or{}
local animation=self:getData('animation')
local stopAnim=self:getData('stopAnim')or false
local softMask=self:getData('softMask')or false
local fadeIn=self:getData('fadeIn')or 0.6
local wait=self:getData('wait')or false

if animation==nil then
local name=self:getData('animName')
animation=eAnimationID[name]
end
animation=animation or eAnimationID.stand

local callback=nil
local state=nil
if wait then
self.isplaying=true
state=nodeState.running
callback=function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end
else
self.isplaying=false
self.bComplete=true
state=nodeState.success
end

widget:SetChildUIModelShowTarget(wIndex,model,size,componnets,animation,stopAnim,softMask,fadeIn,callback)

return state
end

function UIChangeModelNode:skip()
self.isplaying=false
self.bComplete=true

local widget=self:getData('widget')
local wIndex=self:getData('target')
local model=self:getData('model')
local size=self:getData('scale')or 1
local componnets=self:getData('componnets')or{}
local animation=self:getData('animation')or eAnimationID.stand
local stopAnim=self:getData('stopAnim')or false
local softMask=self:getData('softMask')or false
widget:SetChildUIModelShowTarget(wIndex,model,size,componnets,animation,stopAnim,softMask,0,nil)

return nodeState.success
end