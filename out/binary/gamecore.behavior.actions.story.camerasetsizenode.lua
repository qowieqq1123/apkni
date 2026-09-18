







cameraSetSizeNode=simple_class(baseNode)

function cameraSetSizeNode:broke()
self:stopTweener()
end

function cameraSetSizeNode:reset()
cameraSetSizeNode._base.reset(self)
self.changing=false
self.completeChange=false
end

function cameraSetSizeNode:update(interval)
local size=self:getData('size')
local change=self:getData('change')or-1
local duration=self:getData('duration')or 0

if duration==0 then
_MapManager.SetCameraOrthographicSize(size)
return nodeState.success
end

if self.changing then
return nodeState.running
end
if self.completeChange then
return nodeState.success
end

local lastVal=_MapManager.GetCameraOrthographicSize()
self:stopTweener()
self.tweener=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
_MapManager.SetCameraOrthographicSize(val)
local isArrive=false
if change==-1 then
isArrive=val<=(size+0.01)
else
isArrive=val>=(size-0.01)
end
if isArrive then
self.changing=false
self.completeChange=true
if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
end
end,size,duration)
self.tweener:SetEase(_Ease.InOutQuart)
self.changing=true
return nodeState.running
end

function cameraSetSizeNode:stopTweener()
if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
end

function cameraSetSizeNode:skip()
self:stopTweener()
local size=self:getData('size')
_MapManager.SetCameraOrthographicSize(size)
return nodeState.success
end