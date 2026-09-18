


registry_pool_class(fBTNodeTypo.EntityTwinkle,'fBTEntityTwinkleNode',fBTBaseNode)

function fBTEntityTwinkleNode:__init(guid)
self.typo=fBTNodeTypo.EntityTwinkle
end

function fBTEntityTwinkleNode:parser(rawData)
self.duration=rawData[1]
self.color=fBTHelper.color4(rawData,2)
end



function fBTEntityTwinkleNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTEntityTwinkleNode:start()
self.entity:twinkle(self.duration,self.color)
self.state=fBTNodeState.success
end


function fBTEntityTwinkleNode:update(delta)
return self.state
end


function fBTEntityTwinkleNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end






