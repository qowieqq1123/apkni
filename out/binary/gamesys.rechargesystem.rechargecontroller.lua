












rechargeController=gameState.addListener({})









function rechargeController:onAppStart()
rechargeModel:onAppStart()


socketManager:register_receiver(14,1,rechargeController.recv_14_1)

socketManager:register_receiver(15,1,rechargeController.recv_15_1)
socketManager:register_receiver(15,2,rechargeController.recv_15_2)
socketManager:register_receiver(15,3,rechargeController.recv_15_3)
socketManager:register_receiver(15,11,rechargeController.recv_15_11)

socketManager:register_receiver(14,2,rechargeController.recv_14_2)
socketManager:register_receiver(14,3,rechargeController.recv_14_3)
socketManager:register_receiver(14,4,rechargeController.recv_14_4)
socketManager:register_receiver(14,10,rechargeController.recv_14_10)
socketManager:register_receiver(14,11,rechargeController.recv_14_11)

socketManager:register_receiver(14,12,rechargeController.recv_14_12)
socketManager:register_receiver(14,13,rechargeController.recv_14_13)
socketManager:register_receiver(14,14,rechargeController.recv_14_14)

socketManager:register_receiver(14,15,rechargeController.recv_14_15)
socketManager:register_receiver(14,16,rechargeController.recv_14_16)

socketManager:register_receiver(254,83,rechargeController.recv_254_83)

socketManager:register_receiver(15,75,rechargeController.recv_15_75)
socketManager:register_receiver(15,76,rechargeController.recv_15_76)

socketManager:register_receiver(15,81,rechargeController.recv_15_81)

socketManager:register_receiver(14,30,self.recv_14_30)
socketManager:register_receiver(14,31,self.recv_14_31)
socketManager:register_receiver(14,32,self.recv_14_32)

socketManager:register_receiver(14,41,self.recv_14_41)

end


function rechargeController:onEnterState()
rechargeModel:onEnterState()


rechargeController:clearExpireTimer()
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.onNewMonth,self.onNewMonth)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
end


function rechargeController:onServerDataInitFinish()
rechargeModel:onServerDataInitFinish()
end


function rechargeController:onLeaveState()
rechargeModel:onLeaveState()
rechargeController:clearExpireTimer()
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:removelistener(notifyConfig.onNewMonth,self.onNewMonth)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end


function rechargeController:onLostConnection()
rechargeController:clearExpireTimer()
end

function rechargeController:onOpenView(isReconnect)
if mainControl:isInScene(eSceneType.eZongmen)then
rechargeController:checkOpenMonthInvestorDailyWin()
end
end




function rechargeController:reqReChargeData()
socketManager:send_14_1()
end


function rechargeController:reqXianGouLiBaoData()
socketManager:send_15_1()
end


function rechargeController:reqXianGouLiBaoBuy(id,num,assistant)
socketManager:send_15_2(id,num,assistant or 0)
end


