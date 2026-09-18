






local _MODULENAME="yunjiayingModel"


def_table(_MODULENAME)
yunjiayingModel.name=_MODULENAME
yunjiayingModel.data={}

function yunjiayingModel:onAppStart()

end


function yunjiayingModel:onEnterState(isReconnect)

end


function yunjiayingModel:onProtocolReq()

end


function yunjiayingModel:onLeaveState(isReconnect)

self.data={}
end



function yunjiayingModel:initYunJiaYingData(moneyNum,rechargeNum,beginTime,len,trainList)
self.data.moneyNum=moneyNum
self.data.rechargeNum=rechargeNum
self.data.beginTime=beginTime
self:setTrainList(len,trainList)
self:initTrainListTime()
end


function yunjiayingModel:setTrainList(len,trainList)
local list={}
if len and len>0 then
for i,v in ipairs(trainList)do
local idx=i
local startId=v.param_1
local targetId=v.param_2
local trainCount=v.param_3
list[#list+1]={
idx=idx,
startId=startId,
targetId=targetId,
trainCount=trainCount,
}
end
end
self.data.trainList=list
end


function yunjiayingModel:initTrainListTime()
if not self.data or not self.data.trainList or not next(self.data.trainList)then
return
end

local tmpStamp=yunjiayingModel:getTrainBeginTime()or 0
for _,v in ipairs(self.data.trainList)do
local idx=v.idx
local startId=v.startId
local targetId=v.targetId
local trainCount=v.trainCount
local needTime=yunjiayingModel:getTrainNeedTime(startId,targetId,trainCount)
v.needTime=needTime
v.startTime=tmpStamp
v.finishTime=tmpStamp+needTime
tmpStamp=tmpStamp+needTime
end
end


function yunjiayingModel:getTrainList()
if self.data and self.data.trainList then
return self.data.trainList
end

return nil
end


function yunjiayingModel:removeTrainByIdx(idx)
if not self.data or not self.data.trainList or not next(self.data.trainList)then
return
end

table.remove(self.data.trainList,idx)
end


function yunjiayingModel:getTrainBeginTime()
if self.data then
return self.data.beginTime
end

return nil
end


function yunjiayingModel:setTrainBeginTime(time)
if not self.data then
return
end

self.data.beginTime=time
end


function yunjiayingModel:setMoneyNum(moneyNum)
self.data.moneyNum=moneyNum
end


function yunjiayingModel:getMoneyNum()
if self.data and self.data.moneyNum then
return self.data.moneyNum
end

return 0
end


function yunjiayingModel:setRechargeNum(rechargeNum)
self.data.rechargeNum=rechargeNum
end


function yunjiayingModel:getRechargeNum()
if self.data and self.data.rechargeNum then
return self.data.rechargeNum
end

return 0
end



function yunjiayingModel:getTrainDataByLevelIdx(levelIdx,checkType)
if not self.data or not self.data.trainList or not next(self.data.trainList)then
return nil
end

for i,v in ipairs(self.data.trainList)do
if not checkType then
if v.startId==0 and levelIdx==v.targetId or levelIdx==v.startId then
return v
end
elseif checkType==1 then
if v.startId==0 and levelIdx==v.targetId then
return v
end
elseif checkType==2 then
if v.startId~=0 and levelIdx==v.startId then
return v
end
end
end

return nil
end



function yunjiayingModel:getTrainDataByTrainDataIdx(idx,checkLevelIdx)
if not self.data or not self.data.trainList or not next(self.data.trainList)then
return nil
end

if self.data.trainList[idx]and checkLevelIdx then
local trainData=self.data.trainList[idx]
if trainData.startId==0 and checkLevelIdx==trainData.targetId or checkLevelIdx==trainData.startId then
return trainData
else
return nil
end
end

return self.data.trainList[idx]
end


function yunjiayingModel:getTrainingDataTimeByIdx(idx)
if not self.data or not self.data.trainList or not next(self.data.trainList)then
return nil
end

