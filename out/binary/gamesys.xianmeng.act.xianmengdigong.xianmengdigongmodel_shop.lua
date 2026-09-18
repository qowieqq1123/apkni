






XMDG_Shop_Record_Type={
eAuction=1,
eShop=2,
}

function xianmengdigongModel:initData_shop()

self.shopData={}
end

function xianmengdigongModel:clearData_shop()

self.shopData={}
end



function xianmengdigongModel:setXMDG_shopGoodsList(len,list)
self.shopData.goodsList={}
if len>0 then

for i,v in pairs(list)do
local itemId=v.item_id
local itemCount=v.item_num
local buyCount=v.times or 0
local day_buyCount=v.day_times or 0

local item={itemId=itemId,itemCount=itemCount,buyCount=buyCount,day_buyCount=day_buyCount}
self.shopData.goodsList[itemId]=item
end
end
end


function xianmengdigongModel:getXMDG_shopGoodsList()

if not xianmengdigongModel:checkXMDG_shopDataIsNew()then

return nil
end

if self.shopData and self.shopData.goodsList then
return self.shopData.goodsList
end

return nil
end

function xianmengdigongModel:setXMDG_shopLimitList(len,list)
self.shopData.limitList={}
if len>0 then

for i,v in pairs(list)do
local itemId=v.param_1
local limit=v.param_2

local item={itemId=itemId,limit=limit}
self.shopData.limitList[itemId]=item
end
end
end

function xianmengdigongModel:getXMDG_shopLimitList()
if self.shopData and self.shopData.limitList then
return self.shopData.limitList
end

return nil
end


function xianmengdigongModel:setXMDG_shopGoodsDataByItemId(itemId,itemCount,buyCount,day_buyCount)
if not itemId or not self.shopData then
return
end

if not self.shopData.goodsList then
self.shopData.goodsList={}
end

if not self.shopData.goodsList[itemId]then

self.shopData.goodsList[itemId]={itemId=itemId,itemCount=0,buyCount=0,day_buyCount=0}
end

if itemCount then
self.shopData.goodsList[itemId].itemCount=itemCount
end
if buyCount then
self.shopData.goodsList[itemId].buyCount=buyCount
end
if day_buyCount then
self.shopData.goodsList[itemId].day_buyCount=day_buyCount
end
end


function xianmengdigongModel:getXMDG_shopGoodsDataByItemId(itemId)
if not itemId or not self.shopData or not self.shopData.goodsList then
return nil
end

if self.shopData.goodsList[itemId]then
return self.shopData.goodsList[itemId]
end

return nil
end


function xianmengdigongModel:setXMDG_openShopPageRefreshFlag(flag)
if flag==nil or not self.shopData then
return
end
self.shopData.openShopPageRefreshFlag=flag
end


function xianmengdigongModel:getXMDG_openShopPageRefreshFlag()
if self.shopData and self.shopData.openShopPageRefreshFlag~=nil then
return self.shopData.openShopPageRefreshFlag
end

return false
end


function xianmengdigongModel:setXMDG_shopRefreshBtnCdEndTime(endTime)
if endTime==nil or not self.shopData then
return
end
self.shopData.shopRefreshBtnCdEndTime=endTime
end


function xianmengdigongModel:getXMDG_shopRefreshBtnCd()
if not self.shopData or not self.shopData.shopRefreshBtnCdEndTime then
return 0
end

local nowTime=gameUtilityModel.getServerShortTime()
local cdTime=self.shopData.shopRefreshBtnCdEndTime-nowTime
if cdTime<0 then
cdTime=0
self.shopData.shopRefreshBtnCdEndTime=0
end
return cdTime
end


function xianmengdigongModel:setXMDG_shopRefreshDataTime()
if not self.shopData then
return
end
local nowTime=timeHelper.getServerShortTime()
self.shopData.shopRefreshDataTime=nowTime
end


function xianmengdigongModel:getXMDG_shopRefreshDataTime()
if self.shopData and self.shopData.shopRefreshDataTime then
return self.shopData.shopRefreshDataTime
end
return 0
end


function xianmengdigongModel:checkXMDG_shopDataIsNew()
local actId=LIMIT_ACT_TYPE.eXianMengDiGong
local actInfo=limitActivitiesModel:getActInfo(actId)
local openTime
if actInfo then
if actInfo.state==limitActivitiesModel.actPreviewState or actInfo.state==limitActivitiesModel.actIdleState then

return true
else

openTime=actInfo.start_time

local dataTime=xianmengdigongModel:getXMDG_shopRefreshDataTime()
if dataTime>=openTime then

return true
end
end
end


return false
end



function xianmengdigongModel:setXMDG_auctionItemList(len,list)
self.shopData.auctionItemList={}
if len>0 then

