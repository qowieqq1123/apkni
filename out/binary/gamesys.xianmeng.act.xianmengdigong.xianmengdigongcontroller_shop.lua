







function xianmengdigongController:onAppStart_shop()
socketManager:register_receiver(20,120,xianmengdigongController.recv_20_120)
socketManager:register_receiver(20,121,xianmengdigongController.recv_20_121)
socketManager:register_receiver(20,122,xianmengdigongController.recv_20_122)
socketManager:register_receiver(20,123,xianmengdigongController.recv_20_123)

socketManager:register_receiver(20,124,xianmengdigongController.recv_20_124)
socketManager:register_receiver(20,125,xianmengdigongController.recv_20_125)
socketManager:register_receiver(20,126,xianmengdigongController.recv_20_126)
socketManager:register_receiver(20,127,xianmengdigongController.recv_20_127)
socketManager:register_receiver(20,128,xianmengdigongController.recv_20_128)
socketManager:register_receiver(20,129,xianmengdigongController.recv_20_129)

socketManager:register_receiver(20,147,xianmengdigongController.recv_20_147)
end

function xianmengdigongController:onEnterState_shop(isReconnet)
xianmengdigongController:clearAuctionMsgAutoReadTimer()
end

function xianmengdigongController:onLeaveState_shop(isReconnet)
xianmengdigongController:clearAuctionMsgAutoReadTimer()
end

function xianmengdigongController:onProtocolReq_shop()

xianmengdigongController:reqAuctionItemList(false,true)
end

function xianmengdigongController:onLostConnection_shop()
xianmengdigongController:clearAuctionMsgAutoReadTimer()
end



function xianmengdigongController:reqShopGoodsList(isOpenPage)
if isOpenPage then
xianmengdigongModel:setXMDG_openShopPageRefreshFlag(true)
end
socketManager:send_20_120()
end


function xianmengdigongController:reqShopBuyGoods(itemId,count)
socketManager:send_20_121(itemId,count)
end


function xianmengdigongController:reqShopBuyRecord()
socketManager:send_20_122()
end


function xianmengdigongController:reqAuctionItemList(isOpenPage,isInit)
if isOpenPage then
xianmengdigongModel:setXMDG_openAuctionPageRefreshFlag(true)
end
if isInit then
xianmengdigongModel:setXMDG_initAuctionRefreshFlag(true)
end

local page=1
local pageSize=200
socketManager:send_20_124(page,pageSize)
end


function xianmengdigongController:reqAuctionItemRollRankList(idx)
socketManager:send_20_125(idx)
end


function xianmengdigongController:reqAuctionItemStartRollPoint(idx)
socketManager:send_20_126(idx)
end


function xianmengdigongController:reqAuctionRollRecord()
socketManager:send_20_127()
end


function xianmengdigongController:reqAuctionGainList()
socketManager:send_20_129()
end


function xianmengdigongController:reqShopLimitList(len,limitList)
socketManager:send_20_147(len,limitList)
end



function xianmengdigongController.recv_20_120(len,shopList,len2,limitList)
xianmengdigongModel:setXMDG_shopGoodsList(len,shopList)
xianmengdigongModel:setXMDG_shopLimitList(len2,limitList)


xianmengdigongModel:setXMDG_shopRefreshDataTime()


local win=UIManager:findActiveWindow('UIXM_XMDG_ShopWin')
if win then
if xianmengdigongModel:getXMDG_openShopPageRefreshFlag()then

xianmengdigongModel:setXMDG_openShopPageRefreshFlag(false)
win:refreshByAutoCd()
else
win:refresh()
end
end


win=UIManager:findActiveWindow('UIXM_XMDG_HarvestWin')
if win then
win:refreshShopPanel()
end
end


function xianmengdigongController.recv_20_121(item_id,buy_times,remain_num,result,day_buy_num)
if result==0 and item_id==0 then

UIManager.error("该物品已无存量")

return xianmengdigongController:reqShopGoodsList(true)
end


xianmengdigongModel:setXMDG_shopGoodsDataByItemId(item_id,remain_num,buy_times,day_buy_num)


local win=UIManager:findActiveWindow('UIXM_XMDG_ShopWin')
if win then
win:refresh(true)
end


if result~=1 then

if remain_num>0 then

local cfg=cfgHelper.get1(cfg_xmdgshopitemconfig_get,item_id)
local limit=cfg and cfg.shop_type and math.abs(cfg.limit_num)or 0
local limitList=xianmengdigongModel:getXMDG_shopLimitList()or{}

local dayLimit=limit
local limitData=limitList[item_id]
if limitData and limitData.limit~=limit then
dayLimit=limitList[item_id].limit
end

