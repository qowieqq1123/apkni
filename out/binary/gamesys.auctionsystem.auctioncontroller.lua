











auctionController=gameState.addListener({})




auctionController.data={}

local _serverType={
eLocal=0,
eCross=1,
}

local _auctionType={
eXianMeng=1,
ePlayer=2,
}

AUCTION_SERVER_TYPE=_serverType
AUCTION_AUCTION_TYPE=_auctionType


function auctionController:onAppStart()

auctionModel:onAppStart()



socketManager:register_receiver(21,1,auctionController.recv_21_1)
socketManager:register_receiver(21,2,auctionController.recv_21_2)
socketManager:register_receiver(21,3,auctionController.recv_21_3)
socketManager:register_receiver(21,5,auctionController.recv_21_5)
socketManager:register_receiver(21,6,auctionController.recv_21_6)
socketManager:register_receiver(21,7,auctionController.recv_21_7)
socketManager:register_receiver(21,8,auctionController.recv_21_8)
socketManager:register_receiver(21,14,auctionController.recv_21_14)

socketManager:register_receiver(21,21,auctionController.recv_21_21)
socketManager:register_receiver(21,22,auctionController.recv_21_22)
socketManager:register_receiver(21,23,auctionController.recv_21_23)
socketManager:register_receiver(21,24,auctionController.recv_21_24)
socketManager:register_receiver(21,25,auctionController.recv_21_25)
socketManager:register_receiver(21,26,auctionController.recv_21_26)

socketManager:register_receiver(21,30,auctionController.recv_21_30)

socketManager:register_receiver(21,35,auctionController.recv_21_35)
socketManager:register_receiver(21,36,auctionController.recv_21_36)
socketManager:register_receiver(21,37,auctionController.recv_21_37)
socketManager:register_receiver(21,38,auctionController.recv_21_38)

socketManager:register_receiver(21,15,auctionController.recv_21_15)
socketManager:register_receiver(21,16,auctionController.recv_21_16)
socketManager:register_receiver(21,17,auctionController.recv_21_17)
socketManager:register_receiver(21,18,auctionController.recv_21_18)






end


function auctionController:onEnterState(isReconnect)
auctionModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange_TYSC)
end


function auctionController:onProtocolReq()

end


function auctionController:onProtocolReqKF()


auctionController:checkAuctionEnter()

auctionController:reqPersonAuctionListData()

auctionController:reqCrossAuctionListData(AUCTION_SERVER_TYPE.eCross,AUCTION_AUCTION_TYPE.ePlayer,1,200)
end


function auctionController:onLeaveState(isReconnect)
auctionModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange_TYSC)


if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
self.data={}
end


function auctionController:onLostConnection()

end


function auctionController:onReConnection(isInitPro)

end



function auctionController:reqAuctionListData(serverType,auctionType,pageIdx,pageSize)
socketManager:send_21_1(serverType,auctionType,pageIdx,pageSize)
end


function auctionController:reqAuctionBiddingRecordList(serverType)
socketManager:send_21_2(serverType)
end


function auctionController:reqAuctionBidding(serverType,auctionType,auctionSeries,auctionPrice,auctionpwd)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end
socketManager:send_21_3(serverType,auctionType,auctionSeries,auctionPrice,auctionpwd or-1)
end


function auctionController:reqAuctionRecordList(auctionType)
socketManager:send_21_5(auctionType)
end


function auctionController:reqAuctionXianMengScore()
socketManager:send_21_6()
end


function auctionController:reqCrossAuctionListData(serverType,auctionType,pageIdx,pageSize)
socketManager:send_21_11(serverType,auctionType,pageIdx,pageSize)
end


function auctionController:reqCrossAuctionBiddingRecordList(serverType)
socketManager:send_21_12(serverType)
end


function auctionController:reqCrossAuctionBidding(serverType,auctionType,auctionSeries,auctionPrice,auctionpwd)
socketManager:send_21_13(serverType,auctionType,auctionSeries,auctionPrice,auctionpwd or-1)
end



function auctionController:reqPersonAuctionListData()

local isCross=auctionModel:checkPersonAuctionIsCrossModel()
if isCross then

socketManager:send_21_31()
else

