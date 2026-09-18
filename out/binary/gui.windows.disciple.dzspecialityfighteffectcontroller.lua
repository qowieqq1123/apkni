







dzSpecialityFightEffectController={}

local specialEffectType={
eAddBDSkill=1,
}

local _specialEffectValueFunc=
{
[specialEffectType.eAddBDSkill]=
{
add=function(...)
dzSpecialityFightEffectController:addAddBDSkillLookup(...)
end,
get=function(...)
return dzSpecialityFightEffectController:getAddBDSkillLookup(...)
end
},
}

local checkConditionType={
eUsedSomeWeapon=1,
}

local conditionChangeType={
eWeaponChange=1,
}

local _checkConditionFunc={
[checkConditionType.eUsedSomeWeapon]={
changes={conditionChangeType.eWeaponChange},
cond=function(netData,params)
local weaponType=params[2]
local weaponID=UIDiscipleModel:getDiscipleWeaponID(netData.discipleguid)
if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
return equipCfg.type2==weaponType
end
return false
end,
},
}

function dzSpecialityFightEffectController.onEquipChange(disguid,equipType)
if equipType==EQUIP_TYPE.eWeapon then
dzSpecialityFightEffectController:conditionChange(disguid,conditionChangeType.eWeaponChange)
end
end

function dzSpecialityFightEffectController:conditionChange(guid,changeType)
local netData=UIDiscipleModel:getDiscipleData(guid)
local check=self:isEffectSpeciality(netData,changeType)
if check then
dzSpecialityEffectManager:refreshDZEffectValue(netData,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
end
end

function dzSpecialityFightEffectController:isEffectSpeciality(netData,changeType)
return dzSpecialityEffectManager.isEffectSpeciality(netData,BIG_EFFECT_TYPE.eFight,changeType)
end

function dzSpecialityFightEffectController:checkConditionFunc(netData,conditionlist)
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

function dzSpecialityFightEffectController:initCacheLookup(conditionlist,cachelookup)
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

function dzSpecialityFightEffectController:addEffectValue(netData,specialitylookup,effect_cfg,effect_data,cachelookup)
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

function dzSpecialityFightEffectController:getEffectValue(netData,effecfType,...)
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
return cfg.get(netData,...)
else
loggerUtil.logErrFMT('战斗效果类型{0}未支持',effecfType)
end
end


function dzSpecialityFightEffectController:getAddBDSkillLookup(netData,params_1)
local effecfType=specialEffectType.eAddBDSkill
return dzSpecialityEffectManager:getParam2Value_tempParam(netData,BIG_EFFECT_TYPE.eFight,effecfType,params_1)
end


function dzSpecialityFightEffectController:addAddBDSkillLookup(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam3(lookup,effect)
end