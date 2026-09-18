





equipListManager=gameState.addListener({})



function equipListManager:onAppStart()

end

function equipListManager:onEnterState()

end

function equipListManager:onLeaveState()

end





function equipListManager.showTips(argstable)
equipListManager.handleEquipByGrids(argstable)
end

function equipListManager.closeTips()
UIManager:closeWindow('UIEquipGainWin')
UIManager:closeWindow('UINewEquipGainWin')
end



function equipListManager.handleEquipByGrids(argstable)
local itemguid=argstable.itemguid or-1
local equipType=argstable.equipType
local diziguid=argstable.diziguid


local diziInfo=UIDiscipleModel:getDiscipleImageInfo(diziguid)
local voc=diziInfo.job
local dizData=UIDiscipleModel:getDiscipleData(diziguid)
local jingJieLv=dizData.jingjielv
local floor=cfgHelper.get2(cfg_disciplejingjieconfig_get,jingJieLv,'floor')
local itemid=equipsConfig.getDiziTuijian(voc,floor,equipType)
local equipConfig=itemsConfig.getConfig(itemid)
local itemType=itemsConfig.getMainType(itemid)
local produce=equipConfig.produce


local equip
if itemguid~=-1 then
equip=equipsHelper.getEquipByDizi(diziguid,equipType)
end


local filter=nil
if itemType==ITEM_MAIN_TYPE.eEquip then
filter=equipListManager.getEquipFilterNames(voc,equipType)
elseif itemType==ITEM_MAIN_TYPE.eFabao then
filter=equipListManager.getFabaoFilterNames()
elseif itemType==ITEM_MAIN_TYPE.eDaoBing then
filter=equipListManager.getDaoBingFilterNames(voc)
elseif itemType==ITEM_MAIN_TYPE.eMount then
filter=equipListManager.getMountFilterNames()
end




local filterfunc=function(filter)
if itemType==ITEM_MAIN_TYPE.eEquip then
return equipListManager.getEquipFilterFunc(diziguid,itemguid,itemType,equipType,voc,filter)
elseif itemType==ITEM_MAIN_TYPE.eFabao then
return equipListManager.getFabaoFilterFunc(diziguid,itemguid,itemType,filter)
elseif itemType==ITEM_MAIN_TYPE.eDaoBing then
return equipListManager.getDaoBingFilterFunc(diziguid,itemguid,itemType,voc,filter)
elseif itemType==ITEM_MAIN_TYPE.eMount then
return equipListManager.getMountFilterFunc(diziguid,itemguid,itemType,voc,filter)
end
end


local list=filterfunc()

local name=equipType==EQUIP_TYPE.eFabao and'法宝列表'or
equipType==EQUIP_TYPE.eFubao and'符宝列表'or
equipType==EQUIP_TYPE.eDaoBing and'道兵列表'or
equipType==EQUIP_TYPE.eMount and'坐骑列表'or
'装备列表'
local title=equipType==EQUIP_TYPE.eFabao and'尚未穿戴法宝'or
equipType==EQUIP_TYPE.eFubao and'尚未穿戴符宝'or
equipType==EQUIP_TYPE.eDaoBing and'尚未穿戴道兵'or
equipType==EQUIP_TYPE.eMount and'尚未穿戴坐骑'or
'尚未穿戴装备'
local gainTitle=equipType==EQUIP_TYPE.eFabao and'当前没有法宝可用'or
equipType==EQUIP_TYPE.eFubao and'当前没有符宝可用'or
equipType==EQUIP_TYPE.eDaoBing and'当前没有道兵可用'or
equipType==EQUIP_TYPE.eMount and'当前没有坐骑可用'or
'当前没有装备可用'
local args=
{
filterfunc=filterfunc,
gainTitle=gainTitle,
item=equip,
filter=filter,
list=list,
produce=produce,
itemid=itemid,
name=name,
diziguid=diziguid,
movepos=argstable.movepos,
title=title,
}
if itemType==ITEM_MAIN_TYPE.eEquip then
tipsManager.closeTips()
UIManager:showWindow('UINewEquipGainWin',args)
else
UIManager:showWindow('UIEquipGainWin',args)
end
end







local _renameType=
{
[eAttributeType.eATK_PCT]='攻击率',
[eAttributeType.eDEF_PCT]='防御率',
[eAttributeType.eHP_PCT]='生命率',
}

function equipListManager.getEquipFilterNames(voc,equipType)
local filter={}


local suitConfig=equipsHelper.getFilterSuit()

local filterSuit=itemsFilterHelper.getFilterNames(suitConfig,function(v)return FMT.fmt('{0}',v.name)end,'套装/所有')

filterSuit.type=ITEM_FILTER_TYPE.eSuitEquip


local list={}
for i,v in ipairs(suitConfig)do
list[i]=v.id
end
filterSuit.list=list