for i,v in pairs(list)do
local auctionItemIndex=v.idx
local itemId=v.itemInfo and v.itemInfo.itemid or nil
if not itemId then
logErr(FMT.fmt("设置仙盟地宫拍卖品错误 找不到唯一标识{0}对应的道具信息",auctionItemIndex))
end
self.shopData.auctionItemList[auctionItemIndex]=v
end
end
end


function xianmengdigongModel:getXMDG_auctionItemList()
if self.shopData and self.shopData.auctionItemList then
return self.shopData.auctionItemList
end

return nil
end


function xianmengdigongModel:setXMDG_auctionItemDataByIdx(idx,auctionItemData)
if not idx or not self.shopData then
return
end

if not self.shopData.auctionItemList then
self.shopData.auctionItemList={}
end

self.shopData.auctionItemList[idx]=auctionItemData
end


function xianmengdigongModel:setXMDG_auctionItemInfoByIdx(idx,itemInfo,add_time)
if not idx or not self.shopData then
return
end

if not self.shopData.auctionItemList then
self.shopData.auctionItemList={}
end

if not self.shopData.auctionItemList[idx]then

self.shopData.auctionItemList[idx]={
idx=idx,
actor_id=int64.new(0),
actor_name="",
max_roll=0,
iconInfo={actoricon=0,pilistlen=0},
}
end

self.shopData.auctionItemList[idx].itemInfo=itemInfo
self.shopData.auctionItemList[idx].add_time=add_time
end


function xianmengdigongModel:getXMDG_auctionItemDataByIdx(idx)
if not idx or not self.shopData or not self.shopData.auctionItemList then
return nil
end
return self.shopData.auctionItemList[idx]
end


function xianmengdigongModel:setXMDG_auctionRollCount(rollCount)
self.shopData.auctionRollCount=rollCount
end


function xianmengdigongModel:getXMDG_auctionRollCount()
if self.shopData then
return self.shopData.auctionRollCount
end

return nil
end


function xianmengdigongModel:setXMDG_auctionLastSettleTime(time)
self.shopData.auctionLastSettleTime=time
end


function xianmengdigongModel:getXMDG_auctionLastSettleTime()
if self.shopData then
return self.shopData.auctionLastSettleTime
end

return nil
end



function xianmengdigongModel:setXMDG_auctionThisActDataEndTime()

local actId=LIMIT_ACT_TYPE.eXianMengDiGong
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo then
self.shopData.auctionThisActDataEndTime=actInfo.end_time_l
else
self.shopData.auctionThisActDataEndTime=0
end
end


function xianmengdigongModel:getXMDG_auctionThisActDataEndTime()
if self.shopData then
return self.shopData.auctionThisActDataEndTime or nil
end

return nil
end


function xianmengdigongModel:setXMDG_auctionRollRankList(idx,rankList)
if not idx or not self.shopData then
return
end

if not self.shopData.auctionRollRankList then
self.shopData.auctionRollRankList={}
end

self.shopData.auctionRollRankList[idx]=rankList
end


function xianmengdigongModel:getXMDG_auctionRollRankList(idx)
if not idx or not self.shopData then
return
end

if not self.shopData.auctionRollRankList then
self.shopData.auctionRollRankList={}
end

return self.shopData.auctionRollRankList[idx]
end


function xianmengdigongModel:setXMDG_auctionSelfRollNum(idx,rollNum)
if not idx or not self.shopData or not self.shopData.auctionRollRankList then
return
end

if not self.shopData.auctionRollRankList[idx]then

self.shopData.auctionRollRankList[idx]={}
end

local playerId=playerModel:getActorID()
local rankList=self.shopData.auctionRollRankList[idx]
for i,v in ipairs(rankList)do
local actorId=v.actor_id
if mathHelper.compareInt64(actorId,playerId)then
if rollNum>v.roll_num then

v.roll_num=rollNum
end
return
end
end


local selfRankData={
actor_id=playerId,
roll_num=rollNum,
iconInfo=playerModel:getActorIconInfo(),
actor_name=playerModel:getActorName()or"",
}
table.insert(self.shopData.auctionRollRankList[idx],selfRankData)
end


function xianmengdigongModel:getXMDG_auctionSelfRollNum(idx)
if not idx or not self.shopData or not self.shopData.auctionRollRankList then
return
end

if not self.shopData.auctionRollRankList[idx]then

return
end

local playerId=playerModel:getActorID()
local rankList=self.shopData.auctionRollRankList[idx]
for i,v in ipairs(rankList)do
local actorId=v.actor_id
if mathHelper.compareInt64(actorId,playerId)then
return v.roll_num
end
end
end


