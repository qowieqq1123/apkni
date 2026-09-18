







def_class("UIMonthInvestorWin",UIWindowBase)









function UIMonthInvestorWin:bindComponents()

self.activeState=UIText.get(self,0)
self.autopanel=UIObject.get(self,1)
self.autopanelXYK=UIObject.get(self,2)
self.highMonthBuyDiscountFlag=UIObject.get(self,3)
self.highMonthBuyDiscountFlag2=UIImage.get(self,4)
self.highMonthCardBtn=UIButton.get(self,5)
self.highMonthCardBtnReddot=UIObject.get(self,6)
self.highMonthCardBtnText=UIText.get(self,7)
self.highMonthCardGotMark=UIText.get(self,8)
self.highMonthIncomeText=UIText.get(self,9)
self.highMonthOriginalPriceBg=UIObject.get(self,10)
self.highMonthOriginalPriceText=UIText.get(self,11)
self.highMonthPrivilegeScrollView=UIObject.get(self,12)
self.highMonthRenewalBtn=UIButton.get(self,13)
self.highMonthRenewalDiscountFlag=UIObject.get(self,14)
self.highMonthRenewalDiscountFlag2=UIImage.get(self,15)
self.highMonthRewardScrollView=UIObject.get(self,16)
self.highMonthTimeText=UIText.get(self,17)
self.jiehsobtn=UIButton.get(self,18)
self.jiehsobtnXYK=UIButton.get(self,19)
self.mingshengReddot=UIObject.get(self,20)
self.mingshengRewardBtn=UIButton.get(self,21)
self.monthBuyDiscountFlag=UIObject.get(self,22)
self.monthBuyDiscountFlag2=UIImage.get(self,23)
self.monthCardBtn=UIButton.get(self,24)
self.monthCardBtnReddot=UIObject.get(self,25)
self.monthCardBtnText=UIText.get(self,26)
self.monthCardGotMark=UIText.get(self,27)
self.monthIncomeText=UIText.get(self,28)
self.monthOriginalPriceBg=UIObject.get(self,29)
self.monthOriginalPriceText=UIText.get(self,30)
self.monthPrivilegeScrollView=UIObject.get(self,31)
self.monthRenewalBtn=UIButton.get(self,32)
self.monthRenewalDiscountFlag=UIObject.get(self,33)
self.monthRenewalDiscountFlag2=UIImage.get(self,34)
self.monthRewardScrollView=UIObject.get(self,35)
self.monthTimeText=UIText.get(self,36)
self.npcModel=UIObject.get(self,37)
self.smallGiftBtn=UIButton.get(self,38)
self.speakObj=UIObject.get(self,39)
self.speakText=UIText.get(self,40)
self.xudingbtn=UIButton.get(self,41)
self.xudingbtnXYK=UIButton.get(self,42)
self.xzsBtn=UIButton.get(self,43)
self.xzsTips=UIText.get(self,44)

self.highMonthCardBtn:setButtonClick(function()self:onHighMonthCardBtn()end)

self.highMonthRenewalBtn:setButtonClick(function()self:onHighMonthRenewalBtn()end)

self.jiehsobtn:setButtonClick(function()self:onJiehsobtn()end)

self.jiehsobtnXYK:setButtonClick(function()self:onJiehsobtnXYK()end)

self.mingshengRewardBtn:setButtonClick(function()self:onMingshengRewardBtn()end)

self.monthCardBtn:setButtonClick(function()self:onMonthCardBtn()end)

self.monthRenewalBtn:setButtonClick(function()self:onMonthRenewalBtn()end)

self.smallGiftBtn:setButtonClick(function()self:onSmallGiftBtn()end)

self.xudingbtn:setButtonClick(function()self:onXudingbtn()end)

self.xudingbtnXYK:setButtonClick(function()self:onXudingbtnXYK()end)

self.xzsBtn:setButtonClick(function()self:onXzsBtn()end)



end


function UIMonthInvestorWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeState);self.activeState=nil;
_UIObject_release(self.autopanel);self.autopanel=nil;
_UIObject_release(self.autopanelXYK);self.autopanelXYK=nil;
_UIObject_release(self.highMonthBuyDiscountFlag);self.highMonthBuyDiscountFlag=nil;
_UIObject_release(self.highMonthBuyDiscountFlag2);self.highMonthBuyDiscountFlag2=nil;
_UIObject_release(self.highMonthCardBtn);self.highMonthCardBtn=nil;
_UIObject_release(self.highMonthCardBtnReddot);self.highMonthCardBtnReddot=nil;
_UIObject_release(self.highMonthCardBtnText);self.highMonthCardBtnText=nil;
_UIObject_release(self.highMonthCardGotMark);self.highMonthCardGotMark=nil;
_UIObject_release(self.highMonthIncomeText);self.highMonthIncomeText=nil;
_UIObject_release(self.highMonthOriginalPriceBg);self.highMonthOriginalPriceBg=nil;
_UIObject_release(self.highMonthOriginalPriceText);self.highMonthOriginalPriceText=nil;
_UIObject_release(self.highMonthPrivilegeScrollView);self.highMonthPrivilegeScrollView=nil;
_UIObject_release(self.highMonthRenewalBtn);self.highMonthRenewalBtn=nil;
_UIObject_release(self.highMonthRenewalDiscountFlag);self.highMonthRenewalDiscountFlag=nil;
_UIObject_release(self.highMonthRenewalDiscountFlag2);self.highMonthRenewalDiscountFlag2=nil;
_UIObject_release(self.highMonthRewardScrollView);self.highMonthRewardScrollView=nil;
_UIObject_release(self.highMonthTimeText);self.highMonthTimeText=nil;
_UIObject_release(self.jiehsobtn);self.jiehsobtn=nil;
_UIObject_release(self.jiehsobtnXYK);self.jiehsobtnXYK=nil;
_UIObject_release(self.mingshengReddot);self.mingshengReddot=nil;
_UIObject_release(self.mingshengRewardBtn);self.mingshengRewardBtn=nil;
_UIObject_release(self.monthBuyDiscountFlag);self.monthBuyDiscountFlag=nil;
_UIObject_release(self.monthBuyDiscountFlag2);self.monthBuyDiscountFlag2=nil;
_UIObject_release(self.monthCardBtn);self.monthCardBtn=nil;
_UIObject_release(self.monthCardBtnReddot);self.monthCardBtnReddot=nil;
_UIObject_release(self.monthCardBtnText);self.monthCardBtnText=nil;
_UIObject_release(self.monthCardGotMark);self.monthCardGotMark=nil;
_UIObject_release(self.monthIncomeText);self.monthIncomeText=nil;
_UIObject_release(self.monthOriginalPriceBg);self.monthOriginalPriceBg=nil;
_UIObject_release(self.monthOriginalPriceText);self.monthOriginalPriceText=nil;
_UIObject_release(self.monthPrivilegeScrollView);self.monthPrivilegeScrollView=nil;
_UIObject_release(self.monthRenewalBtn);self.monthRenewalBtn=nil;
_UIObject_release(self.monthRenewalDiscountFlag);self.monthRenewalDiscountFlag=nil;
_UIObject_release(self.monthRenewalDiscountFlag2);self.monthRenewalDiscountFlag2=nil;
_UIObject_release(self.monthRewardScrollView);self.monthRewardScrollView=nil;
_UIObject_release(self.monthTimeText);self.monthTimeText=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.smallGiftBtn);self.smallGiftBtn=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.xudingbtn);self.xudingbtn=nil;
_UIObject_release(self.xudingbtnXYK);self.xudingbtnXYK=nil;
_UIObject_release(self.xzsBtn);self.xzsBtn=nil;
_UIObject_release(self.xzsTips);self.xzsTips=nil;
end
















local _this



local abname='ui/windows/recharge/monthcard_atlas_pak.ab'
local imagename=
{
"image_xianshizhekou",
"image_xianshizhekou_02",

}


function UIMonthInvestorWin:onLoaded(...)
_this=self
self:bindComponents()

local _onClickMonthRewardItem=function(...)
self:onClickRewardItem(1,...)
end
local _onClickHighMonthRewardItem=function(...)
self:onClickRewardItem(2,...)
end
local _onClickMonthPrivilegeItem=function(...)
self:onClickPrivilegeItem(1,...)
end
local _onClickHighMonthPrivilegeItem=function(...)
self:onClickPrivilegeItem(2,...)
end
self.monthRewardScrollView:setChildScrollViewInit(0.5,true,_onClickMonthRewardItem,nil)
self.highMonthRewardScrollView:setChildScrollViewInit(0.5,true,_onClickHighMonthRewardItem,nil)
self.monthPrivilegeScrollView:setChildScrollViewInit(0.5,true,_onClickMonthPrivilegeItem,nil)
self.highMonthPrivilegeScrollView:setChildScrollViewInit(0.5,true,_onClickHighMonthPrivilegeItem,nil)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:listenNotify(notifyConfig.subscriptionStatus,self.subscriptionStatusChange)
notifySystem:listenNotify(notifyConfig.payRet,self.GetpayRet)
self:initRefreshXuDing()
self:initRefreshXuDingXYK()
end


function UIMonthInvestorWin:__delete()
notifySystem:removelistener(notifyConfig.subscriptionStatus,self.subscriptionStatusChange)
notifySystem:removelistener(notifyConfig.payRet,self.GetpayRet)
self:mingShengBtnDoPunchRotation(false)
self:unbindComponents()
self:clearAllTimer()
if self.isgetbtnTimer then
self:stopTimerByID(self.isgetbtnTimer)
self.isgetbtnTimer=nil
end
_this=nil
end




function UIMonthInvestorWin:onShow(argtable,afterOnloaded)
self.monthInvestorCfg=cfg_yuekaconfig()
self.punchIntervalTime=5
self.isgetbtn=false
self:refreshScrollerView()
self:refreshPanel()
self:refreshNPCModel(true)
self:isShowPlatform()
self:isShowPlatformXYK()
self:refreshXZSText()
end


function UIMonthInvestorWin:onHide()
self:mingShengBtnDoPunchRotation(false)
self:clearAllTimer()
end



function UIMonthInvestorWin:refreshXZSText()
local baseCfg=cfgHelper.get1(cfg_xiaozhushoubaseconfig_get,1)
local gameVersion=pfwindowslController:getGameVersion()
local zmLevel=baseCfg.zmLv[gameVersion]or baseCfg.zmLv[1]
self.xzsTips:setText(string.format("宗门等级达到%d级后额外解锁<color=#7D3B17>执事助手</color>",zmLevel))
end

function UIMonthInvestorWin:onShowArgRecv()
self:refresh()
end

function UIMonthInvestorWin:refresh()
self:refreshScrollerView()
self:refreshPanel()
self:refreshNPCModel()

if _this.canpfshow then
local highMonthCfg=_this.monthInvestorCfg[2]
local czId=highMonthCfg.czId
platformSDK:reqSubscriptionStatus(czId)
end
if _this.canpfshowXYK then
local highMonthCfg=_this.monthInvestorCfg[1]
local czId=highMonthCfg.czId
platformSDK:reqSubscriptionStatus(czId)
end
end



function UIMonthInvestorWin:onMonthCardBtn()

