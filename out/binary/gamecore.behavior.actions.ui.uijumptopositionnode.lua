








UIJumpToPositionNode=simple_class(baseNode)

function UIJumpToPositionNode:reset()
UIJumpToPositionNode._base.reset(self)
self.isMoving=false
self.bComplete=false
end

function UIJumpToPositionNode:broke()
if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
end

function UIJumpToPositionNode:update(interval)
if self.isMoving then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local tpos=self:getData('inPos')
local speed=self:getData('speed')
local power=self:getData('power')or 1
local duration=self:getData('duration')

local currPos=widget:GetChildAnchoredPosition(wIndex)
local nextPos=Vector2.New(tpos[1],tpos[2])
local dis=Vector2.Distance(currPos,nextPos)
if nextPos.x~=currPos.x then
widget:SetChildUIModelShowFlipX(wIndex,nextPos.x>currPos.x)
end
widget:SetChildModelAnimationState(wIndex,eAnimationID.ui_jump1)
self.isMoving=true
local t=duration or dis/speed
self.tweener=widget:SetChildDOLocalJump(wIndex,nextPos,power,1,t,function()
self.isMoving=false
self.bComplete=true
self:quicklyTick()
end)
local ease=self:getData('ease')
if ease then
ease=DG.Tweening.Ease.IntToEnum(ease)
self.tweener:SetEase(ease)
end

return nodeState.running
end