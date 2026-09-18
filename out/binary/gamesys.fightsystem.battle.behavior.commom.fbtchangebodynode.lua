


registry_pool_class(fBTNodeTypo.ChangeBody,'fBTChangeBodyNode',fBTBaseNode)

function fBTChangeBodyNode:__init(guid)
self.typo=fBTNodeTypo.ChangeBody
end

function fBTChangeBodyNode:parser(rawData)
self.bodyID=rawData[1]
self.cmpIDs=rawData[2]
self.scale=rawData[3]
end




function fBTChangeBodyNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTChangeBodyNode:start()
self.entity:changeBody(self.bodyID,self.cmpIDs,self.scale)
self.state=fBTNodeState.success
end

function fBTChangeBodyNode:update(delta)
return self.state
end


function fBTChangeBodyNode:onDespawn()
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


