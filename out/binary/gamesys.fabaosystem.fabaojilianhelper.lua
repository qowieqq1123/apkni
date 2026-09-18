





local _JilianErr={

eLevelToCap=2,
eNotMaterials=3,
eNotEnoughItem=4,
eNotPos=5,
eExpOver=6,
eSystemLock=7,
}
fabaoHelper.jilianErr=_JilianErr






function fabaoHelper.getJilianItemidList()
local itemlist={}
local list=fabaoConfig.getJilianItemList()
for itemid,_ in pairs(list)do
itemlist[#itemlist+1]=itemid
end
return itemlist
end

function fabaoHelper.getJilianItemsMaterias(needLookup,filterStage,filterColor,useCache)
local itemlist={}
local list=fabaoConfig.getJilianItemList()
for itemid,_ in pairs(list)do
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage
if needLookup[itemid]or(filterColor==nil or color<=filterColor)and(stage==nil or filterStage==nil or stage<=filterStage)then
itemlist[#itemlist+1]=itemid
end
end
if#itemlist==0 then
return{}
end
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,itemlist}
return bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,false,useCache)
end


function fabaoHelper.getJilianFabaoMaterias(filterguid,filterStage,filterColor,useCache)
local filter={}
if filterStage then
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eLessEqulas,{filterColor}}
end
if filterColor then
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eLessEqulas,{filterStage}}
end
if filterguid then
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{filterguid}}
end

filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eNot,{FABAO_TYPE.eBenMing}}

local minTuPolv=fabaoConfig.getMinTuPoLv()
filter[ITEM_FILTER_TYPE.eFabaoJinglian]={ITEM_FILTER_COMPARE.eLessEqulas,minTuPolv}
return bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,useCache)
end


