
local _strengthenErr=
{

eNotEnoughColor=2,
eLevelToCap=3,
eNotMaterials=4,
eNotEnoughCost=5,
eNotPos=6,
eExpOver_maxLv=7,
eExpOver_break=8,
}
vocEquipHelper.strengthenErr=_strengthenErr

function vocEquipHelper.isCanShowStrengthen(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eVocEquip)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eVocEquip)
UIManager.error(tips)
end
return false
end


return true
end
function vocEquipHelper.isCanContinueStrengthen(itemguid,isOnlyCheckStrengthen,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eVocEquip)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eVocEquip)
UIManager.error(tips)
end
return false
end
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local level=equip.itemData and equip.itemData.enhancelv or 0
local exp=equip.itemData and equip.itemData.enhanceexp or 0
local maxLv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local maxExp=vocEquipHelper.getStrengthenExp(vocId,maxLv)

if maxLv==0 or level>=maxLv then
if warn then
UIManager.error('装备强化等级达到上限')
end
return false,_strengthenErr.eLevelToCap,{level,maxLv,exp,maxExp}
end

if maxLv>(level+1)then

local curMaxExp=vocEquipHelper.getStrengthenExp(vocId,level)
local needExp=curMaxExp-exp
for i=level+1,maxLv-1 do
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,i)
if not isOnlyCheckStrengthen and isBreak then

return true
end
needExp=needExp+vocEquipHelper.getStrengthenExp(vocId,i)
end
if needExp<=0 then
if warn then
UIManager.error('装备强化等级达到上限')
end
return false,_strengthenErr.eLevelToCap,{level,maxLv,exp,maxExp}
end
end
return true
end

function vocEquipHelper.isCanStrengthenByCostMoney(itemguid,addexp)
local costlist=vocEquipHelper.getStrengthenMoneyCost(itemguid,addexp)
for _,v in ipairs(costlist)do
local moneyType=v[1]
local needMoney=v[2]
if not moneyModel.checkEnoughMoney(moneyType,needMoney)then
return false,moneyType,needMoney
end
end
return true
end

function vocEquipHelper.isCanStrengthenBreakByCost(itemguid,level)
local costlist=vocEquipHelper.getStrengthenBreakItemCostByLevel(itemguid,level)
for _,v in ipairs(costlist)do
local costItemId=v[1]
local costItemNeedCount=v[2]
local isEnough
if itemsConfig.isMoney(costItemId)then
isEnough=moneyModel.checkEnoughMoney(costItemId,costItemNeedCount)
else
isEnough=itemsModel.checkItemEnough(costItemId,costItemNeedCount)
end

if not isEnough then
return false,costItemId,costItemNeedCount
end
end
return true
end

function vocEquipHelper.isCanStrengthen(itemguid,addexp,targetlv,warn)
local ret,errType,errArgs=vocEquipHelper.isCanContinueStrengthen(itemguid,true,warn)
if not ret then
return ret,errType,errArgs
end
local ret,moneyType,needMoney=vocEquipHelper.isCanStrengthenByCostMoney(itemguid,addexp,targetlv)
if not ret then
return false,_strengthenErr.eNotEnoughCost,{moneyType,needMoney}
end
return true
end

function vocEquipHelper.isCanStrengthenBreak(itemguid,level,warn)
local ret,errType,errArgs=vocEquipHelper.isCanContinueStrengthen(itemguid,nil,warn)
if not ret then
return ret,errType,errArgs
end

local ret,costItemId,costItemNeedCount=vocEquipHelper.isCanStrengthenBreakByCost(itemguid,level)
if not ret then
return false,_strengthenErr.eNotEnoughCost,{costItemId,costItemNeedCount}
end
return true
end

function vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local maxlv=0

local cfgList=cfgHelper.get(cfg_disciplevocequipenhanceconfig_get,vocId)
if cfgList then
local maxLvCfg=cfgList[#cfgList]
maxlv=maxLvCfg.level
end
return maxlv
end


function vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,nowLevel)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local nextBreakLevel=nowLevel or 0

local cfgList=cfgHelper.get(cfg_disciplevocequipenhanceconfig_get,vocId)
if cfgList and next(cfgList)then
for i=nowLevel,#cfgList do
local lvCfg=cfgList[i]
local level=lvCfg.level
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,level)
if isBreak then
return level
end
nextBreakLevel=level
end
end
return nextBreakLevel
end

function vocEquipHelper.checkStrengthenLvIsBreak(vocId,level)
local cfg=cfgHelper.get(cfg_disciplevocequipenhanceconfig_get,vocId,level)
if cfg then

if cfg.tupo and next(cfg.tupo)then
return true
end
end

return false
end

function vocEquipHelper.getStrengthenConfig(vocId,level)
local cfgList=cfgHelper.get(cfg_disciplevocequipenhanceconfig_get,vocId)
if cfgList then
return cfgList[level]
end
loggerUtil.logErrFMT('没找到职业装备强化表：',vocId,level)
end

