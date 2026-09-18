







def_class("UIDailyTeHui_singleDayWin",UIWindowBase)









function UIDailyTeHui_singleDayWin:bindComponents()

self.accumulateDayText=UIText.get(self,0)
self.bannerShowItemList=UIObject.get(self,1)
self.getExRewardBtn=UIButton.get(self,2)
self.progressbar=UIProgress.get(self,3)
self.progressValue=UIObject.get(self,4)
self.libaoPanel=UIObject.get(self,5)
self.freeRewardBtn=UIButton.get(self,6)
self.freeRewardBtnReddot=UIObject.get(self,7)
self.oneKeyBuyPanel=UIObject.get(self,8)
self.oneKeyBuyBtn=UIButton.get(self,9)
self.oneKeyBuyBtnText=UIText.get(self,10)
self.discount=UIObject.get(self,11)
self.discountText=UIText.get(self,12)
self.gotExRewardFlag=UIObject.get(self,13)
self.getExRewardReddot=UIObject.get(self,14)
self.buyCountText=UIText.get(self,15)
self.bgModel=UIObject.get(self,16)

self.getExRewardBtn:setButtonClick(function()self:onGetExRewardBtn()end)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)

self.oneKeyBuyBtn:setButtonClick(function()self:onOneKeyBuyBtn()end)



end


function UIDailyTeHui_singleDayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.accumulateDayText);self.accumulateDayText=nil;
_UIObject_release(self.bannerShowItemList);self.bannerShowItemList=nil;
_UIObject_release(self.getExRewardBtn);self.getExRewardBtn=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.libaoPanel);self.libaoPanel=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.freeRewardBtnReddot);self.freeRewardBtnReddot=nil;
_UIObject_release(self.oneKeyBuyPanel);self.oneKeyBuyPanel=nil;
_UIObject_release(self.oneKeyBuyBtn);self.oneKeyBuyBtn=nil;
_UIObject_release(self.oneKeyBuyBtnText);self.oneKeyBuyBtnText=nil;
_UIObject_release(self.discount);self.discount=nil;
_UIObject_release(self.discountText);self.discountText=nil;
_UIObject_release(self.gotExRewardFlag);self.gotExRewardFlag=nil;
_UIObject_release(self.getExRewardReddot);self.getExRewardReddot=nil;
_UIObject_release(self.buyCountText);self.buyCountText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end

















local showLiBaoItemIndex={
[1]={1,nil,nil,nil},
[2]={1,nil,2,nil},
[3]={1,nil,2,3},
[4]={1,2,3,4},
}

local libaoItemCmpIndex={
buyBtn=0,
buyBtnText=1,
gotFlag=2,
rebate=3,
rebateText=4,
libaoName=5,
rewardShowItem={6,7,8,9}
}

local _this



function UIDailyTeHui_singleDayWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIDailyTeHui_singleDayWin:__delete()
self:doLocalMoveY(false)
self:unbindComponents()
_this=nil
end




function UIDailyTeHui_singleDayWin:onShow(argtable,afterOnloaded)
self.baseCfg=cfgHelper.get1(cfg_daydiscountsnewbasicconfig_get,1)
self.discountCfg=cfg_daydiscountsnewconfig()
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5212,1,{},eAnimationID.stand)
end
self:onShowArgRecv(argtable,afterOnloaded)
end


function UIDailyTeHui_singleDayWin:onHide()
self:doLocalMoveY(false)
end

function UIDailyTeHui_singleDayWin:onShowArgRecv(argtable,afterOnloaded)
if rechargeModel:checkDailyTeHuiSingleDayShowTipsWin()then

self:showWindow("UIDailyTeHui_singleDay_TipsWin")
else

rechargeModel:setDailyTeHuiSingleDayLastDailyBuyZmLv()
end

self:refresh(afterOnloaded)
end

function UIDailyTeHui_singleDayWin:refresh(isInit)

self:refreshBannerPanel()


self:refreshLiBaoPanel()


local isGotFreeReward=rechargeModel:checkDailyTeHuiSingleDayGotByIndex(1)
self.freeRewardBtn:setActive(not isGotFreeReward)



local isBoughtAnyLibao=rechargeController:checkDailyTeHuiSingleDayBoughtAnyLibao()
self:doLocalMoveY(not isBoughtAnyLibao)
self.oneKeyBuyPanel:setActive(not isBoughtAnyLibao)
if not isBoughtAnyLibao then

