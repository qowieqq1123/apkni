













function ClothingHelper.getEquipAttrsLookupByItemguid(itemguid,isEquiped,addCollectAttr)
local equip
if isEquiped then
local switchIdx=ClothingModel:getEquipSwitchIdx(itemguid)or 0
if switchIdx==0 then

equip=ClothingModel:getEquip(itemguid)
end
else
equip=equipsHelper.getEquip(itemguid)
end
if equip==nil then return end
local itemid=equip.itemid
local starlv=equip.itemData.star or 0
local baseAttrs,diziAttrs=ClothingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv)

if addCollectAttr then
local collectStar=ClothingModel:getClothingCollectStarLvById(itemid)
local collectAttrs=ClothingHelper.getCollectAttrLookup(itemid,collectStar)
baseAttrs=attrListHelper.concatLookup(baseAttrs,collectAttrs)
end
return baseAttrs,diziAttrs
end


function ClothingHelper.getEquipAttrsListByItemid(itemid,starlv,addCollectAttr)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrList=ClothingHelper.getBaseAttrsList(itemConfig)
local baseDiziAttrList=ClothingHelper.getDiziAttrsList(itemConfig)
local lookUp={}
local baseAttrs,diziAttrs=ClothingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv)

if addCollectAttr then
local collectStar=ClothingModel:getClothingCollectStarLvById(itemid)
local collectAttrs=ClothingHelper.getCollectAttrLookup(itemid,collectStar)
lookUp=attrListHelper.concatLookup(baseAttrs,collectAttrs)
end

return attrListHelper.transformToList(lookUp,baseAttrList),attrListHelper.transformToList(diziAttrs,baseDiziAttrList)
end

function ClothingHelper.getEquipFightX(itemguid)
local attrlist=ClothingHelper.getEquipAttrsLookupByItemguid(itemguid,nil,true)or{}
local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('装备属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
return math.floor(fight)
end

function ClothingHelper.getEquipFight(itemid)
local attrlist=ClothingHelper.getEquipBaseAttrsLookupByItemid(itemid,0)or{}
local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('装备属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
return math.floor(fight)
end



function ClothingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv)
local baseAttr,diziAttr=ClothingHelper.getStarBaseAttrs(itemid,starlv)
return attrListHelper.tramsformToLookup(baseAttr),attrListHelper.tramsformToLookup(diziAttr)
end

function ClothingHelper.getEquipBaseAttrsListByItemguid(itemguid,itemid,isEquiped)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrList=ClothingHelper.getBaseAttrsList(itemConfig)
local baseDiziAttrList=ClothingHelper.getDiziAttrsList(itemConfig)
local attrsLookup,diziAttrs=ClothingHelper.getEquipAttrsLookupByItemguid(itemguid,isEquiped)
return attrListHelper.transformToList(attrsLookup,baseAttrList),attrListHelper.transformToList(diziAttrs,baseDiziAttrList)
end










function ClothingHelper.getAttr(attrId,attrValue,toIntType,bitNum)
if bitNum==nil then bitNum=2 end
local attrConfig=equipsConfig.getAttributesconfig(attrId)
local name=attrConfig.attrname
local flag=attrConfig.flag
local valStr=attrValue
if flag==3 then
valStr=FMT.fmt('{0}%',mathHelper.decimal(attrValue*100,bitNum))
elseif flag==2 then
valStr=FMT.fmt('{0}%',mathHelper.decimal(attrValue/100,bitNum))
else
if toIntType==nil then toIntType=TO_INT_TYPE.eDown end
if toIntType==TO_INT_TYPE.eDown then
attrValue=math.floor(attrValue)
elseif toIntType==TO_INT_TYPE.eUp then
attrValue=math.ceil(attrValue)
end
valStr=attrValue
end
return name,valStr,flag~=1,flag
end


function ClothingHelper.getStarAttrs(itemConfig)
return itemConfig.star
end


function ClothingHelper.getBaseAttrsList(itemConfig)
return itemConfig.star[0][2]
end


function ClothingHelper.getDiziAttrsList(itemConfig)
return itemConfig.star[0][3]
end


function ClothingHelper.getStarBaseAttrs(itemid,starlv,excludeBase)
local itemConfig=itemsConfig.getConfig(itemid)
local star=itemConfig.star
local list={}
local diziList={}


list=attrListHelper.concatList(list,star[starlv][2])

diziList=attrListHelper.concatList(diziList,star[starlv][3])








return list,diziList
end


function ClothingHelper.getStarBaseAttrsByEquip(equip,excludeBase)
if equip==nil or equip.itemData==nil then return end
local star=equip.itemData.star or 0
return ClothingHelper.getStarBaseAttrs(equip.itemid,star,excludeBase)
end


function ClothingHelper.getCollectAttrLookup(itemid,starlv)
return attrListHelper.tramsformToLookup(ClothingHelper.getCollectAttrs(itemid,starlv))
end

function ClothingHelper.getCollectAttrs(itemid,starlv,excludeBase)
local list={}
if starlv then
local itemConfig=itemsConfig.getConfig(itemid)
local type2=itemConfig.type2
local attr=cfgHelper.get(cfg_discipledresstypeconfig_get,type2,"attr")
local star=attr

list=attrListHelper.concatList(list,star[starlv])







end
return list
end

function ClothingHelper.getCollectAttrLookupByType2(type2,starlv)
return attrListHelper.tramsformToLookup(ClothingHelper.getCollectAttrsByType2(type2,starlv))
end
function ClothingHelper.getCollectAttrsByType2(type2,starlv)
local list={}
if starlv then
local attr=cfgHelper.get(cfg_discipledresstypeconfig_get,type2,"attr")
local star=attr
list=star[starlv]
end
return list
end

function ClothingHelper.getCollectDiziAttrLookupByType2(type2)
return attrListHelper.tramsformToLookup(ClothingHelper.getCollectDiziAttrsByType2(type2))
end

function ClothingHelper.getCollectDiziAttrsByType2(type2)
local attr=cfgHelper.get(cfg_discipledresstypeconfig_get,type2,"attrex")
if attr then
return attr[0]
end
return{}
end


function ClothingHelper.printAttrListChange(oldAttrs,newAttrs,title)





















end

function ClothingHelper.printAttrChange(attrType,val,newval,title)

















end



