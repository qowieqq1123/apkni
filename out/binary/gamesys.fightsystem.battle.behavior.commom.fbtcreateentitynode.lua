


registry_pool_class(fBTNodeTypo.CreateEntity,'fBTCreateEntityNode',fBTBaseNode)

function fBTCreateEntityNode:__init(guid)
self.typo=fBTNodeTypo.CreateEntity
end

function fBTCreateEntityNode:parser(rawData)
self.entName=rawData[1]
self.bodyID=rawData[2]
self.cmpIDs=rawData[3]
self.pos=fBTHelper.vector3(rawData,4)
self.isInFightStage=rawData[7]
self.flipX=rawData[8]
self.scale=rawData[9]
self.initColor=fBTHelper.color4(rawData,10)
self.removeOnComplete=rawData[14]
self.delayRemove=rawData[15]
self.isInBigWorld=rawData[16]
end




function fBTCreateEntityNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.isExe=false

end

function fBTCreateEntityNode:start()
local ent=entity()
if self.isInFightStage then
self.pos=fightModel:transToBattleWorld(self.pos)
end
ent:initObj(self.bodyID,self.cmpIDs,self.pos,self.scale,self.flipX)
ent:fadeToColor(self.initColor,0)
if self.isInBigWorld then
ent:setSortingLayer("Entity")
end
self.behaviorTree:setSharedValue(FMT.fmt("entity_{0}",self.entName),ent)
ent.delayRemove=self.delayRemove
self.isExe=true
self.state=fBTNodeState.success
end

function fBTCreateEntityNode:update(delta)
return self.state
end

function fBTCreateEntityNode:onComplete()
if self.isExe and self.removeOnComplete then
local ent=self.behaviorTree:getSharedValue(FMT.fmt("entity_{0}",self.entName))
if ent~=nil then
self.behaviorTree:setSharedValue(FMT.fmt("entity_{0}"),nil)
ent:hide()
end
end
end

function fBTCreateEntityNode:onDespawn()
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end




