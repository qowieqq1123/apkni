










aiMoveToPosByData=simple_class(aiMoveToPositionNode)

function aiMoveToPosByData:getMoveToPos()
local pos=self:getData('inPos')
local tpos=_MapManager.ToVector3Int(pos[1],pos[2],pos[3]or 0)
return tpos
end
