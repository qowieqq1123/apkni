







def_class("UITouZiMYZS_TXZRewardsWin",UIWindowBase)









function UITouZiMYZS_TXZRewardsWin:bindComponents()

self.artword=UIImage.get(self,0)
self.bgModel=UIObject.get(self,1)
self.buyBtn=UIButton.get(self,2)
self.Content=UIObject.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.lefttime=UIText.get(self,5)
self.ratio1=UIObject.get(self,6)
self.ratio2=UIObject.get(self,7)
self.ratioImg1=UIImage.get(self,8)
self.ratioImg2=UIImage.get(self,9)
self.root=UIObject.get(self,10)
self.shopScrollerView=UILoopListView.new(self,11)
self.suo1=UIObject.get(self,12)
self.suo2=UIObject.get(self,13)
self.timeRoot=UIObject.get(self,14)
self.title=UIText.get(self,15)
self.touziName_1=UIText.get(self,16)
self.touziName_2=UIText.get(self,17)
self.unlcokBtn=UIButton.get(self,18)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.shopScrollerView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)
self.touziName={
self.touziName_1,
self.touziName_2,
}



end


function UITouZiMYZS_TXZRewardsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.artword);self.artword=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.ratioImg1);self.ratioImg1=nil;
_UIObject_release(self.ratioImg2);self.ratioImg2=nil;
_UIObject_release(self.root);self.root=nil;
self.shopScrollerView:deleteSelf();self.shopScrollerView=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.touziName_1);self.touziName_1=nil;
_UIObject_release(self.touziName_2);self.touziName_2=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
self.touziName=nil;
end
















local _this

local abname="ui/windows/tongyongtxz/uitytxz_atlas_pak.ab"

function UITouZiMYZS_TXZRewardsWin:onLoaded(...)
self:bindComponents()
_this=self

self.bgModel:setChildUIModelShowTarget(5677,1,{},eAnimationID.stand,false,false,0.2)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)

local _freshWin=function()
_this:freshInfo()
end
self:addProNotify(29,12,_freshWin)
self:addProNotify(29,13,_freshWin)
self:addProNotify(29,14,_freshWin)
self:addProNotify(29,15,_freshWin)

self:addNotify(notifyConfig.onMingYuanZhuShaStateChange,function()
if _this==nil then return end
_this:refreshAll()
end)
end

function UITouZiMYZS_TXZRewardsWin:__delete()
_this=nil

self:unbindComponents()
end

function UITouZiMYZS_TXZRewardsWin:onShow(argtable,afterOnloaded)


self:refreshAll()
end

function UITouZiMYZS_TXZRewardsWin:onShowArgRecv(argtable)

end

function UITouZiMYZS_TXZRewardsWin:onHide()

end


function UITouZiMYZS_TXZRewardsWin:refreshAll()
self.winlua:SetChildLocalPosY(self.Content:getID(),0)

self.guid=myzsModel:getTxzGuid()
self.txzId=myzsModel:getTxzID()
self.config=cfgHelper.get1(cfg_passportconfig_get,self.txzId)
self.artword:setCSImageSprite(abname,self.config.guanggaoicon)

self.myzsState=myzsModel:checkTxzInStop()

if self.myzsState then
self:freshInfoStop()
else
self:freshInfo(true)
end
end

function UITouZiMYZS_TXZRewardsWin:freshInfoStop()
self.title:setText('通关数')
self.timeRoot:setActive(true)
self:startTickTimer()

self.touziName_1:setText(self.config.investname[1])
self.touziName_2:setText(self.config.investname[2])

self.suo1:setActive(true)
self.suo2:setActive(true)
self.unlcokBtn:setActive(true)

local temp=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
self.rewardsCfgs=temp
local len=#temp
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self.shopScrollerView:initData('item',temp)
self.shopScrollerView:jumpItem(1)
end

function UITouZiMYZS_TXZRewardsWin:freshInfo(isInit)
local guid=self.guid

self.title:setText('通关数')
self.timeRoot:setActive(true)
self:startTickTimer()

self.touziName_1:setText(self.config.investname[1])
self.touziName_2:setText(self.config.investname[2])
self.suo1:setActive(not UITYTongXingZhengModel:hasTouziMoney(guid))
self.suo2:setActive(not UITYTongXingZhengModel:hasTouziRecharge(guid))
local ab='ui/windows/totaltouziactivity/tzzh_wxsd_atals_pak.ab'
self.ratioImg1:setCSImageSprite(ab,self.config.multiple[1])
self.ratioImg2:setCSImageSprite(ab,self.config.multiple[2])

local isHasAnyTouZi=UITYTongXingZhengModel:hasAnyTouzi(guid)
self.unlcokBtn:setActive(isHasAnyTouZi)


self.passLayer=UITYTongXingZhengModel:getProgress(guid)

