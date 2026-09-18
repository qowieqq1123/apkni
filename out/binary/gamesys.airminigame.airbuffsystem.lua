airBuffSystem={}

local _guid

local _handles=
{

[eBuffType.eChangeAttr]={
add=function(...)
airBuffSystem:onAddChangeAttrBuff(...)
end,
remove=function(...)
airBuffSystem:onRemoveChangeAttrBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBetterAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:addAttrBuffEffect(...)
end,

compareSame=function(...)
return airBuffSystem:isSameAtrrBuff(...)
end,
},






















[eBuffType.eChangeSpeed]={
add=function(...)
airBuffSystem:onAddChangeSpeedBuff(...)
end,
remove=function(...)
airBuffSystem:onRemoveChangeSpeedBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBetterChangeSpeedBuff(...)
end,
calculation=function(...)
return airBuffSystem:addChangeSpeedEffect(...)
end,

compareSame=function(...)
return true
end,
},


[eBuffType.ekillEnemyPickUpDrop]={
isBetter=function(...)
return airBuffSystem:isBestKillEnemyPickUpDropBuff(...)
end,
calculation=function(...)
return airBuffSystem:addKillEnemyPickUpDropEffect(...)
end,

compareSame=function(...)
return true
end,
},


[eBuffType.eAddSpecificUnitDamage]={
isBetter=function(...)
return airBuffSystem:isBetterAddSpecificUnitDamageBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationSpecificUnitDamageEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareSpecificUnitDamageEffect(...)
end,
},


[eBuffType.ePickUpDropChangeAttr]={
isBetter=function(...)
return airBuffSystem:isBetterPickUpDropChangeAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationPickUpDropChangeAttrEffect(...)
end,

compareSame=function(...)
return airBuffSystem:comparePickUpDropChangeAttrEffect(...)
end,
},

[eBuffType.eAddSummon]={

},

[eBuffType.eAddXiaoHaoPinRestore]={
isBetter=function(...)
return airBuffSystem:isBetterAddXiaoHaoPinRestoreBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationAddXiaoHaoPinRestoreEffect(...)
end,

compareSame=function(...)
return true
end,
},

[eBuffType.eChangeMonsterRefreshTime]={
isBetter=function(...)
return airBuffSystem:isBetterChangeMonsterRefreshTimeBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChangeMonsterRefreshTimeEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareChangeMonsterRefreshTimeEffect(...)
end,
},

[eBuffType.eMomentCastSkill]={
isBetter=function(...)
return airBuffSystem:isBetterMomentCastSkillBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationMomentCastSkillEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareMomentCastSkillEffect(...)
end,
},

[eBuffType.eStatusCastSkill]={
isBetter=function(...)
return airBuffSystem:isBetterStatusCastSkillBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationStatusCastSkillEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareStatusCastSkillEffect(...)
end,
},

[eBuffType.eMomentChangeAttr]={
isBetter=function(...)
return airBuffSystem:isBetterMomentChangeAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationMomentChangeAttrEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareMomentMomentChangeAttrEffect(...)
end,
},

[eBuffType.eStatusChangeAttr]={
add=function(...)
return airBuffSystem:onAddStatusChangeAttrBuff(...)
end,
remove=function(...)
return airBuffSystem:onRemoveStatusChangeAttrBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBetterStatusChangeAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationStatusChangeAttrEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareStatusChangeAttrEffect(...)
end,
},

[eBuffType.eChangeSkillDamage]={
isBetter=function(...)
return airBuffSystem:isBetterChangeSkillDamageBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChangeSkillDamageEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareChangeSkillDamageEffect(...)
end,
},


[eBuffType.eChangeSkillRange]={
isBetter=function(...)
return airBuffSystem:isBetterChangeSkillRangeBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChangeSkillRangeEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareChangeSkillRangeEffect(...)
end,
},

[eBuffType.eChangeItemPrice]={
add=function()
airController:refreshAllWinItemPriceShow()
end,
remove=function()
airController:refreshAllWinItemPriceShow()
end,
isBetter=function(...)
return airBuffSystem:isBetterChangeItemPriceBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChangeItemPriceEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareChangeItemPriceEffect(...)
end,
},

[eBuffType.eChangePickUpGain]={
isBetter=function(...)
return airBuffSystem:isBetterChangePickUpGainBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChangePickUpGainEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareChangePickUpGainEffect(...)
end,
},

[eBuffType.eAddShopDiscount]={
add=function()
airController:refreshAllWinRefreshCostShow()
end,
remove=function()
airController:refreshAllWinRefreshCostShow()
end,
isBetter=function(...)
return airBuffSystem:isBetterAddShopDiscountBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationAddShopDiscountEffect(...)
end,

compareSame=function(...)
return true
end,
},

[eBuffType.eSpeMoneyUniqueBuff]={
isBetter=function(...)
return airBuffSystem:isBetterSpeMoneyUniqueBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationSpeMoneyUniqueEffect(...)
end,

compareSame=function(...)
return true
end,
},

[eBuffType.eConvertAttrToDamage]={
add=function(...)
return airBuffSystem:addConvertAttrBuff(...)
end,
remove=function(...)
return airBuffSystem:removeConvertAttrBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBetterConvertAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationConvertAttrEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareConvertAttrEffect(...)
end,
},

[eBuffType.eChangeExpGain]={
isBetter=function(...)
return airBuffSystem:isBetterChangeExpGainBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChangeExpGainEffect(...)
end,

compareSame=function(...)
return true
end,
},

[eBuffType.eMomentChangeDrop]={
isBetter=function(...)
return airBuffSystem:isBetterMomentChangeDropBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationMomentChangeDropEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareMomentChangeDropEffect(...)
end,
},
[eBuffType.eChiXuDamage]={
add=function(...)
airBuffSystem:onAddChiXuDamageBuff(...)
end,
remove=function(...)
airBuffSystem:onRemoveChiXuDamageBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBetterChiXuDamageBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationChiXuDamageEffect(...)
end,

compareSame=function(...)
return true
end,
},

[eBuffType.eAttackRatioAddBuff]={
isBetter=function(...)
return airBuffSystem:isBetterAttackAddBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationAttackAddBuffEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareAttackRatioAddBuffEffect(...)
end,
},


[eBuffType.eForceHP]=
{
isBetter=function(...)
return airBuffSystem:isBetterForceHPBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationForceHPEffect(...)
end,

compareSame=function(...)
return true
end,
},

[eBuffType.eConvertAttrToAttr]=
{
add=function(...)
airBuffSystem:addAttrAddAttrBuff(...)
end,
remove=function(...)
airBuffSystem:removeAttrAddAttrBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBettereAttrAddAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationeAttrAddAttrEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareAttrAddAttrEffect(...)
end,
},

[eBuffType.eHpLimitAddAttr]=
{
add=function(...)
airBuffSystem:addHpLimitAddAttrBuff(...)
end,
remove=function(...)
airBuffSystem:removeHpLimitAddAttrBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBettereHpLimitAddAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationeHpLimitAddAttrEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareHpLimitAddAttrEffect(...)
end,
},

[eBuffType.eTuPoAttrTopLimit]=
{
add=function(...)
airBuffSystem:addTuPoTopLimitAttrBuff(...)
end,
remove=function(...)
airBuffSystem:removeTuPoTopLimitAttrBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBettereTuPoTopLimitAttrBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationeTuPoTopLimitAttrEffect(...)
end,

compareSame=function(...)
return false
end,
},

[eBuffType.eEnterStatus]=
{
add=function(...)
airBuffSystem:addEnterStatusBuff(...)
end,
remove=function(...)
airBuffSystem:removeEnterStatusBuff(...)
end,
isBetter=function(...)
return false
end,
calculation=function(...)
return airBuffSystem:calculationEnterStatusEffect(...)
end,

compareSame=function(...)
return airBuffSystem:compareEnterStatusEffect(...)
end,
},

[eBuffType.eDyingRebirth]=
{
isBetter=function(...)
return airBuffSystem:isBetterDyingRebirthBuff(...)
end,

compareSame=function(...)
return false
end,
calculation=function(...)
return airBuffSystem:calculationDyingRebirthBuff(...)
end,
},


[eBuffType.eHoldWeaponChangeAttrs]=
{
isBetter=function(...)
return airBuffSystem:isBetterHoldWeaponChangeAttrsBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationHoldWeaponChangeAttrsBuff(...)
end,

compareSame=function(...)
return airBuffSystem:compareHoldWeaponChangeAttrsEffect(...)
end,
},

[eBuffType.eOwnerSummonChangeAttrs]=
{
add=function(...)
airBuffSystem:addOwnerSummonChangeAttrsBuff(...)
end,
remove=function(...)
airBuffSystem:removeOwnerSummonChangeAttrsBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBetterOwnerSummonChangeAttrsBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationOwnerSummonChangeAttrsBuff(...)
end,

compareSame=function(...)
return airBuffSystem:compareOwnerSummonChangeAttrsEffect(...)
end,
},

[eBuffType.eRangeEnemyChangeAttrs]=
{
add=function(...)
airBuffSystem:addRangeEnemyChangeAttrsBuff(...)
end,
remove=function(...)
airBuffSystem:removeRangeEnemyChangeAttrsBuff(...)
end,
isBetter=function(...)
return airBuffSystem:isBettereRangeEnemyChangeAttrsBuff(...)
end,
calculation=function(...)
return airBuffSystem:calculationRangeEnemyChangeAttrsBuff(...)
end,

compareSame=function(...)
return airBuffSystem:compareRangeEnemyChangeAttrsEffect(...)
end,
},

[eBuffType.eUpWeaponOrChangeAttrs]=
{
isBetter=function(...)
return false
end,
calculation=function(...)
return airBuffSystem:calculationUpWeaponOrChangeAttrsBuff(...)
end,

compareSame=function(...)
return false
end,
},

[eBuffType.eHpLimitOnDropChangeAttr]=
{
add=function(...)
airBuffSystem:onAddChangeAttrBuff(...)
end,
remove=function(...)
airBuffSystem:onRemoveChangeAttrBuff(...)
end,
isBetter=function(...)
return false
end,
calculation=function(...)
return airBuffSystem:calculationHpLimitOnDropChangeAttrBuff(...)
end,

compareSame=function(...)
return false
end,
},
}

