


registry_pool_class(fBTNodeTypo.EntityShadow,'fBTEntityShadowNode',fBTBaseNode)

function fBTEntityShadowNode:__init(guid)
self.typo=fBTNodeTypo.EntityShadow
end

function fBTEntityShadowNode:parser(rawData)
self.shadow=rawData[1]
self.mustExt=rawData[2]
end



function fBTEntityShadowNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

end

function fBTEntityShadowNode:start()
self.entity:showShadow(self.shadow)
self.state=fBTNodeState.success
end


function fBTEntityShadowNode:update(delta)
return self.state
end

function fBTEntityShadowNode:onComplete()

if self.mustExt then
self.entity:showShadow(self.shadow)
end
end

function fBTEntityShadowNode:onDespawn()
self.entity=nil
self.waitTime=0
self.time=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


