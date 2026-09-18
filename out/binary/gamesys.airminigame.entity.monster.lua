monster=simple_class(lifeEntity)


function monster:initialize(args)
monster._base.initialize(self,args)
self.canMove=true
self.attrEffectStamp={}

self.useDeadSkill=nil
self.skillCD={}

self.skillTime={}


self.staticAuto.BaseEntity_IsMoving_set(self.handle,self.canMove)


self:setCanMove(false)
self.bornStop=true

self.aiId=self.entityCfg.ai

self:createSpineByCfg()

self:addMainColliderByCfg()

self:initAttrs()
self:initSpeed()

self:createAI()
self:lookAtCamera()

self.isRoleInRange={}
self.useSkillStamp={}
self.skillCommandLookup={}
self:initSkill()
self:addPostDelete()
self.aiBehaviour:start()

self.entity:EnablePlaceCheck(0.5,3,0.5)


local atkDistance=self.entityCfg.atkDistance

self.skillTouchLookup={}

if atkDistance then
for skillId,v in pairs(atkDistance)do
if v>0 then
local boundType=eAirEntityColliderType.eCircle
local bounds={0,0,0,v}
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
local layer=colliderCfg.atklayer
self:addCollider(skillId,layer,nil,boundType,bounds,true,false,0,3)
else
self.skillTouchLookup[skillId]=1
end
end

end

self.bornSkillDelay=Time.realtimeSinceStartup+1
end

function monster:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()

if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end
self.aiBehaviour:onDelete()

monster._base.onDelete(self)

self.skillCD=nil
self.skillTime=nil
self.isRoleInRange=nil
self.aiId=nil
self.target=nil
self.moveSpeed=nil
self.useSkillStamp=nil
self.skillCommandLookup=nil
self.aiBehaviour=nil
self.attrEffectStamp=nil
self.bornSkillDelay=nil
self.skillTouchLookup=nil
end

function monster:onUpdate()
monster._base.onUpdate(self)

if self.bornSkillDelay and self.bornSkillDelay<Time.realtimeSinceStartup then
if self.bornStop then
self:setCanMove(true)
self.bornStop=nil
end
if self:isCanCastSkill(true)then return end
end

for _,command in pairs(self.skillCommandLookup)do
command:onUpdate()
end
self.aiBehaviour:onUpdate()
end

function monster:onPause()
monster._base.onPause(self)
for _,command in pairs(self.skillCommandLookup)do
command:onPause()
end
self.aiBehaviour:onPause()
end

function monster:onContinue()
monster._base.onContinue(self)
for _,command in pairs(self.skillCommandLookup)do
command:onContinue()
end
self.aiBehaviour:onContinue()
end

function monster:onFastUpdate()
monster._base.onFastUpdate(self)
for _,command in pairs(self.skillCommandLookup)do
command:onFastUpdate()
end
if self.aiBehaviour then
self.aiBehaviour:onFastUpdate()
end
end

function monster:onCommandDelete(guid)
self.skillCommandLookup[guid]=nil
end

function monster:onRemoveEntity(handle)
monster._base.onRemoveEntity(self,handle)
if self.target and handle==self.target.handle then
self.target=nil
self.isRoleInRange={}
self.aiBehaviour:unbindTarget()
end
end



function monster:initAttrs()
self.curAttrs=table.weakCopy(self.entityCfg.attrs)
local lookup=airBuffSystem:getRangeEnemyChangeAttrsAttrs(self)
if lookup then
self.curAttrs=attrListHelper.concatLookup(self.curAttrs,lookup)
end
local maxHp=self:getMaxHP()
self:setAttrValue(aiAttributeType.eHP,maxHp)
end

function monster:getBaseAttrValue(attributeType)
local old=self.curAttrs[attributeType]or 0
old=old+self:getExtraAttrValue(attributeType)
return old
end


function monster:getAttrValue(attributeType,really)
local attributeCfg=cfg_airattributesconfig_get(attributeType)
local old=self:getBaseAttrValue(attributeType)
local value_p=0
local relevantAttr=attributeCfg.relevantAttr
if relevantAttr then
if relevantAttr==attributeType then
loggerUtil.logErrFMT('关联属性不能是本属性：{0}',attributeType)
return 0
end
value_p=value_p+self:getAttrValue(relevantAttr,really)
end
if value_p~=0 then
if airConfig.isAttr_P(attributeType)then
old=old+value_p
else
old=old+old*value_p/10000
end
end
old=self:clampTopAttr(attributeCfg,old)
if not really then
old=self:clampAttr(attributeType,old)
end
return old
end

