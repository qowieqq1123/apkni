




function vocEquipHelper.getVocEquipBaseAttrsListByItemguid(itemguid,itemid)
local equip=itemguid and equipsHelper.getEquip(itemguid)or nil
local strengthenlv=equip and equip.itemData and equip.itemData.enhancelv or 0
local attrs=vocEquipHelper.getVocEquipBaseAttrsListByItemidAndLevel(itemid,strengthenlv)
return attrs
end

function vocEquipHelper.getVocEquipBaseAttrsListByItemidAndLevel(itemid,level)
local itemConfig=itemsConfig.getConfig(itemid)
local attrs={}
local vocId=itemConfig.type1
local cfg=cfgHelper.get2(cfg_disciplevocequipenhanceconfig_get,vocId,level)
local addLookup={}
if cfg and cfg.base then
local normalBaseAttr=cfg and cfg.base or{}
for _,v in ipairs(normalBaseAttr)do
local attrId=v[1]
local attrValue=v[2]
if addLookup[attrId]then
addLookup[attrId]=addLookup[attrId]+attrValue
else
addLookup[attrId]=attrValue
end
end
end
local baseAttr=itemConfig.base
for _,v in ipairs(baseAttr)do
local attrId=v[1]
local attrBaseValue=v[2]
local addValue=addLookup[attrId]or 0
local attrFinalValue=attrBaseValue+addValue

attrs[#attrs+1]={
attrId=attrId,
attrValue=attrFinalValue,
}
end


if cfg.jingjie then
local addRate=cfg.jingjie
if addRate~=0 then
local attrValue=addRate
local attrId=-1
attrs[#attrs+1]={
attrId=attrId,
attrName="境界属性",
attrValue=attrValue,
isPercent=true,
}
end
end








return attrs
end

function vocEquipHelper.getVocEquipBaseAttrsLookupByItemidAndLevel(itemid,level)
local itemConfig=itemsConfig.getConfig(itemid)
local attrs_lookup={}
local vocId=itemConfig.type1
local cfg=cfgHelper.get2(cfg_disciplevocequipenhanceconfig_get,vocId,level)
if cfg and cfg.base then
local normalBaseAttr=cfg and cfg.base or{}
for _,v in ipairs(normalBaseAttr)do
local attrId=v[1]
local attrValue=v[2]
if attrs_lookup[attrId]then
attrs_lookup[attrId].attrValue=attrs_lookup[attrId].attrValue+attrValue
else
attrs_lookup[attrId]={
attrId=attrId,
attrValue=attrValue,
}
end
end
end

local baseAttr=itemConfig.base
for _,v in ipairs(baseAttr)do
local attrId=v[1]
local attrBaseValue=v[2]

if attrs_lookup[attrId]then
attrs_lookup[attrId].attrValue=attrs_lookup[attrId].attrValue+attrBaseValue
else
attrs_lookup[attrId]={
attrId=attrId,
attrValue=attrBaseValue,
}
end
end


if cfg.jingjie then
local addRate=cfg.jingjie
if addRate~=0 then
local attrValue=addRate
local attrId=-1
attrs_lookup[attrId]={
attrId=attrId,
attrName="境界属性",
attrValue=attrValue,
isPercent=true,
}
end
end

return attrs_lookup
end


function vocEquipHelper.getVocEquipAllVocAttrsByVocId(vocId,itemid)
local attrs={}
local itemConfig=itemsConfig.getConfig(itemid)
local cfgList=cfgHelper.get(cfg_disciplevocequipenhanceconfig_get,vocId)
if cfgList then
local lastCfg
local lastNormalAttrLookup
for level,lvCfg in ipairs(cfgList)do
local clientAttrId=0























if lvCfg.extraAttrShow then
local extraAttrList=lvCfg.extraAttrShow
for _,v in ipairs(extraAttrList)do
clientAttrId=clientAttrId-1
local attrId=clientAttrId
local attrName=v[1]
local attrValueStr=v[2]
local skillPosIndex=v[3]
attrs[#attrs+1]={
level=level,
attrId=attrId,
attrName=attrName,
attrValueStr=attrValueStr,
skillPosIndex=skillPosIndex,
}
end
end
lastCfg=lvCfg
end
end

