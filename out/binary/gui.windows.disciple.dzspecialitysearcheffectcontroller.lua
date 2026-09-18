







dzSpecialitySearchEffectController={}

local specialEffectType={
eShenShiSkillRangeRate=1,
eTeamSeaRange=2,
eHideEffectStepNum=3,
eYouLiTimeRate=4,
}

local _specialEffectValueFunc=
{
[specialEffectType.eShenShiSkillRangeRate]=
{
add=function(...)
dzSpecialitySearchEffectController:addShenShiSkillRangeRate(...)
end,
get=function(...)
return dzSpecialitySearchEffectController:getShenShiSkillRangeRate(...)
end
},
[specialEffectType.eTeamSeaRange]=
{
add=function(...)
dzSpecialitySearchEffectController:addTeamSeaRange(...)
end,
get=function(...)
return dzSpecialitySearchEffectController:getTeamSeaRange(...)
end
},
[specialEffectType.eHideEffectStepNum]=
{
add=function(...)
dzSpecialitySearchEffectController:addHideEffectStepNumList(...)
end,
get=function(...)
return dzSpecialitySearchEffectController:getHideEffectStepNumList(...)
end
},
[specialEffectType.eYouLiTimeRate]=
{
add=function(...)
dzSpecialitySearchEffectController:addYouLiTimeRate(...)
end,
get=function(...)
return dzSpecialitySearchEffectController:getYouLiTimeRate(...)
end
},
}

function dzSpecialitySearchEffectController:addEffectValue(netData,specialitylookup,effect_cfg,effect_data)
for i,effect in ipairs(effect_cfg)do
local effecfType=effect[1]
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
cfg.add(specialitylookup,effect,effect_data)
end
end
end

function dzSpecialitySearchEffectController:getEffectValue(netData,effecfType,...)
local cfg=_specialEffectValueFunc[effecfType]
if cfg then
return cfg.get(netData,...)
else
loggerUtil.logErrFMT('探索效果类型{0}未支持',effecfType)
end
end





function dzSpecialitySearchEffectController:getShenShiSkillRangeRate(netData)
local effecfType=specialEffectType.eShenShiSkillRangeRate
return dzSpecialityEffectManager:getParamValue(netData,effecfType)
end


function dzSpecialitySearchEffectController:getTeamSeaRange(netData)
local effecfType=specialEffectType.eTeamSeaRange
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eSearch,effecfType)
end



function dzSpecialitySearchEffectController:getHideEffectStepNumList(netData)
local effecfType=specialEffectType.eHideEffectStepNum
loggerUtil.logErrFMT('特质大类{0}小类{1}未实现',BIG_EFFECT_TYPE.eSearch,effecfType)
end


function dzSpecialitySearchEffectController:getYouLiTimeRate(netData)
local effecfType=specialEffectType.eTeamSeaRange
return dzSpecialityEffectManager:getParamValue(netData,BIG_EFFECT_TYPE.eSearch,effecfType)
end


function dzSpecialitySearchEffectController:addShenShiSkillRangeRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2_ratio(lookup,effect,100.0)
end


function dzSpecialitySearchEffectController:addTeamSeaRange(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2(lookup,effect)
end



function dzSpecialitySearchEffectController:addHideEffectStepNumList(lookup,effect,effect_data)
end


function dzSpecialitySearchEffectController:addYouLiTimeRate(lookup,effect,effect_data)
dzSpecialityEffectManager:addParam2_ratio(lookup,effect,100.0)
end