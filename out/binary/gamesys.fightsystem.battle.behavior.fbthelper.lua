fBTHelper={}

fBTHelper.posOffset=Vector3.New(0,0,-0.4)

function fBTHelper.vector3(rawData,index)
return Vector3.New(rawData[index],rawData[index+1],rawData[index+2])
end


function fBTHelper.color4(rawData,index)
return Color.New(rawData[index],rawData[index+1],rawData[index+2],rawData[index+3])
end

function fBTHelper.listVector3(rawData,index)
local data=rawData[index]
local lst={}
for i,v in ipairs(data)do
lst[#lst+1]=Vector3.New(v[1],v[2],v[3])
end

return lst;

end


ePosTypo=
{
Self=1,
TargetCenter=2,
TargetRow=3,
SelfRow=4,
Hited=5,
TargetTeam=6,
Center=7,
TargetTeamUnit=8,
}

local _FetchFightStagePosFunc=
{
[ePosTypo.Self]=function(self)
return self.entity:getPosition(),self.entity:isLeft()
end,

[ePosTypo.TargetCenter]=function(self)
local battle=self.entity:getBattle()
local targets=self.behaviorTree:getSharedValue('targets')or{}
local num=0
local pos=Vector3.New(0,0,0)
local left=false
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
return pos,self.entity:isLeft()
end,

[ePosTypo.TargetRow]=function(self)
local battle=self.entity:getBattle()
local targets=self.behaviorTree:getSharedValue('targets')or{}
for i,v in pairs(targets)do
local ent=battle:getEntity(v)
if ent~=nil then
return ent:getRowPostion(),self.entity:isLeft()
end
end

return self.entity:getPosition(),self.entity:isLeft()
end,

[ePosTypo.SelfRow]=function(self)
return self.entity:getRowPostion(),not self.entity:isLeft()
end,

[ePosTypo.Hited]=function(self)
return self.entity:getHitedPos(),not self.entity:isLeft()
end,
[ePosTypo.TargetTeam]=function(self)
local battle=self.entity:getBattle()
local targets=self.behaviorTree:getSharedValue('targets')or{}
local num=0
local pos=Vector3.New(0,0,0)
local left=false
local target=next(targets)
if target then
local ent=battle:getEntity(target)
if ent~=nil then
left=ent:isLeft()
end
else
left=self.entity:isLeft()
end
if left then
for i=1,5 do
local ent=battle:getEntity(i)
if ent~=nil then
pos=pos+ent:getPosition()
num=num+1
end
end
else
for i=6,10 do
local ent=battle:getEntity(i)
if ent~=nil then
pos=pos+ent:getPosition()
num=num+1
end
end
end
if num>0 then
pos=pos/num
else
pos=self.entity:getPosition()
end
return pos,self.entity:isLeft()
end,
[ePosTypo.Center]=function(self)
return fightModel:transToBattleWorld(Vector3.zero),self.entity:isLeft()
end,
[ePosTypo.TargetTeamUnit]=function(self)
local battle=self.entity:getBattle()
local targets=self.behaviorTree:getSharedValue('targets')or{}
local num=0
local posList={}
local left=false
local target=next(targets)
if target then
local ent=battle:getEntity(target)
if ent~=nil then
left=ent:isLeft()
end
else
left=self.entity:isLeft()
end
if left then
for i=1,5 do
local ent=battle:getEntity(i)
if ent~=nil then
table.insert(posList,ent:getPosition())
num=num+1
end
end
else
for i=6,10 do
local ent=battle:getEntity(i)
if ent~=nil then
table.insert(posList,ent:getPosition())
num=num+1
end
end
end
if num==0 then
posList=table.insert(posList,self.entity:getPosition())
end
return posList,self.entity:isLeft()
end,
}

function fBTHelper.getEffectPos(node,typo)
local fun=_FetchFightStagePosFunc[typo]
return fun(node)
end

function fBTHelper.fixOffset(left,offset)
if not left then
offset.x=0-offset.x
end

return offset
end

local moveToTarget=1
local moveToOrg=2
local moveToID=3
local moveToPos=4
local SetToPos=5

eMoveTargetType=
{
moveToTarget=1,
moveToOrg=2,
moveToID=3,
moveToPos=4,
SetToPos=5
}

local init_moveTarget_func=
{
[eMoveTargetType.moveToTarget]=function(self)
local battle=self.entity:getBattle()
local targets=self.behaviorTree:getSharedValue('targets')or{}
local num=0
local pos=self.dstPos
for i,v in pairs(targets)do
local ent=battle:getEntity(v)
if ent~=nil then
pos=pos+ent:getAttackPosition(self.entity)
num=num+1
self.targetIsLeft=ent:isLeft()
end
end
if num>0 then
pos=pos/num
else
pos=self.entity:getAttackPosition(self.entity)
end
local offset=self.entity:fixOffset(self.offset)
offset.x=0-offset.x
self.dstPos=pos+offset
end,

[eMoveTargetType.moveToOrg]=function(self)
self.dstPos=self.entity:getLogicPosition()
end,

[eMoveTargetType.moveToID]=function(self)
local offset=self.entity:fixOffset(self.offset)
self.dstPos=fightModel:transToBattleWorld(offset)
end,

[eMoveTargetType.moveToPos]=function(self)
self.offset.x=self.entity:isLeft()and self.offset.x or-self.offset.x
self.dstPos=fightModel:transToBattleWorld(self.offset)
end,

[eMoveTargetType.SetToPos]=function(self)
local offset=self.entity:fixOffset(self.offset)
offset.x=self.entity:isLeft()and-offset.x or offset.x
local logicPosition=self.entity:getLogicPosition()
self.dstPos=logicPosition+offset
end
}

function fBTHelper.getMoveTargetInitFunc(typo)
return init_moveTarget_func[typo]
end