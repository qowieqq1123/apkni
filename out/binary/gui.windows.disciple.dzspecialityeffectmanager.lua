dzSpecialityEffectManager=gameState.addListener({})

BIG_EFFECT_TYPE=
{
eFight=1,
eBuild=2,
eGrow=3,
eSearch=4,
eSpecial=5,
}

local _effect_control=
{
[BIG_EFFECT_TYPE.eFight]='dzSpecialityFightEffectController',
[BIG_EFFECT_TYPE.eBuild]='dzSpecialityBuildEffectController',
[BIG_EFFECT_TYPE.eGrow]='dzSpecialityGrowEffectController',
[BIG_EFFECT_TYPE.eSearch]='dzSpecialitySearchEffectController',
[BIG_EFFECT_TYPE.eSpecial]='dzSpecialitySpecialEffectController',
}

local _big_effect_name=
{
[BIG_EFFECT_TYPE.eFight]='fight_effects',
[BIG_EFFECT_TYPE.eBuild]='build_effects',
[BIG_EFFECT_TYPE.eGrow]='grow_effects',
[BIG_EFFECT_TYPE.eSearch]='search_effects',
[BIG_EFFECT_TYPE.eSpecial]='special_effects',
}


function dzSpecialityEffectManager:onAppStart()
notifySystem:listenNotify(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleSpecialityChange)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
end

function dzSpecialityEffectManager:onEnterState()

end

function dzSpecialityEffectManager:onLeaveState()

end

function dzSpecialityEffectManager:onPlayerCreate(...)

end

function dzSpecialityEffectManager:onLostConnection()

end

function dzSpecialityEffectManager:onProtocolReq()
dzSpecialityEffectManager:refreshAllDZEffectValue()
end

function dzSpecialityEffectManager.onDiscipleSpecialityChange(discipleguid,specialitytype,specialityid,updatetype)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
dzSpecialityEffectManager:refreshDZEffectValue(netData,true)
end