if self.data.trainList[idx]then
local data=self.data.trainList[idx]
local startTime=data.startTime
local finishTime=data.finishTime
return startTime,finishTime
end

return nil
end


function yunjiayingModel:getTrainNeedTime(startId,targetId,count)

local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not buildLv or buildLv<=0 then
return nil
end

local allTime
local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg and buildCfg.duration then
local durationList=buildCfg.duration
local allSingleTime=0
local startLevelCostTime=0
local targetLevelCostTime=0
if startId>0 then
startLevelCostTime=durationList[startId]or 0
end

if targetId>0 then
targetLevelCostTime=durationList[targetId]or 0
end
allSingleTime=targetLevelCostTime-startLevelCostTime







local addRate=self:getTrainAddRate()











allTime=allSingleTime/(1+addRate/100)*count

allTime=math.ceil(allTime)
end

return allTime
end

function yunjiayingModel:getTrainAddRate()
local addRate=0
local value=xianjieModel:getJZAttrLookup(eAttributeType.eXL_Speed)or 0
if value and value>0 then
addRate=addRate+value/100
end
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(1)
if value2 and value2>0 then
addRate=addRate+value2/100
end

self.data.lastAddRate=addRate
return addRate
end

function yunjiayingModel:getTrainLastAddRate()
return self.data and self.data.lastAddRate or 0
end


function yunjiayingModel:getTrainNeedCost(startId,targetId,count,needSort)

local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not buildLv or buildLv<=0 then
return nil
end

local allCostList={}
local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg and buildCfg.consume then
local allCostCfgList=buildCfg.consume
local allCostList_lookup={}
if startId>0 then
local costList=allCostCfgList[startId]
for i,v in ipairs(costList)do
local itemId=v[1]
local itemCount=v[2]
if allCostList_lookup[itemId]then
allCostList_lookup[itemId]=allCostList_lookup[itemId]-itemCount
else
allCostList_lookup[itemId]=-itemCount
end
end
end

if targetId>0 then
local costList=allCostCfgList[targetId]
for i,v in ipairs(costList)do
local itemId=v[1]
local itemCount=v[2]
if allCostList_lookup[itemId]then
allCostList_lookup[itemId]=allCostList_lookup[itemId]+itemCount
else
allCostList_lookup[itemId]=itemCount
end
end
end

for itemId,itemCount in pairs(allCostList_lookup)do
if itemCount>0 then
local finalItemCount=itemCount*count
allCostList[#allCostList+1]={itemId,finalItemCount}
else



end
end

if needSort and next(allCostList)~=nil then
table.sort(allCostList,function(a,b)
local itemId_a=a[1]
local itemId_b=b[1]
local itemColor_a=itemsConfig.getItemColor(itemId_a)
local itemColor_b=itemsConfig.getItemColor(itemId_b)
if itemColor_a==itemColor_b then
return itemId_a<itemId_b
else
return itemColor_a>itemColor_b
end
end)
end
end

return allCostList
end


function yunjiayingModel:getTrainMaxCount()
local initCount=cfgHelper.getdef(cfg_yunjiayingconfig,'init')or 0
local moneyList=cfgHelper.getdef(cfg_yunjiayingconfig,'money')or{}
local moneyCount=#moneyList
local rechargeList=cfgHelper.getdef(cfg_yunjiayingconfig,'recharge')or{}
local rechargeCount=#rechargeList
local maxCount=initCount+moneyCount+rechargeCount

return maxCount
end


function yunjiayingModel:getCanTrainCount()
local initCount=cfgHelper.getdef(cfg_yunjiayingconfig,'init')or 0
local moneyNum=yunjiayingModel:getMoneyNum()
local rechargeNum=yunjiayingModel:getRechargeNum()
local canTrainCount=initCount+moneyNum+rechargeNum
return canTrainCount
end


function yunjiayingModel:getFreeTrainCount()
local canTrainCount=yunjiayingModel:getCanTrainCount()
local trainList=yunjiayingModel:getTrainList()or{}
local trainingCount=#trainList
local freeCount=canTrainCount-trainingCount
return freeCount
end


function yunjiayingModel:checkHasFinishTrain()
local beginTime=yunjiayingModel:getTrainBeginTime()
local trainList=yunjiayingModel:getTrainList()
if beginTime and beginTime>0 and trainList and next(trainList)~=nil then
local nowTime=timeHelper.getServerShortTime()
for i,trainData in ipairs(trainList)do
local finishTime=trainData.finishTime
if nowTime>=finishTime then
return true
end
end
end
return false
end


function yunjiayingModel:checkHasQiuZhu()
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,6)
if not canQiuZhu then
return false
end
local beginTime=yunjiayingModel:getTrainBeginTime()
local trainList=yunjiayingModel:getTrainList()
if beginTime and beginTime>0 and trainList and next(trainList)~=nil then
local nowTime=timeHelper.getServerShortTime()
for i,trainData in ipairs(trainList)do
local finishTime=trainData.finishTime
if nowTime<finishTime then
local startId=trainData.startId
local targetId=trainData.targetId
if startId>0 then
return true,startId
end
if targetId>0 then
return true,targetId
end
return true,1
end
end
end
return false
end