function fabaoHelper.getJilianMateriasOnBag(filterguid,filterStage,filterColor,useCache)
local jilianShiLookup=fabaoConfig.getJilianItemList()
if useCache then
local temp=fabaoModel:getCacheTempTable_Materials()
local items=fabaoHelper.getJilianItemsMaterias(jilianShiLookup,filterStage,filterColor,useCache)
for _,v in ipairs(items)do
temp[#temp+1]=v
end

local fabaos=fabaoHelper.getJilianFabaoMaterias(filterguid,filterStage,filterColor,useCache)
for _,v in ipairs(fabaos)do
if not table.containsValue(temp,v)then
temp[#temp+1]=v
end
end
return temp
else
local items=fabaoHelper.getJilianItemsMaterias(jilianShiLookup,filterStage,filterColor,useCache)
local fabaos=fabaoHelper.getJilianFabaoMaterias(filterguid,filterStage,filterColor,useCache)
return table.concatTable(items,fabaos)
end
end


function fabaoHelper.getJilianBaseAttrsLookup(itemguid,level)

local item=fabaoHelper.getFabao(itemguid)
local baseAttrsLookup=fabaoHelper.getBaseAttrsLookup(item)
local JilianConfig=fabaoConfig.getJilianConfig(level)
if JilianConfig==nil then
return{}
end
local percent=JilianConfig.base
local baseAttrsLookup=attrListHelper.getAddLookupOnPercentLookup(baseAttrsLookup,percent,false)
return baseAttrsLookup
end


function fabaoHelper.getJilianAddBaseAttrs(itemguid,level)

local item=fabaoHelper.getFabao(itemguid)
return fabaoHelper.getJilianAddBaseAttrsByEquip(item,level)
end


function fabaoHelper.getJilianAddBaseAttrsByEquip(item,level)
local baseAttrsLookup=fabaoHelper.getBaseAttrsLookup(item)
local JilianConfig=fabaoConfig.getJilianConfig(level)
if JilianConfig==nil then
return{}
end
local percent=JilianConfig.base
local addBaseAttrsLookup=attrListHelper.getAddLookupOnPercentLookup(baseAttrsLookup,percent,true)
return addBaseAttrsLookup
end


function fabaoHelper.getAddJilianLv(itemguid,level,exp,addExp)
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local maxlv=fabaoHelper.getJilianMaxLv(itemguid)
if maxlv<=level then
return 0,addExp,addExp
end
local upExp=fabaoConfig.getJilianExp(level,itemConfig.stage,itemConfig.color)
local leftExpThisLv=upExp-exp
if addExp<leftExpThisLv then
return 0,exp+addExp,0
end
local startLv=level+1
local leftExp=addExp-leftExpThisLv
if fabaoConfig.isJilianTuPoLv(level,itemid)then
if level<(maxlv-1)then
return 0,leftExp,0
else
return 0,leftExp,leftExp
end
end
local addLv=1
local isTuPo=false
for i=startLv,maxlv-1 do
local needExp=fabaoConfig.getJilianExp(i,itemConfig.stage,itemConfig.color)
local isJilianTuPoLv=fabaoConfig.isJilianTuPoLv(i,itemid)
if leftExp>=needExp then
leftExp=leftExp-needExp
if isJilianTuPoLv then
if i<(maxlv-1)then
return addLv,leftExp,0
else
return addLv,leftExp,leftExp
end
end
addLv=addLv+1
else
if isJilianTuPoLv then
addLv=addLv-1
isTuPo=true
end
break
end
end
local lv=addLv+level
if lv>=(maxlv-1)then
return addLv,leftExp,leftExp,isTuPo
end
return addLv,leftExp,0,isTuPo
end


function fabaoHelper.getOverJilianLv(itemguid,level,addExp)
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local maxlv=fabaoHelper.getJilianMaxLv(itemguid)
if maxlv<=level then
return 0,addExp
end
local upExp=fabaoConfig.getJilianExp(level,stage,itemConfig.color)
addExp=addExp-upExp
if addExp<=0 then
return 0,0
end
local addLv=1
for i=level+1,maxlv-1 do
local needExp=fabaoConfig.getJilianExp(i,stage,itemConfig.color)
if addExp>=needExp then
addExp=addExp-needExp
addLv=addLv+1
else
break
end
end
return addLv,addExp
end

function fabaoHelper.getJilianExpByLevel(itemguid,starlv,targetlv)
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local maxLv=fabaoHelper.getJilianMaxLv(itemguid)
if targetlv>=maxLv then
targetlv=maxLv-1
end
if targetlv<=starlv then
return 0
end
local Jilianexp=0
for i=starlv,targetlv do
Jilianexp=Jilianexp+fabaoConfig.getJilianExp(i,stage,itemConfig.color)
end
return Jilianexp
end


function fabaoHelper.getJilianResetValue(itemguid,num)
local const_def=fabaoConfig.getJilianConstConfig()
local isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
local fabao=isEquip and itemsModel.getItem(itemguid)or bagModel.getItem(itemguid)
local itemid=fabao.itemid
if itemsConfig.isItem(itemid)then
local itemexp=const_def.itemexp or{}
local exp=itemexp[itemid]or 0
return num*exp
elseif itemsConfig.isFabao(itemid)then
local itemConfig=itemsConfig.getConfig(itemid)
local Jilianexp=fabao.itemData and fabao.itemData.jilianexp or 0
local Jilianlv=fabao.itemData and fabao.itemData.jilianlv or 0
if Jilianlv>0 then
for i=0,Jilianlv-1 do
Jilianexp=Jilianexp+fabaoConfig.getJilianExp(i,itemConfig.stage,itemConfig.color)
end
end
local inheritExp=math.floor(Jilianexp*fabaoConfig.getJilianLeftExpRatio())

local monthInvestorCfg=cfg_yuekaconfig()
if monthInvestorCfg[2]then
local highMonthCfg=monthInvestorCfg[2]
local isActive=rechargeModel:checkCardActive(highMonthCfg.id)
if isActive then
inheritExp=Jilianexp
end
end
return inheritExp
end
return 0
end


function fabaoHelper.getJilianValue(itemguid,num,isBMFB)
local const_def=fabaoConfig.getJilianConstConfig()
local isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
local fabao=isEquip and itemsModel.getItem(itemguid)or bagModel.getItem(itemguid)
local itemid=fabao.itemid
if itemsConfig.isItem(itemid)then
local itemexp=const_def.itemexp or{}
local exp=itemexp[itemid]or 0
return num*exp
elseif itemsConfig.isFabao(itemid)then
local fabaoexp=const_def.fabaoexp or{}
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local color=itemConfig.color
local fabaoexpStage1=fabaoexp[stage]or{}
local stageExp=fabaoexpStage1[color]or 0
if isBMFB then
stageExp=stageExp*3
end
local Jilianexp=fabao.itemData and fabao.itemData.jilianexp or 0
local Jilianlv=fabao.itemData and fabao.itemData.jilianlv or 0
if Jilianlv>0 then
for i=0,Jilianlv-1 do
Jilianexp=Jilianexp+fabaoConfig.getJilianExp(i,itemConfig.stage,itemConfig.color)
end
end
local inheritExp=math.floor(Jilianexp*fabaoConfig.getJilianLeftExpRatio())

local monthInvestorCfg=cfg_yuekaconfig()
if monthInvestorCfg[2]then
local highMonthCfg=monthInvestorCfg[2]
local isActive=rechargeModel:checkCardActive(highMonthCfg.id)
if isActive then
inheritExp=Jilianexp
end
end
return stageExp+inheritExp
end
return 0
end


function fabaoHelper.getMaxJilianValueOnItem(item)
local Jilianlv=item.itemData and item.itemData.jilianlv
local Jilianexp=item.itemData and item.itemData.jilianexp
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local level,exp=fabaoModel.getFabaoJilianLevel(itemguid)
local curMaxExp=fabaoConfig.getJilianExp(Jilianlv,itemConfig.stage,itemConfig.color)
local maxLv=fabaoHelper.getJilianMaxLv(itemguid)
local needExp=curMaxExp-Jilianexp
if fabaoConfig.isJilianTuPoLv(Jilianlv,itemid)then
return needExp
end
for i=Jilianlv+1,maxLv-1 do
needExp=needExp+fabaoConfig.getJilianExp(i,itemConfig.stage,itemConfig.color)
if fabaoConfig.isJilianTuPoLv(i,itemid)then
return needExp
end
end
return needExp
end


function fabaoHelper.getCanMaxJilianLv(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local stage=itemCfg.stage
local lv=fabaoConfig.getJilianMaxLv(stage)
if fabaoConfig.isBenMingFabao(itemid)then
local cfgs=cfg_disciplefabaolingxingconfig()
local addlv=cfgs[#cfgs].bonus[1]
lv=lv+addlv
end
return lv
end


function fabaoHelper.getJilianMaxLvByCfg(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local stage=itemCfg.stage
local lv=fabaoConfig.getJilianMaxLv(stage)
return lv
end


function fabaoHelper.getJilianMaxLv(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local maxlv=fabaoHelper.getJilianMaxLvByCfg(itemid)
local addlv=benMingFaBaoHelper.getAddJllv(itemguid)
maxlv=maxlv+addlv
return maxlv
end

function fabaoHelper.checkCostMoney(addexp)
local items=fabaoConfig.getJilianCost()
for i,v in ipairs(items)do
local itemid=v[1]
local revise=v[2]
local need=fabaoConfig.getJilianCostMoney(revise,addexp)
local isEnough=moneyModel.checkEnoughMoney(itemid,need)
if not isEnough then
return false,{itemid,need}
end
end
return true
end








function fabaoHelper.getTuPoAttrLookup(item)
local itemguid=item.itemguid
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)

local jlCfg=fabaoConfig.getJilianConfig(jllv)
local itemCfg=itemsConfig.getConfig(item.itemid)
local stage=itemCfg.stage

return jlCfg.tpattr[stage]or defaultT
end

function fabaoHelper.getJlBaseAttrsPercent(item)
local itemguid=item.itemguid
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)
local jlCfg=fabaoConfig.getJilianConfig(jllv)
return jlCfg.base
end


function fabaoHelper.getTuPoBonus(item,lv)
local itemguid=item.itemguid
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)
local jlCfg=fabaoConfig.getJilianConfig(lv or jllv)
return jlCfg.bonus
end


function fabaoHelper.getJlAddShenTonglv(item,lv)
local bonus=fabaoHelper.getTuPoBonus(item,lv)
return bonus[1]or 0
end


function fabaoHelper.getJlAddAttrsPercent(item,lv)
local bonus=fabaoHelper.getTuPoBonus(item,lv)
return bonus[2]or 0
end


function fabaoHelper.getAddJilianAttrs(item,jllv)
local itemguid=item.itemguid
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
jllv=jllv or fabaoModel.getFabaoJilianLevel(itemguid)
local type3=fabaoHelper.getType3(item)
local stage=itemCfg.stage
local jlCfg=fabaoConfig.getJilianConfig(jllv)
if jlCfg.attr and jlCfg.attr[stage]then
return jlCfg.attr[stage][type3]
end
end


function fabaoConfig.getAddJilianLookupAttrs(item,jllv)
local attrList=fabaoHelper.getAddJilianAttrs(item,jllv)
local attrLookup=attrListHelper.tramsformToLookup(attrList)
return attrLookup
end








function fabaoHelper.isCanShowJilian(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eJiLian)then
if warn then
UIManager.error('系统未解锁，无法祭炼')
end
return false,_JilianErr.eSystemLock
end
local fabao=fabaoHelper.getFabao(itemguid)
if fabao==nil then
return false
end
local itemConfig=itemsConfig.getConfig(fabao.itemid)
local stage=itemConfig.stage
local level,exp=fabaoModel.getFabaoJilianLevel(itemguid)
local maxLv=fabaoHelper.getJilianMaxLv(itemguid)
local maxExp=fabaoConfig.getJilianExp(level,itemConfig.stage,itemConfig.color)
if maxLv==0 or level>=maxLv and exp>=maxExp then
if warn then
UIManager.error('法宝祭炼等级达到上限')
end
return false,_JilianErr.eLevelToCap,maxLv
end
return true
end


function fabaoHelper.isCanJilian(itemguid,addexp,warn)
local ret,errType,errArgs=fabaoHelper.isCanShowJilian(itemguid,warn)
if not ret then
return ret,errType,errArgs
end
local item=fabaoHelper.getFabao(itemguid)
local itemid=item.itemid
local level,exp=fabaoModel.getFabaoJilianLevel(itemguid)
local inTuPo=fabaoHelper.isInTuPo(itemguid,itemid)
if inTuPo then
return false
else
local consumelist=fabaoConfig.getJilianCost()
for _,v in ipairs(consumelist)do
local moneyType=v[1]
local revise=v[2]
local needMoney=fabaoConfig.getJilianCostMoney(revise,addexp)
if not moneyModel.checkEnoughMoney(moneyType,needMoney)then
if warn then
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足',moneyName))
gainControl:showGainWin(moneyType)
end
return false,_JilianErr.eNotEnoughItem,{moneyType,needMoney}
end
end
end
return true
end


function fabaoHelper.isCanTuPo(itemguid,warn)
local ret,errType,errArgs=fabaoHelper.isCanShowJilian(itemguid,warn)
if not ret then
return ret,errType,errArgs
end
local item=fabaoHelper.getFabao(itemguid)
local itemid=item.itemid
local level,exp=fabaoModel.getFabaoJilianLevel(itemguid)
local inTuPo=fabaoHelper.isInTuPo(itemguid,itemid)
if inTuPo then
local costs=fabaoConfig.getJilianTuPoCost(level,itemid)
for _,v in ipairs(costs)do
local _itemid=v[1]
local num=v[2]
if itemsModel.getCount(_itemid)<num then
if warn then
local name=itemsModel.getName(_itemid)
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(_itemid)
end
return false,_JilianErr.eNotEnoughItem,{_itemid,num}
end
end
else
return false
end
return true
end


function fabaoHelper.isInTuPo(itemguid,itemid)
local level,exp=fabaoModel.getFabaoJilianLevel(itemguid)
if fabaoConfig.isJilianTuPoLv(level,itemid)then
local itemConfig=itemsConfig.getConfig(itemid)
local needExp=fabaoConfig.getJilianExp(level,itemConfig.stage,itemConfig.color)
return exp>=needExp
end
return false
end


function fabaoHelper.isInTuPoLv(itemguid,itemid)
local level,exp=fabaoModel.getFabaoJilianLevel(itemguid)
return fabaoConfig.isJilianTuPoLv(level,itemid)
end

function fabaoHelper.getTuPoItems(item)
local itemid=item.itemid
local Jilianlv=item.itemData and item.itemData.jilianlv
local Jilianexp=item.itemData and item.itemData.jilianexp
local costItems={}

local add=function(cost)
local id=cost[1]
local val=cost[2]
for i,v in ipairs(costItems)do
if v[1]==id then
v[2]=v[2]+val
return
end
end
costItems[#costItems+1]={id,val}
end

if Jilianlv>0 then
for i=0,Jilianlv-1 do
local cost=fabaoConfig.getJilianTuPoCost(i,itemid)
if cost then
for i,v in ipairs(cost)do
add(v)
end
end
end
else
return
end
return costItems
end


function fabaoHelper.returnJilianResetItems(item)
local jilianExp=fabaoHelper.getJilianResetValue(item.itemguid,1)
local itemInfo=cfg_bagualuaconfig_get(1).fabao
local itemid=itemInfo[1]
local exp=itemInfo[2]
local num=math.floor(jilianExp/exp)
local jilianItems=num>0 and{{itemid,num}}or{}
local tupoItems=fabaoHelper.getTuPoItems(item)

return table.concatTableXX(jilianItems,tupoItems)
end


function fabaoHelper.returnRonglianItems(item,isBMFB)
local jilianExp=fabaoHelper.getJilianValue(item.itemguid,1,isBMFB)
local itemInfo=cfg_bagualuaconfig_get(1).fabao
local itemid=itemInfo[1]
local exp=itemInfo[2]
local num=math.floor(jilianExp/exp)
local jilianItems=num>0 and{{itemid,num}}or{}
local tupoItems=fabaoHelper.getTuPoItems(item)

return table.concatTableXX(jilianItems,tupoItems)
end


function fabaoHelper.returnRonglianItems_YuanPei(item)
local itemConfig=itemsConfig.getConfig(item.itemid)
local color=itemConfig.color
local cfg=cfgHelper.get(cfg_bagualuaconfig_get,1,"yuanpei")
local itemInfoList=cfg[color]
local ronglianItemList={}
for i,itemInfo in ipairs(itemInfoList)do
local itemId=itemInfo[1]
local itemCount=itemInfo[2]
local num=item.itemcount*itemCount
local ronglianItem={itemId,num}
table.insert(ronglianItemList,ronglianItem)
end

return ronglianItemList
end


function fabaoHelper.returnRonglianItems_FaBaoBenMing(item)
local itemid=item.itemid
local itemguid=item.itemguid
local equip=fabaoHelper.getFabao(itemguid)
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage or 0
local color=itemConfig.color
local cfg=cfgHelper.get(cfg_bagualuaconfig_get,1,"bmfabao")

local lxlv=fabaoModel.getLingXingLv(itemguid)

local ronglianItemList=fabaoConfig.getFanZhuLxItems(itemguid,lxlv)

local yuanpeiItems=fabaoHelper.returnRonglianItems_YuanPei(item)

local jlItems=fabaoHelper.returnRonglianItems(item,true)
local rjlItems={}
for i,v in ipairs(jlItems)do
if not itemsConfig.isMoney(v[1])then
rjlItems[#rjlItems+1]=v
end
end

local items=table.concatTableXX(yuanpeiItems,rjlItems)
return table.concatTableXX(ronglianItemList,items)
end


function fabaoHelper.checkFabaoIsCanJiLian(fabaoItemguid)
if not fabaoItemguid then
return false
end

local item=fabaoHelper.getFabao(fabaoItemguid)
if not item then
return false
end

local fabaoItemId=item.itemid
local itemConfig=itemsConfig.getConfig(fabaoItemId)
local color=itemConfig.color
local stage=itemConfig.stage

local targetColor=4
local targetStage=2
if stage and stage>=targetStage then
if not color or color<targetColor then

return false
end
end

local jilianlv=item.itemData and item.itemData.jilianlv or 0
local jilianexp=item.itemData and item.itemData.jilianexp or 0
local maxlv=fabaoHelper.getJilianMaxLv(fabaoItemguid)
if jilianlv>=maxlv then

return false
end

if not fabaoHelper.isCanShowJilian(fabaoItemguid)then

return false
end


local stageDropIdx=fabaoModel:getFabaoJiLianFilterIdx(ITEM_FILTER_TYPE.eStage)
local colorDropIdx=fabaoModel:getFabaoJiLianFilterIdx(ITEM_FILTER_TYPE.eColor)
local filterStage=stageDropIdx+1
local filterColor=colorDropIdx+1

local materialsList=fabaoHelper.getJilianMateriasOnBag(fabaoItemguid,filterStage,filterColor,true)or{}
if not materialsList or#materialsList<0 then

return false
end

local upExp=fabaoConfig.getJilianExp(jilianlv,stage,itemConfig.color)
local needLvUpExp=upExp-jilianexp
local minNeedExp=5000
local needExp=needLvUpExp>minNeedExp and needLvUpExp or minNeedExp
local tupoCost=fabaoConfig.getJilianTuPoCost(jilianlv,fabaoItemId)
local isNeedTupo=tupoCost~=nil and needLvUpExp<=0

if isNeedTupo then

return fabaoHelper.isCanTuPo(fabaoItemguid)
else

local sortTag={}

local temp=materialsList
for i,v in ipairs(temp)do
local exp=fabaoHelper.getJilianValue(v.itemguid,1)
sortTag[tostring(v.itemguid)]=itemsConfig.getMainType(v.itemid)*-10000000+exp*100-i
end


table.sort(temp,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)

local totalExp=0
local compelementInfo={}
for i,v in ipairs(temp)do
local itemid=v.itemid
local count=v.itemcount
local itemguid=v.itemguid
if totalExp>=needExp then
break
end
local hasExp=fabaoHelper.getJilianValue(itemguid,1)
local canPutExp=needExp-totalExp
local max=math.floor(canPutExp/hasExp)
local cnt=math.min(max,count)
local remainingCount=count
for j=1,cnt do
if totalExp>=needExp then
break
end
totalExp=totalExp+hasExp
remainingCount=remainingCount-1
end
if totalExp<needExp and remainingCount>0 then
local lastExp=compelementInfo[1]
if lastExp==nil or lastExp>hasExp then
compelementInfo={hasExp,itemguid}
end
end
end

if totalExp<needExp and#compelementInfo>0 then
local hasExp=compelementInfo[1]
totalExp=totalExp+hasExp
end

if totalExp<needExp then

return false
end

if not fabaoHelper.checkCostMoney(totalExp)then

return false
end
end

return true
end

function fabaoHelper.getTuPoDesc(fabao,descArgs,args)
local typo=args[1]
if typo==1 then
local attrid=args[2]
local cfg=cfg_attributesconfig_get(attrid)
local name=cfg.attrname
return FMT.fmt(descArgs[typo],name,args[3])
elseif typo==2 then
local czlist=fabaoHelper.getCiZhuiList(fabao)
local czidx=args[2]
local czid=czlist[czidx]
local cfg=cfg_disciplefabaoczconfig_get(czid)
local czname=cfg.name
local desc=descArgs[typo]
return FMT.fmt('{0}\n【{1}】{2}',desc,czname,cfg.desc)
elseif typo==3 then
return FMT.fmt(descArgs[typo],args[2])
elseif typo==4 then
return FMT.fmt(descArgs[typo],args[2])
elseif typo==5 then
local itemCfg=itemsConfig.getConfig(fabao.itemid)
local stage=itemCfg.stage
local arg=args[2][stage]
local attrid=arg[1]
local cfg=cfg_attributesconfig_get(attrid)
local name=cfg.attrname
return FMT.fmt(descArgs[typo],name,arg[2])
end
end

function fabaoHelper.getTuPoDescEx(fabao,descArgs,args)
local typo=args[1]
if typo==1 then
local attrid=args[2]
local cfg=cfg_attributesconfig_get(attrid)
local name=cfg.attrname
return FMT.fmt(descArgs[typo],name,args[3])
elseif typo==2 then
local czlist=fabaoHelper.getCiZhuiList(fabao)
local czidx=args[2]
local czid=czlist[czidx]
local cfg=cfg_disciplefabaoczconfig_get(czid)
return cfg.desc
elseif typo==3 then
return FMT.fmt(descArgs[typo],args[2])
elseif typo==4 then
return FMT.fmt(descArgs[typo],args[2])
elseif typo==5 then
local itemCfg=itemsConfig.getConfig(fabao.itemid)
local stage=itemCfg.stage
local arg=args[2][stage]
local attrid=arg[1]
local cfg=cfg_attributesconfig_get(attrid)
local name=cfg.attrname
return FMT.fmt(descArgs[typo],name,arg[2])
end
end

