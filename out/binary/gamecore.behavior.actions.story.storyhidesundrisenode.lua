








storyHideSundriseNode=simple_class(baseNode)

function storyHideSundriseNode:broke()
local sundriseId=self:getData('sundriseId')
if sundriseId then
local mapId=self:getData('mapId')or zongmenModel:getMountainId()
local data=isometricMapSystem:findSundriesByID(mapId,sundriseId)
if data then
_MapManager.SetTilemapObjectActive(data.guid,true)
end
end
end

function storyHideSundriseNode:update(interval)
local sundriseId=self:getData('sundriseId')
local flag=self:getData('flag')
local mapId=self:getData('mapId')or zongmenModel:getMountainId()
local data=isometricMapSystem:findSundriesByID(mapId,sundriseId)
if data then
_MapManager.SetTilemapObjectActive(data.guid,flag)
end
return nodeState.success
end