function monster:setAttrValue(attributeType,value)
local old=self.curAttrs[attributeType]or 0
local new=value
self.curAttrs[attributeType]=new
if new==old then return end

self:onRefreshAttr(attributeType,old,new)
end

function monster:addAttrValue(attributeType,value)
local old=self.curAttrs[attributeType]or 0
local new=old+value
self.curAttrs[attributeType]=new
if new==old then return end

self:onRefreshAttr(attributeType,old,new)
end

function monster:setAttrValue_P(attributeType,value_P)
local old=self.curAttrs[attributeType]or 0
local new=old*(1+value_P/10000)
self.curAttrs[attributeType]=new
if new==old then return end

self:onRefreshAttr(attributeType,old,new)
end

function monster:onRefreshAttr(attributeType,old,new)

if attributeType==aiAttributeType.eHP then
self:initHpChangeBuff()
end
self:initConvertAttr()
self:initDamageAttr()

if attributeType==aiAttributeType.eAddMoveSpeed then
self:onChangeSpeed()
elseif attributeType==aiAttributeType.eHP or
attributeType==aiAttributeType.eMaxHP then
local maxHP=self:getMaxHP()
local HP=self:getHP()
if HP>maxHP then
HP=maxHP
self.curAttrs[aiAttributeType.eHP]=HP
end
if HP~=old then
airHUDSystem:onHPChange(self.handle,HP,maxHP)
end
end
end

function monster:getHP()
return self:getAttrValue(aiAttributeType.eHP)
end

function monster:getMaxHP()
local maxHP_P=self:getAttrValue(aiAttributeType.eMaxHP_P)
local maxHp=self:getAttrValue(aiAttributeType.eMaxHP,nil)
return math.floor(maxHp*(1+maxHP_P/10000))
end

function monster:isMaxHp()
return self:getHP()>=self:getMaxHP()
end

function monster:setHP(value)
local old=self.curAttrs[aiAttributeType.eHP]
if old==value then return end
self:setAttrValue(aiAttributeType.eHP,value)
end

function monster:addHP(value)
self:addAttrValue(aiAttributeType.eHP,value)
end

function monster:setHP_P(value_P)
self:setAttrValue_P(aiAttributeType.eHP,value_P)
end

function monster:setMaxHP(value)
self:setAttrValue(aiAttributeType.eMaxHP,value)
end

function monster:setMaxHP_P(value_P)
self:setAttrValue_P(aiAttributeType.eMaxHP,value_P)
end


function monster:getCurrrentSpeed()
local moveSpeed=self.orginSpeed
local speed_p=self:getAttrValue(aiAttributeType.eAddMoveSpeed)+self.addSpeedValue_P
if speed_p>0 then
local speed=moveSpeed*(1+speed_p/10000)
return airEntitySystem:clampSpeed(speed)
else
local speed=moveSpeed/(1+math.abs(speed_p/10000))
return airEntitySystem:clampSpeed(speed)
end
end

function monster:initSpeed()
local aiId=self.aiId
self.orginSpeed=cfgHelper.get2(cfg_airemonsteraiconfig_get,aiId,'speed')
self.addSpeedValue_P=0
self.moveSpeed=self:getCurrrentSpeed()
self.entity.MoveSpeed=self.moveSpeed
end

function monster:onChangeSpeed()
local old=self.moveSpeed
local speed=self:getCurrrentSpeed()
if speed~=old then
self.moveSpeed=speed
self.entity.MoveSpeed=speed
end
end

function monster:getAttackRaduis()
local bounds=self.entityCfg.bounds
local radius=bounds[4]
local addPercent=self:getAttrValue(aiAttributeType.eAttckRange)
return radius*(1+addPercent/10000)
end



function monster:onHit()

end

function monster:onTriggerEnterSkill(entity)

end

function monster:onTriggerEnterRole(entity,guid1,guid2)
self.isRoleInRange[guid1]=true
end

function monster:onTriggerExitRole(entity,guid1,guid2)
self.isRoleInRange[guid1]=nil
end


function monster:initSkill()

self.deadSkillid=self.entityCfg.deadSkillid

self.skillPool=self.entityCfg.skillid