function airBuffSystem:onAppStart()

end

function airBuffSystem:onEnterState(isReconnect)

end


function airBuffSystem:onLeaveState(isReconnect)

end

function airBuffSystem:onProtocolReq(isReconnect)

end

function airBuffSystem:enterAirGame()

end

function airBuffSystem:leaveAirGame()

end



function airBuffSystem:addBuff(entity,buffid,level,caster,levelClear)
if levelClear==nil then levelClear=true end
if entity==nil or entity:isDeleteSelf()then return end

local buffCfg=cfg_airbuffconfig_get(buffid)
local delayType=buffCfg.durationType
local effectTime=buffCfg.effectTime
local time=0
if effectTime~=0 then
if delayType==1 then
time=airController:getRealServerTime_short()+effectTime
elseif delayType==2 then
time=airLevelSystem:getCurLevelIdx()+effectTime
end
end
local replaceCaster=airSkillSystem:getBuffCaster(entity,caster,buffid)
return entity:addBuff(buffid,level,delayType,time,replaceCaster)
end


function airBuffSystem:removeBuff(entity,buffguid)
return entity:removeBuff(buffguid)
end

function airBuffSystem:getBuffGUID()
_guid=_guid or airModel:getActorProcessData().buffguid or 0
_guid=_guid+1
return _guid
end

function airBuffSystem:getCurrentBuffGUID()
return _guid
end


function airSkillSystem:getBuffCaster(entity,caster,buffid)
if caster==nil then return end

local buffCfg=cfg_airbuffconfig_get(buffid)
local buffType=buffCfg.buffType
if buffType~=eBuffType.eChiXuDamage then
return nil
end

if caster.entityType==eAirEntityType.TYPE_ROLE then
return caster
end

if caster==nil or caster:isDeleteSelf()then
return airEntitySystem:createReplaceEntity(caster,entity)
end

if airSkillSystem:isReplaceEntity(caster)then return caster end

return caster
end

function airSkillSystem:isReplaceEntity(entity)
return entity.entityType==eAirEntityType.TYPE_ENTITY_REPLACE
end




function airBuffSystem:addBuffEffect(entity,buffInfo)
local buffid=buffInfo.buffid
local level=buffInfo.level
local buffCfg=cfg_airbuffconfig_get(buffid)
local buffType=buffCfg.buffType
local effect=airBuffSystem:getBuffEffects(buffCfg,level)
if _handles[buffType]then
local func=_handles[buffType].add
if func==nil then return end
func(entity,buffType,effect,buffInfo)
else
loggerUtil.debugErrFMT('buff类型{0}尚未实现',buffType)
end
end


function airBuffSystem:removeBuffEffect(entity,buffInfo)
local buffid=buffInfo.buffid
local level=buffInfo.level
local buffCfg=cfg_airbuffconfig_get(buffid)
local buffType=buffCfg.buffType
local effect=airBuffSystem:getBuffEffects(buffCfg,level)
if _handles[buffType]then
local addFunc=_handles[buffType].add
local removeFunc=_handles[buffType].remove
if addFunc==nil and removeFunc or addFunc and removeFunc==nil then
loggerUtil.logErrFMT('buff添加和删除数据方法必须配对')
end
if removeFunc==nil then return end
removeFunc(entity,buffType,effect,buffInfo)
else
loggerUtil.debugErrFMT('buff类型{0}尚未实现',buffType)
end
end




