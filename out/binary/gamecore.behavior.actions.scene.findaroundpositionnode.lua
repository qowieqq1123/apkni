







findAroundPositionNode=simple_class(baseNode)



function findAroundPositionNode:start()












end

function findAroundPositionNode:update(interval)
local data=self.data
if data and data.inPos and data.outPos and data.radius then
local inPos=self:getSharedVar(data.inPos)
local outPos=_MapManager.FindAPosToStand(inPos,data.radius)
self:setSharedVar(data.outPos,outPos)
return nodeState.success
end
return nodeState.failure
end