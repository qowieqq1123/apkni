







def_class("UITYTXZRewardsWin",UIWindowBase)









function UITYTXZRewardsWin:bindComponents()

self.buyBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.Content=UIObject.get(self,2)
self.fullRoot=UIObject.get(self,3)
self.guanggaoci=UIImage.get(self,4)
self.guanggaocibg=UIObject.get(self,5)
self.jifenitem=UIObject.get(self,6)
self.jifennum=UIText.get(self,7)
self.jifenroot=UIObject.get(self,8)
self.lefttime=UIText.get(self,9)
self.modelBg=UIObject.get(self,10)
self.name=UIText.get(self,11)
self.pricesBtn=UIButton.get(self,12)
self.pricesCount=UIText.get(self,13)
self.ratio1=UIImage.get(self,14)
self.ratio1txt=UIText.get(self,15)
self.ratio2=UIImage.get(self,16)
self.ratio2txt=UIText.get(self,17)
self.recvDesc=UIText.get(self,18)
self.recvTimes=UIText.get(self,19)
self.rewadProgress=UIObject.get(self,20)
self.rewadProgressbg=UIObject.get(self,21)
self.rewardProgressBar=UIObject.get(self,22)
self.root=UIObject.get(self,23)
self.selectkuang=UIObject.get(self,24)
self.shopScrollerView=UIObject.get(self,25)
self.suo1=UIObject.get(self,26)
self.suo2=UIObject.get(self,27)
self.timeRoot=UIObject.get(self,28)
self.title=UIText.get(self,29)
self.titleText=UIText.get(self,30)
self.touziName_1=UIText.get(self,31)
self.touziName_2=UIText.get(self,32)
self.unlcokBtn=UIButton.get(self,33)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.pricesBtn:setButtonClick(function()self:onPricesBtn()end)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)
self.touziName={
self.touziName_1,
self.touziName_2,
}



end


function UITYTXZRewardsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.fullRoot);self.fullRoot=nil;
_UIObject_release(self.guanggaoci);self.guanggaoci=nil;
_UIObject_release(self.guanggaocibg);self.guanggaocibg=nil;
_UIObject_release(self.jifenitem);self.jifenitem=nil;
_UIObject_release(self.jifennum);self.jifennum=nil;
_UIObject_release(self.jifenroot);self.jifenroot=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.pricesBtn);self.pricesBtn=nil;
_UIObject_release(self.pricesCount);self.pricesCount=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.ratio1txt);self.ratio1txt=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.ratio2txt);self.ratio2txt=nil;
_UIObject_release(self.recvDesc);self.recvDesc=nil;
_UIObject_release(self.recvTimes);self.recvTimes=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewadProgressbg);self.rewadProgressbg=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectkuang);self.selectkuang=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.touziName_1);self.touziName_1=nil;
_UIObject_release(self.touziName_2);self.touziName_2=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
self.touziName=nil;
end


















local this
local abname="ui/windows/tongyongtxz/uitytxz_atlas_pak.ab"

function UITYTXZRewardsWin:onLoaded(...)
this=self
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(5493,1,{},eAnimationID.enter)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UITYTXZRewardsWin:__delete()
self:unbindComponents()
this=nil
end




function UITYTXZRewardsWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

if argtable then
self.guid=argtable.guid
self.txzId=argtable.txzId or 1
self.passportId=argtable.passportId
self.config=cfgHelper.get1(cfg_passportconfig_get,self.txzId)
self.guanggaoci:setCSImageSprite(abname,self.config.guanggaoicon)
end

this:refreshWin()
end


function UITYTXZRewardsWin:onHide()

end

function UITYTXZRewardsWin:refreshWin()
this:refreshScrollview()
this:freshInfo()
end

function UITYTXZRewardsWin:refreshScrollview()
local flag
local full=UITYTongXingZhengModel:isReceiveFull(self.guid,self.txzId)

if full and self.config.drop_id then
flag=true
else
flag=false
end
if flag then
self.shopScrollerView:setChildSizeDelta(901.84,323.45)
self:refreshFull()
else
self.shopScrollerView:setChildSizeDelta(901.84,416.12)
end

self.fullRoot:setActive(flag)
self.shopScrollerView:setChildCanvasGroupAlpha(1)
end

