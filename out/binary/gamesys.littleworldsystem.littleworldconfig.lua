








function LittleWorldModel.getPopulationMax(world_lv)
local addValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldAttrLimit)
local addVal=addValLookup[eLittleWorldAttr.population]or 0
local mortal=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"mortal")
return mathHelper.floor(mortal[1]*(1+(addVal/100)))
end

function LittleWorldModel.getPopulationAdd(world_lv)
local addValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldAttrRate)
local addVal=addValLookup[eLittleWorldAttr.population]or 0
addVal=1+(addVal/100)
local zwEffect=LittleWorldModel:getZhenWuAttrEffectById(eLittleWorldAttr.population)
addVal=1+(zwEffect/100)
local mortal=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"mortal")
return{mathHelper.floor(mortal[2][1]*addVal),mortal[2][2]*addVal}
end

function LittleWorldModel.getXiaoHuoValMax(world_lv)
local addValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldAttrLimit)
local addVal=addValLookup[eLittleWorldAttr.xhVal]or 0
local incense=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"incense")
return mathHelper.floor(incense*(1+(addVal/100)))
end


function LittleWorldModel.getStabilityMax()
local addValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldAttrLimit)
local addVal=addValLookup[eLittleWorldAttr.stableVal]or 0
local stability_value=cfgHelper.get(cfg_smallworldconfig_get,1,"stability_value")
return mathHelper.floor(stability_value*(1+(addVal/100)))
end


function LittleWorldModel.getMoneyProductTime()
return cfgHelper.get(cfg_smallworldconfig_get,1,"money_create_time")
end


function LittleWorldModel.getItemProductTime()
return cfgHelper.get(cfg_smallworldconfig_get,1,"item_create_time")or 0
end


function LittleWorldModel.getWorldBaseAttr(world_lv)
return cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"attr_list")or{}
end

function LittleWorldModel.getZWEffectConfig(id,star)
return cfgHelper.get(cfg_smallworldtownstarconfig_get,id,star,"effects")or{}
end

function LittleWorldModel.get_money_drop_id1(world_lv)
local pop=LittleWorldModel:getLittleWorldPopulation()
local moneyDrop=cfgHelper.get(cfg_smallworldconfig_get,1,"money_drop_id")
for i,v in ipairs(moneyDrop)do
if pop>=v[1][1]and pop<=v[1][2]then
return v[2]
end
end
end

function LittleWorldModel.get_item_drop_id1(world_lv)
local pop=LittleWorldModel:getLittleWorldPopulation()
local item_drop_id1=cfgHelper.get(cfg_smallworldconfig_get,1,"item_drop_id")
if not item_drop_id1 then
return
end
for i,v in ipairs(item_drop_id1)do
if pop>=v[1][1]and pop<=v[1][2]then
return v[2]
end
end
end

function LittleWorldModel.get_zw_big_icon(icon)
return'icon_zw_l_'..icon
end