function yunjiayingModel:checkHasGotTrain()
local beginTime=yunjiayingModel:getTrainBeginTime()
local trainList=yunjiayingModel:getTrainList()
if beginTime and beginTime>0 and trainList and next(trainList)~=nil then
local nowTime=timeHelper.getServerShortTime()
for i,trainData in ipairs(trainList)do
local startTime=trainData.startTime
local startId=trainData.startId
local targetId=trainData.targetId
local needTime=yunjiayingModel:getTrainNeedTime(startId,targetId,1)
if nowTime>=startTime+needTime then
return true
end
end
end
return false
end





function yunjiayingModel:getSoldierCount(checkHurtType,extraSoldierList,usedSoldierList,minSoldierIdx)
local allSoldierCount=0
local soldierCfgList=cfg_fairylandsoldierconfig()
local soldierCountList_lookup={}
for soldierId,soldierCfg in ipairs(soldierCfgList)do
if not minSoldierIdx or soldierId>=minSoldierIdx then
local soldierMoneyIdList=soldierCfg.money or{}
for hurtType,moneyId in ipairs(soldierMoneyIdList)do
local isInsert=false
if checkHurtType then
if hurtType==checkHurtType then
isInsert=true
end
else
local ignoreHurtType=xjSoldierHurtType.eSlightInjury
if hurtType~=ignoreHurtType then
isInsert=true
end
end

if isInsert then
local hasCount=itemsModel.getCount(moneyId)
allSoldierCount=allSoldierCount+hasCount
if not soldierCountList_lookup[soldierId]then
soldierCountList_lookup[soldierId]=hasCount
else
soldierCountList_lookup[soldierId]=soldierCountList_lookup[soldierId]+hasCount
end
end
end


if extraSoldierList and extraSoldierList[soldierId]then
local extraCount=extraSoldierList[soldierId]
allSoldierCount=allSoldierCount+extraCount
if not soldierCountList_lookup[soldierId]then
soldierCountList_lookup[soldierId]=extraCount
else
soldierCountList_lookup[soldierId]=soldierCountList_lookup[soldierId]+extraCount
end
end


if usedSoldierList and usedSoldierList[soldierId]then
local usedCount=usedSoldierList[soldierId]or 0
allSoldierCount=math.max(0,allSoldierCount-usedCount)
if soldierCountList_lookup[soldierId]then
soldierCountList_lookup[soldierId]=math.max(0,soldierCountList_lookup[soldierId]-usedCount)
end
end
else
soldierCountList_lookup[soldierId]=0
end
end
return soldierCountList_lookup,allSoldierCount
end




