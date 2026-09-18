







def_class("UIUseItemDialouge",UIWindowBase)









function UIUseItemDialouge:bindComponents()

self.autoLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.selectCntSlider=UIObject.get(self,2)
self.handleImg=UIObject.get(self,3)
self.maxCnt=UIButton.get(self,4)
self.subBtn=UIButton.get(self,5)
self.addBtn=UIButton.get(self,6)
self.icon=UIImage.get(self,7)
self.costText=UIText.get(self,8)
self.cancelText=UIText.get(self,9)
self.okText=UIText.get(self,10)
self.selectCntText=UIText.get(self,11)
self.cancelButton=UIButton.get(self,12)
self.okButton=UIButton.get(self,13)
self.dialougeText=UIText.get(self,14)
self.titleText=UIText.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIUseItemDialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoLayout);self.autoLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIUseItemDialouge:onLoaded(...)
self:bindComponents()
end


function UIUseItemDialouge:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
end




function UIUseItemDialouge:onShow(showdata,afterOnloaded)
self.showdata=showdata
self.titleText:setText(showdata.title)

self.okText:setText(showdata.oktext)

self.itemId=showdata.itemId
self.unitPrice=showdata.unitPrice or 1
self.max=showdata.max or 99

if self.itemId~=nil then
local count=itemsModel.getCount(self.itemId)
if self.itemId==eMoneyType.mtLingYu then

local xianyu=moneyModel.getMoney(eMoneyType.mtXianYu)
if xianyu>0 then
count=count+xianyu
end
end
if count<self.max*self.unitPrice then
self.max=math.floor(count/self.unitPrice)
self.isCantBuy=true
end

self.icon:setChildIcon(iconHelper.getIconName(self.itemId))
end
self.min=1
if self.max<=0 then
self.max=1
end
self.selectCnt=self.min

self.need=self.selectCnt*self.unitPrice

if self.max<=1 then
self.selectCntSlider:setActive(false)
self.autoLayout:setChildAnchoredPosition(Vector3.New(25,-195,0))
end

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

local func=function(...)
self:onSliderChange(...)
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIUseItemDialouge:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
self.need=self.selectCnt*self.unitPrice
self.costText:setText(FMT.fmt("<color=#843c0c>{0}</color>购买",self.need))
end


function UIUseItemDialouge:onHide()

end





function UIUseItemDialouge:onCloseBtn()
end



function UIUseItemDialouge:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()
if cancelcallback then
cancelcallback()
end
end



function UIUseItemDialouge:onOkButton()
local okcallback=self.showdata.okcallback
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if self.itemId~=nil then
local count=itemsModel.getCount(self.itemId)
if count<selectCnt*self.unitPrice and self.isWarning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(self.itemId)))
if not gainControl:showGainWin(self.itemId)then
return
end
end
end

self.showdata:deleteSelf()

self:close()
if okcallback then
okcallback(selectCnt)
end
end



function UIUseItemDialouge:onMaxCnt()
end



function UIUseItemDialouge:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIUseItemDialouge:onAddBtn()
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIUseItemDialouge:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIUseItemDialouge:onCloseBtn()
self:doClose()
end

function UIUseItemDialouge:onBGClick()
self:doClose()
end


function UIUseItemDialouge:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIUseItemDialouge:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIUseItemDialouge:doCancel()
self.showdata:deleteSelf()
self:close()
end
