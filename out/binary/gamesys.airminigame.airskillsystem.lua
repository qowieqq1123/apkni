airSkillSystem={}


function airSkillSystem:onAppStart()

end

function airSkillSystem:onEnterState(isReconnect)

end


function airSkillSystem:onLeaveState(isReconnect)
airSkillSystem:leaveAirGame()
end

function airSkillSystem:onProtocolReq(isReconnect)

end

function airSkillSystem:onUpdateDamage()
if self.chixuDamageLookup==nil then return end
if airController:isPauseGame()or
not airLevelSystem:isLevelDoing()then
return
end
for i=#self.chixuDamageList,1,-1 do
self.chixuDamageList[i]:updateChiXuDamage()
end
end

function airSkillSystem:enterAirGame()
self.chixuDamageLookup=nil
self.chixuDamageList={}
end

function airSkillSystem:leaveAirGame()
self.chixuDamageLookup=nil
self.chixuDamageList={}
end

function airSkillSystem:addChixuDamageEntity(entity)
if self.chixuDamageLookup==nil then self.chixuDamageLookup={}end

local handle=entity.handle
if self.chixuDamageLookup[handle]then return end

self.chixuDamageLookup[handle]=true
self.chixuDamageList[#self.chixuDamageList+1]=entity
end

function airSkillSystem:removeChixuDamageEntity(entity)
if self.chixuDamageLookup==nil then return end

local handle=entity.handle
if self.chixuDamageLookup[handle]==nil then return end

self.chixuDamageLookup[handle]=nil

for i=#self.chixuDamageList,1,-1 do
if self.chixuDamageList[i].handle==handle then
table.remove(self.chixuDamageList,i)
break
end
end
if next(self.chixuDamageLookup)==nil then self.chixuDamageLookup=nil end
end

function airSkillSystem:createSkillCommmand(skillCfg,owner,caster,enemy,args)
local ctor=_G['airSkillCommand']
return ctor(skillCfg,owner,caster,enemy,args)
end

function airSkillSystem.createSkillAction(skillCfg,actionid,acionValue,behaviorValue,owner,caster,enemy,args)
local actionCfg=cfg_airskillactionconfig_get(actionid)
local behavourType=actionCfg.behavourType or eAirSkillBehavourType.eBase
airSkillSystem:preloadAction(behavourType)
local ctor=airSkillSystem:getActionInfo(behavourType)
return ctor(skillCfg,actionCfg,acionValue,behaviorValue,owner,caster,enemy,args)
end

function airSkillSystem:getBounds(rangeType,rangeArgs)
local boundType=nil
local bounds={}
bounds[1]=0
bounds[2]=0
bounds[3]=0
if rangeType==eAirSkillRangeType.eCircle then
boundType=eAirEntityColliderType.eCircle
bounds[4]=rangeArgs[1]
elseif rangeType==eAirSkillRangeType.eFan then
boundType=eAirEntityColliderType.eFan
bounds[4]=rangeArgs[1]
bounds[5]=rangeArgs[2]
bounds[6]=rangeArgs[3]
bounds[7]=rangeArgs[4]or 6
elseif rangeType==eAirSkillRangeType.eRect then
boundType=eAirEntityColliderType.eRect
bounds[4]=rangeArgs[1]
bounds[5]=rangeArgs[3]
bounds[6]=rangeArgs[2]
elseif rangeType==eAirSkillRangeType.eSingle then
boundType=eAirEntityColliderType.eCircle
bounds[1]=0
bounds[2]=0
bounds[3]=0
bounds[4]=0
end
return boundType,bounds
end

function airSkillSystem:getCircleBounds(raduis)
local boundType=eAirEntityColliderType.eCircle
local bounds={}
bounds[1]=0
bounds[2]=0
bounds[3]=0
bounds[4]=raduis
return boundType,bounds
end

function airSkillSystem:getBodySize(boundType,bounds)
local length,height,width
if boundType==eAirEntityColliderType.eCircle then
length=bounds[4]
height=length
width=length
elseif boundType==eAirEntityColliderType.eRect then
length=bounds[4]
height=bounds[5]
width=bounds[6]
elseif boundType==eAirEntityColliderType.eCapsule then
length=bounds[4]
height=bounds[5]
width=bounds[4]
end
return length,width,height
end

function airSkillSystem:getRadius(boundType,bounds)
if boundType==eAirEntityColliderType.eCircle then
return math.max(bounds[4],bounds[5])/2
elseif boundType==eAirEntityColliderType.eRect then
return bounds[4]
elseif boundType==eAirEntityColliderType.eCapsule then
return bounds[4]
end
return 0
end

function airSkillSystem:getAngle(actionCfg,owner,caster,target)
if not actionCfg.immediately then return end

local centerType=actionCfg.centerType
local rangeType=actionCfg.rangeType
if rangeType==0 then return end

if centerType==eAirSkillCenterType.eTarget then
return 0
elseif centerType==eAirSkillCenterType.eSelf then
if rangeType==eAirSkillRangeType.eCircle then
return 0
elseif rangeType==eAirSkillRangeType.eFan then
return airEntitySystem:getAoundYAngle(owner.handle,target.handle)
elseif rangeType==eAirSkillRangeType.eRect then
return airEntitySystem:getAoundYAngle(owner.handle,target.handle)
end
elseif centerType==eAirSkillCenterType.eWeapon then
if rangeType==eAirSkillRangeType.eCircle then
return 0
elseif rangeType==eAirSkillRangeType.eFan then
return airEntitySystem:getAoundYAngle(caster.handle,target.handle)
elseif rangeType==eAirSkillRangeType.eRect then
return airEntitySystem:getAoundYAngle(caster.handle,target.handle)
end
end
end


function airSkillSystem:executeSingleDamage(owner,target,caster,skillCfg,actionCfg,acionValue)
local _damage=0
local resultType=actionCfg.resultType
if target==nil or target.isDelete or
caster==nil or caster.isDelete or
owner==nil or owner.isDelete then
return false
end

if resultType==eAirSkillResultType.eDamageAndBuff then


if target:isWuDi()then

target:onWuDiOnDamage(owner,caster)
return
end

local attackType=acionValue[1]
local damage=acionValue[2]or 0
local damage_P=acionValue[3]or 0
local deductHP_P=acionValue[4]or 0
local cirticalRate_P=acionValue[5]or 0
local cirticalDamage_P=acionValue[6]or 0
local lifeSteal_P=acionValue[7]or 0
local hitRate_P=acionValue[8]or 0
local buffList=acionValue[9]
local spe_bit=acionValue[10]


local hitRate=caster:getAttrValue(aiAttributeType.eHitRate)
hitRate_P=hitRate_P+hitRate
if hitRate_P<10000 then
local dodgeRate=target:getAttrValue(aiAttributeType.eDodge)
local dodge=self:isEnoughRate(dodgeRate,0,10000)
if dodge then

target:onDodge(owner,caster)
return false
end
end
airSkillSystem:debugSkillDamage('释放技能：',skillCfg.id)

airSkillSystem:debugSkillDamage('技能基础伤害：',damage)


if caster.entityType==eAirEntityType.TYPE_ROLE then
local attackdamage=caster:getAttrValue(aiAttributeType.eAttack)

damage=damage+attackdamage
airSkillSystem:debugSkillDamage('角色基础攻击伤害：',attackdamage)

local attackTypeDamage=self:getDamageValue(attackType,caster)
damage=damage+attackTypeDamage
airSkillSystem:debugSkillDamage('角色类型伤害：',attackTypeDamage)

local weaponDamage=caster:getEquipHurtAttack(skillCfg.hurtType)
damage=damage+weaponDamage
airSkillSystem:debugSkillDamage('武器总伤害：',weaponDamage)
else
local attackdamage=caster:getAttrValue(aiAttributeType.eAttack)*(1+owner:getAttrValue(aiAttributeType.eWeaponDamage)/10000)

damage=damage+attackdamage
airSkillSystem:debugSkillDamage('基础攻击伤害：',attackdamage)

local attackTypeDamage=self:getDamageValue(attackType,caster)*(1+self:getIncreaseDamageValue(attackType,caster)/10000)
damage=damage+attackTypeDamage

airSkillSystem:debugSkillDamage('攻击类型伤害：',attackTypeDamage)
end


airSkillSystem:debugSkillDamage('技能伤害万分比：',damage_P)


local addDamage_P=caster:getAttrValue(aiAttributeType.eAddDamage)
damage_P=damage_P+addDamage_P
airSkillSystem:debugSkillDamage('提升伤害万分比：',addDamage_P)



local recvDamage_P=target:getAttrValue(aiAttributeType.eRecvDamage)
damage_P=damage_P+recvDamage_P
airSkillSystem:debugSkillDamage('被攻击对象承受更多伤害万分比：',recvDamage_P)


local damage__,damage_P__,deductHP_P__,ignoreDamageLimit=owner:verifyDamage(target,skillCfg,damage,damage_P,deductHP_P)
damage=damage__ or damage
damage_P=damage_P__ or damage_P
deductHP_P=deductHP_P__ or deductHP_P


damage=damage+damage*damage_P/10000
airSkillSystem:debugSkillDamage('最终伤害 + 万分比：',damage)



local multi_P=0
if target.entityType==eAirEntityType.TYPE_MONSTER_ELITE then
local eliteDamage_P=caster:getAttrValue(aiAttributeType.eAddEliteDamage)
multi_P=multi_P+eliteDamage_P
airSkillSystem:debugSkillDamage('精英伤害提升万分比：',eliteDamage_P)
elseif target.entityType==eAirEntityType.TYPE_MONSTER_BOSS then
local bossDamage_P=caster:getAttrValue(aiAttributeType.eAddBossDamage)
multi_P=multi_P+bossDamage_P
airSkillSystem:debugSkillDamage('BOSS伤害提升万分比：',bossDamage_P)
end

damage=damage*(1+multi_P/10000)
airSkillSystem:debugSkillDamage('最终伤害*倍率：',damage)


local cirticalRate=caster:getAttrValue(aiAttributeType.eCirticalRate)
cirticalRate=cirticalRate+cirticalRate_P
cirticalRate=owner:clampAttr(aiAttributeType.eCirticalRate,cirticalRate)
local isCirtical=self:isEnoughRate(cirticalRate,0,10000)
if isCirtical then
airSkillSystem:debugSkillDamage('暴击！技能暴击伤害提升：',cirticalDamage_P)
local attrCirticalDamage_P=caster:getAttrValue(aiAttributeType.eCirticalDamage)
airSkillSystem:debugSkillDamage('暴击！属性暴击伤害倍率：',attrCirticalDamage_P)
cirticalDamage_P=attrCirticalDamage_P+cirticalDamage_P
damage=damage*cirticalDamage_P/10000
airSkillSystem:debugSkillDamage('暴击后最终伤害：',damage)
end


local armor=target:getArmor()
damage=math.max(0,math.ceil(damage*(1-armor)))
airSkillSystem:debugSkillDamage('减去防御后最终伤害：',damage)

local reflectDamage_P=target:getAttrValue(aiAttributeType.eReflectDamage)
local maxHp=target:getMaxHP()
local reflectDamage=math.floor(maxHp*reflectDamage_P/10000)
local reflectIgnoreDamageLimit=false
if not target:isCanReflect()then
airSkillSystem:debugSkillDamage('反伤保护中，不能反伤：',reflectDamage)
reflectDamage=0
else
airSkillSystem:debugSkillDamage('反伤对象伤害：',reflectDamage)
reflectIgnoreDamageLimit=target:canIgnoreDamageLimit(owner)
end

if damage<0 and deductHP_P<=0 then return end


local finalDamage=damage


if owner and not owner:isDeleteSelf()then
airSkillSystem:debugSkillDamage('技能吸血万分比：',lifeSteal_P)
local lifeSteal_P_=owner:getAttrValue(aiAttributeType.eLifeSteal)
airSkillSystem:debugSkillDamage('属性吸血万分比：',lifeSteal_P_)
lifeSteal_P=lifeSteal_P+lifeSteal_P_
lifeSteal_P=owner:clampAttr(aiAttributeType.eLifeSteal,lifeSteal_P)
airSkillSystem:debugSkillDamage('总吸血万分比：',lifeSteal_P)
if lifeSteal_P>0 then
local lifeSteal=math.floor(damage*lifeSteal_P/10000)
if lifeSteal>0 then
airSkillSystem:debugSkillDamage('总吸血：',lifeSteal)
owner:onStealHP(lifeSteal)
end
end
end
local recvDamage=false
if finalDamage>0 then
local random=math.random(95,105)
finalDamage=math.floor(random*finalDamage/100)

owner:onAttack(target)
airSkillSystem:debugSkillDamage('附加随机值后实施最终伤害：',finalDamage)
recvDamage=target:onDamage(finalDamage,isCirtical,caster,ignoreDamageLimit)
end
_damage=finalDamage


if deductHP_P>0 and target and not target:isDeleteSelf()then
local HP=target:getAttrValue(aiAttributeType.eHP)
if HP>0 then
local maxHP=target:getAttrValue(aiAttributeType.eMaxHP)
airSkillSystem:debugSkillDamage('再扣减最大生命万分比：',deductHP_P)
local damage_=math.ceil(maxHP*deductHP_P/10000)
_damage=_damage+damage_
target:onReduceHP(deductHP_P,recvDamage,ignoreDamageLimit)
end
end

if reflectDamage>0 and owner and not owner:isDeleteSelf()then
if target and not target:isDeleteSelf()then
target:reflectDamage(reflectDamage)
end
owner:onReflect(reflectDamage,reflectIgnoreDamageLimit)
airSkillSystem:debugSkillDamage('再反伤：',reflectDamage)
end


if buffList then
airSkillSystem:addBuff(target,buffList,caster)
airSkillSystem:debugSkillDamage('最后加buff!',1)
end

elseif resultType==eAirSkillResultType.eRestoreHP then
local restoreHP_P=acionValue[1]
local restoreHP=acionValue[2]
local totalRestoreHP_P=restoreHP_P
local add=math.floor(target:getMaxHP()*totalRestoreHP_P/10000)+restoreHP
target:onRestoreHP(add)
_damage=add
elseif resultType==eAirSkillResultType.eAddBuff then
airSkillSystem:addBuff(target,acionValue,caster)
else

end

return true,{resultType=resultType,value=_damage}
end

function airSkillSystem:addBuff(target,buffList,caster)

local buffPer,buffId,buffLv,randVal
for i,v in ipairs(buffList)do
buffPer=v[1]buffId=v[2]buffLv=v[3]or 0
randVal=math.random(1,10000)

if randVal>=1 and randVal<=buffPer then
airBuffSystem:addBuff(target,buffId,buffLv,caster)
end
end
end

function airSkillSystem:getTargetBitLayer(entity,targetReleation,extraTargetReleation)
if targetReleation==eAirSkillTargetType.eSelf then
return airConfig.getBitLayer(entity:getColliderLayer())
elseif targetReleation==eAirSkillTargetType.eEnemy then
if entity.teamType==eAirEntityTeam.eRole then
if extraTargetReleation==1 then
return airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER)
elseif extraTargetReleation==2 then
return airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER_ELITE)
elseif extraTargetReleation==3 then
return airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER_BOSS)
elseif extraTargetReleation==4 then
return airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER_NEUTRAL)
else
return airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER)+
airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER_ELITE)+
airConfig.getEntityBitLayer(eAirEntityType.TYPE_MONSTER_BOSS)
end
elseif entity.teamType==eAirEntityTeam.eMonster then
return airConfig.getEntityBitLayer(eAirEntityType.TYPE_ROLE)
end
elseif targetReleation==eAirSkillTargetType.eTeam then
loggerUtil.debugErrFMT('暂未支持额外目标为队友')
elseif targetReleation==eAirSkillTargetType.eAll then
loggerUtil.debugErrFMT('暂未支持额外目标为全部')
end