function airBuffSystem:isBestBuffEffect(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
local buffCfg=cfg_airbuffconfig_get(buffid)
local buffType=buffCfg.buffType
if _handles[buffType]then
local func=_handles[buffType].isBetter
return func(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
else
loggerUtil.debugErrFMT('buff类型{0}尚未实现',buffType)
end
return false
end


function airBuffSystem:calculationBuffEffectList(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,...)
if _handles[buffType]then
local func=_handles[buffType].calculation
return func(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,...)
else
loggerUtil.debugErrFMT('buff类型{0}尚未实现',buffType)
end
end

function airBuffSystem:compareBuffEffect(lifeEnt,buffType,neweffect,oldeffect,...)
if _handles[buffType]then
local func=_handles[buffType].compareSame
return func(lifeEnt,neweffect,oldeffect,...)
else
loggerUtil.debugErrFMT('buff类型{0}尚未实现',buffType)
end
end

function airBuffSystem:getBuffEffects(buffCfg,level)
local effects=buffCfg.effects
return effects[level]or effects[#effects]
end

function airBuffSystem:hasBestBuff(lifeEnt,typelookup,infolookup,buffid,level)
if typelookup==nil then return false end
local buffCfg=cfg_airbuffconfig_get(buffid)
local buffType=buffCfg.buffType
local list=typelookup[buffType]
local helpType=buffCfg.helpType
local isHelp=buffCfg.helpType==1
if list==nil then return false end
local effects=airBuffSystem:getBuffEffects(buffCfg,level)
for _,buffguid in ipairs(list)do
local buffInfo=infolookup[buffguid]
local buffid_=buffInfo.buffid
local level_=buffInfo.level
local buffCfg_=cfg_airbuffconfig_get(buffid_)
local effects1=buffCfg_.effects[level_]
local canCompare=buffType==buffCfg_.buffType and
airBuffSystem:compareBuffEffect(lifeEnt,buffType,effects,effects1)
if canCompare then
local isBetter=airBuffSystem:isBestBuffEffect(lifeEnt,buffid,effects,buffid_,effects1,isHelp)
if isBetter then
return true
end
end
end
return false
end

function airBuffSystem:addBuffEffectList(lifeEnt,list)
if list==nil then return nil end
local effectLookup={}
local layer={}
for _,buffInfo in ipairs(list)do
local buffid=buffInfo.buffid
local buffCfg=cfg_airbuffconfig_get(buffid)
local effectOverlay=buffCfg.effectOverlay
if layer[buffid]==nil or layer[buffid]<=effectOverlay then
local buffguid=buffInfo.buffguid
local level=buffInfo.level
local effects1=buffCfg.effects[level]
if effectLookup[buffid]==nil then effectLookup[buffid]={}end
effectLookup[buffid]=airBuffSystem:calculationBuffEffectList(lifeEnt,buffCfg.buffType,effectLookup[buffid],buffguid,effects1)
end
end
return effectLookup
end

function airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,addIndexs)
local effectList={}
local has=false
for i,neweffect in ipairs(neweffectlist)do
if airBuffSystem:compareBuffEffect(lifeEnt,buffType,neweffect,oldeffect)then
for _,v in ipairs(addIndexs)do
neweffect[v]=neweffect[v]+oldeffect[v]
end

neweffect.guids=neweffect.guids or{}
neweffect.guids[buffguid]=true

effectList[#effectList+1]=neweffect
has=true
else
effectList[#effectList+1]=neweffect
end
end
if not has then
local effect=table.weakCopy(oldeffect)

effect.guids={}
effect.guids[buffguid]=true

effectList[#effectList+1]=effect
end
return effectList
end


function airBuffSystem:onAddChangeAttrBuff(lifeEnt,buffType,effects)
local attrid=effects[1]
local value=effects[2]
lifeEnt:onBuffAddAttr(attrid,value)
end

function airBuffSystem:onRemoveChangeAttrBuff(lifeEnt,buffType,effects,buffInfo)
local attrid=effects[1]
local value=effects[2]
lifeEnt:onBuffRemoveAttr(buffType,attrid,value)
end

function airBuffSystem:isBetterAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
local attrLookup=lifeEnt:getAttrs()
local newattrid=neweffect[1]
local oldattrid=oldeffect[1]

if newattrid~=oldattrid then return false,false end

local curValue=attrLookup[oldattrid]

local oldAddValue=oldeffect[2]

local oldValue=curValue
if oldAddValue>0 then
oldValue=oldValue+oldAddValue
end

local newAddValue=neweffect[2]
local newValue=curValue
if newAddValue>0 then
newValue=newValue+newAddValue
end

if isHelp then
return newValue>oldValue,true
end

return newValue<oldValue,true
end

function airBuffSystem:addAttrBuffEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{2})
end

function airBuffSystem:isSameAtrrBuff(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]
end



function airBuffSystem:onEntityDeadDrop(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.ekillEnemyPickUpDrop
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local ratio=effect[1]
if mathHelper.randomLimit(0,10000,ratio)then
role:startCollectDrop(entity)
end
end
end
end
end

function airBuffSystem:isBestKillEnemyPickUpDropBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]==nil then return false end
return isHelp and neweffect[1]>oldeffect[1]or
neweffect[1]<oldeffect[1]
end

function airBuffSystem:addKillEnemyPickUpDropEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
local effectList={}
local has=false
for i,neweffect in ipairs(neweffectlist)do
if airBuffSystem:compareBuffEffect(lifeEnt,buffType,neweffect,oldeffect)then
neweffect[1]=neweffect[1]+oldeffect[1]

neweffect.guids=neweffect.guids or{}
neweffect.guids[buffguid]=true

effectList[#effectList+1]=neweffect

has=true
else
effectList[#effectList+1]=neweffect
end
end
if not has then
local effect=table.weakCopy(oldeffect)

effect.guids={}
effect.guids[buffguid]=true

effectList[#effectList+1]=effect
end
return effectList
end


function airBuffSystem:onAddChangeSpeedBuff(lifeEnt,buffType,effects)
local value_P=effects[1]
lifeEnt:addAttrValue(aiAttributeType.eAddMoveSpeed,value_P)
end

function airBuffSystem:onRemoveChangeSpeedBuff(lifeEnt,buffType,effects)
local value_P=effects[1]
lifeEnt:addAttrValue(aiAttributeType.eAddMoveSpeed,-value_P)
end

function airBuffSystem:isBetterChangeSpeedBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]==nil then return false end
return isHelp and neweffect[1]>oldeffect[1]or
neweffect[1]<oldeffect[1]
end

function airBuffSystem:addChangeSpeedEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
local effectList={}
local has=false
for i,neweffect in ipairs(neweffectlist)do
if airBuffSystem:compareBuffEffect(lifeEnt,buffType,neweffect,oldeffect)then
neweffect[1]=neweffect[1]+oldeffect[1]

neweffect.guids=neweffect.guids or{}
neweffect.guids[buffguid]=true
effectList[#effectList+1]=neweffect
has=true
else
effectList[#effectList+1]=neweffect
end
end
if not has then
local effect=table.weakCopy(oldeffect)
effect.guids={}
effect.guids[buffguid]=true
effectList[#effectList+1]=effect
end
return effectList
end



function airBuffSystem:getSpecialTargetAddDamage(teamType,entityType)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0,0,0,false end

local buffType=eBuffType.eAddSpecificUnitDamage
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local damageValue=0
local damageValue_P=0
local hpValue_P=0
local damageLimit=true
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local teamType_=effect[1]
if teamType_==-1 or teamType_==teamType then
local entityType_=effect[2]
if entityType_==-1 or entityType==entityType_ then
damageValue=damageValue+(effect[3]or 0)
damageValue_P=damageValue_P+(effect[4]or 0)
hpValue_P=hpValue_P+(effect[5]or 0)
damageLimit=damageLimit and effect[6]==1
end
end
end
end
return damageValue,damageValue_P,hpValue_P,not damageLimit
end
return 0,0,0,false
end


function airBuffSystem:isBetterAddSpecificUnitDamageBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
local teamType=neweffect[1]
local entityType=neweffect[2]
local damageValue=neweffect[3]
local damageValue_P=neweffect[4]
local hpValue_P=neweffect[5]

local teamType_=oldeffect[1]
local entityType_=oldeffect[2]
local damageValue_=oldeffect[3]
local damageValue_P_=oldeffect[4]
local hpValue_P_=oldeffect[5]

if teamType==teamType_ and entityType==entityType_ then
if damageValue~=0 then
return isHelp and damageValue>damageValue_ or damageValue<damageValue_
elseif damageValue_P~=0 then
return isHelp and damageValue_P>damageValue_P_ or damageValue_P<damageValue_P_
elseif hpValue_P_~=0 then
return isHelp and hpValue_P>hpValue_P_ or hpValue_P<hpValue_P_
end
end
return false
end

function airBuffSystem:calculationSpecificUnitDamageEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{3,4,5})
end

function airBuffSystem:compareSpecificUnitDamageEffect(lifeEnt,neweffect,oldeffect)
local teamType=neweffect[1]
local entityType=neweffect[2]
local teamType_=oldeffect[1]
local entityType_=oldeffect[2]
return teamType==teamType_ and entityType==entityType_
end


function airBuffSystem:onRoleKillEnemy(entity,isCirtical)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eMomentCastSkill
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
if isCirtical then
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.eCirticalkillEnemy)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eCirticalkillEnemy then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect)
end
end
end
end
else
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.ekillEnemy)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.ekillEnemy then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect)
end
end
end
end
end
end


local buffType=eBuffType.eMomentChangeAttr
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
if isCirtical then
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.eCirticalkillEnemy)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eCirticalkillEnemy then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local attrid2=effect[6]
if attrid2>0 then
local attrValue=role:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
role:onBuffAddAttr(attrid,addValue)
role:useBuffList(effect.guids)
end
end
end
end
else
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.ekillEnemy)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.ekillEnemy then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]

local attrid2=effect[7]
if attrid2>0 then
local attrValue=role:getAttrValue(attrid2)
local addValue2=math.floor(effect[8]/10000*attrValue)
addValue=addValue+addValue2
end
role:onBuffAddAttr(attrid,addValue)
end
end
end
end
end
end


local buffType=eBuffType.eStatusCastSkill
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffStatus.eDead)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffStatus.eDead then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect)
end
end
end
end
end

local buffType=eBuffType.eStatusChangeAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffStatus.eDead)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffStatus.eDead then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=isRole and role:getAttrValue(attrid2)or
entity:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if addValue~=0 then
if isRole then
role:addAttrValue(attrid,addValue)
role:useBuffList(effect.guids)
else
entity:addAttrValue(attrid,addValue)
entity:useBuffList(effect.guids)
end
end
end
end
end
end
end
end

function airBuffSystem:getSkillTypeByBuffMoment(momentType)
if momentType==eBuffMoment.eCastVocSkill then
return eAirSkillType.eVocSkill
elseif momentType==eBuffMoment.eCastWeaponSkill then
return eAirSkillType.eWeaponSkill
elseif momentType==eBuffMoment.eCastMountSkill then
return eAirSkillType.eMountSkill
end
end

function airBuffSystem:getBuffMomentBySkillType(skillType)
if skillType==eAirSkillType.eVocSkill then
return eBuffMoment.eCastVocSkill
elseif skillType==eAirSkillType.eVocSkill then
return eBuffMoment.eCastWeaponSkill
elseif skillType==eAirSkillType.eMountSkill then
return eBuffMoment.eCastMountSkill
end
end

