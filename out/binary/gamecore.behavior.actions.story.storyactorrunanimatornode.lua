







storyActorRunAnimatorNode=simple_class(baseNode)

function storyActorRunAnimatorNode:update(interval)
local npcid=self:getData('npcid')
local animId=self:getData('animid')

if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
_MapManager.RunAnimator(guid,animId)
return nodeState.success
end
return nodeState.failure
end