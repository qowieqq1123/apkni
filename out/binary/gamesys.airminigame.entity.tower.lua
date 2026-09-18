
tower=simple_class(summon)

function tower:initialize(args)
tower._base.initialize(self,args)

self.earlylen=0
self.earlyWarnLookup={}


self:setCanMove(false)
self.entity.SupportDIR=false
self.entity.SupportDIRAnimation=false
self.entity.TurnSpeed=0

self:createCollider()
self:addPostDelete()
self:lookAtCamera()
end

function tower:onDelete()
if self==nil or self:isDeleteSelf()then return end
if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end
tower._base.onDelete(self)
self.earlylen=nil
self.earlyWarnLookup=nil
end

function tower:onUpdate()
tower._base.onUpdate(self)
self:refreshFlipX()
end

function tower:onFastUpdate()
tower._base.onFastUpdate(self)
self:initCasterTarget()
if self:isCanCastSkill()then
if self:castSkill()then return end
end
end

function tower:onPause()
tower._base.onPause(self)
end

function tower:onContinue()
tower._base.onContinue(self)
end

function tower:onRemoveEntity(handle)
tower._base.onRemoveEntity(self,handle)
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end
if self:isCurrentEnemyTarget(handle)then
self:unbindCasterTarget()
end
end

function tower:onStartLevel()
tower._base.onStartLevel(self)
self.useSkillStamp=nil
end


function tower:onTriggerEnterMonster(entity)
local handle=entity.handle
if not self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=entity
self.earlylen=self.earlylen+1
end
end

function tower:onTriggerExitMonster(entity)
local handle=entity.handle
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end

if self:isCurrentEnemyTarget(handle)then
self:unbindCasterTarget()
end
end

function tower:onTriggerEnterRole(entity)
local handle=entity.handle
if not self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=entity
self.earlylen=self.earlylen+1
end
end

function tower:onTriggerExitRole(entity)
local handle=entity.handle
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end

if self:isCurrentEnemyTarget(handle)then
self:unbindCasterTarget()
end
end



function tower:getRoleColliderLayer()
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
return colliderCfg.roleLayer
end

function tower:createCollider()
local skillCfg=self.skillCfg
local mActionId=skillCfg.mActionId
local resultType=cfgHelper.get2(cfg_airskillactionconfig_get,mActionId,'resultType')
local hasMonsterCollider=false
local hasRoleCollider=false
if resultType==1 then
hasMonsterCollider=true
elseif resultType==2 then
hasRoleCollider=true
end
for i=1,5 do
local str=string.format('mActionId_%d',i)
local id=skillCfg[str]
if id then
local resultType=cfgHelper.get2(cfg_airskillactionconfig_get,id,'resultType')
if resultType==1 then
hasMonsterCollider=true
elseif resultType==2 then
hasRoleCollider=true
end
end
end

if hasMonsterCollider then
self:createMonsterCollider()
end
if hasRoleCollider then
self:createRoleCollider()
end
end


function tower:initCasterTarget()
if self.casterTarget then return end
local target=self:findNearestTarget()
if target==nil then return end
self:bindCasterTarget(target)
end

function tower:bindCasterTarget(ent)
self.casterTarget=ent
local handle=ent.handle
self.entity:BindEntity(handle)
end

function tower:unbindCasterTarget()
self.entity:UnBindEntity()
self.casterTarget=nil
self:initCasterTarget()
end

function tower:findNearestTarget()
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

function tower:isCurrentEnemyTarget(handle)
return self.casterTarget and self.casterTarget.handle==handle or false
end

function tower:refreshFlipX()
if self.casterTarget then
local posX=self.casterTarget:getPosition().x
local x=self:getPosition().x
local flipX=posX>x
self:setFlipX(flipX)
end
end

function tower:setSortingGroup(layer)
self.staticAuto.BaseEntity_SetSortingGroup(self.handle,layer,airActorSystem:getOrder())
end

function tower:getSortingOrder()
return airActorSystem:getOrder()
end
