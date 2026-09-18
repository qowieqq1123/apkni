fabaoPreviewModel={}


function fabaoPreviewModel:init()
self.equipsLookup={}
end

function fabaoPreviewModel:getGUID()
return itemsModel.getGUID()
end

function fabaoPreviewModel:isPreview(itemguid)
local handle=tostring(itemguid)
return self.equipsLookup[handle]~=nil
end

function fabaoPreviewModel:addFabao(equip)
local handle=tostring(equip.itemguid)
self.equipsLookup[handle]=equip
end

function fabaoPreviewModel:getFabao(itemguid)
local handle=tostring(itemguid)
return self.equipsLookup[handle]
end


function fabaoPreviewModel:create(dzguid,ypitemguid,fbitemguids)
local ypItem=bagModel.getItem(ypitemguid)
local ypitemid=ypItem.itemid
local ypitemCfg=itemsConfig.getConfig(ypitemid)


local mainfbitemguid=fbitemguids[1]
local itemid=self:findFaBaoItemId(mainfbitemguid,ypitemguid)
local mainFabao=fabaoHelper.getFabao(mainfbitemguid)
local mainFaBaoItemData=mainFabao.itemData
local mainFaBaoItemid=mainFabao.itemid
local mainid=fabaoHelper.getReallyMainId(mainFabao)
local mainItemCfg=itemsConfig.getConfig(mainid)
local mainfbtype=mainItemCfg.type2
local attrs1=mainItemCfg.static[ypitemCfg.color]
local attrs2=benMingFaBaoHelper.getStaticAttrs(itemid,ypitemid,false)
local attrs=attrListHelper.concatList(attrs1,attrs2)
local attrs=attrListHelper.transformToNamedList(attrs)

local rawlist=fabaoPreviewModel:getRawlist(fbitemguids)
local itemguid=fabaoPreviewModel:getGUID()

local czList=fabaoHelper.getCiZhuiList(mainFabao)
local czlistlen=#(czList or{})
local lianhuaList=fabaoHelper.getLianHuaList(mainFabao)
local lianhualen=#(lianhuaList or{})

local itemStruct={}
itemStruct.itemguid=itemguid
itemStruct.itemid=itemid
itemStruct.itemcount=1
itemStruct.itemflag=0
itemStruct.itemtime=0
itemStruct.itemData={}
local itemData=itemStruct.itemData
itemData.itemtype=ITEM_MAIN_TYPE.eFabaoYuanPei
itemData.jilianlv=mainFaBaoItemData.jilianlv
itemData.jilianexp=mainFaBaoItemData.jilianexp
itemData.lianhuanum=mainFaBaoItemData.lianhuanum
itemData.lianhuatimes=mainFaBaoItemData.lianhuatimes
itemData.lianhualen=lianhualen
itemData.lianhuaList=lianhuaList
itemData.mainid=ypitemid
itemData.czlistlen=czlistlen
itemData.czList=czList
itemData.staticlistlen=#attrs
itemData.staticList=attrs
itemData.elementlistlen=mainFaBaoItemData.elementlistlen
itemData.elementList=mainFaBaoItemData.elementList
itemData.name=benMingFaBaoHelper.getDefaultName(ypItem.itemid,mainfbtype)
itemData.discipleguid=dzguid
itemData.rawlistlen=#rawlist
itemData.rawList=rawlist
itemData.mainidx=1
itemData.yunyang=1
itemData.lingxinglv=fabaoPreviewModel:getLxLv(ypitemCfg,fbitemguids)
itemData.lingxingexp=int64.zero
if mainFaBaoItemData.lianhuanum==0 then
itemData.initlianhualen=lianhualen
itemData.initlianhuaList=lianhuaList
end
fabaoPreviewModel:addFabao(itemStruct)
return itemguid
end


function fabaoPreviewModel:create_normalFabao(mainItemId,itemList)

