


registry_pool_class(fBTNodeTypo.ShowShadow,'fBTShowShadowNode',fBTBaseNode)

function fBTShowShadowNode:__init(guid)
self.typo=fBTNodeTypo.ShowShadow
end

function fBTShowShadowNode:parser(rawData)
self.opType=rawData[1]
self.targetTypo=rawData[2]
self.mustExe=rawData[3]
end



local typeSelf=0
local typeExSelf=1
local typeTarget=2
local typeExSelfFriend=3
local typeExTargetFriend=4


local op_open=1
local op_hide=2
function fBTShowShadowNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.isExe=false
end


function fBTShowShadowNode:start()
self:opShow()
self.state=fBTNodeState.success
end

function fBTShowShadowNode:opShow()
self.isExe=true

if self.targetTypo==typeTarget then
local targets=self.behaviorTree:getSharedValue('targets')or{}
local battle=self.entity:getBattle()
for i,v in pairs(targets)do
if battle~=nil then
local ent=battle:getEntity(v)
if ent~=nil then
self:updateShadow(ent)
end
end
end
elseif self.targetTypo==typeExSelf then
local battle=self.entity:getBattle()
local entities=battle:getEntities()
for i,ent in pairs(entities)do
if ent~=self.entity then
self:updateShadow(ent)
end
end
elseif self.targetTypo==typeExSelfFriend then
local battle=self.entity:getBattle()
local entities=battle:getEntities()
local isLeft=fightModel:isLeft(self.entity.id)
for i,ent in pairs(entities)do
if(ent~=self.entity)and fightModel:isLeft(ent.id)==isLeft then
self:updateShadow(ent)
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
for _,targetid in pairs(targets)do
local target=battle:getEntity(targetid)
local isTargetLeft=fightModel:isLeft(target.id)
if ent.id==target.id or isLeft~=isTargetLeft then
isFade=false
end
end
if isFade then
self:updateShadow(ent)
end
end
end
else
if self.opType==op_open then
self.entity:showShadow(true)
elseif self.opType==op_hide then
self.entity:showShadow(false)
end
end
end

function fBTShowShadowNode:updateShadow(ent)
if self.opType==op_open then
ent:showShadow(true)
elseif self.opType==op_hide then
ent:showShadow(false)
end
end
function fBTShowShadowNode:update(delta)

return self.state
end

function fBTShowShadowNode:onComplete()
if self.mustExe and not self.isExe then
self:opShow()
end
end

function fBTShowShadowNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

