






itemsHelper={}






local s_format=string.format


local _config=
{
[ITEM_MAIN_TYPE.eItem]={
spliter=100,
configPath='data/config/itemconfig_%d',
},
[ITEM_MAIN_TYPE.eEquip]={
spliter=1000,
configPath='data/config/equipconfig_%d',
},
[ITEM_MAIN_TYPE.eFabao]={
spliter=1000,
configPath='data/config/fabaoconfig_%d',
},
[ITEM_MAIN_TYPE.eMoney]={
spliter=1,
configPath='data/config/moneyconfig',
},
[ITEM_MAIN_TYPE.eMaterials]={
spliter=100,
configPath='data/config/materialconfig_%d',
},
[ITEM_MAIN_TYPE.eFubao]={
spliter=1000,
configPath='data/config/fubaoequipconfig_%d',
},
[ITEM_MAIN_TYPE.eGubao]={
spliter=100,
configPath='data/config/gubaomaterialconfig_%d',
},
[ITEM_MAIN_TYPE.eRongYu]={
spliter=100,
configPath='data/config/honoritemconfig_%d',
},
[ITEM_MAIN_TYPE.eDaoBing]={
spliter=1000,
configPath='data/config/daobingconfig_%d',
},
[ITEM_MAIN_TYPE.eFabaoYuanPei]={
spliter=1000,
configPath='data/config/fabaoyuanpeiconfig_%d',
},
[ITEM_MAIN_TYPE.eDaoBingMaterials]={
spliter=100,
configPath='data/config/daobingmaterialconfig_%d',
},
[ITEM_MAIN_TYPE.eYuHuo]={
spliter=100,
configPath='data/config/catchconfig_%d',
},
[ITEM_MAIN_TYPE.eMaoMao]={
spliter=1000,
configPath='data/config/catequipconfig_%d',
},
[ITEM_MAIN_TYPE.eMount]={
spliter=1000,
configPath='data/config/mountconfig_%d',
},
[ITEM_MAIN_TYPE.eYFLingZhen]={
spliter=100,
configPath='data/config/yufulingzhenconfig_%d',
},
[ITEM_MAIN_TYPE.eClothing]={
spliter=1000,
configPath='data/config/dressconfig_%d',
},
[ITEM_MAIN_TYPE.eXingChen]={
spliter=1000,
configPath='data/config/starsconfig_%d',
},
[ITEM_MAIN_TYPE.eYunZhouComponents]={
spliter=1000,
configPath='data/config/boatequipconfig_%d',
},
[ITEM_MAIN_TYPE.eVocEquip]={
spliter=1000,
configPath='data/config/vocequipconfig_%d',
},
[ITEM_MAIN_TYPE.eLingShou]={
spliter=100,
configPath='data/config/itemconfig_%d',
},
}


ITEM_CONFIG_TYPE=
{
eItem=1,
eGuBao=2,
eXianBao=3,
}

local _otherConfig=
{
[ITEM_CONFIG_TYPE.eGuBao]=function(itemid)
local gbcfg=cfgHelper.get1(cfg_gubaoconfig_get,itemid)
local active_itemid=gubaoLookup:gubao2GoodActive(itemid)
local itemcfg
if active_itemid then
itemcfg=itemsConfig.getConfig(active_itemid)
end
return gbcfg,itemcfg
end,
[ITEM_CONFIG_TYPE.eXianBao]=function(itemid)
local xbcfg=cfgHelper.get1(cfg_xianbaoconfig_get,itemid)
return xbcfg
end,
}


local _items_list={}
function itemsHelper:get_base_config(main_type,item_id)
if _items_list[main_type]==nil then _items_list[main_type]={}end
local _item=_items_list[main_type]
local data=_item[item_id]
if not data then
local config=_config[main_type]
local spliter=config.spliter
local configPath=config.configPath
local subTable
if spliter==1 then
subTable=require(configPath)
else
subTable=require(s_format(configPath,math.floor(item_id/spliter)))
end
for k,v in pairs(subTable)do
_item[v.id]=v
end
data=_item[item_id]
end

return data
end

function itemsHelper:get_base(main_type)
return _items_list[main_type]
end


function itemsHelper:get_item_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eItem,item_id)
end


function itemsHelper:get_equip_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eEquip,item_id)
end


function itemsHelper:get_fabao_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eFabao,item_id)
end


function itemsHelper:get_money_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eMoney,item_id)
end


function itemsHelper:get_materials_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eMaterials,item_id)
end

function itemsHelper:get_fubao_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eFubao,item_id)
end

function itemsHelper:get_gubao_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eGubao,item_id)
end

function itemsHelper:get_rongyu_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eRongYu,item_id)
end

function itemsHelper:get_daobing_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eDaoBing,item_id)
end

function itemsHelper:get_fabaoYuanPei_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eFabaoYuanPei,item_id)
end

function itemsHelper:get_daobingMaterials_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eDaoBingMaterials,item_id)
end

function itemsHelper:get_yuhuo_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eYuHuo,item_id)
end

function itemsHelper:get_maomao_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eMaoMao,item_id)
end

function itemsHelper:get_mount_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eMount,item_id)
end

function itemsHelper:get_yflingzhen_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eYFLingZhen,item_id)
end

function itemsHelper:get_clothing_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eClothing,item_id)
end

function itemsHelper:get_xingchen_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eXingChen,item_id)
end

function itemsHelper:get_yunzhoucomponents_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eYunZhouComponents,item_id)
end

function itemsHelper:get_vocequipconfig_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eVocEquip,item_id)
end

function itemsHelper:get_newtype_config(item_id)
return itemsHelper:get_base_config(ITEM_MAIN_TYPE.eLingShou,item_id)
end

function itemsHelper:getOtherConfig(cfgType,item_id)
if _otherConfig[cfgType]then
return _otherConfig[cfgType](item_id)
end
end

function itemsHelper:getEquipLookUp()
return cfg_equip_lookup()
end