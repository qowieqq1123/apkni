








bwCameraMoveNode=simple_class(baseNode)

function bwCameraMoveNode:init()
self.isplaying=false
self.bComplete=false
end

function bwCameraMoveNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local position=self:getData("position")
local duration=self:getData("duration")or 0.2
local ease=self:getData("ease")

if position==nil then
return nodeState.failure
end

ease=ease and DG.Tweening.Ease.IntToEnum(ease)or DG.Tweening.Ease.InQuint
position=Vector3.New(position[1]or position.x,position[2]or position.y,position[3]or position.z)

if duration>0 then
self.isplaying=true
self.bComplete=false
worldController:moveCameraPosition(position,duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end,ease)
return nodeState.running
else
worldController:setCameraPosition(position,true)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end