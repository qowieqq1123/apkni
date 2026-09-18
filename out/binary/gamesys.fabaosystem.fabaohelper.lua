





fabaoHelper={}

local _fabaoLianzhiErr=
{
eNotEnoughtMainItem=1,
eNotEnoughMoney=2,
}
fabaoHelper.lianzhiErr=_fabaoLianzhiErr

function fabaoHelper.getFabao(itemguid)
return fabaoBagModel:getItem(itemguid)or
fabaoModel.getFabao(itemguid)or
fabaoPreviewModel:getFabao(itemguid)or
rankListModel:findFabao(itemguid)or
watchModel.getItem(itemguid)or
auctionModel:getItem(itemguid)or
mailModel:getItem(itemguid)
end


function fabaoHelper.getMainMaterialsConfig(item)
if fabaoConfig.isXiantianFabao(item.itemid)then
return itemsConfig.getConfig(item.itemid),false
else
local itemid=fabaoHelper.getMainId(item)
local conf=itemsConfig.getConfig(itemid)
return conf,true
end
end



function fabaoHelper.getDefaultName(item)
local mainid=fabaoHelper.getReallyMainId(item)
if mainid==0 then
logErr('先天法宝不进入这里')
return''
end
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local mainItemConfig=itemsConfig.getConfig(mainid)
local color=mainItemConfig.color
local fabaoname=mainItemConfig.fabaoname
if fabaoname==nil then
loggerUtil.logErrFMT('{0}的fabaoname没配',mainid)
return''
end

local isEquip=itemsConfig.isEquip(mainid)
local stage=itemCfg.stage

fabaoname=isEquip and fabaoname[stage]or fabaoname


local qianzhuiList=fabaoname[1]or{}
local qianzhuiName=qianzhuiList[itemCfg.color]


local midList=fabaoname[2]or{}
local elementList=fabaoHelper.getElementListBySort(item)
local element=elementList[2]or elementList[1]
local attrid=element[1]
local elementType=fabaoConfig.getElementTypeByAttrid(attrid)
local midName=midList[elementType]


local houzhuiName=fabaoname[3]


return FMT.fmt('{0}{1}{2}',qianzhuiName,midName,houzhuiName)
end

function fabaoHelper.getFabaoName(item)
local name=item.itemData and item.itemData.name
if name and name~=''then
return name
end
local itemid=item.itemid
if fabaoConfig.isBenMingFabao(itemid)then
loggerUtil.logErrFMT('本命法宝{0}没有下发名称',itemid)
return''
else
return fabaoHelper.getDefaultName(item)
end
end

function fabaoHelper.getColorFabaoName(item)
local name=fabaoHelper.getFabaoName(item)
local color=itemsConfig.getConfig(item.itemid).color
return FMT.cfmt(color,name)
end


function fabaoHelper.computeStage(itemidlist)
if itemidlist==nil or itemidlist[1]==nil then
return
end
local itemid=itemidlist[1]
local itemCfg=itemsConfig.getConfig(itemid)
if itemsConfig.isMaterials(itemid)then
return itemCfg.stage
end
loggerUtil.logErrFMT('传入参数有问题：{0}',itemid)
end


function fabaoHelper.getShentongid(item)
local itemid=item.itemid
local addlv=fabaoHelper.getJlAddShenTonglv(item)
if fabaoConfig.isBenMingFabao(itemid)then
local shengInfos=benMingFaBaoHelper.getShentongInfoList(item)
local idx=benMingFaBaoHelper.getNowMainIdx(item)
local info=shengInfos[idx]
local id=info[1]
local lv=info[2]+
benMingFaBaoHelper.getAddShentonglv(item.itemguid,idx)+
addlv
return id,lv
else
local itemCfg=itemsConfig.getConfig(item.itemid)
local lv=itemCfg.color+addlv
local mainMaterialsConfig=fabaoHelper.getMainMaterialsConfig(item)
return mainMaterialsConfig.shentong,lv
end
end


