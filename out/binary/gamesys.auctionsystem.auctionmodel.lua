











auctionModel={}


auctionModel.data={}

function auctionModel:onAppStart()

end


function auctionModel:onEnterState(isReconnect)
self.data={}
self.data.guidlookup={}
self.data.preViewItem={}
end


function auctionModel:onLeaveState(isReconnect)

self.data={}
self.data.guidlookup={}
self.data.preViewItem={}
end




function auctionModel:setAuctionListData(serverType,auctionType,listLen,auctionList)
if not self.data.auctionList then
self.data.auctionList={}
end

if not self.data.auctionList[auctionType]then
self.data.auctionList[auctionType]={}
end

self.data.auctionList[auctionType][serverType]=auctionList


if not self.data.auctionList_lookup then
self.data.auctionList_lookup={}
end

if not self.data.auctionList_lookup[auctionType]then
self.data.auctionList_lookup[auctionType]={}
end

self.data.auctionList_lookup[auctionType][serverType]={}

if listLen and listLen>0 then
for i,auctionItemData in ipairs(auctionList)do
local seriesStr=tostring(auctionItemData.auctionseries)
self.data.auctionList_lookup[auctionType][serverType][seriesStr]={data=self.data.auctionList[auctionType][serverType][i],index=i}
auctionModel:createItem(auctionItemData)
end
end

end


function auctionModel:getAuctionListData(serverType,auctionType)
if not serverType or not auctionType then
return nil
end

if self.data.auctionList and self.data.auctionList[auctionType]and self.data.auctionList[auctionType][serverType]then
return self.data.auctionList[auctionType][serverType]
end
end


function auctionModel:getAuctionItemDataBySeries(serverType,auctionType,auctionSeries)
if not serverType or not auctionType or not auctionSeries then
return nil
end

if self.data.auctionList_lookup and self.data.auctionList_lookup[auctionType]and self.data.auctionList_lookup[auctionType][serverType]then
local seriesStr=tostring(auctionSeries)
if self.data.auctionList_lookup[auctionType][serverType][seriesStr]then
return self.data.auctionList_lookup[auctionType][serverType][seriesStr].data
end
end

return nil
end


function auctionModel:setAuctionItemDataBySeries(serverType,auctionType,auctionSeries,auctionPrice,auctionEndTime,auctionBiddingCount,result,isBuy)
if not serverType or not auctionType or not auctionSeries then
return
end

if self.data.auctionList_lookup and self.data.auctionList_lookup[auctionType]and self.data.auctionList_lookup[auctionType][serverType]then
local seriesStr=tostring(auctionSeries)
if self.data.auctionList_lookup[auctionType][serverType][seriesStr]then
local index=self.data.auctionList_lookup[auctionType][serverType][seriesStr].index
local auctionItemData=self.data.auctionList[auctionType][serverType][index]

auctionItemData.auctionprice=auctionPrice
auctionItemData.auctionsec=auctionEndTime
auctionItemData.times=auctionBiddingCount
if result==0 then

auctionItemData.auctionactorid=playerModel:getActorID()
if isBuy then

auctionItemData.isHide=true
end
end
end
end
end


function auctionModel:setBiddingRecordListData(serverType,listLen,biddingRecordList)
if not self.data.biddingRecordList then
self.data.biddingRecordList={}
end

self.data.biddingRecordList[serverType]=biddingRecordList
end


function auctionModel:setAuctionRecordListData(auctionType,listLen,recordList)
if not self.data.recordList then
self.data.recordList={}
end

self.data.recordList[auctionType]=recordList
end


function auctionModel:getAuctionRecordListData(auctionType)
if not auctionType then
return nil
end

if self.data.recordList and self.data.recordList[auctionType]then
return self.data.recordList[auctionType]
end
end


function auctionModel:setAuctionXianMengScore(score)
self.data.xianMengScore=score
end


function auctionModel:getAuctionXianMengScore()
if not self.data.xianMengScore then
self.data.xianMengScore=0
end

return self.data.xianMengScore
end


function auctionModel:set_CheooseBoxValue(boxCheck)
self.data.boxCheck=boxCheck
end


function auctionModel:get_CheooseBoxValue()
return self.data.boxCheck
end

function auctionModel:setRefreshCdEndTime(time)
self.data.refresh_cd_endTime=time
end

function auctionModel:getRefreshCdTime()
if not self.data.refresh_cd_endTime then
self.data.refresh_cd_endTime=0
end

if self.data.refresh_cd_endTime==0 then
return 0
end

