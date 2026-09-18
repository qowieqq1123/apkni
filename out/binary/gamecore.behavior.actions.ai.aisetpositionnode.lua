





aiSetPositionNode=simple_class(baseNode)

function aiSetPositionNode:update(interval)
local pos=self:getData('inPos')
local args=self:getArgs()
local tpos=_MapManager.ToVector3Int(pos[1],pos[2],pos[3]or 0)
_MapManager.SetPosition(args.stId,tpos)
return nodeState.success
end