filter[#filter+1]=filterSuit



if equipType==EQUIP_TYPE.eWeapon then

local weaponConfig={}

local weapon=equipsConfig.getDiziVocationConfig(voc).weapon

for i,v in ipairs(weapon)do
weaponConfig[#weaponConfig+1]=cfg_discipleweaponconfig_get(v)
end
local filterWeapon=itemsFilterHelper.getFilterNames(weaponConfig,function(v)return FMT.fmt('{0}',v.name)end,'武器/所有')

filterWeapon.type=ITEM_FILTER_TYPE.eWeapon
filterWeapon.list=weapon

filter[#filter+1]=filterWeapon
end


local filterRandomAttr={}
filterRandomAttr.type=ITEM_FILTER_TYPE.eEquipRandomAttr
filterRandomAttr.list={}
local filterlist={}
local attrs=equipsConfig.getEquipConstConfig().rangeattrs
for i,attrid in ipairs(attrs)do
if _renameType[attrid]then
filterRandomAttr[i]=_renameType[attrid]
else
filterRandomAttr[i]=helper.getAttributeName(attrid)
end
filterlist[#filterlist+1]=attrid
end
filterRandomAttr.list=filterlist
filter[#filter+1]=filterRandomAttr

return filter
end


function equipListManager.getFabaoFilterNames()
local filter={}

local filterBenMeng={}
filterBenMeng[#filterBenMeng+1]="所有"
filterBenMeng[#filterBenMeng+1]="本命法宝"
filterBenMeng[#filterBenMeng+1]="普通法宝"

filterBenMeng.type=ITEM_FILTER_TYPE.eIsBenMingFabao
filterBenMeng.list={1,0}
filter[#filter+1]=filterBenMeng


local list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)

local filterWeapon=itemsFilterHelper.getFilterNames(list,function(v)return FMT.fmt('{0}系',ELEMENT_TYPE.getName(v))end,'所有')

filterWeapon.type=ITEM_FILTER_TYPE.eAnyElement

filter[#filter+1]=filterWeapon
return filter
end


function equipListManager.getDaoBingFilterNames(voc)
local filter={}

local weaponConfig={}

local weapon=equipsConfig.getDiziVocationConfig(voc).weapon

for i,v in ipairs(weapon)do
weaponConfig[#weaponConfig+1]=cfg_discipleweaponconfig_get(v)
end

local filterWeapon=itemsFilterHelper.getFilterNames(weaponConfig,function(v)return FMT.fmt('{0}',v.name)end,'道兵/所有')

filterWeapon.type=ITEM_FILTER_TYPE.eWeapon

filter[#filter+1]=filterWeapon

return filter
end


function equipListManager.getMountFilterNames()
local filter={}

local cfgs=cfg_disciplemounttypeconfig()

local filterWeapon=itemsFilterHelper.getFilterNames(cfgs,
function(v)return FMT.fmt('{0}',v.name)end,
'坐骑/所有')

filterWeapon.type=ITEM_FILTER_TYPE.eMountType

filter[#filter+1]=filterWeapon

return filter
end


function equipListManager.getEquipFilterFunc(diziguid,itemguid,itemType,equipType,voc,filter)
if filter==nil then filter={}end
filter[ITEM_FILTER_TYPE.eItemType]=itemType

filter[ITEM_FILTER_TYPE.eEquipType1]=equipType

filter[ITEM_FILTER_TYPE.eEquipWeaponVoc]=voc

filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}








local equipList=equipsModel.getEquipByFilter(filter)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter)
for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end


for i,v in ipairs(equipList)do
local fightVal=equipsHelper.getEquipFightX(v.itemid,v.itemguid)
if equipsHelper.isCanDress(diziguid,v.itemid)then
v.sortflag=fightVal
else
v.sortflag=-fightVal
end
end
if#equipList>0 then
table.sort(equipList,function(a,b)
local a_sortflag=a.sortflag
local b_sortflag=b.sortflag
if not(a_sortflag<0 and b_sortflag<0)then
return a_sortflag>b_sortflag
else
return a_sortflag<b_sortflag
end
end)
end

for i,v in ipairs(equipList)do
if v.sortflag>0 and not equipsHelper.isDressed(v.itemguid)then
table.remove(equipList,i)
table.insert(equipList,1,v)
break
end
end
return equipList
end


function equipListManager.getFabaoFilterFunc(diziguid,itemguid,itemType,filter)
if filter==nil then filter={}end
filter[ITEM_FILTER_TYPE.eItemType]=itemType
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}

local equipList=fabaoModel.getEquipByFilter(filter)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter)

for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end

local fightSortLookup={}
local fightSort={}

local elementSortLookup={}
local elementSort={}
local elementAttrByGuid={}

for i,v in ipairs(equipList)do
local fightVal=fabaoHelper.getBaseFight(v.itemid,v.itemguid)
if not fightSortLookup[fightVal]then
fightSortLookup[fightVal]=true
fightSort[#fightSort+1]=fightVal
end

local elementAttr=0
local element=filter[ITEM_FILTER_TYPE.eAnyElement]
if element and element>0 then
local attrid=fabaoConfig.getElementConfig(element).attrid
local itemCfg=itemsConfig.getConfig(v.itemid)
local isCfg=equipsHelper.isCfgEquip(v.itemguid)
local elementList=isCfg and fabaoHelper.getElementAttrsListByCfg(itemCfg)or
fabaoHelper.getElementAttrsList(v)or{}

for i1,v1 in ipairs(elementList)do
if v1[1]==attrid then
elementAttr=v1[2]
end
end
end
if not elementSortLookup[elementAttr]then
elementSortLookup[elementAttr]=true
elementSort[#elementSort+1]=elementAttr
end
elementAttrByGuid[v.itemguid]=elementAttr
end

local fightSortMax=#fightSort
table.sort(fightSort,function(a,b)
return a<b
end)
fightSortLookup={}
for i,v in ipairs(fightSort)do
fightSortLookup[v]=i
end

local elementSortMax=#elementSort
table.sort(elementSort,function(a,b)
return a<b
end)
elementSortLookup={}
for i,v in ipairs(elementSort)do
elementSortLookup[v]=i
end


for i,v in ipairs(equipList)do
local fightVal=fabaoHelper.getBaseFight(v.itemid,v.itemguid)
local fightSortIdx=fightSortLookup[fightVal]

local elementAttr=elementAttrByGuid[v.itemguid]
local elementSortIdx=elementSortLookup[elementAttr]


local canDress=fabaoHelper.isCanDress(diziguid,v.itemid,v.itemguid)
local dressSort=canDress==true and 1 or-1

local isBenMing=fabaoConfig.isBenMingFabao(v.itemid)
local benmingSort=0
if isBenMing then
benmingSort=1
local owner=benMingFaBaoHelper.getOwner(v.itemguid)
if tostring(owner)~=tostring(diziguid)then
benmingSort=-1
end
end

v.sortflag=benmingSort*fightSortMax*elementSortMax*10000+
dressSort*fightSortMax*elementSortMax*1000+
fightSortIdx*elementSortMax*100+
elementSortIdx*10+i
end

if#equipList>0 then
table.sort(equipList,function(a,b)
return a.sortflag>b.sortflag
end)
end
return equipList
end


function equipListManager.getDaoBingFilterFunc(diziguid,itemguid,itemType,voc,filter)
if filter==nil then filter={}end
filter[ITEM_FILTER_TYPE.eItemType]=itemType
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}
filter[ITEM_FILTER_TYPE.eEquipWeaponVoc]=voc
local weaponidx=filter[ITEM_FILTER_TYPE.eWeapon]
if weaponidx then
local weapon=equipsConfig.getDiziVocationConfig(voc).weapon
filter[ITEM_FILTER_TYPE.eWeapon]=weapon[weaponidx]
end
local equipList=daobingModel:getEquipByFilter(filter)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter)

for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end


for i,v in ipairs(equipList)do
local fightVal=daobingHelper.getEquipFightX(v.itemid,v.itemguid)
if daobingHelper.isCanDress(diziguid,v.itemguid)then
v.sortflag=fightVal
else
v.sortflag=-fightVal
end
end

if#equipList>0 then
table.sort(equipList,function(a,b)
local a_sortflag=a.sortflag
local b_sortflag=b.sortflag
if not(a_sortflag<0 and b_sortflag<0)then
return a_sortflag>b_sortflag
else
return a_sortflag<b_sortflag
end
end)
end
return equipList
end


function equipListManager.getMountFilterFunc(diziguid,itemguid,itemType,voc,filter)
if filter==nil then filter={}end
filter[ITEM_FILTER_TYPE.eItemType]=itemType
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}
local equipList=mountModel:getMountByFilter(filter)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eMountBag,filter,false)

for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end

local fightFunc=function(equip)
return mountHelper.getFight(equip.itemid)
end


local fightIdxLookup,fightlen=itemsSortHelper.getFightSort(equipList,fightFunc)


local sortFunc=function(v,i)
local itemid=v.itemid
local color=itemsConfig.getConfig(itemid).color
local itemid_idx=itemid/100000
local fight=fightFunc(v)
local fightIdx=fightIdxLookup[fight]
return fightIdx*1000+color*10+i+itemid_idx
end
if#equipList>1 then
local sortTag={}
for i,v in ipairs(equipList)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end

table.sort(equipList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end

return equipList
end


function equipListManager.getVocEquipFilterFunc(diziguid,itemguid,itemType,voc,filter)
if filter==nil then filter={}end
filter[ITEM_FILTER_TYPE.eItemType]=itemType
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{voc}}
local equipList=vocEquipModel:getEquipByFilter(filter)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eVocEquip,filter,false)

for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end

local fightFunc=function(equip)
return mountHelper.getFight(equip.itemid)
end


local fightIdxLookup,fightlen=itemsSortHelper.getFightSort(equipList,fightFunc)


local sortFunc=function(v,i)
local itemid=v.itemid
local color=itemsConfig.getConfig(itemid).color
local itemid_idx=itemid/100000
local fight=fightFunc(v)
local fightIdx=fightIdxLookup[fight]
return fightIdx*1000+color*10+i+itemid_idx
end
if#equipList>1 then
local sortTag={}
for i,v in ipairs(equipList)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end

table.sort(equipList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end

return equipList
end