local nowTime=gameUtilityModel.getServerShortTime()
local cdTime=self.data.refresh_cd_endTime-nowTime
if cdTime<0 then
cdTime=0
self.data.refresh_cd_endTime=0
end
return cdTime
end

function auctionModel:getBubbleShowTime()
local time=cfgHelper.get2(cfg_auctionconfig_get,1,'bubbleShowTime')
return time
end

function auctionModel:setBubbleShowFlag(flag)
self.data.bubbleShowFlag=flag
end

function auctionModel:getBubbleShowFlag()
return self.data.bubbleShowFlag or false
end


function auctionModel:initAuctionTime(isChangeTYSCState)
self.data.startTime=nil
self.data.endTime=nil
self.data.finalEndTime=nil


local isDone_TYSC=limitActivitiesModel:getActMark_done(LIMIT_ACT_TYPE.eTianYuanShouChao)
if not isDone_TYSC then

return
end



local info=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eTianYuanShouChao)
local isOpen_TYSC=info:checkDayCondition()
if not isOpen_TYSC then

return
end

local cfg=cfgHelper.get(cfg_auctionconfig_get,1)
if info.pre_end_time_l then

self.data.startTime=info.pre_end_time_l

if isChangeTYSCState then

local nowTime=gameUtilityModel.getServerLongTime()
local deltaTime=info.end_time_l-info.pre_end_time_l
local lerp=nowTime-info.pre_end_time_l
if lerp>=deltaTime then

self.data.startTime=info.end_time_l
end
end
self.data.endTime=self.data.startTime+cfg.enterOpenTime[1]
self.data.finalEndTime=self.data.endTime+cfg.enterOpenTime[2]
elseif info.end_time_l then

self.data.startTime=info.end_time_l
self.data.endTime=self.data.startTime+cfg.enterOpenTime[1]
self.data.finalEndTime=self.data.endTime+cfg.enterOpenTime[2]
else
logErr("找不到天渊兽潮结束时间, 无法计算拍卖会相关时间")
end
end


function auctionModel:getAuctionTime()
if not self.data.startTime then

auctionModel:initAuctionTime()
end

return self.data.startTime,self.data.endTime,self.data.finalEndTime
end


function auctionModel:initAuctionTime_test()
local nowTime=gameUtilityModel.getServerLongTime()
self.data.startTime=nowTime
self.data.endTime=nowTime+86400
self.data.finalEndTime=nowTime+86400
end






function auctionModel:getAuctionState()

local state=0


local isDone_TYSC=limitActivitiesModel:getActMark_done(LIMIT_ACT_TYPE.eTianYuanShouChao)
if not isDone_TYSC then

return state
end



local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eTianYuanShouChao)
local isOpen_TYSC=actInfo and actInfo:checkDayCondition()or nil
if not isOpen_TYSC then

return state
end

local startTime,endTime,finalEndTime=auctionModel:getAuctionTime()


local nowTime=gameUtilityModel.getServerLongTime()
local lerp=nowTime-startTime
if lerp>=0 then
lerp=nowTime-endTime
if lerp<=0 then

state=1
else

lerp=nowTime-finalEndTime
if lerp<=0 then

state=2
else

state=3
end
end
end

return state
end


function auctionModel:setNeedCheckEnterInRecvFlag(flag)
self.data.needCheckEnterInRecv=flag
end


function auctionModel:getNeedCheckEnterInRecvFlag()
return self.data.needCheckEnterInRecv or false
end


function auctionModel:setTryGetCrossAuctionListFlag(flag)
self.data.tryGetCrossAuctionListFlag=flag
end


function auctionModel:getTryGetCrossAuctionListFlag()
return self.data.tryGetCrossAuctionListFlag or false
end


function auctionModel:setQuotaListByServerType(serverType,len,quotaList)
if not self.data.quotaList then
self.data.quotaList={}
end

if not self.data.quotaList[serverType]then
self.data.quotaList[serverType]={}
end

if len>0 then
for k,v in ipairs(quotaList)do
local auctionType=v.param_1
local quota=v.param_2
self.data.quotaList[serverType][auctionType]=quota
end
else

self.data.quotaList[serverType]={}
end
end


function auctionModel:getQuotaByServerTypeAndAuctionType(serverType,auctionType)
if not self.data.quotaList then
return 0
end

if not self.data.quotaList[serverType]then
return 0
end

if not self.data.quotaList[serverType][auctionType]then
return 0
end

return self.data.quotaList[serverType][auctionType]
end


function auctionModel:getRemainderQuota(serverType,auctionType)
local usedQuota=auctionModel:getQuotaByServerTypeAndAuctionType(serverType,auctionType)

