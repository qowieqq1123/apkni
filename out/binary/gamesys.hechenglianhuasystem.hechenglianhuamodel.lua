






local _MODULENAME="heChengLianHuaModel"




def_table(_MODULENAME)
heChengLianHuaModel.name=_MODULENAME


heChengLianHuaModel.data={}
local _peifangList={}
local _peifangPageList={}

function heChengLianHuaModel:onAppStart()

end


function heChengLianHuaModel:onEnterState()
self:setTypePeiFang()
end


function heChengLianHuaModel:onLeaveState()

self.data={}
_peifangList={}
_peifangPageList={}
end


function heChengLianHuaModel:onServerDataInitFinish()

end



function heChengLianHuaModel:getHeChengLianList(sortOrder)
local config=cfg_lianqigeconfig()
local list={}
for k,v in pairs(config)do
if k~='const_def'then
table.insert(list,v)
end
end
if sortOrder then
heChengLianHuaModel:sortPeiFangList(list,sortOrder)
end
return list
end

function heChengLianHuaModel:setTypePeiFang()
_peifangList={}
local list=heChengLianHuaModel:getHeChengLianList()
for k,v in ipairs(list)do
local t=_peifangList[v.type]
if t==nil then
t={}
_peifangList[v.type]=t
end
table.insert(t,v)
end

_peifangPageList={}
local config=cfg_lianqigeconfig()
local pageList=config.const_def.pageList
for k,v in ipairs(pageList)do
_peifangPageList[k]=_peifangPageList[k]or{}
for kk,vv in ipairs(v.list)do
_peifangPageList[k][0]=_peifangPageList[k][0]or{}
_peifangPageList[k][kk]=_peifangPageList[k][kk]or{}
local isShowType=self:checkIsShowType(k)
if isShowType then
for kkk,vvv in ipairs(vv.list)do
_peifangPageList[k][0][kkk]=_peifangPageList[k][0][kkk]or{}
_peifangPageList[k][kk][kkk]=_peifangPageList[k][kk][kkk]or{}
for kkkk,vvvv in ipairs(_peifangList[vvv])do
table.insert(_peifangPageList[k][0][kkk],vvvv)
table.insert(_peifangPageList[k][kk][kkk],vvvv)
end
end
else
for kkk,vvv in ipairs(vv.list)do
for kkkk,vvvv in ipairs(_peifangList[vvv])do
table.insert(_peifangPageList[k][0],vvvv)
table.insert(_peifangPageList[k][kk],vvvv)
end
end

end
end
end
end

function heChengLianHuaModel:getPeiFangListByType(pageIdx,index,typeIdx,sortOrder,isIgnoreReddotSort)
local list=_peifangPageList[pageIdx][index]
local isShowType=self:checkIsShowType(pageIdx)
if isShowType then
list=_peifangPageList[pageIdx][index][typeIdx]
end
heChengLianHuaModel:sortPeiFangList(list,sortOrder,isIgnoreReddotSort)
return list
end

function heChengLianHuaModel:getPeiFangListByType_notSort(pageIdx,index,typeIdx)
local list=_peifangPageList[pageIdx][index]
local isShowType=self:checkIsShowType(pageIdx)
if isShowType then
list=_peifangPageList[pageIdx][index][typeIdx]
end
return list
end

function heChengLianHuaModel:checkIsShowType(pageIdx)
local isShowType=pageIdx==2 or pageIdx==3
return isShowType
end

function heChengLianHuaModel:sortPeiFangList(list,sortOrder,isIgnoreReddotSort)
if sortOrder==nil then
sortOrder=eSortOrder.eUp
end

local sortTag={}
for i,v in ipairs(list)do
local isUnlock=heChengLianHuaModel:checkPeiFangUnlock(v)
local unlockTag=isUnlock and-1 or 1
local isCan=heChengLianHuaModel:getIsCan(v)
local cfg=itemsConfig.getConfig(v.itemid)
local stage=cfg.stage and cfg.stage or 0
local canTag=isCan and 0 or 100000
if isIgnoreReddotSort then

canTag=0
end
sortTag[v.id]=unlockTag*1000000+canTag-stage*100+v.id
end
if sortOrder==eSortOrder.eDown then
table.sort(list,function(a,b)return sortTag[a.id]>sortTag[b.id]end)
else
table.sort(list,function(a,b)return sortTag[a.id]<sortTag[b.id]end)
end
return list
end

