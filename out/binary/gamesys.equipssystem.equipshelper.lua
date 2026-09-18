





equipsHelper={}




local _equipWeaponLimitVoc







function equipsHelper.getEquip(itemguid)
return bagModel.getItem(itemguid)or
equipsModel.getEquip(itemguid)or
fabaoHelper.getFabao(itemguid)or
mountModel:getMount(itemguid)or
watchModel.getItem(itemguid)or
fairModel.getItem(itemguid)or
daobingModel:getEquip(itemguid)or
auctionModel:getItem(itemguid)or
mailModel:getItem(itemguid)or
UIFuLuFangModel:getItem(itemguid)or
ClothingModel:getEquip(itemguid)or
xingChenBagModel:getEquip(itemguid)or
vocEquipModel:getEquip(itemguid)
end

function equipsHelper.isCfgEquip(itemguid)
if itemguid==nil then return true end
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return true end
local itemData=equip.itemData
return not itemData or not next(itemData)
end

function equipsHelper.getEquipByDizi(diziguid,equipType)
if equipType==EQUIP_TYPE.eFabao then
return fabaoModel.getFabaoByDizi(diziguid)
elseif equipType==EQUIP_TYPE.eDaoBing then
return daobingModel:getEquipByDizi(diziguid)
elseif equipType==EQUIP_TYPE.eMount then
return mountModel:getMountByDZ(diziguid)
elseif equipType==EQUIP_TYPE.eShiZhuang then
return ClothingModel:getEquipByDizi(diziguid)
elseif equipType==EQUIP_TYPE.eVocEquip then
return vocEquipModel:getEquipByDizi(diziguid)
end
return equipsModel.getEquipByDizi(diziguid,equipType)
end