function UITYTXZRewardsWin:freshInfo()
local titleName=self.config.titlename
local jfname=self.config.jfname
local num=UITYTongXingZhengModel:getProgress(self.guid)
if self.config.jifen_reduce then
num=math.floor(num/self.config.jifen_reduce)
end

self.jifennum:setText(num)
self.title:setText(jfname)
self.timeRoot:setActive(true)
self:stopTickTimer()

local tick=function()
local endStr=UITYTongXingZhengModel:getCurLeftDay(self.guid)

if endStr then
self.lefttime:setText(FMT.fmt('本期剩余时间：<color=#171311>{0}</color>',endStr))
else
self.timeRoot:setActive(false)
self:stopTickTimer()
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()

local touziCfg=self.config.investname
local ratioConfig=self.config.multiple_text

self.ratio1txt:setText(FMT.fmt("{0}收益",ratioConfig[1]))
self.ratio2txt:setText(FMT.fmt("{0}收益",ratioConfig[2]))

self.name:setText(titleName)
self.touziName[1]:setText(touziCfg[1])
self.touziName[2]:setText(touziCfg[2])









self.suo1:setActive(not UITYTongXingZhengModel:hasTouziMoney(self.guid))
self.suo2:setActive(not UITYTongXingZhengModel:hasTouziRecharge(self.guid))

local cfgs=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
self.rewardsCfgs=cfgs