self.skillType=self.entityCfg.skillType
if self.skillPool then
for _,v in ipairs(self.skillPool)do
self.skillCD[v]=cfg_airskillconfig_get(v).cd
self.skillTime[v]=cfg_airskillconfig_get(v).time
end
end
end

function monster:getCoolDown(skillid)
local cd=self.skillCD[skillid]
local attackSpeed=self:getAttrValue(aiAttributeType.eAttckSpeed)
if attackSpeed>=0 then
return 1/(1/cd*(1+attackSpeed/10000))
else
return 1/(1/cd/(1+math.abs(attackSpeed/10000)))
end
end

function monster:isCoolDown(skillid)
if self.skillPool==nil then return false end
if self.useSkillStamp[skillid]==nil then return true end
local stamp=Time.realtimeSinceStartup
local useStamp=self:getPauseTime()+self.useSkillStamp[skillid]
return stamp-useStamp>=self:getCoolDown(skillid)
end

function monster:isCanCastSkill(isCast)
if self:isXuanYun()then return end
if self.skillPool then
if self.lastSkill then
if self.skillTime[self.lastSkill]and self.useSkillStamp[self.lastSkill]+self.skillTime[self.lastSkill]+self:getPauseTime()>Time.realtimeSinceStartup then
return
end
end
for _,skill in pairs(self.skillPool)do
if self:isCoolDown(skill)and(self.isRoleInRange[skill]or(self.skillTouchLookup[skill]~=nil and self.isRoleInRange[-1]))then
if isCast then
self:castSkill(skill,self.target)
self.lastSkill=skill
return self:isDeleteSelf()
end
end
end
end
end


function monster:isDeadSkill()
return self.deadSkillid~=nil
end


function monster:castSkill(skillid,target,args)
if self:isXuanYun()then return end
local forceCast=args and args.coolType==0 or false
if not forceCast and not self:isCoolDown(skillid)then return-1 end

local skillCfg=cfg_airskillconfig_get(skillid)
if not forceCast then
self.useSkillStamp[skillid]=Time.realtimeSinceStartup-self:getPauseTime()
end

local command=airSkillSystem:createSkillCommmand(skillCfg,self,self,target,args)
command.isDeadSkill=args~=nil and args.isDeadSkill
if not command.isDelete and not self:isDeleteSelf()then
self.skillCommandLookup[command.guid]=command
end
end

function monster:isCanTakeDamage()
if self:isWuDi()then return false end
return true
end

function monster:onWuDi(flag)

end

function monster:onXuanYun(flag)
if flag then
if self.aiBehaviour then
self.aiBehaviour:stopStackTarget()
self.aiBehaviour:onPause()
self.entity:StopMoveTween(false,false)
end
else
if self.aiBehaviour then
self.aiBehaviour:remsumeStackTarget()
self.aiBehaviour:onContinue()
end
end
end

function monster:onAttack(entity)

end

function monster:onDamage(damage,isCirtical,caster,ignoreDamageLimit,damageType)
if not self:isCanTakeDamage()then return end
if damage<=0 then return end
if isCirtical then

end
local damageLimit=not ignoreDamageLimit
damageType=damageType or eDamageType.eProactiveAttack
local recvDamage=damageLimit and self:clampDamage(damage,damageType)or damage
if recvDamage<=0 then return end

local cur=self:getHP()
local next=math.max(cur-recvDamage,0)
local del=cur-next
if del<=0 then return end

self:setHP(next)


airModel:setStatisticData_addAllDmg(recvDamage)
local roleEnt=airActorSystem:getActor()
if roleEnt and caster then
local equipHandle=caster.handle
local equipIdx=roleEnt:getEquipIdxByHandle(equipHandle)
if equipIdx then

airModel:setStatisticData_addWeaponDmg(equipIdx,damage)
end
end

airHUDSystem:onDamage(self,damageLimit and math.min(recvDamage,damage)or damage,isCirtical)
self:showDamageBehaiour()
if next<=0 then
self:onDead(isCirtical)
end
end

function monster:onReduceHP(HP_P,forceDamage,ignoreDamageLimit,damageType)
local max=self:getMaxHP()
local del=math.min(math.ceil(max*HP_P/10000),max)
if del<=0 then return end

local damageLimit=not ignoreDamageLimit
damageType=damageType or eDamageType.eReduceHP
local recvDamage=damageLimit and self:clampDamage(del,eDamageType.eReduceHP)or del
if recvDamage<=0 then return end

local hp=self:getHP()
local next=math.max(hp-recvDamage,0)