local temp=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
self.rewardsCfgs=temp
local len=#temp


self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self.shopScrollerView:initData('item',temp)

local selectIdx
for i=1,len do
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[i]
local layer=cfg.layer
local canFreePrize=UITYTongXingZhengModel:canFreePrize(guid,layer)
local canMoneyPrize=UITYTongXingZhengModel:canMoneyPrize(guid,layer)
local canRechargePrize=UITYTongXingZhengModel:canRechargePrize(guid,layer)
local canPrize=canFreePrize or canMoneyPrize or canRechargePrize
if canPrize then
selectIdx=i
break
end
end

selectIdx=selectIdx or UITYTongXingZhengModel:getCanRecvRewardMaxLayer(guid)or 1
self.shopScrollerView:jumpItem(selectIdx)
end

function UITouZiMYZS_TXZRewardsWin:onStartAction()

end

function UITouZiMYZS_TXZRewardsWin:onFreshAction(index,widget)
if self.myzsState then
self:freshItemStop(index,widget)
else
self:freshItem(index,widget)
end
end

function UITouZiMYZS_TXZRewardsWin:freshItem(index,widget)
local guid=self.guid
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[index]
local layer=cfg.layer

local finishlayer=self.passLayer
local isFinish=self.passLayer>=layer

local free_itemsList=cfg['freeReward']or{}

local money_itemsList=cfg['lock1Reward']or{}

local recharge_itemsList=cfg['lock2Reward']or{}

local levelConf=myzsModel:getlevelConf(layer)
local titleTxt=FMT.fmt("{0}重-{1}",levelConf.layer,levelConf.level)
widget:SetChildText(0,titleTxt)

local descStr2
if finishlayer>0 then
local finishLevelConf=myzsModel:getlevelConf(finishlayer)
local finishLayerTxt=FMT.fmt("{0}重-{1}",finishLevelConf.layer,finishLevelConf.level)
descStr2=FMT.fmt("(<color=#{0}>{1}</color>)",isFinish and"298a1c"or"e03333",finishLayerTxt)
else
descStr2=toColorStringX("#e03333",'(未挑战)')
end
widget:SetChildText(8,descStr2)

