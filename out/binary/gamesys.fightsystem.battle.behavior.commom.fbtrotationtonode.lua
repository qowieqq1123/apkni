


registry_pool_class(fBTNodeTypo.RotationTo,'fBTRotationToNode',fBTBaseNode)

function fBTRotationToNode:__init(guid)
self.typo=fBTNodeTypo.RotationTo
end

function fBTRotationToNode:parser(rawData)
self.speed=rawData[1]
self.angle=fBTHelper.vector3(rawData,2)
self.mustExe=rawData[5]
end



function fBTRotationToNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.isExe=false

end

function fBTRotationToNode:start()
local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
end

self.isMoving=true
self.isExe=true
self.entity:rotationTo(self.angle,self.speed,1,onFinish)
self.state=fBTNodeState.running
end

function fBTRotationToNode:update(delta)
return self.state
end

function fBTRotationToNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
self.entity:rotationTo(self.angle,10000,1,nil)
end

self.isMoving=false
end

function fBTRotationToNode:onDespawn()
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

