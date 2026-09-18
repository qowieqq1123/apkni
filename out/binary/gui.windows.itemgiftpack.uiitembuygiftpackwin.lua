







def_class("UIItemBuyGiftPackWin",UIWindowBase)









function UIItemBuyGiftPackWin:bindComponents()

self.buyBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.needIcon=UIObject.get(self,3)
self.needText=UIText.get(self,4)
self.root=UIObject.get(self,5)
self.scrollView=UIObject.get(self,6)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIItemBuyGiftPackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.needIcon);self.needIcon=nil;
_UIObject_release(self.needText);self.needText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end



















function UIItemBuyGiftPackWin:onLoaded(...)
self:bindComponents()
end


function UIItemBuyGiftPackWin:__delete()
self:unbindComponents()
end




function UIItemBuyGiftPackWin:onShow(argtable,afterOnloaded)
self.itemguid=argtable.itemguid
local itemid=bagModel.getItemIdByGUID(self.itemguid)
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
self.giftid=funcparam.giftid
local giftCfg=cfgHelper.get1(cfg_voerseasgiftconfig_get,self.giftid)
self.giftCfg=giftCfg
self.winlua:SetChildScrollViewStopGridCreate(self.scrollView:getID())
self.winlua:SetChildScrollViewCreateGrids(self.scrollView:getID(),0,0)
local reward=giftCfg.rewards
local len=#reward
self.winlua:SetChildScrollViewDelayCreateGrids(self.scrollView:getID(),len,0,0.02,1,false,false,function(i,item)
local data=reward[i+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
local priceStr=""
if giftCfg.rechargeid then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,giftCfg.rechargeid)
priceStr=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.needIcon:setActive(false)
else
local moneyType,moneyCount=unpack(giftCfg.price[1])
priceStr=moneyCount
self:showWindow('UITopMoneyWin2',{{moneyType}})
self.needIcon:setChildIcon(iconHelper.getIconName(moneyType),false)
self.needIcon:setActive(true)
end
self.priceStr=priceStr
self.needText:setText(priceStr)
self.desc:setText(giftCfg.desc or'')
baseFullScreenUI:clearNeedShowBackWindow()
end



function UIItemBuyGiftPackWin:onBuyBtn()
local isExpire=bagUseControl.isItemExpire(self.itemguid)
if isExpire then
UIManager.error("道具已过期，无法购买")
loggerUtil.logErrFMT("道具已过期，无法购买  道具guid：{0}",self.itemguid)
self:closeSelf()
return
end
local giftCfg=self.giftCfg
local buyFunc=function()
if giftCfg.rechargeid then
local rechargeId=giftCfg.rechargeid
local buyCount=1
local param=FMT.fmt('{0}-{1}',self.giftid,self.itemguid)
payControl.reqPay(rechargeId,buyCount,param)
else
local moneyType,moneyCount=unpack(giftCfg.price[1])
local have=moneyModel.getMoney(moneyType)
if have<moneyCount then
gainControl:showGainWin(moneyType)
return
end
rechargeController:reqBuyItemGiftPack(self.giftid,self.itemguid)
end
end

local args={
rewards=giftCfg.rewards,
name="礼包",
maxcount=1,
showBuyLimit=false,
callback=function(num)
buyFunc()
end
}
if giftCfg.rechargeid then
args.comfirmText=self.priceStr
else
local moneyType,moneyCount=unpack(giftCfg.price[1])
args.price={moneyType,moneyCount}
end
UIManager:showWindow("UICommonBuyDialogWin",args)
end

function UIItemBuyGiftPackWin:onCloseBtn()
self:closeSelf()
end

