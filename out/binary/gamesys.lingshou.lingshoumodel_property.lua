





lingshouPropertyType={
ZIZHI=1,
QIANLI=2,
MAIN_SKILL_LEVEL=3,
PASSIVE_SKILL_LEVEL=4,
BASE_ATTR_TRAIT_ADD_PERVENT_JX=5,
DISCIPLE_GONGFA_SKILL_LEVEL=6,
DISCIPLE_BASE_ATTR_ADD=7,
MOOD_COST_SPEED_RATE=8,
MOOD_MAXVAL=9,
XIUWEI_GET_RATE=10,
VOLUME=11,
FANYAN_COUNT_MAXVAL=12,
QIANLIDAN_COUNT_MAXVAL=13,
FANYAN_COST_ITEM_RATE=14,
SHOULAN_MAINTENANCE_COST_RATE=15,
FANYAN_SINGLE_BIANYI_RATE=16,
MOOD_CHANGE_VAL=17,
}

local _getLingShouPropertyParam={
[lingshouPropertyType.ZIZHI]=function(lsData)
local zizhi=lsData.zizhi or 0

local reduceVal
if lsData.isOther then
reduceVal=0
else
reduceVal=lingshouModel:getReduceZiZhiValByLsGuid(lsData.guid)or 0
end
zizhi=zizhi-reduceVal

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_DATA_ADD,6)or 0
zizhi=zizhi+effectAdd
return Mathf.Max(zizhi,1)
end,
[lingshouPropertyType.QIANLI]=function(lsData)
local qianli=lsData.qianli

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_DATA_ADD,7)or 0
qianli=qianli+effectAdd

return Mathf.Max(qianli,0)
end,
[lingshouPropertyType.MAIN_SKILL_LEVEL]=function(lsData)
local skill_level=lsData.skill_level

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_SKILL_LEVEL_ADD,0)or 0
skill_level=skill_level+effectAdd

return Mathf.Max(skill_level,0)
end,
[lingshouPropertyType.PASSIVE_SKILL_LEVEL]=function(lsData)
local passive_level=lingshouModel:getPassiveSkillLevel(lsData)

if passive_level>0 then
local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_SKILL_LEVEL_ADD,1)or 0
passive_level=passive_level+effectAdd
end

return Mathf.Max(passive_level,0)
end,
[lingshouPropertyType.BASE_ATTR_TRAIT_ADD_PERVENT_JX]=function(lsData,attrType)
local addVal=0

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_ATTR_PERCENT_ADD,attrType)or 0
addVal=addVal+effectAdd

return addVal
end,
[lingshouPropertyType.DISCIPLE_GONGFA_SKILL_LEVEL]=function(lsData,gfID,skillID)
local faction=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID,'faction')
local skillType=cfgHelper.get(cfg_skillconfig_get,skillID,'skillType')

local addVal=0

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.DISCIPLE_GONGFA_LEVEL_ADD,faction,skillType)or 0
addVal=addVal+effectAdd

return addVal
end,
[lingshouPropertyType.DISCIPLE_BASE_ATTR_ADD]=function(lsData,attrType)
local addVal=0

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.DISCIPLE_ATTR_ADD,attrType)or 0
addVal=addVal+effectAdd

return addVal
end,
[lingshouPropertyType.MOOD_COST_SPEED_RATE]=function(lsData)
local addVal=0

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_MOOD_PERCENT_CHANGE)or 0
addVal=addVal+effectAdd

if lingshouModel.checkStateExistEx2(lsData,eLingShouStateType.petBuildMix)then
local effectAdd2=lingshouModel:getDiscipleTraitEffectLookupIndexTotal(lsData.guid,lingshouTraitEffectEnum.LINGSHOU_LIVE_WITH_OTHER_RACE_EFFECT,2)
addVal=addVal+effectAdd2
end

return addVal
end,
[lingshouPropertyType.MOOD_MAXVAL]=function(lsData)
local addVal=lingshouModel:getLSXinQingMaxValueEx(lsData)

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_MOOD_MAXVAL_ADD)or 0
addVal=addVal+effectAdd

return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.XIUWEI_GET_RATE]=function(lsData,xiuweiType,param)
local baseVal=0
local baseRate=1
local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_XIUWEI_GET_RATE_ADD,xiuweiType)or 0
effectAdd=effectAdd/100
if xiuweiType==0 then

