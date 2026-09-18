













UIMoveToPositionNode=simple_class(baseNode)

function UIMoveToPositionNode:reset()
UIMoveToPositionNode._base.reset(self)
self.isMoving=false
self.bComplete=false
end

function UIMoveToPositionNode:broke()
if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
if self.isMoving then
self.modelWidget:SetChildModelAnimationState(self.modelIndex,eAnimationID.stand)
self.isMoving=false
end
self.modelWidget=nil
self.modelIndex=nil
end

function UIMoveToPositionNode:getUsePos(widget,index,tpos)
local rcpos=widget:GetChildAnchoredPosition(index)
local rtpos=Vector2.New(tpos[1],tpos[2])
return rcpos,rtpos
end

function UIMoveToPositionNode:countDistance(currPos,nextPos)
return Vector2.Distance(currPos,nextPos)
end

function UIMoveToPositionNode:doMove(widget,index,pos,time,callback)
return widget:SetChildDOAnchorPos(index,pos,time,callback)
end

function UIMoveToPositionNode:update(interval)
if self.isMoving then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
if widget==nil then return nodeState.success end

local wIndex=self:getData('target')
local tpos=self:getData('inPos')
local speed=self:getData('speed')
local animId=self:getData('animId')

if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

local modelWidget=self:getData('modelWidget')
local modelIndex=self:getData('modelIndex')
self.modelWidget=modelWidget or widget
self.modelIndex=modelIndex or wIndex

local currPos,nextPos=self:getUsePos(widget,wIndex,tpos)
local dis=self:countDistance(currPos,nextPos)
if nextPos.x~=currPos.x then
self.modelWidget:SetChildUIModelShowFlipX(self.modelIndex,nextPos.x>currPos.x)
end
animId=animId or eAnimationID.run
if animId>0 then
self.modelWidget:SetChildModelAnimationState(self.modelIndex,animId)
end
self.isMoving=true
self.tweener=self:doMove(widget,wIndex,nextPos,dis/speed,function()
self.isMoving=false
self.bComplete=true
self:quicklyTick()
if animId>0 then
self.modelWidget:SetChildModelAnimationState(self.modelIndex,eAnimationID.stand)
end
end)
local moveEase=self:getData('moveEase')
self.tweener:SetEase(moveEase or _Ease.Linear)

return nodeState.running
end