







randomFindBuildingPosNode=simple_class(baseNode)



function randomFindBuildingPosNode:start()
local data=self.data
if data and data.inPos then
local allBDData=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
if allBDData then
local temp={}
for k,v in pairs(allBDData)do
if v.build_id<901 then
table.insert(temp,v)
end
end
local rand=math.random(1,#temp)
local bdData=temp[rand]
if bdData then
local buildPos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
if buildPos then
self:setSharedVar(data.inPos,buildPos)
self.state=nodeState.success
return
end
end
end
end
self.state=nodeState.failure
end