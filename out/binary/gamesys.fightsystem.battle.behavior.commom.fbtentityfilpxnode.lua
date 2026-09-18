


registry_pool_class(fBTNodeTypo.EntityFilpX,'fBTEntityFilpXNode',fBTBaseNode)

function fBTEntityFilpXNode:__init(guid)
self.typo=fBTNodeTypo.EntityFilpX
end

function fBTEntityFilpXNode:parser(rawData)
self.faceTo=rawData[1]
end



function fBTEntityFilpXNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTEntityFilpXNode:start()


self.entity:flipX(self.faceTo)

self.state=fBTNodeState.success
end


function fBTEntityFilpXNode:update(delta)

return self.state
end


function fBTEntityFilpXNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

