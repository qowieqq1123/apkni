












function daobingHelper.getEquipFight(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local attrlist=daobingHelper.getBaseAttrLookup(itemCfg)
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


function daobingHelper.getEquipFightByLv(itemid,starlv,jllv)
local attrlist=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,jllv)
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



function daobingHelper.getEquipFightX(itemid,itemguid)
local attrlist=daobingHelper.getEquipBaseAttrsLookupByItemguid(itemguid,itemid)or{}
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


function daobingHelper.getBaseFight(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttr=daobingHelper.getBaseAttrLookup(itemConfig)
local fight=0
for k,v in pairs(baseAttr)do
local config=cfg_attributesconfig_get(k)
fight=fight+config.unitVal*v
end
return math.floor(fight)
end








function daobingHelper.getEquipAttrsLookupByItemguid(itemguid,isEquiped)
local equip
if isEquiped then
local switchIdx=daobingModel:getEquipSwitchIdx(itemguid)or 0
if switchIdx==0 then

equip=daobingModel:getEquip(itemguid)
end
else
equip=equipsHelper.getEquip(itemguid)
end
if equip==nil then return end
local itemid=equip.itemid
local jllv=equip.itemData.jinglianlv or 0
local starlv=equip.itemData.star or 0
return daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,jllv)
end



function daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,jllv)

local jlPrecent=daobingHelper.getJinglianPrecent(itemid,jllv)
local starPrecent=daobingHelper.getStarPrecent(itemid,starlv)
local precent=jlPrecent+starPrecent

local itemConfig=itemsConfig.getConfig(itemid)

local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local t_baseAttrsLookup=attrListHelper.getLookupOnPercent(baseAttrsLookup,precent)


local jlAttrsList=daobingHelper.getJinglianBaseAttrs(itemid,jllv)
local jlAttrsLookup=attrListHelper.tramsformToLookup(jlAttrsList)
local t_jlAttrsLookup=attrListHelper.getLookupOnPercent(jlAttrsLookup,precent)


local starAttrsList=daobingHelper.getStarBaseAttrs(itemid,starlv)
local starAttrsLookup=attrListHelper.tramsformToLookup(starAttrsList)
local t_starAttrsLookup=attrListHelper.getLookupOnPercent(starAttrsLookup,precent)

local temp=attrListHelper.concatLookup(t_baseAttrsLookup,t_jlAttrsLookup)
temp=attrListHelper.concatLookup(temp,t_starAttrsLookup)

local wltAttr=wanLingTaModel:getWanLingTaDaoBingSpeAttrsLookup()
for attrKey,attrVal in pairs(temp)do
local totalPercent=wltAttr[attrKey]or 0
temp[attrKey]=math.floor(attrVal*(1+totalPercent/100))
end
return temp
end

function daobingHelper.getEquipBaseAttrsLookupByItemguid(itemguid,itemid)
local equip=equipsHelper.getEquip(itemguid)
if equip then
return daobingHelper.getEquipAttrsLookupByItemguid(itemguid)
end
local itemConfig=itemsConfig.getConfig(itemid)
return daobingHelper.getBaseAttrLookup(itemConfig)
end








function daobingHelper.getAttr(attrId,attrValue,toIntType,bitNum)
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


function daobingHelper.getBaseAttrLookup(itemConfig)
local baseAttr=attrListHelper.tramsformToLookup(daobingHelper.getBaseAttrsList(itemConfig))
return baseAttr
end


function daobingHelper.getJlAttrs(itemConfig)
return itemConfig.jinglian
end


function daobingHelper.getStarAttrs(itemConfig)
return itemConfig.star
end


function daobingHelper.getBaseAttrsList(itemConfig)
return itemConfig.static
end


function daobingHelper.getJinglianBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local jinglianlv=equip.itemData.jinglianlv or 0
return daobingHelper.getJinglianBaseAttrs(equip.itemid,jinglianlv)
end


function daobingHelper.getJinglianAddPercentBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local jllv=equip.itemData.jinglianlv or 0
local starlv=equip.itemData.star or 0
return daobingHelper.getJinglianAddPercentBaseAttrs(equip.itemid,starlv,jllv)
end


function daobingHelper.getJinglianAddBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local jllv=equip.itemData.jinglianlv or 0
local starlv=equip.itemData.star or 0
return daobingHelper.getJinglianAddBaseAttrs(equip.itemid,starlv,jllv)
end


function daobingHelper.getStarBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local star=equip.itemData.star or 0
return daobingHelper.getStarBaseAttrs(equip.itemid,star)
end


function daobingHelper.getStarAddPercentBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local starlv=equip.itemData.star or 0
local jllv=equip.itemData.jinglianlv or 0
return daobingHelper.getStarAddPercentBaseAttrs(equip.itemid,starlv,jllv)
end


function daobingHelper.getStarAddBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local starlv=equip.itemData.star or 0
local jllv=equip.itemData.jinglianlv or 0
return daobingHelper.getStarAddBaseAttrs(equip.itemid,starlv,jllv)
end

function daobingHelper.printAttrListChange(oldAttrs,newAttrs,title)





















end

function daobingHelper.printAttrChange(attrType,val,newval,title)

















end



