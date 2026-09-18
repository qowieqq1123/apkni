







findRepairBuildingNode=simple_class(baseNode)

function findRepairBuildingNode:update(interval)
local mapId=self:getData('mapId')
local bdId=self:getData('bdId')
local data=isometricMapSystem:getRepairDataByID(mapId,bdId)
if not data then
logErr('无法找到修复建筑，请确保该建筑存在',mapId,bdId)
return nodeState.failure
end
local key=self:getData('outKey')
self:setSharedVar(key,data.guid)
return nodeState.success
end