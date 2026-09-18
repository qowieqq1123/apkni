
cameraOverFollowMoveNode=simple_class(baseNode)

function cameraOverFollowMoveNode:update(interval)
_MapManager.SetCameraFollowTarget(-1)
return nodeState.success
end