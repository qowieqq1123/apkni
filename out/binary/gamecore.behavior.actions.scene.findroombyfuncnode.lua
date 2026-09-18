







findRoomByFuncNode=simple_class(baseNode)



function findRoomByFuncNode:update(interval)
local data=self.data
local args=self:getArgs()
if data and data.func and data.outPos then
local func=discipleStateManager[data.func]
if func then
local bdData=func(discipleStateManager,args.dzId)
if bdData then
local targetPos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
if targetPos then
if data.outId then
self:setSharedVar(data.outId,bdData.build_id)
end
self:setSharedVar(data.outPos,targetPos)
return nodeState.success
end
end
end
end
return nodeState.failure
end