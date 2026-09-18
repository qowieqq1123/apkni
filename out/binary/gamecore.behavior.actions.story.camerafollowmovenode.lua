





cameraFollowMoveNode=simple_class(baseNode)

function cameraFollowMoveNode:broke()
_MapManager.SetCameraFollowTarget(-1)
end

function cameraFollowMoveNode:update(interval)
local npcid=self:getData('npcid')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
_MapManager.SetCameraFollowTarget(guid)
return nodeState.success
end
return nodeState.failure
end