self.shopScrollerView:setChildScrollViewCreateGrids(#cfgs,1)
local grids=self.shopScrollerView:getChildScrollViewItemWidgets()
for i=1,#cfgs do
self:SetItemData(grids[i-1],i)
end

self.unlcokBtn:setActive(UITYTongXingZhengModel:hasAnyTouzi(self.guid))

local selectIdx
if selectIdx==nil then
local prizelayer=UITYTongXingZhengModel:getCanPizeLayer(self.guid,self.txzId)
selectIdx=prizelayer
end
selectIdx=selectIdx or 0
self.shopScrollerView:setChildScrollViewSelectItem(selectIdx,false,false,true)
self.rewardProgressBar:setChildSizeDelta(18,#cfgs*92+15)


local num=UITYTongXingZhengModel:getProgress(self.guid)

local nowmaxindex=0
local jindu=0

local deno=1
for k,v in ipairs(self.rewardsCfgs)do
if num>=v["layer"]then
nowmaxindex=k
end
end
if self.rewardsCfgs[nowmaxindex+1]then
if nowmaxindex==0 then
deno=self.rewardsCfgs[nowmaxindex+1]["layer"]
else
deno=self.rewardsCfgs[nowmaxindex+1]["layer"]-self.rewardsCfgs[nowmaxindex]["layer"]
end
if nowmaxindex>0 then
jindu=num-self.rewardsCfgs[nowmaxindex]["layer"]
end

end

self.rewadProgress:setChildSizeDelta(8,(92*nowmaxindex)+(92*jindu/deno)+15)
end
function UITYTXZRewardsWin:SetItemData(widget,index)
local widget2=widget:GetChildWidgetBase(0)
self:onFreshAction(index,widget2)
end

function UITYTXZRewardsWin:onFreshAction(index,widget)
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[index]
local layer=cfg.layer
if self.config.jifen_reduce then
layer=math.floor(layer/self.config.jifen_reduce)
end
local jfname=self.config.jfname

local isFinish=UITYTongXingZhengModel:canFreePrize(self.guid,layer,index)
local free_itemsList=cfg.freeReward or{}
local money_itemsList=cfg.lock1Reward or{}
local recharge_itemsList=cfg.lock2Reward or{}

local showBuyTips=self.index==index or self.index==0 and index==1 or false
widget:SetChildText(0,layer)

widget:SetChildActive(5,isFinish)

local isFreePrize=UITYTongXingZhengModel:isFreePrize(self.guid,index)
local canFreePrize=UITYTongXingZhengModel:canFreePrize(self.guid,layer,index)and not isFreePrize
widget:SetChildActive(8,isFreePrize or canFreePrize)
widget:SetChildLayoutGroupCreateItems(1,#free_itemsList,function(index)
local data={}
local reward=free_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(1,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
local widget2=widget1:GetChildWidgetBase(0)



widget1:SetChildActive(1,isFreePrize)
widget1:SetChildActive(2,canFreePrize)
widget1:SetChildActive(3,false)
widget1:SetChildActive(4,isFreePrize)
widget1:SetChildActive(2,canFreePrize)
if canFreePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)


local isMoneyPrize=UITYTongXingZhengModel:isMoneyPrize(self.guid,index)
local canMoneyPrize=UITYTongXingZhengModel:canMoneyPrize(self.guid,layer,index)and not isMoneyPrize
local hasTouziMoney=UITYTongXingZhengModel:hasTouziMoney(self.guid)

if not hasTouziMoney then
isFinish=true
elseif hasTouziMoney and isMoneyPrize then
isFinish=true
else
isFinish=false
end

widget:SetChildLayoutGroupCreateItems(2,#money_itemsList,function(index)
local data={}
local reward=money_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(2,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
local widget2=widget1:GetChildWidgetBase(0)



widget1:SetChildActive(1,isMoneyPrize)
widget1:SetChildActive(2,canMoneyPrize)
widget1:SetChildActive(3,not hasTouziMoney)
widget1:SetChildActive(4,isFinish)
widget1:SetChildActive(2,canMoneyPrize)
if canMoneyPrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)


local isRechargePrize=UITYTongXingZhengModel:isRechargePrize(self.guid,index)
local canRechargePrize=UITYTongXingZhengModel:canRechargePrize(self.guid,layer,index)and not isRechargePrize
local hasTouziRecharge=UITYTongXingZhengModel:hasTouziRecharge(self.guid)

if not hasTouziRecharge then
isFinish=true
elseif hasTouziRecharge and isRechargePrize then
isFinish=true
else
isFinish=false
end

widget:SetChildLayoutGroupCreateItems(3,#recharge_itemsList,function(index)
local data={}
local reward=recharge_itemsList[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(3,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
local widget2=widget1:GetChildWidgetBase(0)



widget1:SetChildActive(1,isRechargePrize)
widget1:SetChildActive(2,canRechargePrize)
widget1:SetChildActive(3,not hasTouziRecharge)
widget1:SetChildActive(4,isFinish)
widget1:SetChildActive(2,canRechargePrize)
if canRechargePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

widget:SetChildActive(7,showBuyTips)
end

function UITYTXZRewardsWin:stopTickTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
end

function UITYTXZRewardsWin:onStartAction()

end

function UITYTXZRewardsWin:onPrize()
local idx=UITYTongXingZhengModel:getMaxPizeLayer(self.guid)
socketManager:send_29_12(self.guid,idx)
end

function UITYTXZRewardsWin:refreshFull()
local name=self.config.rewardname
local desc=self.config.rewarddesc
local jfname=self.config.jfname
local jfvalue=self.config.cost

local recvtimes=UITYTongXingZhengModel:getRecvTimes(self.guid)
local canrecvtines=UITYTongXingZhengModel:getCanRecvTimes(self.guid,self.txzId)
local descstr=string.format(desc,jfvalue,jfname)
local recvstr=string.format("已领取: <color=#129E10>%s</color>",recvtimes)

self.titleText:setText(name)
self.recvDesc:setText(descstr)
self.recvTimes:setText(recvstr)
self.pricesCount:setText(canrecvtines)
self.selectkuang:setActive(canrecvtines~=0)
end



function UITYTXZRewardsWin:onCloseBtn()
self:closeSelf()
end


function UITYTXZRewardsWin:onBuyBtn()
local name=self.config.infoDesc
if name then
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=name})
end
end


function UITYTXZRewardsWin:onUnlcokBtn()
UIManager:showWindow('UITYTongXingZhengTouZiWin',{guid=self.guid,txzId=self.txzId,passportId=self.passportId})
end


function UITYTXZRewardsWin:onPricesBtn()
local value=UITYTongXingZhengModel:getCanRecvTimes(self.guid,self.txzId)
if not value or value==0 then
UIManager.info("可领取秘宝礼盒次数不足")
local itemId=self.config.showTips
if itemId then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNoBtns,itemid=itemId,showModel=true})

end
else
socketManager:send_29_15(self.guid,value)
end
end