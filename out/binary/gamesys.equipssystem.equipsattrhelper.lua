












function equipsHelper.getEquipFight(itemguid)
local attrlist,isRefresh=equipsHelper.getEquipAttrsLookupByItemguid(itemguid)or{}

local equip
if not isRefresh then
equip=equipsHelper.getEquip(itemguid)
if equip.totalFight__ then return equip.totalFight__ end
end
local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('装备属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
fight=math.floor(fight)
if equip then
equip.totalFight__=fight
end
return fight
end


function equipsHelper.getEquipFightX(itemid,itemguid)
local attrlist,isRefresh=equipsHelper.getEquipBaseAttrsLookupByItemguid(itemguid,itemid)

local equip
if not isRefresh then
equip=equipsHelper.getEquip(itemguid)
if equip and equip.totalFightX__ then return equip.totalFight__ end
end

local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('装备属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
fight=math.floor(fight)
if equip then
equip.totalFight__=fight
end
return fight
end

function equipsHelper.getFixEquipFight(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local baseAttrList=equipsHelper.getBaseAttrsList(itemCfg)
local randattrList=itemCfg.fix[0].randattr
local baseAttrLookup=attrListHelper.tramsformToLookup(baseAttrList)
local randattrLookup=attrListHelper.tramsformToLookup(randattrList)
local attrlook=attrListHelper.concatLookup(baseAttrLookup,randattrLookup)
local fight=0
for k,v in pairs(attrlook)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('装备属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
return math.floor(fight)
end


function equipsHelper.getBaseFight(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttr=equipsHelper.getBaseAttrLookup(itemConfig)
local fight=0
for k,v in pairs(baseAttr)do
local config=cfg_attributesconfig_get(k)
fight=fight+config.unitVal*v
end
return math.floor(fight)
end

function equipsHelper.getAllSuitAttr(diziguid)
local suit=equipsModel.getAllEquipSuit(diziguid)
local list={}
for _,v in ipairs(suit)do
local list1=equipsHelper.getSingleSuitAttr(v[1],v[2])
list=attrListHelper.concatList(list,list1)
end
return list
end

function equipsHelper.hasSuitAttr(diziguid)
return#equipsHelper.getAllSuitAttr(diziguid)>0
end

function equipsHelper.getSingleSuitAttr(suitid,num)
local suitConfig=equipsConfig.getSuitConfig(suitid)
if num>=3 then
return suitConfig.attr3
elseif num>=2 then
return suitConfig.attr2
end
return{}
end








function equipsHelper.getEquipAttrsLookupByItemguid(itemguid,isEquiped)
local equip
if isEquiped==true then
local switchIdx=equipsModel.getEquipSwitchIdx(itemguid)or 0
if switchIdx==0 then

equip=equipsModel.getEquip(itemguid)
end
else
equip=equipsHelper.getEquip(itemguid)
end
if equip==nil then return end

if equip.totalAttrs__ and not equip.totalAttrs__.dirty then
return equip.totalAttrs__.attrLookup,false
end

local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)

local baseAttrsLookup=equipsHelper.getTotalBaseAttrLookup(equip)

local jlBaseAttrsLookup=equipsHelper.getJinglianAddBaseAttrsByEquip(equip)

local extraAttrsLookup=equipsHelper.getTotalExtraAttrsLookup(equip)

local randomAttrsLookup=equipsHelper.getTotalRandomAttrLookup(equip)

local xmchuanchenAttrsLookup=equipsHelper.getXMChuanChengAttrLookup(equip)

local temp=attrListHelper.concatLookup(baseAttrsLookup,jlBaseAttrsLookup)
temp=attrListHelper.concatLookup(temp,extraAttrsLookup)
temp=attrListHelper.concatLookup(temp,xmchuanchenAttrsLookup)
local attrLookup=attrListHelper.concatLookup(temp,randomAttrsLookup)

equip.totalAttrs__=equip.totalAttrs__ or{}
local totalAttrs__=equip.totalAttrs__
totalAttrs__.dirty=false
totalAttrs__.attrLookup=attrLookup

return attrLookup,true
end


function equipsHelper.setEquipAttrsDirty(equip,dirty)
if equip==nil then return end
local totalAttrs__=equip.totalAttrs__
if not dirty and totalAttrs__==nil and baseAttrs__==nil then
return
else
equip.totalAttrs__=equip.totalAttrs__ or{}
equip.totalAttrs__.dirty=dirty

equip.baseAttrs__=equip.baseAttrs__ or{}
equip.baseAttrs__.dirty=dirty
end
end



function equipsHelper.getEquipBaseAttrsListByItemguid(itemguid,itemid)

local equip=itemguid and equipsHelper.getEquip(itemguid)or nil

if equip and equip.baseAttrs__ and not equip.baseAttrs__.dirty then
return equip.baseAttrs__.attrList,equip.baseAttrs__.attrLookup,false
end

local itemCfg=itemsConfig.getConfig(itemid)

local baseAttrList=equipsHelper.getBaseAttrsList(itemCfg)

local baseAttrsLookup=equip and equipsHelper.getTotalBaseAttrLookup(equip)or
equipsHelper.getBaseAttrLookup(itemCfg)

local jlBaseAttrsLookup=equip and equipsHelper.getJinglianAddBaseAttrsByEquip(equip)or{}

local tempLookup=attrListHelper.concatLookup(baseAttrsLookup,jlBaseAttrsLookup)

local attrList=attrListHelper.transformToList(tempLookup,baseAttrList)

local attrLookup=attrListHelper.tramsformToLookup(attrList)
if equip then
equip.baseAttrs__=equip.baseAttrs__ or{}
local baseAttrs__=equip.baseAttrs__
baseAttrs__.dirty=false
baseAttrs__.attrList=attrList
baseAttrs__.attrLookup=attrLookup
end

return attrList,attrLookup,true
end

function equipsHelper.getEquipBaseAttrsLookupByItemguid(itemguid,itemid)
local attrList,attrLookup,isRefresh=equipsHelper.getEquipBaseAttrsListByItemguid(itemguid,itemid)
return attrLookup,isRefresh
end









function equipsHelper.getAttr(attrId,attrValue,toIntType,bitNum)
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


function equipsHelper.getBaseAttrLookup(itemConfig)
local baseAttr=attrListHelper.tramsformToLookup(equipsHelper.getBaseAttrsList(itemConfig))
return baseAttr
end

function equipsHelper.getTotalBaseAttrLookup(equip)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local baseAttrLookup=equipsHelper.getBaseAttrLookup(itemCfg)
local precent=0


local dzguid=equipsModel.getDiziguidByItemguid(equip.itemguid)
if dzguid and systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)then
precent=LingZhenChongZhuModel:getskilljihuoArr(dzguid)
end


if systemModel.isOpen(SYSTEM_DEFINE.eXianMoEquip)then
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip>0 then
local ninglianStar=equipsModel.getNingLianStar(equip)
local rate=equipsModel.getEquipXMNingLianZY(itemid,ninglianStar)
precent=precent+(rate/100)
end
end


if precent>0 and baseAttrLookup then
for i,v in pairs(baseAttrLookup)do
if v then
local val=v*precent
baseAttrLookup[i]=v+val
end
end
end

local dhcnt=equipsModel:getDianHuaCnt(equip)
if dhcnt>0 then
local reveal_attr=itemCfg.reveal_attr[dhcnt]
local add_baseAttr=reveal_attr and reveal_attr[1]or nil
local add_baseAttrLookup=add_baseAttr and attrListHelper.tramsformToLookup(add_baseAttr)or nil
if add_baseAttrLookup then
baseAttrLookup=attrListHelper.concatLookup(baseAttrLookup,add_baseAttrLookup)
end
end
return baseAttrLookup
end


function equipsHelper.getBaseAttrsList(itemConfig)
return itemConfig.static
end


function equipsHelper.getExtraAttrsList(itemConfig)
return itemConfig.extra
end


function equipsHelper.getTotalExtraAttrsList(equip)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local extralist=equipsHelper.getExtraAttrsList(itemCfg)

local dzguid=equipsModel.getDiziguidByItemguid(equip.itemguid)
if dzguid and systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)then
local precent=LingZhenChongZhuModel:getskilljihuoArr(dzguid)
if extralist then
local temp={}
for i,v in ipairs(extralist)do
if v and v[1]and v[2]then
local val=v[2]*precent
temp[i]={v[1],v[2]+val}
end
end
extralist=temp
end
end

local dhcnt=equipsModel:getDianHuaCnt(equip)
if dhcnt<=0 then
return extralist
end
local extraLookup=attrListHelper.tramsformToLookup(extralist)
local reveal_attr=itemCfg.reveal_attr[dhcnt]
local add_extarAttr=reveal_attr and reveal_attr[2]or nil
local add_baseAttrLookup=add_extarAttr and attrListHelper.tramsformToLookup(add_extarAttr)or nil
if add_baseAttrLookup then
extraLookup=attrListHelper.concatLookup(extraLookup,add_baseAttrLookup)
end
return attrListHelper.transformToList(extraLookup,extralist)
end


function equipsHelper.getTotalExtraAttrsLookup(equip)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local extraLookup=attrListHelper.tramsformToLookup(equipsHelper.getExtraAttrsList(itemCfg))

local dzguid=equipsModel.getDiziguidByItemguid(equip.itemguid)
if dzguid and systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)then
local precent=LingZhenChongZhuModel:getskilljihuoArr(dzguid)
if extraLookup then
for i,v in pairs(extraLookup)do
if v then
local val=v*precent
extraLookup[i]=v+val
end
end
end
end
local dhcnt=equipsModel:getDianHuaCnt(equip)
if dhcnt>0 then
local reveal_attr=itemCfg.reveal_attr[dhcnt]
local add_extarAttr=reveal_attr and reveal_attr[2]or nil
local add_baseAttrLookup=add_extarAttr and attrListHelper.tramsformToLookup(add_extarAttr)or nil
if add_baseAttrLookup then
extraLookup=attrListHelper.concatLookup(extraLookup,add_baseAttrLookup)
end
end
return extraLookup
end



function equipsHelper.getDiziAttr(attrId,attrValue,toIntType,bitNum)
if bitNum==nil then bitNum=2 end
local attrConfig=equipsConfig.getDiziAttrConfig(attrId)
local name=attrConfig.name
local flag=attrConfig.flag or 1
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


function equipsHelper.getJinglianAddBaseAttrsByEquip(equip)
if equip==nil or equip.itemData==nil then return end
local jinglianlv=equip.itemData.jinglianlv or 0
return equipsHelper.getJinglianAddBaseAttrs(equip.itemid,jinglianlv)
end


function equipsHelper.getRandomAttrList(equip)
local attr=equip.itemData and equip.itemData.randattrList or{}
return attrListHelper.transformFromNamedList(attr)
end


function equipsHelper.getRandomAttrLookup(equip)
local list=equipsHelper.getRandomAttrList(equip)
return attrListHelper.tramsformToLookup(list)
end

function equipsHelper.getTotalRandomAttrList(equip)
local attrlist=equipsHelper.getRandomAttrList(equip)
local dhcnt=equipsModel:getDianHuaCnt(equip)
if dhcnt>0 then
local itemCfg=itemsConfig.getConfig(equip.itemid)
local reveal_attr=itemCfg.reveal_attr[dhcnt]
local add_rangeAttr=reveal_attr and reveal_attr[3]or{}
for _,attr in ipairs(attrlist)do
local attrType=attr[1]
local attrValue=attr[2]
local cnt=attr[3]or 0
local addTable=add_rangeAttr[attrType]
local add=addTable and(addTable[1]+addTable[2]*cnt)or 0
attr[2]=attrValue+add
end
end
return attrlist
end

function equipsHelper.getTotalRandomAttrLookup(equip)
local attrlist=equipsHelper.getTotalRandomAttrList(equip)
return attrListHelper.tramsformToLookup(attrlist)
end


function equipsHelper.getXMChuanChengAttrLookup(equip)
local attrlist={}
local itemid=equip.itemid
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip>0 then
local cclist=equipsModel.getChuangChenIdList(itemid)
local ninglian_star=equipsModel.getNingLianStar(equip)
for k,effid in ipairs(cclist)do
if ninglian_star>=effid[2]then
local cfg=cfg_discipleequipxmccconfig_get(effid[1])
if cfg.attr then
attrlist=attrListHelper.concatList(attrlist,cfg.attr)
elseif cfg.skill then

for k,v in ipairs(cfg.skill)do
local skillid=v[1]
local skill_lvl=v[2]or 1
local skill_cfg=cfgHelper.get(cfg_skillconfig_get,skillid)
if skill_cfg and skill_cfg.attr and skill_cfg.attr[skill_lvl]then
attrlist=attrListHelper.concatList(attrlist,skill_cfg.attr[skill_lvl])
end
end
end
end
end
end
return attrListHelper.tramsformToLookup(attrlist)
end


function equipsHelper.printAttrListChange(oldAttrs,newAttrs,title)





















end

function equipsHelper.printAttrChange(attrType,val,newval,title)

















end