function yunjiayingModel:getSoldierCountEx(soldierList,usedSoldierList,minSoldierIdx)
local allSoldierCount=0
local soldierCfgList=cfg_fairylandsoldierconfig()
local soldierCountList_lookup={}
for soldierId,soldierCfg in ipairs(soldierCfgList)do
if not minSoldierIdx or soldierId>=minSoldierIdx then
local hasCount=soldierList[soldierId]or 0
allSoldierCount=allSoldierCount+hasCount
if not soldierCountList_lookup[soldierId]then
soldierCountList_lookup[soldierId]=hasCount
else
soldierCountList_lookup[soldierId]=soldierCountList_lookup[soldierId]+hasCount
end


if usedSoldierList and usedSoldierList[soldierId]then
local usedCount=usedSoldierList[soldierId]or 0
allSoldierCount=math.max(0,allSoldierCount-usedCount)
if soldierCountList_lookup[soldierId]then
soldierCountList_lookup[soldierId]=math.max(0,soldierCountList_lookup[soldierId]-usedCount)
end
end
else
soldierCountList_lookup[soldierId]=0
end
end
return soldierCountList_lookup,allSoldierCount
end


function yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
local soldierCountList_lookup={}
local allSoldierCount=0

local teamInfoList=xianjieModel:getOnlyWaiPaiTeamInfo()
for i,data in ipairs(teamInfoList)do
local moneyListLen=data.moneylistlen
local moneyList=data.moneyList
if moneyListLen>0 then
for _,v in ipairs(moneyList)do
local moneyType=v.param_1
local moneyCount=v.param_2
local soldierId=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if soldierCountList_lookup[soldierId]then
soldierCountList_lookup[soldierId]=soldierCountList_lookup[soldierId]+moneyCount
else
soldierCountList_lookup[soldierId]=moneyCount
end
allSoldierCount=allSoldierCount+moneyCount
end
end
end

return soldierCountList_lookup,allSoldierCount
end


function yunjiayingModel:getBreakingSoldierCount()
local breakingSoldierCount=0

local trainDataList=yunjiayingModel:getTrainList()or{}
for _,trainingData in ipairs(trainDataList)do
local isBreak=trainingData.startId>0
if isBreak then
local count=trainingData.trainCount
breakingSoldierCount=breakingSoldierCount+count
end
end

return breakingSoldierCount
end


function yunjiayingModel:getAllSoldierCountShow()
local soldierCountList,allMoneyCount=yunjiayingModel:getSoldierCount()
local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
local breakingSoldierCount=yunjiayingModel:getBreakingSoldierCount()
local allShowCount=allMoneyCount+waiPaiAllSoldierCount+breakingSoldierCount
return allShowCount
end


function yunjiayingModel:getTrainingSoldierCount()
local allTrainingSoldierCount=0
local trainList=yunjiayingModel:getTrainList()or{}
for i,trainData in ipairs(trainList)do
local count=trainData.trainCount
allTrainingSoldierCount=allTrainingSoldierCount+count
end
return allTrainingSoldierCount
end


function yunjiayingModel:getMaxTrainingSoldierCount()
local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not buildLv or buildLv<=0 then
return 0
end

local maxCount=0
local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg then
local cfgMaxCount=buildCfg.train
local addTrainCount=0
local ydtParam=yandaotaiModel:getAddrateDatasByEffectId(4)
if ydtParam and ydtParam[1]then
addTrainCount=addTrainCount+ydtParam[1]
end
maxCount=cfgMaxCount+addTrainCount
end
return maxCount
end


function yunjiayingModel:getXsjSoldierCount()
return LittleWorldModel:getLittleWorldPopulation()or 0
end


function yunjiayingModel:getXiuShiNumById(selectLevelIdx)
return LittleWorldModel:getXiuShiNumById(selectLevelIdx+1)or 0
end



function yunjiayingModel:getTrainMaxBreakLevel(buildLv)

if not buildLv then
buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
end
if not buildLv or buildLv<=0 then
return nil
end

local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg and buildCfg.duration then
local timeList=buildCfg.duration
local maxLevelIdx=#timeList
return maxLevelIdx
end

return 0
end


function yunjiayingModel:getTrainMinCanBreakLevel(buildLv)
local nowMaxLevelIdx=self:getTrainMaxBreakLevel(buildLv)
for levelIdx=1,nowMaxLevelIdx do
local isCanBreak=self:checkSoldierCanBreak(levelIdx,buildLv)
if isCanBreak then

