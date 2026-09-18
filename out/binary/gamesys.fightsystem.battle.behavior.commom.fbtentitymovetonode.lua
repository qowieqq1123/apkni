


registry_pool_class(fBTNodeTypo.EntityMoveTo,'fBTEntityMoveToNode',fBTBaseNode)

function fBTEntityMoveToNode:__init(guid)
self.typo=fBTNodeTypo.EntityMoveTo
end

function fBTEntityMoveToNode:parser(rawData)
self.speed=rawData[1]
self.dstPos=fBTHelper.vector3(rawData,2)
self.faceTo=rawData[5]
self.mustExe=rawData[6]
end



function fBTEntityMoveToNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.isExe=false
end

function fBTEntityMoveToNode:start()
local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
end
self.isMoving=true
self.isExe=true
local curPos=self.entity:getPosition()
local distance=Vector3.Distance(self.dstPos,curPos)
self.duration=distance/self.speed
self.entity:moveTo(self.dstPos,false,self.duration,1,onFinish)
if self.faceTo then
local pos=self.entity:getPosition()
self.entity:flipX(pos.x<self.dstPos.x)
end

self.state=fBTNodeState.running
end

function fBTEntityMoveToNode:update(delta)
return self.state
end

function fBTEntityMoveToNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
self.entity:moveTo(self.dstPos,false,0.1,1,nil)
end

self.isMoving=false
end

function fBTEntityMoveToNode:onDespawn()
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end




