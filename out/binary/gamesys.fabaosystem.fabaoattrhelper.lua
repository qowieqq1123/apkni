












function fabaoHelper.getFabaoFight(itemguid)
local attrlist=fabaoHelper.getFabaoAttrsLookupByItemguid(itemguid)or{}
local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('法宝属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
return math.floor(fight)
end


function fabaoHelper.getBaseFight(itemid,itemguid)
local baseAttrLookup
local isBenMingFabao=fabaoConfig.isBenMingFabao(itemid)
local item
if itemguid then
item=fabaoHelper.getFabao(itemguid)
baseAttrLookup=fabaoHelper.getBaseAttrsLookup(item)

local jlAttrList=fabaoHelper.getAddJilianAttrs(item)
local jlAttrLookup=attrListHelper.tramsformToLookup(jlAttrList)
local jlAttrPercent=fabaoHelper.getJlAddAttrsPercent(item)
jlAttrLookup=attrListHelper.getLookupOnPercent(jlAttrLookup,jlAttrPercent,true)
local addlxBasePrecent=isBenMingFabao and benMingFaBaoHelper.getAddBaseAttrPrecent(itemguid)or 0
local czPrecentLookup=fabaoCizuiHelper.getAddFabaoBaseAttrsPercentLookup(item)or{}

local jlPercentLookup=fabaoHelper.getJlBaseAttrsPercent(item)
for attrType,attrValue in pairs(baseAttrLookup)do
local jl=jlPercentLookup[attrType]or 0
local cz=czPrecentLookup[attrType]or 0
local lx=addlxBasePrecent or 0
local val=mathHelper.floor(attrValue*(1+(lx+jl+cz)/100))
baseAttrLookup[attrType]=val
end

baseAttrLookup=attrListHelper.concatLookup(baseAttrLookup,jlAttrLookup)
else
local cfg=itemsConfig.getConfig(itemid)
local static=fabaoHelper.getBaseAttrsListByCfg(cfg)
baseAttrLookup=attrListHelper.tramsformToLookup(static)
end
local extraLookup={}
local addPrecent=0
if isBenMingFabao and item then
local extraList=benMingFaBaoHelper.getLingXingBaseAttrs(item)
extraLookup=attrListHelper.tramsformToLookup(extraList)
addPrecent=benMingFaBaoHelper.getAddLxAttrPrecent(itemguid)
end
local fight=0
for k,v in pairs(baseAttrLookup)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('法宝属性类型{0}没有找到',k)
return 0
end
local extra=extraLookup[k]or 0
fight=fight+config.unitVal*(v+extra*(1+addPrecent/100))
end
return math.floor(fight)
end

function fabaoHelper.getBaseFightByItem(item)
if not item.itemData or not item.itemData.staticList then
return
end

local attrlist=fabaoHelper.getBaseAttrsLookup(item)
local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('法宝属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
return math.floor(fight)
end








function fabaoHelper.getFabaoAttrsLookupByItemguid(itemguid,isEquiped)
local item
if isEquiped==true then
local switchidx=fabaoModel.getFabaoSwitchIdx(itemguid)or 0
if switchidx==0 then
item=fabaoModel.getFabao(itemguid)
end
else
item=fabaoHelper.getFabao(itemguid)
end
if item==nil then return end

local baseAttrLookup=fabaoHelper.getBaseAttrsLookup(item)


local elementAttrLookup=fabaoHelper.getElementAttrsLookup(item)


local jlAttrList=fabaoHelper.getAddJilianAttrs(item)
local jlAttrLookup=attrListHelper.tramsformToLookup(jlAttrList)

local jlAttrPercent=fabaoHelper.getJlAddAttrsPercent(item)
jlAttrLookup=attrListHelper.getLookupOnPercent(jlAttrLookup,jlAttrPercent,true)


local tpAttrLookup=fabaoHelper.getTuPoAttrLookup(item)



local lianhuaAttrLookup=fabaoHelper.getLianhuaAttrsLookup(item)


local lxAttrLookup=fabaoHelper.getLingXingAttrsLookup(item)



local jlPercentLookup=fabaoHelper.getJlBaseAttrsPercent(item)


local lxPrecent=benMingFaBaoHelper.getAddBaseAttrPrecent(itemguid)


local czPrecentLookup=fabaoCizuiHelper.getAddFabaoBaseAttrsPercentLookup(item)

for attrType,attrValue in pairs(baseAttrLookup)do
local jl=jlPercentLookup[attrType]or 0
local cz=czPrecentLookup[attrType]or 0
local lx=lxPrecent or 0
local val=mathHelper.floor(attrValue*(1+(jl+cz+lx)/100))
baseAttrLookup[attrType]=val
end

local temp=attrListHelper.concatLookup(baseAttrLookup,elementAttrLookup)
temp=attrListHelper.concatLookup(temp,jlAttrLookup)
temp=attrListHelper.concatLookup(temp,lianhuaAttrLookup)
temp=attrListHelper.concatLookup(temp,lxAttrLookup)
temp=attrListHelper.concatLookup(temp,tpAttrLookup)

return temp
end


function fabaoHelper.getFabaoBaseAttrsList(item)
if item==nil then return end
local baseAttr=fabaoHelper.getBaseAttrsList(item)
local baseAttrLookup=fabaoHelper.getBaseAttrsLookup(item)
local elementAttrsLookup=fabaoHelper.getElementAttrsLookup(item)

local temp=attrListHelper.concatLookup(baseAttrLookup,elementAttrsLookup)
return attrListHelper.transformToList(temp,baseAttr)
end

function fabaoHelper.getFabaoTotalBaseAttrsList(item)
if item==nil then return end
local baseAttr=fabaoHelper.getBaseAttrsList(item)
return baseAttr
end

function fabaoHelper.tramsformElement(item,list)
local element=fabaoHelper.getMainElement(item)
local attrid=cfg_elementtypeconfig_get(element).attrid
table.sort(list,function(a,b)
local t1=a[1]or 0
local t2=b[1]or 0
local aElementConfig=fabaoConfig.getElementTypeByAttrid(t1)
local bElementConfig=fabaoConfig.getElementTypeByAttrid(t2)
local flaga=t1
local flagb=t2
if aElementConfig==nil then
flaga=flaga-10000
end
if bElementConfig==nil then
flagb=flagb-10000
end
if t1==attrid then
flaga=flaga-100
end
if t2==attrid then
flagb=flagb-100
end
return flaga<flagb
end)
return list
end

function fabaoHelper.changeMainElement(item,attrVal)
local element=fabaoHelper.getMainElement(item)
local attrid=fabaoConfig.getElementConfig(element).attrid
if item.itemData==nil then return end
local itemData=item.itemData
if itemData.elementList==nil then itemData.elementList={}end
local elementList=itemData.elementList
for i,v in ipairs(elementList)do
if v.param_1==attrid then
v.param_2=attrVal
return
end
end
itemData.elementlistlen=itemData.elementlistlen+1
elementList[#elementList+1]={param_1=attrid,param_2=attrVal}
end


function fabaoHelper.getRandomBaseAttr(itemConfig)
return itemConfig.clientrand
end

function fabaoHelper.getBaseAttrsList(item)
fabaoHelper.handleItem(item)
local attrList=item.itemData and item.itemData.staticList
return attrListHelper.transformFromNamedList(attrList)
end


function fabaoHelper.getBaseAttrsListByCfg(itemCfg)
local mainid=itemCfg.mainid
local mainItemCfg=itemsConfig.getConfig(mainid)
return mainItemCfg.static[mainItemCfg.color]
end


function fabaoHelper.getElementAttrsListByCfg(itemCfg)
return itemCfg.element
end


function fabaoHelper.getElementAttrsList(item)
local attrList=item.itemData and item.itemData.elementList
return attrListHelper.transformFromNamedList(attrList)
end


function fabaoHelper.getLianhuaAttrsListByCfg(itemCfg)
return itemCfg.lianhua
end


function fabaoHelper.getLianhuaAttrsList(item)
local attrList=fabaoHelper.getLianHuaList(item)
return attrListHelper.transformFromNamedList(attrList)
end


function fabaoHelper.getInitLianhuaAttrsList(item)
local attrList=fabaoHelper.getInitLianHuaList(item)
return attrListHelper.transformFromNamedList(attrList)
end


function fabaoHelper.getBaseAttrsLookup(item)
local baseAttr=attrListHelper.tramsformToLookup(fabaoHelper.getBaseAttrsList(item))
return baseAttr
end


function fabaoHelper.getElementAttrsLookup(item)
local baseAttr=attrListHelper.tramsformToLookup(fabaoHelper.getElementAttrsList(item))
return baseAttr
end


function fabaoHelper.getLianhuaAttrsLookup(item)
local baseAttr=attrListHelper.tramsformToLookup(fabaoHelper.getLianhuaAttrsList(item))
return baseAttr
end


function fabaoHelper.getLingXingAttrsLookup(item)
local baseAttr=attrListHelper.tramsformToLookup(benMingFaBaoHelper.getLingXingAttrsList(item))
return baseAttr
end



function fabaoHelper.getElementRangeByConfig(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local element=itemConfig.element
if element==nil then
loggerUtil.logErrFMT('没有配置element:{0}',itemid)
end
local elementtypeconfig=cfg_elementtypeconfig_get(element)
local attrid=elementtypeconfig.attrid
local power=itemConfig.power
if power==nil then return end
local min=power[1][1]
local max=power[#power][2]
return attrid,{min,max}
end



function fabaoHelper.getAllElementAttrsRange(itemidlist)
local stage=fabaoHelper.computeStage(itemidlist)
local extra=fabaoConfig.getCommonConfig().extra[stage]
local minExtraVal=extra[1]
local maxExtraVal=extra[#extra]
local attrslist=fabaoHelper.getElementAttrList(itemidlist)
local list={}
for _,attrid in ipairs(attrslist)do
local min,max=fabaoHelper.getSingleElementAttrRange(attrid,minExtraVal,maxExtraVal,itemidlist)
list[#list+1]={attrid,{min,max}}
end
return list
end


function fabaoHelper.getSingleElementAttrRange(attrid,minExtraVal,maxExtraVal,itemidlist)
local itemid=itemidlist[1]
local mainAttrid=fabaoHelper.getElementRangeByConfig(itemid)
local min=0
local max=0
if mainAttrid==attrid then
min=min+minExtraVal
max=max+maxExtraVal
end
for i,v in ipairs(itemidlist)do
local subAttrid,subRange=fabaoHelper.getElementRangeByConfig(v)
if subAttrid==attrid then
min=min+subRange[1]
max=max+subRange[2]
end
end
return min,max
end

function fabaoHelper.getElementAttrList(itemidlist)
local temp={}
local list={}
for i,v in ipairs(itemidlist or{})do
local attrid,effect1=fabaoHelper.getElementRangeByConfig(v)
if attrid and temp[attrid]==nil then
temp[attrid]=true
list[#list+1]=attrid
end
end
return list
end

function fabaoHelper.getBaseAttrsRange(mainid)
local itemConfig=itemsConfig.getConfig(mainid)
local static=itemConfig.static
if static==nil then return{}end
local temp={}
local min
local max
for i,v in pairs(static)do
if min==nil or min>i then min=i end
if max==nil or max<i then max=i end
end
local minAttrs=static[min]
local maxAttrs=static[max]
for i,v in ipairs(minAttrs)do
temp[#temp+1]={v[1],{v[2],maxAttrs[i][2]}}
end
return temp
end