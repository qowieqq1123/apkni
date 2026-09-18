











aiFindunBuildingNode=simple_class(baseNode)

function aiFindunBuildingNode:update(interval)
local bdType=self:getData('bdType')
local ignore=self:getData('ignore')
local mapId=self:getData('mapId')or mapIdType.zhufeng
local ubdId=self:getData('ubdId')
local states
local ignoreMarStates=self:getData('ignoreMarStates')
if ignoreMarStates then
states={}
for i,v in ipairs(ignoreMarStates)do
table.insert(states,DISCIPLE_STATE_TYPE[v])
end
end
local datas=zongmenModel:getBuildingDataByBdIdEx(mapId,bdType,ignore,states)
local bdData=ubdId and zongmenModel:getBuildingData(ubdId)or datas[math.random(1,#datas)]
if not bdData then
return nodeState.failure
end
local key=self:getData('outId')
self:setSharedVar(key,bdData.un_build_id)
key=self:getData('outPos')
local tpos=isometricMapSystem:getDoorWayPos(bdData)
if not tpos then
return nodeState.failure
end
self:setSharedVar(key,tpos)
return nodeState.success
end