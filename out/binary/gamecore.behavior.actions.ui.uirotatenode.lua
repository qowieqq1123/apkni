UIRotateNode=simple_class(baseNode)

function UIRotateNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UIRotateNode:update(interval)
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
local wait=self:getData('wait')
if wait==nil then
wait=true
end
if duration>0 then
local onComplete=nil
if wait then
onComplete=function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end
end

val=mathHelper.convertArrayToVector(val)
local mode=self:getData('mode')or 0
mode=DG.Tweening.RotateMode.IntToEnum(mode)
local tweener=widget:SetChildDOLocalRotate(wIndex,val,duration,mode,onComplete)
local loopCnt=self:getData('loopCnt')
if loopCnt then
local loopType=self:getData('loopType')or 0
loopType=DG.Tweening.LoopType.IntToEnum(loopType)
tweener:SetLoops(loopCnt,loopType)
end
local ease=self:getData('ease')
if ease then
ease=DG.Tweening.Ease.IntToEnum(ease)
tweener:SetEase(ease)
else
tweener:SetEase(DG.Tweening.Ease.Linear)
end
local delay=self:getData('delay')
if delay then
tweener:SetDelay(delay)
end
local fast=self:getData('goto')
if fast then
tweener:Goto(fast,true)
end

if wait then
self.isplaying=true
return nodeState.running
else
self.bComplete=true
return nodeState.success
end
else
widget:SetChildRotation(wIndex,val[1],val[2],val[3])
return nodeState.success
end


end

function UIRotateNode:skip()
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local val=self:getData('value')
widget:SetChildRotation(wIndex,val[1],val[2],val[3])
return nodeState.success
end