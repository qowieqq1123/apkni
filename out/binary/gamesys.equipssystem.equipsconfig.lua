





equipsConfig={}









EQUIP_TYPE=
{
eWeapon=1,
eClothes=2,
eCap=3,
eShoot=4,
eFabao=5,
eDaoBing=6,
eZhuZhan=7,
eFuBao=8,
eMount=9,
eShiZhuang=10,
eXingChen=11,
eVocEquip=12,
}


EQUIP_SUIT_TYPES=
{
EQUIP_TYPE.eWeapon,
EQUIP_TYPE.eClothes,
EQUIP_TYPE.eCap,
EQUIP_TYPE.eShoot,
}

EQUIP_STAGE_MAX=10


EQUIP_XianMo_TYPES=
{
eXian=1,
eMo=2,
}


function equipsConfig.toBagType(equipType)
if equipType==EQUIP_TYPE.eFabao then
return BAG_TYPE.eFabaoBag
elseif equipType==EQUIP_TYPE.eFubao then
return BAG_TYPE.eFubaoBag
elseif equipType>=EQUIP_TYPE.eWeapon and equipType<=EQUIP_TYPE.eShoot then
return BAG_TYPE.eEquipBag
elseif equipType==EQUIP_TYPE.eDaoBing then
return BAG_TYPE.eDaoBingBag
end

end

function equipsConfig.getEquipType(itemid)
if itemsConfig.isFabao(itemid)then
return EQUIP_TYPE.eFabao
elseif itemsConfig.isFubao(itemid)then
return EQUIP_TYPE.eFuBao
elseif itemsConfig.isEquip(itemid)then
return itemsConfig.getConfig(itemid).type1
elseif itemsConfig.isDaoBing(itemid)then
return EQUIP_TYPE.eDaoBing
elseif itemsConfig.isMount(itemid)then
return EQUIP_TYPE.eMount
elseif itemsConfig.isVocEquip(itemid)then
return EQUIP_TYPE.eVocEquip
else
return EQUIP_TYPE.eZhuZhan
end
end

function equipsConfig.isReallyEquip(equipType)
if equipType>=EQUIP_TYPE.eWeapon and equipType<=EQUIP_TYPE.eShoot then return true end
return false
end

function equipsConfig.getRoleEquipImageId()

end





function equipsConfig.getEquipConstConfig()
return cfg_discipleequiptypeconfig().const_def
end

function equipsConfig.getDressJingjielv(stage)
return equipsConfig.getEquipConstConfig().jingjie[stage]
end

function equipsConfig.getDressState(jjlv)
local stage
local jingjie=equipsConfig.getEquipConstConfig().jingjie
for i,v in ipairs(jingjie)do
if jjlv>=v then
stage=i
end
end
return stage
end

function equipsConfig.getEquipName(equipType)
return cfg_discipleequiptypeconfig_get(equipType).name
end


function equipsConfig.getAllWeaponConfig()
return cfg_discipleweaponconfig()
end


function equipsConfig.getWeaponConfig(id)
return cfg_discipleweaponconfig_get(id)
end


function equipsConfig.getAllSuitConfig()
return cfg_discipleequipsuitconfig()
end


function equipsConfig.getSuitConfig(id)
return cfg_discipleequipsuitconfig_get(id)
end

function equipsConfig.getSuitFilter()
return cfg_discipleequipsuitconfig().const_def.filter
end


function equipsConfig.getAttributesconfig(id)
return cfg_attributesconfig_get(id,true)
end



function equipsConfig.getAllDiziVocationConfig()
return cfg_disciplevocationconfig()
end


function equipsConfig.getDiziVocationConfig(id)
return cfg_disciplevocationconfig_get(id)
end


function equipsConfig.getDiziAttrConfig(id)
return cfg_disciplespeattrconfig_get(id)
end


function equipsConfig.isModAttr(id)
return cfg_attributesconfig_get(id).ifMod
end



function equipsConfig.getDiziTuijian(voc,floor,equipType)
if floor==0 or floor==nil then floor=1 end
local diziVocationConfig=equipsConfig.getDiziVocationConfig(voc)
if equipType==EQUIP_TYPE.eMount then
return diziVocationConfig.tuijianMount[floor]
else
if diziVocationConfig.tuijian[floor]then
return diziVocationConfig.tuijian[floor][equipType]
else
loggerUtil.logErrFMT('没有配置职业{0}境界{1}的推荐装备',voc,floor)
end
end
end


function equipsConfig.getDiziFubaoTuijian(voc,pos)
local diziVocationConfig=equipsConfig.getDiziVocationConfig(voc)
return diziVocationConfig.tuijianFubao[pos]
end



function equipsConfig.getJinglianConfig(equipType,level)
local discipleequipjinglianconfig=cfg_discipleequipjinglianconfig_get(equipType,false)
if discipleequipjinglianconfig then
return discipleequipjinglianconfig[level]
end
loggerUtil.logErrFMT('没找到精炼表：',equipType,level)
end


function equipsConfig.getAllJinglianConfig()
return cfg_discipleequipjinglianconfig()
end

function equipsConfig.getJinglianConstConfig()
return cfg_discipleequipjinglianconfig().const_def
end


function equipsConfig.getJinglianExp(equipType,level,stage)
local jinglianConfig=equipsConfig.getJinglianConfig(equipType,level)or{}
local exp=jinglianConfig.exp
local curExp=exp[stage]
if curExp==nil then
loggerUtil.logErrFMT('没有配置装备{0}阶的所需精炼经验',stage)
end
return curExp or 0
end


function equipsConfig.getJinglianMaxLv(stage)
local const_def=equipsConfig.getJinglianConstConfig()
return const_def.stagelv[stage]or 0
end

function equipsConfig.getJinglianMaxLvByItemid(itemid)
local stage=itemsConfig.getConfig(itemid).stage
return equipsConfig.getJinglianMaxLv(stage)
end


function equipsConfig.getJinglianCost()
local const_def=equipsConfig.getJinglianConstConfig()
return const_def.consume
end


function equipsConfig.isJinglianItem(itemid)
local const_def=equipsConfig.getJinglianConstConfig()
if itemsConfig.isItem(itemid)then
return const_def.itemexp[itemid]
elseif itemsConfig.isEquip(itemid)then
local equipexp=const_def.equipexp or{}
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local color=itemConfig.color
local equipexpStage1=equipexp[stage]or{}
local stageExp=equipexpStage1[color]
return stageExp
end
return false
end

function equipsConfig.getdefaultJinglianItem()
local const_def=equipsConfig.getJinglianConstConfig()
return const_def.itemdefault
end


function equipsConfig.getJinglianItemList()
local const_def=equipsConfig.getJinglianConstConfig()
return const_def.itemexp
end

function equipsConfig.getJinglianLeftExpRatio()
local const_def=equipsConfig.getJinglianConstConfig()
return const_def.leftexp
end

function equipsConfig.getJinglianMinColor()
local const_def=equipsConfig.getJinglianConstConfig()
return const_def.mincolor
end

function equipsConfig.getMaxBetterReddotLv()
return equipsConfig.getEquipConstConfig().betterreddotlv or 10000
end

function equipsConfig.getEquipDianHuaCfg(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local pos=itemCfg.type1
local stage=itemCfg.stage
return cfg_equiprevealconfig_get(stage)[pos]
end

function equipsConfig.getEquipDianHuaDefCfg()
return cfgHelper.getdef(cfg_equiprevealconfig)
end