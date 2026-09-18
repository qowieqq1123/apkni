







def_class("UITouZiWuXingDianRewardsWin",UIWindowBase)









function UITouZiWuXingDianRewardsWin:bindComponents()

self.root=UIObject.get(self,0)
self.shopScrollerView=UILoopListView.new(self,1)
self.timeRoot=UIObject.get(self,2)
self.lefttime=UIText.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.title=UIText.get(self,5)
self.suo1=UIObject.get(self,6)
self.ratio1=UIObject.get(self,7)
self.suo2=UIObject.get(self,8)
self.touziName=UIText.get(self,9)
self.ratio2=UIObject.get(self,10)
self.buyBtn=UIButton.get(self,11)
self.unlcokBtn=UIButton.get(self,12)
self.Content=UIObject.get(self,13)
self.bgModel=UIObject.get(self,14)

self.shopScrollerView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)



end


function UITouZiWuXingDianRewardsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.shopScrollerView:deleteSelf();self.shopScrollerView=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.touziName);self.touziName=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end

















local _bundle=globalABLookup.wxdrewardssprite

function UITouZiWuXingDianRewardsWin:onLoaded(...)
self:bindComponents()
self.bgModel:setChildUIModelShowTarget(5539,1,{},eAnimationID.stand)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
self.wxdId=wuXingDianConfig.getSDType()
end

function UITouZiWuXingDianRewardsWin:__delete()
self:unbindComponents()
end

function UITouZiWuXingDianRewardsWin:onShow(argtable,afterOnloaded)

self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self:freshInfo(true)
end

function UITouZiWuXingDianRewardsWin:onShowArgRecv(argtable)

end

function UITouZiWuXingDianRewardsWin:onHide()

end


function UITouZiWuXingDianRewardsWin:freshInfo(isInit)
local wxdId=self.wxdId
local isSD=wuXingDianConfig.isSD(wxdId)
self:freshBuyBtn()

local data=wuXingDianModel:getData()
local drop_lv=data.drop_lv
local wxdId=self.wxdId
local name1=isSD and'圣殿'or'五行'
local titleName=FMT.fmt('{0}奖励',name1)
self.title:setText(isSD and'通关层级'or'通关总层级')
self.timeRoot:setActive(true)
self:stopTickTimer()
if isSD then
local tick=function()
local jie,endStamp=wuXingDianModel:getCurJie()
local stamp=timeHelper.getServerLongTime()
local left=endStamp-stamp
if left>=0 then
local endStr=timeHelper.format_time_stamp3(left)
self.lefttime:setText(FMT.fmt('本期剩余时间：<color=#f7f7f7>{0}</color>',endStr))
else
self.timeRoot:setActive(false)
self:stopTickTimer()
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()
else
local finishlayer=wuXingDianModel:getWXTotalLayer()
self.lefttime:setText(FMT.fmt('当前通关总层数：<color=#f7f7f7>{0}</color>',finishlayer))
end


self.touziName:setText(FMT.fmt('{0}投资',name1))
self.suo1:setActive(not wuXingDianModel:hasTouziMoney(wxdId))
self.suo2:setActive(not wuXingDianModel:hasTouziRecharge(wxdId))


local cfgs=wuXingDianModel:getPrizeCfgs(wxdId)
local maxlayer=0
if not isSD then
for _,v in pairs(wuXingDianBaseType)do
maxlayer=maxlayer+wuXingDianModel:getMaxLayer(v)
end
else
maxlayer=wuXingDianModel:getMaxLayer(wxdId)
end

