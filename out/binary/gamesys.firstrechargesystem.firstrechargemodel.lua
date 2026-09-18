











firstRechargeModel={}




firstRechargeModel.data={}

function firstRechargeModel:onAppStart()

end


function firstRechargeModel:onEnterState()
self.data.firstRechargeInfo={}
self.data.firstRechargeSortCfg={}
self.data.firstRechargeShowTabList={}
self.data.firstRechargeShowTabList_lookup={}

firstRechargeModel:initSortCfgList()
end


function firstRechargeModel:onLeaveState()

self.data={}
end


function firstRechargeModel:onServerDataInitFinish()

end




function firstRechargeModel:setFirstRechargeData(len,frList)
self.data.firstRechargeInfoLen=len
if len and len>0 then
for k,v in pairs(frList)do
self.data.firstRechargeInfo[v.recharge_id]=v
end
end
end


function firstRechargeModel:setFirstRechargeGotReward(rechargeId,day)
if self.data.firstRechargeInfo[rechargeId]then
if not self.data.firstRechargeInfo[rechargeId].commData then
self.data.firstRechargeInfo[rechargeId].commData={}
end

local isSet=false
for k,v in pairs(self.data.firstRechargeInfo[rechargeId].commData)do
if v.param_1==day then
self.data.firstRechargeInfo[rechargeId].commData[k]={param_1=day,param_2=1}
isSet=true
break
end
end

if not isSet then
table.insert(self.data.firstRechargeInfo[rechargeId].commData,{param_1=day,param_2=1})
end
pfwindowslController:checkHaoPingReward_Shouchong()
else
logErr("未接收到充值数据的情况下领取奖励")
end
end


function firstRechargeModel:setFirstRechargeBuyTime(rechargeId,rechargeSec)
if self.data.firstRechargeInfo[rechargeId]then
self.data.firstRechargeInfo[rechargeId].recharge_sec=rechargeSec
else
self.data.firstRechargeInfo[rechargeId]={
recharge_id=rechargeId,
len=0,
recharge_sec=rechargeSec,
}



firstRechargeController:reqGetFirstRechargeReward(rechargeId,1)

firstRechargeController:checkFirstRechargeEnter()
end
pfCommonHelper.reportFirstRechargeBuy1(rechargeId)
end


function firstRechargeModel:getFirstRechargeAllData()
local len=self.data.firstRechargeInfoLen
if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
return self.data.firstRechargeInfo,len
end

return nil,len
end


function firstRechargeModel:getFirstRechargeDataByRechargeId(rechargeId)
if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
if self.data.firstRechargeInfo[rechargeId]then
return self.data.firstRechargeInfo[rechargeId]
end
end

return nil
end


function firstRechargeModel:checkIsGotFirstRechargeRewardByIdAndDay(rechargeId,day)
local isGot=false

if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
if self.data.firstRechargeInfo[rechargeId]and self.data.firstRechargeInfo[rechargeId].commData then
for k,v in pairs(self.data.firstRechargeInfo[rechargeId].commData)do
if v.param_1==day then
local flag=v.param_2
if flag==1 then
isGot=true
end
break
end
end
end
end

return isGot
end


function firstRechargeModel:checkNotBought()
local cfgList=firstRechargeModel:getSortCfgList()
for k,v in ipairs(cfgList)do
if not firstRechargeModel:checkIsBought(v.rechargeId)then
return true
end
end
return false
end


function firstRechargeModel:checkIsBought(rechargeId)
if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
return self.data.firstRechargeInfo[rechargeId]~=nil
end
return false
end


function firstRechargeModel:getCanGetRewardTimeByIdAndDay(rechargeId,day)
if day<=0 then
return nil
end

if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
if self.data.firstRechargeInfo[rechargeId]then
local addTime=(day-1)*86400
local openStamp=timeHelper.getServerOpenLongTime()
local zeroStamp=timeHelper.getServerZeroStamp(openStamp)
local stamp=zeroStamp+addTime
if stamp<=openStamp then
stamp=openStamp
end
return stamp
end
end

return nil
end


function firstRechargeModel:checkReddotById(rechargeId)
if firstRechargeModel:checkFirstRechargePageOpenReddotByRechargeId(rechargeId)then

return true
end

local reddot=false


local rewardsAllCfg=cfgHelper.get1(cfg_firstchargeconfig_get,rechargeId).rewards
local rewards=firstRechargeModel:getVersionAndPfCfg(rewardsAllCfg)
local dayCount=#rewards

local nowTime=gameUtilityModel.getServerLongTime()
local canGetDayIndex=1
local canNotGetDayIndex=nil
for i=1,dayCount do

