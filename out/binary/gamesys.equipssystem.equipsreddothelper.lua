equipsReddotHelper={}
local _cacheFilter={}


function equipsReddotHelper.getBetterReddotByDZ(dzguid,equipType)
local isEquip=equipsConfig.isReallyEquip(equipType)
if isEquip then
return equipsReddotHelper.getBetterEquipReddotByDZ(dzguid,equipType)
elseif equipType==EQUIP_TYPE.eFabao then
return equipsReddotHelper.getBetterFabaoReddotByDZ(dzguid)
elseif equipType==EQUIP_TYPE.eDaoBing then
return equipsReddotHelper.getBetterDaoBingReddotByDZ(dzguid)
elseif equipType==EQUIP_TYPE.eMount then
return equipsReddotHelper.getBetterMountReddotByDZ(dzguid)
elseif equipType==EQUIP_TYPE.eShiZhuang then
return equipsReddotHelper.checkDZClothingReddot(dzguid)
elseif equipType==EQUIP_TYPE.eVocEquip then
return equipsReddotHelper.getBetterVocEquipReddotByDZ(dzguid)
elseif equipType==EQUIP_TYPE.eZhuZhan then
return lingshouModel:checkLingShouBatterReddot(dzguid)
end
return false
end

function equipsReddotHelper.getBetterEquipReddotByDZ(dzguid,equipType)
local isEquip=equipsConfig.isReallyEquip(equipType)
if not isEquip then return false end
local equip=equipsHelper.getEquipByDizi(dzguid,equipType)
if equip then
local lv=zongmenModel:getLevel()or 1
if lv>=equipsConfig.getMaxBetterReddotLv()then return false end
end
local fight=0
local suitid
if equip then
fight=equipsHelper.getEquipFightX(equip.itemid,equip.itemguid)
local itemData=equip.itemData
if itemData then
suitid=itemData.suitid
end
end

local bagType=equipsConfig.toBagType(equipType)
table.clear(_cacheFilter)
_cacheFilter[ITEM_FILTER_TYPE.eEquipType1]=equipType
_cacheFilter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
if suitid and suitid>0 then
_cacheFilter[ITEM_FILTER_TYPE.eSuitEquip]=suitid
end
_cacheFilter[ITEM_FILTER_TYPE.eCheckEquipDress]=dzguid
return bagControl.hasBagItems(bagType,_cacheFilter)
end

function equipsReddotHelper.getBetterFabaoReddotByDZ(dzguid)

local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip then

return false
end






table.clear(_cacheFilter)

_cacheFilter[ITEM_FILTER_TYPE.eCheckOtherFaBaoOwner]={ITEM_FILTER_COMPARE.eNot,dzguid}
_cacheFilter[ITEM_FILTER_TYPE.eCheckEquipDress]=dzguid
return bagControl.hasBagItems(BAG_TYPE.eFabaoBag,_cacheFilter)
end

function equipsReddotHelper.getBetterDaoBingReddotByDZ(dzguid)
if not daobingHelper.isDZCanDress(dzguid)then return false end
if not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then return false end
local equip=daobingModel:getEquipByDizi(dzguid)
local fight=0
if equip then
fight=daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
end

table.clear(_cacheFilter)
_cacheFilter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
_cacheFilter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing
_cacheFilter[ITEM_FILTER_TYPE.eCheckEquipDress]=dzguid
return bagControl.hasBagItems(BAG_TYPE.eDaoBingBag,_cacheFilter)
end

function equipsReddotHelper.getBetterMountReddotByDZ(dzguid)
if not mountHelper.isCanDressByDZ(dzguid)then return false end
local equip=mountModel:getMountByDZ(dzguid)
if equip then return false end
local fight=0
if equip then
fight=mountHelper.getFight(equip.itemid)
end
table.clear(_cacheFilter)
_cacheFilter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
return bagControl.hasBagItems(BAG_TYPE.eMountBag,_cacheFilter)
end

function equipsReddotHelper.getBetterVocEquipReddotByDZ(dzguid)
local equip=vocEquipModel:getEquipByDizi(dzguid)
local fight=0
if equip then
fight=vocEquipHelper.getEquipFightX(equip.itemid,equip.itemguid)
end

local bagType=BAG_TYPE.eVocEquip
table.clear(_cacheFilter)
local voc=UIDiscipleModel:getDiscipleJob(dzguid)
_cacheFilter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eVocEquip
_cacheFilter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{voc}}
_cacheFilter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
_cacheFilter[ITEM_FILTER_TYPE.eCheckEquipDress]=dzguid
return bagControl.hasBagItems(bagType,_cacheFilter)
end


function equipsReddotHelper.checkDZAllEquipReddot(diziguid)
for _,equipType in pairs(EQUIP_SUIT_TYPES)do
local reddot=equipsReddotHelper.getBetterReddotByDZ(diziguid,equipType)
if reddot then
return true
end
end
return false
end

function equipsReddotHelper.checkDZAFaBaoReddot(diziguid)
local reddot=equipsReddotHelper.getBetterReddotByDZ(diziguid,EQUIP_TYPE.eFabao,true)
return reddot
end

function equipsReddotHelper.checkDZClothingReddot(diziguid)
if not systemModel.isOpen(SYSTEM_DEFINE.eClothing)then return false end

local equip=ClothingModel:getEquipByDizi(diziguid)

if equip then
return false
end

if not ClothingHelper.checkDiziConfig(UIDiscipleModel:getDiscipleID(diziguid))then
return false
end

table.clear(_cacheFilter)
_cacheFilter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eClothing
_cacheFilter[ITEM_FILTER_TYPE.eCheckEquipDress]=diziguid
return bagControl.hasBagItems(BAG_TYPE.eClothing,_cacheFilter)
end