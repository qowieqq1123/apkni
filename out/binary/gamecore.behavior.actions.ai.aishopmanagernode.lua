


aiShopManagerNode=simple_class(baseNode)

function aiShopManagerNode:update(interval)
local currTime=timeHelper.getServerShortTime()
local nextTime=UIShopModel:getNextSelectTime()
if nextTime and currTime>=nextTime then
UIShopModel:setNextSelectTime(nextTime+5)

local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,24)
if bdData then
UIShopControl:reqExtract()
end
end

return nodeState.running
end