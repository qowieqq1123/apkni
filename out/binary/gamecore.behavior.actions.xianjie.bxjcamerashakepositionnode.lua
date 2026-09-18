






bXJCameraShakePositionNode=simple_class(baseNode)

function bXJCameraShakePositionNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJCameraShakePositionNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local duration=self:getData("duration")or 0.2
local strengthX=self:getData("strengthX")or 1
local strengthZ=self:getData("strengthZ")or 1
local vibrato=self:getData("vibrato")or 10
local ease=self:getData("ease")

ease=ease and DG.Tweening.Ease.IntToEnum(ease)or DG.Tweening.Ease.Linear
local strength=Vector3.New(strengthX,0,strengthZ)

if duration>0 then
self.isplaying=true
self.bComplete=false
xianjieController:cameraDOShake(duration,strength,vibrato,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end,ease)
return nodeState.running
else
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end