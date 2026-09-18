






storyActorSetPositionNode=simple_class(baseNode)

function storyActorSetPositionNode:update(interval)
local npcid=self:getData('npcid')
local pos=self:getData('setPos')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
local tpos=_MapManager.ToVector3Int(pos[1],pos[2],pos[3]or 0)
_MapManager.SetPosition(guid,tpos)
return nodeState.success
end
return nodeState.failure
end