end

function airSkillSystem:checkCastEnity(owner,target,actionCfg)
local entityType=target.entityType
if entityType~=eAirEntityType.TYPE_ROLE and
entityType~=eAirEntityType.TYPE_MONSTER and
entityType~=eAirEntityType.TYPE_MONSTER_ELITE and
entityType~=eAirEntityType.TYPE_MONSTER_BOSS and
entityType~=eAirEntityType.TYPE_MONSTER_NEUTRAL then
return false
end

local targetReleation=actionCfg.targetReleation
if targetReleation==eAirSkillTargetType.eSelf then
if not owner:isSelf(target)then return false end
elseif targetReleation==eAirSkillTargetType.eEnemy then
if not owner:isEnemy(target)then return false end
elseif targetReleation==eAirSkillTargetType.eTeam then
if not owner:isFriend(target)then return false end
elseif targetReleation==eAirSkillTargetType.eAll then

end

local targetReleation=actionCfg.extraTargetReleation
if targetReleation then
return entityType==airConfig.getMonsterType(targetReleation)
end
return true
end

function airSkillSystem:isEnoughRate(ratio,min,max)
return mathHelper.randomLimit(min,max,ratio)
end

function airSkillSystem:getIncreaseDamageValue(attackType,owner)
if attackType==1 then
return owner:getAttrValue(aiAttributeType.ePhiscIncreaseDamage)
elseif attackType==2 then
return owner:getAttrValue(aiAttributeType.eMagicIncreaseDamage)
end
return 0
end

function airSkillSystem:getDamageValue(attackType,owner)
if attackType==1 then
return owner:getAttrValue(aiAttributeType.ePhiscAttack)
elseif attackType==2 then
return owner:getAttrValue(aiAttributeType.eMagicAttack)
end
return 0
end






function airSkillSystem:rayCastBox(origin,halfsize,direction,quaternion,distance,layerMask)
return airController.getManagerStatic().RayCastBox3D(origin,halfsize,direction,quaternion,distance,layerMask)
end

function airSkillSystem:rayCastSphere(origin,radius,direction,distance,layerMask)
return airController.getManagerStatic().RayCastSphere(origin,radius,direction,distance,layerMask)
end

function airSkillSystem:debugSkillDamage(desc,damage)





end
