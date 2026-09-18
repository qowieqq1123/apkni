






setCameraEffect=simple_class(baseNode)

function setCameraEffect:update(interval)

local setState=self:getData('setState')
local effectId=self:getData('effectId')

local cameraTransform=cameraControl.getCameraTransform()

if cameraTransform then
if setState==1 then

local effectHandle=_MapManager.PlayEffectByParent(cameraTransform,effectId)
self:setSharedVar("cameraEffectHandle",effectHandle)
elseif setState==0 then

local effectHandle=self:getSharedVar("cameraEffectHandle")
if effectHandle then
_stopEffect(effectHandle)
self:setSharedVar("cameraEffectHandle",nil)
end
end
else
logErr("未找到对应场景摄像机")
return nodeState.failure
end

return nodeState.success
end