socketManager:send_21_21()
end
end


function auctionController:reqPersonAuctionGrounding(itemguid,itemcount,auctionprice,auctionpwd,anonymous)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end
local isFreeze,left=ServerTransferModel:checkTransferServerFreezeAuction()
if isFreeze then
UIManager.error(string.format("库房受空间法则影响暂时无法上架，请在%s之后再次尝试",timeHelper.format_time_stamp11(left)))
return
end

local isCross=auctionModel:checkPersonAuctionIsCrossModel()
if isCross then

socketManager:send_21_32(itemguid,itemcount,auctionprice,auctionpwd or-1,anonymous)
else

socketManager:send_21_22(itemguid,itemcount,auctionprice,auctionpwd or-1,anonymous)
end
end


function auctionController:reqPersonAuctionCancelGrounding(auctionseries)

local isCross=auctionModel:checkPersonAuctionIsCrossModel()
if isCross then

socketManager:send_21_33(auctionseries)
else

socketManager:send_21_23(auctionseries)
end
end


function auctionController:reqPersonAuctionGroundingAgain(auctionseries,auctionprice,auctionpwd,anonymous)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end

local isCross=auctionModel:checkPersonAuctionIsCrossModel()
if isCross then

socketManager:send_21_34(auctionseries,auctionprice,auctionpwd or-1,anonymous)
else

socketManager:send_21_24(auctionseries,auctionprice,auctionpwd or-1,anonymous)
end
end


function auctionController:send_21_35(auctionseries,maxprice,auctionpwd)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end



socketManager:send_21_35(auctionseries,maxprice,auctionpwd)
end


function auctionController:send_21_36(auctionseries,maxprice)


socketManager:send_21_36(auctionseries,maxprice)
end


function auctionController:send_21_15(servertype,auctiontype,auctionseries,maxprice,auctionpwd)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end
socketManager:send_21_15(servertype,auctiontype,auctionseries,maxprice,auctionpwd)
end


function auctionController:send_21_16(servertype,auctiontype,auctionseries,maxprice)


socketManager:send_21_16(servertype,auctiontype,auctionseries,maxprice)
end



function auctionController.recv_21_1(argtable)
local serverType=argtable[1]
local auctionType=argtable[2]
local pageIdx=argtable[3]
local pageSize=argtable[4]
local totalPage=argtable[5]
local listLen=argtable[6]
local auctionList=argtable[7]
auctionModel:setAuctionListData(serverType,auctionType,listLen,auctionList)
if serverType==AUCTION_AUCTION_TYPE.ePlayer then

local guanzhuList=auctionModel:getAuctionItemGuanZhuStateList()
if guanzhuList and next(guanzhuList)then
for auctionSeriesStr,v in pairs(guanzhuList)do
local serverType_guanzhu=v.serverType
local auctionType_guanzhu=v.auctionType
local auctionSeries=int64.new(auctionSeriesStr)
local auctionItemData=auctionModel:getAuctionItemDataBySeries(serverType_guanzhu,auctionType_guanzhu,auctionSeries)
if not auctionItemData then
auctionModel:setAuctionItemGuanZhuState(serverType_guanzhu,auctionType_guanzhu,auctionSeries,nil)
end
end


auctionModel:saveAuctionItemGuanZhuStateList_WBSH()
end
end

local win
local isKeepPos=nil
if auctionType==AUCTION_AUCTION_TYPE.ePlayer then
win=UIManager:findActiveWindow('UIWanBaoShangHui_auctionWin')

local flag=auctionModel:getAuctionRefreshKeepPosFlag()
if flag then
isKeepPos=true
auctionModel:setAuctionRefreshKeepPosFlag(nil)
end
elseif auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
win=UIManager:findActiveWindow('UIAuctionWin')
end
if win then
win:refresh(isKeepPos)
end

if auctionModel:getNeedCheckEnterInRecvFlag()then

auctionModel:setNeedCheckEnterInRecvFlag(false)
auctionController:checkAuctionEnter(true)
end
end


function auctionController.recv_21_2(serverType,listLen,biddingRecordList)
auctionModel:setBiddingRecordListData(serverType,listLen,biddingRecordList)
end


