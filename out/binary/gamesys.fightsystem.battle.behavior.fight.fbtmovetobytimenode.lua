


registry_pool_class(fBTNodeTypo.MoveToByTime,'fBTMoveToByTimeNode',fBTBaseNode)

function fBTMoveToByTimeNode:__init(guid)
self.typo=fBTNodeTypo.MoveToByTime
end

function fBTMoveToByTimeNode:parser(rawData)
self.moveToType=rawData[1]
self.duration=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
self.faceTo=rawData[6]
self.mustExe=rawData[7]
end



function fBTMoveToByTimeNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

self.dstPos=Vector3.New(0,0,0)
local init=fBTHelper.getMoveTargetInitFunc(self.moveToType)
if init~=nil then
init(self)
end
self.isExe=false

end

function fBTMoveToByTimeNode:start()
local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
if self.moveToType==eMoveTargetType.moveToOrg then
self.entity:flipX(self.entity:isLeft())
elseif self.moveToType==eMoveTargetType.moveToTarget then
if self.targetIsLeft==self.entity:isLeft()then
self.entity:flipX(not self.entity:isLeft())
end
end
end
self.isMoving=true
self.isExe=true
local curPos=self.entity:getPosition()

if self.faceTo then
local pos=self.entity:getPosition()
self.entity:flipX(pos.x<self.dstPos.x)
end

if self.moveToType==eMoveTargetType.SetToPos then
if self.entity.entObj then
self.entity.entObj.transform.localPosition=self.dstPos
end

self.state=fBTNodeState.success
else
self.entity:moveTo(self.dstPos,false,self.duration,1,onFinish)

self.state=fBTNodeState.running
end
end


function fBTMoveToByTimeNode:update(delta)
return self.state
end

function fBTMoveToByTimeNode:onEnd()

end

function fBTMoveToByTimeNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
self.entity:moveTo(self.dstPos,false,0.1,1,nil)
end

self.isMoving=false
end

function fBTMoveToByTimeNode:onDespawn()
if self.state~=fBTNodeState.success then
self.entity:stopMoveTo()
end
self.behaviorTree=nil
self.entity=nil

self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