local canBuyCount=remain_num
local contentStr=FMT.fmt("该物品当前数量只剩{0}个，是否兑换余下数量？",canBuyCount)
if limit>0 then

if dayLimit<=day_buy_num then

UIManager.error("该物品已无剩余限兑次数")
return
else

local maxCount=dayLimit-day_buy_num
if maxCount<remain_num then
canBuyCount=maxCount
contentStr=FMT.fmt("该物品当前剩余限兑数量只剩{0}个，是否兑换余下数量？",canBuyCount)
end
end
end


local showdata=
{
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
if not xianmengdigongController:checkXMDGIsActive(true)then

return
end

return xianmengdigongController:reqShopBuyGoods(item_id,canBuyCount)
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else

UIManager.error("该物品已无存量")
end
end
end


function xianmengdigongController.recv_20_122(len,buyRecordList)
local recordType=XMDG_Shop_Record_Type.eShop
xianmengdigongModel:setXMDG_recordList(len,buyRecordList,recordType)


local win=UIManager:findActiveWindow('UIXM_XMDG_RecordWin')
if win then
win:refresh(XMDG_Shop_Record_Type.eShop)
end
end


function xianmengdigongController.recv_20_123(len,itemList)
if len<=0 then
return
end

for i,v in ipairs(itemList)do
local itemId=v.param_1
local itemCount=v.param_2
xianmengdigongModel:setXMDG_shopGoodsDataByItemId(itemId,itemCount)
end


local win=UIManager:findActiveWindow('UIXM_XMDG_ShopWin')
if win then
win:refreshByAutoCd()
end


win=UIManager:findActiveWindow('UIXM_XMDG_HarvestWin')
if win then
win:refreshShopPanel()
end
end


function xianmengdigongController.recv_20_124(len,aution_list,roll_times,prev_settle_sec)

xianmengdigongModel:setXMDG_auctionItemList(len,aution_list)

xianmengdigongModel:setXMDG_auctionRollCount(roll_times)

xianmengdigongModel:setXMDG_auctionLastSettleTime(prev_settle_sec)

xianmengdigongModel:setXMDG_auctionThisActDataEndTime()


local win=UIManager:findActiveWindow('UIXM_XMDG_AuctionWin')
if win then
if xianmengdigongModel:getXMDG_openAuctionPageRefreshFlag()then

xianmengdigongModel:setXMDG_openAuctionPageRefreshFlag(false)
win:refreshByAutoCd()
else

win:refresh()
end
end

if xianmengdigongModel:getXMDG_initAuctionRefreshFlag()then
xianmengdigongModel:setXMDG_initAuctionRefreshFlag(false)
xianmengdigongController:checkNewAuctionAddMsg(true)
end
end


function xianmengdigongController.recv_20_125(idx,len,rankList)
xianmengdigongModel:setXMDG_auctionRollRankList(idx,rankList)


local win=UIManager:findActiveWindow('UIXM_XMDG_RollPointWin')
if win then
win:refreshRollRank()
end
end


function xianmengdigongController.recv_20_126(idx,roll_num)

xianmengdigongModel:setXMDG_auctionSelfRollNum(idx,roll_num)


local rollCount=xianmengdigongModel:getXMDG_auctionRollCount()or 0
rollCount=rollCount+1
xianmengdigongModel:setXMDG_auctionRollCount(rollCount)


local win=UIManager:findActiveWindow('UIXM_XMDG_RollPointWin')
if win then
win:startRollWithRecv(idx,roll_num)
end

local auctionItemData=xianmengdigongModel:getXMDG_auctionItemDataByIdx(idx)

auctionItemData.shop_roll_times=auctionItemData.shop_roll_times and auctionItemData.shop_roll_times+1 or 1

if not auctionItemData.max_roll or roll_num>auctionItemData.max_roll then

auctionItemData.actor_id=playerModel:getActorID()
auctionItemData.actor_name=playerModel:getActorName()or""
auctionItemData.max_roll=roll_num
auctionItemData.iconInfo=playerModel:getActorIconInfo()
xianmengdigongModel:setXMDG_auctionItemDataByIdx(idx,auctionItemData)
end

win=UIManager:findActiveWindow('UIXM_XMDG_AuctionWin')
if win then
win:refreshByAutoCd(true)
end
end


function xianmengdigongController.recv_20_127(len,auctionRecordList)
local recordType=XMDG_Shop_Record_Type.eAuction
xianmengdigongModel:setXMDG_recordList(len,auctionRecordList,recordType)


local win=UIManager:findActiveWindow('UIXM_XMDG_RecordWin')
if win then
win:refresh(XMDG_Shop_Record_Type.eAuction)
end
end


function xianmengdigongController.recv_20_128(len,auctionItemList)
if not len or len<=0 then
return
end

for i,v in ipairs(auctionItemList)do
local idx=v.idx
local itemInfo=v.itemInfo
local add_time=v.add_time
xianmengdigongModel:setXMDG_auctionItemInfoByIdx(idx,itemInfo,add_time)
end


local win=UIManager:findActiveWindow('UIXM_XMDG_AuctionWin')
if win then
win:refreshByAutoCd()
end


xianmengdigongController:checkNewAuctionAddMsg()
end


function xianmengdigongController.recv_20_129(len,auctionGainList)
xianmengdigongModel:setXMDG_auctionGainList(len,auctionGainList)


local win=UIManager:findActiveWindow('UIXM_XMDG_HarvestWin')
if win then
win:refreshAuctionPanel()
end
end


function xianmengdigongController.recv_20_147(len,limitList)
xianmengdigongModel:setXMDG_shopLimitList(len,limitList)

UIManager:callWindowFunc('UIXM_XMDG_ShopWin','onShowArgRecv')

end



function xianmengdigongController:checkIsOverSettleTime()

local settleHour=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'settle_time')
local thisSettleTime=timeHelper.getTodayXXStamp(settleHour,0,0)

