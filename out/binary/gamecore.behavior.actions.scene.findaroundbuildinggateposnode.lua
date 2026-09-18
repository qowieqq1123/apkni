










findAroundBuildingGatePosNode=simple_class(baseNode)

function findAroundBuildingGatePosNode:update(interval)
local ubdId=self:getData('targetId')
local outPos1=self:getData('outPos1')
local outPos2=self:getData('outPos2')
local bdData=zongmenModel:getBuildingData(ubdId)
local rpos,lpos=isometricMapSystem:getDoorWayNBPos(bdData)
if not rpos or not lpos then
return nodeState.failure
end
self:setSharedVar(outPos1,rpos)
self:setSharedVar(outPos2,lpos)
return nodeState.success
end