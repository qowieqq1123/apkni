







def_class("UIWanBaoShangHui_sellPanelWin",UIWindowBase)









function UIWanBaoShangHui_sellPanelWin:bindComponents()

self.costIcon=UIImage.get(self,0)
self.costCount=UIText.get(self,1)
self.priceIcon=UIImage.get(self,2)
self.priceInputField=UIInputField.get(self,3)
self.Placeholder=UIText.get(self,4)
self.anonymizeToggle=UIToggleButton.get(self,5)
self.frontClickMask=UIObject.get(self,6)
self.tips=UIText.get(self,7)



end


function UIWanBaoShangHui_sellPanelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.priceIcon);self.priceIcon=nil;
_UIObject_release(self.priceInputField);self.priceInputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.anonymizeToggle);self.anonymizeToggle=nil;
_UIObject_release(self.frontClickMask);self.frontClickMask=nil;
_UIObject_release(self.tips);self.tips=nil;
end


local _topLayer='UITopModel'
local _topOrder=2001
















function UIWanBaoShangHui_sellPanelWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoShangHui_sellPanelWin:__delete()
self:unbindComponents()
end




function UIWanBaoShangHui_sellPanelWin:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
self.attach=data.attach
self.itemConfig=itemsConfig.getConfig(itemid)

local auctionSeries=data.auctionSeries
self.auctionData=auctionSeries and auctionModel:getPersonAuctionSellItemDataByAuctionSeries(auctionSeries)or nil

if self.auctionData then

self.isAnonymous=not self.auctionData.ownername or self.auctionData.ownername==""


tipsManager.setTipsAttachTableArgs(self.attach,{'auctionSeries'},auctionSeries)
else

self.isAnonymous=auctionModel:getPersonAuctionSellIsAnonymous()
end
tipsManager.setTipsAttachTableArgs(self.attach,{'isAnonymous'},self.isAnonymous)
self:initInputField()


self.priceInputField:setChildInputFieldChange(true,function()
self:onInputFieldValueChange()
end)

if self.auctionData then

self.Placeholder:setActive(false)

local price=self.auctionData.auctionprice
self.priceInputField:setInputFieldValue(price)
else

self:refreshSellPanel()
end
end


function UIWanBaoShangHui_sellPanelWin:onHide()

end

function UIWanBaoShangHui_sellPanelWin:initInputField()
self:setInputMask(false)

self.Placeholder:setActive(true)
self.priceInputField:setInputFieldValue('')
self.cost=0
self.costMoneyType=nil
self.price=nil
end

function UIWanBaoShangHui_sellPanelWin:refreshSellPanel()
local str=self.priceInputField:getInputFieldValue()
if str~=''then
self.price=tonumber(str)
else
self.price=nil
end

self:setAttachPrice(self.price)
self.cost,self.costMoneyType=auctionModel:getPersonAuctionSellCostByPrice(self.price)

self.costIcon:setChildIcon(iconHelper.getIconName(self.costMoneyType),false)

local enough=moneyModel.checkEnoughMoney(self.costMoneyType,self.cost)
if enough then
self.costCount:setText(self.cost)
else

self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",self.cost))
end



self.anonymizeToggle:setToggle(self.isAnonymous)


self.anonymizeToggle:setToggleChange(function(...)self:onToggleChanged(...)end)


local persontax=cfgHelper.get2(cfg_auctionconfig_get,1,'persontax')
self.tips:setText(FMT.fmt("拍卖成功将收取<color=#ca631d>{0}%</color>手续费，且获得的仙玉会1比1转换为灵玉",persontax))
end

function UIWanBaoShangHui_sellPanelWin:onClickInput()

self.Placeholder:setActive(false)
end


function UIWanBaoShangHui_sellPanelWin:onExitInput()
self:setInputMask(false)
local str=self.priceInputField:getInputFieldValue()
if str~=''then
self.price=tonumber(str)
else
self.price=nil
end

self:setAttachPrice(self.price)
if self.price then

local minPrice=self.itemConfig.wbsh[1]
if self.price<minPrice then

self.priceInputField:setInputFieldValue(minPrice)
UIManager.error("竞拍底价过低，已为您调整")
return
end
else

self.Placeholder:setActive(true)
end
end

function UIWanBaoShangHui_sellPanelWin:onInputFieldValueChange()
local str=self.priceInputField:getInputFieldValue()
if str~=''then
if str=='-'then
return self.priceInputField:setInputFieldValue('')
else
local price=tonumber(str)
if price and price<0 then
return self.priceInputField:setInputFieldValue(0)
end
end
end

self:refreshSellPanel()

local isShowMask=false
if self.price then

local minPrice=self.itemConfig.wbsh[1]
isShowMask=self.price<minPrice
end
self:setInputMask(isShowMask)
end

function UIWanBaoShangHui_sellPanelWin:setAttachPrice(price)
tipsManager.setTipsAttachTableArgs(self.attach,{'auctionSellPrice'},price)
end

function UIWanBaoShangHui_sellPanelWin:setInputMask(isActive)
self.frontClickMask:setActive(isActive)










end

function UIWanBaoShangHui_sellPanelWin:onToggleChanged(name,isToggle,data)
self.isAnonymous=isToggle
if not self.auctionData then
auctionModel:setPersonAuctionSellIsAnonymous(isToggle)
end
tipsManager.setTipsAttachTableArgs(self.attach,{'isAnonymous'},self.isAnonymous)


self.anonymizeToggle:setToggle(self.isAnonymous)
end


