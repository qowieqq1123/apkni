
storyBuildingActiveNode=simple_class(baseNode)

function storyBuildingActiveNode:broke()

end


function storyBuildingActiveNode:update(interval)
local bdId=self:getData('bdId')
local flag=self:getData('show')

local sfId=zongmenModel:getMountainId()
local buildingList=zongmenModel:getAllBuildingDataByBdType(sfId,bdId)
if buildingList then
for i,v in ipairs(buildingList)do
_MapManager.SetFadeToColor(v.entityId,Color.New(1,1,1,flag and 1 or 0),0,nil)




end
else
local data=isometricMapSystem:getRepairDataByID(sfId,bdId)
if data then
_MapManager.SetFadeToColor(data.guid,Color.New(1,1,1,flag and 1 or 0),0,nil)




end
end

return nodeState.success
end

function storyBuildingActiveNode:skip()
local bdId=self:getData('bdId')
local flag=self:getData('show')
local sfId=zongmenModel:getMountainId()
local buildingList=zongmenModel:getAllBuildingDataByBdType(sfId,bdId)
if buildingList then
for i,v in ipairs(buildingList)do
_MapManager.SetFadeToColor(v.entityId,Color.New(1,1,1,flag and 1 or 0),0,nil)




end
else
local data=isometricMapSystem:getRepairDataByID(sfId,bdId)
if data then
_MapManager.SetFadeToColor(data.guid,Color.New(1,1,1,flag and 1 or 0),0,nil)




end
end
return nodeState.success
end