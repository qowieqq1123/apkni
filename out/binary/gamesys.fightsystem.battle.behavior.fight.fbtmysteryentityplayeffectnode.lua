


registry_pool_class(fBTNodeTypo.MysteryEntityPlayEffect,'fBTMysteryEntityPlayEffectNode',fBTBaseNode)

function fBTMysteryEntityPlayEffectNode:__init(guid)
self.typo=fBTNodeTypo.MysteryEntityPlayEffect
end

function fBTMysteryEntityPlayEffectNode:parser(rawData)
self.effectId=rawData[1]
self.useRange=rawData[2]
self.mustExe=rawData[3]
end



function fBTMysteryEntityPlayEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTMysteryEntityPlayEffectNode:start()

self.state=fBTNodeState.success

if not self.entity then
return
end

local guid=self.entity.guid
local entity=mysteryEntityBase:get_entity_all(guid)
if entity==nil then
return
end

if entity.posList then
local effectId=self.effectId
local groundLayer=mysteryRoomModel:get_GroundLayer(entity.roomId)
for i,v in pairs(entity.posList)do
mysteryFogController:createEffect(effectId,v,groundLayer,0)
end
else
local colorPosList=mysteryPosHelper.get_all_round_pos_list(entity.pos,self.useRange and entity.data.range or 0)
if colorPosList then
local effectId=self.effectId
local groundLayer=mysteryRoomModel:get_GroundLayer(entity.roomId)
for i,v in pairs(colorPosList)do
mysteryFogController:createEffect(effectId,v,groundLayer,0)
end
end
end


end


function fBTMysteryEntityPlayEffectNode:update(delta)

return self.state
end

function fBTMysteryEntityPlayEffectNode:onComplete()

end


function fBTMysteryEntityPlayEffectNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

