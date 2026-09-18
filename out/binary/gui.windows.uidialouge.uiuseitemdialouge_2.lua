







def_class("UIUseItemDialouge_2",UIWindowBase)









function UIUseItemDialouge_2:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.selectCntSlider=UIObject.get(self,1)
self.handleImg=UIObject.get(self,2)
self.maxCnt=UIButton.get(self,3)
self.subBtn=UIButton.get(self,4)
self.addBtn=UIButton.get(self,5)
self.cancelText=UIText.get(self,6)
self.okText=UIText.get(self,7)
self.selectCntText=UIText.get(self,8)
self.cancelButton=UIButton.get(self,9)
self.okButton=UIButton.get(self,10)
self.titleText=UIText.get(self,11)
self.linkImageText=UIText.get(self,12)
self.buyText=UIText.get(self,13)
self.icon=UIImage.get(self,14)
self.icon2=UIImage.get(self,15)
self.linkImageText2=UIText.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIUseItemDialouge_2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.buyText);self.buyText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.icon2);self.icon2=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
end


















function UIUseItemDialouge_2:onLoaded(...)
self:bindComponents()
end


function UIUseItemDialouge_2:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIUseItemDialouge_2:onShow(showdata,afterOnloaded)
self.showdata=showdata
self.titleText:setText(showdata.title)

self.okText:setText(showdata.oktext)

self.isWarning=showdata.isWarning or true
self.iconStr=showdata.iconStr
self.singlePrice=showdata.singlePrice or 1
self.iconStr2=showdata.iconStr2
self.singlePrice2=showdata.singlePrice2 or 1
self.itemid=showdata.itemid
self.itemid2=showdata.itemid2
self.max=showdata.max or 99

self.min=1
if self.max==0 then
self.max=1
end
self.selectCnt=self.min
if self.itemid~=nil then
local count=itemsModel.getCount(self.itemid)
if count<self.max*self.singlePrice then
self.max=math.floor(count/self.singlePrice)

end
self.icon:setChildIcon(iconHelper.getIconName(self.itemid))
end
if self.itemid2~=nil then
local count=itemsModel.getCount(self.itemid2)
if count<self.max*self.singlePrice2 then
self.max=math.floor(count/self.singlePrice2)
end
self.icon2:setChildIcon(iconHelper.getIconName(self.itemid2))
end

if self.max<=1 and showdata.AlwaysShowSlider~=true then
self.selectCntSlider:setActive(false)

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
if showdata.content then
self.buyText:setText(showdata.content)
end

local func=function(...)
self:onSliderChange(...)
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

local showMoney
local moneytypes=self.showdata.moneytypes
if moneytypes then
showMoney=true
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeBuyCount'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney
end

function UIUseItemDialouge_2:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
self.need=self.selectCnt*self.singlePrice
if self.itemid2 then
self.need2=self.selectCnt*self.singlePrice2
self.linkImageText:setText(FMT.fmt("<color=#843c0c>{0}</color>、",mathHelper.formatNumber(self.need)))
self.linkImageText2:setText(FMT.fmt("<color=#843c0c>{0}</color>",mathHelper.formatNumber(self.need2)))
else
self.linkImageText:setText(FMT.fmt("<color=#843c0c>{0}</color>",mathHelper.formatNumber(self.need)))
end




end


function UIUseItemDialouge_2:onHide()

end





function UIUseItemDialouge_2:onCloseBtn()
end



function UIUseItemDialouge_2:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()
if cancelcallback then
cancelcallback()
end
end



function UIUseItemDialouge_2:onOkButton()
local okcallback=self.showdata.okcallback
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if self.itemid~=nil then
local count=itemsModel.getCount(self.itemid)
if count<selectCnt*self.singlePrice and self.isWarning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(self.itemid)))
if not gainControl:showGainWin(self.itemid)then
return
end
end
end
if self.itemid2~=nil then
local count=itemsModel.getCount(self.itemid2)
if count<selectCnt*self.singlePrice2 and self.isWarning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(self.itemid2)))
if not gainControl:showGainWin(self.itemid2)then
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



function UIUseItemDialouge_2:onMaxCnt()
end



function UIUseItemDialouge_2:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIUseItemDialouge_2:onAddBtn()
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

function UIUseItemDialouge_2:onLongPressBtn(id)
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

function UIUseItemDialouge_2:onCloseBtn()
self:doClose()
end

function UIUseItemDialouge_2:onBGClick()
self:doClose()
end


function UIUseItemDialouge_2:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIUseItemDialouge_2:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIUseItemDialouge_2:doCancel()
self.showdata:deleteSelf()
self:close()
end
