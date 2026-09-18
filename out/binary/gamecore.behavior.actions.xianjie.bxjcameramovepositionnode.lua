






bXJCameraMovePositionNode=simple_class(baseNode)

function bXJCameraMovePositionNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJCameraMovePositionNode:update(interval)
if self.bComplete then
return nodeState.success
end


if self.isplaying then
return nodeState.running
end

local position=self:getData("position")
local duration=self:getData("duration")or 0.2
local width=self:getData("width")or 1
local height=self:getData("height")or xianjieController:getCameraPosition().y
local ease=self:getData("ease")

if position==nil then
logErr("仙界行为树 移动摄像机 坐标为空")
return nodeState.failure
end

ease=ease and DG.Tweening.Ease.IntToEnum(ease)or DG.Tweening.Ease.InQuint


local pos=Vector3(position[1],position[2],position[3])
local callback=function()
self.bComplete=true
self.isplaying=false
self:quicklyTick()
end

local cameraCurPos=xianjieController.manager:GetCameraTransform()
if cameraCurPos==nil then
logErr("未获取到摄像机坐标")
return nodeState.failure
end
if pos==cameraCurPos then
duration=0
end

if duration>0 then
self.isplaying=true
self.bComplete=false

xianjieController.manager:CameraLookAtPosition(pos,height,duration,callback,DG.Tweening.Ease.Linear,false)
return nodeState.running
else
xianjieController.manager:CameraLookAtPosition(pos,height,0,callback,DG.Tweening.Ease.Linear,false)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end