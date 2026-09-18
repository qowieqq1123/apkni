








bwCameraAngleMoveNode=simple_class(baseNode)

function bwCameraAngleMoveNode:init()
self.isplaying=false
self.bComplete=false
end

function bwCameraAngleMoveNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local position=self:getData("position")
local angle=self:getData("angle")
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
local tick=function()
worldController:markCameraViewChange()
end
local finish=function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end
local cTF=worldController:getCameraTransform()
local seq=Lua.SequenceProxy.New()
local tweener1=Lua.DOTweenProxyExtensions.DOMove(cTF,position,duration)
seq:Join(tweener1)
local tweener2=Lua.DOTweenProxyExtensions.DORotate(cTF,Vector3.right*angle,duration)
seq:Join(tweener1)
seq:SetEase(ease)
seq:OnUpdate(tick)
seq:OnComplete(finish)
return nodeState.running
else
local cTF=worldController:getCameraTransform()
cTF.position=position
cTF.rotation=Quaternion.Euler(Vector3.right*angle)
worldController:markCameraViewChange()
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end