return attrs
end


function vocEquipHelper.getVocEquipAllAttrsLookupByItemguid(itemguid,isEquiped)
local attrs={}
local equip
if isEquiped then
local switchIdx=vocEquipModel:getEquipSwitchIdx(itemguid)or 0
if switchIdx==0 then

equip=itemguid and vocEquipModel:getEquip(itemguid)or nil
end
else
equip=itemguid and equipsHelper.getEquip(itemguid)or nil
end

if not equip then
return nil
end

if equip.totalAttrs__ and not equip.totalAttrs__.dirty then
return equip.totalAttrs__.attrLookup,false
end

local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)


local baseAttr=itemConfig.base
for _,v in ipairs(baseAttr)do
local attrId=v[1]
local attrBaseValue=v[2]
if attrs[attrId]then
attrs[attrId]=attrs[attrId]+attrBaseValue
else
attrs[attrId]=attrBaseValue
end
end


local vocId=itemConfig.type1
local strengthenlv=equip and equip.itemData and equip.itemData.enhancelv or 0
local cfg=cfgHelper.get2(cfg_disciplevocequipenhanceconfig_get,vocId,strengthenlv)



















local normalBaseAttr=cfg and cfg.base or{}
for _,v in ipairs(normalBaseAttr)do
local attrId=v[1]
local attrValue=v[2]
if attrs[attrId]then
attrs[attrId]=attrs[attrId]+attrValue
else
attrs[attrId]=attrValue
end
end


local normalVocAttr=cfg and cfg.attr or{}
for _,v in ipairs(normalVocAttr)do
local attrId=v[1]
local attrValue=v[2]
if attrs[attrId]then
attrs[attrId]=attrs[attrId]+attrValue
else
attrs[attrId]=attrValue
end
end


local gongMingLv,gongMingGbList
if equip then
gongMingLv,gongMingGbList=vocEquipModel:getVocEquipGongMingLv(itemid)
end

if not gongMingLv then
gongMingLv=0
else
for _,gbId in ipairs(gongMingGbList)do
vocEquipModel:setGongMingGbLookupWithVocEquipItemGuid(gbId,itemguid)
end
end

local gongMingAttr=gongMingLv>0 and vocEquipHelper.getVocEquipGongMingActiveAttrsByLevel(itemid,gongMingLv)or{}
for _,v in ipairs(gongMingAttr)do
local attrId=v[1]
local attrValue=v[2]
if attrs[attrId]then
attrs[attrId]=attrs[attrId]+attrValue
else
attrs[attrId]=attrValue
end
end

equip.totalAttrs__=equip.totalAttrs__ or{}
local totalAttrs__=equip.totalAttrs__
totalAttrs__.dirty=false
totalAttrs__.attrLookup=attrs

return attrs
end


function vocEquipHelper.getVocEquipAllAttrsLookupByItemId(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local attrs={}


local baseAttr=itemConfig.base
for _,v in ipairs(baseAttr)do
local attrId=v[1]
local attrBaseValue=v[2]
if attrs[attrId]then
attrs[attrId]=attrs[attrId]+attrBaseValue
else
attrs[attrId]=attrBaseValue
end
end
return attrs
end

function vocEquipHelper.getEquipFightX(itemid,itemguid)
local attrlist=vocEquipHelper.getVocEquipAllAttrsLookupByItemguid(itemguid,itemid)or vocEquipHelper.getVocEquipAllAttrsLookupByItemId(itemid)
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


function vocEquipHelper.setEquipAttrsDirty(equip,dirty)
if equip==nil then return end
local totalAttrs__=equip.totalAttrs__
if not dirty and totalAttrs__==nil then
return
else
equip.totalAttrs__=equip.totalAttrs__ or{}
equip.totalAttrs__.dirty=dirty
end
end

function vocEquipHelper.getVocEquipGongMingAllAttrsList(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local attrsList=itemConfig.gongming
return attrsList
end

function vocEquipHelper.getVocEquipGongMingActiveAttrsByLevel(itemid,level)
local allAttrsList=vocEquipHelper.getVocEquipGongMingAllAttrsList(itemid)
local attrs=allAttrsList[level]
return attrs
end

