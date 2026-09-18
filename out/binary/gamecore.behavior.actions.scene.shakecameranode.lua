







shakeCameraNode=simple_class(baseNode)

function shakeCameraNode:init()
self.playing=false
self.bComplete=false
end

function shakeCameraNode:broke()
if self.tweener then
self.tweener:Rewind()
self.tweener:Kill()
self.tweener=nil
end
end

function shakeCameraNode:update(interval)
if self.playing then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local duration=self:getData('duration')
local strength=self:getData('strength')
local vibrato=self:getData('vibrato')
strength=Vector3.New(strength[1],strength[2],strength[3]or 0)
self.playing=true
self.tweener=isometricMapSystem:shakeSceneCamera(duration,strength,vibrato,function()
self.playing=false
self.bComplete=true
self.tweener=nil
self:quicklyTick()
end)
return nodeState.running
end