







aiFindBuildingNearbyPos=simple_class(baseNode)

function aiFindBuildingNearbyPos:update(interval)
local entityId=self:getData('entityId')

local posList=_MapManager.GetPlaceObjectNearbySpace(entityId,1)
local pos
if posList and posList.Count>0 then
pos=_MapManager.GetTheNearestPosInList(self:getArgs().stId,posList)
else
pos=_MapManager.GetTilemapObjectPosition(entityId)
end
local outkey=self:getData('outPos')
self:setSharedVar(outkey,pos)
return nodeState.success
end