local maxQuota=0
local quotaLevelCfg=cfgHelper.get2(cfg_auctionconfig_get,1,'quota')
if quotaLevelCfg then
local zmLevel=zongmenModel:getLevel()
local quotaCfg=nil
for i,v in ipairs(quotaLevelCfg)do
local minLv=v[1]
local maxLv=v[2]
if zmLevel>=minLv and zmLevel<=maxLv then
quotaCfg=v[3]
break
end
end

if quotaCfg and quotaCfg[serverType]then
maxQuota=quotaCfg[serverType][auctionType]or 0
end
end

local remainderQuota=maxQuota-usedQuota
if remainderQuota<0 then
remainderQuota=0
end

return remainderQuota
end



function auctionModel:setPersonAuctionSellListData(listLen,itemList)
if not self.data.personAuctionSellList then
self.data.personAuctionSellList={}
end

self.data.personAuctionSellList=itemList

for i=1,listLen do
local auctionItemData=itemList[i]
auctionModel:createItem(auctionItemData)
end
end


function auctionModel:addPersonAuctionSellItem(auctionItemData)
if not self.data.personAuctionSellList then
self.data.personAuctionSellList={}
end

table.insert(self.data.personAuctionSellList,auctionItemData)

auctionModel:createItem(auctionItemData)
end


function auctionModel:removePersonAuctionSellItem(auctionseries)
local auctionItemData,index=auctionModel:getPersonAuctionSellItemDataByAuctionSeries(auctionseries)
table.remove(self.data.personAuctionSellList,index)
end


function auctionModel:setPersonAuctionSellItemEndTime(auctionseries,auctionEndTime)
local auctionItemData,index=auctionModel:getPersonAuctionSellItemDataByAuctionSeries(auctionseries)
if auctionItemData then
self.data.personAuctionSellList[index].auctionsec=auctionEndTime
end
end


function auctionModel:getPersonAuctionSellListData()
if not self.data.personAuctionSellList then
self.data.personAuctionSellList={}
end
return self.data.personAuctionSellList
end


function auctionModel:getPersonAuctionSellItemDataByAuctionSeries(auctionseries)
if not auctionseries then
return nil
end

if self.data.personAuctionSellList then
for i,v in ipairs(self.data.personAuctionSellList)do
if mathHelper.compareInt64(v.auctionseries,auctionseries)then
return v,i
end
end
end

return nil
end


function auctionModel:getPersonAuctionSellCostByPrice(price)
local costCfg=cfgHelper.get2(cfg_auctionconfig_get,1,'personcost')
local costMoneyType=costCfg[1]
local costRate=costCfg[2]
local costCount=price and price*costRate or 0

return costCount,costMoneyType
end


function auctionModel:checkPersonAuctionIsCrossModel()

if not self.data.personAuctionIsCross then

local openDay=timeHelper.getServerOpenDay()
local crossModelNeedOpenDay=cfgHelper.get2(cfg_auctionconfig_get,1,'personcross')
self.data.personAuctionIsCross=openDay>=crossModelNeedOpenDay
end

return self.data.personAuctionIsCross
end


function auctionModel:setPersonAuctionEnterCrossModel()
self.data.personAuctionIsCross=true
end


function auctionModel:checkPersonAuctionSellMax(isReSell)
local nowSellList=auctionModel:getPersonAuctionSellListData()
local nowSellCount=#nowSellList
if isReSell then
nowSellCount=nowSellCount-1
if nowSellCount<0 then
nowSellCount=0
end
end
local maxSellCount=cfgHelper.get2(cfg_auctionconfig_get,1,'personmax')

return nowSellCount>=maxSellCount
end


function auctionModel:setPersonAuctionSellIsAnonymous(flag)
self.data.personAuctionSellIsAnonymous=flag
end


function auctionModel:getPersonAuctionSellIsAnonymous()
return self.data.personAuctionSellIsAnonymous or false
end


function auctionModel:setPersonAuctionConditionFilter(filterTypeCfgIndex,filter,tabType)

















local pA_conditionFilter=self.data.pA_conditionFilter or{}
local typeId=auctionModel:getPersonAuctionSecondFilterMainTypeId(filterTypeCfgIndex,tabType)
pA_conditionFilter[tostring(typeId)]=filter

self.data.pA_conditionFilter=pA_conditionFilter
end


function auctionModel:getPersonAuctionSecondFilter(filterTypeCfgIndex,tabType)