local isFreePrize=UITYTongXingZhengModel:isFreePrize(guid,index)
local canFreePrize=UITYTongXingZhengModel:canFreePrize(guid,layer,index)and not isFreePrize
widget:SetChildLayoutGroupCreateItems(1,#free_itemsList,function(index)
local data={}
local reward=free_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(1,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(1,isFreePrize)
widget1:SetChildActive(2,canFreePrize)
widget1:SetChildActive(3,false)
widget1:SetChildActive(4,isFreePrize)
if canFreePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

local isMoneyPrize=UITYTongXingZhengModel:isMoneyPrize(guid,index)
local canMoneyPrize=UITYTongXingZhengModel:canMoneyPrize(guid,layer,index)and not isMoneyPrize
local hasTouziMoney=UITYTongXingZhengModel:hasTouziMoney(guid)
widget:SetChildLayoutGroupCreateItems(2,#money_itemsList,function(index)
local data={}
local reward=money_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(2,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(1,isMoneyPrize)
widget1:SetChildActive(2,canMoneyPrize)
widget1:SetChildActive(3,not hasTouziMoney)
widget1:SetChildActive(4,not hasTouziMoney or isMoneyPrize)
if canMoneyPrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

local isRechargePrize=UITYTongXingZhengModel:isRechargePrize(guid,index)
local canRechargePrize=UITYTongXingZhengModel:canRechargePrize(guid,layer,index)and not isRechargePrize
local hasTouziRecharge=UITYTongXingZhengModel:hasTouziRecharge(guid)
widget:SetChildLayoutGroupCreateItems(3,#recharge_itemsList,function(index)
local data={}
local reward=recharge_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(3,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(1,isRechargePrize)
widget1:SetChildActive(2,canRechargePrize)
widget1:SetChildActive(3,not hasTouziRecharge)
widget1:SetChildActive(4,not hasTouziRecharge or isRechargePrize)
if canRechargePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

widget:SetChildActive(7,false)
end

function UITouZiMYZS_TXZRewardsWin:freshItemStop(index,widget)
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[index]
local layer=cfg.layer

local finishlayer=0
local isFinish=false

local free_itemsList=cfg['freeReward']or{}

local money_itemsList=cfg['lock1Reward']or{}

local recharge_itemsList=cfg['lock2Reward']or{}

local levelConf=myzsModel:getlevelConf(layer)
local titleTxt=FMT.fmt("{0}重-{1}",levelConf.layer,levelConf.level)
widget:SetChildText(0,titleTxt)

local descStr2
if finishlayer>0 then
local finishLevelConf=myzsModel:getlevelConf(finishlayer)
local finishLayerTxt=FMT.fmt("{0}重-{1}",finishLevelConf.layer,finishLevelConf.level)
descStr2=FMT.fmt("(<color=#{0}>{1}</color>)",isFinish and"298a1c"or"e03333",finishLayerTxt)
else
descStr2=toColorStringX("#e03333",'(未挑战)')
end
widget:SetChildText(8,descStr2)

local isFreePrize=false
local canFreePrize=false
widget:SetChildLayoutGroupCreateItems(1,#free_itemsList,function(index)
local data={}
local reward=free_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(1,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(1,isFreePrize)
widget1:SetChildActive(2,canFreePrize)
widget1:SetChildActive(3,false)
widget1:SetChildActive(4,isFreePrize)
if canFreePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

local isMoneyPrize=false
local canMoneyPrize=false
local hasTouziMoney=false
widget:SetChildLayoutGroupCreateItems(2,#money_itemsList,function(index)
local data={}
local reward=money_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(2,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(1,isMoneyPrize)
widget1:SetChildActive(2,canMoneyPrize)
widget1:SetChildActive(3,not hasTouziMoney)
widget1:SetChildActive(4,not hasTouziMoney or isMoneyPrize)
if canMoneyPrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

local isRechargePrize=false
local canRechargePrize=false
local hasTouziRecharge=false
widget:SetChildLayoutGroupCreateItems(3,#recharge_itemsList,function(index)
local data={}
local reward=recharge_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(3,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(1,isRechargePrize)
widget1:SetChildActive(2,canRechargePrize)
widget1:SetChildActive(3,not hasTouziRecharge)
widget1:SetChildActive(4,not hasTouziRecharge or isRechargePrize)
if canRechargePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

widget:SetChildActive(7,false)
end

function UITouZiMYZS_TXZRewardsWin:jumpIndex(index)

end

function UITouZiMYZS_TXZRewardsWin:stopTickTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
end

function UITouZiMYZS_TXZRewardsWin:startTickTimer()
self:stopTickTimer()

local endTime
local curTime=timeHelper.getServerShortTime()

local timeFmt

local changeState=function()
local state=myzsModel:checkTxzInStop()

if not state then
timeFmt='本期剩余时间：<color=#f7f7f7>{0}</color>'
endTime=UITYTongXingZhengModel:getEndTime(_this.guid)
else
timeFmt='下期开启时间：<color=#f7f7f7>{0}</color>'
endTime=myzsModel:getNextSeasonOpenStamp()
end
end

changeState()

local tick=function()
local stamp=timeHelper.getServerShortTime()
local left=endTime-stamp
if left>=0 then
local endStr=timeHelper.format_time_stamp3(left)
_this.lefttime:setText(FMT.fmt(timeFmt,endStr))
else
_this:stopTickTimer()
_this:refreshAll()
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()
end


function UITouZiMYZS_TXZRewardsWin:onUnlcokBtn()

local state=myzsModel:checkTxzInStop()
if state then
UIManager.info('下期开启后可购买')
return
end

local settlementState=myzsModel:getSettlementState()
if settlementState~=MYZSSettlementStateEnum.eStop then
UIManager:showWindow('UIMingYuanZhuShaTouZiWin',{guid=self.guid,txzId=self.txzId})
return
end

local passIdx=self.passLayer

if passIdx==0 then











UIManager.error("休赛期且未通关任意关卡，不可解锁")
return
end

local lastRewardCfg=self.rewardsCfgs[#self.rewardsCfgs]
local lastLevelConf=myzsModel:getlevelConf(lastRewardCfg.layer)
local maxPassIdx=lastLevelConf.idx

if maxPassIdx>passIdx then
local content=FMT.fmt("目前处于休赛期不可挑战，通关数未达\n<color='#c82c2c'>{0}重-{1}</color>，购买投资无法获得全部奖励，\n是否要购买？",lastLevelConf.layer,lastLevelConf.level)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
showclosebtn=true,
okcallback=function()
UIManager:showWindow('UIMingYuanZhuShaTouZiWin',{guid=self.guid,txzId=self.txzId})
end
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
return
end

UIManager:showWindow('UIMingYuanZhuShaTouZiWin',{guid=self.guid,txzId=self.txzId})
end

function UITouZiMYZS_TXZRewardsWin:onPrize()
local idx=UITYTongXingZhengModel:getMaxPizeLayer(self.guid)
socketManager:send_29_12(self.guid,idx)
end

function UITouZiMYZS_TXZRewardsWin:onCloseBtn()
self:closeSelf()
end

function UITouZiMYZS_TXZRewardsWin:onBuyBtn()

end

function UITouZiMYZS_TXZRewardsWin:enter()
myzsController:showFullWin()
end

function UITouZiMYZS_TXZRewardsWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='myzs_txz_help_%s'})
end