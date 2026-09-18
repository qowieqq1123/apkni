







dzSpecialityBuildEffectController={}


dzSpecialityBuildEffectChangeType={
eNeedCostChangeRate=1,
eProduceTimeChangeRate=2,
eOutputRate=3,
}

local specialEffectType={
eProduction=1,
eOpenMount=2,
eOpenArea=3,
eBulidLevelup=4,
}

local _specialEffectValueFunc=
{
[specialEffectType.eProduction]=
{
add=function(...)
dzSpecialityBuildEffectController:addProductionChange(...)
end,
get=function(...)
return dzSpecialityBuildEffectController:getProductionChange(...)
end
},
[specialEffectType.eOpenMount]=
{
add=function(...)
dzSpecialityBuildEffectController:addOpenMountChange(...)
end,
get=function(...)
return dzSpecialityBuildEffectController:getOpenMountChange(...)
end
},
[specialEffectType.eOpenArea]=
{
add=function(...)
dzSpecialityBuildEffectController:addOpenAreaChange(...)
end,
get=function(...)
return dzSpecialityBuildEffectController:getOpenAreaChange(...)
end
},
[specialEffectType.eBulidLevelup]=
{
add=function(...)
dzSpecialityBuildEffectController:addBulidLevelupChange(...)
end,
get=function(...)
return dzSpecialityBuildEffectController:getBulidLevelupChange(...)
end
},
}

function dzSpecialityBuildEffectController:addEffectValue(netData,specialitylookup,effect_cfg,effect_data,cachelookup)
for i,effect in ipairs(effect_cfg)do
local effecfType=effect.type
local effecfParam=effect.param
local conditionlist=effect.condition
self:initCacheLookup(conditionlist,cachelookup)

if self:checkConditionFunc(netData,conditionlist)then
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
cfg.add(specialitylookup,effecfParam,effect_data)
end
end
end
end

function dzSpecialityBuildEffectController:getEffectValue(netData,effecfType,...)
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
return cfg.get(netData,...)
else
loggerUtil.logErrFMT('战斗效果类型{0}未支持',effecfType)
end
end








function dzSpecialityBuildEffectController:getProductionChange(netData)
loggerUtil.logErrFMT('特质大类{0}小类{1}未实现',BIG_EFFECT_TYPE.eBuild,specialEffectType.eProduction)
end




function dzSpecialityBuildEffectController:getOpenMountChange(netData)
loggerUtil.logErrFMT('特质大类{0}小类{1}未实现',BIG_EFFECT_TYPE.eBuild,specialEffectType.eOpenMount)
end




function dzSpecialityBuildEffectController:getOpenAreaChange(netData)
loggerUtil.logErrFMT('特质大类{0}小类{1}未实现',BIG_EFFECT_TYPE.eBuild,specialEffectType.eOpenArea)
end




function dzSpecialityBuildEffectController:getBulidLevelupChange(netData)
loggerUtil.logErrFMT('特质大类{0}小类{1}未实现',BIG_EFFECT_TYPE.eBuild,specialEffectType.eBulidLevelup)
end



function dzSpecialityBuildEffectController:addProductionChange(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam4(lookup,effect)
end



function dzSpecialityBuildEffectController:addOpenMountChange(lookup,effect,effect_data)

end



function dzSpecialityBuildEffectController:addOpenAreaChange(lookup,effect,effect_data)

end



function dzSpecialityBuildEffectController:addBulidLevelupChange(lookup,effect,effect_data)

end



local checkConditionType={
eDisLingGen=1,
}

local conditionChangeType={
onDisLingGenChange=1,
}

local _checkConditionFunc={
[checkConditionType.eDisLingGen]={
changes={conditionChangeType.onDisLingGenChange},
cond=function(netData,params)
local lgId=params[2]
local isVary=params[3]
local data=UIDiscipleModel:getDiscipleLingGenData(netData.discipleguid)
if data then
for k,v in ipairs(data)do

local varyState=v.varyState
if v.type==lgId then
if isVary==2 then return true
elseif isVary==varyState then return true
elseif isVary==0 and varyState<=0 then return true
end
end
end
end
return false
end,
},
}

function dzSpecialityBuildEffectController:initCacheLookup(conditionlist,cachelookup)
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

function dzSpecialityBuildEffectController:checkConditionFunc(netData,conditionlist)
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

function dzSpecialityBuildEffectController:isEffectSpeciality(netData,changeType)
return dzSpecialityEffectManager.isEffectSpeciality(netData,BIG_EFFECT_TYPE.eBuild,changeType)
end



function dzSpecialityBuildEffectController:conditionChange(guid,changeType)
local netData=UIDiscipleModel:getDiscipleData(guid)
local check=self:isEffectSpeciality(netData,changeType)
if check then
dzSpecialityEffectManager:refreshDZEffectValue(netData,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
end
end

function dzSpecialityBuildEffectController.onDiscipleLingGenChangeVary(discipleguid)
dzSpecialityBuildEffectController:conditionChange(discipleguid,conditionChangeType.onDisLingGenChange)
end

function dzSpecialityBuildEffectController.onDiscipleSpecialityChange(discipleguid)
dzSpecialityBuildEffectController:conditionChange(discipleguid,conditionChangeType.onDisLingGenChange)
end