
skillSlot=simple_class(baseEntity)

function skillSlot:initialize(args)
self.earlylen=0
self.earlyWarnLookup={}
self.skillCfg=self.entityCfg
self.owner=args.owner
self.caster=args.caster
self.enemyTarget=nil
self.skillCD=self.skillCfg.cd
self.useSkillStamp=nil
self.executeCnt=nil
self.skillCommandLookup={}
skillSlot._base.initialize(self,args)
self:addPostDelete()
self:step()
end

function skillSlot:onDelete()
skillSlot._base.onDelete(self)
if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end
self.skillCommandLookup=nil

self.skillCfg=nil
self.owner=nil
self.caster=nil
self.enemyTarget=nil
self.skillCD=nil
self.useSkillStamp=nil
self.executeCnt=nil
self.range=nil
self.targetType=nil
end

function skillSlot:onUpdate()
skillSlot._base.onUpdate(self)
self:onCommandsUpdate()
end

function skillSlot:onFastUpdate()
skillSlot._base.onFastUpdate(self)
self:onCommandsFastUpdate()


if self.executeCnt then
self.executeCnt=self.executeCnt-1
if self.executeCnt<=0 then
self:initEnemyTarget()
end
end
end

function skillSlot:onPause()
skillSlot._base.onPause(self)
self:onCommandsPause()
end

function skillSlot:onContinue()
skillSlot._base.onContinue(self)
self:onCommandsContinue()
end

function skillSlot:onRemoveEntity(handle)
skillSlot._base.onRemoveEntity(self,handle)
end

function skillSlot:step()
self.range=self.skillCfg.range
if self.range<=0 then
local entityCfg=self.owner.entityCfg
self.range=airSkillSystem:getRadius(entityCfg.boundType,entityCfg.bounds)
end

self:createEarlyCollider()


self.targetType=self.skillCfg.targetType
if self.targetType then
self.executeCnt=1
end
end

function skillSlot:isCanCastSkill(ignoreCD,target)
if target==nil and self.targetType and self.enemyTarget==nil then return false end
if not ignoreCD and not self:isCoolDown()then return false end
if not self:isInRange(target)then return false end
return true
end


function skillSlot:castSkill(ignoreCD,target,args)
if not self:isCanCastSkill(ignoreCD,target)then return false end
target=target or self.enemyTarget
local command=airSkillSystem:createSkillCommmand(self.skillCfg,self.owner,self.caster,target,args,self)
self:addCommand(command)
return true
end

function skillSlot:addCommand(command)
if self:isDeleteSelf()or
self.owner:isDeleteSelf()or
self.caster:isDeleteSelf()then
return
end
self.skillCommandLookup[command.guid]=command
end


function skillSlot:isInRange(target)
target=target or self.enemyTarget
return self.earlyWarnLookup[target.handle]~=nil
end

function skillSlot:getPauseTime()
return airLevelSystem:getPauseTime()
end


function skillSlot:isCoolDown()
return self:getCoolDownTime()<=0
end

function skillSlot:getCoolDownTime()
if self.useSkillStamp==nil then return 0 end
local stamp=Time.realtimeSinceStartup
local useStamp=self:getPauseTime()+self.useSkillStamp
local costTime=stamp-useStamp
local cd=self:getCoolDown()
local left=cd-costTime
if left<=0 then return 0 end
return left
end

function skillSlot:getCoolDown()
local cd=self.skillCD
local isNormalAtk=self.skillCfg.skillType==0
if isNormalAtk then
local attackSpeed=self.caster:getAttrValue(aiAttributeType.eAttckSpeed)
if attackSpeed>=0 then
return 1/(1/cd*(1+attackSpeed/10000))
else
return 1/(1/cd/(1+math.abs(attackSpeed/10000)))
end
else
return cd
end
end


function skillSlot:createEarlyCollider()
local radius=self:getAttackRaduis()
local colliderType=eAirEntityColliderType.eCircle
local bounds={0,0,0,radius}
local layer=self.caster:getColliderLayer()
local colliderCfg=airConfig.getEntityColliderConfig(self.caster.entityType)
self:addMainCollider(layer,nil,colliderType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
end


function skillSlot:getAttackRaduis()
local radius=self.range
local addPercent=self.owner:getAttrValue(aiAttributeType.eAttckRange)
return radius*(1+addPercent/10000)
end


function skillSlot:refreshAttackCollider()
local radius=self:getAttackRaduis()
local bounds={0,0,0,radius}
local layer=self.caster:getColliderLayer()
self:setColliderBounds(layer,bounds)
end


function skillSlot:getSortingLayer()
return airConfig.getEntitySortingLayer(eAirEntityType.TYPE_SKILL)
end


function skillSlot:onTriggerEnterMonster(entity)
local handle=entity.handle
if not self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=entity
self.earlylen=self.earlylen+1
end
end

function skillSlot:onTriggerEnterRole(entity)
local handle=entity.handle
if not self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=entity
self.earlylen=self.earlylen+1
end
end

function skillSlot:onTriggerExitMonster(entity)
self:onRemoveEntity(entity.handle)
end

function skillSlot:onTriggerExitRole(entity)
self:onRemoveEntity(entity.handle)
end

function skillSlot:checkCastEnity(entity)

end


function skillSlot:setEnemyTarget(enemyTarget)
self.enemyTarget=enemyTarget
end

function skillSlot:initEnemyTarget(force)
if not force and self.enemyTarget then return end
self.enemyTarget=self:findNearestEnemyTarget(self.earlyWarnLookup)
end

function skillSlot:unbindEnemyTarget(handle)
if self.enemyTarget and self.enemyTarget.handle==handle then
self.enemyTarget=nil
end
end

function skillSlot:findNearestEnemyTarget(lookup)
if self.earlylen==0 then return end
local min
local target
for handle,ent in pairs(lookup)do
local distance=airEntitySystem:getDistance(self.caster.handle,ent.handle)
if(min==nil or distance<min)and not self:isRoleEnemyTeam(ent.teamType)then
min=distance
target=ent
end
end
return target
end

function skillSlot:onRemoveEntity(handle)
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end
self:unbindEnemyTarget(handle)
end


function skillSlot:onCommandsFastUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onFastUpdate()
end
end

function skillSlot:onCommandsUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onUpdate()
end
end

function skillSlot:onCommandsPause()
for _,command in pairs(self.skillCommandLookup)do
command:onPause()
end
end

function skillSlot:onCommandsContinue()
for _,command in pairs(self.skillCommandLookup)do
command:onContinue()
end
end

function skillSlot:onCommandDelete(guid)
self.skillCommandLookup[guid]=nil
end