local _filterTable={}

function daobingHelper.getStarPrecent(itemid,starlv)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local star=itemConfig.star
local attr=star[starlv]
local starAttrLookup=attrListHelper.tramsformToLookup(attr[2])
return attr[3]or 0
end


function daobingHelper.getStarBaseAttrs(itemid,level)
local itemConfig=itemsConfig.getConfig(itemid)
local star=itemConfig.star
return star[level][2]
end


function daobingHelper.getStarAddPercentBaseAttrs(itemid,starlv,jllv)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local star=itemConfig.star
local attr=star[starlv]
local starAttrLookup=attrListHelper.tramsformToLookup(attr[2])
local percent=attr[3]or 0
local jlBaseAttrs=daobingHelper.getJinglianBaseAttrs(itemid,jllv)
local jlAttrLookup=attrListHelper.tramsformToLookup(jlBaseAttrs)
local baseLookup=attrListHelper.concatLookup(baseAttrsLookup,starAttrLookup)
baseLookup=attrListHelper.concatLookup(baseLookup,jlAttrLookup)
local addBaseAttrsLookup=attrListHelper.getAddLookupOnPercent(baseLookup,percent,true)
return addBaseAttrsLookup
end


function daobingHelper.getStarAddBaseAttrs(itemid,starlv,jllv)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local star=itemConfig.star
local attr=star[starlv]
local percent=attr[3]or 0

local starAttrLookup=attrListHelper.tramsformToLookup(attr[2])
local jlBaseAttrs=daobingHelper.getJinglianBaseAttrs(itemid,jllv)
local jlAttrLookup=attrListHelper.tramsformToLookup(jlBaseAttrs)

local baseLookup=attrListHelper.concatLookup(baseAttrsLookup,starAttrLookup)
baseLookup=attrListHelper.concatLookup(baseLookup,jlAttrLookup)
local addBaseAttrsLookup=attrListHelper.getAddLookupOnPercent(baseLookup,percent,true)

local lookup=attrListHelper.concatLookup(addBaseAttrsLookup,starAttrLookup)
return lookup
end








function daobingHelper.isCanStar(itemguid,checkBenTi)
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return false end
local itemData=equip.itemData
local itemid=equip.itemid
local lv=equip.itemData and equip.itemData.star or 0
local maxlv=daobingConfig.getStarMaxLv(itemid)
if lv>=maxlv then return false end
local itemCfg=itemsConfig.getConfig(itemid)

if checkBenTi then

local bentinum=daobingConfig.getCostBenTiNum(lv)
table.clear(_filterTable)
_filterTable[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}
_filterTable[ITEM_FILTER_TYPE.eItemid]=itemid
_filterTable[ITEM_FILTER_TYPE.eJinglianLv]=0
_filterTable[ITEM_FILTER_TYPE.eStarLv]=0
local len=bagControl.getBagItemsCnt(BAG_TYPE.eDaoBingBag,_filterTable)
if len<bentinum then return false end
end

local star=daobingHelper.getStarAttrs(itemCfg)
local starTable=star[lv]
if starTable==nil then return false end
local cost=starTable[1]
if cost==nil then return true end
for i,v in ipairs(cost)do
local needid=v[1]
local neednum=v[2]
local has=itemsModel.getCount(needid)
if neednum>has then
return false,v
end
end
return true
end











