







def_class("UIXBSL_xuanShangBuyWin",UIWindowBase)









function UIXBSL_xuanShangBuyWin:bindComponents()

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


function UIXBSL_xuanShangBuyWin:unbindComponents()
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



















function UIXBSL_xuanShangBuyWin:onLoaded(...)
self:bindComponents()
end


function UIXBSL_xuanShangBuyWin:__delete()
self:unbindComponents()
end




function UIXBSL_xuanShangBuyWin:onShow(argtable,afterOnloaded)
self.rechargeId=argtable.rechargeId
self.bountyId=argtable.bountyId
self.xuanshangCfg=argtable.xuanshangCfg


self.root:setChildCanvasGroupAlpha(0)


self.model:setChildUIModelShowTarget(4005,1,{},2059,
false,false,0,function()
self:setSpineCallBackFun()
end)

self:refresh()
end


function UIXBSL_xuanShangBuyWin:onHide()
self:clearTimer()
end


function UIXBSL_xuanShangBuyWin:setSpineCallBackFun()
self:clearTimer()

self.rootTimer=self:setTimer(0.3,1,function()
if self.isClose then return end
self.root:setChildCanvasGroupDOFade(1,0.3)
end)
end

function UIXBSL_xuanShangBuyWin:refresh()

self:refreshShowPanel()


local rechargeId=self.rechargeId
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
if str then
self.price:setText(FMT.fmt("{0}购",str))
else
logErr(FMT.fmt("找不到充值id: {0}对应的rmb价格配置",rechargeId))
end
end


function UIXBSL_xuanShangBuyWin:refreshShowPanel()

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

function UIXBSL_xuanShangBuyWin:initRewardsList()
self.activateRewardsList={}
self.activateRewardsList_lookUp={}
self.finalRewardsList={}
self.finalRewardsList_lookUp={}
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(XBSL_DIFFICULTY_MODE.Normal)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(XBSL_DIFFICULTY_MODE.Normal)
local rewardParamList=self.xuanshangCfg.bounty_invest_reward

local buyRewardList=self.xuanshangCfg.buy_rewards
for _,v in ipairs(buyRewardList)do
local itemId=v[1]
local itemCount=v[2]

if self.activateRewardsList_lookUp[itemId]then
self.activateRewardsList_lookUp[itemId][2]=self.activateRewardsList_lookUp[itemId][2]+itemCount
else
local item={itemId,itemCount}
self.activateRewardsList_lookUp[itemId]=item
self.activateRewardsList[#self.activateRewardsList+1]=item
end

if self.finalRewardsList_lookUp[itemId]then
self.finalRewardsList_lookUp[itemId][2]=self.finalRewardsList_lookUp[itemId][2]+itemCount
else
local item={itemId,itemCount}
self.finalRewardsList_lookUp[itemId]=item
self.finalRewardsList[#self.finalRewardsList+1]=item
end
end


for i,v in ipairs(rewardParamList)do
local isFinish=false
local chapterId=v[1]
local levelIdx=v[2]
local rewardList=v[3]
if clearChapterId>chapterId or(clearChapterId==chapterId and clearLevelIdx>=levelIdx)then
isFinish=true
end
for _,v in ipairs(rewardList)do
local itemId=v[1]
local itemCount=v[2]

if isFinish then

if self.activateRewardsList_lookUp[itemId]then
self.activateRewardsList_lookUp[itemId][2]=self.activateRewardsList_lookUp[itemId][2]+itemCount
else
local item={itemId,itemCount}
self.activateRewardsList_lookUp[itemId]=item
self.activateRewardsList[#self.activateRewardsList+1]=item
end
end


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





function UIXBSL_xuanShangBuyWin:onBuyBtn()

local bountyId=self.bountyId
local isBought=xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)
local rechargeId=self.rechargeId
if not isBought then
local param=FMT.fmt('{0}',bountyId)
payControl.reqPay(rechargeId,1,param)
end

self:onClickClose()
end



function UIXBSL_xuanShangBuyWin:onCancelBtn()
self:onClickClose()
end



function UIXBSL_xuanShangBuyWin:onClickClose()
self:closeSelf()
end


function UIXBSL_xuanShangBuyWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIXBSL_xuanShangBuyWin:clearTimer()
if self.rootTimer then
self:stopTimerByID(self.rootTimer)
self.rootTimer=nil
end
end