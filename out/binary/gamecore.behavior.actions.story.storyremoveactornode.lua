





storyRemoveActorNode=simple_class(baseNode)

function storyRemoveActorNode:update(interval)
local npcid=self:getData('npcid')

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
_MapManager.RemoveTilemapObject(guid)
return nodeState.success
end
return nodeState.failure
end