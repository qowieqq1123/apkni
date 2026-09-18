








bwCameraEnableNode=simple_class(baseNode)

function bwCameraEnableNode:init()
self.enable=nil
self.resume=nil
end

function bwCameraEnableNode:update(interval)
self.enable=self:getData('enable')
self.resume=self:getData('resume')

if self.enable~=nil then
if self.enable then
worldController:resumeCameraControl()
else
worldController:stopCameraControl()
end
return nodeState.success
else
return nodeState.failure
end
end

function bwCameraEnableNode:broke()

if self.resume~=nil then
if self.resume then
worldController:resumeCameraControl()
else
worldController:stopCameraControl()
end
end
end