if not firstRechargeModel:checkIsGotFirstRechargeRewardByIdAndDay(rechargeId,i)then

local targetTime=firstRechargeModel:getCanGetRewardTimeByIdAndDay(rechargeId,i)
if targetTime and targetTime-nowTime<=0 then

if not reddot then

canGetDayIndex=i
end
reddot=true
return reddot,canGetDayIndex
else

if canNotGetDayIndex==nil then

canNotGetDayIndex=i
else

canNotGetDayIndex=i<canNotGetDayIndex and i or canNotGetDayIndex
end
end

end
end
return reddot,canNotGetDayIndex or 1
end


function firstRechargeModel:checkMainEnterReddot()
local cfgList=firstRechargeModel:getSortCfgList()
local reddot=false
local cfgIndex=1
for k,v in ipairs(cfgList)do
reddot=firstRechargeModel:checkReddotById(v.rechargeId)
if reddot then
return reddot,k
end
end

return reddot,cfgIndex
end


function firstRechargeModel:initSortCfgList()
local frCfg=cfg_firstchargeconfig()
local sortCfgList={}
for k,v in pairs(frCfg)do
local czCfg=cfgHelper.get(cfg_rechargeconfig_get,v.id)
if czCfg.recharge_type==6 then


local rewardsAllCfg=v.rewards
local rewards=firstRechargeModel:getVersionAndPfCfg(rewardsAllCfg)
local dayCount=#rewards
local listItem={rechargeId=v.id,rmb=czCfg.rmb,dayCount=dayCount,cfg=v}


table.insert(sortCfgList,listItem)
end
end

table.sort(sortCfgList,function(a,b)return a.rmb<b.rmb end)
self.data.firstRechargeSortCfg=sortCfgList
end


function firstRechargeModel:getSortCfgList()
if self.data.firstRechargeSortCfg and next(self.data.firstRechargeSortCfg)then
return self.data.firstRechargeSortCfg
end


firstRechargeModel:initSortCfgList()

return self.data.firstRechargeSortCfg
end



function firstRechargeModel:initShowTabList(isOnlyAdd)
if not isOnlyAdd then
self.data.firstRechargeShowTabList={}
self.data.firstRechargeShowTabList_lookup={}
end
local allCfg=firstRechargeModel:getSortCfgList()
for k,v in ipairs(allCfg)do
local rechargeId=v.rechargeId

local isShow=firstRechargeModel:checkTabCanShowByRechargeId(rechargeId)
if isShow and not self.data.firstRechargeShowTabList_lookup[rechargeId]then

