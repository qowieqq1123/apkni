


registry_pool_class(fBTNodeTypo.CameraFocus,'fBTCameraFocusNode',fBTBaseNode)

function fBTCameraFocusNode:__init(guid)
self.typo=fBTNodeTypo.CameraFocus
end

function fBTCameraFocusNode:parser(rawData)
self.focusType=rawData[1]
self.speed=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
self.aimOffset=fBTHelper.vector3(rawData,6)
self.waitEnd=rawData[9]
self.aimEase=rawData[10]
self.targetEase=rawData[11]
self.weight=rawData[12]
end



local FocusTypeSrc=1
local FocusTypeSrcTarget=2
local FocusTypeOrg=3
local wolrdPos=4
local Focusfunc=
{
[FocusTypeSrcTarget]=function(self)
local battle=self.entity:getBattle()
local targets=self.behaviorTree:getSharedValue('targets')or{}
local num=0
local pos=Vector3.New(0,0,0)
for i,v in pairs(targets)do
local ent=battle:getEntity(v)
if ent~=nil then
pos=pos+ent:getPosition()
num=num+1
end
end
if num>0 then
pos=pos/num
else
pos=self.entity:getPosition()
end
self.duration=fightManager.focus(pos+self.offset,pos+self.aimOffset,self.speed,self.targetEase,self.aimEase)
end,

[FocusTypeSrc]=function(self)
local dstPos=self.entity:getPosition()
self.duration=fightManager.focus(dstPos+self.offset,dstPos+self.aimOffset,self.speed,self.targetEase,self.aimEase)
end,

[FocusTypeOrg]=function(self)
self.duration=fightManager.focusEntity(100,self.offset,self.aimOffset,self.speed,self.targetEase,self.aimEase)
end,

[wolrdPos]=function(self)

self.duration=fightManager.focus(fightModel:transToBattleWorld(self.offset),fightModel:transToBattleWorld(self.aimOffset),self.speed,self.targetEase,self.aimEase)
end,
}


function fBTCameraFocusNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.time=0
self.duration=0
end

function fBTCameraFocusNode:start()
self.time=0
Focusfunc[self.focusType](self)
self:setDamping(self.weight)
self.isExe=true
if self.waitEnd then
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end


function fBTCameraFocusNode:setDamping(weight)
if weight>=0 then
fightManager.setVirtualCameraDamping(weight)
end
end

function fBTCameraFocusNode:update(delta)
self.time=self.time+delta
if self.time>=self.duration then
self.state=fBTNodeState.success
end
return self.state
end

function fBTCameraFocusNode:onComplete()
self:setDamping(1)
if not self.isExe then
Focusfunc[self.focusType](self)
end
end


