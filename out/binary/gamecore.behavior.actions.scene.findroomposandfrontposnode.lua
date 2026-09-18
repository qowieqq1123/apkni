














findRoomPosAndFrontPosNode=simple_class(baseNode)

function findRoomPosAndFrontPosNode:update(interval)
local data=self.data
local args=self:getArgs()
if data and data.func and data.outPos1 and data.outPos2 then
local func=discipleStateManager[data.func]
if func then
local bdData=func(discipleStateManager,args.dzId)
if bdData then
local tpos,ipos=isometricMapSystem:getDoorWayPos(bdData)
if tpos and ipos then
if data.outId then
self:setSharedVar(data.outId,bdData.build_id)
end
self:setSharedVar(data.outPos1,tpos)
self:setSharedVar(data.outPos2,ipos)
return nodeState.success
end
end
end
end
return nodeState.failure
end