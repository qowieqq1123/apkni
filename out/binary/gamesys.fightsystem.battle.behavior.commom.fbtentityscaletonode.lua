


registry_pool_class(fBTNodeTypo.EntityScaleTo,'fBTEntityScaleToNode',fBTBaseNode)

function fBTEntityScaleToNode:__init(guid)
self.typo=fBTNodeTypo.EntityScaleTo
end

function fBTEntityScaleToNode:parser(rawData)
self.speed=rawData[1]
self.dstSize=rawData[2]
self.mustExe=rawData[3]
end



function fBTEntityScaleToNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTEntityScaleToNode:start()
local onFinish=function()
self.state=fBTNodeState.success
self.isChange=false
end
self.isChange=true
self.isExe=true

self.entity:scaleToRate(self.dstSize,self.speed,0,1,onFinish)

self.state=fBTNodeState.running
end


function fBTEntityScaleToNode:update(delta)

return self.state
end

function fBTEntityScaleToNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
self.entity:stopScaleTo(true)
end

self.isChange=false
end



function fBTEntityScaleToNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

