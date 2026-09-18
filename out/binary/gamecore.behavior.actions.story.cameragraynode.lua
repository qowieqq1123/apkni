





cameraGrayNode=simple_class(baseNode)

function cameraGrayNode:update(interval)
local gray=self:getData('gray')
_MapManager.SetCameraGray(gray)
return nodeState.success
end