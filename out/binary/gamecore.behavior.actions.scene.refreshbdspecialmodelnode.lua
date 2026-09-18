







refreshBDSpecialModelNode=simple_class(baseNode)

function refreshBDSpecialModelNode:update(interval)
local bdId=self:getData('bdId')
local isRepair=self:getData('isRepair')
local mapId=self:getData('mapId')
if isRepair then
local data=isometricMapSystem:getRepairDataByID(mapId,bdId)
if data then
if isometricMapSystem:hasSpecialModel(data.guid)then
isometricMapSystem:change3DModel(data.bdData)
else
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
isometricMapSystem:showSpecialModel(data.guid,bdcfg,0,true)
end
return nodeState.success
end
else
local bdData=zongmenModel:findBuildingDataByID(mapId,bdId)
if bdData then
isometricMapSystem:change3DModel(bdData)
return nodeState.success
end
end
return nodeState.failure
end