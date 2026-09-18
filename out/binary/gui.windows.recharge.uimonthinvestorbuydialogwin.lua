







def_class("UIMonthInvestorBuyDialogWin",UIWindowBase)









function UIMonthInvestorBuyDialogWin:bindComponents()

self.linkImageText=UILinkImageText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.titleText=UIText.get(self,2)
self.cancelButton=UIButton.get(self,3)
self.okButton=UIButton.get(self,4)
self.cancelText=UIText.get(self,5)
self.okText=UIText.get(self,6)
self.originalPriceBg=UIObject.get(self,7)
self.discountFlag=UIObject.get(self,8)
self.discountFlag2=UIObject.get(self,9)
self.originalPriceText=UIText.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIMonthInvestorBuyDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.originalPriceBg);self.originalPriceBg=nil;
_UIObject_release(self.discountFlag);self.discountFlag=nil;
_UIObject_release(self.discountFlag2);self.discountFlag2=nil;
_UIObject_release(self.originalPriceText);self.originalPriceText=nil;
end
















local _this




local abname='ui/windows/recharge/monthcard_atlas_pak.ab'
local imagename=
{
"image_xianshizhekou",
"image_xianshizhekou_02",

}

function UIMonthInvestorBuyDialogWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)

end


function UIMonthInvestorBuyDialogWin:__delete()
self:unbindComponents()
_this=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end


function UIMonthInvestorBuyDialogWin:onShow(showdata)

self.titleText:setText(showdata.title)
self.linkImageText:setText(showdata.content)
self.okText:setText(showdata.oktext)

if showdata.canceltext~=nil then
self.cancelText:setText(showdata.canceltext)
else
self.cancelButton:setActive(false)
end
if showdata.showclosebtn then
self.closeBtn:setActive(showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end

self.showdata=showdata
self.id=showdata.id

local showMoney
local moneytypes=showdata.moneytypes
if moneytypes then
showMoney=true
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIMonthInvestorBuyDialogWin'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

self.originalPrice=showdata.originalPrice
self.originalPriceText:setActive(self.originalPrice~=nil)
if self.originalPrice then
self.originalPriceText:setText(FMT.fmt("原价:{0}",self.originalPrice))
end

self.hasDiscount=showdata.hasDiscount
self.havecount=showdata.havecount
self.havecount2=showdata.havecount2
self.originalPriceBg:setActive(self.hasDiscount)
self.discountFlag:setActive(self.hasDiscount)
if self.havecount then
self.discountFlag2:setActive(true)
self.discountFlag2:setSprite(abname,imagename[1])
elseif self.havecount2>0 then
self.discountFlag2:setActive(true)
self.discountFlag2:setSprite(abname,imagename[2])
else
self.discountFlag2:setActive(false)
end

end

function UIMonthInvestorBuyDialogWin:doClose()
local closecallback=self.showdata.closecallback

if closecallback then
closecallback()
end
return self:closeSelf()
end

function UIMonthInvestorBuyDialogWin:doOk()
local okcallback=self.showdata.okcallback
if okcallback then
okcallback()
end
return self:closeSelf()
end

function UIMonthInvestorBuyDialogWin:doCancel()
return self:closeSelf()
end


function UIMonthInvestorBuyDialogWin:onCloseBtn()
self:doClose()
end

function UIMonthInvestorBuyDialogWin:onCancelButton()
local cancelcallback=self.showdata.cancelcallback


if cancelcallback then
cancelcallback()
end
return self:closeSelf()
end

function UIMonthInvestorBuyDialogWin:onOkButton()
local okcallback=self.showdata.okcallback


if okcallback then
okcallback()
end
return self:closeSelf()
end

function UIMonthInvestorBuyDialogWin:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIMonthInvestorBuyDialogWin.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end
if subType==SUB_ACTIVITY_TYPE.eYueKaZengLi then
if state==activitiesModel.activityFinishState then
return _this:closeSelf()
end
end
end