
weapon=simple_class(baseEntity)
local _remove=table.remove

function weapon:initialize(args)
self.owner=args.owner
self.weaponId=self.entityCfg.id
self.target=nil
self.earlylen=0
self.earlyWarnLookup={}
self.enemyTarget=nil
self.turnSpeed=self.entityCfg.turnSpeed

self.useSkillStamp=0

self.waitAnimTime=0

self.skillCommandLookup={}


local lockTarget=self.entityCfg.lockTarget
self.entity.SupportDIR=lockTarget==true
self.entity.SupportDIRAnimation=lockTarget==true
self.entity.TurnSpeed=self.turnSpeed

self.managerStatic.SetEntityZRotationMode(self.handle,30)
self:initAttrs()
self:createEarlyWarnCollider()
self:createAssetByCfg()
self:initEnemyTarget()
self:initSkill()
self:addPostDelete()
end

function weapon:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
self:setAssetActive(true)
self._base.onDelete(self)
if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end
self.owner=nil
self.weaponId=nil
self.target=nil
self.earlylen=nil
self.earlyWarnLookup=nil
self.enemyTarget=nil
self.turnSpeed=nil
self.skillid=nil
self.useSkillStamp=nil
self.skillCommandLookup=nil
end

function weapon:onUpdate()
self:onCommandsUpdate()
end

function weapon:onFastUpdate()
self:onCommandsFastUpdate()

if self:isCanCastSkill()then
if self:castSkill()then return end
end
self:initEnemyTarget()

if not self.enemyTarget then
self:setZRotationByOwner()
end
end

function weapon:onPause()
self._base.onPause(self)
self:onCommandsPause()
end

function weapon:onContinue()
self._base.onContinue(self)
self:onCommandsContinue()
end

function weapon:onRemoveEntity(handle)
weapon._base.onRemoveEntity(self,handle)
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end
if handle==self.owner.handle then
self.owner=nil
end
if self:isCurrentEnemyTarget(handle)then
self:unbindEnemyTarget()
end
end

function weapon:onStartLevel()
weapon._base.onStartLevel(self)
self.useSkillStamp=nil
end

function weapon:initAttrs()
self.curAttrs=table.deepCopy(self.entityCfg.attackAttrs)or{}
end

function weapon:getBaseAttrValue(attributeType)
return self.curAttrs[attributeType]or 0
end

function weapon:getAttrValue(attributeType,really)
if self.owner==nil or self.owner:isDeleteSelf()then return 0 end
local cfg=cfg_airattributesconfig_get(attributeType)
local isAttack=cfg.attack==true
local value=self:getBaseAttrValue(attributeType)
if isAttack then
value=value+self.owner:getBaseAttrValue(attributeType)
local value_p=0
if value_p~=0 then
if airConfig.isAttr_P(attributeType)then
value=value+value_p
else
value=value+math.floor(value*value_p/10000)
end
end
end
if not really then
value=self.owner:clampAttr(attributeType,value)
end
return value
end

function weapon:onMissSkillAction(entity,skillid,actionid,isPenetrate)

end



function weapon:onTriggerEnterMonster(entity)
local handle=entity.handle
if not self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=entity
self.earlylen=self.earlylen+1
end
end

function weapon:onTriggerExitMonster(entity)
local handle=entity.handle
if self.earlyWarnLookup[handle]then
self.earlyWarnLookup[handle]=nil
self.earlylen=self.earlylen-1
end

if self:isCurrentEnemyTarget(handle)then
self:unbindEnemyTarget()
end
end




function weapon:initEnemyTarget()
if self.enemyTarget then return end
local target=self:findOwnerNearestEnemyTarget()
if target==nil then return end
self:bindEnemyTarget(target)
end

function weapon:bindEnemyTarget(ent)
self.enemyTarget=ent
local handle=ent.handle
self.entity:BindEntity(handle)

end

function weapon:unbindEnemyTarget()
self.entity:UnBindEntity()
if self.enemyTarget then
airHUDSystem:deleteEntityHUD(self.enemyTarget.handle,eHudType.eTarget)
end
self.enemyTarget=nil
self:setZRotationByOwner()
self:initEnemyTarget()
end

function weapon:setZRotationByOwner()
if airController:getRealServerTime_short()>self.waitAnimTime then
self.entity:SetZRotation(self.owner.moveDir)
end
end

