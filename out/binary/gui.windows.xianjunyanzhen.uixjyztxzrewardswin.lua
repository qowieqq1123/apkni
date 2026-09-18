







def_class("UIXJYZTXZRewardsWin",UIWindowBase)









function UIXJYZTXZRewardsWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.jifennum=UIText.get(self,2)
self.mbg=UIObject.get(self,3)
self.mbg2=UIObject.get(self,4)
self.ratio1=UIImage.get(self,5)
self.ratio2=UIImage.get(self,6)
self.root=UIObject.get(self,7)
self.shopScrollerView=UIObject.get(self,8)
self.suo1=UIObject.get(self,9)
self.suo2=UIObject.get(self,10)
self.title=UIText.get(self,11)
self.touziName_1=UIText.get(self,12)
self.touziName_2=UIText.get(self,13)
self.unlcokBtn=UIButton.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)
self.touziName={
self.touziName_1,
self.touziName_2,
}



end


function UIXJYZTXZRewardsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.jifennum);self.jifennum=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.touziName_1);self.touziName_1=nil;
_UIObject_release(self.touziName_2);self.touziName_2=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
self.touziName=nil;
end

















local _this




function UIXJYZTXZRewardsWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXJYZTXZRewardsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXJYZTXZRewardsWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

if argtable then
self.guid=argtable.guid
self.txzId=argtable.txzId or 1
self.passportId=argtable.passportId
self.config=cfgHelper.get1(cfg_passportconfig_get,self.txzId)
end

self:refreshWin()

if afterOnloaded then
self.mbg:setChildUIModelShowTarget(772157,1,{},eAnimationID.enter)
self.mbg2:setChildUIModelShowTarget(772156,1,{},eAnimationID.enter)
self.root:setChildCanvasGroupAlpha(0)
self.shopScrollerView:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
self.shopScrollerView:setChildCanvasGroupDOFade(1,0.2)
end)
end
end


function UIXJYZTXZRewardsWin:onHide()

end

function UIXJYZTXZRewardsWin:refreshWin()
_this:refreshScrollview()
_this:freshInfo()
end

function UIXJYZTXZRewardsWin:refreshScrollview()
self.shopScrollerView:setChildCanvasGroupAlpha(1)
end

function UIXJYZTXZRewardsWin:freshInfo()
local num=UITYTongXingZhengModel:getProgress(self.guid)
if self.config.jifen_reduce then
num=math.floor(num/self.config.jifen_reduce)
end
local text=string.format('当前通关：%s',num)
self.jifennum:setText(text)

local touziCfg=self.config.investname

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
end
function UIXJYZTXZRewardsWin:SetItemData(widget,index)
local widget2=widget:GetChildWidgetBase(0)
self:onFreshAction(index,widget2)
end

function UIXJYZTXZRewardsWin:onFreshAction(index,widget)
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[index]
local layer=cfg.layer
if self.config.jifen_reduce then
layer=math.floor(layer/self.config.jifen_reduce)
end

local isFinish=UITYTongXingZhengModel:canFreePrize(self.guid,layer,index)
local isFreePrize=UITYTongXingZhengModel:isFreePrize(self.guid,index)
local free_itemsList=cfg.freeReward or{}
local money_itemsList=cfg.lock1Reward or{}
local recharge_itemsList=cfg.lock2Reward or{}

widget:SetChildText(0,layer)
widget:SetChildActive(4,isFinish or isFreePrize)

local canFreePrize=isFinish and not isFreePrize

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
widget1:SetChildActive(2,canFreePrize)
if canFreePrize then
widget1:SetChildButtonClick(2,function()
_this:onPrize()
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
_this:onPrize()
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
_this:onPrize()
end,true)
end
end)
end

function UIXJYZTXZRewardsWin:onStartAction()

end

function UIXJYZTXZRewardsWin:onPrize()
local idx=UITYTongXingZhengModel:getMaxPizeLayer(self.guid)
socketManager:send_29_12(self.guid,idx)
end





function UIXJYZTXZRewardsWin:onCloseBtn()
self:closeSelf()
end



function UIXJYZTXZRewardsWin:onUnlcokBtn()
UIManager:showWindow('UIXJYZTongXingZhengTouZiWin',{guid=self.guid,txzId=self.txzId,passportId=self.passportId})
end