local monthCfg=self.monthInvestorCfg[1]
local isActive=rechargeModel:checkCardActive(monthCfg.id)
if not isActive then
local havecount_xianshi=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[1])
local havecount_yongjiu=itemsModel.getCount(MonthCardController.data.itemid[3])
local czid
local guid=""
local hasDiscount,discountCzId=rechargeController:checkMonthCardHasDiscount(monthCfg.id)
if hasDiscount then
czid=discountCzId
elseif havecount_xianshi then
local itemid=MonthCardController.data.itemid[1]
czid=self:getCzidandGuid(itemid)
guid=havecount_xianshi
elseif havecount_yongjiu>0 then
local itemid=MonthCardController.data.itemid[3]
czid,guid=self:getCzidandGuid(itemid)
else
czid=monthCfg.czId
end
payControl.reqPay(czid,1,tostring(guid))
else



local isGetted=rechargeModel:checkCardGetReward(monthCfg.id)

if not isGetted then
rechargeController:reqMonthInvestorGetReward(monthCfg.id)
else
UIManager.info("今日已领取过奖励, 请明天再来")
end
end
end



function UIMonthInvestorWin:onHighMonthCardBtn()

local highMonthCfg=self.monthInvestorCfg[2]
local isActive=rechargeModel:checkCardActive(highMonthCfg.id)
if not isActive then
local havecount_xianshi=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[2])
local havecount_yongjiu=itemsModel.getCount(MonthCardController.data.itemid[4])
local czid
local guid=""
local hasDiscount,discountCzId=rechargeController:checkMonthCardHasDiscount(highMonthCfg.id)
if hasDiscount then
czid=discountCzId
elseif havecount_xianshi then
local itemid=MonthCardController.data.itemid[2]
czid=self:getCzidandGuid(itemid)
guid=havecount_xianshi
elseif havecount_yongjiu>0 then
local itemid=MonthCardController.data.itemid[4]
czid,guid=self:getCzidandGuid(itemid)
else
czid=highMonthCfg.czId
end
payControl.reqPay(czid,1,tostring(guid))
else



local isGetted=rechargeModel:checkCardGetReward(highMonthCfg.id)

if not isGetted then
rechargeController:reqMonthInvestorGetReward(highMonthCfg.id)
else
UIManager.info("今日已领取过奖励, 请明天再来")
end
end

end

function UIMonthInvestorWin:refreshScrollerView()
self:refreshMonthReward()
self:refreshHighMonthReward()
self:refreshMonthPrivilege()
self:refreshHighMonthPrivilege()
end

function UIMonthInvestorWin:refreshMonthReward()
local monthCfg=self.monthInvestorCfg[1]
self.monthRewardList=monthCfg.dayItems
self.monthRewardScrollView:setActive(true)
self.monthRewardScrollView:setChildScrollViewCreateGrids(#self.monthRewardList,#self.monthRewardList)

local grids=self.monthRewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.monthRewardList[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)

if itemid==2 and not self.monthDailyIncome then
self.monthDailyIncome=count
end
end
end
end

function UIMonthInvestorWin:refreshHighMonthReward()
local highMonthCfg=self.monthInvestorCfg[2]
self.highMonthRewardList=highMonthCfg.dayItems
self.highMonthRewardScrollView:setActive(true)
self.highMonthRewardScrollView:setChildScrollViewCreateGrids(#self.highMonthRewardList,#self.highMonthRewardList)

local grids=self.highMonthRewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.highMonthRewardList[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)

if itemid==2 and not self.highMonthDailyIncome then
self.highMonthDailyIncome=count
end
end
end
end

function UIMonthInvestorWin:refreshMonthPrivilege()
local monthCfg=self.monthInvestorCfg[1]
self.monthPrivilegeList=monthCfg.showItems
self.monthPrivilegeScrollView:setActive(true)
self.monthPrivilegeScrollView:setChildScrollViewCreateGrids(#self.monthPrivilegeList,#self.monthPrivilegeList)
local isActive,remainingTime=rechargeModel:checkCardActive(monthCfg.id)
local grids=self.monthPrivilegeScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.monthPrivilegeList[i]
local itemid=reward[1]
local count=reward[2]
local isPrivilegeItem=reward[3]and reward[3]==1 or false
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,range=reward.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)


item:SetChildActive(7,isPrivilegeItem and isActive)
end
end
end

function UIMonthInvestorWin:refreshHighMonthPrivilege()
local highMonthCfg=self.monthInvestorCfg[2]
self.highMonthPrivilegeList=highMonthCfg.showItems
self.highMonthPrivilegeScrollView:setActive(true)
self.highMonthPrivilegeScrollView:setChildScrollViewCreateGrids(#self.highMonthPrivilegeList,#self.highMonthPrivilegeList)
local isActive,remainingTime=rechargeModel:checkCardActive(highMonthCfg.id)

local grids=self.highMonthPrivilegeScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.highMonthPrivilegeList[i]
local itemid=reward[1]
local count=reward[2]
local isPrivilegeItem=reward[3]and reward[3]==1 or false
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,range=reward.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)

item:SetChildActive(7,isPrivilegeItem and isActive)
end
end
end


function UIMonthInvestorWin:onClickRewardItem(rewardType,clickCount,index)

local itemid=nil
local itemguid=nil

if rewardType==1 then

itemid=self.monthRewardList[index+1][1]
elseif rewardType==2 then

itemid=self.highMonthRewardList[index+1][1]
end

if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end


function UIMonthInvestorWin:onClickPrivilegeItem(privilegeType,clickCount,index)

local itemid=nil
local itemguid=nil

if privilegeType==1 then

itemid=self.monthPrivilegeList[index+1][1]
elseif privilegeType==2 then

itemid=self.highMonthPrivilegeList[index+1][1]
end

if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end

function UIMonthInvestorWin:refreshPanel()
self:refreshMonthCardPanel()
self:refreshHighMonthCardPanel()


if self.monthUpdate or self.highMonthUpdate then
self:setRemainingTimeTimer()
end


local isGotSmallGift=rechargeModel:getMonthCardSmallGiftGotFlag()
self.smallGiftBtn:setActive(not isGotSmallGift)


if not channelHelper.isXianLing()then
self:refreshMingshengBtn()
end

end

function UIMonthInvestorWin:refreshMonthCardPanel()
local monthCfg=self.monthInvestorCfg[1]
local hasDiscount,discountCzId=rechargeController:checkMonthCardHasDiscount(monthCfg.id)

local isActive,remainingTime=rechargeModel:checkCardActive(monthCfg.id)
local havecount_xianshi=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[1])
local havecount_yongjiu=itemsModel.getCount(MonthCardController.data.itemid[3])
if not isActive then



self.monthCardGotMark:setActive(false)
local czId=monthCfg.czId
local czCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)
local rmb
local str=pfwindowslController:showDesc_ByMoneyType(czCfg)
if hasDiscount then
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,discountCzId)
rmb=discountCzCfg.rmb