function airBuffSystem:onCastSkill(entity,skillid,isTriggerCast)
if entity==nil or entity:isDeleteSelf()then return end
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eMomentChangeAttr
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local skillType=cfgHelper.get2(cfg_airskillconfig_get,skillid,'skillType')
if skillType==eAirSkillType.eVocSkill or skillType==eAirSkillType.eWeaponSkill or skillType==eAirSkillType.eMountSkill then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local skillType_=airBuffSystem:getSkillTypeByBuffMoment(effect[1])
if skillType==skillType_ then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=isRole and role:getAttrValue(attrid2)or
entity:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if addValue~=0 then
if isRole then
role:addAttrValue(attrid,addValue)
role:useBuffList(effect.guids)
else
entity:addAttrValue(attrid,addValue)
entity:useBuffList(effect.guids)
end
end
end
end
end
end
end
end






















end

function airBuffSystem:castSkill(entity,role,effect,target)
local isRole=effect[4]==1
local skillid=effect[3]
local args={}
local coolType=effect[6]
local force=coolType==0
if force then
args.coolType=coolType
end
args.isTriggerCast=true

if isRole or entity.handle==role.handle then
local skillType=effect[5]
if skillType==1 then
role:castVocSkill(args)
if force then
UIManager:callWindowFunc('UIAirMiniGameMainWin','freshRoleSkillCool')
end
elseif skillType==2 then
role:castMountSkill(args)
if force then
UIManager:callWindowFunc('UIAirMiniGameMainWin','freshMountSkillCool')
end
else





role:castSkill(skillid,target,args)
end
role:useBuffList(effect.guids)
else





entity:castSkill(skillid,nil,args)
entity:useBuffList(effect.guids)
end
end

function airBuffSystem:isBetterMomentCastSkillBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=momentType then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[3]~=oldeffect[3]then return false end
if neweffect[4]~=oldeffect[4]then return false end
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end

function airBuffSystem:calculationMomentCastSkillEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{2})
end

function airBuffSystem:compareMomentCastSkillEffect(lifeEnt,neweffect,oldeffect,momentType)
return momentType==neweffect[1]and
neweffect[1]==oldeffect[1]and
neweffect[3]==oldeffect[3]and
neweffect[4]==oldeffect[4]
end



function airBuffSystem:isBetterStatusCastSkillBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=momentType then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[3]~=oldeffect[3]then return false end
if neweffect[4]~=oldeffect[4]then return false end
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end

function airBuffSystem:calculationStatusCastSkillEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{2})
end

function airBuffSystem:compareStatusCastSkillEffect(lifeEnt,neweffect,oldeffect,momentType)
return momentType==neweffect[1]and
neweffect[1]==oldeffect[1]and
neweffect[3]==oldeffect[3]and
neweffect[4]==oldeffect[4]
end


function airBuffSystem:isBetterMomentChangeAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp,momentType)
if neweffect[1]~=momentType then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[3]~=oldeffect[3]then return false end
if neweffect[6]~=oldeffect[6]then return false end
if neweffect[7]~=oldeffect[7]then return false end
local newValue=neweffect[4]or 0
local newValue_P=neweffect[5]or 0
local newValue2=neweffect[8]or 0

local oldValue=oldeffect[4]or 0
local oldValue_P=oldeffect[5]or 0
local oldValue2=oldeffect[8]or 0

if oldValue2==newValue2 then
if newValue_P==oldValue_P then
return isHelp and newValue>oldValue or newValue<oldValue
end
return isHelp and newValue_P>oldValue_P or newValue_P<oldValue_P
else
return isHelp and newValue2>oldValue2 or newValue2<oldValue2
end
end

function airBuffSystem:calculationMomentChangeAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,momentType)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{4,5,8})
end

function airBuffSystem:compareMomentMomentChangeAttrEffect(lifeEnt,neweffect,oldeffect,momentType)
return momentType==neweffect[1]and
neweffect[1]==oldeffect[1]and
neweffect[3]==oldeffect[3]and
neweffect[6]==oldeffect[6]and
neweffect[7]==oldeffect[7]
end


function airBuffSystem:onAddStatusChangeAttrBuff(lifeEnt,buffType,effects)
if not lifeEnt:isIdle()then return end
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end
local buffType=eBuffType.eStatusChangeAttr
local hasBuff=lifeEnt:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=lifeEnt:calculationBuffEffectList(buffType,eBuffStatus.eIdle)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffStatus.eIdle then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=isRole and role:getAttrValue(attrid2)or
lifeEnt:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if addValue~=0 then
if isRole then
role:addAttrValue(attrid,addValue)
role:useBuffList(effect.guids)
else
lifeEnt:addAttrValue(attrid,addValue)
lifeEnt:useBuffList(effect.guids)
end
end


end
end
end
end
end
end

function airBuffSystem:onRemoveStatusChangeAttrBuff(lifeEnt,buffType,effects)
if not lifeEnt:isIdle()then return end
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end
local buffType=eBuffType.eStatusChangeAttr
local hasBuff=lifeEnt:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=lifeEnt:calculationBuffEffectList(buffType,eBuffStatus.eIdle)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffStatus.eIdle then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=isRole and role:getAttrValue(attrid2)or
lifeEnt:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if addValue~=0 then
if isRole then
role:addAttrValue(attrid,-addValue)
else
lifeEnt:addAttrValue(attrid,-addValue)
end
end
end
end
end
end
end
end

function airBuffSystem:isBetterStatusChangeAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp,momentType)
if neweffect[1]~=momentType then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[3]~=oldeffect[3]then return false end
if neweffect[6]~=oldeffect[6]then return false end
local newValue=neweffect[4]or 0
local newValue_P=neweffect[5]or 0
local oldValue=oldeffect[4]or 0
local oldValue_P=oldeffect[5]or 0
if newValue_P==oldValue_P then
return isHelp and newValue>oldValue or newValue<oldValue
end
return isHelp and newValue_P>oldValue_P or newValue_P<oldValue_P
end

function airBuffSystem:calculationStatusChangeAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{4,5})
end

function airBuffSystem:compareStatusChangeAttrEffect(lifeEnt,neweffect,oldeffect,momentType)
return momentType==neweffect[1]and
neweffect[1]==oldeffect[1]and
neweffect[3]==oldeffect[3]and
neweffect[6]==oldeffect[6]and
neweffect[7]==oldeffect[7]
end



function airBuffSystem:onDodge(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eMomentCastSkill
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffMoment.eDodge)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eDodge then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect)
end
end
end
end
end


local buffType=eBuffType.eMomentChangeAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffMoment.eDodge)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eDodge then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=role:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if isRole then
role:onBuffAddAttr(attrid,addValue)
role:useBuffList(effect.guids)
else
entity:onBuffAddAttr(attrid,addValue)
entity:useBuffList(effect.guids)
end
end

end
end
end
end
end


function airBuffSystem:onDamage(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eMomentCastSkill
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffMoment.eOnDamage)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eOnDamage then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect)
end
end
end
end
end


local buffType=eBuffType.eMomentChangeAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffMoment.eOnDamage)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eOnDamage then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=role:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if isRole then
role:onBuffAddAttr(attrid,addValue)
role:useBuffList(effect.guids)
else
entity:onBuffAddAttr(attrid,addValue)
entity:useBuffList(effect.guids)
end
end
end
end
end
end
end


function airBuffSystem:onRoleAttack(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eAttackRatioAddBuff
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local ratio=effect[1]
if mathHelper.randomLimit(0,10000,ratio)then
local buffid=effect[2]
local level=effect[3]
airBuffSystem:addBuff(entity,buffid,level,role)
end
end
end
end
end

function airBuffSystem:isBetterAttackAddBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
if neweffect[3]==oldeffect[3]then
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
else
return isHelp and neweffect[3]>oldeffect[3]or neweffect[3]<oldeffect[3]
end
end

function airBuffSystem:calculationAttackAddBuffEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1})
end

function airBuffSystem:compareAttackRatioAddBuffEffect(lifeEnt,neweffect,oldeffect)
return neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]
end


function airBuffSystem:onRoleCollectDrop(role,dropid_)
if role:isDeleteSelf()then return end

