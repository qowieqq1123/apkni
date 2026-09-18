







def_class("UIDialougeBuyCount",UIWindowBase)









function UIDialougeBuyCount:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.handleImg=UIObject.get(self,1)
self.maxCnt=UIButton.get(self,2)
self.subBtn=UIButton.get(self,3)
self.addBtn=UIButton.get(self,4)
self.cancelText=UIText.get(self,5)
self.okText=UIText.get(self,6)
self.selectCntText=UIText.get(self,7)
self.cancelButton=UIButton.get(self,8)
self.okButton=UIButton.get(self,9)
self.titleText=UIText.get(self,10)
self.linkImageText1=UILinkImageText.get(self,11)
self.linkImageText2=UILinkImageText.get(self,12)
self.sliderRoot=UIObject.get(self,13)
self.selectCntSlider=UIObject.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBuyCount:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
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
_UIObject_release(self.linkImageText1);self.linkImageText1=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
end



















function UIDialougeBuyCount:onLoaded(...)
self:bindComponents()
end


function UIDialougeBuyCount:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIDialougeBuyCount:onShow(argtable,afterOnloaded)
self.showdata=argtable

self.titleText:setText(self.showdata.title)
self.okText:setText(self.showdata.oktext)

self.max=self.showdata.max or 99
self.min=self.showdata.min or 1
if self.max==0 then
self.max=1
end
self.selectCnt=self.showdata.defaultCnt or self.min

if self.max<=self.min then
self.sliderRoot:setActive(false)
else
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end
local str,str2=self.showdata.refreshcallback(self.selectCnt)
self.linkImageText1:setText(str)
local tipsStr=self.showdata.tips or str2
if tipsStr then
self.linkImageText2:setText(tipsStr)
self.linkImageText2:setActive(true)
else
self.linkImageText2:setActive(false)
end

if self.showdata.canceltext~=nil then
self.cancelText:setText(self.showdata.canceltext)
else
self.cancelButton:setActive(false)
end
if self.showdata.showclosebtn then
self.closeBtn:setActive(self.showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end

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

function UIDialougeBuyCount:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)

local str,str2=self.showdata.refreshcallback(value)
self.linkImageText1:setText(str)

if str2 then
self.linkImageText2:setActive(true)
self.linkImageText2:setText(str2)
else
self.linkImageText2:setActive(false)
end
end


function UIDialougeBuyCount:onHide()

end





function UIDialougeBuyCount:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()

if cancelcallback then
cancelcallback()
end
end


function UIDialougeBuyCount:onOkButton()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end

local okcallback=self.showdata.okcallback

self.showdata:deleteSelf()
self:close()

if okcallback then
okcallback(selectCnt)
end
end


function UIDialougeBuyCount:onMaxCnt()
end


function UIDialougeBuyCount:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIDialougeBuyCount:onAddBtn()




if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIDialougeBuyCount:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=self.min then
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

function UIDialougeBuyCount:onCloseBtn()
self:doClose()
end

function UIDialougeBuyCount:onBGClick()
self:doClose()
end

function UIDialougeBuyCount:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeBuyCount:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeBuyCount:doCancel()
self.showdata:deleteSelf()
self:close()
end