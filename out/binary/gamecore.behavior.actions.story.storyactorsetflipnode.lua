






storyActorSetFlipNode=simple_class(baseNode)

function storyActorSetFlipNode:update(interval)
local npcid=self:getData('npcid')
local flip=self:getData('flip')

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then

local isFlip=_MapManager.IsFlip(guid)
if flip~=nil and flip~=isFlip then
isometricMapSystem:flip(guid)
end
end
return nodeState.success
end