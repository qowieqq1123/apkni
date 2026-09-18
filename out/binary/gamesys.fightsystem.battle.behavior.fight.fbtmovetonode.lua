


registry_pool_class(fBTNodeTypo.MoveTo,'fBTMoveToNode',fBTBaseNode)

function fBTMoveToNode:__init(guid)
self.typo=fBTNodeTypo.MoveTo
end

function fBTMoveToNode:parser(rawData)
self.moveToType=rawData[1]
self.speed=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
self.faceTo=rawData[6]
self.mustExe=rawData[7]
self.targetTypo=rawData[8]
end



local moveToTarget=1
local moveToOrg=2
local moveToID=3
local moveToPos=4
local SetToPos=5

local init_func=
{
[moveToTarget]=function(self)
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

[moveToOrg]=function(self)
self.dstPos=self.entity:getLogicPosition()
end,

[moveToID]=function(self)
local offset=self.entity:fixOffset(self.offset)
self.dstPos=fightModel:transToBattleWorld(offset)
end,

[moveToPos]=function(self)
self.offset.x=self.entity:isLeft()and self.offset.x or-self.offset.x
self.dstPos=fightModel:transToBattleWorld(self.offset)
end,

[SetToPos]=function(self)
local offset=self.entity:fixOffset(self.offset)
offset.x=self.entity:isLeft()and-offset.x or offset.x
local logicPosition=self.entity:getLogicPosition()
self.dstPos=logicPosition+offset
end,
}

local typeSelf=0
local typeExSelf=1
local typeTarget=2
local typeExSelfFriend=3
local typeExTargetFriend=4
local typeSelfLingShou=5
local typeLingShouMaster=6


function fBTMoveToNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

self.dstPos=Vector3.New(0,0,0)
local init=fBTHelper.getMoveTargetInitFunc(self.moveToType)
if init~=nil then
init(self)
end
self.isExe=false

end

function fBTMoveToNode:getTargetEntity()
local targetEntity=self.entity
if self.targetTypo~=nil then
if self.targetTypo==typeExSelf then

elseif self.targetTypo==typeTarget then

elseif self.targetTypo==typeExSelfFriend then

elseif self.targetTypo==typeExTargetFriend then

elseif self.targetTypo==typeSelfLingShou then

local selfEntId=self.entity.id
local lsEntId=selfEntId+stagePosWeight.assist
local battle=self.entity:getBattle()
if battle~=nil then
local ent=battle:getEntity(lsEntId)
if ent~=nil then
targetEntity=ent
end
end
elseif self.targetTypo==typeLingShouMaster then

local selfEntId=self.entity.id
local lsMasterEntId=selfEntId-stagePosWeight.assist
local battle=self.entity:getBattle()
if battle~=nil then
local ent=battle:getEntity(lsMasterEntId)
if ent~=nil then
targetEntity=ent
end
end
end
end
self.targetEntity=targetEntity
end

function fBTMoveToNode:start()
self:getTargetEntity()
local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
if self.targetEntity then
if self.moveToType==eMoveTargetType.moveToOrg then
self.targetEntity:flipX(self.targetEntity:isLeft())
elseif self.moveToType==eMoveTargetType.moveToTarget then
if self.targetIsLeft==self.targetEntity:isLeft()then
self.targetEntity:flipX(not self.targetEntity:isLeft())
end
end
end
end
self.isMoving=true
self.isExe=true
local curPos=self.targetEntity:getPosition()

if self.faceTo then
local pos=self.targetEntity:getPosition()
self.targetEntity:flipX(pos.x<self.dstPos.x)
end

if self.moveToType==eMoveTargetType.SetToPos then
if self.targetEntity.entObj then
self.targetEntity.entObj.transform.localPosition=self.dstPos
end

self.state=fBTNodeState.success
else
local distance=Vector3.Distance(self.dstPos,curPos)
self.duration=distance/self.speed
self.targetEntity:moveTo(self.dstPos,false,self.duration,1,onFinish)

self.state=fBTNodeState.running
end
end


function fBTMoveToNode:update(delta)
return self.state
end

function fBTMoveToNode:onEnd()

end

function fBTMoveToNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
if self.targetEntity then
self.targetEntity:moveTo(self.dstPos,false,0.1,1,nil)
else
self.entity:moveTo(self.dstPos,false,0.1,1,nil)
end
end

self.isMoving=false
end

function fBTMoveToNode:onDespawn()
if self.state~=fBTNodeState.success then
if self.targetEntity then
self.targetEntity:stopMoveTo()
else
self.entity:stopMoveTo()
end
end
self.behaviorTree=nil
self.entity=nil
self.targetEntity=nil

self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end





