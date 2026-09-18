








bwCameraLookAtNode=simple_class(baseNode)

function bwCameraLookAtNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwCameraLookAtNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end


local position=self:getData("position")
local unitKey=self:getData("unitKey")
local height=self:getData("height")
local duration=self:getData("duration")or 0.2
local ease=self:getData("ease")
ease=ease and DG.Tweening.Ease.IntToEnum(ease)or DG.Tweening.Ease.InQuint
if unitKey then
if duration>0 then
self.isplaying=true
self.bComplete=false
worldController:lookAtUnit_Duration(unitKey,height,duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end,ease)
return nodeState.running
else
worldController:lookAtUnit(unitKey,height,true)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
elseif position and#position==3 then
position=mathHelper.convertArrayToVector(position)
if duration>0 then
self.isplaying=true
self.bComplete=false
worldController:lookAtPosition_Duration(position,height,duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end,ease)
return nodeState.running
else
worldController:lookAtPosition(position,height,true)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end

return nodeState.failure
end