local buffType=eBuffType.ePickUpDropChangeAttr
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
local cfg=cfg_airdropconfig_get(dropid_)
for _,effect in ipairs(effectList)do
local dropid=effect[1]
if dropid==dropid_ then
local type1=effect[2]
local type2=effect[3]
if type1==-1 or cfg.type1==type1 or
type2==-1 or cfg.type2==type2 then
local ratio=effect[4]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[5]
local addValue=effect[6]or 0
local addValue_p=effect[7]or 0
local attrid_2=effect[8]
local attr2Value=role:getAttrValue(attrid_2)
local addValue_2=math.floor(effect[9]/10000*attr2Value)
addValue=addValue+addValue_2
if attrid==aiAttributeType.eHP then
local restoreHP=airDropSystem:getRestoreHP(role,dropid)
local addValue_,addValue_p_=airBuffSystem:getAddXiaoHaoPinRestoreEffect()
addValue=addValue+addValue_
if restoreHP>0 and addValue_p_>0 then
addValue=addValue+restoreHP*addValue_p_/10000
end
end
role:onBuffAddAttr(attrid,addValue)
end
end
end
end
end
end

airBuffSystem:changeAttrOnCollectDropByHpLimitAttr(role,dropid_)
end


function airBuffSystem:getAddXiaoHaoPinRestoreEffect()
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0,0 end
local buffType=eBuffType.eAddXiaoHaoPinRestore
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local effect=effectList[1]
return effect[1]or 0,effect[2]or 0
end
end
return 0,0
end

function airBuffSystem:isBetterPickUpDropChangeAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
local dropid=oldeffect[1]
local type1=oldeffect[2]
local type2=oldeffect[3]
local ratio=oldeffect[4]
local attrid=oldeffect[5]
local addValue=oldeffect[6]
local addValue_P=oldeffect[7]
local addValue2=oldeffect[9]

local dropid_=neweffect[1]
local type1_=neweffect[2]
local type2_=neweffect[3]
local ratio_=neweffect[4]
local attrid_=neweffect[5]
local addValue_=neweffect[6]
local addValue_P_=neweffect[7]
local addValue2_=neweffect[9]

if dropid~=dropid_ or
type1~=type1_ or
type2~=type2_ or
attrid~=attrid_ or
ratio~=ratio_ or
neweffect[8]~=oldeffect[8]then
return false
end
if addValue2==addValue2_ then
if addValue_P_==addValue_P then
return isHelp and addValue_>addValue or addValue_<addValue
end
return isHelp and addValue_P_>addValue_P or addValue_P_<addValue_P
else
return isHelp and addValue2>addValue2_ or addValue2<addValue2_
end
end

function airBuffSystem:calculationPickUpDropChangeAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{6,7,9})
end

function airBuffSystem:comparePickUpDropChangeAttrEffect(lifeEnt,neweffect,oldeffect)
local dropid=oldeffect[1]
local type1=oldeffect[2]
local type2=oldeffect[3]
local ratio=oldeffect[4]
local attrid=oldeffect[5]
local attrid2=neweffect[8]

local dropid_=neweffect[1]
local type1_=neweffect[2]
local type2_=neweffect[3]
local ratio_=neweffect[4]
local attrid_=neweffect[5]
local attrid2_=neweffect[8]

return dropid==dropid_ and
type1==type1_ and
type2==type2_ and
attrid==attrid_ and
attrid2==attrid2_ and
ratio==ratio_

end


function airBuffSystem:isBetterAddXiaoHaoPinRestoreBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
local newValue=neweffect[1]or 0
local newValue_P=neweffect[2]or 0
local oldValue=oldeffect[1]or 0
local oldValue_P=oldeffect[2]or 0
if oldValue~=0 then
return isHelp and newValue>oldValue or newValue<oldValue
else
return isHelp and newValue_P>oldValue_P or newValue_P<oldValue_P
end
end

function airBuffSystem:calculationAddXiaoHaoPinRestoreEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1,2})
end




function airBuffSystem:getAddItemPrice(type,itemid,itemType)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0,0 end
local buffType=eBuffType.eChangeItemPrice
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local addValue=0
local addValue_P=0
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
if effect[1]==type then
if effect[2]==-1 or effect[2]==itemid then
local itemCfg
if itemType==1 then
itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemid)
elseif itemType==2 then
itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemid)
end
local type1=itemCfg.type1
local type2=itemCfg.type2
if effect[3]==-1 or effect[3]==type1 and effect[4]==-1 and effect[4]==type2 then
addValue=addValue+(effect[5]or 0)
addValue_P=addValue_P+(effect[6]or 0)
end
end
end
end
end
return addValue,addValue_P
end
return 0,0
end

function airBuffSystem:isBetterChangeItemPriceBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
local typo=neweffect[1]
local itemid=neweffect[2]or 0
local type1=neweffect[3]or 0
local type2=neweffect[4]or 0
local addVaue=neweffect[5]or 0
local addVaue_p=neweffect[6]or 0

local typo_=oldeffect[1]
local itemid_=oldeffect[2]or 0
local type1_=oldeffect[3]or 0
local type2_=oldeffect[4]or 0
local addVaue_=oldeffect[5]or 0
local addVaue_p_=oldeffect[6]or 0

if typo_~=typo or
itemid~=itemid_ or
type1~=type1_ or
type2~=type2_ then
return false
end

if addVaue_p_==addVaue_p then
return isHelp and addVaue>addVaue_ or addVaue<addVaue_
else
return isHelp and addVaue_p>addVaue_p_ or addVaue_p<addVaue_p_
end
end

function airBuffSystem:calculationChangeItemPriceEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{5,6})
end

function airBuffSystem:compareChangeItemPriceEffect(lifeEnt,neweffect,oldeffect)
local typo=neweffect[1]
local itemid=neweffect[2]or 0
local type1=neweffect[3]or 0
local type2=neweffect[4]or 0

local typo_=oldeffect[1]
local itemid_=oldeffect[2]or 0
local type1_=oldeffect[3]or 0
local type2_=oldeffect[4]or 0

return typo_==typo and
itemid==itemid_ and
type1==type1_ and
type2==type2_
end


function airBuffSystem:onLevelStart()
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end
local buffType=eBuffType.eForceHP
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList==nil or#effectList==0 then return end
local effect=effectList[1]
local value=effect[1]or 0
local value_P=effect[2]or 0
if value_P>0 then
local maxhp=role:getMaxHP()
role:setHP(math.floor(maxhp*value_P/10000))
else
if value>0 then
role:setHP(effect[1])
end
end
end

local buffType=eBuffType.eSpeMoneyUniqueBuff
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList==nil or#effectList==0 then return end
local effect=effectList[1]
local value_P=effect[1]or 0
if value_P~=0 then
local money=airModel:getMoney()
local add=math.floor(money*value_P/10000)
airModel:addMoney(add)
end
end


local buffType=eBuffType.eMomentCastSkill
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eLevelStart then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(role,role,effect)
end
end
end
end
end


local buffType=eBuffType.eMomentChangeAttr
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eLevelStart then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local attrid2=effect[6]
if attrid2>0 then
local attrValue=role:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
role:onBuffAddAttr(attrid,addValue)
role:useBuffList(effect.guids)
end
end
end
end
end
end


function airBuffSystem:onLevelEnd()
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end


local buffType=eBuffType.eMomentChangeAttr
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.eLevelEnd)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eLevelEnd then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local attrid2=effect[6]
if attrid2>0 then
local attrValue=role:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
role:onBuffAddAttr(attrid,addValue)
role:useBuffList(effect.guids)
end
end
end
end
end


local buffType=eBuffType.eMomentCastSkill
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eLevelEnd then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(role,role,effect)
end
end
end
end
end
end

function airBuffSystem:isBetterForceHPBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
return isHelp and neweffect[1]>oldeffect[1]or
neweffect[1]<oldeffect[1]
end


function airBuffSystem:calculationForceHPEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1,2})
end





function airBuffSystem:onDyingRebirth(entity)
local buffType=eBuffType.eDyingRebirth
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType)

if effectList then
local max=0
for _,effect in ipairs(effectList)do
local add=effect[1]
if add>max then max=add end
end
local add=math.floor(entity:getMaxHP()*max/10000)

entity:onRevive(add)
return true
end
end
end
function airBuffSystem:isBetterDyingRebirthBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
end

