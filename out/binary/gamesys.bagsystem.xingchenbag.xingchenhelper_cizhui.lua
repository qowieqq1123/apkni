






function xingChenHelper.getEffectList(effectType,effect_name,equipGuid)
if equipGuid then
return xingChenHelper.getEquipEffectList(equipGuid,effectType,effect_name)
else
local growlist={}
local slotList=xingChenBagModel:getPosData()
for _t,slot in pairs(slotList)do
local effectlist=xingChenHelper.getAllCiZhuiList(slot.itemguid,effect_name)
for i,v in ipairs(effectlist)do
if v[1]==effectType then
table.insert(growlist,v)
end
end
if slot.itemData.fin_rare_id~=0 then
local cfg=cfgHelper.get(cfg_starsrareconfig_get,slot.itemData.fin_rare_id)
if cfg and cfg[effect_name]then
local effects=cfg[effect_name]
for i,v in ipairs(effects)do
if v[1]==effectType then
table.insert(growlist,v)
end
end
end
end


local starGrow=xingChenHelper.getStarGrowAttr(slot.itemid,xingChenHelper.getStarLevel(slot))
for i,v in ipairs(starGrow)do
if v[1]==effectType then
table.insert(growlist,v)
end
end
end
return growlist
end
end

function xingChenHelper.getEquipEffectList(guid,effectType,effect_name)
local growlist={}
local effectlist=xingChenHelper.getAllCiZhuiList(guid,effect_name)
for i,v in ipairs(effectlist)do
if v[1]==effectType then
table.insert(growlist,v)
end
end

local equip=equipsHelper.getEquip(guid)
if equip then
if equip.itemData.fin_rare_id~=0 then
local cfg=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
if cfg and cfg[effect_name]then
local effects=cfg[effect_name]
for i,v in ipairs(effects)do
if v[1]==effectType then
table.insert(growlist,v)
end
end
end
end


local starGrow=xingChenHelper.getStarGrowAttr(equip.itemid,xingChenHelper.getStarLevel(equip))
for i,v in ipairs(starGrow)do
if v[1]==effectType then
table.insert(growlist,v)
end
end
end

return growlist
end



function xingChenHelper.getAllCiZhuiList(guid,effect_name)
local effectlist={}
local affixList=xingChenHelper.getAffixListByGuid(guid)
if#affixList>0 then

for _,ciZhui in ipairs(affixList)do
local cfg=cfgHelper.get(cfg_starsaffixconfig_get,ciZhui)
if cfg~=nil and cfg[effect_name]~=nil then
local effects=cfg[effect_name]
for i2,v2 in ipairs(effects)do
table.insert(effectlist,v2)
end
end
end
end
return effectlist
end

function xingChenHelper.calcEffectAttrLookup(effectType,effect_name,guid)
local lookup={}
local effectlist=xingChenHelper.getEffectList(effectType,effect_name,guid)
if#effectlist>0 then
for i,v in ipairs(effectlist)do
local _attrLookup=v[2]
lookup=attrListHelper.concatLookup(lookup,_attrLookup)
end
end
return lookup
end

function xingChenHelper.calcEffectAttrListToLookup(effectType,effect_name,guid)
local lookup={}
local effectlist=xingChenHelper.getEffectList(effectType,effect_name,guid)
if#effectlist>0 then
for i,v in ipairs(effectlist)do
local _attrList=v[2]
for i2,v2 in ipairs(_attrList)do
lookup[v2[1]]=(lookup[v2[1]]or 0)+v2[2]
end
end
end
return lookup
end

function xingChenHelper.calcEffectVal(effectType,effect_name,guid)
local val=0
local effectlist=xingChenHelper.getEffectList(effectType,effect_name,guid)
if#effectlist>0 then
for i,v in ipairs(effectlist)do
val=val+v[2]
end
end
return val
end

function xingChenHelper.calcEffectAttrListToLookup2(effectType,effect_name,guid)
local lookup={}
local effectlist=xingChenHelper.getEffectList(effectType,effect_name,guid)

if#effectlist>0 then
for i,v in ipairs(effectlist)do
local _attrList=v[2]
for k,v2 in pairs(_attrList)do
local lookup2=lookup[k]or{}
for k2,v3 in pairs(v2)do
lookup2[k2]=(lookup2[k2]or 0)+v3
end
lookup[k]=lookup2
end
end
end

return lookup
end