function heChengLianHuaModel:getIsCan(config,cnt,isTips)
local isUnlock=heChengLianHuaModel:checkPeiFangUnlock(config)
if not isUnlock then
return false
end

local btnStr="合成"
if config.btnText then
btnStr=config.btnText
end
local selectCnt=cnt or 1
local lzcsItemId=10620
local isLzcsHC=false
local lingshiCost,costList=heChengLianHuaModel:getCostList(config)
for i,v in ipairs(costList)do
local matId=v[1]
local need=v[2]*selectCnt
local have=0
if matId==lzcsItemId then
isLzcsHC=true
end
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
elseif itemsConfig.isVocEquip(matId)then
local checkFunc=function(item)
if item.itemflag~=0 then

return false
end
local enhancelv=item.itemData and item.itemData.enhancelv or 0
if enhancelv>0 then

return false
end
return true
end
have=bagControl.invokeFuncByItemId(matId,'getItemCountWithCheckFuncByItemID',matId,checkFunc)
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
if have<need then
if isTips then
UIManager.error(FMT.fmt("材料不足，无法{0}",btnStr))
gainControl:showGainWin(matId,nil,{needCount=need})
end
return false,isLzcsHC
end
end

if lingshiCost then
local haveMoney=moneyModel.getMoney(lingshiCost[1])
local costCnt=lingshiCost[2]*selectCnt
if haveMoney<costCnt then
if isTips then
local name=moneyModel.getMoneyName(lingshiCost[1])
UIManager.error(FMT.fmt("{0}不足，无法{1}",name,btnStr))

gainControl:showGainWin(lingshiCost[1])
end
return false,isLzcsHC
end
end
return true,isLzcsHC
end

function heChengLianHuaModel:getSelectTypeByItemid(pfId)
for i,v in ipairs(_peifangPageList)do
for ii,vv in ipairs(v[0])do
local isShowType=self:checkIsShowType(i)
if isShowType then
for iii,vvv in ipairs(vv)do
if vvv.id==pfId then
return i,ii
end
end
elseif vv.id==pfId then
return i,1
end
end
end
return 1,1
end

function heChengLianHuaModel:getMenuIndexByItemid(itemid)
for i,v in ipairs(_peifangPageList)do
for ii,vv in ipairs(v[0])do
local isShowType=self:checkIsShowType(i)
if isShowType then
for iii,vvv in ipairs(vv)do
if vvv.itemid==itemid then
return i,iii,ii,vvv
end
end
elseif vv.itemid==itemid then
return i,ii,1,vv
end
end
end
return 1,1,1,nil
end

function heChengLianHuaModel:getPFIdByItemid(itemid)
local list=heChengLianHuaModel:getHeChengLianList()
for i,v in ipairs(list)do
if v.itemid==itemid then
return v.id
end
end
return nil
end

function heChengLianHuaModel:getCost(config)
if config.cost then
return config.cost
else
local list={}
local hecheng3=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"hecheng3")
local hecheng2=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"hecheng2")
if config.btnText~=nil then

