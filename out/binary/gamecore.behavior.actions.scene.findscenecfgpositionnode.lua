







findSceneCfgPositionNode=simple_class(baseNode)



function findSceneCfgPositionNode:update(interval)
local data=self.data
if data and data.stateId and data.outPos then
local config=cfgHelper.get1(cfg_disciplesceneconfig_get,data.stateId)
if config then
local sfId=zongmenModel:getMountainId()
local positions=config.positions[sfId]
if positions then
local len=#positions
local index=1
if len>1 then
index=math.random(1,len)
end
local position=positions[index]
if position then
local targetPos=_MapManager.ToVector3Int(position[1],position[2],0)
if _MapManager.IsCanMove(targetPos)then
self:setSharedVar(data.outPos,targetPos)
return nodeState.success
end
end
end
end
end
return nodeState.failure
end