function rechargeController:reqXianGouLiBaoListBuy(list,assistant)
socketManager:send_15_3(#list,list,assistant or 0)
end


function rechargeController:reqMonthInvestorData()
socketManager:send_14_2()
end


function rechargeController:reqMonthInvestorGetReward(cardId)
socketManager:send_14_4(cardId)
end


function rechargeController:reqMonthInvestorExpire(cardId)
socketManager:send_14_9(cardId)
end


function rechargeController:reqMonthInvestorGetSmallGift(assistant)
socketManager:send_14_10(assistant or 0)
end


function rechargeController:reqMonthInvestorGetAccumulateMingSheng()
socketManager:send_14_11()
end


function rechargeController:reqGetDailyTeHuiRewardByIndex(index,assistant)
socketManager:send_14_14(index,assistant or 0)
end


function rechargeController:reqGetDailyTeHuiAllReward(assistant)


socketManager:send_14_14(0,assistant or 0)
end


function rechargeController:reqGetDailyTeHuiSingleDayRewardByIndex(index,assistant)
socketManager:send_14_16(index,assistant or 0)
end


function rechargeController:reqGuanYinGeOnekeyBuy(len,list,assistant)
socketManager:send_254_83(len,list,assistant or 0)
end


function rechargeController:reqBuySelectLiBao(libaoId,buyCount,indexList)
local len=#indexList
socketManager:send_15_76(libaoId,buyCount,len,indexList)
end


function rechargeController:reqBuyItemGiftPack(gift_id,item_guid,assistant)
socketManager:send_15_81(gift_id,item_guid,assistant or 0)
end




function rechargeController.recv_14_1(firstFlag,totalrecharge,dailyrecharge)
local lastTotalRecharge=rechargeModel:getTotalRecharge()
local lastDailyRecharge=rechargeModel:getDailyRecharge()
rechargeModel:initReCharge(firstFlag,totalrecharge,dailyrecharge)
payControl:initXianQuan()
local win=UIManager:findActiveWindow('UIReChargeWin')
if win then
win:refreshScrollerView()
end

local win=UIManager:findActiveWindow('UIZhenBaoGeFrontWin')
if win then
win:refreshView()
end


firstRechargeModel:initShowTabList(true)
firstRechargeNewModel:initShowTabList(true)
firstRecharge3Model:initShowTabList(true)

firstRechargeController:checkFirstRechargeEnter()

firstRechargeNewController:checkFirstRechargeEnter()

firstRecharge3Controller:checkFirstRechargeEnter()

superZuShiController:checkSuperZuShiEnter()
pfCommonHelper.onRechargeChange(lastTotalRecharge,totalrecharge)
notifySystem:postNotify(notifyConfig.onRecharge,firstFlag,lastTotalRecharge,totalrecharge,lastDailyRecharge,dailyrecharge)
end









function rechargeController.recv_14_2(len,cardList,xlbFlag)
rechargeModel:setCardList(len,cardList)
local smallGiftGotFlag=xlbFlag==1
rechargeModel:setMonthCardSmallGiftGotFlag(smallGiftGotFlag)

local win=UIManager:findActiveWindow('UIMonthInvestorWin')
if win then
win:refresh()
end

UIManager:callWindowFunc('UIZongmenInfoWin','refreshCatAccountBoookReddot')


local win=UIManager:findActiveWindow('UIMonthInvestorCatAccountBookWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)

if len>0 then

rechargeController:checkMinMonthCardExpireTime()
end


UIManager:invokeUIMethod('UICatEntrustWin','refreshAll')
end


function rechargeController.recv_14_3(cardItem)
rechargeModel:setCardItem(cardItem)
local win=UIManager:findActiveWindow('UIMonthInvestorWin')
if win then
win:refresh()
end

UIManager:callWindowFunc('UIZongmenInfoWin','refreshCatAccountBoookReddot')


local win=UIManager:findActiveWindow('UIMonthInvestorCatAccountBookWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_4(cardId,result)
local flag=result==0 and 1 or 0
if cardId==0 then

local allConfig=cfg_yuekaconfig()
for i,v in pairs(allConfig)do
local cardId=v.id
if rechargeModel:checkCardActive(cardId)then
rechargeModel:setCardGetReward(cardId,flag)
end
end
else

rechargeModel:setCardGetReward(cardId,flag)
end

local win=UIManager:findActiveWindow('UIMonthInvestorWin')
if win then
win:refresh()
end

UIManager:callWindowFunc('UIZongmenInfoWin','refreshCatAccountBoookReddot')

local win=UIManager:findActiveWindow('UIMonthInvestorDailyWin')
if win then

win:closeSelfDelay(0.5)
end


notifySystem:postNotify(notifyConfig.onYueKaReceive)


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_10()

rechargeModel:setMonthCardSmallGiftGotFlag(true)
local win=UIManager:findActiveWindow('UIMonthInvestorWin')
if win then
win:refresh()
end

UIManager:callWindowFunc('UIZongmenInfoWin','refreshCatAccountBoookReddot')


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_11(msVal_64)
local msVal=mathHelper.int64_to_number(msVal_64)
local originalMsVal=rechargeModel:getMonthCardAccumulateMingSheng()
rechargeModel:setMonthCardAccumulateMingSheng(msVal)

local needRefreshReddot=false
if msVal==0 and originalMsVal>0 then

local win=UIManager:findActiveWindow('UIMonthInvestorCatAccountBookWin')
if win then
win:closeSelf()
end


local win=UIManager:findActiveWindow('UIZongmenInfoWin')
if win then
win:refreshInfo()
end
needRefreshReddot=true
elseif msVal>0 and rechargeModel:checkCardActive(2)then
needRefreshReddot=true
end

if needRefreshReddot then

reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)


local win=UIManager:findActiveWindow('UIMonthInvestorWin')
if win then
win:refresh()
end

UIManager:callWindowFunc('UIZongmenInfoWin','refreshCatAccountBoookReddot')
end
end


function rechargeController.recv_14_12(buy_sec,gotFlag)
rechargeModel:setDailyTeHuiData(buy_sec,gotFlag)


local win=UIManager:findActiveWindow('UIDailyTeHuiWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_13(id,buy_sec)
if id==0 then

rechargeModel:setDailyTeHuiBuyTime(buy_sec)
else

rechargeModel:setDailyTeHuiGotFlagByIndex(id,true)
end


local win=UIManager:findActiveWindow('UIDailyTeHuiWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_14(gotFlag)
rechargeModel:setDailyTeHuiGotFlagByBitValue(gotFlag)


local win=UIManager:findActiveWindow('UIDailyTeHuiWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_15(gotFlag,buyCount,exRewardGotFlag,firstBuyZmLv,dailyBuyZmLv)
rechargeModel:setDailyTeHuiSingleDayData(gotFlag,buyCount,exRewardGotFlag,firstBuyZmLv,dailyBuyZmLv)


local win=UIManager:findActiveWindow('UIDailyTeHui_singleDayWin')
if win then
win:refresh()
end
UIManager:invokeUIMethod("UIDailyTeHui_singleDay_TipsWin","onBtnClose")


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_14_16(index,gotFlag)
if index==0 then
rechargeModel:setDailyTeHuiSingleDayExRewardGotFlag(true)
else
rechargeModel:setDailyTeHuiSingleDayGotFlagByBitValue(gotFlag)
end

local win=UIManager:findActiveWindow('UIDailyTeHui_singleDayWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end




function rechargeController.recv_15_1(len,array)
rechargeModel:initXianGouLiBao(len,array)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_15_2(id,num,assistant)

local config=cfgHelper.get1(cfg_limitedgiftconfig_get,id)
local gifttype=config.gifttype
if gifttype and gifttype==shopLibaoType.eGuangGao then
if rechargeModel:getGuanYinGeOneKeyBuy()then
return
end
end
rechargeModel:changeLiBaoBuyNum(id,num)
local win=UIManager:findActiveWindow('UIXianGouBuyDialogWin')
if win then
win:closeSelf()
end
local win1=UIManager:findActiveWindow('UIXianGouLiBaoWin')
if win1 then
win1:refreshScrollerView()

end

local win2=UIManager:findActiveWindow('UICommonMoneyGainWin')
if win2 then
win2:refreshGainList()
if UIManager:isActive('UIQuickBuyWin')then
win2:showQuickBuyWin()
end
end
if gifttype then
if gifttype==shopLibaoType.blueDiamondNewBieGift then

UIManager:invokeUIMethod("UIBlueDiamondNewBieGiftWin","refreshPanel")
elseif gifttype==shopLibaoType.blueDiamondDailyGift then

UIManager:invokeUIMethod("UIBlueDiamondDailyGiftWin","refreshPanel")
elseif gifttype==shopLibaoType.blueDiamondGrowUpGift then

UIManager:invokeUIMethod("UIBlueDiamondGrowUpGiftWin","refreshPanel")
end
end

local win3=UIManager:findActiveWindow('UIQQLobbyGiftWin')
if win3 then
win3:refreshAll()
qqLobbyActController:freshActEnter()
end

if assistant~=1 then


local rewards=rechargeModel:getXianGouLiBaoRewards(config.rewards)
local conf={}
for k,v in pairs(rewards)do
local itemId=v[1]
table.insert(conf,{itemid=itemId,num=v[2]*num})
end
if#conf>0 then
showPrizeControl.showWindowNow(conf)
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end


function rechargeController.recv_15_3(len,list,assistant)
if len==0 then
return
end
local rewardLookup={}
local gifttypeLookup={}
for i=1,len do
local id=list[i].param_1
local num=list[i].param_2

local config=cfgHelper.get1(cfg_limitedgiftconfig_get,id)

local gifttype=config.gifttype
if not gifttypeLookup[gifttype]then
gifttypeLookup[gifttype]=true
end

rechargeModel:changeLiBaoBuyNum(id,num)

local rewards=rechargeModel:getXianGouLiBaoRewards(config.rewards)
for k,v in pairs(rewards)do
local itemId=v[1]
rewardLookup[itemId]=(rewardLookup[itemId]or 0)+v[2]*num
end
end
local win=UIManager:findActiveWindow('UIXianGouBuyDialogWin')
if win then
win:closeSelf()
end
local win1=UIManager:findActiveWindow('UIXianGouLiBaoWin')
if win1 then
win1:refreshScrollerView()
end

local win2=UIManager:findActiveWindow('UICommonMoneyGainWin')
if win2 then
win2:refreshGainList()
if UIManager:isActive('UIQuickBuyWin')then
win2:showQuickBuyWin()
end
end
for gifttype,v in pairs(gifttypeLookup)do
if gifttype==shopLibaoType.blueDiamondNewBieGift then

UIManager:invokeUIMethod("UIBlueDiamondNewBieGiftWin","refreshPanel")
elseif gifttype==shopLibaoType.blueDiamondDailyGift then

UIManager:invokeUIMethod("UIBlueDiamondDailyGiftWin","refreshPanel")
elseif gifttype==shopLibaoType.blueDiamondGrowUpGift then

UIManager:invokeUIMethod("UIBlueDiamondGrowUpGiftWin","refreshPanel")
end
end

if assistant~=1 then
local conf={}
for itemId,num in pairs(rewardLookup)do
table.insert(conf,{itemid=itemId,num=num})
end

if#conf>0 then
showPrizeControl.showWindowNow(conf)
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end

function rechargeController.recv_15_11(flag)
rechargeModel:initZhenBaoGeData(flag)
local win=UIManager:findActiveWindow('UIZhenBaoGeFrontWin')
if win then
win:refreshView()
end
local win=UIManager:findActiveWindow('UIZhenBaoGeWin')
if win then
win:refreshScrollerView()
win:checkArrowBtn()
end
end


function rechargeController.recv_15_75(len,libaoDataList,resetDataLen,resetDataList)
rechargeModel:initSelectLiBaoData(len,libaoDataList,resetDataLen,resetDataList)


UIManager:invokeUIMethod("UISelectLiBaoWin","refresh")


reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end


function rechargeController.recv_15_76(libaoId,buyCount,len,selectList)
local buyNum=rechargeModel:getSelectLiBaoBuyNumByLiBaoId(libaoId)
buyNum=buyNum+buyCount
rechargeModel:setSelectLiBaoDataByLibaoId(libaoId,buyNum)


UIManager:invokeUIMethod("UISelectLiBaoWin","refresh")


reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end


function rechargeController.recv_15_81(gift_id,item_guid)

UIManager:closeWindow("UIItemBuyGiftPackWin")
end


function rechargeController:checkOpenMonthInvestorDailyWin()





end


function rechargeController:setExpireTimer()
self:clearExpireTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerLongTime()
local cardId=self.minExpireCard
local expireTime=self.minExpireTime
local lerp=expireTime and expireTime-nowTime or 0
if lerp<=0 then

rechargeController:reqMonthInvestorExpire(cardId)
notifySystem:postNotify(notifyConfig.onMonthInvestorExpire)


self.minExpireTime=nil
self.minExpireCard=nil


local allConfig=cfg_yuekaconfig()
for i,v in ipairs(allConfig)do
local cardExpireTime=rechargeModel:getCardExpireTime(v.id)
lerp=cardExpireTime and cardExpireTime-nowTime or 0
if lerp>0 and lerp<=86400 then
if not self.minExpireTime then
self.minExpireTime=cardExpireTime
self.minExpireCard=v.id
else

if cardExpireTime<self.minExpireTime then
self.minExpireTime=cardExpireTime
self.minExpireCard=v.id
end

end
elseif cardExpireTime and lerp==0 and v.id~=cardId then

rechargeController:reqMonthInvestorExpire(v.id)
end
end

if not self.minExpireTime then

self:clearExpireTimer()
end
end
end

self.expireTimer=timer.new()
self.expireTimer:start(1,func)

func()
end


function rechargeController:clearExpireTimer()
if self.expireTimer then
self.expireTimer:cancel()
self.expireTimer=nil
end
end


function rechargeController:checkMinMonthCardExpireTime()
self:clearExpireTimer()
self.minExpireTime=nil
self.minExpireCard=nil
local nowTime=gameUtilityModel.getServerLongTime()
local allConfig=cfg_yuekaconfig()
local lerp=0
for i,v in ipairs(allConfig)do
local cardExpireTime=rechargeModel:getCardExpireTime(v.id)
lerp=cardExpireTime and cardExpireTime-nowTime or 0
if lerp>0 and lerp<=86400 then
if not self.minExpireTime then
self.minExpireTime=cardExpireTime
self.minExpireCard=v.id
else

if cardExpireTime<self.minExpireTime then
self.minExpireTime=cardExpireTime
self.minExpireCard=v.id
end
end
elseif cardExpireTime and lerp<=0 then

rechargeController:reqMonthInvestorExpire(v.id)
end
end

if self.minExpireTime then

self:setExpireTimer()
end
end


function rechargeController:checkMonthCardHasDiscount(cardId)

local subActList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eYueKaZengLi)
if subActList and next(subActList)then
local subActInfo=subActList[1]
local cardType=cardId
return subActInfo:checkHasDiscount(cardType)
end

return false
end



function rechargeController:checkDailyTeHuiTenDayIsExpire()

local nowTime=gameUtilityModel.getServerLongTime()

local endTime=rechargeModel:getDailyTeHuiEndTime()or 0

local isExpire=endTime<=nowTime
return isExpire
end


function rechargeController:checkDailyTeHuiTenDayIsValid()

local nowTime=gameUtilityModel.getServerLongTime()

local endTime=rechargeModel:getDailyTeHuiEndTime()or 0

local buyTime=rechargeModel:getDailyTeHuiBuyTime()or 0

local isValid=buyTime<=nowTime and endTime>nowTime
return isValid
end


function rechargeController:checkDailyTeHuiIsGotAll()
local liBaoListCfg=cfg_daydiscountsconfig()
local isGotAll=true
local isValid=rechargeController:checkDailyTeHuiTenDayIsValid()
if isValid then

for i,v in ipairs(liBaoListCfg)do
if v.recharge_id and not rechargeModel:checkDailyTeHuiGotByIndex(v.id)then
isGotAll=false
break
end
end
end
return isGotAll
end


function rechargeController:checkDailyTeHuiSingleDayBoughtAnyLibao()
local libaoAllCfg=cfg_daydiscountsnewconfig()
for i,v in ipairs(libaoAllCfg)do
if v.recharge_id then

local isBought=rechargeModel:checkDailyTeHuiSingleDayGotByIndex(v.id)
if isBought then
return true
end
end
end
return false
end


function rechargeController.onNewDay()
if systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then

rechargeModel:resetDataDailyTeHuiOnNewDay()


local win=UIManager:findActiveWindow('UIDailyTeHuiWin')
if win then
win:refresh()
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eNewDayDiscounts)then

rechargeModel:resetDataDailyTeHuiSingleDayOnNewDay()


local win=UIManager:findActiveWindow('UIDailyTeHui_singleDayWin')
if win then
win:refresh()
end
end


rechargeModel:setDailyRecharge(0)

UIManager:invokeUIMethod('UIDailyRebateWin','refresh')

if systemModel.isOpen(SYSTEM_DEFINE.eCustomizedGift)then

rechargeModel:resetSelectLiBaoResetZmLevelByResetType(1)
rechargeModel:resetSelectLiBaoBuyNumDataByResetType(1)

UIManager:invokeUIMethod('UISelectLiBaoWin','refresh')

UIManager:closeWindow('UISelectLiBao_selectWin')
UIManager:closeWindow('UISelectLiBao_dialogWin')
reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end
end

function rechargeController.onNewWeek()
if systemModel.isOpen(SYSTEM_DEFINE.eCustomizedGift)then

rechargeModel:resetSelectLiBaoResetZmLevelByResetType(2)
rechargeModel:resetSelectLiBaoBuyNumDataByResetType(2)

UIManager:invokeUIMethod('UISelectLiBaoWin','refresh')

UIManager:closeWindow('UISelectLiBao_selectWin')
UIManager:closeWindow('UISelectLiBao_dialogWin')
reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end
end

function rechargeController.onNewMonth()
if systemModel.isOpen(SYSTEM_DEFINE.eCustomizedGift)then

rechargeModel:resetSelectLiBaoResetZmLevelByResetType(3)
rechargeModel:resetSelectLiBaoBuyNumDataByResetType(3)

UIManager:invokeUIMethod('UISelectLiBaoWin','refresh')

UIManager:closeWindow('UISelectLiBao_selectWin')
UIManager:closeWindow('UISelectLiBao_dialogWin')
reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end

end

function rechargeController.on_system_open(sysid)
if sysid==SYSTEM_DEFINE.eDayDiscounts and sysid==SYSTEM_DEFINE.eNewDayDiscounts then
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end

if systemModel.isOpen(SYSTEM_DEFINE.eCustomizedGift)then
reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end
end



function rechargeController.recv_254_83(len,list,assistant)
local flag=rechargeModel:getGuanYinGeOneKeyBuy()
if len>0 and flag then
local conf={}
for k,v in ipairs(list)do

rechargeModel:changeLiBaoBuyNum(tonumber(v.param_2),1)
local config=cfgHelper.get1(cfg_limitedgiftconfig_get,tonumber(v.param_2))
local rewards=rechargeModel:getXianGouLiBaoRewards(config.rewards)
for k,v in pairs(rewards)do
local itemId=v[1]
table.insert(conf,{itemid=itemId,num=v[2]*1})
end
end

if assistant==1 then
xiaoZhuShouDetailFunc.autoReceiveAdRewardShowPrize(nil,conf,{count=len})
xiaoZhuShouController:inserPrizeList(conf)
else
if#conf>0 then
showPrizeControl.showWindowNow(conf)
end
end

local win=UIManager:findActiveWindow('UIXianGouBuyDialogWin')
if win then
win:closeSelf()
end
local win1=UIManager:findActiveWindow('UIXianGouLiBaoWin')
if win1 then
win1:refreshScrollerView()
end
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end
rechargeModel:setGuanYinGeOneKeyBuy(false)
end


function rechargeController.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)
local item_id=cfg_advertconfig().const_def.itemid
if item_id and item_id==itemid then
local isopen=rechargeModel:checkXianGouLiBaoIsGuanYinQuan(shopLibaoType.eGuangGao)
if isopen then
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end
end
end



function rechargeController:doWeekCardEnter()
if rechargeModel:checkWeekCardEnterFlag()then
rechargeModel:markWeekCardEnterFlag()
reddotControl.on_change_catch_type(CATCH_TYPE.eWeekCard)
end
end


function rechargeController:send_14_30()
socketManager:send_14_30()
end


function rechargeController:send_14_31(id)
socketManager:send_14_31(id)
end


function rechargeController.recv_14_30(len,list)
rechargeModel:initWeekCardData(list)

reddotControl.on_change_catch_type(CATCH_TYPE.eWeekCard)
end


function rechargeController.recv_14_31(len,list)
if list then
for i,v in ipairs(list)do
rechargeModel:setWeakCardData(v)
end
end
notifySystem:postNotify(notifyConfig.onZhouKaReceive)
reddotControl.on_change_catch_type(CATCH_TYPE.eWeekCard)
end


function rechargeController.recv_14_32(data)
rechargeModel:setWeakCardData(data)

reddotControl.on_change_catch_type(CATCH_TYPE.eWeekCard)
end


function rechargeController.recv_14_41(rechargeId)
pfCommonHelper.reportRecharge(rechargeId)
end