local itemConfig=itemsConfig.getConfig(mainItemId)
local itemid=mainItemId
local itemguid=fabaoPreviewModel:getGUID()
local stage=fabaoHelper.computeStage(itemList)
local baseRangeAttrs=itemid and fabaoHelper.getBaseAttrsRange(itemid,stage)
local elementRangeAttrs=fabaoHelper.getAllElementAttrsRange(itemList)
local baseLianhuaRangeLookupAttrs=fabaoHelper.getAddLianhuaAttrsListByLianzhi(itemList)
local elementList={}
for i,v in ipairs(elementRangeAttrs)do
elementList[i]={
param_1=v[1],
param_2=v[2][1],
}
end
local staticList={}
for i,v in ipairs(baseRangeAttrs)do
staticList[i]={
param_1=v[1],
param_2=v[2][1],
}
end

local itemStruct={}
itemStruct.itemguid=itemguid
itemStruct.itemid=itemid
itemStruct.itemcount=1
itemStruct.itemflag=0
itemStruct.itemtime=0
itemStruct.itemData={}
local itemData=itemStruct.itemData
itemData.itemtype=ITEM_MAIN_TYPE.eFabao
itemData.jilianlv=0
itemData.jilianexp=0
itemData.lianhuanum=0
itemData.lianhuatimes=0
itemData.lianhualen=0
itemData.lianhuaList=nil
itemData.mainid=mainItemId
itemData.czlistlen=0
itemData.czList=nil
itemData.staticlistlen=#staticList
itemData.staticList=staticList
itemData.elementlistlen=#elementList
itemData.elementList=elementList

itemData.rawlistlen=0
itemData.rawList=nil
itemData.mainidx=1
itemData.yunyang=1
itemData.lingxinglv=0
itemData.lingxingexp=int64.zero
itemData.baseRangeAttrs=baseRangeAttrs
itemData.elementRangeAttrs=elementRangeAttrs
itemData.baseLianhuaRangeLookupAttrs=baseLianhuaRangeLookupAttrs

itemData.name=itemConfig.name
fabaoPreviewModel:addFabao(itemStruct)
fabaoHelper.handleItem(itemStruct)
return itemguid
end

function fabaoPreviewModel:findFaBaoItemId(itemguid,ypitemguid)
local fabao=fabaoHelper.getFabao(itemguid)
local ypItem=bagModel.getItem(ypitemguid)
local fbitemid=fabao.itemid
local fbitemCfg=itemsConfig.getConfig(fbitemid)
local ypitemid=ypItem.itemid
local ypitemCfg=itemsConfig.getConfig(ypitemid)
local fbcolor=ypitemCfg.color
local fbstage=fbitemCfg.stage
local type1=FABAO_TYPE.eBenMing
local itemids=cfg_lookupfabaoconfig_get(fbcolor)[fbstage][type1]
return itemids[1]
end

function fabaoPreviewModel:findFaBaoItemIdEx(fbitemid,ypitemid)
local fbitemCfg=itemsConfig.getConfig(fbitemid)
local ypitemCfg=itemsConfig.getConfig(ypitemid)
local fbcolor=ypitemCfg.color
local fbstage=fbitemCfg.stage
local type1=FABAO_TYPE.eBenMing
local itemids=cfg_lookupfabaoconfig_get(fbcolor)[fbstage][type1]
return itemids[1]
end


function fabaoPreviewModel:getLxLv(ypitemCfg,fbitemguids)
local lv=0
local color=ypitemCfg.color
local itemguid1,itemguid2,itemguid3=unpack(fbitemguids)
local equip1=fabaoHelper.getFabao(itemguid1)
local itemsCfg1=itemsConfig.getConfig(equip1.itemid)
local stage1=itemsCfg1.stage
local color1=itemsCfg1.color

local add=(color1-color)*3
lv=lv+math.max(add,0)

local guids={itemguid2,itemguid3}
for _,itemguid in ipairs(guids)do
local equip=fabaoHelper.getFabao(itemguid)
local itemsCfg=itemsConfig.getConfig(equip.itemid)
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)
local lhnum=fabaoModel.getFabaoLianhuanum(itemguid)

