


registry_pool_class(fBTNodeTypo.WorldCameraMove,'fBTWorldCameraMoveNode',fBTBaseNode)

function fBTWorldCameraMoveNode:__init(guid)
self.typo=fBTNodeTypo.WorldCameraMove
end

function fBTWorldCameraMoveNode:parser(rawData)
self.srcPos=fBTHelper.vector3(rawData,1)
self.dstPos=fBTHelper.vector3(rawData,4)
self.speed=rawData[7]
self.ease=rawData[8]
self.mustExt=rawData[9]
end



function fBTWorldCameraMoveNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

self.distance=Vector3.Distance(self.dstPos,self.srcPos)
self.duration=self.distance/self.speed
end


function fBTWorldCameraMoveNode:start()


local callback=function()
self.state=fBTNodeState.success
end

worldController:setCameraPosition(self.srcPos,true)
worldController:moveCameraPosition(self.dstPos,self.duration,callback,DG.Tweening.Ease.IntToEnum(self.ease))
self.state=fBTNodeState.running
end


function fBTWorldCameraMoveNode:update(delta)

return self.state
end


function fBTWorldCameraMoveNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTWorldCameraMoveNode:onComplete()

if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
worldController:setCameraPosition(self.dstPos,true)
end
end
