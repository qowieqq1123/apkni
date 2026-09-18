







mysteryRoomModel={}

local _HexMapManager=CS.HexagonMapManagerInterface

mysteryRoomModel.data={}





function mysteryRoomModel:init_data()
self.data={}

self.data.roomTypeIDLookup={}
self.data.roomPortalLookup={}
self.data.posEntData={}
self.data.FBData={}
self.data.tempGridData={}
end


function mysteryRoomModel:get_room_map_type()
return self.data.curRoomType
end


function mysteryRoomModel:set_cur_roomID(roomID)
self.data.roomID=roomID
if roomID==0 then
self.data.curRoomType=HexMapType.Main
else
if not(self.data.roomTypeIDLookup[self.data.curRoomType]and self.data.roomTypeIDLookup[self.data.curRoomType]==roomID)then
self.data.curRoomType=HexMapType.Room
end
end
self.data.roomTypeIDLookup[self.data.curRoomType]=roomID
MysteryModel:set_map_type(self.data.curRoomType)
if mysteryPlayerModel:has_player()then
mysteryPlayerModel:set_player_room(roomID)
end
end

function mysteryRoomModel:get_cur_roomID()
return self.data.roomTypeIDLookup[self.data.curRoomType]
end

function mysteryRoomModel:set_cur_birth_roomID(roomID)
self.data.birth_roomID=roomID
end

function mysteryRoomModel:get_cur_birth_roomID()
return self.data.birth_roomID
end


function mysteryRoomModel:get_roomID_by_type(mapType)
return self.data.roomTypeIDLookup[mapType]
end


function mysteryRoomModel:get_mapType_by_roomID(roomID)
if roomID==0 then
return HexMapType.Main
end
for k,v in pairs(self.data.roomTypeIDLookup)do
if v==roomID then
return k
end
end
end


function mysteryRoomModel:get_GroundLayer(roomID)
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
return MysteryController.MapLayerLookUp[mapType].GroundLayer
end

function mysteryRoomModel:get_room_groundLayer()
local roomId=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomId)
return MysteryController.MapLayerLookUp[mapType].GroundLayer
end



function mysteryRoomModel:set_temp_grid_data(roomID,x,y,preRoomId,gridList,etList)
self.data.tempGridData[roomID]={x,y,preRoomId,gridList,etList}
end

function mysteryRoomModel:get_temp_grid_data(roomID)
return self.data.tempGridData[roomID]
end
function mysteryRoomModel:set_room_grid_data(roomID,gridList,mapIndex,preRoomId)
self.data.FBData[roomID]={}
self.data.posEntData[roomID]={}
self.data.FBData[roomID].GridData={}
local mapAreaX=0
local mapAreaY=0
mapIndex=mapIndex or 1
local view=MysteryModel:get_fog_view()
local mapData=MysteryController.loadRoomMapData(roomID,mapIndex)
for i,v in ipairs(mapData[1])do
local x,y=v[3][1],v[3][2]
if not self.data.FBData[roomID].GridData[y]then
self.data.FBData[roomID].GridData[y]={}
end
if x>mapAreaX then
mapAreaX=x
end
if y>mapAreaY then
mapAreaY=y
end
if not view then
mysteryFogModel:set_fog_data(roomID,x,y,true)
end
self.data.FBData[roomID].GridData[y][x]={height=v[4],surfaceId=v[2],etGuid=v[2],gridType=v[1]}
end

local birth=mapData[4]
mysteryPortalModel:add_portal_room_data({guid=-1,etId=roomID,},roomID,birth[3][1],birth[3][2],preRoomId)


for i,v in ipairs(gridList or{})do
if not self.data.FBData[roomID].GridData[v.y]then
self.data.FBData[roomID].GridData[v.y]={}
end



















local fogFlag=mathHelper.getBitValue(v.gridStatus,0)
if fogFlag then
mysteryFogModel:set_fog_data(roomID,v.x,v.y,false)
else
mysteryFogModel:set_fog_data(roomID,v.x,v.y,true)
end
end

self:set_room_map_area(roomID,mapAreaX,mapAreaY)
end

function mysteryRoomModel:set_room_ent_birth_data(roomID,etList)
self.data.FBData[roomID].GridData=self.data.FBData[roomID].GridData or{}
for _,entity in ipairs(etList)do
if entity.etType==eMysteryEntityType.eSurface then
self.data.FBData[roomID].GridData[entity.etComm.y][entity.etComm.x]={height=0,surfaceId=entity.etId,etGuid=entity.etGuid}
else
local model=mysteryEntityController.getModelByEntityType(entity.etType)
if model then
local newData=model:dealServerData(entity)
if newData.etType==eMysteryEntityType.ePortal then
mysteryPortalModel:add_portal_room_data(newData,roomID,newData.x,newData.y)
mysteryRoomModel:set_room_entity_birth_pos_list(roomID,newData.etType,newData)

else
mysteryRoomModel:set_room_entity_birth_pos_list(roomID,newData.etType,newData)
end
end
end

end

end

function mysteryRoomModel:set_room_map_area(roomID,mapAreaX,mapAreaY)
if not self.data.FBData[roomID]then
self.data.FBData[roomID]={}
end
self.data.FBData[roomID].mapArea={mapAreaX,mapAreaY}
end

function mysteryRoomModel:get_room_map_area(roomID)
if not self.data.FBData[roomID]then
return
end
return self.data.FBData[roomID].mapArea
end