local add=(itemsCfg.color-color)*3
lv=lv+math.max(add,0)


lv=lv+math.floor(jllv/5)





local add=(itemsCfg.stage-stage1)*5
lv=lv+math.max(add,0)
end
lv=math.min(lv,9)
return lv
end

function fabaoPreviewModel:getRawlist(fbitemguids)
local temp={}
for i,itemguid in ipairs(fbitemguids)do
local equip=fabaoHelper.getFabao(itemguid)
local itemsCfg=itemsConfig.getConfig(equip.itemid)
local mainid=fabaoHelper.getReallyMainId(equip)or 0
temp[#temp+1]={itemsCfg.color,mainid}
end
return attrListHelper.transformToNamedList(temp)
end


function fabaoPreviewModel:create_refine(bmfbGuid,materialGuids)

local bmfbItem=itemsModel.getItem(bmfbGuid)
local bmfbMainId=bmfbItem.itemData.mainid
local ypitemCfg=itemsConfig.getConfig(bmfbMainId)

local mainMaterialGuid=materialGuids[1]
local mainMaterialItem=itemsModel.getItem(mainMaterialGuid)
local mainMaterialItemData=mainMaterialItem.itemData
local mainid=fabaoHelper.getReallyMainId(mainMaterialItem)
local mainItemCfg=itemsConfig.getConfig(mainid)
local mainfbtype=mainItemCfg.type2
local itemid=self:findFaBaoItemIdEx(mainMaterialItem.itemid,bmfbMainId)
local attrs1=mainItemCfg.static[ypitemCfg.color]
local attrs2=benMingFaBaoHelper.getStaticAttrs(itemid,bmfbMainId,false)
local attrs=attrListHelper.concatList(attrs1,attrs2)
local attrs=attrListHelper.transformToNamedList(attrs)

local rawlist=fabaoPreviewModel:getRawlist(materialGuids)
local itemguid=fabaoPreviewModel:getGUID()

local czList=fabaoHelper.getCiZhuiList(mainMaterialItem)
local czlistlen=#(czList or{})
local lianhuaList=fabaoHelper.getLianHuaList(mainMaterialItem)
local lianhualen=#(lianhuaList or{})

local itemStruct={}
itemStruct.itemguid=itemguid
itemStruct.itemid=itemid
itemStruct.itemcount=1
itemStruct.itemflag=0
itemStruct.itemtime=0
itemStruct.itemData=table.deepCopy(bmfbItem.itemData)
local itemData=itemStruct.itemData

itemData.jilianlv=mainMaterialItemData.jilianlv
itemData.jilianexp=mainMaterialItemData.jilianexp




itemData.mainid=bmfbMainId
itemData.czlistlen=czlistlen
itemData.czList=czList
itemData.staticlistlen=#attrs
itemData.staticList=attrs
itemData.elementlistlen=mainMaterialItemData.elementlistlen
itemData.elementList=mainMaterialItemData.elementList
itemData.name=benMingFaBaoHelper.getDefaultName(bmfbMainId,mainfbtype)
itemData.discipleguid=Int64_0
itemData.rawlistlen=#rawlist
itemData.rawList=rawlist
itemData.mainidx=1



itemData.discipleguid=bmfbItem.itemData.discipleguid




fabaoPreviewModel:addFabao(itemStruct)
return itemguid
end

function fabaoPreviewModel:create_Compare_refine(bmfbGuid)
local bmfbItem=itemsModel.getItem(bmfbGuid)
local tempItem=table.deepCopy(bmfbItem)

local itemguid=fabaoPreviewModel:getGUID()
tempItem.itemguid=itemguid
local itemData=tempItem.itemData
itemData.jilianlv=0
itemData.jilianexp=0

fabaoPreviewModel:addFabao(tempItem)
return itemguid
end