self:setHP(next)


airHUDSystem:onDamage(self,damageLimit and math.min(recvDamage,del)or del)
self:showDamageBehaiour()
if next<=0 then
self:onDead()
end
return true
end

function monster:onDead(isCirtical)
if airBuffSystem:onDyingRebirth(self)then
return false
end





airModel:setStatisticData_addKillMonsterCount(1)
if self.entityType==eAirEntityType.TYPE_MONSTER_BOSS then

airModel:setStatisticData_addKillBossCount(1)
end

if self:isDeadSkill()and not self.useDeadSkill then

airEntitySystem:createEntityDeadSkill(self,self.deadSkillid,self.target)
self.useDeadSkill=true
end

airMonsterSystem:onDead(self,isCirtical)
airDropSystem:createDropEnity(self,isCirtical)
self:deleteEntity()
return true
end


function monster:onDodge(owner,caster)

airHUDSystem:onDodge(self.handle)
airBuffSystem:onDodge(self)
end

function monster:onRestoreHP(add)
local max=self:getMaxHP()
local cur=self:getHP()
local next=math.min(cur+add,max)
local add=next-cur
if add<=0 then return end

self:setHP(next)
airHUDSystem:onRestoreHP(self.handle,add)
end

function monster:onStealHP(add)
local attributeType=aiAttributeType.eLifeSteal
local attributeCfg=cfg_airattributesconfig_get(attributeType)
local cd=attributeCfg.cd
local stamp=airController:getRealServerTime_short()
if cd then
local nextStamp=self.attrEffectStamp[attributeType]
if nextStamp and nextStamp+self:getPauseTime()>stamp then
return false
end
end
local limit=attributeCfg.limit
local max=self:getMaxHP()
if limit then
add=math.min(add,math.floor(limit[1]/10000*max))
end
local cur=self:getHP()
local next=math.min(cur+add,max)
local add=next-cur
if add<=0 then return end


if cd then
self.attrEffectStamp[attributeType]=stamp+cd-self:getPauseTime()
end

self:setHP(next)
airHUDSystem:onStealHP(self.handle,add)
end

function monster:onReflect(value,ignoreDamageLimit)
if not self:isCanTakeDamage()then return end

local damageLimit=not ignoreDamageLimit
local recvDamage=damageLimit and self:clampDamage(value,eDamageType.eReflect)or value
if recvDamage<=0 then return end

local cur=self:getHP()
local next=math.max(cur-recvDamage,0)
local del=cur-next
if del<=0 then return end


self:setHP(next)
self:showDamageBehaiour()
airHUDSystem:onReflect(self.handle,damageLimit and math.min(recvDamage,value)or value)
if next<=0 then
self:onDead()
end
end


function monster:checkReflectDead(value,ignoreDamageLimit)
if not self:isCanTakeDamage()then return false end
local damageLimit=not ignoreDamageLimit
local recvDamage=damageLimit and self:clampDamage(value,eDamageType.eReflect)or value
if recvDamage<=0 then return false end
local cur=self:getHP()
local next=math.max(cur-recvDamage,0)
return next<=0
end

function monster:onReduceSpeedValue(value)
self.addSpeedValue_P=self.addSpeedValue_P+value
self:onChangeSpeed()
end

function monster:onMissSkillAction(entity,skillid,actionid,isPenetrate)

end

function monster:showDamageBehaiour()
self:twinkleSpine(Color.New(0.92,0.93,0.87),0.2)
end



function monster:createAI()
local aiId=self.aiId
local target=airActorSystem:getActor()
local args={}
args.target=target
self.target=target
self.aiBehaviour=airMonsterSystem:createAI(self,aiId,args)
self.aiBehaviour:bindTarget(self.target)
end

function monster:clampDamage(damage,damageType)
local clampDamage=self.entityCfg.clampDamage

if clampDamage==nil then return damage,false end

if damageType~=clampDamage[2]then return 0,false end

local typo=clampDamage[1]
local limitBottom=clampDamage[3]
local limitTop=clampDamage[4]
local damage_
if typo==1 then
damage_=damage
damage_=math.min(damage_,limitTop)
damage_=math.max(damage_,limitBottom)
return damage_,true
elseif typo==2 then
damage_=10000
damage_=math.min(damage_,limitTop)
damage_=math.max(damage_,limitBottom)
return math.ceil(damage_/10000*damage),true
else
return damage,false
end
end