function auctionController.recv_21_3(argtable)
local serverType=argtable[1]
local auctionType=argtable[2]
local auctionSeries=argtable[3]
local auctionPrice=argtable[4]
local auctionSec=argtable[5]
local times=argtable[6]
local res=argtable[7]

local lastData=auctionModel:getAuctionItemDataBySeries(serverType,auctionType,auctionSeries)
local isBuy=false
if lastData and auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
local itemId=lastData.itemid
local itemCount=lastData.itemcount
local itemConfig=itemsConfig.getConfig(itemId)

local singleBuyPrice=itemConfig.auction and itemConfig.auction[3]or nil
local buyPrice=singleBuyPrice and singleBuyPrice*itemCount or lastData.auctionprice
isBuy=auctionPrice>=buyPrice
end

auctionModel:setAuctionItemDataBySeries(serverType,auctionType,auctionSeries,auctionPrice,auctionSec,times,res,isBuy)

local isClose=false
if res==0 then

if auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList',{})
local auctionSeriesStr=tostring(auctionSeries)
auctionSelfBiddingList[auctionSeriesStr]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList',auctionSelfBiddingList)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAuction)
elseif auctionType==AUCTION_AUCTION_TYPE.ePlayer then

local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
local auctionSeriesStr=tostring(auctionSeries)
auctionSelfBiddingList[auctionSeriesStr]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',auctionSelfBiddingList)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAuction)
end

if isBuy then

UIManager.info("购买成功")

AudioManager.playAudio(514)
end
elseif res==1 then


local nowTime=gameUtilityModel.getServerShortTime()
local isEnd=false
if auctionSec then
local lerp=auctionSec-nowTime
if lerp<=0 then
isEnd=true
end
end
if isEnd then

UIManager.error("此拍卖品已经结束竞拍了")

if serverType==_serverType.eLocal then

auctionController:reqAuctionListData(serverType,auctionType,1,200)
elseif serverType==_serverType.eCross then

auctionController:reqCrossAuctionListData(serverType,auctionType,1,200)
end

isClose=true

auctionModel:setAuctionRefreshKeepPosFlag(true)
else
UIManager.error("该物品有新竞价")
end
elseif res==2 then

UIManager.error("密码错误")
end

local win
if auctionType==AUCTION_AUCTION_TYPE.ePlayer then
win=UIManager:findActiveWindow('UIWanBaoShangHui_auctionWin')
elseif auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
win=UIManager:findActiveWindow('UIAuctionWin')
end
if win then
win:refresh(true)
end

win=UIManager:findActiveWindow('UIAuctionBiddingWin')
if win then
win:onCommitCallBack(res,isClose)
end
end


function auctionController.recv_21_5(auctionType,listLen,recordList)
auctionModel:setAuctionRecordListData(auctionType,listLen,recordList)

local win=UIManager:findActiveWindow('UIAuctionRecordWin')
if win then
win:refresh()
end
end


function auctionController.recv_21_6(score)
auctionModel:setAuctionXianMengScore(score)

local win=UIManager:findActiveWindow('UIAuctionRecordWin')
if win then
win:refresh()
end
end


function auctionController.recv_21_7(serverType,auctionType)
if auctionType==AUCTION_AUCTION_TYPE.ePlayer then
return
end

local win=UIManager:findActiveWindow('UIAuctionWin')
if win then
UIManager.info("竞价被超")
else

local cur=mainControl:getSceneType()
local isShowNow=true
if cur~=eSceneType.eZongmen then

isShowNow=false
else
if not zongmenControl:isMountid(mapIdType.zhufeng)then

isShowNow=false
end
end


if isShowNow and MysteryModel:is_enter_Mystery()then

isShowNow=false
end

if isShowNow then

auctionController.showBubble()
else

auctionModel:setBubbleShowFlag(true)
end
end
end


function auctionController.recv_21_8(len,quotaList)
auctionModel:setQuotaListByServerType(_serverType.eLocal,len,quotaList)


local win=UIManager:findActiveWindow('UIAuctionWin')
if win then
win:refreshQuota()
end
end


function auctionController.recv_21_14(len,quotaList)
auctionModel:setQuotaListByServerType(_serverType.eCross,len,quotaList)


