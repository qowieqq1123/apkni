bagSortConfig={}

local _sortConfig={}


local bagType=SHOW_BAG_TYPE.eItemBag
_sortConfig[bagType]={}
local sortConfig=_sortConfig[bagType]


local config={}
config.type=ITEM_SORT_TYPE.eColor
config.name='品质'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareColorTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eStage
config.name='品阶'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareStageTag(a,sortCompareType)
end



local bagType=SHOW_BAG_TYPE.eMaterialsBag
_sortConfig[bagType]={}
local sortConfig=_sortConfig[bagType]


local config={}
config.type=ITEM_SORT_TYPE.eColor
config.name='品质'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareColorTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eStage
config.name='品阶'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareStageTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eElement
config.name='五行'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareElementTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local bagType=SHOW_BAG_TYPE.eEquipBag
_sortConfig[bagType]={}
local sortConfig=_sortConfig[bagType]











local config={}
config.type=ITEM_SORT_TYPE.eColor
config.name='品质'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareEquipColorTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eStage
config.name='品阶'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareEquipStageTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eFight
config.name='战力'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareEquipFightTag(a,sortCompareType)
end
config.sortFun=function(itemList,sortType)
local wigetList={}

for index,itemData in ipairs(itemList)do
local itemid=itemData.itemid
local itemguid=itemData.itemguid
local cfg=itemsConfig.getConfig(itemid)
local isEquip=itemsConfig.isEquip(itemid)
local fight=isEquip and equipsHelper.getEquipFightX(itemid,itemguid)or fabaoHelper.getBaseFight(itemid,itemguid)or 0

local type1=cfg.type1 or 0
local color=cfg.color or 0
local stage=cfg.stage or 0
local xm=cfg.type3 and 1 or 0

local widget
if sortType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
widget=100000-xm*10000-type1*1000-(color*100+stage*1+itemid*0.00001)
wigetList[tostring(itemguid)]={fight,widget,xm}
else
widget=100000+xm*10000+type1*1000+(color*100+stage*1+itemid*0.00001)
wigetList[tostring(itemguid)]={fight,widget,xm}
end
end