function xianmengdigongModel:setXMDG_initAuctionRefreshFlag(flag)
if flag==nil or not self.shopData then
return
end
self.shopData.initAuctionRefreshFlag=flag
end


function xianmengdigongModel:getXMDG_initAuctionRefreshFlag()
if self.shopData and self.shopData.initAuctionRefreshFlag~=nil then
return self.shopData.initAuctionRefreshFlag
end

return false
end


function xianmengdigongModel:setXMDG_openAuctionPageRefreshFlag(flag)
if flag==nil or not self.shopData then
return
end
self.shopData.openAuctionPageRefreshFlag=flag
end


function xianmengdigongModel:getXMDG_openAuctionPageRefreshFlag()
if self.shopData and self.shopData.openAuctionPageRefreshFlag~=nil then
return self.shopData.openAuctionPageRefreshFlag
end

return false
end


function xianmengdigongModel:setXMDG_auctionRefreshBtnCdEndTime(endTime)
if endTime==nil or not self.shopData then
return
end
self.shopData.auctionRefreshBtnCdEndTime=endTime
end


function xianmengdigongModel:getXMDG_auctionRefreshBtnCd()
if not self.shopData or not self.shopData.auctionRefreshBtnCdEndTime then
return 0
end

local nowTime=gameUtilityModel.getServerShortTime()
local cdTime=self.shopData.auctionRefreshBtnCdEndTime-nowTime
if cdTime<0 then
cdTime=0
self.shopData.auctionRefreshBtnCdEndTime=0
end
return cdTime
end


function xianmengdigongModel:setXMDG_auctionGainList(len,list)
self.shopData.auctionGainList=list or{}
end


function xianmengdigongModel:getXMDG_auctionGainList()
if self.shopData and self.shopData.auctionGainList then
return self.shopData.auctionGainList
end

return nil
end


function xianmengdigongModel:setXMDG_newAddAuctionMsgList(list)
self.shopData.newAddAuctionMsgList=list or{}
end


function xianmengdigongModel:getXMDG_newAddAuctionMsgList()
if self.shopData and self.shopData.newAddAuctionMsgList then
return self.shopData.newAddAuctionMsgList
end

return{}
end


function xianmengdigongModel:setXMDG_notReadAddAuctionMsgNum(num)
self.shopData.notReadAddAuctionMsgNum=num
end


function xianmengdigongModel:getXMDG_notReadAddAuctionMsgNum()
if self.shopData and self.shopData.notReadAddAuctionMsgNum then
return self.shopData.notReadAddAuctionMsgNum
end

return 0
end


function xianmengdigongModel:setXMDG_newAuctionMsgAddTimeList(time,isRead)

local newAuctionMsgAddTimeList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'newAuctionMsgAddTimeList',{})
local timeStr=tostring(time)
newAuctionMsgAddTimeList[timeStr]=isRead or nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianMengDiGong,'newAuctionMsgAddTimeList',newAuctionMsgAddTimeList)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianMengDiGong)
end


function xianmengdigongModel:getXMDG_newAuctionMsgAddTimeList(time)
local newAuctionMsgAddTimeList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'newAuctionMsgAddTimeList',{})
local timeStr=tostring(time)
return newAuctionMsgAddTimeList[timeStr]
end


function xianmengdigongModel:getXMDG_allNewAuctionMsgAddTimeList()
local newAuctionMsgAddTimeList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'newAuctionMsgAddTimeList',{})
return newAuctionMsgAddTimeList
end



function xianmengdigongModel:setXMDG_recordList(len,list,recordType)
if not self.shopData.recordList then
self.shopData.recordList={}
end

if len<=0 then
self.shopData.recordList[recordType]={}
else
self.shopData.recordList[recordType]=list
end
end


function xianmengdigongModel:getXMDG_recordListByType(recordType)
if self.shopData and self.shopData.recordList then
return self.shopData.recordList[recordType]
end

return nil
end


function xianmengdigongModel:getXMDG_shopManageList()
if not self.shopManagListLookup then
self.shopManagListLookup={}
local configs=cfg_xmdgshopitemconfig()
for i,v in pairs(configs)do
if v.is_set==1 then
table.insert(self.shopManagListLookup,v)
end
end

table.sort(self.shopManagListLookup,function(a,b)
if a.sortId==b.sortId then
return a.id<b.id
else
return a.sortId<b.sortId
end
end)
end

return self.shopManagListLookup
end


function xianmengdigongModel:check_XMDG_shopManageReddot()
if not lingxuwenjianModel:isLeader()then
return false
end
if not limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianMengDiGong)then
return false
end
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianMengDiGong)then
return false
end

if not xianmengdigongController:checkOpen()then
return false
end
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'xmdgShopManage',0)==0
return reddot
end