function equipsHelper.getLimitVoc(type2)
if type2==nil then return end
if _equipWeaponLimitVoc==nil then
_equipWeaponLimitVoc={}
local disciplevocationconfig=equipsConfig.getAllDiziVocationConfig()
for voc,v in pairs(disciplevocationconfig)do
for _,type2 in ipairs(v.weapon)do
if _equipWeaponLimitVoc[type2]==nil then _equipWeaponLimitVoc[type2]={}end
local vocList=_equipWeaponLimitVoc[type2]
vocList[#vocList+1]=voc
end
end
end
return _equipWeaponLimitVoc[type2]
end








function equipsHelper.canEquipWeaponByVoc(itemid,voc,warning)
if not itemsConfig.isEquip(itemid)then return true end
local itemConfig=itemsConfig.getConfig(itemid)
local type2=itemConfig.type2
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip and isxmEquip>0 then
local joblist=equipsModel.getEquipXMJobList(itemid)
if joblist[voc]and joblist[voc]==1 then
else
if warning then
UIManager.error('职业不匹配，无法穿戴')
end
return false
end
end
if type2==nil then return true end
local voclist=equipsHelper.getLimitVoc(type2)
if voclist==nil then return true end
for i,v in ipairs(voclist)do
if v==voc then
return true
end
end
if warning then
UIManager.error('职业不匹配，无法穿戴')
end
return false
end

function equipsHelper.isWeapon(itemid)
local config=itemsConfig.getConfig(itemid)
return config.type2~=nil
end

function equipsHelper.isCanDress(diziguid,itemid,warning)
local job=UIDiscipleModel:getDiscipleJob(diziguid)
if not equipsHelper.canEquipWeaponByVoc(itemid,job,warning)then
return false
end
local needJingJieLv=equipsHelper.getDressJingjielv(itemid)
local jingJieLv=UIDiscipleModel:getDiscipleJJLevel(diziguid)
if needJingJieLv>jingJieLv then
if warning then

UIManager.error('弟子境界等级不足')
end
return false
end
return true
end

function equipsHelper.getDressJingjielv(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return equipsConfig.getDressJingjielv(itemConfig.stage)
end

function equipsHelper.isDressed(itemguid)
return equipsModel.getDiziguidByItemguid(itemguid)~=nil
end

function equipsHelper.isDressedByDizi(diziguid,itemguid)
return equipsModel.getDiziguidByItemguid(itemguid)~=nil
end



function equipsHelper.getBetterEquipBydizi(diziguid,equipType,useCache)
local isEquip=equipsConfig.isReallyEquip(equipType)
if isEquip then
return equipsHelper.getBetterOnlyEquipBydizi(diziguid,equipType,useCache)
elseif equipType==EQUIP_TYPE.eFabao then
return equipsHelper.getBetterOnlyFabaoBydizi(diziguid,equipType,useCache)
elseif equipType==EQUIP_TYPE.eDaoBing then
return equipsHelper.getBetterOnlyDaoBingBydizi(diziguid,equipType,useCache)
elseif equipType==EQUIP_TYPE.eMount then
return equipsHelper.getBetterOnlyMountBydizi(diziguid,useCache)
end
end

function equipsHelper.getBetterOnlyEquipBydizi(diziguid,equipType,useCache)
local bagType=equipsConfig.toBagType(equipType)
local isEquip=bagType==BAG_TYPE.eEquipBag
if not isEquip then return end
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
local fight=0
if equip then
fight=equipsHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
local bagType=equipsConfig.toBagType(equipType)
local filter={}
filter[ITEM_FILTER_TYPE.eEquipType1]={ITEM_FILTER_COMPARE.eEquals,equipType}
filter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}


local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(diziguid)
if xm_voc>0 then
if xm_voc==EQUIP_XianMo_TYPES.eXian then
filter[ITEM_FILTER_TYPE.eEquipXMType]={ITEM_FILTER_COMPARE.eNot,EQUIP_XianMo_TYPES.eMo}
elseif xm_voc==EQUIP_XianMo_TYPES.eMo then
filter[ITEM_FILTER_TYPE.eEquipXMType]={ITEM_FILTER_COMPARE.eNot,EQUIP_XianMo_TYPES.eXian}
end
else
filter[ITEM_FILTER_TYPE.eEquipXMType]={ITEM_FILTER_COMPARE.eNot,{EQUIP_XianMo_TYPES.eXian,EQUIP_XianMo_TYPES.eMo}}
end
local list=bagControl.getBagItemsByFilter(bagType,filter,false,useCache)or{}

if#list>1 then
for _,v in pairs(list)do
v.totalFightX__=equipsHelper.getEquipFightX(v.itemid,v.itemguid)
end
table.sort(list,function(a,b)
return a.totalFightX__>b.totalFightX__
end)
end
local temp={}
for i,v in ipairs(list)do
local itemid=v.itemid
if equipsHelper.isCanDress(diziguid,itemid)then
temp[#temp+1]=v
end
end
return temp
end

function equipsHelper.getBetterOnlyFabaoBydizi(diziguid,equipType,useCache)
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
local fight=0
if equip then
fight=fabaoHelper.getBaseFight(equip.itemid,equip.itemguid)
end
local filter={}
filter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
filter[ITEM_FILTER_TYPE.eCheckOtherFaBaoOwner]={ITEM_FILTER_COMPARE.eNot,{diziguid}}
local list=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,useCache)or{}

if#list>1 then
for _,v in pairs(list)do
v.totalFight__=fabaoHelper.getBaseFight(v.itemid,v.itemguid)
end
table.sort(list,function(a,b)
return a.totalFight__>b.totalFight__
end)
end
local temp={}
for i,v in ipairs(list)do
local itemid=v.itemid
local itemguid=v.itemguid
if fabaoHelper.isCanDress(diziguid,itemid,itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function equipsHelper.getBetterOnlyDaoBingBydizi(diziguid,equipType,useCache)
if not daobingHelper.isDZCanDress(diziguid)then return{}end
if not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then return{}end
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
local fight=0
if equip then
fight=daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
local filter={}
filter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing
local list=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false,useCache)or{}

if#list>1 then
for _,v in pairs(list)do
v.totalFightX__=daobingHelper.getEquipFightX(v.itemid,v.itemguid)
end
table.sort(list,function(a,b)
return a.totalFightX__>b.totalFightX__
end)
end
local temp={}
for i,v in ipairs(list)do
local itemid=v.itemid
local itemguid=v.itemguid
if daobingHelper.isCanDress(diziguid,itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function equipsHelper.getBetterOnlyMountBydizi(diziguid,useCache)
if not mountHelper.isCanDressByDZ(diziguid)then return{}end
local equip=mountModel:getMountByDZ(diziguid)
local fight=0
if equip then
fight=mountHelper.getFight(equip.itemid)
end
local filter={}
filter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
local list=bagControl.getBagItemsByFilter(BAG_TYPE.eMountBag,filter,false,useCache)or{}
if#list>1 then
for _,v in pairs(list)do
v.totalFight__=mountHelper.getFight(v.itemid)
end
table.sort(list,function(a,b)
return a.totalFight__>b.totalFight__
end)
end
return list
end

function equipsHelper.getBetterOnlyClothingBydizi(diziguid,equipType,useCache)
if not systemModel.isOpen(SYSTEM_DEFINE.eClothing)then return{}end
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
local fight=0
if equip then
fight=ClothingHelper.getEquipFightX(equip.itemguid)
end
local filter={}
filter[ITEM_FILTER_TYPE.eFight]={ITEM_FILTER_COMPARE.eGreater,fight}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eClothing
local list=bagControl.getBagItemsByFilter(BAG_TYPE.eClothing,filter,false,useCache)or{}

if#list>1 then
for _,v in pairs(list)do
v.totalFightX__=ClothingHelper.getEquipFightX(v.itemguid)
end
table.sort(list,function(a,b)
return a.totalFightX__>b.totalFightX__
end)
end

local temp={}
for i,v in ipairs(list)do
local itemid=v.itemid
local itemguid=v.itemguid
if ClothingHelper.isCanDress(diziguid,itemguid)then
temp[#temp+1]=v
end
end
return temp
end


function equipsHelper.getBetterEquipListBydizi(diziguid,replaceEquipd,suitAttrsSkip,useCache)
local list={}
if not fabaoModel.getFabaoByDizi(diziguid)then
local equipType=EQUIP_TYPE.eFabao
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
local betterList=equipsHelper.getBetterEquipBydizi(diziguid,equipType,useCache)
if betterList and#betterList>0 then
list[#list+1]=betterList[1].itemguid
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
local equipType=EQUIP_TYPE.eDaoBing
if not daobingModel:getEquipByDizi(diziguid)then
local betterList=equipsHelper.getBetterEquipBydizi(diziguid,equipType,useCache)
if betterList and#betterList>0 then
list[#list+1]=betterList[1].itemguid
end
end
end


















local hasSuitAttr=equipsHelper.hasSuitAttr(diziguid)
if hasSuitAttr and suitAttrsSkip then
replaceEquipd=false
end
for i=EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot do
local equipType=i
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equip==nil or equip and replaceEquipd then
local betterList=equipsHelper.getBetterEquipBydizi(diziguid,equipType,useCache)
if betterList and#betterList>0 then
list[#list+1]=betterList[1].itemguid
end
end
end
return list
end

function equipsHelper.getFilterSuit()
local zmlv=zongmenModel:getLevel()
local filterSuit=equipsConfig.getSuitFilter()
local suitIds={}
for lv,v in pairs(filterSuit)do
if zmlv>=lv then
suitIds=table.concatTableX(suitIds,v)
end
end

local suitCfgs={}
for i,v in ipairs(suitIds)do
suitCfgs[#suitCfgs+1]=equipsConfig.getSuitConfig(v)
end
return suitCfgs
end

function equipsHelper.getSuitIconByArgs(itemguid,itemid)
local equip=equipsHelper.getEquip(itemguid)
if equip then
return equipsHelper.getEquipSuitIcon(equip)
end
return equipsHelper.getEquipSuitIconByFix(itemid)
end

function equipsHelper.getSuitIcon(equip)
local itemid=equip.itemid
if not itemsConfig.isEquip then return''end
return equipsHelper.getEquipSuitIcon(equip)
end

function equipsHelper.getEquipSuitIcon(equip)
if equip==nil then return''end
local itemData=equip.itemData or{}
local suitid=itemData.suitid or 0
return equipsHelper.getEquipSuitIconById(suitid)
end

function equipsHelper.getEquipSuitIconById(suitid)
if suitid and suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
return iconHelper.getSuitIcon(suitConfig.icon)
end
return''
end

function equipsHelper.getEquipSuitIconByFix(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
if not itemsConfig.isEquip(itemid)then return''end
if itemCfg.fix and itemCfg.fix[0]then
local suitid=itemCfg.fix[0].suitid
return equipsHelper.getEquipSuitIconById(suitid)
end
return''
end