table.sort(itemList,function(a,b)
local aWigetData=wigetList[tostring(a.itemguid)]
local bWigetData=wigetList[tostring(b.itemguid)]

if sortType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
if aWigetData[3]==bWigetData[3]then
if aWigetData[1]==bWigetData[1]then
return aWigetData[2]<bWigetData[2]
else
return aWigetData[1]<bWigetData[1]
end
else
return aWigetData[3]<bWigetData[3]
end
else
if aWigetData[3]==bWigetData[3]then
if aWigetData[1]==bWigetData[1]then
return aWigetData[2]>bWigetData[2]
else
return aWigetData[1]>bWigetData[1]
end
else
return aWigetData[3]>bWigetData[3]
end
end
end)
end
sortConfig[#sortConfig+1]=config


local bagType=SHOW_BAG_TYPE.eFabaoBag
_sortConfig[bagType]={}
local sortConfig=_sortConfig[bagType]


local config={}
config.type=ITEM_SORT_TYPE.eColor
config.name='品质'
config.sortTag=function(a,sortCompareType)
local bmsortNum=fabaoConfig.isBenMingFabao(a.itemid)and 100000 or 0
return bagSortConfig.getCompareColorTag(a,sortCompareType)+bmsortNum
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eStage
config.name='品阶'
config.sortTag=function(a,sortCompareType)
local bmsortNum=fabaoConfig.isBenMingFabao(a.itemid)and 100000 or 0
return bagSortConfig.getCompareStageTag(a,sortCompareType)+bmsortNum
end



local config={}
config.type=ITEM_SORT_TYPE.eJingjie
config.name='境界'
config.sortTag=function(a,sortCompareType)
local bmsortNum=fabaoConfig.isBenMingFabao(a.itemid)and 100000 or 0
return bagSortConfig.getCompareJingjieTag(a,sortCompareType)+bmsortNum
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eFight
config.name='战力'
config.sortFun=function(equipList,sortCompareType)
local sortTag={}


local fightFunc=function(equip)
return fabaoHelper.getBaseFight(equip.itemid,equip.itemguid)
end


local fightIdxLookup,fightlen=itemsSortHelper.getFightSort(equipList,fightFunc)


local sortFunc=function(v,i)
local itemid=v.itemid
local itemguid=v.itemguid
local itemsCfg=itemsConfig.getConfig(itemid)
local color=itemsCfg.color
local stage=itemsCfg.stage

local fightVal=fightFunc(v)
local fightIdx=fightIdxLookup[fightVal]


local benmingSort=0
if fabaoConfig.isBenMingFabao(itemid)then
benmingSort=1
end
return benmingSort*fightlen*100000+
fightIdx*10000+
color*1000+stage*10+i+itemid*0.00001
end


for i,v in ipairs(equipList)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end


if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
table.sort(equipList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
else
table.sort(equipList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end
end




sortConfig[#sortConfig+1]=config


local bagType=SHOW_BAG_TYPE.eFubaoBag
_sortConfig[bagType]={}
local sortConfig=_sortConfig[bagType]


local config={}
config.type=ITEM_SORT_TYPE.eColor
config.name='品质'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareColorTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eStage
config.name='品阶'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareStageTag(a,sortCompareType)
end











































































































































































































































































local bagType=SHOW_BAG_TYPE.eRareBag
_sortConfig[bagType]={}
local sortConfig=_sortConfig[bagType]


local config={}
config.type=ITEM_SORT_TYPE.eBagType
config.name='类型'
config.sortFun=function(itemList,sortCompareType)
local sortTag={}

local len=#itemList


local fightFunc=function(equip)
if itemsConfig.isDaoBing(equip.itemid)then
return daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
elseif itemsConfig.isMount(equip.itemid)then
return mountHelper.getFight(equip.itemid)
elseif itemsConfig.isClothing(equip.itemid)then
return ClothingHelper.getEquipFightX(equip.itemguid)
elseif itemsConfig.isVocEquip(equip.itemid)then
return vocEquipHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
end


local fightIdxLookup,fightlen=itemsSortHelper.getFightSort(itemList,fightFunc)


local sortFunc=function(v,i)
local itemid=v.itemid
local itemid_idx=itemid/100000
local isSp=itemsConfig.isDaoBingMaterials(itemid)
if isSp then
local combine=daobingHelper.isCanCombine(itemid)
local color=itemsConfig.getConfig(itemid).color
local spTag=0
if combine then
spTag=1000000*len+
color*10000
else
spTag=-1000000*len+
color*10000
end
return spTag+i+itemid_idx
else
local typeSort=1
if itemsConfig.isDaoBing(itemid)then
typeSort=3
elseif itemsConfig.isMount(itemid)then
typeSort=1
elseif itemsConfig.isClothing(itemid)then
typeSort=2
elseif itemsConfig.isVocEquip(itemid)then
typeSort=4
end
local fight=fightFunc(v)
local fightIdx=fightIdxLookup[fight]
return fightIdx*1000+i+itemid_idx+typeSort*10000
end
end


for i,v in ipairs(itemList)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end


if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
table.sort(itemList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
else
table.sort(itemList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end
end
sortConfig[#sortConfig+1]=config

local config={}
config.type=ITEM_SORT_TYPE.eFight
config.name='战力'
config.sortFun=function(itemList,sortCompareType)
local sortTag={}

local len=#itemList


local fightFunc=function(equip)
if itemsConfig.isDaoBing(equip.itemid)then
return daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
elseif itemsConfig.isMount(equip.itemid)then
return mountHelper.getFight(equip.itemid)
elseif itemsConfig.isClothing(equip.itemid)then
return ClothingHelper.getEquipFightX(equip.itemguid)
elseif itemsConfig.isVocEquip(equip.itemid)then
return vocEquipHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
end


local fightIdxLookup,fightlen=itemsSortHelper.getFightSort(itemList,fightFunc)


local sortFunc=function(v,i)
local itemid=v.itemid
local itemid_idx=itemid/100000
local isSp=itemsConfig.isDaoBingMaterials(itemid)
if isSp then
local combine=daobingHelper.isCanCombine(itemid)
local color=itemsConfig.getConfig(itemid).color
local spTag=0
if combine then
spTag=1000000*len+
color*10000
else
spTag=-1000000*len+
color*10000
end
return spTag+i+itemid_idx
else
local fight=fightFunc(v)
local fightIdx=fightIdxLookup[fight]
return fightIdx*1000+i+itemid_idx
end
end


for i,v in ipairs(itemList)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end


if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
table.sort(itemList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
else
table.sort(itemList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eStage
config.name='星级'
config.sortFun=function(itemList,sortCompareType)
local sortTag={}

local len=#itemList


local fightFunc=function(equip)
if itemsConfig.isDaoBing(equip.itemid)then
return daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
elseif itemsConfig.isMount(equip.itemid)then
return mountHelper.getFight(equip.itemid)
elseif itemsConfig.isClothing(equip.itemid)then
return ClothingHelper.getEquipFightX(equip.itemguid)
elseif itemsConfig.isVocEquip(equip.itemid)then
return vocEquipHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
end


local fightIdxLookup,fightlen=itemsSortHelper.getFightSort(itemList,fightFunc)


local sortFunc=function(v,i)
local itemid=v.itemid
local itemid_idx=itemid/100000
local isSp=itemsConfig.isDaoBingMaterials(itemid)
if isSp then
local combine=daobingHelper.isCanCombine(itemid)
local color=itemsConfig.getConfig(itemid).color
local spTag=0
if combine then
spTag=1000000*len+
color*10000
else
spTag=-1000000*len+
color*10000
end
return spTag+i+itemid_idx
else
local star=0
if itemsConfig.isDaoBing(itemid)then
star=daobingModel:getStarLv(v.itemguid)
elseif itemsConfig.isMount(itemid)then
star=0
elseif itemsConfig.isClothing(itemid)then
star=ClothingModel:getStarLv(v.itemguid)
end
local fight=fightFunc(v)
local fightIdx=fightIdxLookup[fight]
return fightIdx*1000+i+itemid_idx+star*10000
end
end


for i,v in ipairs(itemList)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end


if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
table.sort(itemList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
else
table.sort(itemList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end
end
sortConfig[#sortConfig+1]=config


local config={}
config.type=ITEM_SORT_TYPE.eColor
config.name='品质'
config.sortTag=function(a,sortCompareType)
return bagSortConfig.getCompareColorTag(a,sortCompareType)
end
sortConfig[#sortConfig+1]=config

function bagSortConfig.getCompareColorTag(a,sortCompareType)
local itemid=a.itemid
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color or 0
local stage=cfg.stage or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return color*100-(stage*1+itemid*0.00001)
end
return color*100+(stage*1+itemid*0.00001)
end

function bagSortConfig.getCompareStageTag(a,sortCompareType)
local itemid=a.itemid
local cfg=itemsConfig.getConfig(itemid)
local stage=cfg.stage or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return stage*1000-itemid*0.00001
end
return stage*1000+itemid*0.00001
end


function bagSortConfig.getCompareJingjieTag(a,sortCompareType)
local itemid=a.itemid
local jingJieLv=fabaoHelper.getDressJingjielv(itemid,a.itemguid)
local floor=cfgHelper.get2(cfg_disciplejingjieconfig_get,jingJieLv,'floor')or 0
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color or 0
local stage=cfg.stage or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return floor*1000-(color*100+stage*1+itemid*0.00001)
end
return floor*1000+(color*100+stage*1+itemid*0.00001)
end


function bagSortConfig.getCompareElementTag(a,sortCompareType)
local itemid=a.itemid
local cfg=itemsConfig.getConfig(itemid)
local element=cfg.element or 100
local color=cfg.color or 0
local stage=cfg.stage or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return(100-element)*1000-(color*100+stage*1+itemid*0.00001)
end
return(100-element)*1000+(color*100+stage*1+itemid*0.00001)
end

function bagSortConfig.getCompareFightTag(a,sortCompareType)
local itemid=a.itemid
local itemguid=a.itemguid
local cfg=itemsConfig.getConfig(itemid)
local isEquip=itemsConfig.isEquip(itemid)
local color=cfg.color or 0
local stage=cfg.stage or 0
local fight=isEquip and equipsHelper.getEquipFightX(itemid,itemguid)or fabaoHelper.getBaseFight(itemid,itemguid)or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return fight*1000-(color*100+stage*1+itemid*0.00001)
end
return fight*1000+(color*100+stage*1+itemid*0.00001)
end

function bagSortConfig.getCompareEquipColorTag(a,sortCompareType)
local itemid=a.itemid
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color or 0
local type1=cfg.type1 or 0
local stage=cfg.stage or 0
local xm=cfg.type3 and 1 or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return 1000000-xm*100000-color*10000-stage*1000-type1*100+(itemid*0.00001)
end
return 1000000+xm*100000+color*10000+stage*100+type1*10+(itemid*0.00001)
end

function bagSortConfig.getCompareEquipStageTag(a,sortCompareType)
local itemid=a.itemid
local cfg=itemsConfig.getConfig(itemid)
local stage=cfg.stage or 0
local type1=cfg.type1 or 0
local xm=cfg.type3 and 1 or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return 1000000-xm*100000-stage*1000-type1*10-itemid*0.00001
end
return 1000000+xm*100000+stage*1000+type1*10+itemid*0.00001
end

function bagSortConfig.getCompareEquipFightTag(a,sortCompareType)
local itemid=a.itemid
local itemguid=a.itemguid
local cfg=itemsConfig.getConfig(itemid)
local isEquip=itemsConfig.isEquip(itemid)
local fight=isEquip and equipsHelper.getEquipFightX(itemid,itemguid)or fabaoHelper.getBaseFight(itemid,itemguid)or 0
local type1=cfg.type1 or 0
local color=cfg.color or 0
local stage=cfg.stage or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return fight*10000+type1*1000-(color*100+stage*1+itemid*0.00001)
end
return fight*10000-type1*1000+(color*100+stage*1+itemid*0.00001)
end

function bagSortConfig.getCompareEquipXianMoTag(a,sortCompareType)
local itemid=a.itemid
local cfg=itemsConfig.getConfig(itemid)
local type3=cfg.type3 or 0
local color=cfg.color or 0
local stage=cfg.stage or 0
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return type3*10000-(color*100+stage*1+itemid*0.00001)
end
return type3*10000+(color*100+stage*1+itemid*0.00001)
end


function bagSortConfig.getAllSortConfig()
return _sortConfig
end

function bagSortConfig.getSortConfig(showBagType)
return _sortConfig[showBagType]
end