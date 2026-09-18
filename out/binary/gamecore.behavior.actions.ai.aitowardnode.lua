






aiTowardNode=simple_class(baseNode)

function aiTowardNode:update(interval)
local args=self:getArgs()
local targetId=self:getData('targetKey')
local reverse=self:getData('reverse')
_MapManager.TowardToTarget(args.stId,targetId,reverse)
return nodeState.success
end