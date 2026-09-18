UISetSizeDeltaNode=simple_class(baseNode)


function UISetSizeDeltaNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UISetSizeDeltaNode:update(interval)
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
local wait=self:getData('wait')
if wait==nil then
wait=true
end

local onComplete=nil
if wait then
onComplete=function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end
end

local tweener=widget:SetChildDOSizeDelta(wIndex,mathHelper.convertArrayToVector(val),duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
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
widget:SetChildSizeDelta(wIndex,val[1],val[2])
return nodeState.success
end

return nodeState.running
end

function UISetSizeDeltaNode:skip()
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local val=self:getData('value')
widget:SetChildSizeDelta(wIndex,val[1],val[2])
return nodeState.success
end