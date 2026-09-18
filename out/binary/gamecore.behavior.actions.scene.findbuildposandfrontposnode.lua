







findBuildPosAndFrontPosNode=simple_class(baseNode)



function findBuildPosAndFrontPosNode:update(interval)
local data=self.data
local args=self:getArgs()
if data and data.outPos1 and data.outPos2 then
local buildId=data.bdId or self:getSharedVar('bdId')
if buildId then
local bdData=discipleStateManager:getBuildingData(args.dzId,self:getSharedVar('lastUbdId'))
self:setSharedVar('lastUbdId')
if bdData then
local tpos,ipos=isometricMapSystem:getDoorWayPos(bdData)
if tpos and ipos then
self:setSharedVar(data.outPos1,tpos)
self:setSharedVar(data.outPos2,ipos)
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