local pA_conditionFilter=self.data.pA_conditionFilter or{}
local typeId=auctionModel:getPersonAuctionSecondFilterMainTypeId(filterTypeCfgIndex,tabType)
local filter=pA_conditionFilter[tostring(typeId)]or{}

return filter
end


local tabFilterNameList={
[FULL_TAB_TYPE.eWBSH_Auction]='personItemTypeList',
[FULL_TAB_TYPE.eWBSH_Sell]='sellBagItemTypeList'
}
function auctionModel:getItemTypeCfgList(tabType)
local filterName=tabFilterNameList[tabType]
local itemTypeCfgList=cfgHelper.get2(cfg_auctionconfig_get,1,filterName)
return itemTypeCfgList
end

function auctionModel:getPersonAuctionSecondFilterMainTypeId(filterTypeCfgIndex,tabType)
local typeId=0
local itemTypeCfgList=auctionModel:getItemTypeCfgList(tabType)
local itemTypeCfg=itemTypeCfgList[filterTypeCfgIndex]
typeId=itemTypeCfg.filterType
local itemTypeList=itemTypeCfg.itemType or{}
if type(itemTypeList)=='table'then
for i,v in ipairs(itemTypeList)do
typeId=typeId+v*100^i
end
else
typeId=typeId+itemTypeList*100
end

return typeId*1000+tabType
end


function auctionModel:setPersonAuctionHideReconfirmFlag(flag)
self.data.isPersonAuctionHideReconfirm=flag
end


function auctionModel:getPersonAuctionHideReconfirmFlag()
return self.data.isPersonAuctionHideReconfirm or false
end


function auctionModel:clearPersonAuctionConditionFilter()





self.data.pA_conditionFilter=nil
end


function auctionModel:createItem(data)
local auctionseries=data.auctionseries
local itemguid=auctionModel:getItemguid(auctionseries)
if itemguid then return end
itemguid=itemsModel.getGUID()
auctionModel:setItemguid(auctionseries,itemguid)
local itemStruct={}
local itemid=data.itemid
itemStruct.itemguid=itemguid
itemStruct.itemid=itemid
itemStruct.itemcount=data.itemcount
itemStruct.itemflag=0
itemStruct.itemtime=0
itemStruct.itemData=data.itemData
if itemsConfig.isFabao(itemid)then
fabaoHelper.handleItem(itemStruct)
end
self.data.preViewItem[tostring(itemguid)]=itemStruct
end

function auctionModel:getItem(itemguid)
return self.data.preViewItem[tostring(itemguid)]
end

function auctionModel:setItemguid(auctionseries,itemguid)
self.data.guidlookup[tostring(auctionseries)]=itemguid
end

function auctionModel:getItemguid(auctionseries)
return self.data.guidlookup[tostring(auctionseries)]
end


function auctionModel:setAuctionRefreshKeepPosFlag(flag)
self.data.auctionRefreshKeepPosFlag=flag
end


function auctionModel:getAuctionRefreshKeepPosFlag()
return self.data.auctionRefreshKeepPosFlag or false
end



function auctionModel.initAuctionItemGuanZhuState_WBSH(len,arr)
local guanZhuStateList={}
local serverType=AUCTION_SERVER_TYPE.eCross
local auctionType=AUCTION_AUCTION_TYPE.ePlayer
if len>0 then
for i=1,len,2 do
local hightIndex=i
local lowIndex=i+1
local hight=arr[hightIndex]
local low=arr[lowIndex]
local auctionseries=mathHelper.concatToInt64(hight,low)
local auctionseriesStr=tostring(auctionseries)
guanZhuStateList[auctionseriesStr]={
serverType=serverType,
auctionType=auctionType,
}
end
end
auctionModel:setAuctionItemGuanZhuStateList(guanZhuStateList)
end


function auctionModel:setAuctionItemGuanZhuStateList(guanZhuStateList)
self.data.auctionItemGuanZhuStateList=guanZhuStateList or{}
end


function auctionModel:setAuctionItemGuanZhuState(serverType,auctionType,auctionseries,flag)
if not self.data.auctionItemGuanZhuStateList then
self.data.auctionItemGuanZhuStateList={}
end

local auctionseriesStr=tostring(auctionseries)
if flag==false or flag==nil then
self.data.auctionItemGuanZhuStateList[auctionseriesStr]=nil
else
self.data.auctionItemGuanZhuStateList[auctionseriesStr]={
serverType=serverType,
auctionType=auctionType,
}
end
end


function auctionModel:getAuctionItemGuanZhuState(auctionseries)
if not self.data or not self.data.auctionItemGuanZhuStateList then
return nil
end