function fabaoHelper.getShentongidByMainItemId(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local lv=itemCfg.color
local shentongid=itemCfg.shentong
return shentongid,lv
end


function fabaoHelper.getCiZhuiList(item)





return item.itemData and item.itemData.czList

end


function fabaoHelper.getInitLianHuaList(item)
return item.itemData and item.itemData.initlianhuaList
end


function fabaoHelper.getLianHuaList(item)




return item.itemData and item.itemData.lianhuaList

end


function fabaoHelper.isCanUseToMakeFabao(itemid)
local config=itemsConfig.getConfig(itemid)
if itemsConfig.isMaterials(itemid)then
if config.element==nil then return false end
end
return true
end

function fabaoHelper.isXiantianFabaoByType1(type1)
return type1==0 or type1==nil
end

function fabaoHelper.getIconItemId(item)
local itemid=item.itemid
if fabaoConfig.isXiantianFabao(itemid)then
return itemid
else
return fabaoHelper.getMainId(item)
end
end


function fabaoHelper.getType3Itemid(item)
local itemid=item.itemid
if fabaoConfig.isBenMingFabao(itemid)then
return benMingFaBaoHelper.getMaterialsInfoList(item)[1].param_2
end
return fabaoHelper.getMainId(item)
end


function fabaoHelper.getType3(item)
local itemid=fabaoHelper.getType3Itemid(item)
return itemsConfig.getConfig(itemid).type3
end




function fabaoHelper.getMainId(item)
local mainid=fabaoHelper.getReallyMainId(item)or item.itemid
if mainid==0 then mainid=item.itemid end
return mainid
end

function fabaoHelper.getReallyMainId(item)
local itemid=item.itemid
if fabaoConfig.isXiantianFabao(itemid)then
return itemsConfig.getConfig(itemid).mainid or nil
end
return item.itemData and item.itemData.mainid or nil
end



function fabaoHelper.getMateriasByBag(bagType,filterElement,filterStage)
local filter={}
if filterElement then
filter[ITEM_FILTER_TYPE.eElement]={ITEM_FILTER_COMPARE.eEquals,{filterElement}}
end
if filterStage then
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eEquals,{filterStage}}
end
return bagControl.getBagItemsByFilter(bagType,filter)
end


function fabaoHelper.getAddLianhuaAttrsListByLianzhi(itemidlist)
if itemidlist==nil or#itemidlist==0 then return{}end
local left=#itemidlist
local rangeList={}
for _,v in ipairs(itemidlist)do
fabaoHelper.getAddLianhuaAttrsListByItem(left,v,1,rangeList)
end
return rangeList
end

function fabaoHelper.isCanLianzhiMoney(itemidlist,percent)
local stage=fabaoHelper.computeStage(itemidlist)
local cost=fabaoConfig.getCostByLianzhi(stage)
for i,v in ipairs(cost)do
local moneyType=v[1]
local price=v[2]
if percent~=0 then
price=math.ceil(price*(1+percent/100))
end
if not moneyModel.checkEnoughMoney(moneyType,price)then
return false,_fabaoLianzhiErr.eNotEnoughMoney,{moneyType,price}
end
end
return true
end


function fabaoHelper.handleItem(item)
local itemid=item.itemid
local itemData=item.itemData
if itemData then

local itemCfg=itemsConfig.getConfig(itemid)

if fabaoConfig.isXiantianFabao(itemid)then

local cz=itemCfg.cz
itemData.czlen=#(cz or{})
itemData.czList=cz


local type3Id=fabaoHelper.getType3Itemid(item)
local mainItemCfg=itemsConfig.getConfig(type3Id)
if mainItemCfg.static==nil then
if type3Id==itemid then
loggerUtil.logErrFMT('先天法宝{0}的没有配置主材料',itemid)
else
loggerUtil.logErrFMT('先天法宝{0}的主材料{1}没有配置static',itemid,type3Id)
end
end
local attrs=mainItemCfg.static[itemCfg.color]
itemData.staticlen=#(attrs or{})
itemData.staticList=attrListHelper.transformToNamedList(attrs)


local element=itemCfg.element
itemData.elementlen=#(element or{})
itemData.elementList=attrListHelper.transformToNamedList(element)

if itemData.lianhuaList==nil or#itemData.lianhuaList==0 then
local lianhua=itemCfg.lianhua
itemData.lianhualen=#(lianhua or{})
itemData.lianhuaList=attrListHelper.transformToNamedList(lianhua)
end

if itemData.lianhuanum==0 then
itemData.initlianhualen=itemData.lianhualen
itemData.initlianhuaList=itemData.lianhuaList
end
itemData.name=itemCfg.name
else
if fabaoConfig.isBenMingFabao(itemid)then

local type3Id=fabaoHelper.getType3Itemid(item)
local type3ItemCfg=itemsConfig.getConfig(type3Id)
local attrs1=type3ItemCfg.static[itemCfg.color]

local mainid=fabaoHelper.getMainId(item)
local attrs2=benMingFaBaoHelper.getStaticAttrs(itemid,mainid)

local attrs=attrListHelper.concatList(attrs1,attrs2)

itemData.staticlen=#(attrs or{})
itemData.staticList=attrListHelper.transformToNamedList(attrs)
else