function mysteryRoomModel:get_room_grid_list_data(roomID)
if not self.data.FBData[roomID]then
return
end
return self.data.FBData[roomID].GridData
end

function mysteryRoomModel:get_room_grid_data(roomID,x,y)
if not self.data.FBData[roomID]then
return
end
if(not self.data.FBData[roomID].GridData)then
return
end
if not self.data.FBData[roomID].GridData[y]then
return
end
return self.data.FBData[roomID].GridData[y][x]
end


function mysteryRoomModel:clear_room_data(roomID)
self.data.FBData[roomID]=nil
self.data.posEntData[roomID]={}
end

function mysteryRoomModel:set_grid_data(roomID,x,y,gridData)
if not self.data.FBData[roomID]then
return
end
if(not self.data.FBData[roomID].GridData)then
return
end
if not self.data.FBData[roomID].GridData[y]then
self.data.FBData[roomID].GridData[y]={}
end
self.data.FBData[roomID].GridData[y][x]=gridData
end

function mysteryRoomModel:get_grid_data(roomID)
return roomID==0 and MysteryModel:get_all_main_grid_data()or self:get_room_grid_list_data(roomID)
end

function mysteryRoomModel:get_grid_pos_data(roomID,x,y)
return roomID==0 and MysteryModel:get_main_grid_data(x,y)or self:get_room_grid_data(roomID,x,y)
end

function mysteryRoomModel:set_grid_pos_data(roomID,x,y,gridData)
return roomID==0 and MysteryModel:set_main_grid_pos_data(x,y,gridData)or self:set_grid_data(roomID,x,y,gridData)
end




function mysteryRoomModel:set_room_entity_birth_pos_list(roomID,entityType,addData)
if not self.data.FBData[roomID]then
self.data.FBData[roomID]={}
end
if not self.data.FBData[roomID][entityType]then
self.data.FBData[roomID][entityType]={}
end

table.insert(self.data.FBData[roomID][entityType],addData)
end

function mysteryRoomModel:get_room_entity_birth_pos_list(roomID,entityType)
if not self.data.FBData[roomID]then
self.data.FBData[roomID]={}
end
if not self.data.FBData[roomID][entityType]then
self.data.FBData[roomID][entityType]={}
end

return self.data.FBData[roomID][entityType]
end


function mysteryRoomModel:set_pos_entity(roomID,pos,entity)
if not self.data.posEntData[roomID]then
self.data.posEntData[roomID]={}
end
local pos=table.concat({pos.x,pos.y},"_")
if not self.data.posEntData[roomID][pos]then
self.data.posEntData[roomID][pos]={}
end
self.data.posEntData[roomID][pos][entity.guid]=entity
end

function mysteryRoomModel:remove_pos_entity(roomID,pos,guid)
local pos=table.concat({pos.x,pos.y},"_")
if not self.data.posEntData[roomID][pos]then
self.data.posEntData[roomID][pos]={}
end

self.data.posEntData[roomID][pos][guid]=nil
end

function mysteryRoomModel:get_pos_entityList(roomID,ePos,notCheck)
if not self.data.posEntData[roomID]then
self.data.posEntData[roomID]={}
end
local pos=table.concat({ePos.x,ePos.y},"_")
if not self.data.posEntData[roomID][pos]then
self.data.posEntData[roomID][pos]={}
end

if not notCheck then
for guid,v in pairs(self.data.posEntData[roomID][pos])do
if not mysteryPosHelper.is_same_pos(ePos,v.pos,roomID,v.roomId)then
self.data.posEntData[roomID][pos][guid]=nil
end
end
end
return self.data.posEntData[roomID][pos]
end

function mysteryRoomModel:get_pos_entity(roomID,pos,guid)
if not self.data.posEntData[roomID]then
self.data.posEntData[roomID]={}
end
local pos=table.concat({pos.x,pos.y},"_")
if not self.data.posEntData[roomID][pos]then
self.data.posEntData[roomID][pos]={}
end
return self.data.posEntData[roomID][pos][guid]
end

function mysteryRoomModel:is_pos_have_entity(roomID,pos)
if not self.data.posEntData[roomID]then
self.data.posEntData[roomID]={}
end
local pos=table.concat({pos.x,pos.y},"_")
if not self.data.posEntData[roomID][pos]then
self.data.posEntData[roomID][pos]={}
end
local player=mysteryPlayerModel:get_player_guid()
for i,v in pairs(self.data.posEntData[roomID][pos])do
if player~=v.guid then
return true
end
end
return false
end

function mysteryRoomModel:get_pos_entityType(roomID,pos,entityType)
if not self.data.posEntData[roomID]then
self.data.posEntData[roomID]={}
end
local pos=table.concat({pos.x,pos.y},"_")
if not self.data.posEntData[roomID][pos]then
self.data.posEntData[roomID][pos]={}
end
for i,v in pairs(self.data.posEntData[roomID][pos])do
if v.entityType==entityType then
return v
end
end
end

function mysteryRoomModel:get_pos_have_entity_hidden(roomID,pos,entityType)
local model=mysteryEntityController.getModelByEntityType(entityType)
if model then
local hidden=model:get_hidden_entity_by_pos(roomID,pos)
return hidden
end
end

function mysteryRoomModel:isInitRoom()
return self.data.isInitRoom
end