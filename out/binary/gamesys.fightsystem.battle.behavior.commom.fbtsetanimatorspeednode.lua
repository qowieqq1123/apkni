


registry_pool_class(fBTNodeTypo.SetAnimatorSpeed,'fBTSetAnimatorSpeedNode',fBTBaseNode)

function fBTSetAnimatorSpeedNode:__init(guid)
self.typo=fBTNodeTypo.SetAnimatorSpeed
end

function fBTSetAnimatorSpeedNode:parser(rawData)
self.speed=rawData[1]
end



function fBTSetAnimatorSpeedNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTSetAnimatorSpeedNode:start()

self.entity:setAnimatorSpeed(self.speed)
self.state=fBTNodeState.success
end


function fBTSetAnimatorSpeedNode:update(delta)

return self.state
end


function fBTSetAnimatorSpeedNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