local type3Id=fabaoHelper.getType3Itemid(item)
local mainItemCfg=itemsConfig.getConfig(type3Id)
local attrs=mainItemCfg.static[itemCfg.color]
itemData.staticlen=#(attrs or{})
itemData.staticList=attrListHelper.transformToNamedList(attrs)
end
if itemData.lianhuanum==0 then
itemData.initlianhualen=itemData.lianhualen
itemData.initlianhuaList=itemData.lianhuaList
end
fabaoHelper.logHouTian(item)
if itemData.name==''or itemData.name==nil then
itemData.name=fabaoHelper.getDefaultName(item)
end
end
end
end


function fabaoHelper.logHouTian(item)
local itemData=item.itemData
if itemData==nil then
loggerUtil.logErrFMT('生成后天法宝itemData为空:{0}',item.itemid)
return
end
if itemData.elementList==nil then
loggerUtil.logErrFMT('生成后天法宝elementList为空:{0}',item.itemid)
return
end
end

function fabaoHelper.hasMainElement(item,elementType)
return fabaoHelper.getMainElement(item)==elementType
end


function fabaoHelper.getMainElement(item)
local itemid=fabaoHelper.getReallyMainId(item)
if itemid==nil or itemid==0 then return end
local itemCfg=itemsConfig.getConfig(itemid)
local element=itemCfg.element
if element then return element end
local elementList=item.itemData.elementList or{}
local elementInfo=elementList[1]or{}
local attrid=elementInfo.param_1
return fabaoConfig.getElementTypeByAttrid(attrid)
end

function fabaoHelper.getElementList(item)
if item.itemData and item.itemData.elementList then
return attrListHelper.transformFromNamedList(item.itemData.elementList)
end
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
return itemCfg.element
end

function fabaoHelper.getElementListBySort(item)
local list=fabaoHelper.getElementList(item)
local tempTable=table.deepCopy(list)
for i,v in ipairs(tempTable)do
v.idx=i
end
table.sort(tempTable,function(a,b)
if a[1]==b[1]then
return a.idx<b.idx
end
return a[2]>b[2]
end)
return tempTable
end

function fabaoHelper.isDressed(itemguid)
return fabaoModel.getDiziguidStrByItemguid(itemguid)~=nil
end

function fabaoHelper.isCanDress(diziguid,itemid,itemguid,warning)
if not itemsConfig.isFabao(itemid)then return true end
local itemCfg=itemsConfig.getConfig(itemid)
local needjingjielv=fabaoHelper.getDressJingjielv(itemid,itemguid)
local jingJieLv=UIDiscipleModel:getDiscipleJJLevel(diziguid)
if jingJieLv<needjingjielv then
if warning then
UIManager.error('弟子境界等级不足')
end
return false
end
return true
end