function airBuffSystem:calculationDyingRebirthBuff(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
local effectList={}
for i,neweffect in ipairs(neweffectlist)do
effectList[#effectList+1]=neweffect
end
local effect=table.weakCopy(oldeffect)

effect.guids={}
effect.guids[buffguid]=true

effectList[#effectList+1]=effect
return effectList
end




function airBuffSystem:getSkillAddDamage(entity,skillCfg)
local buffType=eBuffType.eChangeSkillDamage
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local addValue=0
local addValue_P=0
local effectList=entity:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local ratio=effect[1]
if mathHelper.randomLimit(0,10000,ratio)then
local hurtType=effect[2]
if hurtType==-1 or skillCfg.hurtType==hurtType then
local hurtType2=effect[3]
if hurtType2==-1 or skillCfg.hurtType2==hurtType2 then
addValue=addValue+(effect[4]or 0)
addValue_P=addValue_P+(effect[5]or 0)
end
end
end
end
end
return addValue,addValue_P
end
return 0,0
end

function airBuffSystem:isBetterChangeSkillDamageBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
if neweffect[2]~=oldeffect[2]then return false end
if neweffect[3]~=oldeffect[3]then return false end
local addValue=neweffect[4]or 0
local addValue_P=neweffect[5]or 0
local addValue_=oldeffect[4]or 0
local addValue_P_=oldeffect[5]or 0
if addValue_P==addValue_P_ then
return isHelp and addValue>addValue_ or addValue<addValue_
end
return isHelp and addValue_P>addValue_P_ or addValue_P<addValue_P_
end

function airBuffSystem:calculationChangeSkillDamageEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{4,5})
end

function airBuffSystem:compareChangeSkillDamageEffect(lifeEnt,neweffect,oldeffect)
return neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]
end


function airBuffSystem:getSkillAddRange(entity,skillCfg)
local buffType=eBuffType.eChangeSkillRange
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local addValue=0
local addValue_P=0
local effectList=entity:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local ratio=effect[1]
if mathHelper.randomLimit(0,10000,ratio)then
local hurtType=effect[2]
if hurtType==-1 or skillCfg.hurtType==hurtType then
local hurtType2=effect[3]
if hurtType2==-1 or skillCfg.hurtType2==hurtType2 then
addValue=addValue+(effect[4]or 0)
addValue_P=addValue_P+(effect[5]or 0)
end
end
end
end
end
return addValue,addValue_P
end
return 0,0
end

function airBuffSystem:isBetterChangeSkillRangeBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
if neweffect[2]~=oldeffect[2]then return false end
if neweffect[3]~=oldeffect[3]then return false end
local addValue=neweffect[4]or 0
local addValue_P=neweffect[5]or 0
local addValue_=oldeffect[4]or 0
local addValue_P_=oldeffect[5]or 0
if addValue_P==addValue_P_ then
return isHelp and addValue>addValue_ or addValue<addValue_
end
return isHelp and addValue_P>addValue_P_ or ddValue_P<addValue_P_
end

function airBuffSystem:calculationChangeSkillRangeEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{4,5})
end

function airBuffSystem:compareChangeSkillRangeEffect(lifeEnt,neweffect,oldeffect)
return neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]
end



function airBuffSystem:getAddSpeFreshTime(monsterid)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0,0 end
local buffType=eBuffType.eChangeMonsterRefreshTime
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local addValue=0
local addValue_P=0
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
for _,effect in ipairs(effectList)do
local monsterid_=effect[2]
if monsterid_==-1 or monsterid==monsterid_ then
local cfg=cfg_airemonsterconfig_get(monsterid)
local monsterType2=cfg.monsterType2
local monsterType2_=effect[1]
if monsterType2_==-1 or monsterType2==monsterType2_ then
addValue=addValue+(effect[3]or 0)
addValue_P=addValue_P+(effect[4]or 0)
end
end
end
end
return addValue,addValue_P
end
return 0,0
end

function airBuffSystem:isBetterChangeMonsterRefreshTimeBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[2]~=oldeffect[2]then return false end
local addValue=neweffect[3]or 0
local addValue_P=neweffect[4]or 0
local addValue_=oldeffect[3]or 0
local addValue_P_=oldeffect[4]or 0
if addValue_P==addValue_P_ then
return isHelp and addValue>addValue_ or addValue<addValue_
end
return isHelp and addValue_P>addValue_P_ or addValue_P<addValue_P_
end

function airBuffSystem:calculationChangeMonsterRefreshTimeEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{3,4})
end

function airBuffSystem:compareChangeMonsterRefreshTimeEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and
neweffect[2]==oldeffect[2]
end


function airBuffSystem:getAddDropMulti(dropid)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0 end
local buffType=eBuffType.eChangePickUpGain
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local multi=0
local effectList=role:calculationBuffEffectList(buffType)
if effectList then
local cfg=cfg_airdropconfig_get(dropid)
for _,effect in ipairs(effectList)do
local dropid_=effect[1]
if dropid==dropid_ then
local type1=effect[2]
local type2=effect[3]
if type1==-1 or cfg.type1==type1 or
type2==-1 or cfg.type2==type2 then
local ratio=effect[4]
if mathHelper.randomLimit(0,10000,ratio)then
multi=multi+effect[5]
end
end
end
end
end
return multi
end
return 0
end

function airBuffSystem:isBetterChangePickUpGainBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect==nil or#neweffect==0 then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[2]~=oldeffect[2]then return false end
if neweffect[3]~=oldeffect[3]then return false end
local addValue=neweffect[4]or 0
local addValue_P=neweffect[5]or 0
local addValue_=oldeffect[4]or 0
local addValue_P_=oldeffect[5]or 0
if addValue_P==addValue_P_ then
return isHelp and addValue>addValue_ or addValue<addValue_
end
return isHelp and addValue_P>addValue_P_ or addValue_P<addValue_P_
end

function airBuffSystem:calculationChangePickUpGainEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{5})
end

function airBuffSystem:compareChangePickUpGainEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and
neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]
end


function airBuffSystem:isBetterSpeMoneyUniqueBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
end

function airBuffSystem:calculationSpeMoneyUniqueEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1})
end



function airBuffSystem:onFreshShop(use)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0,0 end
local buffType=eBuffType.eAddShopDiscount
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local effect=effectList[1]
local addValue=effect[1]
local addValue_P=effect[2]
if use then
role:useBuffList(effect.guids)
end
return addValue,addValue_P
end
end
return 0,0
end

function airBuffSystem:isBetterAddShopDiscountBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[2]==oldeffect[2]then
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
end
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end

function airBuffSystem:calculationAddShopDiscountEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1,2})
end




function airBuffSystem:getConvertAttrToDamageBuff(entity)
local buffType=eBuffType.eConvertAttrToDamage
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local addValue_P=0
local effectList=entity:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local t={}
for i,v in ipairs(effectList)do
local attr1=v[1]
local attrValue=entity:getAttrValue(attr1)
t[attr1]=attrValue
end

for i,v in ipairs(effectList)do
local attr1=v[1]
local perValue=v[2]
local value_p=v[3]
local attrValue=t[attr1]
addValue_P=addValue_P+math.floor(attrValue/perValue)*value_p
end
return addValue_P
end
end
return 0
end

function airBuffSystem:addConvertAttrBuff(lifeEnt,buffType,effects)
lifeEnt:initConvertAttr()
end

function airBuffSystem:removeConvertAttrBuff(lifeEnt,buffType,effects)
lifeEnt:initConvertAttr()
end

function airBuffSystem:isBetterConvertAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
return isHelp and neweffect[3]>oldeffect[3]or neweffect[3]<oldeffect[3]
end

function airBuffSystem:calculationConvertAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{3})
end

function airBuffSystem:compareConvertAttrEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and
neweffect[2]==oldeffect[2]
end



function airBuffSystem:onEntityIdle(entity,flag)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end
local buffType=eBuffType.eStatusChangeAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffStatus.eIdle)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffStatus.eIdle then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=isRole and role:getAttrValue(attrid2)or
entity:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end


if addValue~=0 then
if isRole then
role:addAttrValue(attrid,flag and addValue or-addValue)
if flag then
role:useBuffList(effect.guids)
end
else
entity:addAttrValue(attrid,flag and addValue or-addValue)
if flag then
entity:useBuffList(effect.guids)
end
end
end

end
end
end
end
end
end





function airBuffSystem:getAddDropMultiByKillEnemy(dropid,isCirtical)

local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0 end
local buffType=eBuffType.eMomentChangeDrop
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local multi=0
if isCirtical then
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.eCirticalkillEnemy)
if effectList then
local cfg=cfg_airdropconfig_get(dropid)
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eCirticalkillEnemy then
local dropid_=effect[2]
if dropid==dropid_ then
local type1=effect[3]
local type2=effect[4]
if type1==-1 or cfg.type1==type1 or
type2==-1 or cfg.type2==type2 then
local ratio=effect[5]
if mathHelper.randomLimit(0,10000,ratio)then
multi=multi+effect[6]
end
end
end
end
end
end
else
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.ekillEnemy)
if effectList then
local cfg=cfg_airdropconfig_get(dropid)
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.ekillEnemy then
local dropid_=effect[2]
if dropid==dropid_ then
local type1=effect[3]
local type2=effect[4]
if type1==-1 or cfg.type1==type1 or
type2==-1 or cfg.type2==type2 then
local ratio=effect[5]
if mathHelper.randomLimit(0,10000,ratio)then
multi=multi+effect[6]
end
end
end
end
end
end
end
return multi
end
return 0
end