local lastSettleTime=xianmengdigongModel:getXMDG_auctionLastSettleTime()
if not lastSettleTime then

return false
end
local lastSettleTime_long=lastSettleTime==0 and 0 or timeHelper.convertLongStamp(lastSettleTime)
if lastSettleTime_long>=thisSettleTime then

return false
end


local nowTime=timeHelper.getServerLongTime()
local lerp=thisSettleTime-nowTime
if lerp>0 then

return false
else

return true
end
end


function xianmengdigongController:getNextSettleTime()
local settleHour=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'settle_time')
local settleTime=timeHelper.getTodayXXStamp(settleHour,0,0)
local nowTime=timeHelper.getServerLongTime()
local lerp=settleTime-nowTime
if lerp<=0 then
settleTime=settleTime+86400
end

return settleTime
end


function xianmengdigongController:checkXMDGIsActive(isWarning)
local isActive=true












if not xianmengModel:hasXM()then
isActive=false

if isWarning then
UIManager.error(cfgHelper.getlang("haveNotXianMengTips"))
end
end

return isActive
end


function xianmengdigongController:checkXMDGAuctionDataIsNew()
local nowTime=gameUtilityModel.getServerLongTime()
local dataEndTime=xianmengdigongModel:getXMDG_auctionThisActDataEndTime()
if dataEndTime and dataEndTime-nowTime<=0 then
return false
end

return true
end

function xianmengdigongController:addNewAuctionMsg(auctionList)
local notice=""
local itemNameList={}
for i,v in ipairs(auctionList)do
local auctionData=v.data
local itemInfo=auctionData.itemInfo
local itemid=itemInfo.itemid
local itemCount=itemInfo.itemcount
local itemConfig=itemsConfig.getConfig(itemid)
local itemName=itemConfig.name
local itemColor=itemConfig.color
local itemNameStr=FMT.cfmt(itemColor,"{0}x{1}",itemName,itemCount)
table.insert(itemNameList,itemNameStr)
end
local allItemNameStr=table.concat(itemNameList,"、")
local addNewTips=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'addNewTips')
notice=FMT.fmt(addNewTips,allItemNameStr)

chatControl.onRecvSystemMesg(CHAT_MSG_TYPE.eNoFitler,chatConfig.getSystemPosValue({CHAT_CHANNNEL.eXianmeng}),notice,"仙盟地宫公告",false,false)
end


function xianmengdigongController:clearAllNotReadMsgList()
local msgAuctionList=xianmengdigongModel:getXMDG_newAddAuctionMsgList()or{}
for _,msgData in ipairs(msgAuctionList)do
local addTime=msgData.addTime

xianmengdigongModel:setXMDG_newAuctionMsgAddTimeList(addTime,true)
end

end


function xianmengdigongController:checkNewAuctionAddMsg(isInit)
local auctionItemList=xianmengdigongModel:getXMDG_auctionItemList()
local needReturn=false
if not auctionItemList or not next(auctionItemList)then
needReturn=true
end


local addAuctionItemList={}
local addAuctionTimeIndexList_lookup={}
local thisSettleTime

local settleTime=xianmengdigongController:getNextSettleTime()

if not needReturn then
local isOverSettleTime=xianmengdigongController:checkIsOverSettleTime()
if not isOverSettleTime then

