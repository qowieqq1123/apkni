







def_class("UIShangHang_limitInvestorBuyWin",UIWindowBase)









function UIShangHang_limitInvestorBuyWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.buyBtn=UIButton.get(self,3)
self.cancelBtn=UIButton.get(self,4)
self.activateRewardsPanel=UIObject.get(self,5)
self.finalRewardsPanel=UIObject.get(self,6)
self.activateRewards=UIObject.get(self,7)
self.finalRewards=UIObject.get(self,8)
self.price=UIText.get(self,9)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UIShangHang_limitInvestorBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.activateRewardsPanel);self.activateRewardsPanel=nil;
_UIObject_release(self.finalRewardsPanel);self.finalRewardsPanel=nil;
_UIObject_release(self.activateRewards);self.activateRewards=nil;
_UIObject_release(self.finalRewards);self.finalRewards=nil;
_UIObject_release(self.price);self.price=nil;
end



















function UIShangHang_limitInvestorBuyWin:onLoaded(...)
self:bindComponents()
end


function UIShangHang_limitInvestorBuyWin:__delete()
self:unbindComponents()
end




function UIShangHang_limitInvestorBuyWin:onShow(argtable,afterOnloaded)
local investId=shangHangModel:getInvestId()or 1
local investCfg=cfgHelper.get(cfg_shanghangtargetconfig_get,investId)
self.investId=investId
self.inCome=shangHangModel:getTotalInCome()
local rewards=investCfg.rewards
self.allReward=rewards

local Idx=0
for i,v in ipairs(self.allReward)do
local need=v[1]
if self.inCome<need then
break
end
Idx=i
end
self.Idx=Idx

self:refreshShowPanel()

local recharge_id=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"recharge_id")
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
if rechargeCfg then
self.price:setText(FMT.fmt("{0}购",str))
else
logErr(FMT.fmt("找不到充值id: {0}对应的rmb价格配置",recharge_id))
end
end


function UIShangHang_limitInvestorBuyWin:onHide()

end

function UIShangHang_limitInvestorBuyWin:initRewardsList()
self.activateRewardsList={}
self.activateRewardsList_lookUp={}
self.finalRewardsList={}
self.finalRewardsList_lookUp={}

for i=1,#self.allReward do

local exrEwards=self.allReward[i][2][2]
if i<=self.Idx then

for _,v in ipairs(exrEwards)do
local itemId=v[1]
local itemCount=v[2]

if self.activateRewardsList_lookUp[itemId]then
self.activateRewardsList_lookUp[itemId][2]=self.activateRewardsList_lookUp[itemId][2]+itemCount
else
local item={itemId,itemCount}
self.activateRewardsList_lookUp[itemId]=item
self.activateRewardsList[#self.activateRewardsList+1]=item
end
end
end


for _,v in ipairs(exrEwards)do
local itemId=v[1]
local itemCount=v[2]

if self.finalRewardsList_lookUp[itemId]then
self.finalRewardsList_lookUp[itemId][2]=self.finalRewardsList_lookUp[itemId][2]+itemCount
else
local item={itemId,itemCount}
self.finalRewardsList_lookUp[itemId]=item
self.finalRewardsList[#self.finalRewardsList+1]=item
end
end

end
end


function UIShangHang_limitInvestorBuyWin:refreshShowPanel()

self:initRewardsList()


if self.activateRewardsList and next(self.activateRewardsList)then

self.activateRewardsPanel:setActive(true)

self.activateRewards:setChildLayoutGroupCreateItems(0)
self.activateRewards:setChildLayoutGroupCreateItems(#self.activateRewardsList)
local gridlist=self.activateRewards:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local widget=gridlist[i-1]
local reward=self.activateRewardsList[i]
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
else

self.activateRewardsPanel:setActive(false)
end



self.finalRewards:setChildLayoutGroupCreateItems(0)
self.finalRewards:setChildLayoutGroupCreateItems(#self.finalRewardsList)
local gridlist=self.finalRewards:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local widget=gridlist[i-1]
local reward=self.finalRewardsList[i]
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end

function UIShangHang_limitInvestorBuyWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end




function UIShangHang_limitInvestorBuyWin:onBuyBtn()
local recharge_id=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"recharge_id")
payControl.reqPay(recharge_id)


self:onClickClose()
end



function UIShangHang_limitInvestorBuyWin:onCancelBtn()
self:onClickClose()
end

function UIShangHang_limitInvestorBuyWin:onClickClose()
self:closeSelf()
end