function fabaoHelper.getDressJingjielv(itemid,itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
local needjingjielv=fabaoConfig.getDressJingjielv(itemCfg.stage)
local addJingJieLv=0
if itemguid then
addJingJieLv=fabaoCizuiHelper.getAddJingjieLv(itemguid)
end
return needjingjielv+addJingJieLv
end

function fabaoHelper.getNextLianzhiWeightlv(mainid,lianqilv)
local cfg=itemsConfig.getConfig(mainid)
local lianzi=cfg.lianzhicolor
local maxlv=lianzi[#lianzi][1]
for _,v in ipairs(lianzi)do
local lv=v[1]
if lv>=lianqilv then
lv=lv+1
if lv<=maxlv then return lv end
end
end
end


function fabaoHelper.lianzhiBaseWeight(mainid,lianqilv)
local cfg=itemsConfig.getConfig(mainid)
local weight=fabaoHelper.makeBaseRandLib(cfg.lianzhicolor,lianqilv)
local total=0
local list={}
for color,v in pairs(weight)do
total=total+v
list[#list+1]={v,color}
end
if#list>1 then
table.sort(list,function(a,b)return a[2]<b[2]end)
end
local precentArray={}
local left=100
local lastColor
for i=#list,1,-1 do
local info=list[i]
local val=info[1]
local color=info[2]
local precent=math.floor(val*1000/total)/10
precentArray[color]=precent
left=left-precent
if precent>0 then
lastColor=color
end
end
if left>0 then
precentArray[lastColor]=precentArray[lastColor]+left
end
return precentArray
end

function fabaoHelper.lianzhiWeight(diziguid,mainid,itemlist,jhid)
local equipcolorfix=fabaoConfig.getCommonConfig().equipcolorfix
local lianqilv=UIDiscipleModel:getDiscipleJobLevel(diziguid,DISCIPLE_PROSKILL_TYPE.eLianQi)
local equipcolorCfg
if itemsConfig.isEquip(mainid)then
local stage=itemsConfig.getConfig(mainid).stage
equipcolorCfg=equipcolorfix[stage]
end
local jinghuacolorCfg
if jhid then
local jinghuacolorfix=fabaoConfig.getJingHuaCfg()
jinghuacolorCfg=jinghuacolorfix[jhid][2]
end
local cfg=itemsConfig.getConfig(itemlist[1])
local stageList={}
for i,v in ipairs(itemlist)do
stageList[#stageList+1]=itemsConfig.getConfig(v).stage
end
local weight=fabaoHelper.makeRandLib(cfg.lianzhicolor,lianqilv,stageList,equipcolorCfg,jinghuacolorCfg)
local total=0
local list={}
for color,v in pairs(weight)do
total=total+v
list[#list+1]={v,color}
end
if#list>1 then
table.sort(list,function(a,b)return a[2]<b[2]end)
end
local precentArray={}
local left=100
local lastColor
for i=#list,1,-1 do
local info=list[i]
local val=info[1]
local color=info[2]
local precent=math.floor(val*1000/total)/10
precentArray[color]=precent
left=left-precent
if precent>0 then
lastColor=color
end
end
if left>0 then
precentArray[lastColor]=precentArray[lastColor]+left
end
return precentArray
end

function fabaoHelper.makeBaseRandLib(cfg,lianqilv)
for _,v in ipairs(cfg)do
local lv,color_lib=v[1],v[2]

if lianqilv<=lv then
local fixed_color_lib=table.deepCopy(color_lib)


local total_weight=0
for _,weight in ipairs(fixed_color_lib)do
total_weight=total_weight+weight
end
local weight_list={}
local left_weight=10000
for color,weight in ipairs(fixed_color_lib)do
local new_weight=math.floor(weight*10000/total_weight)
weight_list[color]=new_weight
left_weight=left_weight-new_weight
end
if left_weight>0 then
for color,weight in ipairs(weight_list)do
if weight>0 then
weight_list[color]=weight+left_weight
break
end
end
end
return weight_list
end
end
end

function fabaoHelper.makeRandLib(cfg,lianqilv,stageList,equipcolorfix,jinghuacolorCfg)
for _,v in ipairs(cfg)do
local lv,color_lib,fix_lib=v[1],v[2],v[3]

if lianqilv<=lv then
local fixed_color_lib=table.deepCopy(color_lib)

local main_stage,sub_stage_list=stageList[1],{unpack(stageList,2)}
for color,fix in ipairs(fix_lib)do
if fix~=0 then
for _,stage in ipairs(sub_stage_list)do
local fix_res=(stage-main_stage)*fix
if fix_res>0 then fixed_color_lib[color]=fixed_color_lib[color]+fix_res end
end
end
end



if equipcolorfix then
for color,fix in ipairs(equipcolorfix)do
fixed_color_lib[color]=fixed_color_lib[color]+fix
end
end


local total_weight=0
for _,weight in ipairs(fixed_color_lib)do
total_weight=total_weight+weight
end
local weight_list={}
local left_weight=10000
for color,weight in ipairs(fixed_color_lib)do
local new_weight=math.floor(weight*10000/total_weight)
weight_list[color]=new_weight
left_weight=left_weight-new_weight
end
if left_weight>0 then
for color,weight in ipairs(weight_list)do
if weight>0 then
weight_list[color]=weight+left_weight
break
end
end
end


if jinghuacolorCfg then
local sum_weight=0
for color,weight in ipairs(jinghuacolorCfg)do
if weight>0 then
weight_list[color]=weight_list[color]+weight
sum_weight=sum_weight+weight
end
end
for color,weight in ipairs(weight_list)do
if weight>0 then
if weight>=sum_weight then
weight_list[color]=weight-sum_weight
sum_weight=0
break
else
weight_list[color]=0
sum_weight=sum_weight-weight
end
end
end
end

return weight_list
end
end
end


function fabaoHelper.isUnlockByCreate(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local comCfg=fabaoConfig.getCommonConfig()
local stage=itemCfg.stage
local isEquip=itemsConfig.isEquip(itemid)
local refstage=stage and(isEquip and comCfg.stage[stage]or stage)or nil
local systemLimit=comCfg.system
local limitSystem=stage and systemLimit[refstage]or nil
local isUnlock=true
if limitSystem then
isUnlock=systemModel.isOpen(limitSystem)
end
return isUnlock
end