for i,v in pairs(auctionItemList)do
local addTime=v.add_time
if addTime>0 then
local auctionData={data=v,settleTime=settleTime}
local index
if not addAuctionTimeIndexList_lookup[addTime]then
index=#addAuctionItemList+1
addAuctionTimeIndexList_lookup[addTime]=index
else
index=addAuctionTimeIndexList_lookup[addTime]
end

if not addAuctionItemList[index]then
addAuctionItemList[index]={
addTime=addTime,
auctionList={},
}
end

table.insert(addAuctionItemList[index].auctionList,auctionData)

local isRead=xianmengdigongModel:getXMDG_newAuctionMsgAddTimeList(addTime)
if not isRead and not thisSettleTime then
thisSettleTime=settleTime
end
end
end
end

if not next(addAuctionItemList)then
needReturn=true
end
end


local addMsgNum=0
if not needReturn then

table.sort(addAuctionItemList,function(a,b)
return a.addTime<b.addTime
end)

if isInit then

for i,v in ipairs(addAuctionItemList)do
local auctionList=v.auctionList
xianmengdigongController:addNewAuctionMsg(auctionList)
addMsgNum=addMsgNum+1
end
else

local auctionList=addAuctionItemList[#addAuctionItemList].auctionList
xianmengdigongController:addNewAuctionMsg(auctionList)
addMsgNum=addMsgNum+1
end
xianmengdigongModel:setXMDG_newAddAuctionMsgList(addAuctionItemList)
end


if UIManager:isActive('UIXM_XMDG_AuctionWin')then

xianmengdigongController:clearAllNotReadMsgList()
end


xianmengdigongController:checkReadAddAuctionMsgNum(addMsgNum)

xianmengdigongController:setAuctionMsgAutoReadTimer(thisSettleTime)
end


function xianmengdigongController:checkReadAddAuctionMsgNum(addMsgNum)

local msgAuctionList=xianmengdigongModel:getXMDG_newAddAuctionMsgList()or{}
local originalNum=xianmengdigongModel:getXMDG_notReadAddAuctionMsgNum()


local nowNum=0
local nowTime=timeHelper.getServerLongTime()
for _,msgData in ipairs(msgAuctionList)do
local auctionList=msgData.auctionList
local addTime=msgData.addTime
local isNotRead=false

if not xianmengdigongModel:getXMDG_newAuctionMsgAddTimeList(addTime)then
for _,v in pairs(auctionList)do
local auctionData=v.data
local settleTime=v.settleTime
local auctionId=auctionData.idx

local nowAuctionData=xianmengdigongModel:getXMDG_auctionItemDataByIdx(auctionId)
if nowAuctionData then

if nowTime<settleTime or not auctionData.actor_id or mathHelper.compareInt64(auctionData.actor_id,int64.new(0))then
isNotRead=true
break
end
end
end
end

if isNotRead then
nowNum=nowNum+1
else

xianmengdigongModel:setXMDG_newAuctionMsgAddTimeList(addTime,true)
end
end

if not addMsgNum then
addMsgNum=0
end
local deltaNum=addMsgNum+originalNum-nowNum
xianmengdigongModel:setXMDG_notReadAddAuctionMsgNum(nowNum)
if deltaNum<0 then
deltaNum=0
end

local channelId=CHAT_CHANNNEL.eXianmeng
if deltaNum~=0 then

local nowXMMsgNum=chatControl.getNewestMesgNumByChannel(channelId)


local targetXMMsgNum=nowXMMsgNum-deltaNum

chatControl.setNewestMesgNumByChannel(channelId,targetXMMsgNum)
end


UIManager:callWindowFunc('UIFightMainTop','onReadNewestMesg')
chatControl.freshMain('onReadNewestMesg',channelId)
chatControl.freshChatMain('onReadNewestMesg',channelId)
chatControl.freshWorldChatMain('onReadNewestMesg',channelId)
end


function xianmengdigongController:setAuctionMsgAutoReadTimer(settleTime)
self:clearAuctionMsgAutoReadTimer()
if not settleTime then
return
end

local nowTime=gameUtilityModel.getServerLongTime()
if nowTime<settleTime then
local func=function()
local thisSettleTime=xianmengdigongController:getNextSettleTime()


xianmengdigongController:checkReadAddAuctionMsgNum()
return xianmengdigongController:setAuctionMsgAutoReadTimer(thisSettleTime)
end
local delayTime=settleTime-nowTime
self.auctionMsgAutoReadTimer=timer.new()
self.auctionMsgAutoReadTimer:start(delayTime,func,1)
end
end


function xianmengdigongController:clearAuctionMsgAutoReadTimer()
if self.auctionMsgAutoReadTimer then
self.auctionMsgAutoReadTimer:cancel()
self.auctionMsgAutoReadTimer=nil
end
end