function vocEquipHelper.getStrengthenExp(vocId,level)
local cfg=vocEquipHelper.getStrengthenConfig(vocId,level)or{}
local exp=cfg.exp
if exp==nil then
loggerUtil.logErrFMT('没有配置职业id为{0}对应的职业装备{0}级的所需强化经验',vocId,level)
end
return exp or 0
end

function vocEquipHelper.getStrengthenMoneyCost(itemguid,addexp)
local moneyCostList=vocEquipHelper.getStrengthenMoneyCostCfg()
local cost={}
if moneyCostList and next(moneyCostList)then
if addexp<=0 then
for i,v in ipairs(moneyCostList)do
local itemid=v[1]
cost[#cost+1]={itemid,0}
end
table.sort(cost,function(a,b)return a[1]<b[1]end)
return cost
end

local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local enhancelv=equip.itemData and equip.itemData.enhancelv or 0
if enhancelv>=maxlv then return{}end
local enhanceexp=equip.itemData and equip.itemData.enhanceexp or 0

local needCost={}
for i,v in ipairs(moneyCostList)do
local itemid=v[1]
local num=math.ceil(addexp*v[2])
if needCost[itemid]==nil then needCost[itemid]=0 end
needCost[itemid]=needCost[itemid]+num
end

for k,v in pairs(needCost)do
cost[#cost+1]={k,v}
end
table.sort(cost,function(a,b)return a[1]<b[1]end)
end
return cost
end

function vocEquipHelper.getStrengthenBreakItemCostByLevel(itemguid,level)
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)
local cfg=vocEquipHelper.getStrengthenConfig(vocId,level)or{}
return cfg.tupo
end


function vocEquipHelper.getStrengthenConstDefConfig()
local const_def=cfgHelper.getdef(cfg_disciplevocequipenhanceconfig)
return const_def
end


function vocEquipHelper.getStrengthenMoneyCostCfg()
local const_def=vocEquipHelper.getStrengthenConstDefConfig()
return const_def.money
end


function vocEquipHelper.getStrengthenItemList()
local const_def=vocEquipHelper.getStrengthenConstDefConfig()
return const_def.itemexp
end

function vocEquipHelper.getdefaultStrengthenItem()
local const_def=vocEquipHelper.getStrengthenConstDefConfig()
return const_def.itemdefault
end

function vocEquipHelper.getdefaultStrengthenLvResetCost()
local const_def=vocEquipHelper.getStrengthenConstDefConfig()
return const_def.reset
end


function vocEquipHelper.getMateriasOnBag(filterguid,useCache)
if useCache then
local temp=equipsModel:getCacheTempTable_Materials()
local items=vocEquipHelper.getItemsMaterias(filterguid,useCache)
for _,v in ipairs(items)do
temp[#temp+1]=v
end

return temp
else
local items=vocEquipHelper.getItemsMaterias(filterguid,useCache)
return items
end
end


function vocEquipHelper.getItemsMaterias(filterguid,useCache)
local itemlist={}
local list=vocEquipHelper.getStrengthenItemList()
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


function vocEquipHelper.getStrengthenExpValue(itemguid,num)
local const_def=vocEquipHelper.getStrengthenConstDefConfig()
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
if itemsConfig.isItem(itemid)then
local itemexp=const_def.itemexp or{}
local exp=itemexp[itemid]or 0
return num*exp
end
return 0
end


function vocEquipHelper.getStrengthenExpValueToMaxLevelOnItem(item)
local itemid=item.itemid
local maxLv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
return vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(item,maxLv)
end


function vocEquipHelper.getStrengthenExpValueToNextBreakLevelOnItem(item)
local itemid=item.itemid
local enhancelv=item.itemData and item.itemData.enhancelv
local nextBreakLevel=vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,enhancelv)
return vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(item,nextBreakLevel)
end

function vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(item,targetLevel)
local enhancelv=item.itemData and item.itemData.enhancelv
if enhancelv>=targetLevel then
return 0
end

local enhanceexp=item.itemData and item.itemData.enhanceexp
local itemid=item.itemid
local itemguid=item.itemguid
local vocId=vocEquipHelper.getEquipVocId(itemid)
local curMaxExp=vocEquipHelper.getStrengthenExp(vocId,enhancelv)
local needExp=curMaxExp-enhanceexp
for i=enhancelv+1,targetLevel-1 do
needExp=needExp+vocEquipHelper.getStrengthenExp(vocId,i)
end
return needExp
end


function vocEquipHelper.getAddStrengthenLv(itemid,level,exp,addExp)
local itemConfig=itemsConfig.getConfig(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
if maxlv<=level then return 0,addExp,addExp end
local upExp=vocEquipHelper.getStrengthenExp(vocId,level)
local leftExpThisLv=upExp-exp
if addExp<leftExpThisLv then return 0,exp+addExp,0 end
local startLv=level+1
local leftExp=addExp-leftExpThisLv
local addLv=1
for i=startLv,maxlv-1 do
local needExp=vocEquipHelper.getStrengthenExp(vocId,i)
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,i)
if not isBreak and leftExp>=needExp then
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
