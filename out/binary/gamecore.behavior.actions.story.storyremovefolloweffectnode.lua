




storyRemoveFollowEffectNode=simple_class(baseNode)

function storyRemoveFollowEffectNode:update(interval)
local npcid=self:getData('npcid')

local effecId=storyAIManager:getStoryBTBlackBoard(FMT.fmt('effect_{0}',npcid))
if effecId then
_stopEffect(effecId)
return nodeState.success
end
return nodeState.failure
end