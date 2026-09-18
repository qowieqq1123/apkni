





yunZhouEquipsConfig={}








local attrNameMap={
[1]="弟子军阵攻击",
[2]="弟子军阵防御",
[3]="弟子军阵生命",
}
function yunZhouEquipsConfig.getYunZhouSpecialAttrName(attrType)
return attrNameMap[attrType]
end

function yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
local enhance_limit=cfgHelper.get2(cfg_boatequipbaseconfig_get,1,"enhance_limit")
local itemConfig=itemsConfig.getConfig(itemid)
if not itemConfig then
return
end
local color=itemConfig.color or 0
local stage=itemConfig.stage or 0
local idx=color*10+stage
return enhance_limit[idx]
end


function yunZhouEquipsConfig.getJinglianCostCfg()
local const_def=cfgHelper.get1(cfg_boatequipbaseconfig_get,1)
return const_def.enhance_consume
end


function yunZhouEquipsConfig.getJinglianItemList()
local const_def=cfgHelper.get1(cfg_boatequipbaseconfig_get,1)
return const_def.enhance_item
end


function yunZhouEquipsConfig.getStrengthenExp(equipType,level)
local jinglianConfig=cfgHelper.get1(cfg_boatequipenhanceconfig_get,level)
if jinglianConfig==nil then
loggerUtil.logErrFMT('没有配置装备{0}级的精炼经验',level)
return 0
end
local keyStr=string.format("exp%d",equipType)
if jinglianConfig[keyStr]then
return jinglianConfig[keyStr]
else
loggerUtil.logErrFMT('没有配置装备{0}级 类型为：{1}的精炼经验',level,equipType)
return 0
end
end


function yunZhouEquipsConfig.getStrengthenBaseAttrs(itemid,level)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1

local baseAttrsLookup=equipsHelper.getBaseAttrLookup(itemConfig)
local jinglianConfig=cfgHelper.get1(cfg_boatequipenhanceconfig_get,level)
if jinglianConfig==nil then
return baseAttrsLookup
end
local keyStr=string.format("attr%d",equipType)
local jinglianAttr=jinglianConfig[keyStr]
local attrLookup=jinglianAttr and attrListHelper.tramsformToLookup(jinglianAttr)
local lookup=attrListHelper.concatLookup(baseAttrsLookup,attrLookup)
return lookup
end


function yunZhouEquipsConfig.getJinglianTargetLv(equip,addexp)
if addexp<=0 then return false end
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
if jinglianlv>=maxlv then return false end
local jinglianexp=equip.itemData and equip.itemData.jinglianexp or 0


local fullNeedExp=yunZhouEquipsConfig.getStrengthenExp(equipType,jinglianlv)
local addlvExp=math.min(fullNeedExp-jinglianexp,addexp)
local leftExp=addexp-addlvExp
local temp={}
local targetlv=jinglianlv
for i=jinglianlv+1,maxlv-1 do
local lv=i
if leftExp>0 then
local needExp=yunZhouEquipsConfig.getStrengthenExp(equipType,i)
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


function yunZhouEquipsConfig.getJinglianCost(equip,addexp,targetlv)
if addexp<=0 then return{{5,0}}end
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
targetlv=targetlv or jinglianlv
if jinglianlv>=maxlv then return{}end
local jinglianexp=equip.itemData and equip.itemData.jinglianexp or 0


