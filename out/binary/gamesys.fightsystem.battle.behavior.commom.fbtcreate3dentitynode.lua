


registry_pool_class(fBTNodeTypo.Create3DEntity,'fBTCreate3DEntityNode',fBTBaseNode)

function fBTCreate3DEntityNode:__init(guid)
self.typo=fBTNodeTypo.Create3DEntity
end

function fBTCreate3DEntityNode:parser(rawData)
self.entName=rawData[1]
self.id=rawData[2]
self.pos=fBTHelper.vector3(rawData,3)
self.rot=fBTHelper.vector3(rawData,6)
self.scale=fBTHelper.vector3(rawData,9)
self.removeOnComplete=rawData[12]
self.waitModelLoadComplete=rawData[13]
self.delayRemove=rawData[14]
end



function fBTCreate3DEntityNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.isExe=false
end


function fBTCreate3DEntityNode:start()

self.state=self.waitModelLoadComplete and fBTNodeState.running or fBTNodeState.success
self.isExe=true
local ent=entity()
ent:init3DObj(self.id,self.pos,self.rot,self.scale,function()self.state=fBTNodeState.success end)
self.behaviorTree:setSharedValue(FMT.fmt("entity_{0}",self.entName),ent)
ent.delayRemove=self.delayRemove
end


function fBTCreate3DEntityNode:update(delta)

return self.state
end

function fBTCreate3DEntityNode:onComplete()
if self.isExe and self.removeOnComplete then
local ent=self.behaviorTree:getSharedValue(FMT.fmt("entity_{0}",self.entName))
if ent~=nil then
self.behaviorTree:setSharedValue(FMT.fmt("entity_{0}"),nil)
ent:hide()
end
end
end


function fBTCreate3DEntityNode:onDespawn()
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

