


registry_pool_class(fBTNodeTypo.FightPlaySceneEffectObjAnim,'fBTFightPlaySceneEffectObjAnimNode',fBTBaseNode)

function fBTFightPlaySceneEffectObjAnimNode:__init(guid)
self.typo=fBTNodeTypo.FightPlaySceneEffectObjAnim
end

function fBTFightPlaySceneEffectObjAnimNode:parser(rawData)
self.stateID=rawData[1]
end



function fBTFightPlaySceneEffectObjAnimNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTFightPlaySceneEffectObjAnimNode:start()

self.state=fBTNodeState.success

local battle=self.entity.battle
if battle then
battle:playSceneEffectAnim(self.entity,self.stateID,1)
end
end


function fBTFightPlaySceneEffectObjAnimNode:update(delta)

return self.state
end


function fBTFightPlaySceneEffectObjAnimNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

