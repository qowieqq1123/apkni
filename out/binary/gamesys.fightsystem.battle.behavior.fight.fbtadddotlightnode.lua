


registry_pool_class(fBTNodeTypo.AddDotLight,'fBTAddDotLightNode',fBTBaseNode)

function fBTAddDotLightNode:__init(guid)
self.typo=fBTNodeTypo.AddDotLight
end

function fBTAddDotLightNode:parser(rawData)
self.posType=rawData[1]
self.duraion=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
self.srcRadius=rawData[6]
self.dstRadius=rawData[7]
self.srcColor=fBTHelper.color4(rawData,8)
self.dstColor=fBTHelper.color4(rawData,12)
self.srcBlackColor=fBTHelper.color4(rawData,16)
self.dstBlackColor=fBTHelper.color4(rawData,20)
self.waitEnd=rawData[24]
end



local PosTypeSrc=1
local PosTypeTarget=2

local AddTypofunc=
{
[PosTypeTarget]=function(self)
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
fightManager.setDotLight(self.duraion,pos+self.offset,self.srcRadius,self.dstRadius,self.srcColor,self.dstColor,self.srcBlackColor,self.dstBlackColor)
end,

[PosTypeSrc]=function(self)
local dstPos=self.entity:getPosition()
fightManager.setDotLight(self.duraion,dstPos+self.offset,self.srcRadius,self.dstRadius,self.srcColor,self.dstColor,self.srcBlackColor,self.dstBlackColor)
end,
}


function fBTAddDotLightNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.time=0
end

function fBTAddDotLightNode:start()

self.time=0

AddTypofunc[self.posType](self)
if self.waitEnd then
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end


function fBTAddDotLightNode:update(delta)

self.time=self.time+delta
if self.time>=self.duraion then
self.state=fBTNodeState.success
end
return self.state
end


