


registry_pool_class(fBTNodeTypo.MysteryEntityRemove,'fBTMysteryEntityRemoveNode',fBTBaseNode)

function fBTMysteryEntityRemoveNode:__init(guid)
self.typo=fBTNodeTypo.MysteryEntityRemove
end

function fBTMysteryEntityRemoveNode:parser(rawData)
self.pos=fBTHelper.vector3(rawData,1)
self.entityType=rawData[4]
self.entityId=rawData[5]
self.fadeOutTime=rawData[6]
end



function fBTMysteryEntityRemoveNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
if self.entityType>0 then
self.entityType=self.entityType+1
end
end


function fBTMysteryEntityRemoveNode:start()

self.state=fBTNodeState.success

local entity
if self.entityType==0 then
entity=mysteryPlayerModel:get_player()
else
entity=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,"get_entity_by_pos_id",self.pos,mysteryRoomModel:get_cur_roomID(),self.entityId)
end

if entity then
self.entity=entity
if self.fadeOutTime>0 then
self.roleEntity=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,"get_role_entity",self.entity.guid)
self.roleEntity:FadeToColor(Color.New(1,1,1,0),self.fadeOutTime,function()
mysteryEntityController.send_4_50({entity})

if entity.entityType==eMysteryEntityType.eObstacle then
local mapType=mysteryRoomModel:get_mapType_by_roomID(entity.roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
mysteryFogController:createEffect(5,entity.pos,groundLayer,0.5,nil)
end
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'remove_entity',entity.guid)

self.state=fBTNodeState.success
end,0)






self.state=fBTNodeState.running
else
mysteryEntityController.send_4_50({entity})
end
end
end

function fBTMysteryEntityRemoveNode:update(delta)

return self.state
end


function fBTMysteryEntityRemoveNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

