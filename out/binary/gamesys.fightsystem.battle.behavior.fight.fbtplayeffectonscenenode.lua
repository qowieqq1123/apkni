


registry_pool_class(fBTNodeTypo.PlayEffectOnScene,'fBTPlayEffectOnSceneNode',fBTBaseNode)

function fBTPlayEffectOnSceneNode:__init(guid)
self.typo=fBTNodeTypo.PlayEffectOnScene
end

function fBTPlayEffectOnSceneNode:parser(rawData)
self.effectID=rawData[1]
self.holdPlaceID=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
self.delayTime=rawData[6]
self.removeOnComplete=rawData[7]
self.scale=fBTHelper.vector3(rawData,8)
end



local stopEffect=CS.GameInterface.StopEffect
local playEffect=CS.GameInterface.PlayEffect


function fBTPlayEffectOnSceneNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTPlayEffectOnSceneNode:start()
self.state=fBTNodeState.running
end


function fBTPlayEffectOnSceneNode:update(delta)
self.delayTime=self.delayTime-delta
if self.delayTime<=0 then
self:play()
end
return self.state
end

function fBTPlayEffectOnSceneNode:play()
local pos=fightModel:getPosInfo(self.holdPlaceID).pos+self.offset+fBTHelper.posOffset
self.handle=fightManager.playEffect(self.effectID,pos,self.entity:isLeft(),self.scale)
self.state=fBTNodeState.success
end

function fBTPlayEffectOnSceneNode:onDespawn()
if self.removeOnComplete and self.handle then
stopEffect(self.handle)
end
self.entity=nil
self.effectID=0
self.delayTime=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