list[#list+1]={config.itemid+1,1}
else

local nextCfg=itemsConfig.getConfig(config.itemid-1)
local count=0
if nextCfg.level>=hecheng3[1]and nextCfg.level<=hecheng3[2]then
count=3
elseif nextCfg.level>=hecheng2[1]and nextCfg.level<=hecheng2[2]then
count=2
end
list[#list+1]=nextCfg.compound
list[#list+1]={config.itemid-1,count}
end
return list
end
end

function heChengLianHuaModel:getRewards(config)
if config.rewards then
return config.rewards
else
local list={}
local hecheng3=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"hecheng3")
local hecheng2=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"hecheng2")
if config.btnText~=nil then

local cfg=itemsConfig.getConfig(config.itemid)
local count=0
if cfg.level>=hecheng3[1]and cfg.level<=hecheng3[2]then
count=3
elseif cfg.level>=hecheng2[1]and cfg.level<=hecheng2[2]then
count=2
end
list[#list+1]={config.itemid,count}
else

list[#list+1]={config.itemid,1}
end
return list
end
end

function heChengLianHuaModel:getCostList(config)
local lingshiCost
local list={}

local costList=self:getCost(config)
local num=#costList
local startIdx=0
if costList[1][1]==eMoneyType.mtLingShi or costList[1][1]==eMoneyType.mtZhenShi then
lingshiCost=costList[1]
num=num-1
startIdx=1
end
for i=1,num do
local mat=costList[i+startIdx]
list[#list+1]=mat
end
return lingshiCost,list
end

function heChengLianHuaModel:checkPeiFangUnlock(config)
local unLock=false
local requireStr=''
local unLockLimit=config.unlock
local typeName=cfgHelper.get2(cfg_lianqigetypeconfig_get,config.type,'typename')
if unLockLimit==nil then
unLock=true
requireStr=typeName
elseif unLockLimit[1]==1 then
local zongmenLv=zongmenModel:getLevel()
unLock=zongmenLv>=unLockLimit[2]
requireStr=unLock and typeName or FMT.fmt('宗门达到{0}级解锁',unLockLimit[2])
else

end
return unLock,requireStr
end

function heChengLianHuaModel:getMaxLianHuaCount(config)
local costList=self:getCost(config)
local max=config.maxCount
for i,v in ipairs(costList)do
local itemid=v[1]
local need=v[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
elseif itemsConfig.isVocEquip(itemid)then
local checkFunc=function(item)
if item.itemflag~=0 then

return false
end
local enhancelv=item.itemData and item.itemData.enhancelv or 0
if enhancelv>0 then

return false
end
return true
end
have=bagControl.invokeFuncByItemId(itemid,'getItemCountWithCheckFuncByItemID',itemid,checkFunc)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local can=math.floor(have/need)
max=can<max and can or max
end
local count=max>config.maxCount and config.maxCount or max
count=count==0 and 1 or count
return count
end

function heChengLianHuaModel:getItemIdToHCConfigId(itemId)
local config=itemsConfig.getConfig(itemId)
for i,v in ipairs(config.produce)do
if v.hecheng then
return v.hecheng.args[1]
end
end
end


function heChengLianHuaModel:getMaxLianHuaCount_quick(config)
local quickCostList=heChengLianHuaModel:getCrossLevelHeChengCostList(config.id)
local hechengWeight=0
for i,v in ipairs(quickCostList)do
local itemid=v.mainItemCost[1]
local needItemCount=v.mainItemCost[2]
local itemHave=0
if itemsConfig.isVocEquip(itemid)then
local checkFunc=function(item)
if item.itemflag~=0 then

return false
end
local enhancelv=item.itemData and item.itemData.enhancelv or 0
if enhancelv>0 then

return false
end
return true
end
itemHave=bagControl.invokeFuncByItemId(itemid,'getItemCountWithCheckFuncByItemID',itemid,checkFunc)
else
itemHave=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local itemWeight=v.weight/needItemCount
local itemCanWeight=itemHave*itemWeight
local canWeight=itemCanWeight
hechengWeight=hechengWeight+canWeight
end
local count=math.floor(hechengWeight+0.0000001)
count=count>config.maxCount and config.maxCount or count
return count
end


function heChengLianHuaModel:getCrossLevelHeChengCostList(pfId)
local config=cfgHelper.get1(cfg_lianqigeconfig_get,pfId)
local originalCostList=self:getCost(config)
local crossLvCostList=config.cost2
local heChengCostList={}
local moneyCost={}
local mainItemCost={}
if#originalCostList>1 then
local moneyType=originalCostList[1][1]
local moneyCount=originalCostList[1][2]
local itemid=originalCostList[2][1]
local itemCount=originalCostList[2][2]
moneyCost={moneyType,moneyCount}
mainItemCost={itemid,itemCount}
else
moneyCost=nil
local itemid=originalCostList[1][1]
local itemCount=originalCostList[1][2]
mainItemCost={itemid,itemCount}
end
heChengCostList={
{weight=1,moneyCost=moneyCost,mainItemCost=mainItemCost},
}

if crossLvCostList and next(crossLvCostList)then
for _,pfId in ipairs(crossLvCostList)do
local lastCostItem=heChengCostList[#heChengCostList]
local pfCfg=cfgHelper.get1(cfg_lianqigeconfig_get,pfId)
if pfCfg then
local costCfg=pfCfg.cost
local lastMoneyType=lastCostItem.moneyCost and lastCostItem.moneyCost[1]
local lastMoneyCount=lastCostItem.moneyCost and lastCostItem.moneyCost[2]
local lastItemCount=lastCostItem.mainItemCost[2]
local lastPfWight=lastCostItem.weight
local pfWight=lastPfWight/lastItemCount
local crossMoneyCost={}
local crossMainItemCost={}
if#costCfg>1 then
local moneyType=costCfg[1][1]
local moneyCount=costCfg[1][2]
local itemid=costCfg[2][1]
local itemCount=costCfg[2][2]
if lastMoneyType and lastMoneyType==moneyType then
crossMoneyCost={moneyType,moneyCount+lastMoneyCount*pfWight}
else
crossMoneyCost={moneyType,moneyCount}
end
crossMainItemCost={itemid,itemCount}
else
crossMoneyCost=nil
local itemid=costCfg[1][1]
local itemCount=costCfg[1][2]
crossMainItemCost={itemid,itemCount}
end
heChengCostList[#heChengCostList+1]={weight=pfWight,moneyCost=crossMoneyCost,mainItemCost=crossMainItemCost}
end
end
end

return heChengCostList
end


function heChengLianHuaModel:getCrossLevelHeChengCostListByCount(pfId,count)
local heChengCostList=heChengLianHuaModel:getCrossLevelHeChengCostList(pfId)
local moneyCostList={}
local itemCostList={}

local hechengWeight=0
local costList_lookup={}
for i,v in ipairs(heChengCostList)do
local moneyType=v.moneyCost and v.moneyCost[1]
local needMoneyCount=v.moneyCost and v.moneyCost[2]
local itemid=v.mainItemCost[1]
local needItemCount=v.mainItemCost[2]
local itemHave=0
if itemsConfig.isVocEquip(itemid)then
local checkFunc=function(item)
if item.itemflag~=0 then

return false
end
local enhancelv=item.itemData and item.itemData.enhancelv or 0
if enhancelv>0 then

return false
end
return true
end
itemHave=bagControl.invokeFuncByItemId(itemid,'getItemCountWithCheckFuncByItemID',itemid,checkFunc)
else
itemHave=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local itemWeight=v.weight/needItemCount
local itemCanWeight=itemHave*itemWeight
local canWeight=itemCanWeight
local can=itemHave/needItemCount

local originalHeChengWeight=hechengWeight
hechengWeight=hechengWeight+canWeight
local costCount=can
local needBreak=false
if hechengWeight>count then
local deltaWeight=count-originalHeChengWeight
costCount=math.floor(deltaWeight/v.weight+0.0000001)
if originalHeChengWeight+costCount*v.weight<count then
costCount=costCount+1
end
needBreak=true
elseif hechengWeight==count then
needBreak=true
end

if costCount>0 then
if moneyType then
if costList_lookup[moneyType]then
costList_lookup[moneyType]=costList_lookup[moneyType]+costCount*needMoneyCount
else
costList_lookup[moneyType]=costCount*needMoneyCount
end
end
if costList_lookup[itemid]then
costList_lookup[itemid]=costList_lookup[itemid]+costCount*needItemCount
else
costList_lookup[itemid]=costCount*needItemCount
end
end

if needBreak then
break
end
end

if hechengWeight<count then

local deltaWeight=count-hechengWeight
for i,v in ipairs(heChengCostList)do
local moneyType=v.moneyCost and v.moneyCost[1]
local needMoneyCount=v.moneyCost and v.moneyCost[2]
local itemid=v.mainItemCost[1]
local needItemCount=v.mainItemCost[2]
local itemWeight=v.weight/needItemCount
local isBreak=false
local deltaItemCount=math.floor(deltaWeight/itemWeight+0.0000001)
local deltaCount=deltaItemCount/needItemCount
if deltaWeight%itemWeight==0 then
isBreak=true
end
if deltaCount>0 then
if moneyType then
if costList_lookup[moneyType]then
costList_lookup[moneyType]=costList_lookup[moneyType]+deltaCount*needMoneyCount
else
costList_lookup[moneyType]=deltaCount*needMoneyCount
end
end
if costList_lookup[itemid]then
costList_lookup[itemid]=costList_lookup[itemid]+deltaCount*needItemCount
else
costList_lookup[itemid]=deltaCount*needItemCount
end
deltaWeight=deltaWeight-deltaCount*v.weight
end

if isBreak then
break
end
end
end

for itemid,itemcount in pairs(costList_lookup)do
local costItem={itemid,itemcount}
if moneyConfig.isMoney(itemid)then
table.insert(moneyCostList,costItem)
else
table.insert(itemCostList,costItem)
end
end

return moneyCostList,itemCostList
end




