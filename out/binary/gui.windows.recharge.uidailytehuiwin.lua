







def_class("UIDailyTeHuiWin",UIWindowBase)









function UIDailyTeHuiWin:bindComponents()

self.freeRewardBtn=UIButton.get(self,0)
self.getAllRewardBtn=UIButton.get(self,1)
self.libaoPanel=UIObject.get(self,2)
self.notBuyBanner=UIObject.get(self,3)
self.boughtBanner=UIObject.get(self,4)
self.bannerShowItemList=UIObject.get(self,5)
self.remainingDayText=UIText.get(self,6)
self.buyTenDayBtn=UIButton.get(self,7)
self.discount=UIObject.get(self,8)
self.discountText=UIText.get(self,9)
self.buyTenDayBtnText=UIText.get(self,10)
self.freeRewardBtnReddot=UIObject.get(self,11)
self.npcPanel=UIObject.get(self,12)
self.npcModel=UIObject.get(self,13)
self.speakObj=UIObject.get(self,14)
self.speakText=UIText.get(self,15)
self.bgModel=UIObject.get(self,16)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)

self.getAllRewardBtn:setButtonClick(function()self:onGetAllRewardBtn()end)

self.buyTenDayBtn:setButtonClick(function()self:onBuyTenDayBtn()end)



end


function UIDailyTeHuiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.getAllRewardBtn);self.getAllRewardBtn=nil;
_UIObject_release(self.libaoPanel);self.libaoPanel=nil;
_UIObject_release(self.notBuyBanner);self.notBuyBanner=nil;
_UIObject_release(self.boughtBanner);self.boughtBanner=nil;
_UIObject_release(self.bannerShowItemList);self.bannerShowItemList=nil;
_UIObject_release(self.remainingDayText);self.remainingDayText=nil;
_UIObject_release(self.buyTenDayBtn);self.buyTenDayBtn=nil;
_UIObject_release(self.discount);self.discount=nil;
_UIObject_release(self.discountText);self.discountText=nil;
_UIObject_release(self.buyTenDayBtnText);self.buyTenDayBtnText=nil;
_UIObject_release(self.freeRewardBtnReddot);self.freeRewardBtnReddot=nil;
_UIObject_release(self.npcPanel);self.npcPanel=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
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
getRewardBtn=2,
gotFlag=3,
rebate=4,
rebateText=5,
rewardShowItem={6,7,8,9}
}

local _this



function UIDailyTeHuiWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIDailyTeHuiWin:__delete()
self:unbindComponents()
self:clearSpeakTimer()
self:clearTalkTween()
_this=nil
end




function UIDailyTeHuiWin:onShow(argtable,afterOnloaded)
self.baseCfg=cfgHelper.get1(cfg_daydiscountsbasicconfig_get,1)
self.discountCfg=cfg_daydiscountsconfig()
self:onShowArgRecv(argtable,afterOnloaded)
end


function UIDailyTeHuiWin:onHide()
self:clearSpeakTimer()
self:clearTalkTween()
end

function UIDailyTeHuiWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh(afterOnloaded)
end

function UIDailyTeHuiWin:refresh(isInit)

self:refreshBannerPanel()


self:refreshLiBaoPanel()


local isGotFreeReward=rechargeModel:checkDailyTeHuiGotByIndex(1)
self.freeRewardBtn:setActive(not isGotFreeReward)



self:refreshNPCPanel(isInit)

if isInit then

local modelId=4098
self.bgModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand,false,false,0)
end
end


function UIDailyTeHuiWin:refreshBannerPanel()

local isBought=not rechargeController:checkDailyTeHuiTenDayIsExpire()
local isGotAll=rechargeController:checkDailyTeHuiIsGotAll()
local remainingDayCount=0
if isBought then

local endTime=rechargeModel:getDailyTeHuiEndTime()

remainingDayCount=timeHelper.getLeftDataNumberTwo(endTime)
if isGotAll then
remainingDayCount=remainingDayCount-1
if remainingDayCount<0 then
remainingDayCount=0
end
end
end

if remainingDayCount>0 then

self.notBuyBanner:setActive(false)
self.boughtBanner:setActive(true)
self.remainingDayText:setText(remainingDayCount)
else

self.boughtBanner:setActive(false)
self.notBuyBanner:setActive(true)


local level=zongmenModel:getLevel()
local dropId=self.baseCfg.drop_id
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


local rechargeId=self.baseCfg.recharge_id
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local dayCount=self.baseCfg.day
self.buyTenDayBtnText:setText(FMT.fmt("{0}买{1}天",str,dayCount))


