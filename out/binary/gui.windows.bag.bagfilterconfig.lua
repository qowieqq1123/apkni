bagFilterConfig={}


local _filterConfig={}


_filterConfig[SHOW_BAG_TYPE.eItemBag]={}
local itemBagFilterCfg=_filterConfig[SHOW_BAG_TYPE.eItemBag]

local bagFilterItemEeffectCfg={}
bagFilterItemEeffectCfg.type=BAG_FILTER_TYPE.eItemEffectType

itemBagFilterCfg[#itemBagFilterCfg+1]=bagFilterItemEeffectCfg

local itemFilterList={
BAG_SUB_FILTER_TYPE.eJingjieItem,BAG_SUB_FILTER_TYPE.eLiantiItem,BAG_SUB_FILTER_TYPE.eFuluItem,
BAG_SUB_FILTER_TYPE.eZhuanyeItem,BAG_SUB_FILTER_TYPE.eGongfaItem,BAG_SUB_FILTER_TYPE.eOtherItem,
}
local itemFilterLookup={}
for i,v in ipairs(itemFilterList)do
itemFilterLookup[v]=true
end

local bagFilterItemType1Cfg={}
bagFilterItemType1Cfg.type=BAG_FILTER_TYPE.eItemType1Type

itemBagFilterCfg[#itemBagFilterCfg+1]=bagFilterItemType1Cfg


local bagFilterQuickItemType1Cfg={}
bagFilterQuickItemType1Cfg.type=nil

itemBagFilterCfg[#itemBagFilterCfg+1]=bagFilterQuickItemType1Cfg


_filterConfig[SHOW_BAG_TYPE.eMaterialsBag]={}
local materialsBagFilterCfg=_filterConfig[SHOW_BAG_TYPE.eMaterialsBag]


local materialsBagFilterElementCfg={}
materialsBagFilterElementCfg.type=BAG_FILTER_TYPE.eElement


local materialsBagFilterStageCfg={}
materialsBagFilterStageCfg.type=BAG_FILTER_TYPE.eStage


local materialsBagFilterLianzhiCfg={}
materialsBagFilterLianzhiCfg.type=BAG_FILTER_TYPE.eMaterialsType


local materialsBagFilterQuickElementCfg={}
materialsBagFilterQuickElementCfg.type=nil

materialsBagFilterCfg[#materialsBagFilterCfg+1]=materialsBagFilterElementCfg
materialsBagFilterCfg[#materialsBagFilterCfg+1]=materialsBagFilterStageCfg
materialsBagFilterCfg[#materialsBagFilterCfg+1]=materialsBagFilterLianzhiCfg
materialsBagFilterCfg[#materialsBagFilterCfg+1]=materialsBagFilterQuickElementCfg

local materialsFilterList={
BAG_SUB_FILTER_TYPE.eJingcuiMaterials,BAG_SUB_FILTER_TYPE.eLianzhiMaterials
}
local materialsFilterLookup={}
for i,v in ipairs(materialsFilterList)do
materialsFilterLookup[v]=true
end


_filterConfig[SHOW_BAG_TYPE.eEquipBag]={}
local equipBagFilterCfg=_filterConfig[SHOW_BAG_TYPE.eEquipBag]


local equipBagFilterPosCfg={}
equipBagFilterPosCfg.type=BAG_FILTER_TYPE.eEquipPosType


local equipBagFilterStageCfg={}
equipBagFilterStageCfg.type=BAG_FILTER_TYPE.eStage


local equipBagFilterSuitCfg={}
equipBagFilterSuitCfg.type=BAG_FILTER_TYPE.eEquipSuit


local equipBagFilterRandomAttrCfg={}
equipBagFilterRandomAttrCfg.type=BAG_FILTER_TYPE.eEquipRandomAttr


local equipBagFilterQuickPosCfg={}
equipBagFilterQuickPosCfg.type=nil

equipBagFilterCfg[#equipBagFilterCfg+1]=equipBagFilterPosCfg
equipBagFilterCfg[#equipBagFilterCfg+1]=equipBagFilterStageCfg
equipBagFilterCfg[#equipBagFilterCfg+1]=equipBagFilterSuitCfg
equipBagFilterCfg[#equipBagFilterCfg+1]=equipBagFilterRandomAttrCfg
equipBagFilterCfg[#equipBagFilterCfg+1]=equipBagFilterQuickPosCfg


_filterConfig[SHOW_BAG_TYPE.eFabaoBag]={}
local fabaoBagFilterCfg=_filterConfig[SHOW_BAG_TYPE.eFabaoBag]

local fabaoBagFilterCreateCfg={}
fabaoBagFilterCreateCfg.type=BAG_FILTER_TYPE.eFabaoCreateType

local fabaoBagFilterElementCfg={}
fabaoBagFilterElementCfg.type=BAG_FILTER_TYPE.eElement

local fabaoBagFilterDressJingjieCfg={}
fabaoBagFilterDressJingjieCfg.type=BAG_FILTER_TYPE.eFabaoDressJingjie


local fabaoBagFilterQuickElementCfg={}
fabaoBagFilterQuickElementCfg.type=nil

fabaoBagFilterCfg[#fabaoBagFilterCfg+1]=fabaoBagFilterCreateCfg
fabaoBagFilterCfg[#fabaoBagFilterCfg+1]=fabaoBagFilterElementCfg
fabaoBagFilterCfg[#fabaoBagFilterCfg+1]=fabaoBagFilterDressJingjieCfg
fabaoBagFilterCfg[#fabaoBagFilterCfg+1]=fabaoBagFilterQuickElementCfg


_filterConfig[SHOW_BAG_TYPE.eFubaoBag]={}
local fubaoBagFilterCfg=_filterConfig[SHOW_BAG_TYPE.eFubaoBag]

local fubaoBagFilterEffectCfg={}
fubaoBagFilterEffectCfg.type=BAG_FILTER_TYPE.eFubaoEffectType

local fubaoBagFilterStageCfg={}
fubaoBagFilterStageCfg.type=BAG_FILTER_TYPE.eStage

local fubaoBagFilterColorCfg={}
fubaoBagFilterColorCfg.type=BAG_FILTER_TYPE.eColor

local fubaoBagFilterRandomAttrCfg={}
fubaoBagFilterRandomAttrCfg.type=BAG_FILTER_TYPE.eFuBaoEffectRandomAttr


local fubaoBagFilterQuickEffectCfg={}
fubaoBagFilterQuickEffectCfg.type=nil

fubaoBagFilterCfg[#fubaoBagFilterCfg+1]=fubaoBagFilterEffectCfg
fubaoBagFilterCfg[#fubaoBagFilterCfg+1]=fubaoBagFilterStageCfg
fubaoBagFilterCfg[#fubaoBagFilterCfg+1]=fubaoBagFilterColorCfg
fubaoBagFilterCfg[#fubaoBagFilterCfg+1]=fubaoBagFilterRandomAttrCfg
fubaoBagFilterCfg[#fubaoBagFilterCfg+1]=fubaoBagFilterQuickEffectCfg


_filterConfig[SHOW_BAG_TYPE.eRareBag]={}
local rareBagFilterCfg=_filterConfig[SHOW_BAG_TYPE.eRareBag]

local rareBagFilterCreateCfg={}
rareBagFilterCreateCfg.type=BAG_FILTER_TYPE.eBagType


local rareBagFilterQuickCreateCfg={}
rareBagFilterQuickCreateCfg.type=nil

rareBagFilterCfg[#rareBagFilterCfg+1]=rareBagFilterCreateCfg
rareBagFilterCfg[#rareBagFilterCfg+1]=rareBagFilterQuickCreateCfg


for i,bagType in ipairs(BAG_TYPE_IN_SHOW_BAG_TYPE[SHOW_BAG_TYPE.eRareBag])do
local cfg={}
cfg.name=function()
return BAG_TYPE_NAME[bagType]
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eBagType]={[ITEM_FILTER_COMPARE.eEquals]={bagType}}}
end

rareBagFilterCreateCfg[#rareBagFilterCreateCfg+1]=cfg
rareBagFilterQuickCreateCfg[#rareBagFilterQuickCreateCfg+1]=cfg
end


for i,v in ipairs(cfg_bagfiltersubxconfig())do
local subType=v.id
local cfg={}
cfg.name=function()
return bagFilterConfig.getSubCommonFilterName(subType)
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eItemConfigAttr]={[ITEM_FILTER_COMPARE.eEquals]=
{{'bagFilterType',subType}}}}
end
if itemFilterLookup[subType]then
bagFilterItemEeffectCfg[#bagFilterItemEeffectCfg+1]=cfg
elseif materialsFilterLookup[subType]then
materialsBagFilterLianzhiCfg[#materialsBagFilterLianzhiCfg+1]=cfg
end
end

local otherdroplist={"nil"}

for _,v in pairs(cfg_itemtype1config())do
local bagfilter=v.bagfilter
if bagfilter==nil or bagfilter==1 then
local type1=v.id
local name=v.name


local droplist={}
if type1==itemtype1Type.eFaBaoYP then
for k,v in pairs(FABAO_YUANPEI_MAT_TYPE)do
droplist[#droplist+1]=v
end
else
droplist[#droplist+1]=type1
end

local cfg={}
local sort=v.bagfiltersort or 0
cfg.sortTag=sort*10000+type1
cfg.name=function()
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eEquals]=
droplist}}
end
bagFilterItemType1Cfg[#bagFilterItemType1Cfg+1]=cfg
end

if v.bagfilterquicklysort then
local type1=v.id


local droplist={}
if type1==itemtype1Type.eFaBaoYP then
for k,v in pairs(FABAO_YUANPEI_MAT_TYPE)do
droplist[#droplist+1]=v
end
else
droplist[#droplist+1]=type1
end

local name=v.bagfilterquicklyname
local cfg={}
local sort=v.bagfilterquicklysort or 0
cfg.sortTag=sort*10000+type1
cfg.name=function()
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eEquals]=droplist}}
end
bagFilterQuickItemType1Cfg[#bagFilterQuickItemType1Cfg+1]=cfg
else
otherdroplist[#otherdroplist+1]=v.id
end
end

table.sort(bagFilterItemType1Cfg,function(a,b)
return a.sortTag>b.sortTag
end)

bagFilterItemType1Cfg[#bagFilterItemType1Cfg+1]=
{
name=function()
return'其他'
end,
filter=function()
return{[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eEquals]={'nil'}}}
end,
}

table.sort(bagFilterQuickItemType1Cfg,function(a,b)
return a.sortTag>b.sortTag
end)

bagFilterQuickItemType1Cfg[#bagFilterQuickItemType1Cfg+1]=
{
name=function()
return'其他'
end,
filter=function()
return{[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eEquals]=otherdroplist}}
end,
}



local list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
for _,element in ipairs(list)do
local cfg={}
cfg.name=function()
return cfg_elementtypeconfig_get(element).name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eElement]={[ITEM_FILTER_COMPARE.eEquals]={element},
[ITEM_FILTER_COMPARE.eNotNull]={'element'}}}
end
materialsBagFilterElementCfg[#materialsBagFilterElementCfg+1]=cfg
materialsBagFilterQuickElementCfg[#materialsBagFilterQuickElementCfg+1]=cfg
fabaoBagFilterElementCfg[#fabaoBagFilterElementCfg+1]=cfg
fabaoBagFilterQuickElementCfg[#fabaoBagFilterQuickElementCfg+1]=cfg
end
list=nil




for i=1,EQUIP_STAGE_MAX do
local stage=i
local cfg={}
cfg.name=function()
return FMT.fmt('{0}品',stage)
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eEquals]={stage}}}
end
materialsBagFilterStageCfg[#materialsBagFilterStageCfg+1]=cfg
end



for i=EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot do
local pos=i
local cfg={}
cfg.name=function()
local name=cfg_discipleequiptypeconfig_get(pos).name
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eEquipType1]={[ITEM_FILTER_COMPARE.eEquals]={pos}}}
end
equipBagFilterPosCfg[#equipBagFilterPosCfg+1]=cfg
equipBagFilterQuickPosCfg[#equipBagFilterQuickPosCfg+1]=cfg
end



for i=1,EQUIP_STAGE_MAX do
local stage=i
local cfg={}
cfg.name=function()
local name=FMT.fmt('{0}阶',stage)
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eEquals]={stage}}}
end
equipBagFilterStageCfg[#equipBagFilterStageCfg+1]=cfg
end



local list=cfg_discipleequipsuitconfig()
for _,v in ipairs(list)do
local suitid=v.id
local cfg={}
local name=v.name
cfg.name=function()
return name
end
cfg.icon=function()
return equipsHelper.getEquipSuitIconById(suitid)
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eSuitEquip]={[ITEM_FILTER_COMPARE.eEquals]={suitid}}}
end
equipBagFilterSuitCfg[#equipBagFilterSuitCfg+1]=cfg
end
list=nil


local _renameType=
{
[eAttributeType.eATK_PCT]='攻击率',
[eAttributeType.eDEF_PCT]='防御率',
[eAttributeType.eHP_PCT]='生命率',
}
local attrs=equipsConfig.getEquipConstConfig().rangeattrs
for i,attrid in ipairs(attrs)do
local cfg={}
cfg.name=function()
if _renameType[attrid]then return _renameType[attrid]end
return helper.getAttributeName(attrid)
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eEquipRandomAttr]={[ITEM_FILTER_COMPARE.eEquals]={attrid}}}
end
equipBagFilterRandomAttrCfg[#equipBagFilterRandomAttrCfg+1]=cfg
end



local _fabaoCreateType={
eXianTian=1,
eHouTian=2,
eBenMing=3,
}
local _fabaoName=
{
[_fabaoCreateType.eXianTian]='先天法宝',
[_fabaoCreateType.eHouTian]='后天法宝',
[_fabaoCreateType.eBenMing]='本命法宝',
}
for _,v in pairs(_fabaoCreateType)do
local filterType=v
local cfg={}
local name=_fabaoName[v]
cfg.name=function()
return name
end
cfg.filter=function()
local func=function(itemid,itemguid)
local type1=itemsConfig.getConfig(itemid).type1
if type1==FABAO_TYPE.eXiantian then
return filterType==_fabaoCreateType.eXianTian
elseif type1==FABAO_TYPE.eHoutian or type1==FABAO_TYPE.eRandom then
return filterType==_fabaoCreateType.eHouTian
elseif type1==FABAO_TYPE.eBenMing then
return filterType==_fabaoCreateType.eBenMing
end
return false
end
return{[ITEM_FILTER_TYPE.eFunc]={[ITEM_FILTER_COMPARE.eEquals]={{func,true}}}}
end
fabaoBagFilterCreateCfg[#fabaoBagFilterCreateCfg+1]=cfg
end


local jingjieCfgList=fabaoConfig.getDressJingjieConfig()
for stage,jingjieLv in pairs(jingjieCfgList)do

local jingjieCfg=cfg_disciplejingjieconfig_get(jingjieLv)
local jingjieName=UIDiscipleModel:getJJNameX(jingjieLv)
local cfg={}
local name=FMT.fmt('{0}及以上',jingjieName)
cfg.name=function()
return name
end
cfg.filter=function()
local func=function(itemid,itemguid)
return fabaoHelper.getDressJingjielv(itemid,itemguid)
end
return{[ITEM_FILTER_TYPE.eFunc]={[ITEM_FILTER_COMPARE.eGreaterEquals]={{func,jingjieLv}}}}
end
fabaoBagFilterDressJingjieCfg[#fabaoBagFilterDressJingjieCfg+1]=cfg
end


local cfgs=cfg_lookupfubaoequipconfig()
local list={}
local lookup={}
for type1,v in pairs(cfgs)do
for type2,vv in pairs(v)do
if lookup[type2]==nil then
list[#list+1]={type2,vv[1]}
else
break
end
end
end
table.sort(list,function(a,b)
return a[1]<b[1]
end)
for _,v in ipairs(list)do
local id=v[2]
local itemCfg=itemsConfig.getConfig(id)
local name=itemCfg.name
name=string.replace(name,'符宝','')
local type2=itemCfg.type2
local cfg={}
cfg.name=function()
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eItemType2]={[ITEM_FILTER_COMPARE.eEquals]={type2}},[ITEM_FILTER_TYPE.eItemType]={[ITEM_FILTER_COMPARE.eEquals]={ITEM_MAIN_TYPE.eFubao}}}
end

fubaoBagFilterEffectCfg[#fubaoBagFilterEffectCfg+1]=cfg


local quickCfg={}
name=string.replace(name,'玉符','')
quickCfg.name=function()
return name
end
quickCfg.filter=function()
return{[ITEM_FILTER_TYPE.eItemType2]={[ITEM_FILTER_COMPARE.eEquals]={type2}},[ITEM_FILTER_TYPE.eItemType]={[ITEM_FILTER_COMPARE.eEquals]={ITEM_MAIN_TYPE.eFubao}}}
end
fubaoBagFilterQuickEffectCfg[#fubaoBagFilterQuickEffectCfg+1]=cfg
end
list=nil
lookup=nil


for i=1,2 do
local stage=i
local cfg={}
cfg.name=function()
local name=FMT.fmt('{0}阶',stage)
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eEquals]={stage}}}
end
fubaoBagFilterStageCfg[#fubaoBagFilterStageCfg+1]=cfg
end

for i=1,5 do
local color=i
local cfg={}
cfg.name=function()
local name=eQualityColorName[color]
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eColor]={[ITEM_FILTER_COMPARE.eEquals]={color}}}
end
fubaoBagFilterColorCfg[#fubaoBagFilterColorCfg+1]=cfg
end

local attrs2=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"rangeattrs")
for i,subFilterAttrData in ipairs(attrs2)do
local attrType=subFilterAttrData[1]
local attrIds=subFilterAttrData[2]
for k,attrId in ipairs(attrIds)do
local cfg={}
cfg.name=function()
local name=''
if attrType==FUBAO_EFFECT_TYPE.eSixAttr then
name=FMT.fmt("{0}",UIDiscipleModel:discipleBaseAttrName(attrId))
elseif attrType==FUBAO_EFFECT_TYPE.eProfessionExp then
local _cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,attrId)
name=FMT.fmt('{0}经验',_cfg.name)
elseif attrType==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
name=FMT.fmt("{0}经验",ELEMENT_TYPE.getNameGF(attrId))
end
return name
end
cfg.filter=function()
return{[ITEM_FILTER_TYPE.eFubaoRandomAttr]={[ITEM_FILTER_COMPARE.eEquals]={{attrType,attrId}}}}
end
fubaoBagFilterRandomAttrCfg[#fubaoBagFilterRandomAttrCfg+1]=cfg
end
end



function bagFilterConfig.getFilter(showBagType)
return _filterConfig[showBagType]
end

function bagFilterConfig.getCommonFilterConfig(filterType)
return cfg_bagfilterconfig_get(filterType)
end

function bagFilterConfig.getSubFilterConfig(subType)
return cfg_bagfiltersubxconfig_get(subType)
end

function bagFilterConfig.getCommonFilterName(filterType)
return bagFilterConfig.getCommonFilterConfig(filterType).name
end

function bagFilterConfig.getSubCommonFilterName(subType)
return bagFilterConfig.getSubFilterConfig(subType).name
end