






local _MODULENAME="firstRecharge3Model"


def_table(_MODULENAME)
firstRecharge3Model.name=_MODULENAME
firstRecharge3Model.data={}

function firstRecharge3Model:onAppStart()

end


function firstRecharge3Model:onEnterState(isReconnect)
self.data.firstRechargeInfo={}
self.data.firstRechargeSortCfg={}
self.data.firstRechargeShowTabList={}
self.data.firstRechargeShowTabList_lookup={}

firstRecharge3Model:initSortCfgList()
end


function firstRecharge3Model:onProtocolReq()

end


function firstRecharge3Model:onLeaveState(isReconnect)

self.data={}
end



function firstRecharge3Model:setFirstRechargeData(len,frList)
self.data.firstRechargeInfoLen=len
if len and len>0 then
for k,v in pairs(frList)do
self.data.firstRechargeInfo[v.recharge_id]=v
end
end
end


function firstRecharge3Model:setFirstRechargeGotReward(rechargeId,day)
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


function firstRecharge3Model:setFirstRechargeBuyTime(rechargeId,rechargeSec)
if self.data.firstRechargeInfo[rechargeId]then
self.data.firstRechargeInfo[rechargeId].recharge_sec=rechargeSec
else
self.data.firstRechargeInfo[rechargeId]={
recharge_id=rechargeId,
len=0,
recharge_sec=rechargeSec,
}



firstRecharge3Controller:reqGetFirstRechargeReward(rechargeId,1)

firstRecharge3Controller:checkFirstRechargeEnter()
end
pfCommonHelper.reportFirstRechargeBuy3(rechargeId)
end


function firstRecharge3Model:getFirstRechargeAllData()
local len=self.data.firstRechargeInfoLen
if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
return self.data.firstRechargeInfo,len
end

return nil,len
end


function firstRecharge3Model:getFirstRechargeDataByRechargeId(rechargeId)
if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
if self.data.firstRechargeInfo[rechargeId]then
return self.data.firstRechargeInfo[rechargeId]
end
end

return nil
end


function firstRecharge3Model:checkIsGotFirstRechargeRewardByIdAndDay(rechargeId,day)
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


function firstRecharge3Model:checkNotBought()
local cfgList=firstRecharge3Model:getSortCfgList()
for k,v in ipairs(cfgList)do
if not firstRecharge3Model:checkIsBought(v.rechargeId)then
return true
end
end
return false
end


function firstRecharge3Model:checkIsBought(rechargeId)
if self.data.firstRechargeInfo and next(self.data.firstRechargeInfo)then
return self.data.firstRechargeInfo[rechargeId]~=nil
end
return false
end


function firstRecharge3Model:getCanGetRewardTimeByIdAndDay(rechargeId,day)
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


function firstRecharge3Model:checkReddotById(rechargeId)
if firstRecharge3Model:checkFirstRechargePageOpenReddotByRechargeId(rechargeId)then

return true
end

local reddot=false


local rewardsAllCfg=cfgHelper.get1(cfg_firstcharge3config_get,rechargeId).rewards
local rewards=pfwindowsModel:getVersionAndPfCfg(rewardsAllCfg)
local dayCount=#rewards

local nowTime=gameUtilityModel.getServerLongTime()
local canGetDayIndex=1
local canNotGetDayIndex=nil
for i=1,dayCount do

if not firstRecharge3Model:checkIsGotFirstRechargeRewardByIdAndDay(rechargeId,i)then

local targetTime=firstRecharge3Model:getCanGetRewardTimeByIdAndDay(rechargeId,i)
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


function firstRecharge3Model:checkMainEnterReddot()
local cfgList=firstRecharge3Model:getSortCfgList()
local reddot=false
local cfgIndex=1
for k,v in ipairs(cfgList)do
reddot=firstRecharge3Model:checkReddotById(v.rechargeId)
if reddot then
return reddot,k
end
end

return reddot,cfgIndex
end


function firstRecharge3Model:initSortCfgList()
local frCfg=cfg_firstcharge3config()
local sortCfgList={}
for k,v in pairs(frCfg)do
local czCfg=cfgHelper.get(cfg_rechargeconfig_get,v.id)
if czCfg.recharge_type==40 then


local rewardsAllCfg=v.rewards
local rewards=pfwindowsModel:getVersionAndPfCfg(rewardsAllCfg)
local dayCount=#rewards
local listItem={rechargeId=v.id,rmb=czCfg.rmb,dayCount=dayCount,cfg=v}


table.insert(sortCfgList,listItem)
end
end

table.sort(sortCfgList,function(a,b)return a.rmb<b.rmb end)
self.data.firstRechargeSortCfg=sortCfgList
end


function firstRecharge3Model:getSortCfgList()
if self.data.firstRechargeSortCfg and next(self.data.firstRechargeSortCfg)then
return self.data.firstRechargeSortCfg
end


firstRecharge3Model:initSortCfgList()

return self.data.firstRechargeSortCfg
end



function firstRecharge3Model:initShowTabList(isOnlyAdd)
if not isOnlyAdd then
self.data.firstRechargeShowTabList={}
self.data.firstRechargeShowTabList_lookup={}
end
local allCfg=firstRecharge3Model:getSortCfgList()
for k,v in ipairs(allCfg)do
local rechargeId=v.rechargeId

