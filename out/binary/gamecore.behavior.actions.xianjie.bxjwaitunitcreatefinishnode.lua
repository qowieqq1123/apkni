






bXJWaitUnitCreateFinishNode=simple_class(baseNode)

function bXJWaitUnitCreateFinishNode:init()
self.waitTime=0
end

function bXJWaitUnitCreateFinishNode:update(interval)
local unitKey=self:getData('unitKey')
local lastWaitTime=self:getData('lastWaitTime')or 6000

self.isPlaying=true
local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
self.ent=xianjieModel:getUnit(unitKey)
if self.ent then
return nodeState.success
end
end

self.waitTime=self.waitTime+interval
if self.waitTime>lastWaitTime then
logErr(FMT.fmt('长时间未创建完成 {0}',unitKey))
return nodeState.failure
end

return nodeState.running
end