local slId=UIShouLanModel:getShouLanUbdIdByLsGuid(lsData.guid)
local addRate=0
if slId then
baseVal,addRate=feedingSystem:countMonsterAddExp(slId,lsData.guid)
effectAdd=effectAdd+addRate
end


local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eLingShouJJSpeed,1)
buildingBuffRate=buildingBuffRate/100
effectAdd=effectAdd+buildingBuffRate
elseif xiuweiType==1 then

local baseXiuWeiVal=param
baseVal=baseXiuWeiVal
local zizhiAddRate=lingshouModel:getLsZiZhiAddXiuLianExpRate(lsData)
effectAdd=effectAdd+zizhiAddRate


local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eLingShouJJSpeed,2)
buildingBuffRate=buildingBuffRate/100
effectAdd=effectAdd+buildingBuffRate
end

baseRate=baseRate+effectAdd

if lingshouModel.checkStateExistEx2(lsData,eLingShouStateType.petBuildMix)then
local effectAdd2=lingshouModel:getDiscipleTraitEffectLookupIndexTotal(lsData.guid,lingshouTraitEffectEnum.LINGSHOU_LIVE_WITH_OTHER_RACE_EFFECT,3)
baseRate=baseRate+(effectAdd2/100)
end

local finalVal=baseVal*baseRate
return Mathf.Max(finalVal,0)
end,
[lingshouPropertyType.VOLUME]=function(lsData)
local addVal=lsData.cfg.volume

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_VOLUME_CHANGE)or 0
addVal=addVal+effectAdd

return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.FANYAN_COUNT_MAXVAL]=function(lsData)
local addVal=lsData.cfg.mating_cnt

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_FANYAN_MAXVAL_ADD)or 0
addVal=addVal+effectAdd

return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.QIANLIDAN_COUNT_MAXVAL]=function(lsData,ql_itemid)
local addVal=lingshouModel.getQianLiDanUseMaxNum(lsData,ql_itemid)

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_USE_QIANLI_ELIXIR_MAXVAL_ADD,ql_itemid)or 0
addVal=addVal+effectAdd
return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.FANYAN_COST_ITEM_RATE]=function(lsData,itemID)
local addVal=0

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_FANYAN_COST_CHANGE,itemID)or 0
addVal=addVal+(effectAdd/100)

return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.SHOULAN_MAINTENANCE_COST_RATE]=function(lsData,itemID)
local addVal=0

local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_STABLE_MAINTENANCE_COST_CHANGE)
addVal=addVal+(effectAdd/100)

return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.FANYAN_SINGLE_BIANYI_RATE]=function(lsData)
local addVal=0
local config=cfg_lingshoubabybasicconfig_get(1)
local bianyi=config.bianyi
if bianyi then
local daishu=lsData.generation or 1
local color=lsData.cfg.color or 1
if bianyi[daishu]and bianyi[daishu][color]then
addVal=bianyi[daishu][color]
end
if addVal>0 then
local effectAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_FANYAN_SINGLE_BIANYI_RATE_ADD)or 0
addVal=addVal+effectAdd
end
end
return Mathf.Max(addVal,0)
end,
[lingshouPropertyType.MOOD_CHANGE_VAL]=function(lsData)
local baseChange=lsData.cfg.love_chagne
local lsGuid=lsData.guid

local slId=UIShouLanModel:getShouLanUbdIdByLsGuid(lsData.guid)
local slAddVal=0
if slId then
slAddVal=feedingSystem:getMonsterXinQingAddVal(slId,lsGuid)
end





local addVal=baseChange+slAddVal
return addVal
end,
}


function lingshouModel.getLingShouPropertyVal(lsData,ptype,...)
if lsData==nil then
logErr("getLingShouPropertyVal lsData == nil")
return
end

local args={...}
local func=_getLingShouPropertyParam[ptype]
if func then
local result
xpcall(function()
result=func(lsData,unpack(args))
end,function(err)logErr(err)end)
return result
else
logErr("_getLingShouPropertyParam has not define get func")
end
end

function lingshouModel.getLingShouPropertyValEx(lsGuid,ptype,...)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
return lingshouModel.getLingShouPropertyVal(lsData,ptype,...)
end
end

function lingshouModel.getDisciplePropertyVal(dzGuid,ptype,...)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)
if lsGuid==nil then return end
return lingshouModel.getLingShouPropertyValEx(lsGuid,ptype,...)
end