function weapon:findOwnerNearestEnemyTarget()
if self.earlylen==0 or self.owner==nil or self.owner:isDeleteSelf()then return end
return self.owner:findNearestEnemyTarget(self.earlyWarnLookup)
end

function weapon:isCurrentEnemyTarget(handle)
return self.enemyTarget and self.enemyTarget.handle==handle or false
end

function weapon:hasEnemyTarget()
return self.enemyTarget and not self.enemyTarget:isDeleteSelf()or false
end

function weapon:setAnimWaitTime(time)
self.waitAnimTime=airController:getRealServerTime_short()+time
end

function weapon:createAssetByCfg()
self:createSpineByCfg()
self:createSpriteByCfg()
self:setFlipX(self.entityCfg.flipX==1)
end

function weapon:isFlipX()
return self.entityCfg.flipX==1
end


function weapon:createEarlyWarnCollider()
local radius=self:getAttackRaduis()
local bounds=table.deepCopy(self.entityCfg.bounds)
bounds[4]=radius
local layer=self:getColliderLayer()
local colliderType=eAirEntityColliderType.eCircle
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(layer,nil,colliderType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
end


function weapon:getAttackRaduis()
local bounds=self.entityCfg.bounds
local radius=bounds[4]
local addPercent=self:getAttrValue(aiAttributeType.eAttckRange)
return radius*(1+addPercent/10000)
end

function weapon:refreshAttackCollider()
local radius=self:getAttackRaduis()
local bounds=table.deepCopy(self.entityCfg.bounds)
bounds[4]=radius
local layer=self:getColliderLayer()
self:setColliderBounds(layer,bounds)
end



function weapon:initSkill()
self.skillid=self.entityCfg.skillid
self.skillCfg=cfg_airskillconfig_get(self.skillid)
self.skillCD=self.skillCfg.cd
self.hurtType=self.skillCfg.hurtType
end

function weapon:getHurtType()
return self.hurtType
end

function weapon:getCoolDown()
local cd=self.skillCD
local attackSpeed=self:getAttrValue(aiAttributeType.eAttckSpeed)
if attackSpeed>=0 then
return 1/(1/cd*(1+attackSpeed/10000))
else
return 1/(1/cd/(1+math.abs(attackSpeed/10000)))
end
end

function weapon:isCoolDown()
if self.useSkillStamp==nil then return true end
local stamp=Time.realtimeSinceStartup
local useStamp=self:getPauseTime()+self.useSkillStamp
return stamp-useStamp>=self:getCoolDown()
end

function weapon:isCanCastSkill()
return self.enemyTarget~=nil and
self:isCoolDown()and
not self.owner:isDeleteSelf()and
not self.owner:hasBuffStatus(eBuffStatus.eXuanYun)or false
end

function weapon:castSkill(skillid,target)
if skillid then

local skillCfg=cfg_airskillconfig_get(skillid)
local command=airSkillSystem:createSkillCommmand(skillCfg,self.owner,self,self.enemyTarget)
if not command.isDelete and not self:isDeleteSelf()then
self.skillCommandLookup[command.guid]=command
end
local ret=self.owner:isDeleteSelf()or self:isDeleteSelf()
return ret
else
return self:castSkillEx()
end
end

function weapon:castSkillEx()
self.useSkillStamp=Time.realtimeSinceStartup-self:getPauseTime()
local command=airSkillSystem:createSkillCommmand(self.skillCfg,self.owner,self,self.enemyTarget)
if not command.isDelete and not self:isDeleteSelf()then
self.skillCommandLookup[command.guid]=command
end
local ret=self.owner:isDeleteSelf()or self:isDeleteSelf()
if not ret then
airBuffSystem:onWeaponAttack(self.owner,self.enemyTarget)
end
return ret
end

function weapon:onCommandsFastUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onFastUpdate()
end
end

function weapon:onCommandsUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onUpdate()
end
end

function weapon:onCommandsPause()
for _,command in pairs(self.skillCommandLookup)do
command:onPause()
end
end

function weapon:onCommandsContinue()
for _,command in pairs(self.skillCommandLookup)do
command:onContinue()
end
end

function weapon:onCommandDelete(guid)
self.skillCommandLookup[guid]=nil
end
