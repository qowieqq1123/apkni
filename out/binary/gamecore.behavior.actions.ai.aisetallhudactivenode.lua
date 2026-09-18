





aiSetAllHUDActiveNode=simple_class(baseNode)

function aiSetAllHUDActiveNode:update(interval)
local args=self:getArgs()
local bActive=self:getData('bActive')
hudControl:setHUDActiveByTarget(args.stId,bActive)
return nodeState.success
end