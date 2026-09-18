fabaoCizuiHelper={}




function fabaoCizuiHelper.isActive(itemguid,idx)
local fabao=fabaoHelper.getFabao(itemguid)
if fabao==nil then return false end
local commonConfig=fabaoConfig.getCommonConfig()
local czActiveLookup=commonConfig.czactiveex
local jilianlv=fabao.itemData and fabao.itemData.jilianlv or 0
local limit=czActiveLookup[idx]or 0
return jilianlv>=limit
end

function fabaoCizuiHelper.getFabaoEffect(itemguid,effectType)
local fabao=fabaoHelper.getFabao(itemguid)
if fabao==nil then return end
local retTable=nil

if fabaoConfig.isBenMingFabao(fabao.itemid)then
local mainid=fabaoHelper.getMainId(fabao)
local czid=benMingFaBaoHelper.getCiZhui(mainid)
local ret=fabaoCizuiHelper.getValue(czid,effectType)
if ret then
if type(ret)=='number'then
retTable=(retTable or 0)+ret
else
retTable=attrListHelper.concatList(ret,retTable)
end
end
end

local czlist=fabaoHelper.getCiZhuiList(fabao)
if czlist==nil then return retTable end
for i,czid in ipairs(czlist)do
local isActive=fabaoCizuiHelper.isActive(itemguid,i)
if not isActive then break end
local ret=fabaoCizuiHelper.getValue(czid,effectType)
if ret then
if type(ret)=='number'then
retTable=(retTable or 0)+ret
else
retTable=attrListHelper.concatList(ret,retTable)
end
end
end
return retTable
end


function fabaoCizuiHelper.getValue(id,effectType)
local cfg=fabaoConfig.getCiZhuiConfig(id)
if cfg.effects==nil or#cfg.effects<=0 then return end
local effects=cfg.effects
local ret=nil
for i,v in ipairs(effects)do
if effectType==v[1]then
ret=fabaoCizuiHelper.contactValue(effectType,v,ret)
end
end
return ret
end

function fabaoCizuiHelper.contactValue(effectType,effect,effectList)
if effectType==FABAO_CIZHUI_EFFECT_TYPE.eAddAttr then
return fabaoCizuiHelper.contactAttrList(effect,effectList)
elseif effectType==FABAO_CIZHUI_EFFECT_TYPE.eAddFabaoAttr then
return fabaoCizuiHelper.contactAttrList(effect,effectList)
elseif effectType==FABAO_CIZHUI_EFFECT_TYPE.eAddJobActiveSkillLv then
return fabaoCizuiHelper.contactLevel(effect,effectList)
elseif effectType==FABAO_CIZHUI_EFFECT_TYPE.eAddFabaoUseJingjieLv then
return fabaoCizuiHelper.contactLevel(effect,effectList)
elseif effectType==FABAO_CIZHUI_EFFECT_TYPE.eAddPassiveSkill then
return fabaoCizuiHelper.contactSkill(effect,effectList)
end
end

function fabaoCizuiHelper.contactAttrList(effect,effectList)
local flag=false
local temp={}
if effectList and#effectList>0 then
for i,v in ipairs(effectList)do
local attid=v[2]
local val=temp[attid]or 0
val=val+v[3]
if effect[2]==attid then
val=val+effect[3]
flag=true
end
temp[attid]=val
end
end

if not flag then
temp[effect[2]]=effect[3]
end

return attrListHelper.transformToList(temp)
end

function fabaoCizuiHelper.contactLevel(effect,effectList)
return(effectList or 0)+effect[2]
end

function fabaoCizuiHelper.contactSkill(effect,effectList)
local flag=false
local temp={}
if effectList and#effectList>0 then
for i,v in ipairs(effectList)do
local skillid=v[2]
local val=temp[skillid]or 0
val=val+v[3]
if effect[2]==skillid then
val=val+effect[3]
flag=true
end
temp[skillid]=val
end
end

if not flag then
temp[effect[2]]=effect[3]
end

return attrListHelper.transformToList(temp)
end

function fabaoCizuiHelper.getDiziAddAttrLookup(diziguid)
local fabao=fabaoModel.getFabaoByDizi(diziguid)
if fabao==nil then return end
local itemguid=fabao.itemguid
local list=fabaoCizuiHelper.getFabaoEffect(itemguid,FABAO_CIZHUI_EFFECT_TYPE.eAddAttr)
return attrListHelper.tramsformToLookup(list)
end

function fabaoCizuiHelper.getAddFabaoBaseAttrsPercentLookup(item)
local itemguid=item.itemguid
local list=fabaoCizuiHelper.getFabaoEffect(itemguid,FABAO_CIZHUI_EFFECT_TYPE.eAddFabaoAttr)
return attrListHelper.tramsformToLookup(list)
end

function fabaoCizuiHelper.getAddJingjieLv(itemguid)
local val=fabaoCizuiHelper.getFabaoEffect(itemguid,FABAO_CIZHUI_EFFECT_TYPE.eAddFabaoUseJingjieLv)
return val or 0
end