function dzSpecialityEffectManager.onDiscipleCreate(discipleguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
dzSpecialityEffectManager:refreshDZEffectValue(netData)
end


function dzSpecialityEffectManager:refreshAllDZEffectValue()
local allDzInfo=UIDiscipleModel:getAllDiscipleDataX()
for _,v in pairs(allDzInfo)do
dzSpecialityEffectManager:refreshDZEffectValue(v.netData.net)
UIDiscipleModel:setDiscipleAttrListDirtyX(v.netData.net.discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
end
end

function dzSpecialityEffectManager:refreshDZEffectValue(netData,update)
if netData.specialitylist==nil and update then return end
local specialitylist={}
local cachelookup={}
local oldspecialitylist=netData.specialitylist
if netData.specialityList then
for _,v in ipairs(netData.specialityList)do
local specialitytype=v.specialitytype
local specialityInfo=v.specialityLst
if specialityInfo then
for _,vv in ipairs(specialityInfo)do
local cfg=UIDiscipleModel:getSpecialityConfigCommon(netData,specialitytype,vv)
for _,bigEffectType in pairs(BIG_EFFECT_TYPE)do
local effectTypeName=_big_effect_name[bigEffectType]
local effects_cfg=cfg[effectTypeName]
if effects_cfg then
if specialitylist[bigEffectType]==nil then specialitylist[bigEffectType]={}end
if cachelookup[bigEffectType]==nil then cachelookup[bigEffectType]={}end
local specialitybiglookup=specialitylist[bigEffectType]
local cachebiglookup=cachelookup[bigEffectType]
local controlName=_effect_control[bigEffectType]
local control=_G[controlName]
control:addEffectValue(netData,specialitybiglookup,effects_cfg,vv,cachebiglookup)
end
end
end
end
end
end

netData.specialitylist=specialitylist
netData.specialitycachelookup=cachelookup









end

function dzSpecialityEffectManager:getEffectValue(netData,bigEffectType,effecfType,...)
local controlName=_effect_control[bigEffectType]
local control=_G[controlName]
local cfg=control:getEffectValue(netData,effecfType,...)
return cfg.get(netData,...)
end

function dzSpecialityEffectManager.isEffectSpeciality(netData,bigEffectType,changeType)
if netData.specialitycachelookup==nil or netData.specialitycachelookup[bigEffectType]==nil then return false end
return netData.specialitycachelookup[bigEffectType][changeType]==true
end






function dzSpecialityEffectManager.onEquipChange(dzguid,equipType)
dzSpecialityGrowEffectController.onEquipChange(dzguid,equipType)
dzSpecialityFightEffectController.onEquipChange(dzguid,equipType)
end

function dzSpecialityEffectManager.onDiscipleInjuryChange(dzguid)
dzSpecialitySpecialEffectController.onDiscipleInjuryChange(dzguid)
end

function dzSpecialityEffectManager.onMoneyChanged(moneytype)
dzSpecialityGrowEffectController.onMoneyChanged(moneytype)
end

function dzSpecialityEffectManager.onDiscipleSpecialityChange(dzguid)
dzSpecialityGrowEffectController.onDiscipleSpecialityChange(dzguid)
dzSpecialityBuildEffectController.onDiscipleSpecialityChange(dzguid)
end

function dzSpecialityEffectManager.onDisciplePosChange(dzguid)
dzSpecialityGrowEffectController.onDisciplePosChange(dzguid)
end

function dzSpecialityEffectManager.onDiscipleLingGenChangeVary(dzguid)
dzSpecialityGrowEffectController.onDiscipleLingGenChangeVary(dzguid)
dzSpecialityBuildEffectController.onDiscipleLingGenChangeVary(dzguid)
end

function dzSpecialityEffectManager.onDiscipleLingGenVary(dzguid)
dzSpecialityBuildEffectController.onDiscipleLingGenChangeVary(dzguid)
end




function dzSpecialityEffectManager:addParam2_only(lookup,effect)
local effecfType=effect[1]
lookup[effecfType]=effect[2]
end

function dzSpecialityEffectManager:addParam2(lookup,effect)
local effecfType=effect[1]
lookup[effecfType]=lookup[effecfType]or 0
lookup[effecfType]=lookup[effecfType]+effect[2]
end

function dzSpecialityEffectManager:addParam2_ratio(lookup,effect,ratio)
local effecfType=effect[1]
lookup[effecfType]=lookup[effecfType]or 0
lookup[effecfType]=lookup[effecfType]+effect[2]/ratio
end

function dzSpecialityEffectManager:addParam3(lookup,effect)
local effecfType=effect[1]
local key=effect[2]
local val=effect[3]
lookup[effecfType]=lookup[effecfType]or{}
lookup[effecfType][key]=lookup[effecfType][key]or 0
lookup[effecfType][key]=lookup[effecfType][key]+val
end

function dzSpecialityEffectManager:addParam4(lookup,effect)
for bulidType,v in pairs(effect)do
for k,value in ipairs(v)do
local effecfType=value[1]
local val=value[2]
lookup[effecfType]=lookup[effecfType]or{}
lookup[effecfType][bulidType]=lookup[effecfType][bulidType]or 0
lookup[effecfType][bulidType]=lookup[effecfType][bulidType]+val
end
end
end

function dzSpecialityEffectManager:addParam_bool(lookup,effect)
local effecfType=effect[1]
lookup[effecfType]=true
end

function dzSpecialityEffectManager:addParamValue(lookup,effect,value)
local effecfType=effect[1]
lookup[effecfType]=value
end






function dzSpecialityEffectManager:getBoolParamValueByStamp(netData,big_effect_type,effecfType)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then return false end
local old=netData.specialitylist[big_effect_type][effecfType]or 0
local stamp=timeHelper.getServerShortTime()
return stamp<old
end

function dzSpecialityEffectManager:getBoolParamValue(netData,big_effect_type,effecfType)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then return false end
return netData.specialitylist[big_effect_type][effecfType]or false
end

function dzSpecialityEffectManager:getParamValue(netData,big_effect_type,effecfType)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then return 0 end
return netData.specialitylist[big_effect_type][effecfType]or 0
end

function dzSpecialityEffectManager:get2ParamValue(netData,big_effect_type,effecfType)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then return 0,0 end
netData.specialitylist[big_effect_type][effecfType]=netData.specialitylist[big_effect_type][effecfType]or{}
local lookup=netData.specialitylist[big_effect_type][effecfType]
return lookup[1]or 0,lookup[2]or 0
end

function dzSpecialityEffectManager:getParam2Value(netData,big_effect_type,effecfType,params_1)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then return 0 end
netData.specialitylist[big_effect_type][effecfType]=netData.specialitylist[big_effect_type][effecfType]or{}
local lookup=netData.specialitylist[big_effect_type][effecfType]
return lookup[params_1]or 0
end

function dzSpecialityEffectManager:getParam2Value_tempParam(netData,big_effect_type,effecfType,params_1)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then
if params_1==nil then
return nil
else
return 0
end
end
netData.specialitylist[big_effect_type][effecfType]=netData.specialitylist[big_effect_type][effecfType]or{}
local lookup=netData.specialitylist[big_effect_type][effecfType]
if params_1==nil then
return lookup
else
return lookup[params_1]or 0
end
end

function dzSpecialityEffectManager:getParam2AddZeroValue_tempParam(netData,big_effect_type,effecfType,params_1)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then
if params_1==nil then
return nil
else
return 0
end
end
netData.specialitylist[big_effect_type][effecfType]=netData.specialitylist[big_effect_type][effecfType]or{}
local lookup=netData.specialitylist[big_effect_type][effecfType]
if params_1==nil then
return lookup
else
local oldZero=lookup[0]or 0
if params_1==0 then return oldZero end
return(lookup[params_1]or 0)+oldZero
end
end

function dzSpecialityEffectManager:getParam2AddZeroValue(netData,big_effect_type,effecfType,params_1)
if netData==nil or netData.specialitylist==nil or netData.specialitylist[big_effect_type]==nil then return 0 end
netData.specialitylist[big_effect_type][effecfType]=netData.specialitylist[big_effect_type][effecfType]or{}
local lookup=netData.specialitylist[big_effect_type][effecfType]
local oldZero=lookup[0]or 0
if params_1==0 then return oldZero end
return(lookup[params_1]or 0)+oldZero
end
