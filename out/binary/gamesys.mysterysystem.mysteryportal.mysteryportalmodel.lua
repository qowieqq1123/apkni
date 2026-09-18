







mysteryPortalModel=mysteryEntityBase.new(eMysteryEntityType.ePortal,{})

mysteryPortalModel.entityType=eMysteryEntityType.ePortal


function mysteryPortalModel:get_config(id)
local config=cfg_secretscenetransferdoor_get(id)
return config
end

function mysteryPortalModel.get_portal_config(id)
local config=cfg_secretscenetransferdoor_get(id)
return config
end










mysteryPortalModel.roomPortalLookup={}

function mysteryPortalModel:init_data()
self.roomPortalLookup={}
end


function mysteryPortalModel:set_portal_room_data(roomList,inroomId)
for i,v in ipairs(roomList)do




if not self.roomPortalLookup[inroomId]then
self.roomPortalLookup[inroomId]={}
end
self.roomPortalLookup[inroomId][v.guid]=v
end
end

function mysteryPortalModel:add_portal_room_data(door,roomId,x,y,toRoomId)

toRoomId=toRoomId or door.etId

if not self.roomPortalLookup[roomId]then
self.roomPortalLookup[roomId]={}
end
if roomId==toRoomId then
return
end

self.roomPortalLookup[roomId][door.guid]={doorGuid=door.guid,transferDoorId=door.etId,inRoomId=roomId,toRoomId=toRoomId,x=x,y=y,roomId=roomId}
end

function mysteryPortalModel:set_back_portal_data(portalList)
self:set_portal_room_data(portalList)
end

function mysteryPortalModel:clear_portal_data(roomID)
self.roomPortalLookup[roomID]=nil
end

function mysteryPortalModel:get_portal_data(roomID)
return self.roomPortalLookup[roomID]
end

function mysteryPortalModel:checkDoorAndPortal(roomID,doorID)
local data=mysteryPortalModel:get_portal_data(roomID)
if data then
for _,v2 in pairs(data)do
if doorID==v2.transferDoorId then
return true
end
end
end
end


function mysteryPortalModel:getPortal(roomID)
if roomID==0 then
return
end
local data=mysteryPortalModel:get_portal_data(roomID)
if data then
for _,v2 in pairs(data)do
return v2.transferDoorId
end
end
end

function mysteryPortalModel:get_room(doorId,x,y)
for roomId,v in pairs(self.roomPortalLookup)do
for _,v2 in pairs(v)do
if doorId==v2.transferDoorId and v2.x==x and v2.y==y then
return roomId
end
end
end
end

function mysteryPortalModel:get_room_guid(roomId,guid)
if self.roomPortalLookup[roomId]and self.roomPortalLookup[roomId][guid]then
return self.roomPortalLookup[roomId][guid].toRoomId
end
end

function mysteryPortalModel:isRoomBanSkill(roomId)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local portal=self:getPortal(roomId)
if portal then
return self:isBanSkill(portal)
end
end

function mysteryPortalModel:isBanSkill(portalId)
local config=self:get_config(portalId)
return config and config.banSkill
end

