


registry_pool_class(fBTNodeTypo.FightEntityFilpX,'fBTFightEntityFilpXNode',fBTBaseNode)

function fBTFightEntityFilpXNode:__init(guid)
self.typo=fBTNodeTypo.FightEntityFilpX
end

function fBTFightEntityFilpXNode:parser(rawData)
self.faceTo=rawData[1]
end



function fBTFightEntityFilpXNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTFightEntityFilpXNode:start()

if self.entity:isLeft()then
self.entity:flipX(not self.faceTo)
else
self.entity:flipX(self.faceTo)
end


self.state=fBTNodeState.success
end


function fBTFightEntityFilpXNode:update(delta)

return self.state
end


function fBTFightEntityFilpXNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