local isShow=firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId)
if isShow and not self.data.firstRechargeShowTabList_lookup[rechargeId]then

self.data.firstRechargeShowTabList[#self.data.firstRechargeShowTabList+1]={rechargeId=v.rechargeId,rmb=v.rmb,dayCount=v.dayCount,cfg=v.cfg}
self.data.firstRechargeShowTabList_lookup[rechargeId]=#self.data.firstRechargeShowTabList
end
end
end

function firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId,isIgnoreRewardGot)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
return false
end
local isShow=false
local firstRechargeCfg=cfgHelper.get1(cfg_firstcharge3config_get,rechargeId)
if firstRechargeCfg then
local isFinishCondition=false
local showCondition=firstRechargeCfg.show_condition
local showParamIdList=firstRechargeCfg.showParamId
local showParamId=pfwindowsModel:getVersionAndPfCfg(showParamIdList)
local showParamCfg=cfgHelper.get1(cfg_firstrecharge3showparamconfig_get,showParamId)
local hideCondition=showParamCfg.hideCondition

local rewardsAllCfg=cfgHelper.get1(cfg_firstcharge3config_get,rechargeId).rewards
local rewards=pfwindowsModel:getVersionAndPfCfg(rewardsAllCfg)
local dayCount=#rewards
local isBought=firstRecharge3Model:checkIsBought(rechargeId)

if not isBought and(showCondition or hideCondition)then
if showCondition then
isFinishCondition=true
for cndType,conditionIdList in pairs(showCondition)do
if cndType==1 then

for _,conditionId in ipairs(conditionIdList)do
if not firstRecharge3Model:checkIsBought(conditionId)then

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
if not firstRecharge3Model:checkIsGotFirstRechargeRewardByIdAndDay(rechargeId,i)then

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


function firstRecharge3Model:getShowTabList()
if self.data.firstRechargeShowTabList and next(self.data.firstRechargeShowTabList)then

return self.data.firstRechargeShowTabList
end


firstRecharge3Model:initShowTabList()

return self.data.firstRechargeShowTabList
end

function firstRecharge3Model:getShowTabIndexByRechargeId(rechargeId)
if self.data.firstRechargeShowTabList_lookup and next(self.data.firstRechargeShowTabList_lookup)then

return self.data.firstRechargeShowTabList_lookup[rechargeId]
end


firstRecharge3Model:initShowTabList()

return self.data.firstRechargeShowTabList_lookup[rechargeId]
end


function firstRecharge3Model:getNextRefreshTime()
local tabList=firstRecharge3Model:getShowTabList()
local nextRefreshTime=nil

local nowTime=gameUtilityModel.getServerLongTime()
for k,v in ipairs(tabList)do
local dayCount=v.dayCount
for i=1,dayCount do

if not firstRecharge3Model:checkIsGotFirstRechargeRewardByIdAndDay(v.rechargeId,i)then

local targetTime=firstRecharge3Model:getCanGetRewardTimeByIdAndDay(v.rechargeId,i)
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


function firstRecharge3Model:getTabSelectIndexBySortCfgIndex(sortCfgIndex)
local sortCfg=firstRecharge3Model:getSortCfgList()
local cfg=sortCfg[sortCfgIndex]and sortCfg[sortCfgIndex].cfg or nil
local selectIndex=1
if cfg then
local tabList=firstRecharge3Model:getShowTabList()
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


function firstRecharge3Model:getFirstRechargePageOpenFlagByRechargeId(rechargeId)
local firstRechargePageOpenFlagList=userActorSetting.get('firstRecharge3PageOpenFlagList',{})
local rechargeIdStr=tostring(rechargeId)
if firstRechargePageOpenFlagList[rechargeIdStr]then
return true
end
return false
end


function firstRecharge3Model:setFirstRechargePageOpenFlagByRechargeId(rechargeId)
local firstRechargePageOpenFlagList=userActorSetting.get('firstRecharge3PageOpenFlagList',{})
local rechargeIdStr=tostring(rechargeId)
if not firstRechargePageOpenFlagList[rechargeIdStr]then
firstRechargePageOpenFlagList[rechargeIdStr]=true
userActorSetting.flushVal('firstRecharge3PageOpenFlagList',firstRechargePageOpenFlagList)
end
end


function firstRecharge3Model:checkFirstRechargePageOpenReddotByRechargeId(rechargeId)

local isShow=firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId)
if not isShow then
return false
end

local isOpened=firstRecharge3Model:getFirstRechargePageOpenFlagByRechargeId(rechargeId)
if not isOpened then

local cfg=cfgHelper.get1(cfg_firstcharge3config_get,rechargeId)
local showCnd=cfg and cfg.show_condition or nil
if showCnd then

return true
end
end
return false
end


function firstRecharge3Model:test_clearFirstRechargePageOpenFlag()
userActorSetting.flushVal('firstRecharge3PageOpenFlagList',nil)

firstRecharge3Controller:refreshEnterObjReddot()
end
