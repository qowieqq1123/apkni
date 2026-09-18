


registry_pool_class(fBTNodeTypo.BindWorldEntity,'fBTBindWorldEntityNode',fBTBaseNode)

function fBTBindWorldEntityNode:__init(guid)
self.typo=fBTNodeTypo.BindWorldEntity
end

function fBTBindWorldEntityNode:parser(rawData)
self.entName=rawData[1]
self.unitKey=rawData[2]
end



function fBTBindWorldEntityNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTBindWorldEntityNode:start()


local ent=worldController:getUnitModelEntity(self.unitKey)
if ent then
self.behaviorTree:setSharedValue(FMT.fmt("entity_{0}",self.entName),ent)
end
self.isExe=true
end


function fBTBindWorldEntityNode:update(delta)

return self.state
end


function fBTBindWorldEntityNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