self.data.firstRechargeShowTabList[#self.data.firstRechargeShowTabList+1]={rechargeId=v.rechargeId,rmb=v.rmb,dayCount=v.dayCount,cfg=v.cfg}
self.data.firstRechargeShowTabList_lookup[rechargeId]=#self.data.firstRechargeShowTabList
end
end
end

function firstRechargeModel:checkTabCanShowByRechargeId(rechargeId,isIgnoreRewardGot)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
return false
end
local isShow=false
local firstRechargeCfg=cfgHelper.get1(cfg_firstchargeconfig_get,rechargeId)
if firstRechargeCfg then
local isFinishCondition=false
local showCondition=firstRechargeCfg.show_condition
local showParamIdList=firstRechargeCfg.showParamId
local showParamId=firstRechargeModel:getVersionAndPfCfg(showParamIdList)
local showParamCfg=cfgHelper.get1(cfg_firstrechargeshowparamconfig_get,showParamId)
local hideCondition=showParamCfg.hideCondition

local rewardsAllCfg=cfgHelper.get1(cfg_firstchargeconfig_get,rechargeId).rewards
local rewards=firstRechargeModel:getVersionAndPfCfg(rewardsAllCfg)
local dayCount=#rewards
local isBought=firstRechargeModel:checkIsBought(rechargeId)

if not isBought and(showCondition or hideCondition)then
if showCondition then
isFinishCondition=true
for cndType,conditionIdList in pairs(showCondition)do
if cndType==1 then

for _,conditionId in ipairs(conditionIdList)do
if not firstRechargeModel:checkIsBought(conditionId)then

isFinishCondition=false
break
end
end
if not isFinishCondition then
break
end
elseif cndType==2 then

local targetNum=conditionIdList[1]
local totalNum=rechargeModel:getTotalRecharge()
if totalNum<targetNum then
isFinishCondition=false
break
end
end
end
else
isFinishCondition=true
end

if isFinishCondition and hideCondition then
local conditionType=hideCondition[1]
local conditionParam=hideCondition[2]
if conditionType==1 then

local zmLevel=zongmenModel:getLevel()
local targetLevel=conditionParam
if zmLevel>=targetLevel then

isFinishCondition=false
end
end
end
else

isFinishCondition=true
end

if isFinishCondition and not isIgnoreRewardGot then

for i=1,dayCount do
if not firstRechargeModel:checkIsGotFirstRechargeRewardByIdAndDay(rechargeId,i)then

isShow=true
break
end
end
elseif isFinishCondition then

isShow=true
end
end
return isShow
end


function firstRechargeModel:getShowTabList()
if self.data.firstRechargeShowTabList and next(self.data.firstRechargeShowTabList)then

return self.data.firstRechargeShowTabList
end


firstRechargeModel:initShowTabList()

return self.data.firstRechargeShowTabList
end

function firstRechargeModel:getShowTabIndexByRechargeId(rechargeId)
if self.data.firstRechargeShowTabList_lookup and next(self.data.firstRechargeShowTabList_lookup)then

return self.data.firstRechargeShowTabList_lookup[rechargeId]
end


firstRechargeModel:initShowTabList()

return self.data.firstRechargeShowTabList_lookup[rechargeId]
end


function firstRechargeModel:getNextRefreshTime()
local tabList=firstRechargeModel:getShowTabList()
local nextRefreshTime=nil

local nowTime=gameUtilityModel.getServerLongTime()
for k,v in ipairs(tabList)do
local dayCount=v.dayCount
for i=1,dayCount do

if not firstRechargeModel:checkIsGotFirstRechargeRewardByIdAndDay(v.rechargeId,i)then

local targetTime=firstRechargeModel:getCanGetRewardTimeByIdAndDay(v.rechargeId,i)
if targetTime and targetTime-nowTime>0 then

if not nextRefreshTime then
nextRefreshTime=targetTime
else

nextRefreshTime=nextRefreshTime<=targetTime and nextRefreshTime or targetTime
end
end
end
end
end

return nextRefreshTime
end


function firstRechargeModel:getTabSelectIndexBySortCfgIndex(sortCfgIndex)
local sortCfg=firstRechargeModel:getSortCfgList()
local cfg=sortCfg[sortCfgIndex]and sortCfg[sortCfgIndex].cfg or nil
local selectIndex=1
if cfg then
local tabList=firstRechargeModel:getShowTabList()
for i,v in ipairs(tabList)do
if v.rechargeId==cfg.id then
selectIndex=i
break
end
end
else
logErr(FMT.fmt("排序配置列表找不到对应索引为 {0} 的配置",sortCfgIndex))
end

return selectIndex
end


function firstRechargeModel:getFirstRechargePageOpenFlagByRechargeId(rechargeId)
local firstRechargePageOpenFlagList=userActorSetting.get('firstRechargePageOpenFlagList',{})
local rechargeIdStr=tostring(rechargeId)
if firstRechargePageOpenFlagList[rechargeIdStr]then
return true
end
return false
end


function firstRechargeModel:setFirstRechargePageOpenFlagByRechargeId(rechargeId)
local firstRechargePageOpenFlagList=userActorSetting.get('firstRechargePageOpenFlagList',{})
local rechargeIdStr=tostring(rechargeId)
if not firstRechargePageOpenFlagList[rechargeIdStr]then
firstRechargePageOpenFlagList[rechargeIdStr]=true
userActorSetting.flushVal('firstRechargePageOpenFlagList',firstRechargePageOpenFlagList)
end
end


function firstRechargeModel:checkFirstRechargePageOpenReddotByRechargeId(rechargeId)

local isShow=firstRechargeModel:checkTabCanShowByRechargeId(rechargeId)
if not isShow then
return false
end

local isOpened=firstRechargeModel:getFirstRechargePageOpenFlagByRechargeId(rechargeId)
if not isOpened then

local cfg=cfgHelper.get1(cfg_firstchargeconfig_get,rechargeId)
local showCnd=cfg and cfg.show_condition or nil
if showCnd then

return true
end
end
return false
end



function firstRechargeModel:getVersionAndPfCfg(cfgList)
local outCfg
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local defaultPfId=-1
local versionId=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()
if cfgList[versionId]then
if cfgList[versionId][pfId]then
outCfg=cfgList[versionId][pfId]
else

outCfg=cfgList[versionId][defaultPfId]
end
else

if cfgList[defaultVersionId][pfId]then
outCfg=cfgList[defaultVersionId][pfId]
else
outCfg=cfgList[defaultVersionId][defaultPfId]
end
end
return outCfg
end


function firstRechargeModel:test_clearFirstRechargePageOpenFlag()
userActorSetting.flushVal('firstRechargePageOpenFlagList',nil)

firstRechargeController:refreshEnterObjReddot()
end