return levelIdx
end
end


return nowMaxLevelIdx
end

function yunjiayingModel:setTrainSpeedUpTime(time)
local beginTime=self:getTrainBeginTime()
local newTime=beginTime-time
self:setTrainBeginTime(newTime)
self:initTrainListTime()
end


function yunjiayingModel:checkSoldierCanBreak(levelIdx,buildLv)
if not buildLv then
buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
end

if not buildLv or buildLv<=0 then
return false
end
local maxBreakLevelIdx=yunjiayingModel:getTrainMaxBreakLevel(buildLv)
if levelIdx>=maxBreakLevelIdx then
return false
end

local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg then

local soldierCountList,allMoneyCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy)
local soldierCount=soldierCountList and soldierCountList[levelIdx]or 0

if soldierCount>0 then
local freeCount=yunjiayingModel:getFreeTrainCount()
if freeCount and freeCount>0 then
return true
end
end
end

return false
end


function yunjiayingModel:getSoldierUnlockBuildLevel(levelIdx)
local unlockBuildLevelList_lookup=self:getUnlockBuildLevelList()
return unlockBuildLevelList_lookup[levelIdx]
end

function yunjiayingModel:getUnlockBuildLevelList()
if self.unlockBdLvList_lookup then
return self.unlockBdLvList_lookup
end

local list={}
local buildAllCfg=cfg_yunjiayingconfig()
for bdLv,buildCfg in ipairs(buildAllCfg)do
if buildCfg.duration then
local timeList=buildCfg.duration
local maxLevelIdx=#timeList
if not list[maxLevelIdx]then
list[maxLevelIdx]=bdLv
elseif bdLv<list[maxLevelIdx]then
list[maxLevelIdx]=bdLv
end
end
end
self.unlockBdLvList_lookup=list
return self.unlockBdLvList_lookup
end


function yunjiayingModel:getMaxCanMakeSoldierCount()
local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not buildLv or buildLv<=0 then
return 0
end

local maxCount=0
local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg then
local cfgMaxCount=buildCfg.max
local addMaxCount=0






maxCount=cfgMaxCount+addMaxCount
end
return maxCount
end


function yunjiayingModel:getRemainingCanMakeSoldierCount()
local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not buildLv or buildLv<=0 then
return 0
end

local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
if buildCfg then

local soldierCountList,allMoneyCount=yunjiayingModel:getSoldierCount()
local maxCount=self:getMaxCanMakeSoldierCount()
local trainingSoldierCount=yunjiayingModel:getTrainingSoldierCount()
local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
local remainingCount=maxCount-allMoneyCount-trainingSoldierCount-waiPaiAllSoldierCount
if remainingCount<0 then
remainingCount=0
end

return remainingCount
end

return 0
end


function yunjiayingModel:getTrainMaxEnoughCostCount(startId,targetId)

local costList=self:getTrainNeedCost(startId,targetId,1)
local maxCount
for i,item in ipairs(costList)do
local itemId=item[1]
local itemCount=item[2]
local hasCount=itemsModel.getCount(itemId)
if hasCount<itemCount then
return 0
else
local canSelectCount=math.floor(hasCount/itemCount)
if not maxCount or canSelectCount<maxCount then
maxCount=canSelectCount
end
end
end

return maxCount or 0
end


function yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if self.soldierLevelLookup then
return self.soldierLevelLookup[moneyType]
end
local soldierCfgList=cfg_fairylandsoldierconfig()
local soldierLevelLookup={}
for soldierId,soldierCfg in ipairs(soldierCfgList)do
local soldierMoneyIdList=soldierCfg.money or{}
for hurtType,moneyId in ipairs(soldierMoneyIdList)do
soldierLevelLookup[moneyId]=soldierId
end
end
self.soldierLevelLookup=soldierLevelLookup
return self.soldierLevelLookup[moneyType]
end


function yunjiayingModel:getFrotSoldierFightValue()
local totlefortfight=0