local discount=self.baseCfg.tenDayDiscount
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


function UIDailyTeHuiWin:refreshLiBaoPanel()

local isValid=rechargeController:checkDailyTeHuiTenDayIsValid()
local level=zongmenModel:getLevel()
local grids=self.libaoPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local libaoIndex=i+1
local libaoCfg=self.discountCfg[libaoIndex]
if libaoCfg then
widget:SetChildActive(-1,true)


local rewardDropId=libaoCfg.drop_id
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


local isGot=rechargeModel:checkDailyTeHuiGotByIndex(libaoIndex)
widget:SetChildActive(libaoItemCmpIndex.getRewardBtn,isValid and not isGot)
widget:SetChildActive(libaoItemCmpIndex.gotFlag,isGot)
if not isGot then

widget:SetChildButtonClick(libaoItemCmpIndex.getRewardBtn,function()
self:onGetRewardBtnClick(libaoIndex)
end)
end


widget:SetChildActive(libaoItemCmpIndex.buyBtn,not isValid and not isGot)
if not isValid and not isGot then

local rechargeId=libaoCfg.recharge_id

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(libaoItemCmpIndex.buyBtnText,str)
widget:SetChildActive(libaoItemCmpIndex.buyBtn,true)


widget:SetChildButtonClick(libaoItemCmpIndex.buyBtn,function()
self:onBuyLiBaoBtnClick(rechargeId)
end)
end


local rebate=libaoCfg.rebate
local isShowRebate=rebate~=nil
widget:SetChildActive(libaoItemCmpIndex.rebate,isShowRebate)
if isShowRebate then
widget:SetChildText(libaoItemCmpIndex.rebateText,FMT.fmt("{0}%",rebate))
end
else
widget:SetChildActive(-1,false)
end
end
end



function UIDailyTeHuiWin:refreshNPCPanel(isInit)
local showGetAllReward=not rechargeController:checkDailyTeHuiIsGotAll()

self.npcPanel:setActive(showGetAllReward)
if not showGetAllReward then
self.npcModel:setChildUIModelRemoveTarget()
self.isShowNpcModel=nil
return
end

if not self.isShowNpcModel then
local fadeTime=isInit and 0 or 0.5
local modelId=4099
self.npcModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand,false,false,fadeTime)
self.isShowNpcModel=true
end

self.speakContent=self.baseCfg.npcTalk
self.npcTalkTime=self.baseCfg.npcTalkTime
self.npcTalkShowTime=self.baseCfg.npcTalkShowTime

self:doSpeaking()
end


function UIDailyTeHuiWin:doSpeaking()
self:clearSpeakTimer()
local speakList=self.speakContent

local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end


function UIDailyTeHuiWin:doTalkAnim()
self:clearTalkTween()
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


function UIDailyTeHuiWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end




function UIDailyTeHuiWin:onFreeRewardBtn()
self:onGetRewardBtnClick(1)
end



function UIDailyTeHuiWin:onGetAllRewardBtn()

rechargeController:reqGetDailyTeHuiAllReward()
end




function UIDailyTeHuiWin:onBuyTenDayBtn()
local contentStr=self.baseCfg.buy10DayContent
local isBoughtOneLiBao=false
if contentStr then

for i=1,#self.discountCfg do
local cfg=self.discountCfg[i]
if cfg and cfg.recharge_id then

if rechargeModel:checkDailyTeHuiGotByIndex(cfg.id)then
isBoughtOneLiBao=true
break
end
end
end
end

local rechargeId=self.baseCfg.recharge_id
local buyFunc=function()

payControl.reqPay(rechargeId)
end

if isBoughtOneLiBao then

local showdata=
{
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
buyFunc()
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else

buyFunc()
end
end


function UIDailyTeHuiWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIDailyTeHuiWin:onGetRewardBtnClick(index)
local isGotReward=rechargeModel:checkDailyTeHuiGotByIndex(index)
if isGotReward then
UIManager.error("您今天已领取过该奖励了")
return
end


rechargeController:reqGetDailyTeHuiRewardByIndex(index)
end


function UIDailyTeHuiWin:onBuyLiBaoBtnClick(rechargeId)

payControl.reqPay(rechargeId)
end


function UIDailyTeHuiWin:onNPCClick()

local isGotAll=rechargeController:checkDailyTeHuiIsGotAll()
if isGotAll then
return
end


rechargeController:reqGetDailyTeHuiAllReward()
end


function UIDailyTeHuiWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UIDailyTeHuiWin:clearTalkTween()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
end