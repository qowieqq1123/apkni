






local _jinglianErr=
{

eNotEnoughColor=2,
eLevelToCap=3,
eNotMaterials=4,
eNotEnoughMoney=5,
eNotPos=6,
eExpOver=7,
}
equipsHelper.jinglianErr=_jinglianErr






function equipsHelper.getItemsMaterias(filterguid,filterColor,useCache)
local itemlist={}
local list=equipsConfig.getJinglianItemList()
for itemid,_ in pairs(list)do
itemlist[#itemlist+1]=itemid
end
if#itemlist==0 then return{}end
local filter={}
if filterguid then
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{filterguid}}

end
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,itemlist}
return bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,nil,useCache)
end


function equipsHelper.getEquipsMaterias(filterguid,filterStage,filterColor,lockEquip,sort,useCache)
local filter={}
if filterStage then
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eLessEqulas,{filterStage}}
end
if filterColor then
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eLessEqulas,{filterColor}}
end
if lockEquip then
filter[ITEM_FILTER_TYPE.eIsLock]=false
end
if filterguid then
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{filterguid}}
filter[ITEM_FILTER_TYPE.eEquipXMType]={ITEM_FILTER_COMPARE.eNot,{EQUIP_XianMo_TYPES.eXian,EQUIP_XianMo_TYPES.eMo}}
end
filter[ITEM_FILTER_TYPE.eDianHuaEquip]={ITEM_FILTER_COMPARE.eEquals,false}
return bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter,sort,useCache)
end


function equipsHelper.getEquipsMaterias2(filterguidlist,filterStage,filterColor,lockEquip,sort,useCache)
local filter={}
if filterStage then
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eLessEqulas,{filterStage}}
end
if filterColor then
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eLessEqulas,{filterColor}}
end
if lockEquip then
filter[ITEM_FILTER_TYPE.eIsLock]=false
end
if filterguidlist then
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,filterguidlist}
filter[ITEM_FILTER_TYPE.eEquipXMType]={ITEM_FILTER_COMPARE.eNot,{EQUIP_XianMo_TYPES.eXian,EQUIP_XianMo_TYPES.eMo}}
end
filter[ITEM_FILTER_TYPE.eDianHuaEquip]={ITEM_FILTER_COMPARE.eEquals,false}
return bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter,sort,useCache)
end



