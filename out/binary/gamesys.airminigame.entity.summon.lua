
summon=simple_class(lifeEntity)

local _roleApplyAttr=
{
[aiAttributeType.eMagicAttack]=true,
[aiAttributeType.ePhiscAttack]=true,
}

function summon:initialize(args)
summon._base.initialize(self,args)

self.casterTarget=nil
self.useSkillStamp=nil
self.skillCommandLookup={}
self.owner=args.owner
self:initAttrs()
self:initSkill()
self:createAssetByCfg()
self:addPostDelete()
end

function summon:onDelete()
if self==nil or self:isDeleteSelf()then return end
summon._base.onDelete(self)
if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end
self.skillCommandLookup=nil
self.owner=nil
self.useSkillStamp=nil
self.curAttrs=nil
self.casterTarget=nil
self.skillid=nil
self.skillCfg=nil
self.skillCD=nil
end

function summon:onUpdate()
self:onCommandsUpdate()
end

function summon:onFastUpdate()
summon._base.onPause(self)
self:onCommandsFastUpdate()
end

function summon:onPause()
summon._base.onPause(self)
self:onCommandsPause()
end

function summon:onContinue()
summon._base.onContinue(self)
self:onCommandsContinue()
end

function summon:onStartLevel()
summon._base.onStartLevel(self)
end

function summon:initAttrs()
self.curAttrs=table.deepCopy(self.entityCfg.attrs)
end

function summon:getBaseAttrValue(attributeType)
return self.curAttrs[attributeType]or 0
end

function summon:getAttrValue(attributeType,really)
if self.owner==nil or self.owner:isDeleteSelf()then return 0 end
local value=self:getBaseAttrValue(attributeType)
value=value+self.owner:getSummonAddAttr(self,attributeType)
if _roleApplyAttr[attributeType]then
value=value+self.owner:getBaseAttrValue(attributeType)
local value_p=0
local attributeCfg=cfg_airattributesconfig_get(attributeType)
local relevantAttr=attributeCfg.relevantAttr
if relevantAttr then
value_p=value_p+self.owner:getAttrValue(relevantAttr,really)
end

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

function summon:createAssetByCfg()
self:createSpineByCfg()
end


function summon:createMonsterCollider()
local radius=self:getAttackRaduis()
local bounds=table.deepCopy(self.entityCfg.bounds)
bounds[4]=radius
local layer=self:getMonsterColliderLayer()
local colliderType=eAirEntityColliderType.eCircle
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addCollider(1,layer,nil,colliderType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
self.monsterCollider=true
end

function summon:refreshMonsterCollider()
if self.monsterCollider==nil then return end
local radius=self:getAttackRaduis()
local bounds=table.deepCopy(self.entityCfg.bounds)
bounds[4]=radius
self:setColliderBounds(1,bounds)
end


function summon:getAttackRaduis()
local bounds=self.entityCfg.bounds
local radius=bounds[4]
local addPercent=self:getAttrValue(aiAttributeType.eAttckRange)
return radius*(1+addPercent/10000)
end


function summon:createRoleCollider()
local radius=self:getAttackRaduis()
local bounds=table.deepCopy(self.entityCfg.bounds)
bounds[4]=radius
local layer=self:getRoleColliderLayer()
local colliderType=eAirEntityColliderType.eCircle
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addCollider(-1,layer,nil,colliderType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
self.roleCollider=true
end

function summon:refreshRoleCollider()
if self.roleCollider==nil then return end
local radius=self:getAttackRaduis()
local bounds=table.deepCopy(self.entityCfg.bounds)
bounds[4]=radius
self:setColliderBounds(-1,bounds)
end

function summon:getRoleColliderLayer()
return self:getColliderLayer()
end

function summon:getMonsterColliderLayer()
return self:getColliderLayer()
end

function summon:verifyDamage(entity,skillCfg,damage,damage_P,deductHP_P)
return damage,damage_P,deductHP_P,false
end

function summon:canIgnoreDamageLimit(entity)
return false
end


function summon:initSkill()
self.skillid=self.entityCfg.skillid
self.skillCfg=cfg_airskillconfig_get(self.skillid)
self.skillCD=self.skillCfg.cd
end

function summon:getCoolDown()
local cd=self.skillCD
local attackSpeed=self:getAttrValue(aiAttributeType.eAttckSpeed)
if attackSpeed>=0 then
return 1/(1/cd*(1+attackSpeed/10000))
else
return 1/(1/cd/(1+math.abs(attackSpeed/10000)))
end
end

function summon:isCoolDown()
if self.useSkillStamp==nil then return true end
local stamp=Time.realtimeSinceStartup
local useStamp=self:getPauseTime()+self.useSkillStamp
return stamp-useStamp>=self:getCoolDown()
end

function summon:isCanCastSkill()
return self.casterTarget~=nil and
self:isCoolDown()and
not self.owner:isDeleteSelf()
end

function summon:castSkill()
self.useSkillStamp=Time.realtimeSinceStartup-self:getPauseTime()
local command=airSkillSystem:createSkillCommmand(self.skillCfg,self.owner,self,self.casterTarget)
if not command.isDelete and not self:isDeleteSelf()then
self.skillCommandLookup[command.guid]=command
end
local ret=self.owner:isDeleteSelf()or self:isDeleteSelf()
return ret
end

function summon:onCommandsFastUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onFastUpdate()
end
end

function summon:onCommandsUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onUpdate()
end
end

function summon:onCommandsPause()
for _,command in pairs(self.skillCommandLookup)do
command:onPause()
end
end

function summon:onCommandsContinue()
for _,command in pairs(self.skillCommandLookup)do
command:onContinue()
end
end

function summon:onCommandDelete(guid)
self.skillCommandLookup[guid]=nil
end

function summon:onMissSkillAction(entity,skillid,actionid,isPenetrate)

end