local temp={}
for i,v in ipairs(cfgs)do
local layer=v.layer
if layer<=maxlayer then
temp[#temp+1]=v
end
end

self.rewardsCfgs=temp
local len=#temp


self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self.shopScrollerView:initData('item',temp)

self.unlcokBtn:setActive(wuXingDianModel:hasAnyTouzi(wxdId))
self.bgModel:setChildModelAnimationState(wuXingDianModel:hasAnyTouzi(wxdId)and eAnimationID.stand2 or eAnimationID.stand)
local selectIdx
for i=1,len do
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[i]
local layer=cfg.layer
local canFreePrize=wuXingDianModel:canFreePrize(wxdId,layer)
local canMoneyPrize=wuXingDianModel:canMoneyPrize(wxdId,layer)
local canRechargePrize=wuXingDianModel:canRechargePrize(wxdId,layer)
local canPrize=canFreePrize or canMoneyPrize or canRechargePrize
if canPrize then
selectIdx=i
break
end
end

if selectIdx==nil then
local layer=isSD and wuXingDianModel:getRewardLayer(wxdId)or
wuXingDianModel:getWXTotalLayer(wxdId)
local prizelayer,index=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local len=#wuXingDianModel:getPrizeCfgs(wxdId)
if index>=len then
selectIdx=0
else
selectIdx=index-1
end
selectIdx=selectIdx+1
end
selectIdx=selectIdx or 1
self.shopScrollerView:jumpItem(selectIdx)
end

function UITouZiWuXingDianRewardsWin:freshBuyBtn()
local wxdId=self.wxdId
local isSD=wuXingDianConfig.isSD(wxdId)
local vis=isSD and wuXingDianModel:isCanBuySDLayer()

if vis then
local layer=wuXingDianModel:getRewardLayer(wxdId)
local index=wuXingDianModel:getPrizeCfgsIndex(wxdId,layer)
self.index=index or 0
else
self.index=nil
end
vis=false
self.buyBtn:setActive(vis)
end

function UITouZiWuXingDianRewardsWin:onStartAction()

end

function UITouZiWuXingDianRewardsWin:onFreshAction(index,widget)
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[index]
local layer=cfg.layer
local free_drop_id=cfg.free_drop_id
local drop_id=cfg.drop_id
local recharge_drop_id=cfg.recharge_drop_id
local data=wuXingDianModel:getData()
local level=data.drop_lv
local wxdId=self.wxdId
local finishlayer=wuXingDianConfig.isSD(self.wxdId)and wuXingDianModel:getRewardLayer(self.wxdId)or
wuXingDianModel:getWXTotalLayer()
local isFinish=finishlayer>=layer

local free_rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(free_drop_id,level)
local free_itemsList=free_rewardCfg.showItems or{}

local money_rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(drop_id,level)
local money_itemsList=money_rewardCfg.showItems or{}

local recharge_rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(recharge_drop_id,level)
local recharge_itemsList=recharge_rewardCfg.showItems or{}

local showBuyTips=false
widget:SetChildText(0,FMT.fmt('{0}层',layer))
local descStr2=FMT.fmt("(<color=#{0}>{1}/{2}</color>)",isFinish and"298a1c"or"e03333",finishlayer,layer)
widget:SetChildText(8,descStr2)



local isFreePrize=wuXingDianModel:isFreePrize(wxdId,layer)
local canFreePrize=wuXingDianModel:canFreePrize(wxdId,layer)
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

local isMoneyPrize=wuXingDianModel:isMoneyPrize(wxdId,layer)
local canMoneyPrize=wuXingDianModel:canMoneyPrize(wxdId,layer)
local hasTouziMoney=wuXingDianModel:hasTouziMoney(wxdId)
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
widget1:SetChildActive(4,not hasTouziMoney or isMoneyPrize)
widget1:SetChildActive(2,canMoneyPrize)
if canMoneyPrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

local isRechargePrize=wuXingDianModel:isRechargePrize(wxdId,layer)
local canRechargePrize=wuXingDianModel:canRechargePrize(wxdId,layer)
local hasTouziRecharge=wuXingDianModel:hasTouziRecharge(wxdId)
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
widget1:SetChildActive(4,not hasTouziRecharge or isRechargePrize)
widget1:SetChildActive(2,canRechargePrize)
if canRechargePrize then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end)

widget:SetChildActive(7,showBuyTips)
if showBuyTips then
local cfg=rewardsCfgs[1]
local minlayer=cfg.layer

local layer=wuXingDianModel:getRewardLayer(wxdId)

widget:SetChildText(6,FMT.fmt('{0}层',layer))
end
end

function UITouZiWuXingDianRewardsWin:jumpIndex(index)

end

function UITouZiWuXingDianRewardsWin:stopTickTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
end

function UITouZiWuXingDianRewardsWin:onUnlcokBtn()
UIManager:showWindow('UIWuXingDianTouZiWin',{wxdId=self.wxdId})
end

function UITouZiWuXingDianRewardsWin:onPrize()
local hasPrize=wuXingDianModel:hasAnyPrize(self.wxdId)
if hasPrize then
local id=2
if wuXingDianConfig.isSD(self.wxdId)then id=1 end
socketManager:send_25_16(id)
end
end

function UITouZiWuXingDianRewardsWin:onCloseBtn()
self:closeSelf()
end

function UITouZiWuXingDianRewardsWin:onBuyBtn()
local wxdId=self.wxdId
local layer=wuXingDianModel:getRewardLayer(wxdId)
local maxLayer=wuXingDianModel:getMaxLayer(wxdId)
local index=wuXingDianModel:getPrizeCfgsIndex(wxdId,layer)
local maxIndex=wuXingDianModel:getPrizeCfgsIndex(wxdId,maxLayer)
UIManager:showWindow('UIWuXingDianBuyLayerWin',{wxdId=self.wxdId,index=index,maxIndex=maxIndex})
end

function UITouZiWuXingDianRewardsWin:enter()
jumpManager:jump({id=JUMP_TYPE.eWuXingDian},nil,JUMP_BACK.eNoBack)
end

function UITouZiWuXingDianRewardsWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='wxsd_tz_help_%s'})
end