







findBuildingPosNode=simple_class(baseNode)



function findBuildingPosNode:update(interval)
local data=self.data
local args=self:getArgs()
if data and data.outPos then
local buildId=data.bdId or self:getSharedVar('bdId')
if buildId then
local bdData=discipleStateManager:getBuildingData(args.dzId,self:getSharedVar('lastUbdId'))
self:setSharedVar('lastUbdId')
if bdData then
local targetPos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
if targetPos then
self:setSharedVar(data.outPos,targetPos)
if data.outId then
self:setSharedVar(data.outId,bdData.un_build_id)
self:setSharedVar('lastUbdId',bdData.un_build_id)
end
return nodeState.success
end
end
end
end
return nodeState.failure
end