local auctionseriesStr=tostring(auctionseries)
return self.data.auctionItemGuanZhuStateList[auctionseriesStr]
end


function auctionModel:getAuctionItemGuanZhuStateList()
if not self.data or not self.data.auctionItemGuanZhuStateList then
return nil
end

return self.data.auctionItemGuanZhuStateList
end


function auctionModel:saveAuctionItemGuanZhuStateList_WBSH()
local list={}
if self.data.auctionItemGuanZhuStateList and next(self.data.auctionItemGuanZhuStateList)then
for auctionseriesStr,v in pairs(self.data.auctionItemGuanZhuStateList)do
local auctionseries=int64.new(auctionseriesStr)
local hight,low=mathHelper.splitToInt32(auctionseries)
local hightIndex=#list+1
local lowIndex=#list+2
list[hightIndex]=hight
list[lowIndex]=low
end
end
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.AUCTION_WBSH_GUANZHU_STATE,#list,list)
end



function auctionModel:setAutoData(_auctionSeries,_maxprice,res,auctionprice,flag,serverType,auctionType)





auctionModel:setAuctionRefreshKeepPosFlag(true)
local winNmae=auctionType==AUCTION_AUCTION_TYPE.ePlayer and"UIWanBaoShangHui_auctionWin"or"UIAuctionWin"
if res==0 then








local auctionSeries=_auctionSeries
local maxprice=_maxprice
local issuccess=false

if auctionType==AUCTION_AUCTION_TYPE.ePlayer then
local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
local auctionSeriesStr=tostring(auctionSeries)
auctionSelfBiddingList[auctionSeriesStr]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',auctionSelfBiddingList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAuction)
elseif auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList',{})
local auctionSeriesStr=tostring(auctionSeries)
auctionSelfBiddingList[auctionSeriesStr]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList',auctionSelfBiddingList)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAuction)

end

if self.data.auctionList_lookup and self.data.auctionList_lookup[auctionType]and self.data.auctionList_lookup[auctionType][serverType]then
local seriesStr=tostring(auctionSeries)
if self.data.auctionList_lookup[auctionType][serverType][seriesStr]then
local index=self.data.auctionList_lookup[auctionType][serverType][seriesStr].index
local auctionItemData=self.data.auctionList[auctionType][serverType][index]
local selfid=playerModel:getActorID()

if auctionItemData.autolistlen and auctionItemData.autolistlen>0 and auctionItemData.autoList then
for k,v in ipairs(auctionItemData.autoList)do
if mathHelper.compareInt64(v.param_1,selfid)then
v.param_2=maxprice
end
end
else
local temp=
{
param_1=selfid,
param_2=maxprice
}
auctionItemData.autolistlen=1
auctionItemData.autoList=temp
end

issuccess=true
end
end

if issuccess then
if flag==1 then
UIManager.info("自动竞价成功")
elseif flag==2 then
local Autoflag=auctionModel:getAutoflag()
if Autoflag then
auctionModel:setAutoflag(false)
UIManager.info("已取消，不再自动竞价")
else
UIManager.info("修改自动竞价成功")
end

local win=UIManager:findActiveWindow(winNmae)
if win then

win:refresh(true)
end
end
local win2=UIManager:findActiveWindow('UIAuctionBiddingWin')
if win2 then
UIManager:closeWindow("UIAuctionBiddingWin")
end
end
elseif res==1 then
UIManager.info("拍品不存在，需要刷新")

local win=UIManager:findActiveWindow(winNmae)
if win then

win:refresh(true)
end
local win2=UIManager:findActiveWindow('UIAuctionBiddingWin')
if win2 then
UIManager:closeWindow("UIAuctionBiddingWin")
end
elseif res==2 then
UIManager.info("最新竞价上限已超过，需要重新设置")

local win=UIManager:findActiveWindow(winNmae)
if win then

win:refresh(true)
end
local newprice=auctionprice
UIManager:invokeUIMethod("UIAuctionBiddingWin","setEewPrice",newprice)
elseif res==3 then
UIManager.info("密码错误")
end
end

function auctionModel:setAutoflag(flag)
self.data.quexiaoaoutoflag=flag
end
function auctionModel:getAutoflag()
return self.data.quexiaoaoutoflag
end

function auctionModel:getSelfJoinAuction()
local selfid=playerModel:getActorID()
if self.data.auctionList then
for _,v in pairs(self.data.auctionList)do
for _,vv in pairs(v)do
for _,vvv in pairs(vv)do
if mathHelper.compareInt64(vvv.auctionactorid,selfid)then
return true
end
end
end
end
end
return false
end