local win=UIManager:findActiveWindow('UIAuctionWin')
if win then
win:refreshQuota()
end

if not auctionModel:getTryGetCrossAuctionListFlag()then

auctionModel:setTryGetCrossAuctionListFlag(true)
auctionModel:setNeedCheckEnterInRecvFlag(true)
auctionController:reqCrossAuctionListData(_serverType.eCross,AUCTION_AUCTION_TYPE.eXianMeng,1,200)
end
end



function auctionController.recv_21_21(len,sellList)
auctionModel:setPersonAuctionSellListData(len,sellList)

local win=UIManager:findActiveWindow('UIWanBaoShangHui_sellWin')
if win then
win:refresh()
end
end


function auctionController.recv_21_22(sellItemData)

auctionModel:addPersonAuctionSellItem(sellItemData)


local win=UIManager:findActiveWindow('UIWanBaoShangHui_sellWin')
if win then
win:refreshSellItemListPanel()
end


UIManager.info("寄售成功")
end


function auctionController.recv_21_23(auctionseries,ret)
if ret==0 then


auctionModel:removePersonAuctionSellItem(auctionseries)


local win=UIManager:findActiveWindow('UIWanBaoShangHui_sellWin')
if win then
win:refreshSellItemListPanel()
end


UIManager.info("下架成功")
elseif ret==1 then

UIManager.error("已有人竞拍此物品，无法下架")
end
end


function auctionController.recv_21_24(auctionseries,newSellItemData)

auctionModel:removePersonAuctionSellItem(auctionseries)


auctionModel:addPersonAuctionSellItem(newSellItemData)


local win=UIManager:findActiveWindow('UIWanBaoShangHui_sellWin')
if win then
win:refreshSellItemListPanel()
end
UIManager.info("重新上架成功")
end


function auctionController.recv_21_25(auctionseries)

auctionModel:removePersonAuctionSellItem(auctionseries)

local win=UIManager:findActiveWindow('UIWanBaoShangHui_sellWin')
if win then
win:refreshSellItemListPanel()
end
end


function auctionController.recv_21_26(auctionseries,auctionsec)

auctionModel:setPersonAuctionSellItemEndTime(auctionseries,auctionsec)


local win=UIManager:findActiveWindow('UIWanBaoShangHui_sellWin')
if win then
win:refreshSellItemListPanel()
end
end


function auctionController.recv_21_30()
auctionModel:setPersonAuctionEnterCrossModel()
end



function auctionController.recv_21_35(_auctionSeries,_maxprice,res,auctionprice)
local serverType=AUCTION_SERVER_TYPE.eLocal
if auctionModel:checkPersonAuctionIsCrossModel()then
serverType=AUCTION_SERVER_TYPE.eCross
end
auctionModel:setAutoData(_auctionSeries,_maxprice,res,auctionprice,1,serverType,AUCTION_AUCTION_TYPE.ePlayer)
end


function auctionController.recv_21_36(_auctionSeries,_maxprice,res,auctionprice)
local serverType=AUCTION_SERVER_TYPE.eLocal
if auctionModel:checkPersonAuctionIsCrossModel()then
serverType=AUCTION_SERVER_TYPE.eCross
end
auctionModel:setAutoData(_auctionSeries,_maxprice,res,auctionprice,2,serverType,AUCTION_AUCTION_TYPE.ePlayer)
end


function auctionController.recv_21_37(auctionSeries,auctionprice)


local win=UIManager:findActiveWindow('UIWanBaoShangHui_auctionWin')
if win then
win:onRefreshBtn(true)
end
end


function auctionController.recv_21_38(auctionSeries)

local win=UIManager:findActiveWindow('UIWanBaoShangHui_auctionWin')
if win then
win:onRefreshBtn(true)
UIManager.info("竞价商品价格被超，预付款邮件返还")
end
end


function auctionController.recv_21_15(args)
local servertype,auctiontype,_auctionSeries,_maxprice,res,auctionprice=args[1],args[2],args[3],args[4],args[5],args[6]
auctionModel:setAutoData(_auctionSeries,_maxprice,res,auctionprice,1,servertype,auctiontype)
end


