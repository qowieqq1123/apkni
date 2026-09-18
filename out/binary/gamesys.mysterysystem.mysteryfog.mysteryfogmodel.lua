







mysteryFogModel={}


mysteryFogModel.data={}

function mysteryFogModel:init_data()
mysteryFogModel.data={}
mysteryFogModel.updataData={}
mysteryFogModel.roundFogCloudData={}
end


function mysteryFogModel:get_fog_data(roomID,x,y)
if not mysteryFogModel.data[roomID]then
return false
end
if not mysteryFogModel.data[roomID][x]then
return false
end
return mysteryFogModel.data[roomID][x][y]
end

function mysteryFogModel:set_fog_data(roomID,x,y,flag)
if not mysteryFogModel.data[roomID]then
mysteryFogModel.data[roomID]={}
end
if not mysteryFogModel.data[roomID][x]then
mysteryFogModel.data[roomID][x]={}
end
mysteryFogModel.data[roomID][x][y]=flag
end

function mysteryFogModel:get_fog_data_list(roomID)
if not mysteryFogModel.data[roomID]then
return
end
local fogList={}
for x,yList in pairs(mysteryFogModel.data[roomID])do
for y,flag in pairs(yList)do
if flag then
table.insert(fogList,{x,y})
end
end
end
table.sort(fogList,function(a,b)return a[1]<b[1]or(a[1]==b[1]and a[2]<b[2])end)
return fogList
end

function mysteryFogModel:clear_fog_data(roomID)
mysteryFogModel.data[roomID]=nil
end


function mysteryFogModel:set_update_fog_data(roomID,x,y,flag)
if not mysteryRoomModel:get_grid_pos_data(roomID,x,y)then
return
end
if not mysteryFogModel.updataData[roomID]then
mysteryFogModel.updataData[roomID]={}
end
if not mysteryFogModel.updataData[roomID][x]then
mysteryFogModel.updataData[roomID][x]={}
end
mysteryFogModel.updataData[roomID][x][y]=flag
end

function mysteryFogModel:get_update_fog_data_list(roomID)
if not mysteryFogModel.updataData[roomID]then
return
end
local fogList={}
for x,yList in pairs(mysteryFogModel.updataData[roomID])do
for y,flag in pairs(yList)do
if flag then
table.insert(fogList,{x,y})
end
end
end


return fogList
end

function mysteryFogModel:clear_update_fog_data(roomID)
mysteryFogModel.updataData[roomID]={}
end


function mysteryFogModel:set_round_fog_cloud_data(roomID,x,y,flag)
if not mysteryFogModel.roundFogCloudData[roomID]then
mysteryFogModel.roundFogCloudData[roomID]={}
end
if not mysteryFogModel.roundFogCloudData[roomID][x]then
mysteryFogModel.roundFogCloudData[roomID][x]={}
end
mysteryFogModel.roundFogCloudData[roomID][x][y]=flag
end

function mysteryFogModel:get_round_fog_cloud_data(roomID,x,y)
if not mysteryFogModel.roundFogCloudData[roomID]then
return false
end
if not mysteryFogModel.roundFogCloudData[roomID][x]then
return false
end
return mysteryFogModel.roundFogCloudData[roomID][x][y]
end

function mysteryFogModel:get_fog_effect_key(gridPos,layer)
local posList={gridPos.x,gridPos.y,gridPos.z}
local posKey=table.concat(posList,"_")
return FMT.fmt("{0}_{1}",layer,posKey)
end

function mysteryFogModel:set_fog_effect_id(id,gridPos,layer)
self.data.fogEffectData=self.data.fogEffectData or{}
local key=mysteryFogModel:get_fog_effect_key(gridPos,layer)
self.data.fogEffectData[key]=id
end

function mysteryFogModel:get_fog_effect_id(gridPos,layer)
if self.data.fogEffectData then
local key=mysteryFogModel:get_fog_effect_key(gridPos,layer)
return self.data.fogEffectData[key]or-1
else
return-1
end
end

function mysteryFogModel:insert_room_fog_effect(roomID,id)
self.data.fogEffectIdList=self.data.fogEffectData or{}
self.data.fogEffectIdList[roomID]=self.data.fogEffectIdList[roomID]or{}
table.insert(self.data.fogEffectIdList[roomID],id)
end

function mysteryFogModel:get_room_fog_effect(roomID)
self.data.fogEffectIdList=self.data.fogEffectData or{}
return self.data.fogEffectIdList[roomID]
end

function mysteryFogModel:clear_room_fog_effect(roomID)
self.data.fogEffectIdList=self.data.fogEffectData or{}
self.data.fogEffectIdList[roomID]={}
end

function mysteryFogModel:insert_room_fog_object(roomID,pos,id)
self.data.fogObjectIdList=self.data.fogObjectIdList or{}
self.data.fogObjectIdList[roomID]=self.data.fogObjectIdList[roomID]or{}
self.data.fogObjectIdList[roomID][pos]=id
end

function mysteryFogModel:get_room_fog_object_id(roomID,pos)
self.data.fogObjectIdList=self.data.fogObjectIdList or{}
self.data.fogObjectIdList[roomID]=self.data.fogObjectIdList[roomID]or{}
return self.data.fogObjectIdList[roomID][pos]
end

function mysteryFogModel:remove_room_fog_object(roomID,pos)
self.data.fogObjectIdList=self.data.fogObjectIdList or{}
self.data.fogObjectIdList[roomID]=self.data.fogObjectIdList[roomID]or{}
self.data.fogObjectIdList[roomID][pos]=nil
end

function mysteryFogModel:clear_room_fog_object_list(roomID)
self.data.fogObjectIdList=self.data.fogObjectIdList or{}
self.data.fogObjectIdList[roomID]={}
end

function mysteryFogModel:get_room_fog_object(roomID)
self.data.fogObjectIdList=self.data.fogObjectIdList or{}
self.data.fogObjectIdList[roomID]=self.data.fogObjectIdList[roomID]or{}
return self.data.fogObjectIdList[roomID]
end
