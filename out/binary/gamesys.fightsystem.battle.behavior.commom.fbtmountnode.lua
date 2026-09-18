


registry_pool_class(fBTNodeTypo.Mount,'fBTMountNode',fBTBaseNode)

function fBTMountNode:__init(guid)
self.typo=fBTNodeTypo.Mount
end

function fBTMountNode:parser(rawData)
self.mountID=rawData[1]
self.cmpIDs=rawData[2]
self.mountHp=rawData[3]
self.scale=rawData[4]
self.offset=fBTHelper.vector3(rawData,5)
end



function fBTMountNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTMountNode:start()

if self.mountID>0 then
self.entity:mount(self.mountID,self.cmpIDs,self.mountHp,self.scale,self.offset,nil)
else
self.entity:unMount()
end

self.state=fBTNodeState.success
end


function fBTMountNode:update(delta)

return self.state
end


function fBTMountNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

