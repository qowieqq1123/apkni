


registry_pool_class(fBTNodeTypo.WorldCameraMovePath,'fBTWorldCameraMovePathNode',fBTBaseNode)

function fBTWorldCameraMovePathNode:__init(guid)
self.typo=fBTNodeTypo.WorldCameraMovePath
end

function fBTWorldCameraMovePathNode:parser(rawData)
self.points=fBTHelper.listVector3(rawData,1)
self.duration=rawData[2]
self.ease=rawData[3]
self.mustExt=rawData[4]
end



function fBTWorldCameraMovePathNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTWorldCameraMovePathNode:start()

if self.duration>0 then
self.state=fBTNodeState.running
local cameraTF=worldController:getCameraTransform()
cameraTF.transform.position=self.points[1]
self.tween=Lua.DOTweenProxyExtensions.DoPath(cameraTF,
self.points,self.duration,DG.Tweening.PathType.IntToEnum(self.ease))
self.tween:OnComplete(function()
self:onTweenComplete()
end)
else
self.isExe=true
self.state=fBTNodeState.success
worldController:setCameraPosition(self.points[#self.points],true)
end
end


function fBTWorldCameraMovePathNode:update(delta)

return self.state
end


function fBTWorldCameraMovePathNode:onDespawn()
self.entity=nil
self.isExe=false
self:killTween()
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTWorldCameraMovePathNode:onTweenComplete()
self.isExe=true
self.state=fBTNodeState.success
end

function fBTWorldCameraMovePathNode:onComplete()

if self.mustExe and not self.isExe then
self:killTween()
self.state=fBTNodeState.success
worldController:setCameraPosition(self.points[#self.points],true)
end
end

function fBTWorldCameraMovePathNode:killTween()
if self.tween then
self.tween:Kill()
self.tween=nil
end
end