local extraSoldierList=xianjieModel:getWaiPaiSoldierList()
local soldierCountList,allMoneyCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,extraSoldierList)
for soldierId,count in pairs(soldierCountList)do
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierId)
totlefortfight=totlefortfight+count*(levelCfg.fortfight or 0)
end
return totlefortfight
end


function yunjiayingModel:getAllTrainFinalFinishTime()
local beginTime=yunjiayingModel:getTrainBeginTime()
local trainList=yunjiayingModel:getTrainList()
if beginTime and beginTime>0 and trainList and next(trainList)~=nil then
local _,finalFinishTime=yunjiayingModel:getTrainingDataTimeByIdx(#trainList)
return finalFinishTime
end
return 0
end


function yunjiayingModel:getAllTrainLeftTime()
local nowTime=timeHelper.getServerShortTime()
local finalFinishTime=self:getAllTrainFinalFinishTime()

return finalFinishTime-nowTime
end


function yunjiayingModel:checkHasFinishTrain()
local trainList=yunjiayingModel:getTrainList()
if trainList and trainList[1]then
return true
end
return false
end


function yunjiayingModel:getFreeTrainIndex()
local trainList=yunjiayingModel:getTrainList()
if trainList then
local TrainMax=yunjiayingModel:getTrainMaxCount()
local CanTrainCount=yunjiayingModel:getCanTrainCount()
for i=1,TrainMax do
if not trainList[i]and i<=CanTrainCount then
return i
end
end
end
return 1
end

function yunjiayingModel:getActiveXianGuan()
local xgList=cfgHelper.get2(cfg_yunjiayingbaseconfig_get,1,"xianguan")
local index=nil
if xgList then
local myJobInfos=xianguanModel:getSelfJobList()
for i,v in ipairs(xgList)do
local job=v[1]
local privilege=v[2]


if myJobInfos[job]and xianguanHelper.checkTeQuanPlatformLimit(privilege)and xianguanHelper.checkSpecialUseCondition(job,privilege,false)then
index=i
break
end
end
end
return index
end


function yunjiayingModel:checkYunJiaYingBdHasFreeReddot()

local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not bdData then
return false
end

if bdData.flag==buildingStateType.eUpgrading then

return false
end









local trainList=yunjiayingModel:getTrainList()
local trainingCount=trainList and#trainList or 0
if trainingCount>0 then
return false
end

local levelCfgList=cfg_fairylandsoldierconfig()
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()
local checkCostEnoughtFunc=function(costList)
if costList and next(costList)then
for i,v in ipairs(costList)do
local itemid=v[1]
local itemCount=v[2]
local hasCount=itemsModel.getCount(itemid)
if hasCount<itemCount then
return false
end
end
end
return true
end


local remainingCount=yunjiayingModel:getRemainingCanMakeSoldierCount()
if remainingCount>0 then

local cfg=levelCfgList[1]
local solderId=cfg.id
local costList=yunjiayingModel:getTrainNeedCost(0,solderId,maxTrainCount,true)
local isEnough=checkCostEnoughtFunc(costList)
if isEnough then
return true
end
end


local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local soldierCountList,allMoneyCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy)
for i,cfg in ipairs(levelCfgList)do
local solderId=cfg.id
if solderId>=nowMaxLevelIdx then

break
end

if not cfg.isHide then

local soldierCount=soldierCountList and soldierCountList[solderId]or 0
if soldierCount>0 then
local costList=yunjiayingModel:getTrainNeedCost(solderId,nowMaxLevelIdx,maxTrainCount,true)

local isEnough=checkCostEnoughtFunc(costList)
if isEnough then
return true
end
end
end
end


return false
end


function yunjiayingModel:checkYunJiaYingBdAllFinishReddot()

local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not bdData then
return false
end


local trainList=yunjiayingModel:getTrainList()
local trainingCount=trainList and#trainList or 0
if trainingCount<=0 then
return false
end


local leftTime=yunjiayingModel:getAllTrainLeftTime()
if leftTime<=0 then
return true
end

return false
end
