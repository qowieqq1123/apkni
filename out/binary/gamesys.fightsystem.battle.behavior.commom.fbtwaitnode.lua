


registry_pool_class(fBTNodeTypo.Wait,'fBTWaitNode',fBTBaseNode)

function fBTWaitNode:__init(guid)
self.typo=fBTNodeTypo.Wait
end

function fBTWaitNode:parser(rawData)
self.waitTime=rawData[1]
self.random=rawData[2]
self.minTime=rawData[3]
self.maxTime=rawData[4]
end



function fBTWaitNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
if self.random then
self.waitTime=math.random(self.minTime*100,self.maxTime*100)*0.01
end
end

function fBTWaitNode:start()
self.time=0
self.state=fBTNodeState.running
end


function fBTWaitNode:update(delta)
self.time=self.time+delta
if self.time>=self.waitTime then
self.state=fBTNodeState.success
end
return self.state
end


function fBTWaitNode:onDespawn()
self.entity=nil
self.waitTime=0
self.time=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


