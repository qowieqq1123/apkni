







def_class("UIDailyTeHui_singleDay_TipsWin",UIWindowBase)









function UIDailyTeHui_singleDay_TipsWin:bindComponents()

self.mask=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.rewardScrollView=UIObject.get(self,2)
self.oneKeyBuyBtn=UIButton.get(self,3)
self.discount=UIObject.get(self,4)
self.discountText=UIText.get(self,5)
self.rebateText=UIText.get(self,6)
self.oneKeyBuyBtnText=UIText.get(self,7)
self.bgModel=UIObject.get(self,8)
self.effect=UIObject.get(self,9)
self.root=UIObject.get(self,10)

self.mask:setButtonClick(function()self:onMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.oneKeyBuyBtn:setButtonClick(function()self:onOneKeyBuyBtn()end)



end


function UIDailyTeHui_singleDay_TipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.oneKeyBuyBtn);self.oneKeyBuyBtn=nil;
_UIObject_release(self.discount);self.discount=nil;
_UIObject_release(self.discountText);self.discountText=nil;
_UIObject_release(self.rebateText);self.rebateText=nil;
_UIObject_release(self.oneKeyBuyBtnText);self.oneKeyBuyBtnText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIDailyTeHui_singleDay_TipsWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.rewardScrollView:setChildScrollViewInit(0.5,true,_onClickRewardItem,nil)
end


function UIDailyTeHui_singleDay_TipsWin:__delete()
self:unbindComponents()
end




function UIDailyTeHui_singleDay_TipsWin:onShow(argtable,afterOnloaded)

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5211,1,{},eAnimationID.enter)
self.effect:setChildShowEffect(10010,true)
self.root:setChildCanvasGroupDOFade(1,1,nil)
end

self.baseCfg=cfgHelper.get1(cfg_daydiscountsnewbasicconfig_get,1)
self.discountCfg=cfg_daydiscountsnewconfig()
local lastZmLv=rechargeModel:getDailyTeHuiSingleDayLastDailyBuyZmLv()
if not lastZmLv then
lastZmLv=1
end
local nowBuyLv=rechargeModel:getDailyTeHuiSingleDayShowDailyBuyZmLv()
rechargeModel:setDailyTeHuiSingleDayLastDailyBuyZmLv()


local rechargeId=self.baseCfg.recharge_id[pfwindowslController:getGameVersion()]or self.baseCfg.recharge_id[1]

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.oneKeyBuyBtnText:setText(FMT.fmt("一键全购（{0}）",str))

local discount=self.baseCfg.onKeyBuyDiscount
local isShowDiscount=discount~=nil
self.discount:setActive(isShowDiscount)
if isShowDiscount then
self.discountText:setText(pfwindowslController:convertDiscount_yuenan(FMT.fmt("{0}折",discount)))
end


local rebate=rechargeModel:getDailyTeHuiSingleDayRebateByZmLevel(nowBuyLv)

self.rebateText:setText(FMT.fmt("{0}",rebate))


local lastAllRewardList_lookup={}
local allRewardList_lookup={}
for _,libaoCfg in ipairs(self.discountCfg)do
if libaoCfg.recharge_id then
local rewardDropId=libaoCfg.drop_id[pfwindowslController:getGameVersion()]or libaoCfg.drop_id[1]
local lastAwardCfg=lastZmLv and itemsAwardConfig:getAwardInConfigByLevel(rewardDropId,lastZmLv)or{}
local awardCfg=itemsAwardConfig:getAwardInConfigByLevel(rewardDropId,nowBuyLv)
local lastRewards=lastAwardCfg.showItems or{}
for i,v in ipairs(lastRewards)do
local itemId=v[1]
local itemCount=v[2]
if not lastAllRewardList_lookup[itemId]then
lastAllRewardList_lookup[itemId]=itemCount
else
lastAllRewardList_lookup[itemId]=lastAllRewardList_lookup[itemId]+itemCount
end
end

local rewards=awardCfg.showItems or{}
for i,v in ipairs(rewards)do
local itemId=v[1]
local itemCount=v[2]
if not allRewardList_lookup[itemId]then
allRewardList_lookup[itemId]=itemCount
else
allRewardList_lookup[itemId]=allRewardList_lookup[itemId]+itemCount
end
end
end
end

self.allRewardList={}
for itemId,itemCount in pairs(allRewardList_lookup)do
local isNew=lastAllRewardList_lookup[itemId]==nil
local isAdd=not isNew and lastAllRewardList_lookup[itemId]<itemCount
local itemColor=itemsConfig.getItemColor(itemId)
table.insert(self.allRewardList,{itemId=itemId,itemCount=itemCount,isNew=isNew,isAdd=isAdd,itemColor=itemColor})
end

table.sort(self.allRewardList,function(a,b)
if a.itemColor==b.itemColor then
return a.itemId<b.itemId
else
return a.itemColor>b.itemColor
end
end)

self.rewardScrollView:setChildScrollViewCreateGrids(#self.allRewardList,4)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.allRewardList[i]
local itemid=reward.itemId
local count=reward.itemCount
local countStr=''
local showCountBG=false
local isNew=reward.isNew
local isAdd=reward.isAdd
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildActive(1,isNew)
item:SetChildActive(2,isAdd)
end
end
end


function UIDailyTeHui_singleDay_TipsWin:onHide()

end





function UIDailyTeHui_singleDay_TipsWin:onMask()
self:onBtnClose()
end



function UIDailyTeHui_singleDay_TipsWin:onBtnClose()
self:closeSelf()
end



function UIDailyTeHui_singleDay_TipsWin:onOneKeyBuyBtn()

local rechargeId=self.baseCfg.recharge_id[pfwindowslController:getGameVersion()]or self.baseCfg.recharge_id[1]
payControl.reqPay(rechargeId)
end

function UIDailyTeHui_singleDay_TipsWin:onClickRewardItem(clickCount,index)

local itemid=nil
local itemguid=nil

itemid=self.allRewardList[index+1].itemId

if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
