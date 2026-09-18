registry_pool_class(fBTNodeTypo.Repeat,'fBTRepeatNode',fBTBaseNode)

function fBTRepeatNode:__init(guid)
self.typo=fBTNodeTypo.Wait
end


function fBTRepeatNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self.behaviorData=rawData[1]
end

function fBTRepeatNode:start()
self.time=0
self.state=fBTNodeState.running
end


function fBTRepeatNode:update(delta)

return self.state
end


function fBTRepeatNode:onDespawn()
self.entity=nil
self.waitTime=0
self.time=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end