self.monthOriginalPriceText:setText(FMT.fmt("原价:{0}",str))
elseif havecount_xianshi then

self.monthOriginalPriceText:setText(FMT.fmt("原价:{0}",str))
local itemid=MonthCardController.data.itemid[1]
local czid=self:getCzidandGuid(itemid)
czCfg=cfgHelper.get(cfg_rechargeconfig_get,czid)
rmb=czCfg.rmb
elseif havecount_yongjiu>0 then

self.monthOriginalPriceText:setText(FMT.fmt("原价:{0}",str))
local itemid=MonthCardController.data.itemid[3]
local czid=self:getCzidandGuid(itemid)
czCfg=cfgHelper.get(cfg_rechargeconfig_get,czid)
rmb=czCfg.rmb
else
rmb=czCfg.rmb
end


self.monthOriginalPriceBg:setActive(hasDiscount or havecount_xianshi~=nil or havecount_yongjiu>0)
self.monthBuyDiscountFlag:setActive(hasDiscount)
self.monthRenewalDiscountFlag:setActive(false)

if rmb then
self.monthCardBtnText:setText(FMT.fmt('{0}投资',str))
end
self.monthCardBtn:setActive(true)

self.monthCardBtnReddot:setActive(false)

self.monthRenewalBtn:setActive(false)


if self.monthDailyIncome then
local monthIncome=self.monthDailyIncome*monthCfg.vaildTime
self.monthIncomeText:setActive(true)
self.monthIncomeText:setText(FMT.fmt("总计可获得 {0} 灵玉",monthIncome))
else
self.monthIncomeText:setActive(false)
end


self.monthUpdate=false
self.monthTimeText:setText(FMT.fmt("持续{0}天",monthCfg.vaildTime))
else


local isGot=rechargeModel:checkCardGetReward(monthCfg.id)

if isGot then
self.monthCardBtnText:setText('已领取')
else
self.monthCardBtnText:setText('领取')
end


self.monthOriginalPriceBg:setActive(false)
self.monthBuyDiscountFlag:setActive(false)
self.monthRenewalDiscountFlag:setActive(hasDiscount)


self.monthCardBtn:setActive(not isGot)
self.monthCardGotMark:setActive(isGot)

self.monthCardBtnReddot:setActive(not isGot)


local canRenewal=self:checkRenewal(1)

self.monthRenewalBtn:setActive(canRenewal)
if _this.canpfshowXYK then
self.monthRenewalBtn:setActive(false)
end


if self.monthDailyIncome then
local monthIncome=self.monthDailyIncome*monthCfg.vaildTime
self.monthIncomeText:setActive(true)
self.monthIncomeText:setText(FMT.fmt("总计可获得 {0} 灵玉",monthIncome))
else
self.monthIncomeText:setActive(false)
end


self.monthUpdate=true

if remainingTime then
self.monthTimeText:setText(FMT.fmt("剩余{0}",remainingTime))
end
end








self:judeZheKou(isActive)
end

function UIMonthInvestorWin:refreshHighMonthCardPanel()
local highMonthCfg=self.monthInvestorCfg[2]
local hasDiscount,discountCzId=rechargeController:checkMonthCardHasDiscount(highMonthCfg.id)


local isActive,remainingTime=rechargeModel:checkCardActive(highMonthCfg.id)

local havecount_xianshi=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[2])

local havecount_yongjiu=itemsModel.getCount(MonthCardController.data.itemid[4])
if not isActive then



self.highMonthCardGotMark:setActive(false)

local czId=highMonthCfg.czId
local czCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)
local rmb
local str=pfwindowslController:showDesc_ByMoneyType(czCfg)
if hasDiscount then
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,discountCzId)
rmb=discountCzCfg.rmb

self.highMonthOriginalPriceText:setText(FMT.fmt("原价:{0}",str))
elseif havecount_xianshi then

self.highMonthOriginalPriceText:setText(FMT.fmt("原价:{0}",str))
local itemid=MonthCardController.data.itemid[2]
local czid=self:getCzidandGuid(itemid)
czCfg=cfgHelper.get(cfg_rechargeconfig_get,czid)
rmb=czCfg.rmb
elseif havecount_yongjiu>0 then

self.highMonthOriginalPriceText:setText(FMT.fmt("原价:{0}",str))
local itemid=MonthCardController.data.itemid[4]
local czid,guid=self:getCzidandGuid(itemid)
czCfg=cfgHelper.get(cfg_rechargeconfig_get,czid)
rmb=czCfg.rmb

else
rmb=czCfg.rmb
end

self.highMonthOriginalPriceBg:setActive(hasDiscount or havecount_xianshi~=nil or havecount_yongjiu>0)
self.highMonthBuyDiscountFlag:setActive(hasDiscount)
self.highMonthRenewalDiscountFlag:setActive(false)

if rmb then
self.highMonthCardBtnText:setText(FMT.fmt('{0}投资',str))
end
self.highMonthCardBtn:setActive(true)

self.highMonthCardBtnReddot:setActive(false)

