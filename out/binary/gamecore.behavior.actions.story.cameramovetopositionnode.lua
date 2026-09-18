






cameraMoveToPositionNode=simple_class(baseNode)

function cameraMoveToPositionNode:broke()
self:stopTweener()
end

function cameraMoveToPositionNode:reset()
cameraMoveToPositionNode._base.reset(self)
self.camMoving=false
self.camComplete=false
end

function cameraMoveToPositionNode:update(interval)
local pos=self:getData('pos')
local duration=self:getData('duration')or 0
local camPos=_MapManager.GetCameraPosition()

if pos then
local topos=Vector3(pos[1],pos[2],camPos.z)
if duration==0 or self.camComplete then
_MapManager.SetCameraPosition(topos)
return nodeState.success
end
if self.camMoving then
return nodeState.running
end
self:stopTweener()
self.camTweener=_DOTweenProxy.DOMove(_MapManager.GetCameraTransform(),topos,duration)
self.camTweener:SetEase(_Ease.Linear)
self.camTweener:OnComplete(function(...)
self:stopTweener()
self.camMoving=false
self.camComplete=true
end)
self.camMoving=true
return nodeState.running
end
return nodeState.failure
end

function cameraMoveToPositionNode:stopTweener()
if self.camTweener then
self.camTweener:Kill(false)
self.camTweener=nil
end
end

function cameraMoveToPositionNode:skip()
self:stopTweener()
local pos=self:getData('pos')
if pos then
local camPos=_MapManager.GetCameraPosition()
local topos=Vector3(pos[1],pos[2],camPos.z)
_MapManager.SetCameraPosition(topos)
end
return nodeState.success
end