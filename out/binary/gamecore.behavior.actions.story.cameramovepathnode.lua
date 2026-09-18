






cameraMovePathNode=simple_class(baseNode)

function cameraMovePathNode:broke()
self:stopTweener()
end

function cameraMovePathNode:reset()
cameraMovePathNode._base.reset(self)
self.startPath=false
self.campComplete=false
end

function cameraMovePathNode:update(interval)
local pathPos=self:getData('pathPos')
local duration=self:getData('duration')or 0
local camPos=_MapManager.GetCameraPosition()

if pathPos then
if self.campComplete then
return nodeState.success
end
if self.startPath then
return nodeState.running
end
self:stopTweener()
local paths=self:getChangeArray(pathPos,camPos)
self.campTweener=_DOTweenProxy.DoPath(_MapManager.GetCameraTransform(),paths,duration)
self.campTweener:SetEase(_Ease.Linear)
self.campTweener:OnComplete(function(...)
self:stopTweener()
self.startPath=false
self.campComplete=true
end)
self.startPath=true
return nodeState.running
end
return nodeState.failure
end

function cameraMovePathNode:getChangeArray(pathPos,camPos)
local t={}
for i,v in ipairs(pathPos)do
table.insert(t,Vector3(v[1],v[2],camPos.z))
end
return t
end

function cameraMovePathNode:stopTweener()
if self.campTweener then
self.campTweener:Kill(false)
self.campTweener=nil
end
end

function cameraMovePathNode:skip()
self:stopTweener()
local pathPos=self:getData('pathPos')
if pathPos then
local lastPos=pathPos[#pathPos]
local camPos=_MapManager.GetCameraPosition()
local topos=Vector3(lastPos[1],lastPos[2],camPos.z)
_MapManager.SetCameraPosition(topos)
end
return nodeState.success
end