self.highMonthRenewalBtn:setActive(false)


if self.highMonthDailyIncome then
local highMonthIncome=self.highMonthDailyIncome*highMonthCfg.vaildTime
self.highMonthIncomeText:setActive(true)
self.highMonthIncomeText:setText(FMT.fmt("总计可获得 {0} 灵玉",highMonthIncome))
else
self.highMonthIncomeText:setActive(false)
end


self.highMonthUpdate=false
self.highMonthTimeText:setText(FMT.fmt("持续{0}天",highMonthCfg.vaildTime))

else


local isGot=rechargeModel:checkCardGetReward(highMonthCfg.id)

if isGot then
self.highMonthCardBtnText:setText('已领取')
else
self.highMonthCardBtnText:setText('领取')
end


self.highMonthOriginalPriceBg:setActive(false)
self.highMonthBuyDiscountFlag:setActive(false)
self.highMonthRenewalDiscountFlag:setActive(hasDiscount)


self.highMonthCardBtn:setActive(not isGot)
self.highMonthCardGotMark:setActive(isGot)

self.highMonthCardBtnReddot:setActive(not isGot)


local canRenewal=self:checkRenewal(2)

self.highMonthRenewalBtn:setActive(canRenewal)
if _this.canpfshow then
self.highMonthRenewalBtn:setActive(false)
end


if self.highMonthDailyIncome then
local highMonthIncome=self.highMonthDailyIncome*highMonthCfg.vaildTime
self.highMonthIncomeText:setActive(true)
self.highMonthIncomeText:setText(FMT.fmt("总计可获得 {0} 灵玉",highMonthIncome))
else
self.highMonthIncomeText:setActive(false)
end


self.highMonthUpdate=true

if remainingTime then
self.highMonthTimeText:setText(FMT.fmt("剩余{0}",remainingTime))
end

end









self:judehideZheKou(isActive)
end


function UIMonthInvestorWin:refreshMingshengBtn()
local highMonthActive=rechargeModel:checkCardActive(2)

local reddot=rechargeModel:checkMonthCardCatAccountReddot()
self.mingshengReddot:setActive(reddot)
local isShowMingshengBtn=not highMonthActive or reddot
self.mingshengRewardBtn:setActive(isShowMingshengBtn)
self:mingShengBtnDoPunchRotation(isShowMingshengBtn)
end


function UIMonthInvestorWin:refreshNPCModel(isInit)
local fadeTime=isInit and 0.5 or 0
local cfg=cfgHelper.get1(cfg_yuekanpcconfig_get,1)
self.speakContent_before=cfg.npcTalk_before
self.speakContent_after=cfg.npcTalk_after
local npcModelParms=cfg.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=cfg.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=cfg.npcTalkTime
self.npcTalkShowTime=cfg.npcTalkShowTime

local stateStr=rechargeModel:checkHasCardActive()and"已招商"or"招商"
self.activeState:setText(stateStr)


self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UIMonthInvestorWin:doSpeaking()
self:clearSpeakTimer()
local speakList={}

local isActiveCard=rechargeModel:checkHasCardActive()
if isActiveCard then
speakList=self.speakContent_after
else
speakList=self.speakContent_before
end

local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(2099)
self:doTalkAnim()
end


function UIMonthInvestorWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UIMonthInvestorWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
self.npcModel:setChildModelAnimationState(eAnimationID.stand)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end

function UIMonthInvestorWin:mingShengBtnDoPunchRotation(isShow)
if isShow then
if self.mingShengBtnTweener==nil then
self.mingshengRewardBtn:setRotation(0,0,0)
local tweener=self.mingshengRewardBtn:setChildDOPunchRotation(Vector3(0,0,15),2,6,1,function()
if _this==nil then return end
return _this:delayDo(_this.punchIntervalTime,function()
if _this==nil then return end
if _this.mingShengBtnTweener then
_this:mingShengBtnDoPunchRotation(false)
_this:mingShengBtnDoPunchRotation(isShow)
end
end)
end)
tweener:SetEase(_Ease.Linear)

self.mingShengBtnTweener=tweener
end
else
if self.mingShengBtnTweener~=nil then
self.mingShengBtnTweener:Complete()
self.mingShengBtnTweener:Kill()
self.mingShengBtnTweener=nil
self.mingshengRewardBtn:setRotation(0,0,0)
end
end
end



function UIMonthInvestorWin:onMonthRenewalBtn()

local monthCfg=self.monthInvestorCfg[1]
local czId=monthCfg.czId
local hasDiscount,discountCzId=rechargeController:checkMonthCardHasDiscount(monthCfg.id)
local czCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)

local originalRMB
local rmb,rmbStr

local havecount=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[1])
local havecount2=itemsModel.getCount(MonthCardController.data.itemid[3])
local guid=""

if hasDiscount then
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,discountCzId)
rmbStr=pfwindowslController:showDesc_ByMoneyType(discountCzCfg)
rmb=discountCzCfg.rmb
originalRMB=czCfg.rmb
czId=discountCzId
elseif havecount then

local itemid=MonthCardController.data.itemid[1]
czId=self:getCzidandGuid(itemid)
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)
rmb=discountCzCfg.rmb
rmbStr=pfwindowslController:showDesc_ByMoneyType(discountCzCfg)
originalRMB=czCfg.rmb
hasDiscount=true
guid=havecount
elseif havecount2>0 then

local itemid=MonthCardController.data.itemid[3]
czId,guid=self:getCzidandGuid(itemid)
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)
rmbStr=pfwindowslController:showDesc_ByMoneyType(discountCzCfg)
rmb=discountCzCfg.rmb
originalRMB=czCfg.rmb
hasDiscount=true
else
rmb=czCfg.rmb
end


