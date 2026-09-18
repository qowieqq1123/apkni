







def_class("UIHuanJingTouZiWin",UIWindowBase)









function UIHuanJingTouZiWin:bindComponents()

self.speakHUD=UIObject.get(self,0)
self.cost=UIText.get(self,1)
self.moneyIcon=UIObject.get(self,2)
self.rwValue=UIText.get(self,3)
self.model=UIObject.get(self,4)
self.payBtn=UIButton.get(self,5)
self.scrollview=UIObject.get(self,6)
self.rwScrollView=UIObject.get(self,7)

self.payBtn:setButtonClick(function()self:onPayBtn()end)


self.sprite_button_zhulitouziui_2=0

end


function UIHuanJingTouZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.speakHUD);self.speakHUD=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.rwValue);self.rwValue=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
end
















local _item_index={
title=0,
lock=1,
level=2,
tips=3,
rw_items={4,5,6,7},
receive_btn=8,
undone_btn=9,
received=10,
bg2=11,
}




function UIHuanJingTouZiWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIHuanJingTouZiWin:__delete()
self:unbindComponents()
end




function UIHuanJingTouZiWin:onShow(argtable,afterOnloaded)
self.investData=UIHuanJingControl:getInvestData()
self.receiveList={}

self:showNPC()

self:refresh()
end

function UIHuanJingTouZiWin:refresh()
self:setRewardList()
self:setSPRewards()
self:setTZValue()
end


function UIHuanJingTouZiWin:onHide()

end

function UIHuanJingTouZiWin:showNPC()
local scale=isometricMapSystem:getModelScale(1001,true)
self.model:setChildUIModelShowTarget(1001,scale*0.91,{47002},eAnimationID.stand)
self.model:setChildUIModelShowFlipX(true)

local widget=self.speakHUD:getChildWidgetBase()
local txt='购买后完成指定关卡，\n可获得大量灵玉奖励！'
widget:SetChildText(0,chatEmotHelper.decodeEmot(txt))
end

function UIHuanJingTouZiWin:setTZValue()
local lcfg=cfgHelper.get1(cfg_guanqianewinvestconfig_get,self.investData.rechargeId)
local czcfg=cfgHelper.get1(cfg_rechargeconfig_get,self.investData.rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(czcfg)
self.moneyIcon:setChildIcon(iconHelper.getIconName(lcfg.rw_value[1]),true)
self.rwValue:setText(lcfg.rw_value[2])
if self.investData.paid then
self.payBtn:setImageSprite(self.sprite_button_zhulitouziui_2,true)
self.cost:setText('已购买')
else
self.cost:setText(FMT.fmt('{0}购买',str))
end
end

function UIHuanJingTouZiWin:setSPRewards()
local lcfg=cfgHelper.get1(cfg_guanqianewinvestconfig_get,self.investData.rechargeId)
local rwId=lcfg.recharge_rewards[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems

local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local rwdata=rewards[i+1]
widgetHelper.setNormalRewardItem(item,0,rwdata)
item:SetChildGraphicGray(0,self.investData.paid,true)
item:SetChildActive(1,self.investData.paid)
end
end

function UIHuanJingTouZiWin:setRewardList()
local levelRewards=UIHuanJingControl:getTZRewardList(self.investData.rechargeId)
local len=#levelRewards
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=levelRewards[i]
local unlock=self.investData.paid
item:SetChildActive(_item_index.lock,not unlock)
item:SetChildText(_item_index.level,UIHuanJingControl:getLevelName('关卡：',data.level))
self:setLevelReward(item,data.rwId)
if unlock then
item:SetChildActive(_item_index.tips,false)
local complete=UIHuanJingControl:isLevelComplete(data.level)
if complete then
local receive=data.receive
item:SetChildActive(_item_index.undone_btn,false)
item:SetChildActive(_item_index.receive_btn,not receive)
item:SetChildActive(_item_index.received,receive)
item:SetChildActive(_item_index.bg2,receive)
if not receive then
item:SetChildButtonClick(_item_index.receive_btn,function()

self:receiveAll()
end)
end
if not receive then
self.receiveList[data.level]=true
end
else
item:SetChildActive(_item_index.undone_btn,true)
item:SetChildActive(_item_index.receive_btn,false)
item:SetChildActive(_item_index.received,false)
item:SetChildActive(_item_index.bg2,false)
item:SetChildButtonClick(_item_index.undone_btn,function()
UIManager.error('需先完成关卡')
end)
end
else
item:SetChildActive(_item_index.receive_btn,false)
item:SetChildActive(_item_index.undone_btn,false)
item:SetChildActive(_item_index.received,false)
item:SetChildActive(_item_index.bg2,false)
end
end
end

function UIHuanJingTouZiWin:setLevelReward(item,rwId)
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
for i,v in ipairs(_item_index.rw_items)do
local rdata=rewards[i]
if rdata then
item:SetChildActive(v,true)
widgetHelper.setNormalRewardItem(item,v,rdata)
else
item:SetChildActive(v,false)
end
end
end

function UIHuanJingTouZiWin:checkTZFinish()
local investData=UILiLianControl:getInvestData()
local unlock=investData.paid
if not unlock then
return false
end
local levelRewards=UILiLianControl:getTZRewardList(investData.rechargeId)
for i,v in ipairs(levelRewards)do
local complete=UILiLianControl:isLevelComplete(v.level)
if complete then
if not v.receive then
return false
end
else
return false
end
end
return true
end




function UIHuanJingTouZiWin:receiveAll()
for k,v in pairs(self.receiveList)do
UIHuanJingControl:setTZRewardCheck(k)
UIHuanJingControl:reqReceiveInvest(self.investData.rechargeId,k)
end
self.receiveList={}
end

function UIHuanJingTouZiWin:onPayBtn()
if not self.investData.paid then
payControl.reqPay(self.investData.rechargeId)
else
UIManager.info('已购买')
end
end

function UIHuanJingTouZiWin:onCloseClick()
self:closeSelf()
end