local recharge_id=self.baseCfg.recharge_id[pfwindowslController:getGameVersion()]or self.baseCfg.recharge_id[1]
local rechargecfg=cfg_rechargeconfig_get(recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.oneKeyBuyBtnText:setText(FMT.fmt("一键全购（{0}）",str))

local discount=self.baseCfg.onKeyBuyDiscount
local isShowDiscount=discount~=nil
self.discount:setActive(isShowDiscount)
if isShowDiscount then
self.discountText:setText(FMT.fmt("{0}折",discount))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.discountText:setText("Ưu Đãi")
end
end
end
end


function UIDailyTeHui_singleDayWin:refreshBannerPanel()

local acc_reward=self.baseCfg.acc_reward[pfwindowslController:getGameVersion()]or self.baseCfg.acc_reward[1]
local targetDayCount=acc_reward[1]
self.accumulateDayText:setText(targetDayCount)
local nowBoughtCount=rechargeModel:getDailyTeHuiSingleDayBuyCount()




self.buyCountText:setText(FMT.fmt("当前已全购：{0}/{1}",nowBoughtCount,targetDayCount))


local level=rechargeModel:getDailyTeHuiSingleDayShowExRewardZmLv()
local dropId=acc_reward[2]
local awardCfg=itemsAwardConfig:getAwardInConfigByLevel(dropId,level)
local rewards=awardCfg.showItems or{}

local grids=self.bannerShowItemList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local rewardData=rewards[i]

if rewardData then
local itemid=rewardData[1]
local count=rewardData[2]
if not count then
count=0
end
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=true,range=rewardData.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
item:SetChildActive(-1,false)
end
end


local isGotExReward=rechargeModel:checkDailyTeHuiSingleDayGotExReward()
self.getExRewardBtn:setActive(not isGotExReward)
self.gotExRewardFlag:setActive(isGotExReward)
if not isGotExReward then

local isCanGet=nowBoughtCount>=targetDayCount
self.getExRewardBtn:setChildImageExGray(not isCanGet)
self.getExRewardReddot:setActive(isCanGet)
else
self.getExRewardReddot:setActive(false)
end
end


function UIDailyTeHui_singleDayWin:refreshLiBaoPanel()

local level=rechargeModel:getDailyTeHuiSingleDayShowDailyBuyZmLv()
local grids=self.libaoPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local libaoIndex=i+1
local libaoCfg=self.discountCfg[libaoIndex]
if libaoCfg then
widget:SetChildActive(-1,true)

local libaoName=libaoCfg.libaoName
widget:SetChildText(libaoItemCmpIndex.libaoName,libaoName)


local rewardDropId=libaoCfg.drop_id[pfwindowslController:getGameVersion()]or libaoCfg.drop_id[1]
local awardCfg=itemsAwardConfig:getAwardInConfigByLevel(rewardDropId,level)
local rewards=awardCfg.showItems or{}
local rewardCount=#rewards
local libaoItemCount=#libaoItemCmpIndex.rewardShowItem
if rewardCount>libaoItemCount then
rewardCount=libaoItemCount
end
local showItemIndexList=showLiBaoItemIndex[rewardCount]
for i=1,libaoItemCount do
local libaoItemIndex=showItemIndexList[i]
if libaoItemIndex then
widget:SetChildActive(libaoItemCmpIndex.rewardShowItem[i],true)
local rewardData=rewards[libaoItemIndex]
local itemid=rewardData[1]
local count=rewardData[2]
if not count then
count=0
end
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,range=rewardData.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local itemWidget=widget:GetChildWidgetBase(libaoItemCmpIndex.rewardShowItem[i])
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(libaoItemCmpIndex.rewardShowItem[i],false)
end
end


local isGot=rechargeModel:checkDailyTeHuiSingleDayGotByIndex(libaoIndex)
widget:SetChildActive(libaoItemCmpIndex.gotFlag,isGot)


widget:SetChildActive(libaoItemCmpIndex.buyBtn,not isGot)
if not isGot then
local rechargeId=libaoCfg.recharge_id[pfwindowslController:getGameVersion()]or libaoCfg.recharge_id[1]

local rechargecfg=cfg_rechargeconfig_get(rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(libaoItemCmpIndex.buyBtnText,str)
widget:SetChildActive(libaoItemCmpIndex.buyBtn,true)


widget:SetChildButtonClick(libaoItemCmpIndex.buyBtn,function()
self:onBuyLiBaoBtnClick(rechargeId)
end)
end



local rebate=rechargeModel:getDailyTeHuiSingleDayRebateByLibaoId(libaoCfg.id)
local isShowRebate=rebate~=nil
widget:SetChildActive(libaoItemCmpIndex.rebate,isShowRebate)
if isShowRebate then
widget:SetChildText(libaoItemCmpIndex.rebateText,FMT.fmt("<size=26>{0}倍</size>\n收益",rebate))
end
else
widget:SetChildActive(-1,false)
end
end
end

function UIDailyTeHui_singleDayWin:doLocalMoveY(isFloat)
if isFloat then
if self.floatTweener==nil then
self.oneKeyBuyBtn:setLocalPosY(0)
local tweener=self.oneKeyBuyBtn:setChildDOLocalMoveY(10.0,1.5)
tweener:SetEase(_Ease.InOutSine)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.floatTweener=tweener
end
else
if self.floatTweener~=nil then
self.floatTweener:Complete()
self.floatTweener:Kill()
self.floatTweener=nil
self.oneKeyBuyBtn:setLocalPosY(0)
end
end
end




function UIDailyTeHui_singleDayWin:onGetExRewardBtn()
local acc_reward=self.baseCfg.acc_reward[pfwindowslController:getGameVersion()]or self.baseCfg.acc_reward[1]
local targetDayCount=acc_reward[1]
local nowBoughtCount=rechargeModel:getDailyTeHuiSingleDayBuyCount()
local isCanGet=nowBoughtCount>=targetDayCount
if isCanGet then

rechargeController:reqGetDailyTeHuiSingleDayRewardByIndex(0)
else
UIManager.error(FMT.fmt("累计{0}天购买全部特惠礼包可领取",targetDayCount))
end
end



function UIDailyTeHui_singleDayWin:onFreeRewardBtn()

rechargeController:reqGetDailyTeHuiSingleDayRewardByIndex(1)
end



function UIDailyTeHui_singleDayWin:onOneKeyBuyBtn()

local rechargeId=self.baseCfg.recharge_id[pfwindowslController:getGameVersion()]or self.baseCfg.recharge_id[1]
payControl.reqPay(rechargeId)
end


function UIDailyTeHui_singleDayWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIDailyTeHui_singleDayWin:onBuyLiBaoBtnClick(rechargeId)

payControl.reqPay(rechargeId)
end