local activeRewards=monthCfg.jhReward[5]
local extraCont=0
if activeRewards then
for i=1,#activeRewards do
if activeRewards[i][1]==3 then
extraCont=activeRewards[i][2]
break
end
end
end

local iconname=iconHelper.getIconName(3)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local str=FMT.fmt('   是否追加投资, 时长<color=#ed7d31>+{0}</color>天, 同时\n立即获得{1}{2}',monthCfg.vaildTime,iconStr,extraCont)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext=rmbStr,
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
payControl.reqPay(czId,1,tostring(guid))
end,
showclosebtn=true,

originalPrice=rmbStr,
hasDiscount=hasDiscount,
havecount=havecount,
havecount2=havecount2,
}


UIManager:showWindow('UIMonthInvestorBuyDialogWin',showdata)

end



function UIMonthInvestorWin:onHighMonthRenewalBtn()

local highMonthCfg=self.monthInvestorCfg[2]
local czId=highMonthCfg.czId
local hasDiscount,discountCzId=rechargeController:checkMonthCardHasDiscount(highMonthCfg.id)
local czCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)

local originalRMB
local rmb,rmbStr
local havecount=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[2])
local havecount2=itemsModel.getCount(MonthCardController.data.itemid[4])
local guid=""

if hasDiscount then
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,discountCzId)
rmbStr=pfwindowslController:showDesc_ByMoneyType(discountCzCfg)
rmb=discountCzCfg.rmb
originalRMB=czCfg.rmb
czId=discountCzId
elseif havecount then

local itemid=MonthCardController.data.itemid[2]
czId=self:getCzidandGuid(itemid)
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)
rmbStr=pfwindowslController:showDesc_ByMoneyType(discountCzCfg)
rmb=discountCzCfg.rmb
originalRMB=czCfg.rmb
hasDiscount=true
guid=havecount
elseif havecount2>0 then

local itemid=MonthCardController.data.itemid[4]
czId,guid=self:getCzidandGuid(itemid)
local discountCzCfg=cfgHelper.get(cfg_rechargeconfig_get,czId)
rmbStr=pfwindowslController:showDesc_ByMoneyType(discountCzCfg)
rmb=discountCzCfg.rmb
originalRMB=czCfg.rmb
hasDiscount=true
else
rmb=czCfg.rmb
end

local activeRewards=highMonthCfg.jhReward[5]
local extraCont=0
if activeRewards then
for i=1,#activeRewards do
if activeRewards[i][1]==3 then
extraCont=activeRewards[i][2]
break
end
end
end

local iconname=iconHelper.getIconName(3)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local str=FMT.fmt('   是否追加投资, 时长<color=#ed7d31>+{0}</color>天, 同时\n立即获得{1}{2}',highMonthCfg.vaildTime,iconStr,extraCont)
local showdata=
{
title='提示',
content=str,
oktext=rmbStr,
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
payControl.reqPay(czId,1,tostring(guid))
end,
showclosebtn=true,

originalPrice=rmbStr,
hasDiscount=hasDiscount,
havecount=havecount,
havecount2=havecount2,
}


UIManager:showWindow('UIMonthInvestorBuyDialogWin',showdata)
end


function UIMonthInvestorWin:clearAllTimer()
if self.remainingTimer then
self:stopTimerByID(self.remainingTimer)
self.remainingTimer=nil
end

if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UIMonthInvestorWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UIMonthInvestorWin:clearRemainingTimer()
if self.remainingTimer then
self:stopTimerByID(self.remainingTimer)
self.remainingTimer=nil
end
end


function UIMonthInvestorWin:setRemainingTimeTimer()
self:clearRemainingTimer()
local func=function()

if self.monthUpdate then
local monthActive,monthRemainingTime=rechargeModel:checkCardActive(1)
if monthActive then
self.monthTimeText:setText(FMT.fmt("剩余{0}",monthRemainingTime))
else
self:refresh()
end

end

if self.highMonthUpdate then
local highMonthActive,highMonthRemainingTime=rechargeModel:checkCardActive(2)
if highMonthActive then
self.highMonthTimeText:setText(FMT.fmt("剩余{0}",highMonthRemainingTime))
else
self:refresh()
end
end


if not self.monthUpdate and not self.highMonthUpdate then
self:clearRemainingTimer()
self:refresh()
end
end
self.remainingTimer=self:setTimer(1,0,func)
end


function UIMonthInvestorWin:checkRenewal(type)

local cardCfg=nil
if type==1 then
cardCfg=self.monthInvestorCfg[1]
elseif type==2 then
cardCfg=self.monthInvestorCfg[2]
end
local canRenewal=true


if cardCfg.maxVaildTime then

local remainingDay=rechargeModel:getCardRemainDay(cardCfg.id)


local tmpDay=remainingDay+cardCfg.vaildTime
if tmpDay>cardCfg.maxVaildTime then

canRenewal=false
end
end

return canRenewal
end


function UIMonthInvestorWin:onNPCClick()
self:doSpeaking()
end




function UIMonthInvestorWin:onSmallGiftBtn()
if not rechargeModel:getMonthCardSmallGiftGotFlag()then

rechargeController:reqMonthInvestorGetSmallGift()
else

UIManager.error("您已经领取过该礼包了")
end

end



function UIMonthInvestorWin:onMingshengRewardBtn()
UIFullRechargeController:showMonthInvestorCatAccountBookWin()
end

function UIMonthInvestorWin.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end
if subType==SUB_ACTIVITY_TYPE.eYueKaZengLi then
if state==activitiesModel.activityFinishState then
return _this:refresh()
end
end
end

function UIMonthInvestorWin.test_changePunchIntervalTime(time)
if _this==nil then return end
_this.punchIntervalTime=time
end



