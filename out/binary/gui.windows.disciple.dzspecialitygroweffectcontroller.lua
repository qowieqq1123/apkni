







dzSpecialityGrowEffectController={}

local specialEffectType={
eBaseAttr=1,
eShouYuanLostSpeedRate=2,
eJJXiuWeiUpSpeedRate=3,
eJJMedicineRate=4,
eBattleRewardXiuWeiRate=5,
eJJBrokeRate=6,
eSixAttrValue=7,
eProskillExpRate=8,
eGongFaExpRate=9,
eGongFaLearnCostRate=10,
ePostWagesRate=11,
eZhenFaStudyRate=12,
eLvFaTangCostRate=13,
eDanYaoBaoShiDuRate=14,
eReplaceWeapon=15,
eDuJieFailLostXiuWeiRate=16,
eDuJieFailDuJieRate=17,
eInjuryRate=18,
eLoyaltyRate=19,
eXiuWeiDanYaoNotCostRate=20,
eGongFaForgetGiveRate=21,
eLvFaTangCostRate2=22,
eGongFaLevelUpCostRate=23,
eLianTiUpSpeedRate=24,
eGongFaExpRate2=25,
eMoneyAutoChange=26,
eYouLiMoneyChange=27,
eLianDanTimeChange=28,
}

local _specialEffectValueFunc=
{
[specialEffectType.eBaseAttr]=
{
add=function(...)
dzSpecialityGrowEffectController:addBaseAttrLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getBaseAttrLookup(...)
end
},
[specialEffectType.eShouYuanLostSpeedRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addShouYuanLostSpeedRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getShouYuanLostSpeedRate(...)
end
},
[specialEffectType.eJJXiuWeiUpSpeedRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addJJXiuWeiUpSpeedRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getJJXiuWeiUpSpeedRate(...)
end
},
[specialEffectType.eJJMedicineRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addJJMedicineRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getJJMedicineRate(...)
end
},
[specialEffectType.eBattleRewardXiuWeiRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addBattleRewardXiuWeiRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getBattleRewardXiuWeiRate(...)
end
},
[specialEffectType.eJJBrokeRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addJJBrokeRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getJJBrokeRate(...)
end
},
[specialEffectType.eSixAttrValue]=
{
add=function(...)
dzSpecialityGrowEffectController:addSixAttrValueLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getSixAttrValueLookup(...)
end
},
[specialEffectType.eProskillExpRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addProskillExpRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getProskillExpRateLookup(...)
end
},
[specialEffectType.eGongFaExpRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addGongFaExpRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getGongFaExpRateLookup(...)
end
},
[specialEffectType.eGongFaLearnCostRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addGongFaLearnCostRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getGongFaLearnCostRateLookup(...)
end
},
[specialEffectType.ePostWagesRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addPostWagesRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getPostWagesRate(...)
end
},
[specialEffectType.eZhenFaStudyRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addZhenFaStudyRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getZhenFaStudyRate(...)
end
},
[specialEffectType.eLvFaTangCostRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addLvFaTangCostRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getLvFaTangCostRateLookup(...)
end
},
[specialEffectType.eDanYaoBaoShiDuRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addDanYaoBaoShiDuRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getDanYaoBaoShiDuRateLookup(...)
end
},
[specialEffectType.eReplaceWeapon]=
{
add=function(...)
dzSpecialityGrowEffectController:addReplaceWeaponLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getReplaceWeaponLookup(...)
end
},
[specialEffectType.eDuJieFailLostXiuWeiRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addDuJieFailLostXiuWeiRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getDuJieFailLostXiuWeiRateLookup(...)
end
},
[specialEffectType.eDuJieFailDuJieRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addDuJieFailDuJieRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getDuJieFailDuJieRateLookup(...)
end
},
[specialEffectType.eInjuryRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addInjuryRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getInjuryRateLookup(...)
end
},
[specialEffectType.eXiuWeiDanYaoNotCostRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addXiuWeiDanYaoNotCostRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getXiuWeiDanYaoNotCostRateLookup(...)
end
},
[specialEffectType.eGongFaForgetGiveRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addGongFaForgetGiveRateLookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getGongFaForgetGiveRateLookup(...)
end
},
[specialEffectType.eLvFaTangCostRate2]=
{
add=function(...)
dzSpecialityGrowEffectController:addLvFaTangCostRateLookup2(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getLvFaTangCostRateLookup2(...)
end
},
[specialEffectType.eGongFaLevelUpCostRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addGongFaLevelUpCostRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getGongFaLevelUpCostRate(...)
end
},
[specialEffectType.eLianTiUpSpeedRate]=
{
add=function(...)
dzSpecialityGrowEffectController:addLianTiUpSpeedRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getLianTiUpSpeedRate(...)
end
},
[specialEffectType.eGongFaExpRate2]=
{
add=function(...)
dzSpecialityGrowEffectController:addGongFaExpRate2Lookup(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getGongFaExpRate2Lookup(...)
end
},
[specialEffectType.eMoneyAutoChange]=
{
add=function(...)
dzSpecialityGrowEffectController:addMoneyAutoChangeRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getMoneyAutoChangeRate(...)
end
},
[specialEffectType.eYouLiMoneyChange]=
{
add=function(...)
dzSpecialityGrowEffectController:addYouLiMoneyChangeRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getYouLiMoneyChangeRate(...)
end
},
[specialEffectType.eLianDanTimeChange]=
{
add=function(...)
dzSpecialityGrowEffectController:addLianDanTimeChangeRate(...)
end,
get=function(...)
return dzSpecialityGrowEffectController:getLianDanTimeChangeRate(...)
end
},
}

local checkConditionType={
eJob=1,
eSex=2,
eWifeHasSomeSpeciality=3,
eNotUsedSomeWeapon=4,
eSpiritRootNum=5,
eStandPoint1=6,
eStandPoint2=7,
eUsedSomeWeapon=8,
ePost=9,
eSpiritGoldToThunder=10,
eDisSameSuit=11,
}

local conditionChangeType={
eWifeChange=1,
eWifeSpecialityBodyChange=2,
eWeaponChange=3,
eStandPointChange=4,
eSpecialSpiritRootChange=5,
ePostChange=6,
onDiscipleLingGenChangeVary=7,
}

local _checkConditionFunc={
[checkConditionType.eJob]={
cond=function(netData,params)
local tJob=params[2]
local cJob=UIDiscipleModel:getDiscipleJobByData(netData)
return tJob==cJob
end,
},
[checkConditionType.eSex]={
cond=function(netData,params)
local tSex=params[2]
local cSex=UIDiscipleModel:getDiscipleSexByData(netData)
return tSex==cSex
end,
},

[checkConditionType.eWifeHasSomeSpeciality]={
cond=function(netData,params)
return false
end,
},
[checkConditionType.eNotUsedSomeWeapon]={
changes={conditionChangeType.eWeaponChange},
cond=function(netData,params)
local weaponType=params[2]
local weaponID=UIDiscipleModel:getDiscipleWeaponID(netData.discipleguid)
if weaponID>0 and itemsConfig.isDaoBing(weaponID)then return false end
if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
return equipCfg.type2~=weaponType
end
return true
end,
},
[checkConditionType.eSpiritRootNum]={
changes={conditionChangeType.eSpecialSpiritRootChange},
cond=function(netData,params)
local tnum=params[2]
local cnum=UIDiscipleModel:getDiscipleSpecialityLen(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
return tnum==cnum
end,
},
[checkConditionType.eStandPoint1]={
changes={conditionChangeType.eStandPointChange},
cond=function(netData,params)


local lichang=UISectPalaceModel:getZongMenLiChang()
return lichang==STAND_POINT_TYPE.decent
end,
},
[checkConditionType.eStandPoint2]={
changes={conditionChangeType.eStandPointChange},
cond=function(netData,params)
local lichang=UISectPalaceModel:getZongMenLiChang()
return lichang==STAND_POINT_TYPE.evil
end,
},
[checkConditionType.eUsedSomeWeapon]={
changes={conditionChangeType.eWeaponChange},
cond=function(netData,params)
local weaponType=params[2]
local weaponID=UIDiscipleModel:getDiscipleWeaponID(netData.discipleguid)
if weaponID>0 and not itemsConfig.isDaoBing(weaponID)then
local equipCfg=itemsConfig.getConfig(weaponID)
return equipCfg.type2==weaponType
end
return false
end,
},
[checkConditionType.ePost]={
changes={conditionChangeType.ePostChange},
cond=function(netData,params)
local tPost=params[2]
local cPost=UIDiscipleModel:getDisciplePostEX(netData)
return tPost==cPost
end,
},
[checkConditionType.eSpiritGoldToThunder]={
changes={conditionChangeType.onDiscipleLingGenChangeVary},
cond=function(netData,params)
local lgId=params[2]
return lgId==netData.varysrid
end,
},
[checkConditionType.eDisSameSuit]={
changes={conditionChangeType.eWeaponChange},
cond=function(netData,params)
local flag=UIDiscipleModel:isDisSuitSame(netData.discipleguid)
return flag==params[2]
end,
},
}


function dzSpecialityGrowEffectController.onMoneyChanged(moneytype)
if moneytype==eMoneyType.mtShanEVal then
dzSpecialityGrowEffectController:conditionChange(nil,conditionChangeType.eStandPointChange)
end
end

function dzSpecialityGrowEffectController.onEquipChange(disguid,equipType)
if equipType==EQUIP_TYPE.eWeapon or equipType==EQUIP_TYPE.eClothes or equipType==EQUIP_TYPE.eCap or equipType==EQUIP_TYPE.eShoot then
dzSpecialityGrowEffectController:conditionChange(disguid,conditionChangeType.eWeaponChange)
end
end

function dzSpecialityGrowEffectController.onDiscipleSpecialityChange(discipleguid)
dzSpecialityGrowEffectController:conditionChange(discipleguid,conditionChangeType.eSpecialSpiritRootChange)
end

function dzSpecialityGrowEffectController.onDisciplePosChange(disguid)
dzSpecialityGrowEffectController:conditionChange(disguid,conditionChangeType.ePostChange)
end

function dzSpecialityGrowEffectController.onDiscipleLingGenChangeVary(discipleguid)
dzSpecialityGrowEffectController:conditionChange(discipleguid,conditionChangeType.onDiscipleLingGenChangeVary)
end

function dzSpecialityGrowEffectController:conditionChange(guid,changeType)
if guid then
local netData=UIDiscipleModel:getDiscipleData(guid)
local check=self:isEffectSpeciality(netData,changeType)
if check then
dzSpecialityEffectManager:refreshDZEffectValue(netData,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
end
else
local dzlist=UIDiscipleModel:getAllDiscipleDataX()
if dzlist then
for _,v in ipairs(dzlist)do
local netData=v.netData.net
local check=self:isEffectSpeciality(netData,changeType)
if check then
dzSpecialityEffectManager:refreshDZEffectValue(netData,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
end
end
end
end
end

function dzSpecialityGrowEffectController:isEffectSpeciality(netData,changeType)
return dzSpecialityEffectManager.isEffectSpeciality(netData,BIG_EFFECT_TYPE.eGrow,changeType)
end

function dzSpecialityGrowEffectController:checkConditionFunc(netData,conditionlist)
if conditionlist==nil then return true end
for i,v in ipairs(conditionlist)do
local condType=v[1]
local condFunc=_checkConditionFunc[condType]
if condFunc then
local cond=condFunc.cond
if not cond(netData,v)then
return false
end
end
end
return true
end

function dzSpecialityGrowEffectController:initCacheLookup(conditionlist,cachelookup)
if conditionlist==nil then return end
for i,v in ipairs(conditionlist)do
local condType=v[1]
local condFunc=_checkConditionFunc[condType]
if condFunc then
local changes=condFunc.changes
if changes then
for _,v in ipairs(changes)do
cachelookup[v]=true
end
end
end
end
end

function dzSpecialityGrowEffectController:addEffectValue(netData,specialitylookup,effect_cfg,effect_data,cachelookup)
for i,v in ipairs(effect_cfg)do
local effects=v[1]
local conditionlist=v[2]
self:initCacheLookup(conditionlist,cachelookup)
if self:checkConditionFunc(netData,conditionlist)then
for _,effect in ipairs(effects)do
local effecfType=effect[1]
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
cfg.add(specialitylookup,effect,effect_data)
end
end
end
end
end

function dzSpecialityGrowEffectController:getEffectValue(netData,effecfType,...)
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
return cfg.get(netData,...)
else
loggerUtil.logErrFMT('成长效果类型{0}未支持',effecfType)
end
end





function dzSpecialityGrowEffectController:getBaseAttrLookup(netData,params_1)
local effecfType=specialEffectType.eBaseAttr
return dzSpecialityEffectManager:getParam2Value_tempParam(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end


function dzSpecialityGrowEffectController:getShouYuanLostSpeedRate(netData)
local effecfType=specialEffectType.eShouYuanLostSpeedRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getJJXiuWeiUpSpeedRateByData(netData)
local effecfType=specialEffectType.eJJXiuWeiUpSpeedRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getJJMedicineRate(netData)
local effecfType=specialEffectType.eJJMedicineRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getJJBrokeRate(netData)
local effecfType=specialEffectType.eJJBrokeRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getSixAttrValueLookup(netData,params_1)
local effecfType=specialEffectType.eSixAttrValue
return dzSpecialityEffectManager:getParam2Value_tempParam(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end



function dzSpecialityGrowEffectController:getProskillExpRateLookup(netData,proskillType,scrType,includeall)
if scrType==nil then scrType=0 end
if includeall==nil then includeall=true end
local big_effect_type=BIG_EFFECT_TYPE.eGrow
local effecfType=specialEffectType.eProskillExpRate
if netData.specialitylist==nil or
netData.specialitylist[big_effect_type]==nil or
netData.specialitylist[big_effect_type][effecfType]==nil then
return 0
end
local lookup=netData.specialitylist[big_effect_type][effecfType]
if lookup then
local rate=0
for _proskillType,v in pairs(lookup)do
for _scrType,_rate in pairs(v)do
if proskillType==_proskillType or includeall and _proskillType==0 then
if _scrType==scrType or _scrType==0 then
rate=rate+_rate
end
end
end
end
return rate
end
return 0
end


function dzSpecialityGrowEffectController:getGongFaExpRateLookup(netData,params_1)
local effecfType=specialEffectType.eGongFaExpRate
return dzSpecialityEffectManager:getParam2Value_tempParam(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end


function dzSpecialityGrowEffectController:getGongFaLearnCostRateLookup(netData,params_1)
local effecfType=specialEffectType.eGongFaLearnCostRate
return dzSpecialityEffectManager:getParam2Value_tempParam(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end


function dzSpecialityGrowEffectController:getPostWagesRate(netData)
local effecfType=specialEffectType.ePostWagesRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getZhenFaStudyRate(netData)
local effecfType=specialEffectType.eZhenFaStudyRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getLvFaTangCostRateLookup(netData)
local effecfType=specialEffectType.eLvFaTangCostRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getLvFaTangCostRateLookup2(netData)
local effecfType=specialEffectType.eLvFaTangCostRate2
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getDanYaoBaoShiDuRateLookup(netData)
local effecfType=specialEffectType.eDanYaoBaoShiDuRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getReplaceWeaponLookup(netData)
local effecfType=specialEffectType.eReplaceWeapon
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getDuJieFailLostXiuWeiRateLookup(netData)
local effecfType=specialEffectType.eDuJieFailLostXiuWeiRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getDuJieFailDuJieRateLookup(netData)
local effecfType=specialEffectType.eDuJieFailDuJieRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getInjuryRateLookup(netData)
local effecfType=specialEffectType.eInjuryRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end



function dzSpecialityGrowEffectController:getLoyaltyRateLookup(netData,params_1)
local effecfType=specialEffectType.eLoyaltyRate
return dzSpecialityEffectManager:getParam2AddZeroValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end


function dzSpecialityGrowEffectController:getXiuWeiDanYaoNotCostRateLookup(netData)

local effecfType=specialEffectType.eXiuWeiDanYaoNotCostRate
return dzSpecialityEffectManager:get2ParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getGongFaForgetGiveRateLookup(netData)
local effecfType=specialEffectType.eGongFaForgetGiveRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getGongFaLevelUpCostRate(netData,params_1)
local effecfType=specialEffectType.eGongFaLevelUpCostRate
return dzSpecialityEffectManager:getParam2AddZeroValue_tempParam(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end


function dzSpecialityGrowEffectController:getLianTiUpSpeedRate(netData)
local effecfType=specialEffectType.eLianTiUpSpeedRate
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eGrow,effecfType)
end


function dzSpecialityGrowEffectController:getGongFaExpRate2Lookup(netData,params_1)
params_1=params_1 or 0
local effecfType=specialEffectType.eGongFaExpRate2
return dzSpecialityEffectManager:getParam2AddZeroValue_tempParam(netData,BIG_EFFECT_TYPE.eGrow,effecfType,params_1)
end


function dzSpecialityGrowEffectController:getMoneyAutoChangeRate(netData,moneytype)
local effecfType=specialEffectType.eMoneyAutoChange
return dzSpecialityEffectManager:getParam2Value(netData,BIG_EFFECT_TYPE.eGrow,effecfType,moneytype)
end


function dzSpecialityGrowEffectController:getYouLiMoneyChangeRate(netData,moneytype)
local effecfType=specialEffectType.eYouLiMoneyChange
return dzSpecialityEffectManager:getParam2Value(netData,BIG_EFFECT_TYPE.eGrow,effecfType,moneytype)
end


function dzSpecialityGrowEffectController:getLianDanTimeChangeRate(netData,moneytype)
local effecfType=specialEffectType.eLianDanTimeChange
return dzSpecialityEffectManager:getParam2Value(netData,BIG_EFFECT_TYPE.eGrow,effecfType,moneytype)
end




function dzSpecialityGrowEffectController:addBaseAttrLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end

function dzSpecialityGrowEffectController:addShouYuanLostSpeedRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addJJXiuWeiUpSpeedRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addJJMedicineRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2_ratio(lookup,effect,100)
end


function dzSpecialityGrowEffectController:addBattleRewardXiuWeiRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addJJBrokeRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addSixAttrValueLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end



function dzSpecialityGrowEffectController:addProskillExpRateLookup(lookup,effect,effect_data)
if lookup==nil then lookup={}end
local effecfType=effect[1]
local key1=effect[2]
local key2=effect[4]or 0
local val=effect[3]
lookup[effecfType]=lookup[effecfType]or{}
lookup[effecfType][key1]=lookup[effecfType][key1]or{}
local old=lookup[effecfType][key1][key2]or 0
lookup[effecfType][key1][key2]=old+val
end


function dzSpecialityGrowEffectController:addGongFaExpRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addGongFaLearnCostRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addPostWagesRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addZhenFaStudyRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addLvFaTangCostRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addLvFaTangCostRateLookup2(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addDanYaoBaoShiDuRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addReplaceWeaponLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2_only(lookup,effect)
end


function dzSpecialityGrowEffectController:addReplaceWeaponLookupByDzData(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2_only(lookup,effect)
end


function dzSpecialityGrowEffectController:addDuJieFailLostXiuWeiRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addDuJieFailDuJieRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addInjuryRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end



function dzSpecialityGrowEffectController:addLoyaltyRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addXiuWeiDanYaoNotCostRateLookup(lookup,effect,effect_data)
local effecfType=effect[1]
local val1=effect[2]
local val2=effect[3]
lookup[effecfType]={val1,val2}
end


function dzSpecialityGrowEffectController:addGongFaForgetGiveRateLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addGongFaLevelUpCostRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addLianTiUpSpeedRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialityGrowEffectController:addGongFaExpRate2Lookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addMoneyAutoChangeRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addYouLiMoneyChangeRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end


function dzSpecialityGrowEffectController:addLianDanTimeChangeRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


