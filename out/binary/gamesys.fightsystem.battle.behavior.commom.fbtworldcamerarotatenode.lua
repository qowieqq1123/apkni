


registry_pool_class(fBTNodeTypo.WorldCameraRotate,'fBTWorldCameraRotateNode',fBTBaseNode)

function fBTWorldCameraRotateNode:__init(guid)
self.typo=fBTNodeTypo.WorldCameraRotate
end

function fBTWorldCameraRotateNode:parser(rawData)
self.srcPos=fBTHelper.vector3(rawData,1)
self.dstPos=fBTHelper.vector3(rawData,4)
self.duration=rawData[7]
self.ease=rawData[8]
self.mode=rawData[9]
self.mustExt=rawData[10]
end



function fBTWorldCameraRotateNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTWorldCameraRotateNode:start()

if self.duration>0 then
self.state=fBTNodeState.running
local cameraTF=worldController:getCameraTransform()
cameraTF.transform.rotation=Quaternion.Euler(self.srcPos.x,self.srcPos.y,self.srcPos.z)
self.tween=Lua.DOTweenProxyExtensions.DORotate(cameraTF,self.dstPos,self.duration,DG.Tweening.RotateMode.IntToEnum(self.mode))
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(self.ease))
self.tween:OnComplete(function()
self:onTweenComplete()
end)
else
local cameraTF=worldController:getCameraTransform()
cameraTF.transform.rotation=Quaternion.Euler(self.dstPos.x,self.dstPos.y,self.dstPos.z)
self.isExe=true
self.state=fBTNodeState.success
end
end


function fBTWorldCameraRotateNode:update(delta)

return self.state
end


function fBTWorldCameraRotateNode:onDespawn()
self.entity=nil
self.isExe=false
self:killTween()
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTWorldCameraRotateNode:onTweenComplete()
self.isExe=true
self.state=fBTNodeState.success
end

function fBTWorldCameraRotateNode:onComplete()

if self.mustExe and not self.isExe then
self:killTween()
self.state=fBTNodeState.success
local cameraTF=worldController:getCameraTransform()
cameraTF.transform.rotation=Quaternion.Euler(self.dstPos.x,self.dstPos.y,self.dstPos.z)
end
end

function fBTWorldCameraRotateNode:killTween()
if self.tween then
self.tween:Kill()
self.tween=nil
end
end