function UIMonthInvestorWin:initRefreshXuDing()
local monthInvestorCfg=cfg_yuekaconfig()
local highMonthCfg=monthInvestorCfg[2]
local czId=highMonthCfg.czId
local pfid=loginModel:getPfid()
local cfg_pfidList=cfg_yuekadingyueconfig_get(1).platform
local isshow=cfg_pfidList[pfid]
_this.canpfshow=isshow
if isshow then
platformSDK:reqSubscriptionStatus(czId)
end
end

function UIMonthInvestorWin:isShowPlatform()
if _this.canpfshow then
_this.autopanel:setActive(true)
local highMonthCfg=_this.monthInvestorCfg[2]
local czId=highMonthCfg.czId
local flag=payControl:getSubscriptionStatus(czId)
loggerUtil.log(FMT.fmt("UIMonthInvestorWin isShowPlatform {0} {1}",czId,flag))
if flag then
_this.winlua:SetChildGray(_this.xudingbtn:getID(),true)
_this.highMonthRenewalBtn:setActive(false)
else
_this.winlua:SetChildGray(_this.xudingbtn:getID(),false)
_this.highMonthRenewalBtn:setActive(false)
end
else
_this.autopanel:setActive(false)
end
end

function UIMonthInvestorWin.subscriptionStatusChange(id,status)
local highMonthCfg=_this.monthInvestorCfg[2]
local czId=highMonthCfg.czId
if _this.canpfshow and id==czId then
local flag=false
if czId==id then
flag=payControl:getSubscriptionStatus(id)
end
loggerUtil.log(FMT.fmt("UIMonthInvestorWin subscriptionStatusChange {0}-{1}-{2}",id,czId,flag))
if flag then
_this.winlua:SetChildGray(_this.xudingbtn:getID(),true)
_this.highMonthRenewalBtn:setActive(false)
else
_this.winlua:SetChildGray(_this.xudingbtn:getID(),false)
_this.highMonthRenewalBtn:setActive(false)
end
end

local MonthCfg=_this.monthInvestorCfg[1]
local czId2=MonthCfg.czId
if _this.canpfshowXYK and czId2==id then
local flag=false
if czId2==id then
flag=payControl:getSubscriptionStatus(id)
end
loggerUtil.log(FMT.fmt("UIMonthInvestorWin subscriptionStatusChangeXYK {0}-{1}-{2}",id,czId,flag))
if flag then
_this.winlua:SetChildGray(_this.xudingbtnXYK:getID(),true)
_this.monthRenewalBtn:setActive(false)
else
_this.winlua:SetChildGray(_this.xudingbtnXYK:getID(),false)
_this.monthRenewalBtn:setActive(false)
end
end
end

function UIMonthInvestorWin.GetpayRet(flag)
loggerUtil.log(FMT.fmt("UIMonthInvestorWin GetpayRet {0}",flag))
if _this.canpfshow then
if flag then
local highMonthCfg=_this.monthInvestorCfg[2]
local czId=highMonthCfg.czId
platformSDK:reqSubscriptionStatus(czId)
end
end
if _this.canpfshowXYK then
loggerUtil.log(FMT.fmt("UIMonthInvestorWin GetpayRetXYK {0}",flag))
if flag then
local MonthCfg=_this.monthInvestorCfg[1]
local czId=MonthCfg.czId
platformSDK:reqSubscriptionStatus(czId)
end
end
end

function UIMonthInvestorWin:onJiehsobtn()
local pfid=loginModel:getPfid()
local cfg_pfidList=cfg_yuekadingyueconfig_get(1).platformdesc
local _desc=cfg_pfidList[pfid]
local d={}
d.title='自动续费服务协议'
d.mode=3
d.name=_desc
UIManager:showWindow('UIMonthRuleWin',d)
end

function UIMonthInvestorWin:onXudingbtn()
if _this.canpfshow then
if _this.isgetbtn then
UIManager.error('祖师点击太频繁，请稍后')
return
end
if not _this.isgetbtn then
local highMonthCfg=_this.monthInvestorCfg[2]
local czId=highMonthCfg.czId
local flag=payControl:getSubscriptionStatus(czId)
loggerUtil.log(FMT.fmt("UIMonthInvestorWin onXudingbtn {0}{1}",czId,flag))
if flag then
UIManager.info('已自动续订')
else
payControl.reqPay(czId,nil,nil,true)
UIMonthInvestorWin:testgetXuDingStage(czId,true)
UIMonthInvestorWin:testgetGouMaiStage(true)
end
_this.isgetbtn=true
end

if not _this.isgetbtnTimer and _this.isgetbtn==true then
_this.isgetbtnTimer=_this:delayDo(4,function()
if _this==nil then return end
_this.isgetbtnTimer=nil
_this.isgetbtn=false
end)
end

end
end



function UIMonthInvestorWin:initRefreshXuDingXYK()
local monthInvestorCfg=cfg_yuekaconfig()
local MonthCfg=monthInvestorCfg[1]
local czId=MonthCfg.czId
local pfid=loginModel:getPfid()
local cfg_pfidList=cfg_yuekadingyueconfig_get(2).platform
local isshow=cfg_pfidList[pfid]
_this.canpfshowXYK=isshow
if isshow then
platformSDK:reqSubscriptionStatus(czId)
end
end

function UIMonthInvestorWin:isShowPlatformXYK()
if _this.canpfshowXYK then
_this.autopanelXYK:setActive(true)
local MonthCfg=_this.monthInvestorCfg[1]
local czId=MonthCfg.czId
local flag=payControl:getSubscriptionStatus(czId)
loggerUtil.log(FMT.fmt("UIMonthInvestorWin isShowPlatformXYK {0} {1}",czId,flag))
if flag then
_this.winlua:SetChildGray(_this.xudingbtnXYK:getID(),true)
_this.monthRenewalBtn:setActive(false)
else
_this.winlua:SetChildGray(_this.xudingbtnXYK:getID(),false)
_this.monthRenewalBtn:setActive(false)
end
else
_this.autopanelXYK:setActive(false)
end
end