local fullNeedExp=yunZhouEquipsConfig.getStrengthenExp(equipType,jinglianlv)
local addlvExp=math.min(fullNeedExp-jinglianexp,addexp)
local leftExp=addexp-addlvExp
local temp={}
temp[#temp+1]={jinglianlv,addlvExp}

if jinglianlv<targetlv then
for i=jinglianlv+1,targetlv do
local lv=i
if lv<maxlv and leftExp>0 then
local needExp=yunZhouEquipsConfig.getStrengthenExp(equipType,i)
local addlvExp=math.min(needExp,leftExp)
temp[#temp+1]={lv,addlvExp}
leftExp=leftExp-addlvExp
else
break
end
end
end

local needCost={}
local consumelist=yunZhouEquipsConfig.getJinglianCostCfg()
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
loggerUtil.logErrFMT('【云舟阵器强化】没有找到等级{0}所需消耗的货币配置',lv)
end
end
local cost={}
for k,v in pairs(needCost)do
cost[#cost+1]={k,v}
end
table.sort(cost,function(a,b)return a[1]<b[1]end)
return cost
end


function yunZhouEquipsConfig.getItemsMaterias(filterguid,filterColor,useCache)
local itemlist={}
local list=yunZhouEquipsConfig.getJinglianItemList()
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


function yunZhouEquipsConfig.getEquipsMaterias(filterguid,filterStage,filterColor,lockEquip,sort,useCache)
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
end
return bagControl.getBagItemsByFilter(BAG_TYPE.eYunZhou,filter,sort,useCache)
end



function yunZhouEquipsConfig.getMateriasOnBag(filterguid,filterStage,filterColor,filterlockEquip,useCache)
if useCache then
local temp=equipsModel:getCacheTempTable_Materials()
local items=yunZhouEquipsConfig.getItemsMaterias(filterguid,filterColor,useCache)
for _,v in ipairs(items)do
temp[#temp+1]=v
end







return temp
else
local items=yunZhouEquipsConfig.getItemsMaterias(filterguid,filterColor,useCache)


return items
end
end


function yunZhouEquipsConfig.getAddJinglianLv(itemid,level,exp,addExp)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
if maxlv<=level then return 0,addExp,addExp end
local upExp=yunZhouEquipsConfig.getStrengthenExp(equipType,level)
local leftExpThisLv=upExp-exp
if addExp<leftExpThisLv then return 0,exp+addExp,0 end
local startLv=level+1
local leftExp=addExp-leftExpThisLv
local addLv=1
for i=startLv,maxlv-1 do
local needExp=yunZhouEquipsConfig.getStrengthenExp(equipType,i)
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


function yunZhouEquipsConfig.getJinglianValue(equip,num)
local const_def=cfgHelper.get1(cfg_boatequipbaseconfig_get,1)
local itemid=equip.itemid
if itemsConfig.isItem(itemid)then
local itemexp=const_def.enhance_item or{}
local exp=itemexp[itemid]or 0
return num*exp
elseif itemsConfig.isYunZhouComponents(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianConfig=cfgHelper.get1(cfg_boatequipenhanceconfig_get,jinglianlv)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
local keyStr=string.format("lv_exp%d",equipType)
local jinglianlv_exp=jinglianConfig[keyStr]or 0
local base_exp=itemConfig.jinglian_exp
local jinglianexp=equip.itemData and equip.itemData.jinglianexp or 0
local total_exp=jinglianlv_exp+jinglianexp+base_exp
return total_exp
end
return 0
end


function yunZhouEquipsConfig.getJinglianValueToMaxLevelOnItem(item)
local itemid=item.itemid
local maxLv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
return yunZhouEquipsConfig.getJinglianValueToTargetLevelOnItem(item,maxLv)
end


function yunZhouEquipsConfig.getJinglianValueToTargetLevelOnItem(item,targetLevel)
local jinglianlv=item.itemData and item.itemData.jinglianlv
if jinglianlv>=targetLevel then
return 0
end
local jinglianexp=item.itemData and item.itemData.jinglianexp
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
local curMaxExp=yunZhouEquipsConfig.getStrengthenExp(equipType,jinglianlv)
local needExp=curMaxExp-jinglianexp
for i=jinglianlv+1,targetLevel-1 do
needExp=needExp+yunZhouEquipsConfig.getStrengthenExp(equipType,i)
end
return needExp
end

function yunZhouEquipsConfig.isCanJinglianByCostMoney(item,addexp,targetlv)
local costlist=yunZhouEquipsConfig.getJinglianCost(item,addexp,targetlv)
for _,v in ipairs(costlist)do
local moneyType=v[1]
local needMoney=v[2]
if not moneyModel.checkEnoughMoney(moneyType,needMoney)then
return false,moneyType,needMoney
end
end
return true
end


function yunZhouEquipsConfig.checkEquipIsCanJingLian(item)
if not item then
return false
end

local equipItemguid=item.itemguid
local equipItemid=item.itemid
local itemConfig=itemsConfig.getConfig(equipItemid)
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianexp=item.itemData and item.itemData.jinglianexp or 0
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(item.itemid)
if jinglianlv>=maxlv then

return false
end







local materialsList=yunZhouEquipsConfig.getMateriasOnBag(equipItemguid,nil,nil,true,true)or{}
if not materialsList or#materialsList<0 then

return false
end

local equipType=itemConfig.type1
local upExp=yunZhouEquipsConfig.getStrengthenExp(equipType,jinglianlv)
local needExp=upExp-jinglianexp

local sortTag={}

local temp=materialsList
for i,v in ipairs(temp)do
local tempItem=bagModel.getItem(v.itemguid)
local exp=yunZhouEquipsConfig.getJinglianValue(tempItem,1)
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
local tempItem=bagModel.getItem(itemguid)
local hasExp=yunZhouEquipsConfig.getJinglianValue(tempItem,1)
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

local addLv=yunZhouEquipsConfig.getAddJinglianLv(equipItemid,jinglianlv,jinglianexp,totalExp)
if not yunZhouEquipsConfig.isCanJinglianByCostMoney(item,totalExp,jinglianlv+addLv)then

return false
end

return true
end


function yunZhouEquipsConfig.getEquipMaxStar(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local colorMaxStar=cfgHelper.get2(cfg_boatequipbaseconfig_get,1,"colorMaxStar")
return colorMaxStar[color]or 0
end


function yunZhouEquipsConfig.checkEquipQuickCompose(itemid,itemnum)
local cost=0
local count=0
local flag,cost=yunZhouEquipsConfig.quickComposeFunc(itemid,itemnum or 1,0,0)
return flag,cost
end

function yunZhouEquipsConfig.quickComposeFunc(target_itemid,target_need_num,cost,count)
count=count+1
if count>1000 then
logErr("count > 1000")
return false
end
local quick_make_list=cfgHelper.get2(cfg_boatequipmakeconfig_get,target_itemid,"quick_make_list")
if not quick_make_list then
return false
end
local quick_make_itemid=quick_make_list[1]
if not quick_make_itemid then
return false
end
local quick_make_itemid_config=cfgHelper.get1(cfg_boatequipmakeconfig_get,quick_make_itemid)
local need_item_num=(quick_make_itemid_config.exitem_num+1)*target_need_num
local all,bind=yunZhouBagModel:getItemCountByItemID(quick_make_itemid)
local itemNum=all-bind
cost=cost+(target_need_num*quick_make_itemid_config.consume[1][2])
if itemNum>=need_item_num then
return true,cost
end
local need_num=need_item_num-itemNum
return yunZhouEquipsConfig.quickComposeFunc(quick_make_itemid,need_num,cost,count)
end


function yunZhouEquipsConfig.checkEquipComposeBetter(mainItemid)
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,mainItemid)
if not cfg then
return false
end
local item=yunZhouBagModel:getItemByItemID(mainItemid)
if not item then
return false
end
local consume=cfg.consume or{}
for i,v in ipairs(consume)do
local itemid=v[1]
local cost=v[2]
local has=itemsModel.getCount(itemid)
if has<cost then
return false
end
end
local needitem=cfg.needitem or{}
for i,v in ipairs(needitem)do
local itemid=v[1]
local cost=v[2]
local has=itemsModel.getCount(itemid)
if has<cost then
return false
end
end
local exitem_num=cfg.exitem_num
if exitem_num>0 then
local exitem_map=cfg.exitem_map
local hasNum=0
for itemid,_ in pairs(exitem_map)do
local all,bind=yunZhouBagModel:getItemCountByItemID(itemid)
local itemNum=all-bind
hasNum=hasNum+itemNum
end
if exitem_num>hasNum then
return false
end
end
return true,item.itemguid
end