function equipsHelper.getMateriasOnBag(filterguid,filterStage,filterColor,filterlockEquip,useCache)
if useCache then
local temp=equipsModel:getCacheTempTable_Materials()
local items=equipsHelper.getItemsMaterias(filterguid,filterColor,useCache)
for _,v in ipairs(items)do
temp[#temp+1]=v
end

local equips=equipsHelper.getEquipsMaterias(filterguid,filterStage,filterColor,filterlockEquip,nil,useCache)
for _,v in ipairs(equips)do
temp[#temp+1]=v
end
return temp
else
local items=equipsHelper.getItemsMaterias(filterguid,filterColor,useCache)
local equips=equipsHelper.getEquipsMaterias(filterguid,filterStage,filterColor,filterlockEquip,nil,useCache)
return table.concatTableX(items,equips)
end
end


function equipsHelper.getJinglianBaseAttrs(itemid,level)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage

local baseAttrsLookup=equipsHelper.getBaseAttrLookup(itemConfig)
local jinglianConfig=equipsConfig.getJinglianConfig(equipType,level)
if jinglianConfig==nil then
return{}
end
local jinglianAttr=jinglianConfig.attr
local attrLookup=jinglianAttr[stage]and attrListHelper.tramsformToLookup(jinglianAttr[stage])
local percent=jinglianConfig.percent or 0
local baseAttrsLookup=attrListHelper.getLookupOnPercent(baseAttrsLookup,percent,false)
local lookup=attrListHelper.concatLookup(baseAttrsLookup,attrLookup)
return lookup
end


function equipsHelper.getJinglianAddBaseAttrs(itemid,level)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage

local baseAttrsLookup=equipsHelper.getBaseAttrLookup(itemConfig)
local jinglianConfig=equipsConfig.getJinglianConfig(equipType,level)
if jinglianConfig==nil then
return{}
end
local jinglianAttr=jinglianConfig.attr
local attrLookup=jinglianAttr[stage]and attrListHelper.tramsformToLookup(jinglianAttr[stage])
local percent=jinglianConfig.percent or 0
local addBaseAttrsLookup=attrListHelper.getAddLookupOnPercent(baseAttrsLookup,percent,true)
local lookup=attrListHelper.concatLookup(addBaseAttrsLookup,attrLookup)
return lookup
end


function equipsHelper.getAddJinglianLv(itemid,level,exp,addExp)
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local equipType=equipsConfig.getEquipType(itemid)
local maxlv=equipsConfig.getJinglianMaxLv(stage)
if maxlv<=level then return 0,addExp,addExp end
local upExp=equipsConfig.getJinglianExp(equipType,level,stage)
local leftExpThisLv=upExp-exp
if addExp<leftExpThisLv then return 0,exp+addExp,0 end
local startLv=level+1
local leftExp=addExp-leftExpThisLv
local addLv=1
for i=startLv,maxlv-1 do
local needExp=equipsConfig.getJinglianExp(equipType,i,stage)
if leftExp>=needExp then
addLv=addLv+1
leftExp=leftExp-needExp
else
break
end
end
local lv=addLv+level
local fullExp=0
if lv>=maxlv then
return addLv,leftExp,leftExp
end
return addLv,leftExp,0
end


function equipsHelper.getJinglianValue(itemguid,num)
local const_def=equipsConfig.getJinglianConstConfig()
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
if itemsConfig.isItem(itemid)then
local itemexp=const_def.itemexp or{}
local exp=itemexp[itemid]or 0
return num*exp
elseif itemsConfig.isEquip(itemid)then
local equipexp=const_def.equipexp or{}
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local color=itemConfig.color
if equipexp[stage]==nil then
loggerUtil.logErrFMT('没有找到{0}阶装备作为精炼材料的配置',stage)
end
local equipexpStage1=equipexp[stage]or{}
local stageExp=equipexpStage1[color]or 0
local curjinglianexp=equip.itemData and equip.itemData.jinglianexp or 0
local jinglianexp=curjinglianexp+equipsHelper.getJingLianCostedExp(equip)
local inheritExp=jinglianexp*equipsConfig.getJinglianLeftExpRatio()

local monthInvestorCfg=cfg_yuekaconfig()
if monthInvestorCfg[2]then
local highMonthCfg=monthInvestorCfg[2]
local isActive=rechargeModel:checkCardActive(highMonthCfg.id,false)
if isActive then
inheritExp=jinglianexp
end
end
return stageExp+math.floor(inheritExp)
end
return 0
end

function equipsHelper.getJingLianCostedExp(equip)
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
if jinglianlv<=0 then return 0 end
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage
local dzequipjinglianconfig=cfg_discipleequipjinglianconfig_get(equipType)
local costedExp=0
for i=0,jinglianlv-1 do
local jinglianConfig=dzequipjinglianconfig[i]
local expList=jinglianConfig.exp
costedExp=costedExp+expList[stage]
end
return costedExp
end


function equipsHelper.getJinglianValueToMaxLevelOnItem(item)
local jinglianlv=item.itemData and item.itemData.jinglianlv
local jinglianexp=item.itemData and item.itemData.jinglianexp
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage
local level,exp=equipsModel.getEquipJinglianLevelByGUID(itemguid)
local curMaxExp=equipsConfig.getJinglianExp(equipType,jinglianlv,stage)
local maxLv=equipsConfig.getJinglianMaxLv(stage)
local needExp=curMaxExp-jinglianexp
for i=jinglianlv+1,maxLv-1 do
needExp=needExp+equipsConfig.getJinglianExp(equipType,i,stage)
end
return needExp
end


function equipsHelper.getJinglianValueToTargetLevelOnItem(item,targetLevel)
local jinglianlv=item.itemData and item.itemData.jinglianlv
if jinglianlv>=targetLevel then
return 0
end
local jinglianexp=item.itemData and item.itemData.jinglianexp
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage
local level,exp=equipsModel.getEquipJinglianLevelByGUID(itemguid)
local curMaxExp=equipsConfig.getJinglianExp(equipType,jinglianlv,stage)
local needExp=curMaxExp-jinglianexp
for i=jinglianlv+1,targetLevel-1 do
needExp=needExp+equipsConfig.getJinglianExp(equipType,i,stage)
end
return needExp
end


function equipsHelper.getJinglianValueToMaxLevel(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage
local maxLv=equipsConfig.getJinglianMaxLv(stage)
local maxexp=0
for i=0,maxLv-1 do
maxexp=maxexp+equipsConfig.getJinglianExp(equipType,i,stage)
end
return maxLv
end














function equipsHelper.isCanShowJinglian(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eJingLian)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eJingLian)
UIManager.error(tips)
end
return false
end
local equip=equipsHelper.getEquip(itemguid)
local itemConfig=itemsConfig.getConfig(equip.itemid)
local color=itemConfig.color
local minColor=equipsConfig.getJinglianMinColor()or eQualityColor.ePurple
if color<minColor then
if warn then
UIManager.error('紫色及以上的装备才能精炼')
end
return false,_jinglianErr.eNotEnoughColor,color
end

local equipType=equipsConfig.getEquipType(equip.itemid)
local stage=itemConfig.stage
local level,exp=equipsModel.getEquipJinglianLevelByGUID(itemguid)
local maxLv=equipsConfig.getJinglianMaxLv(stage)
local maxExp=equipsConfig.getJinglianExp(equipType,level,stage)

if maxLv==0 or level>=maxLv and exp>=maxExp then
if warn then
UIManager.error('装备精炼等级达到上限')
end
return false,_jinglianErr.eLevelToCap,maxLv
end

if maxLv>(level+1)then
local needExp=0
for i=level+1,maxLv-1 do
needExp=needExp+equipsConfig.getJinglianExp(equipType,i,stage)
end
if needExp<=0 then
if warn then
UIManager.error('装备精炼等级达到上限')
end
return false,_jinglianErr.eLevelToCap,maxLv
end
end
return true
end


function equipsHelper.isCanShowJinglian2(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eJingLian)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eJingLian)
UIManager.error(tips)
end
return false
end
local equip=equipsHelper.getEquip(itemguid)
local itemConfig=itemsConfig.getConfig(equip.itemid)
local color=itemConfig.color
local minColor=equipsConfig.getJinglianMinColor()or eQualityColor.ePurple
if color<minColor then
if warn then
UIManager.error('紫色及以上的装备才能精炼')
end
return false,_jinglianErr.eNotEnoughColor,color
end


local stage=itemConfig.stage
local level,exp=equipsModel.getEquipJinglianLevelByGUID(itemguid)
local maxLv=equipsConfig.getJinglianMaxLv(stage)


if maxLv==0 or level>=maxLv then
if warn then
UIManager.error('装备精炼等级达到上限')
end
return false,_jinglianErr.eLevelToCap,maxLv
end

return true
end


function equipsHelper.isCanJinglian(itemguid,addexp,targetlv,warn)
local ret,errType,errArgs=equipsHelper.isCanShowJinglian(itemguid,warn)
if not ret then
return ret,errType,errArgs
end
local ret,moneyType,needMoney=equipsHelper.isCanJinglianByCostMoney(itemguid,addexp,targetlv)
if not ret then
return false,_jinglianErr.eNotEnoughMoney,{moneyType,needMoney}
end
return true
end


function equipsHelper.getJinglianTargetLv(itemguid,addexp)
if addexp<=0 then return false end
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage
local maxlv=equipsConfig.getJinglianMaxLv(stage)
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
if jinglianlv>=maxlv then return false end
local jinglianexp=equip.itemData and equip.itemData.jinglianexp or 0


local fullNeedExp=equipsConfig.getJinglianExp(equipType,jinglianlv,stage)
local addlvExp=math.min(fullNeedExp-jinglianexp,addexp)
local leftExp=addexp-addlvExp
local temp={}
local targetlv=jinglianlv
for i=jinglianlv+1,maxlv-1 do
local lv=i
if leftExp>0 then
local needExp=equipsConfig.getJinglianExp(equipType,i,stage)
local addlvExp=math.min(needExp,leftExp)
temp[#temp+1]={lv,addlvExp}
targetlv=lv
leftExp=leftExp-addlvExp
if leftExp>=0 then
targetlv=targetlv+1
end
else
break
end
end
return targetlv
end

function equipsHelper.getJinglianCost(itemguid,addexp,targetlv)
if addexp<=0 then return{{1,0}}end
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local stage=itemConfig.stage
local maxlv=equipsConfig.getJinglianMaxLv(stage)
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
targetlv=targetlv or jinglianlv
if jinglianlv>=maxlv then return{}end
local jinglianexp=equip.itemData and equip.itemData.jinglianexp or 0


local fullNeedExp=equipsConfig.getJinglianExp(equipType,jinglianlv,stage)
local addlvExp=math.min(fullNeedExp-jinglianexp,addexp)
local leftExp=addexp-addlvExp
local temp={}
temp[#temp+1]={jinglianlv,addlvExp}

if jinglianlv<targetlv then
for i=jinglianlv+1,targetlv do
local lv=i
if lv<maxlv and leftExp>0 then
local needExp=equipsConfig.getJinglianExp(equipType,i,stage)
local addlvExp=math.min(needExp,leftExp)
temp[#temp+1]={lv,addlvExp}
leftExp=leftExp-addlvExp
else
break
end
end
end

local needCost={}
local consumelist=equipsConfig.getJinglianCost()
local checkCost=function(lv,exp)
for i,v in ipairs(consumelist)do
local minlv=v[1]
local maxlv=v[2]
local cost=v[3]
if lv>=minlv and lv<=maxlv then
for ii,vv in ipairs(cost)do
local itemid=vv[1]
local num=math.ceil(exp/vv[2])
if needCost[itemid]==nil then needCost[itemid]=0 end
needCost[itemid]=needCost[itemid]+num
end
return true
end
end
return false
end

for i,v in ipairs(temp)do
local lv=v[1]
local exp=v[2]
if not checkCost(lv,exp)then
loggerUtil.logErrFMT('没有找到等级{0}所需消耗的货币配置',lv)
end
end
local cost={}
for k,v in pairs(needCost)do
cost[#cost+1]={k,v}
end
table.sort(cost,function(a,b)return a[1]<b[1]end)
return cost
end

function equipsHelper.isCanJinglianByCostMoney(itemguid,addexp,targetlv)
local costlist=equipsHelper.getJinglianCost(itemguid,addexp,targetlv)
for _,v in ipairs(costlist)do
local moneyType=v[1]
local needMoney=v[2]
if not moneyModel.checkEnoughMoney(moneyType,needMoney)then
return false,moneyType,needMoney
end
end
return true
end


function equipsHelper.returnRonglianItems(item)
local jilianExp=equipsHelper.getJinglianValue(item.itemguid,1)
local itemInfo=cfg_bagualuaconfig_get(1).equip
local itemid=itemInfo[1]
local exp=itemInfo[2]
local num=math.floor(jilianExp/exp)
local jilianItems={{itemid,num}}

local dhcnt=equipsModel:getDianHuaCnt(item)
if dhcnt>0 then
local dhCfg=equipsConfig.getEquipDianHuaCfg(item.itemid)
local cost=dhCfg.costs
jilianItems=table.concatTableXX(jilianItems,cost)
end


local isxmEquip=equipsHelper.getEquipXMTypebyItemid(item.itemid)
if isxmEquip>0 then
jilianItems=equipsModel.returnNingLianItems(item.itemguid,jilianItems)
end

return jilianItems
end


function equipsHelper.checkEquipIsCanJingLian(equipItemguid)
if not equipItemguid then
return false
end

local item=equipsHelper.getEquip(equipItemguid)
if not item then
return false
end

local equipItemid=item.itemid
local itemConfig=itemsConfig.getConfig(equipItemid)
local color=itemConfig.color
local stage=itemConfig.stage

local targetColor=5
local targetStage=2
if stage and stage>=targetStage then
if not color or color<targetColor then

return false
end
end

local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianexp=item.itemData and item.itemData.jinglianexp or 0
local maxlv=equipsConfig.getJinglianMaxLvByItemid(item.itemid)
if jinglianlv>=maxlv then

return false
end

if not equipsHelper.isCanShowJinglian(equipItemguid)then

return false
end


local stageDropIdx=equipsModel:getEquipJingLianDropDownIdx(ITEM_FILTER_TYPE.eStage)
local colorDropIdx=equipsModel:getEquipJingLianDropDownIdx(ITEM_FILTER_TYPE.eColor)
local filterStage=stageDropIdx+1
local filterColor=colorDropIdx+1

local materialsList=equipsHelper.getMateriasOnBag(equipItemguid,filterStage,filterColor,nil,true)or{}
if not materialsList or#materialsList<0 then

return false
end

local equipType=equipsConfig.getEquipType(equipItemid)
local upExp=equipsConfig.getJinglianExp(equipType,jinglianlv,stage)
local needLvUpExp=upExp-jinglianexp
local minNeedExp=5000
local needExp=needLvUpExp>minNeedExp and needLvUpExp or minNeedExp

local sortTag={}

local temp=materialsList
for i,v in ipairs(temp)do
local exp=equipsHelper.getJinglianValue(v.itemguid,1)
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
if totalExp>=needExp then break end
local hasExp=equipsHelper.getJinglianValue(itemguid,1)
local canPutExp=needExp-totalExp
local max=math.floor(canPutExp/hasExp)
local cnt=math.min(max,count)
local remainingCount=count
for j=1,cnt do
if totalExp>=needExp then break end
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

local addLv=equipsHelper.getAddJinglianLv(equipItemid,jinglianlv,jinglianexp,totalExp)
if not equipsHelper.isCanJinglianByCostMoney(equipItemguid,totalExp,jinglianlv+addLv)then

return false
end

return true
end