function UIMonthInvestorWin.subscriptionStatusChangeXYK(id,status)
if _this.canpfshowXYK then
local MonthCfg=_this.monthInvestorCfg[1]
local czId=MonthCfg.czId
local flag=false
if czId==id then
flag=payControl:getSubscriptionStatus(id)
end
loggerUtil.log(FMT.fmt("UIMonthInvestorWin subscriptionStatusChangeXYK {0}-{1}-{2}",id,czId,flag))
if flag then
_this.winlua:SetChildGray(_this.xudingbtn:getID(),true)
_this.highMonthRenewalBtn:setActive(false)
else
_this.winlua:SetChildGray(_this.xudingbtn:getID(),false)
_this.highMonthRenewalBtn:setActive(false)
end
end
end

function UIMonthInvestorWin.GetpayRetXYK(flag)
loggerUtil.log(FMT.fmt("UIMonthInvestorWin GetpayRetXYK {0}",flag))
if _this.canpfshowXYK then
if flag then
local MonthCfg=_this.monthInvestorCfg[1]
local czId=MonthCfg.czId
platformSDK:reqSubscriptionStatus(czId)
end
end
end

function UIMonthInvestorWin:onJiehsobtnXYK()
local pfid=loginModel:getPfid()
local cfg_pfidList=cfg_yuekadingyueconfig_get(2).platformdesc
local _desc=cfg_pfidList[pfid]
local d={}
d.title='自动续费服务协议'
d.mode=3
d.name=_desc
UIManager:showWindow('UIMonthRuleWin',d)
end

function UIMonthInvestorWin:onXudingbtnXYK()
if _this.canpfshowXYK then
if _this.isgetbtnXYK then
UIManager.error('祖师点击太频繁，请稍后')
return
end
if not _this.isgetbtnXYK then
local MonthCfg=_this.monthInvestorCfg[1]
local czId=MonthCfg.czId
local flag=payControl:getSubscriptionStatus(czId)
loggerUtil.log(FMT.fmt("UIMonthInvestorWin onXudingbtnXYK {0}{1}",czId,flag))
if flag then
UIManager.info('已自动续订')
else
payControl.reqPay(czId,nil,nil,true)
UIMonthInvestorWin:testgetXuDingStage(czId,true)
UIMonthInvestorWin:testgetGouMaiStage(true)
end
_this.isgetbtnXYK=true
end

if not _this.isgetbtnTimer2 and _this.isgetbtnXYK==true then
_this.isgetbtnTimer2=_this:delayDo(4,function()
if _this==nil then return end
_this.isgetbtnTimer2=nil
_this.isgetbtnXYK=false
end)
end

end
end

function UIMonthInvestorWin:onXzsBtn()
if xiaoZhuShouController:checkXiaoZhuShouVisiable(true)then
UIFullRechargeController:closeUI()
UIManager:showWindow("UIXiaoZhuShouWin")
end
end




function UIMonthInvestorWin:testgetXuDingStage(id,status)
if not deviceHelper.isRunNoneOrEditor()then return end
if status==false then
payControl.subscriptionData[id]=true
end
payControl:setSubscriptionStatus(id,status)
end

function UIMonthInvestorWin:testgetGouMaiStage(flag)
if not deviceHelper.isRunNoneOrEditor()then return end
notifySystem:postNotify(notifyConfig.payRet,flag)
end


function UIMonthInvestorWin:judeZheKou(isGot)
local havecount_xianshi=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[1])
local havecount_yongjiu=itemsModel.getCount(MonthCardController.data.itemid[3])

self.monthRenewalDiscountFlag2:setActive(false)
self.monthBuyDiscountFlag2:setActive(false)
if isGot then

if havecount_xianshi then
self.monthRenewalDiscountFlag2:setActive(true)
self.monthRenewalDiscountFlag2:setSprite(abname,imagename[1])
elseif havecount_yongjiu>0 then
self.monthRenewalDiscountFlag2:setActive(true)
self.monthRenewalDiscountFlag2:setSprite(abname,imagename[2])
end
else

if havecount_xianshi then
self.monthBuyDiscountFlag2:setActive(true)
self.monthBuyDiscountFlag2:setSprite(abname,imagename[1])
elseif havecount_yongjiu>0 then
self.monthBuyDiscountFlag2:setActive(true)
self.monthBuyDiscountFlag2:setSprite(abname,imagename[2])
end
end
end


function UIMonthInvestorWin:judehideZheKou(isGot)
local havecount_xianshi2=MonthCardController:judeNotExpireItem(MonthCardController.data.itemid[2])

local havecount_yongjiu2=itemsModel.getCount(MonthCardController.data.itemid[4])
self.highMonthRenewalDiscountFlag2:setActive(false)
self.highMonthBuyDiscountFlag2:setActive(false)
if isGot then
if havecount_xianshi2 then
self.highMonthRenewalDiscountFlag2:setActive(true)
self.highMonthRenewalDiscountFlag2:setSprite(abname,imagename[1])
elseif havecount_yongjiu2>0 then
self.highMonthRenewalDiscountFlag2:setActive(true)
self.highMonthRenewalDiscountFlag2:setSprite(abname,imagename[2])
end
else
if havecount_xianshi2 then
self.highMonthBuyDiscountFlag2:setActive(true)
self.highMonthBuyDiscountFlag2:setSprite(abname,imagename[1])
elseif havecount_yongjiu2>0 then
self.highMonthBuyDiscountFlag2:setActive(true)
self.highMonthBuyDiscountFlag2:setSprite(abname,imagename[2])
end
end

end


function UIMonthInvestorWin:getCzidandGuid(itemid)

local item_cfg=itemsConfig.getConfig(itemid)
local funcparam=item_cfg.funcparam
local czid=funcparam.czid


local item,guid=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
return czid,guid
end
