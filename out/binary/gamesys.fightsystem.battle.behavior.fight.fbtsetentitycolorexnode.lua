


registry_pool_class(fBTNodeTypo.SetEntityColorEx,'fBTSetEntityColorExNode',fBTBaseNode)

function fBTSetEntityColorExNode:__init(guid)
self.typo=fBTNodeTypo.SetEntityColorEx
end

function fBTSetEntityColorExNode:parser(rawData)
self.targetTypo=rawData[1]
self.color=fBTHelper.color4(rawData,2)
self.duration=rawData[6]
self.mustExt=rawData[7]
end



local typeSelf=0
local typeExSelf=1
local typeTarget=2
local typeExSelfFriend=3
local typeExTargetFriend=4
local typeSelfLingShou=5
local typeLingShouMaster=6


function fBTSetEntityColorExNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTSetEntityColorExNode:start()
self.hasExed=false
self:fadeToColor()
self.state=fBTNodeState.success
end

function fBTSetEntityColorExNode:fadeToColor()
if self.hasExed then
return
end

self.hasExed=true
if self.targetTypo==typeTarget then
local targets=self.behaviorTree:getSharedValue('targets')or{}
local battle=self.entity:getBattle()
for i,v in pairs(targets)do
if battle~=nil then
local ent=battle:getEntity(v)
if ent~=nil then
ent:fadeToColor(self.color,self.duration)
if ent.hud then
if self.color.a==0 then
if ent.hud then
ent.hud:fade(self.duration,0)
end
else
if ent.hud then
ent.hud:fade(self.duration,1)
end
end
end
end
end
end
elseif self.targetTypo==typeExSelf then
local battle=self.entity:getBattle()
local entities=battle:getEntities()
for i,ent in pairs(entities)do
local isFade=false
if ent~=self.entity then
local isLingShou=ent:checkIsLingShou()
local isSummonLs=ent:checkIsSummonLingShou()
if not isLingShou or isSummonLs then

isFade=true
end
end

if isFade then
ent:fadeToColor(self.color,self.duration)
end
end
elseif self.targetTypo==typeExSelfFriend then
local battle=self.entity:getBattle()
local entities=battle:getEntities()
local isLeft=fightModel:isLeft(self.entity.id)
for i,ent in pairs(entities)do
local isFade=false
if(ent~=self.entity)and fightModel:isLeft(ent.id)==isLeft then
local isLingShou=ent:checkIsLingShou()
local isSummonLs=ent:checkIsSummonLingShou()
if not isLingShou or isSummonLs then

isFade=true
end
end

if isFade then
ent:fadeToColor(self.color,self.duration)
end
end
elseif self.targetTypo==typeExTargetFriend then
local targets=self.behaviorTree:getSharedValue('targets')or{}
if next(targets)then
local battle=self.entity:getBattle()
local entities=battle:getEntities()
for i,ent in pairs(entities)do
local isFade=true
local isLeft=fightModel:isLeft(ent.id)
local isLingShou=ent:checkIsLingShou()
local isSummonLs=ent:checkIsSummonLingShou()
if isLingShou and not isSummonLs then

isFade=false
end

if isFade then
for _,targetid in pairs(targets)do
local target=battle:getEntity(targetid)
if target then
local isTargetLeft=fightModel:isLeft(target.id)
if ent.id==target.id or isLeft~=isTargetLeft then
isFade=false
end
end
end
end

if isFade then
ent:fadeToColor(self.color,self.duration)
end
end
end
elseif self.targetTypo==typeSelfLingShou then
local selfEntId=self.entity.id
local lsEntId=selfEntId+stagePosWeight.assist
local battle=self.entity:getBattle()
if battle~=nil then
local ent=battle:getEntity(lsEntId)
if ent~=nil then
ent:fadeToColor(self.color,self.duration)
end
end
elseif self.targetTypo==typeLingShouMaster then

local selfEntId=self.entity.id
local lsMasterEntId=selfEntId-stagePosWeight.assist
local battle=self.entity:getBattle()
if battle~=nil then
local ent=battle:getEntity(lsMasterEntId)
if ent~=nil then
ent:fadeToColor(self.color,self.duration)
end
end
else
self.entity:fadeToColor(self.color,self.duration)
end
end

function fBTSetEntityColorExNode:update(delta)

return self.state
end

function fBTSetEntityColorExNode:onComplete()

if self.mustExt then
self:fadeToColor()
end
end

function fBTSetEntityColorExNode:onDespawn()
self.hasExed=false
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

