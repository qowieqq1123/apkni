







changeBuildingModelVisibleNode=simple_class(baseNode)

function changeBuildingModelVisibleNode:update(interval)
local mapId=self:getData('mapId')
local bdId=self:getData('bdId')
local isVisible=self:getData('isVisible')
local bdData=zongmenModel:findBuildingDataByID(mapId,bdId)
if bdData then
isometricMapSystem:changeBuildingModelVisible(bdData,isVisible)
return nodeState.success
else
logErr(FMT.fmt("行为树节点:修改建筑模型显示 出错，找不到地图id为{0} 建筑id为{1} 的建筑",mapId,bdId))
return nodeState.failure
end

end