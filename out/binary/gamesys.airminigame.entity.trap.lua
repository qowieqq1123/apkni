
trap=simple_class(summon)

function trap:initialize(args)
trap._base.initialize(self,args)

self.earlylen=0
self.earlyWarnLookup={}


self:setCanMove(false)
self.entity.SupportDIR=false
self.entity.SupportDIRAnimation=false
self.entity.TurnSpeed=0

self:createMonsterCollider()
end

function trap:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
trap._base.onDelete(self)
if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end
self.earlylen=nil
self.earlyWarnLookup=nil
end

function trap:onUpdate()
trap._base.onUpdate(self)
self:refreshFlipX()
end

function trap:onFastUpdate()
trap._base.onFastUpdate(self)

if self:isCanCastSkill()then
if self:castSkill()then return end
end
self:initCasterTarget()
end

function trap:onPause()
trap._base.onPause(self)
end

function trap:onContinue()
trap._base.onContinue(self)
end

function trap:onRemoveEntity(handle)
trap._base.onRemoveEntity(self,handle)
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end
if self:isCurrentEnemyTarget(handle)then
self:unbindCasterTarget()
end
if handle==self.owner.handle then
self.owner=nil
self:deleteEntity()
end
end

function trap:onStartLevel()
trap._base.onStartLevel(self)
self.useSkillStamp=nil
end


function trap:onTriggerEnterMonster(entity)
local handle=entity.handle
if not self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=entity
self.earlylen=self.earlylen+1
end
end

function trap:onTriggerExitMonster(entity)
local handle=entity.handle
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end

if self:isCurrentEnemyTarget(handle)then
self:unbindCasterTarget()
end
end


function trap:initCasterTarget()
if self.casterTarget then return end
local target=self:findNearestTarget()
if target==nil then return end
self:bindCasterTarget(target)
end

function trap:bindCasterTarget(ent)
self.casterTarget=ent
local handle=ent.handle
self.entity:BindEntity(handle)
end

function trap:unbindCasterTarget()
self.entity:UnBindEntity()
self.casterTarget=nil
self:initCasterTarget()
end

function trap:findNearestTarget()
if self.earlylen==0 or self.owner==nil or self.owner:isDeleteSelf()then return end
local min
local target
for handle,ent in pairs(self.earlyWarnLookup)do
local distance=self.managerStatic.EntityDistance2D(handle,ent.handle)
if(min==nil or distance<min)then
min=distance
target=ent
end
end
return target
end

function trap:isCurrentEnemyTarget(handle)
return self.casterTarget and self.casterTarget.handle==handle or false
end

function trap:refreshFlipX()
if self.casterTarget then
local posX=self.casterTarget:getPosition().x
local x=self:getPosition().x
local flipX=posX>x
self:setFlipX(flipX)
end
end

function trap:setSortingGroup(layer)
self.staticAuto.BaseEntity_SetSortingGroup(self.handle,layer,airActorSystem:getOrder())
end

function trap:getSortingOrder()
return airActorSystem:getOrder()
end
