







dzSpecialitySpecialEffectController={}

local specialEffectType={
eNotGetSpecielStrange=3,
eNotAcceptCouple=4,
eInjuryNoDie=5,
eNotChuangGong=11,
eCantQianRuSystemZM=12,
eInjurpNotDownAttr=13,
eChuWuDaiAddItem=14,
eChuWuDaiNotCheck=15,
eNotGetXieWeiAndLianTi=16,
eZZSHCollectRate=17,
eZZSHCollectKeepRate=18,
eSystemZMOutgoerRate=19,
eSystemZMInciteRate=20,

}

local _specialEffectValueFunc=
{
[specialEffectType.eNotChuangGong]=
{
add=function(...)
dzSpecialitySpecialEffectController:addNotChuangGong(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getNotChuangGong(...)
end
},
[specialEffectType.eNotGetSpecielStrange]=
{
add=function(...)
dzSpecialitySpecialEffectController:addNotGetSpecielStrange(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getNotGetSpecielStrange(...)
end
},
[specialEffectType.eNotAcceptCouple]=
{
add=function(...)
dzSpecialitySpecialEffectController:addNotAcceptCouple(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getNotAcceptCouple(...)
end
},
[specialEffectType.eInjuryNoDie]=
{
add=function(...)
dzSpecialitySpecialEffectController:addInjuryNoDie(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getInjuryNoDie(...)
end
},
[specialEffectType.eCantQianRuSystemZM]=
{
add=function(...)
dzSpecialitySpecialEffectController:addCantQianRuSystemZM(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getCantQianRuSystemZM(...)
end
},
[specialEffectType.eInjurpNotDownAttr]=
{
add=function(...)
dzSpecialitySpecialEffectController:addInjurpNotDownAttr(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getInjurpNotDownAttr(...)
end
},
[specialEffectType.eChuWuDaiAddItem]=
{
add=function(...)
dzSpecialitySpecialEffectController:addChuWuDaiAddItem(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getChuWuDaiAddItem(...)
end
},
[specialEffectType.eChuWuDaiNotCheck]=
{
add=function(...)
dzSpecialitySpecialEffectController:addChuWuDaiNotCheck(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getChuWuDaiNotCheck(...)
end
},
[specialEffectType.eZZSHCollectRate]=
{
add=function(...)
dzSpecialitySpecialEffectController:addZZSHCollectRate(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getZZSHCollectRate(...)
end
},
[specialEffectType.eZZSHCollectKeepRate]=
{
add=function(...)
dzSpecialitySpecialEffectController:addZZSHCollectKeepRate(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getZZSHCollectKeepRate(...)
end
},
[specialEffectType.eNotGetXieWeiAndLianTi]=
{
add=function(...)
dzSpecialitySpecialEffectController:addNotGetXieWeiAndLianTi(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getNotGetXieWeiAndLianTi(...)
end
},
[specialEffectType.eSystemZMOutgoerRate]=
{
add=function(...)
dzSpecialitySpecialEffectController:addSystemZMOutgoerRate(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getSystemZMOutgoerRate(...)
end
},
[specialEffectType.eSystemZMInciteRate]=
{
add=function(...)
dzSpecialitySpecialEffectController:addSystemZMInciteRateRate(...)
end,
get=function(...)
return dzSpecialitySpecialEffectController:getSystemZMInciteRateRate(...)
end
},

}

local conditionChangeType={
eInjurpChange=1,
}

local _checkConditionFunc={
[specialEffectType.eInjurpNotDownAttr]=
{
{conditionChangeType.eInjurpChange}
}
}

function dzSpecialitySpecialEffectController.onDiscipleInjuryChange(discipleguid)
dzSpecialitySpecialEffectController:conditionChange(discipleguid,conditionChangeType.eInjurpChange)
end

function dzSpecialitySpecialEffectController:isEffectSpeciality(netData,changeType)
return dzSpecialityEffectManager.isEffectSpeciality(netData,BIG_EFFECT_TYPE.eSpecial,changeType)
end

function dzSpecialitySpecialEffectController:conditionChange(guid,changeType)
local netData=UIDiscipleModel:getDiscipleData(guid)
local check=self:isEffectSpeciality(netData,changeType)
if check then
dzSpecialityEffectManager:refreshDZEffectValue(netData,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
end
end

function dzSpecialitySpecialEffectController:initCacheLookup(effecfType,cachelookup)
local conditionlist=_checkConditionFunc[effecfType]
if conditionlist==nil then return end
for i,v in ipairs(conditionlist)do
cachelookup[v]=true
end
end

function dzSpecialitySpecialEffectController:addEffectValue(netData,specialitylookup,effect_cfg,effect_data,cachelookup)
for i,v in ipairs(effect_cfg)do
local effects=v[1]
for _,effect in ipairs(effects)do
local effecfType=effect[1]
self:initCacheLookup(effecfType,cachelookup)
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
cfg.add(specialitylookup,effect,effect_data)
end
end
end
end

function dzSpecialitySpecialEffectController:getEffectValue(netData,effecfType,...)
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
return cfg.get(netData,...)
else
loggerUtil.logErrFMT('特殊效果类型{0}未支持',effecfType)
end
end





function dzSpecialitySpecialEffectController:getNotChuangGong(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eNotChuangGong)
end


function dzSpecialitySpecialEffectController:getNotGetSpecielStrange(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eNotGetSpecielStrange)
end


function dzSpecialitySpecialEffectController:getNotAcceptCouple(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eNotAcceptCouple)
end



function dzSpecialitySpecialEffectController:getInjuryNoDie(netData)
return dzSpecialityEffectManager:getBoolParamValueByStamp(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eInjuryNoDie)
end


function dzSpecialitySpecialEffectController:getCantQianRuSystemZM(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eCantQianRuSystemZM)
end


function dzSpecialitySpecialEffectController:getInjurpNotDownAttr(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eInjurpNotDownAttr)
end


function dzSpecialitySpecialEffectController:getChuWuDaiAddItem(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eChuWuDaiAddItem)
end


function dzSpecialitySpecialEffectController:getChuWuDaiNotCheck(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eChuWuDaiNotCheck)
end


function dzSpecialitySpecialEffectController:getZZSHCollectRate(netData)
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eZZSHCollectRate)
end


function dzSpecialitySpecialEffectController:getZZSHCollectKeepRate(netData)
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eZZSHCollectKeepRate)
end


function dzSpecialitySpecialEffectController:getNotGetXieWeiAndLianTi(netData)
return dzSpecialityEffectManager:getBoolParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eNotGetXieWeiAndLianTi)
end


function dzSpecialitySpecialEffectController:getSystemZMOutgoerRate(netData)
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eSystemZMOutgoerRate)
end


function dzSpecialitySpecialEffectController:getSystemZMInciteRateRate(netData)
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eSpecial,specialEffectType.eSystemZMInciteRate)
end


function dzSpecialitySpecialEffectController:addNotChuangGong(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addNotGetSpecielStrange(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addNotAcceptCouple(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addInjuryNoDie(lookup,effect,effect_data)
dzSpecialityEffectManager:addParamValue(lookup,effect,effect_data.expiresec)
end


function dzSpecialitySpecialEffectController:addCantQianRuSystemZM(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addInjurpNotDownAttr(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addChuWuDaiAddItem(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addChuWuDaiNotCheck(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addZZSHCollectRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialitySpecialEffectController:addZZSHCollectKeepRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialitySpecialEffectController:addNotGetXieWeiAndLianTi(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam_bool(lookup,effect)
end


function dzSpecialitySpecialEffectController:addSystemZMOutgoerRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end


function dzSpecialitySpecialEffectController:addSystemZMInciteRateRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end
