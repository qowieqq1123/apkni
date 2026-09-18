









cameraShakeNode=simple_class(baseNode)

function cameraShakeNode:broke()
self:stopTweener()
end

function cameraShakeNode:update(interval)
local duration=self:getData('duration')
local strength=self:getData('strength')or 3
local vibrato=self:getData('vibrato')or 10
local random=self:getData('random')or 0
local fadeout=self:getData('fadeout')~=false
local isLoop=duration==0
local duration=isLoop and 3 or data.duration

local cameraTrans=_MapManager.GetCameraTransform()
self:stopTweener()
self.tweener=_DOTweenProxy.DOShakeRotation(cameraTrans,duration,strength,vibrato,random,fadeout)
self.tweener:OnComplete(function(...)
self.tweener:Kill(false)
self.tweener=nil
end)
self.tweener:SetEase(_Ease.Linear)
if isLoop then
self.tweener:SetLoops(-1,_LoopType.Restart)
end
return nodeState.success
end

function cameraShakeNode:stopTweener()
if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
end