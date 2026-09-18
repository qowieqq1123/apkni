


registry_pool_class(fBTNodeTypo.RunAnimator,'fBTRunAnimatorNode',fBTBaseNode)

function fBTRunAnimatorNode:__init(guid)
self.typo=fBTNodeTypo.RunAnimator
end

function fBTRunAnimatorNode:parser(rawData)
self.stateID=rawData[1]
self.speed=rawData[2]
self.targetTypo=rawData[3]
end



local typeSelf=0
local typeExSelf=1
local typeTarget=2
local typeExSelfFriend=3
local typeExTargetFriend=4
local typeSelfLingShou=5
local typeLingShouMaster=6

function fBTRunAnimatorNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTRunAnimatorNode:start()
if self.entity~=nil then

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

if targetEntity:haveAnimExculdeModel()then
self.state=fBTNodeState.success
return
end

targetEntity:runAnimator(self.stateID,self.speed)
end
self.state=fBTNodeState.success
end


function fBTRunAnimatorNode:update(delta)
return self.state
end


function fBTRunAnimatorNode:onDespawn()
self.stateID=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end



