






itemsConfig={}







ITEM_GET_USE_TYPE=
{
eAutoUse=1,
eUseAsk=2,
eHighAsk=3,
eJustFirstAsk=4,
eSpecialAutoUse=5,
eAutoUseKuang=6,
}




function itemsConfig.getColorDesc(color)
return eQualityColorName[color]
end


function itemsConfig.getMainType(itemid)






local cfg=cfg_items_id_range_lookup_get(itemid,false)
if cfg and cfg.mainType then
return cfg.mainType
else
if itemsConfig.isMoney(itemid)then
return ITEM_MAIN_TYPE.eMoney
end
loggerUtil.logErrFMT('没有导表或者没有找到物品配置：{0}',itemid)
end
end


function itemsConfig.getBagType(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return itemConfig.bagType
end

function itemsConfig.checkBag(item,putBagType)
local itemid=item.itemid
return itemsConfig.getBagType(itemid)==putBagType
end


function itemsConfig.getConfig(itemid,cfgType)





if cfgType==nil or cfgType==ITEM_CONFIG_TYPE.eItem then
local config=cfg_items_id_range_lookup_get(itemid,false)
if config and config.func then
return config.func(itemid)
end
if moneyConfig.isMoney(itemid)then
return itemsHelper:get_money_config(itemid)
end
loggerUtil.logErrFMT('找不到itemid={0}的配置',itemid)
else
return itemsHelper:getOtherConfig(cfgType,itemid)
end
end


function itemsConfig.getItemName(itemid)
local item_config=itemsConfig.getConfig(itemid)or{}
return item_config.name
end

function itemsConfig.getItemColor(itemid)
local item_config=itemsConfig.getConfig(itemid)or{}
return item_config.color
end


function itemsConfig.getColorName(itemid)
local item_config=itemsConfig.getConfig(itemid)
if item_config==nil then return end
return FMT.cfmt(item_config.color,item_config.name)
end


function itemsConfig.getTipsColorName(itemid)
local item_config=itemsConfig.getConfig(itemid)
if item_config==nil then return end
return FMT.cfmt1(item_config.color,item_config.name)
end

function itemsConfig.getStageName(itemid)
if itemsConfig.isMaterials(itemid)or itemsConfig.isGubao(itemid)then
return'品',true
end
if itemsConfig.isLingZhen(itemid)then
return'级',false
end
return'阶',false
end

local _getMainType=itemsConfig.getMainType
function itemsConfig.isMoney(itemid)
return moneyConfig.isMoney(itemid)
end

function itemsConfig.isEquip(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eEquip
end

function itemsConfig.isItem(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eItem
end

function itemsConfig.isFabao(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eFabao
end

function itemsConfig.isFabaoYuanPei(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eFabaoYuanPei
end

function itemsConfig.isMaterials(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eMaterials
end

function itemsConfig.isFubao(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eFubao
end

function itemsConfig.isGubao(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eGubao
end

function itemsConfig.isDaoBing(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eDaoBing
end

function itemsConfig.isDaoBingMaterials(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eDaoBingMaterials
end

function itemsConfig.isYuHuo(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eYuHuo
end

function itemsConfig.isMaoMao(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eMaoMao
end

function itemsConfig.isMount(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eMount
end

function itemsConfig.isClothing(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eClothing
end

function itemsConfig.isLingZhen(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eYFLingZhen
end

function itemsConfig.isXingChen(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eXingChen
end

function itemsConfig.isYunZhouComponents(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eYunZhouComponents
end

function itemsConfig.isVocEquip(itemid)
return _getMainType(itemid)==ITEM_MAIN_TYPE.eVocEquip
end

function itemsConfig.isMoneyType(mainType)
return mainType==ITEM_MAIN_TYPE.eMoney
end

function itemsConfig.isEquipType(mainType)
return mainType==ITEM_MAIN_TYPE.eEquip
end

function itemsConfig.isItemType(mainType)
return mainType==ITEM_MAIN_TYPE.eItem
end

function itemsConfig.isFabaoType(mainType)
return mainType==ITEM_MAIN_TYPE.eFabao
end

function itemsConfig.isMaterialsType(mainType)
return mainType==ITEM_MAIN_TYPE.eMaterials
end

function itemsConfig.isFubaoType(mainType)
return mainType==ITEM_MAIN_TYPE.eFubao
end

function itemsConfig.isGubaoType(mainType)
return mainType==ITEM_MAIN_TYPE.eGubao
end

function itemsConfig.isDaoBingType(mainType)
return mainType==ITEM_MAIN_TYPE.eDaoBing
end

function itemsConfig.isDaoBingMaterialsType(mainType)
return mainType==ITEM_MAIN_TYPE.eDaoBingMaterials
end

function itemsConfig.isMountType(mainType)
return mainType==ITEM_MAIN_TYPE.eMount
end



function itemsConfig.getFuncParamCndByType(cndType,condition)
if condition and condition[cndType]then
return condition[cndType]
end
end


function itemsConfig.isRare(itemid)
local itemConfig=itemsConfig.getConfig(itemid)

return itemConfig and itemConfig.zhenxiFlag and itemConfig.zhenxiFlag>0
end


function itemsConfig.getRareLv(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return itemsConfig.getRareLvByCfg(itemConfig)
end


function itemsConfig.getRareLvByCfg(itemConfig)
local rareLv=0
if itemConfig and itemConfig.zhenxiFlag then
rareLv=itemConfig.zhenxiFlag
end

if rareLv and rareLv>9 then
rareLv=9
logErr(FMT.fmt("道具{0}的珍惜等级超过9 请检查配置是否正确",itemid))
end

return rareLv or 0
end