function airBuffSystem:isBetterMomentChangeDropBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp,momentType)
if neweffect[1]~=momentType then return false end
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[2]~=oldeffect[2]then return false end
if neweffect[3]~=oldeffect[3]then return false end
if neweffect[4]~=oldeffect[4]then return false end
if neweffect[5]~=oldeffect[5]then return false end
return isHelp and neweffect[6]>oldeffect[6]or neweffect[6]<oldeffect[6]
end

function airBuffSystem:calculationMomentChangeDropEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{6})
end

function airBuffSystem:compareMomentChangeDropEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and
neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]and
neweffect[4]==oldeffect[4]and
neweffect[5]==oldeffect[5]
end



function airBuffSystem:onAddChiXuDamageBuff(lifeEnt,buffType,effects,buffInfo)
lifeEnt:addChiXuDamage(buffInfo,effects)
end

function airBuffSystem:onRemoveChiXuDamageBuff(lifeEnt,buffType,effects,buffInfo)
lifeEnt:removeChiXuDamage(buffInfo)
end

function airBuffSystem:isBetterChiXuDamageBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[2]==oldeffect[2]then
if neweffect[3]==oldeffect[3]then
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
else
return isHelp and neweffect[3]>oldeffect[3]or neweffect[3]<oldeffect[3]
end
elseif neweffect[3]==oldeffect[3]then
if neweffect[2]==oldeffect[2]then
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
else
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end
else
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end
end

function airBuffSystem:calculationChiXuDamageEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1,2,3})
end


function airBuffSystem:getAllConvertAttrToAttrBuff(entity)
local buffType=eBuffType.eConvertAttrToAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local lookup={}
local t={}
for i,v in ipairs(effectList)do
local attr1=v[1]
local attrValue=entity:getAttrValue(attr1)
t[attr1]=attrValue
end

for i,v in ipairs(effectList)do
local attr1=v[1]
local perValue=v[2]
local attr2=v[3]
local value=v[4]
local attrValue=t[attr1]
local multi=math.floor(attrValue/perValue)
local addValue=multi*value

if addValue>0 then
local old=lookup[attr2]or 0
lookup[attr2]=old+addValue
end
end

return lookup
end
end
return{}
end

function airBuffSystem:addAttrAddAttrBuff(lifeEnt,buffType,effects)
lifeEnt:initConvertAttr()
end

function airBuffSystem:removeAttrAddAttrBuff(lifeEnt,buffType,effects)
lifeEnt:initConvertAttr()
end

function airBuffSystem:isBettereAttrAddAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[2]~=oldeffect[2]then return false end
if neweffect[3]~=oldeffect[3]then return false end
return isHelp and neweffect[4]>oldeffect[4]or neweffect[4]<oldeffect[4]
end

function airBuffSystem:calculationeAttrAddAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{4})
end

function airBuffSystem:compareAttrAddAttrEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and
neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]
end



function airBuffSystem:getHpLimitAttr(entity,HP,maxHP)
local buffType=eBuffType.eHpLimitAddAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local lookup={}
for i,v in ipairs(effectList)do
local op=v[1]
local limitType=v[2]
local limitValue=v[3]
local enough=false
if op==1 then
if limitType==1 then
if HP<=limitValue then
enough=true
end
elseif limitType==2 then
if HP<=math.floor(limitValue/10000*maxHP)then
enough=true
end
end
elseif op==2 then
if limitType==1 then
if HP>=limitValue then
enough=true
end
elseif limitType==2 then
if HP>=math.floor(limitValue/10000*maxHP)then
enough=true
end
end
end
if enough then
local attrid=v[4]
local addValue=v[5]

if addValue~=0 then
local old=lookup[attrid]or 0
lookup[attrid]=old+addValue
end
end
end
return lookup
end
end
return{}
end

function airBuffSystem:addHpLimitAddAttrBuff(lifeEnt,buffType,effects)
lifeEnt:initHpChangeBuff()
end

function airBuffSystem:removeHpLimitAddAttrBuff(lifeEnt,buffType,effects)
lifeEnt:initHpChangeBuff()
end

function airBuffSystem:isBettereHpLimitAddAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=oldeffect[1]then return false end
if neweffect[2]~=oldeffect[2]then return false end
if neweffect[3]~=oldeffect[3]then return false end
if neweffect[4]~=oldeffect[4]then return false end
return isHelp and neweffect[5]>oldeffect[5]or neweffect[5]<oldeffect[5]
end

function airBuffSystem:calculationeHpLimitAddAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{5})
end

function airBuffSystem:compareHpLimitAddAttrEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and
neweffect[2]==oldeffect[2]and
neweffect[3]==oldeffect[3]and
neweffect[4]==oldeffect[4]
end


function airBuffSystem:addTuPoTopLimitAttrBuff(lifeEnt,buffType,effects)
local attrid=effects[1]
local limitTop=cfg_airattributesconfig_get(attrid).limitTop
if limitTop then
lifeEnt:setAttrTopLimit(attrid,effects[2])
end
end

function airBuffSystem:removeTuPoTopLimitAttrBuff(lifeEnt,buffType,effects)
local attrid=effects[1]
lifeEnt:setAttrTopLimit(attrid,nil)
end

function airBuffSystem:isBettereTuPoTopLimitAttrBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=oldeffect[1]then return false end
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end

function airBuffSystem:calculationeTuPoTopLimitAttrEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
local effectList={}

for i,neweffect in ipairs(neweffectlist)do
effectList[#effectList+1]=neweffect
end
local effect=table.weakCopy(oldeffect)
effect.guids={}
effect.guids[buffguid]=true
effectList[#effectList+1]=effect

return effectList
end



function airBuffSystem:onWeaponAttack(entity,target)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eMomentCastSkill
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType,eBuffMoment.eWeaponAttack)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eWeaponAttack then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect,target)
end
end
end
end
end
end


function airBuffSystem:reflectDamage(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end

local buffType=eBuffType.eMomentCastSkill
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffMoment.eReflect)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eReflect then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
airBuffSystem:castSkill(entity,role,effect)
end
end
end
end
end


local buffType=eBuffType.eMomentChangeAttr
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType,eBuffMoment.eReflect)
if effectList then
for _,effect in ipairs(effectList)do
local momentType=effect[1]
if momentType==eBuffMoment.eReflect then
local ratio=effect[2]
if mathHelper.randomLimit(0,10000,ratio)then
local attrid=effect[3]
local addValue=effect[4]
local isRole=effect[5]==1
local attrid2=effect[6]
if attrid2>0 then
local attrValue=isRole and role:getAttrValue(attrid2)or
entity:getAttrValue(attrid2)
local addValue2=math.floor(effect[7]/10000*attrValue)
addValue=addValue+addValue2
end
if isRole then
role:onBuffAddAttr(attrid,addValue)
role:useBuffList(effect.guids)
else
entity:onBuffAddAttr(attrid,addValue)
entity:useBuffList(effect.guids)
end
end
end
end
end
end
end


function airBuffSystem:addEnterStatusBuff(lifeEnt,buffType,effects)
local statusType=effects[1]
lifeEnt:setBuffStatus(statusType,true)
end

function airBuffSystem:removeEnterStatusBuff(lifeEnt,buffType,effects)
local statusType=effects[1]
lifeEnt:setBuffStatus(statusType,nil)
end

function airBuffSystem:isBetterEnterStatusBuff(lifeEnt,neweffect,oldeffect)
return false
end

function airBuffSystem:calculationEnterStatusEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
loggerUtil.logErrFMT('不能进入这里，类型{0}不能累加，请检查配置',buffType)
end

function airBuffSystem:compareEnterStatusEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]
end


function airBuffSystem:getExpGainBuff()
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return 0,0 end
local buffType=eBuffType.eChangeExpGain
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local addValue=0
local addValue_P=0
for _,effect in ipairs(effectList)do
addValue=addValue+effect[1]
addValue_P=addValue_P+effect[2]
end
return addValue,addValue_P
end
end
return 0,0
end

function airBuffSystem:isBetterChangeExpGainBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[2]==oldeffect[2]then
return isHelp and neweffect[1]>oldeffect[1]or neweffect[1]<oldeffect[1]
end
return isHelp and neweffect[2]>oldeffect[2]or neweffect[2]<oldeffect[2]
end

function airBuffSystem:calculationChangeExpGainEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{1,2})
end




























































function airBuffSystem:getHoldWeaponChangeAttrsBuffAttrs(role)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return{}end
local buffType=eBuffType.eHoldWeaponChangeAttrs
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local cntTable=airBuffSystem:getWeaponCntByType()
local lookup={}
for _,effect in ipairs(effectList)do
local typo=effect[1]
local cnt=cntTable[typo]or 0
local attrid=effect[2]
local addValue=effect[3]*cnt
lookup[attrid]=(lookup[attrid]or 0)+addValue
end
return lookup
end
end
return{}
end

function airBuffSystem:getWeaponCntByType()
local equips=airModel:getEquipList()
local type1Lookup={}
local type12Lookup={}
for _,weaponId in ipairs(equips)do
local weaponCfg=cfg_airweaponconfig_get(weaponId)
local type1=weaponCfg.type1
local type2=weaponCfg.type2
type1Lookup[type1]=true
type12Lookup[type1*100+type2]=true
end

local cnt={}
for k,v in pairs(type1Lookup)do
cnt[1]=(cnt[1]or 0)+1
end
for k,v in pairs(type12Lookup)do
cnt[2]=(cnt[2]or 0)+1
end

return cnt
end

function airBuffSystem:isBetterHoldWeaponChangeAttrsBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=oldeffect[1]or
neweffect[2]~=oldeffect[2]then
return false
end
return isHelp and neweffect[3]>oldeffect[3]or
neweffect[3]<oldeffect[3]
end

function airBuffSystem:calculationHoldWeaponChangeAttrsBuff(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{3})
end

function airBuffSystem:compareHoldWeaponChangeAttrsEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and neweffect[2]==oldeffect[2]or false
end


function airBuffSystem:getOwnerSummonChangeAttrs(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return{}end
local buffType=eBuffType.eOwnerSummonChangeAttrs
local hasBuff=entity:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=entity:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local lookup={}
for _,effect in ipairs(effectList)do
local typo=effect[1]
local attrid=effect[2]
local addValue=effect[3]
if lookup[typo]==nil then lookup[typo]={}end
local lkup=lookup[typo]
lkup[attrid]=(lkup[attrid]or 0)+addValue
end
return lookup
end
end
return{}
end

function airBuffSystem:addOwnerSummonChangeAttrsBuff(lifeEnt,buffType,effects)
lifeEnt:initSummonChangeAttr()
end

function airBuffSystem:removeOwnerSummonChangeAttrsBuff(lifeEnt,buffType,effects)
lifeEnt:initSummonChangeAttr()
end

function airBuffSystem:isBetterOwnerSummonChangeAttrsBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=oldeffect[1]or
neweffect[2]~=oldeffect[2]then
return false
end
return isHelp and neweffect[3]>oldeffect[3]or
neweffect[3]<oldeffect[3]
end

function airBuffSystem:calculationOwnerSummonChangeAttrsBuff(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{3})
end

function airBuffSystem:compareOwnerSummonChangeAttrsEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and neweffect[2]==oldeffect[2]or false
end


function airBuffSystem:getRangeEnemyChangeAttrsAttrs(entity)
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end
local buffType=eBuffType.eRangeEnemyChangeAttrs
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local entityType=entity.entityType
local lookup={}
for _,effect in ipairs(effectList)do
local entityType_=effect[1]
if entityType_==-1 or entityType==entityType_ then
local attrid=effect[2]
local addValue=effect[3]
lookup[attrid]=(lookup[attrid]or 0)+addValue
end
end
return lookup
end
end
end

function airBuffSystem:addRangeEnemyChangeAttrsBuff(lifeEnt,buffType,effects)
local entityType=effects[1]
local attrid=effects[2]
local attrValue=effects[3]
local ents=airEntitySystem:getEntitysByEntityType(entityType)
for i,v in ipairs(ents)do
if v.onBuffAddAttr then
v:onBuffAddAttr(attrid,attrValue)
end
end
end

function airBuffSystem:removeRangeEnemyChangeAttrsBuff(lifeEnt,buffType,effects)
local entityType=effects[1]
local attrid=effects[2]
local attrValue=effects[3]
local ents=airEntitySystem:getEntitysByEntityType(entityType)
for i,v in ipairs(ents)do
if v.onBuffAddAttr then
v:onBuffAddAttr(attrid,-attrValue)
end
end
end

function airBuffSystem:isBettereRangeEnemyChangeAttrsBuff(lifeEnt,buffid,neweffect,buffid_,oldeffect,isHelp)
if neweffect[1]~=oldeffect[1]or
neweffect[2]~=oldeffect[2]then
return false
end
return isHelp and neweffect[3]>oldeffect[3]or
neweffect[3]<oldeffect[3]
end

function airBuffSystem:calculationRangeEnemyChangeAttrsBuff(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
return airBuffSystem:calculationCommonEffect(lifeEnt,buffType,neweffectlist,buffguid,oldeffect,{3})
end

function airBuffSystem:compareRangeEnemyChangeAttrsEffect(lifeEnt,neweffect,oldeffect)
return neweffect[1]==oldeffect[1]and neweffect[2]==oldeffect[2]or false
end


function airBuffSystem:onUpEquipOrAttrs()
local role=airActorSystem:getActor()
if role==nil or role:isDeleteSelf()then return end
local buffType=eBuffType.eUpWeaponOrChangeAttrs
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local equips=airModel:getEquipList()
if#equips>=6 then
local list={}
for i=1,6 do
if airModel:checkEquipIsCanLevelUp(i)then
list[#list+1]=i
end
end
local len=#list
if len>0 then
local index=math.random(1,len)
airController:levelUpEquipItem(list[index])
return
end
end

local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
for _,effect in ipairs(effectList)do
local attrid=effect[1]
local addValue=effect[2]
role:onBuffAddAttr(attrid,addValue)
end
end
end
end

function airBuffSystem:calculationUpWeaponOrChangeAttrsBuff(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
local effectList={}
for i,neweffect in ipairs(neweffectlist)do
effectList[#effectList+1]=neweffect
end
local effect=table.weakCopy(oldeffect)

effect.guids={}
effect.guids[buffguid]=true

effectList[#effectList+1]=effect
return effectList
end



function airBuffSystem:changeAttrOnCollectDropByHpLimitAttr(role,dropid)
if role:isDeleteSelf()then return end
local buffType=eBuffType.eHpLimitOnDropChangeAttr
local hasBuff=role:hasSameTypeBuff(buffType)
if hasBuff then
local effectList=role:calculationBuffEffectList(buffType)
if effectList and#effectList>0 then
local lookup={}
local maxHP=role:getMaxHP()
local HP=role:getHP()
local cfg=cfg_airdropconfig_get(dropid)
for i,effect in ipairs(effectList)do
local dropid_=effect[6]
local type1=effect[7]
local type2=effect[8]
if dropid_==-1 or dropid_==dropid and
type1==-1 or cfg.type1==type1 and
type2==-1 or cfg.type2==type2 then

local op=effect[1]
local limitType=effect[2]
local limitValue=effect[3]
local enough=false
if op==1 then
if limitType==1 then
if HP<=limitValue then
enough=true
end
elseif limitType==2 then
if HP<=math.floor(limitValue/10000*maxHP)then
enough=true
end
end
elseif op==2 then
if limitType==1 then
if HP>=limitValue then
enough=true
end
elseif limitType==2 then
if HP>=math.floor(limitValue/10000*maxHP)then
enough=true
end
end
end
if enough then
local attrid=effect[4]
local addValue=effect[5]

if addValue~=0 then
local old=lookup[attrid]or 0
lookup[attrid]=old+addValue
end
role:useBuffList(effect.guids)
end
end
end
for attrid,addValue in pairs(lookup)do
role:onBuffAddAttr(attrid,addValue)
end
end
end
end


function airBuffSystem:calculationHpLimitOnDropChangeAttrBuff(lifeEnt,buffType,neweffectlist,buffguid,oldeffect)
local effectList={}
for i,neweffect in ipairs(neweffectlist)do
effectList[#effectList+1]=neweffect
end
local effect=table.weakCopy(oldeffect)

effect.guids={}
effect.guids[buffguid]=true

effectList[#effectList+1]=effect
return effectList
end
