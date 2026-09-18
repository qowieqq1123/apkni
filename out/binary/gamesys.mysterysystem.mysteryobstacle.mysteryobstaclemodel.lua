







mysteryObstacleModel=mysteryEntityBase.new(eMysteryEntityType.eObstacle,{})

mysteryObstacleModel.entityType=eMysteryEntityType.eObstacle

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject

mysteryObstacleModel.obstaclePosList={}

mysteryObstacleModel.obstacleBrush=
{
{groupId=0,id=-1},
{groupId=0,id=0},
}


function mysteryObstacleModel:get_config(id)
local config=cfg_secretsceneobstacleconfig_get(id)
return config
end

function mysteryObstacleModel.get_obstacle_config(id)
local config=cfg_secretsceneobstacleconfig_get(id)
return config
end



function mysteryObstacleModel:init_data()
self.obstaclePosList={}
self.obstacleByLingShou=nil
end



function mysteryObstacleModel:remove_obstacle(guid)

self:remove_entity(guid)
end



function mysteryObstacleModel:add_obstacle_pos(guid,id,pos,roomID)
if not self.obstaclePosList[roomID]then
self.obstaclePosList[roomID]={}
end
local key=mysteryPosHelper.get_pos_key(pos)
if not self.obstaclePosList[roomID][key]then
self.obstaclePosList[roomID][key]={}
mysteryObstacleModel:paint_obstacle(roomID,pos)
end
self.obstaclePosList[roomID][key][guid]=id
end

function mysteryObstacleModel:paint_obstacle(roomID,pos)
local brush=mysteryObstacleModel.obstacleBrush[2]
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local dataLayer=MysteryController.MapLayerLookUp[mapType].DataLayer
_HexMapManager.Paint(Vector3(pos.x,pos.y,pos.z),brush.groupId,brush.id,dataLayer,0)
end

function mysteryObstacleModel:erase_obstacle(roomID,pos)
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local dataLayer=MysteryController.MapLayerLookUp[mapType].DataLayer
_HexMapManager.Erase(Vector3(pos.x,pos.y,pos.z),dataLayer)
end


function mysteryObstacleModel:remove_obstacle_pos(roomID,guid,pos)
if not self.obstaclePosList[roomID]then
return
end
local key=mysteryPosHelper.get_pos_key(pos)
if not self.obstaclePosList[roomID][key]then
self.obstaclePosList[roomID][key]={}
end
self.obstaclePosList[roomID][key][guid]=nil
end

function mysteryObstacleModel:is_obstacle_pos(roomID,pos)
if not self.obstaclePosList[roomID]then
return false
end
local key=mysteryPosHelper.get_pos_key(pos)
if not self.obstaclePosList[roomID][key]then
return false
end
return next(self.obstaclePosList[roomID][key])~=nil
end



function mysteryObstacleModel:recordShowLingShouEntitypos(pos)
self.obstacleByLingShou=pos
end


function mysteryObstacleModel:ClearShowLingShouEntitypos()
self.obstacleByLingShou=nil
end

function mysteryObstacleModel:GetShowLingShouEntitypos()
return self.obstacleByLingShou
end