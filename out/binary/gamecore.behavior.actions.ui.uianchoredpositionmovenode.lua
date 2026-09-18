






UIAnchoredPositionMoveNode=simple_class(baseNode)

function UIAnchoredPositionMoveNode:reset()
baseNode.reset(self)
self.isplaying=false
self.bComplete=false
end


function UIAnchoredPositionMoveNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local tpos=self:getData('pos')
local nextPos=Vector2.New(tpos[1],tpos[2])
local duration=self:getData('duration')or 0

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

local tweener=widget:SetChildDOAnchorPos(wIndex,nextPos,duration,function()
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
widget:SetChildAnchoredPosition(wIndex,nextPos)
end

return nodeState.success
end

function UIAnchoredPositionMoveNode:skip()
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local tpos=self:getData('pos')
widget:SetChildAnchoredPosition(wIndex,Vector2.New(tpos[1],tpos[2]))
return nodeState.success
end