function auctionController.recv_21_16(args)
local servertype,auctiontype,_auctionSeries,_maxprice,res,auctionprice=args[1],args[2],args[3],args[4],args[5],args[6]
auctionModel:setAutoData(_auctionSeries,_maxprice,res,auctionprice,2,servertype,auctiontype)
end


function auctionController.recv_21_17(auctionSeries,auctionprice,servertype,auctiontype)


local win=UIManager:findActiveWindow('UIAuctionWin')
if win then
win:onRefreshBtn(true)
end
end


function auctionController.recv_21_18(auctionSeries,servertype,auctiontype)

local win=UIManager:findActiveWindow('UIAuctionWin')
if win then
win:onRefreshBtn(true)
UIManager.info("竞价商品价格被超，预付款邮件返还")
end
end















function auctionController:checkAuctionEnter(isRecv)
local auctionState=auctionModel:getAuctionState()
local isShowEnter=false

if auctionState==1 then
isShowEnter=true
elseif auctionState==2 then
if isRecv then

local auctionList=auctionModel:getAuctionListData(AUCTION_SERVER_TYPE.eCross,AUCTION_AUCTION_TYPE.eXianMeng)
if auctionList and next(auctionList)then

isShowEnter=true
end
end
elseif auctionState==0 then

local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList')
if auctionSelfBiddingList then

auctionController.removeSelfBiddingList()
end
end

if verifyManager:isHideWanBaoShangHui()then
return
end

if isShowEnter then

self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eAuction})
end

end


function auctionController:checkXianMenAuctionEnd()
local isEndXMAuction=false

local startTime,endTime,finalEndTime=auctionModel:getAuctionTime()

local cfg=cfgHelper.get(cfg_auctionconfig_get,1)
local xianmengAuctionDuration=cfg.duration[0][1]
if xianmengAuctionDuration then

local nowTime=gameUtilityModel.getServerLongTime()
local lerp=nowTime-startTime

if lerp>xianmengAuctionDuration then
isEndXMAuction=true
end
end

return isEndXMAuction
end


function auctionController:removeAuctionEnter()

enterManager:freshFunc('onClose',ENTER_TYPE.eAuction)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end

function auctionController.showBubble()
enterManager:freshFunc('ShowBubble',ENTER_TYPE.eAuction)
end

function auctionController.checkBubble()
if auctionModel:getBubbleShowFlag()then
enterManager:freshFunc('ShowBubble',ENTER_TYPE.eAuction)
end
end


function auctionController.removeSelfBiddingList()
userActorArraySetting.remove(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList')

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAuction)
end


function auctionController.onLimitActStateChange_TYSC(actID,state)
if actID~=LIMIT_ACT_TYPE.eTianYuanShouChao then return end
if state==limitActivitiesModel.actIdleState then

auctionModel:initAuctionTime(true)

auctionController:checkAuctionEnter()
end
end


function auctionController.openAuctionEnter_test()
auctionModel:initAuctionTime_test()
auctionController.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eAuction})
end


function auctionController:isEnoughBidding(serverType,auctionType,moneyCount)
local isEnough=false
local remainderQuota=auctionModel:getRemainderQuota(serverType,auctionType)
if remainderQuota>=moneyCount then
isEnough=true
end

return isEnough
end


function auctionController:checkEnoughPaySellCost(price,isWarning)
local isEnough=false
local costMoneyCount,costMoneyType=auctionModel:getPersonAuctionSellCostByPrice(price)
local warnType=isWarning and WARNING_TYPE.eWarning or nil
isEnough=moneySystem:useMoney(costMoneyType,costMoneyCount,function()return end,warnType)

return isEnough
end


function auctionController:checkIsBadeAuctionItem(auctionType,auctionSeries)
local isBade=false
if auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList',{})
local auctionSeriesStr=tostring(auctionSeries)
if auctionSelfBiddingList[auctionSeriesStr]then

isBade=true
end
elseif auctionType==AUCTION_AUCTION_TYPE.ePlayer then

local personAuctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
local auctionSeriesStr=tostring(auctionSeries)
if personAuctionSelfBiddingList[auctionSeriesStr]then

isBade=true
end
end

return isBade
end



