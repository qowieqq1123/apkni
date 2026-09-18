







setPositionNode=simple_class(baseNode)



function setPositionNode:update(interval)
local data=self.data
if data and data.setPos then
local targetPos=self:getSharedVar(data.setPos)
local args=self:getArgs()
_MapManager.SetPosition(args.stId,targetPos)
return nodeState.success
end
return nodeState.failure
end