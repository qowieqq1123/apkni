







def_class("UIGuPiaoBuyCountWin",UIWindowBase)









function UIGuPiaoBuyCountWin:bindComponents()

self.speIcon=UIObject.get(self,0)
self.sliderRoot=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.titleText=UIText.get(self,3)
self.linkImageText33=UILinkImageText.get(self,4)
self.linkImageText44=UILinkImageText.get(self,5)
self.linkImageText55=UILinkImageText.get(self,6)
self.linkImageText22=UILinkImageText.get(self,7)
self.linkImageText11=UILinkImageText.get(self,8)
self.selectCntSlider=UIObject.get(self,9)
self.addBtn=UIButton.get(self,10)
self.subBtn=UIButton.get(self,11)
self.maxCnt=UIButton.get(self,12)
self.handleImg=UIObject.get(self,13)
self.selectCntText=UIText.get(self,14)
self.cancelButton=UIButton.get(self,15)
self.okButton=UIButton.get(self,16)
self.cancelText=UIText.get(self,17)
self.okText=UIText.get(self,18)
self.icon=UIImage.get(self,19)
self.name=UIText.get(self,20)
self.linkImageText1=UILinkImageText.get(self,21)
self.linkImageText2=UILinkImageText.get(self,22)
self.linkImageText3=UILinkImageText.get(self,23)
self.linkImageText4=UILinkImageText.get(self,24)
self.linkImageText5=UILinkImageText.get(self,25)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIGuPiaoBuyCountWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.speIcon);self.speIcon=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.linkImageText33);self.linkImageText33=nil;
_UIObject_release(self.linkImageText44);self.linkImageText44=nil;
_UIObject_release(self.linkImageText55);self.linkImageText55=nil;
_UIObject_release(self.linkImageText22);self.linkImageText22=nil;
_UIObject_release(self.linkImageText11);self.linkImageText11=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.linkImageText1);self.linkImageText1=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
_UIObject_release(self.linkImageText3);self.linkImageText3=nil;
_UIObject_release(self.linkImageText4);self.linkImageText4=nil;
_UIObject_release(self.linkImageText5);self.linkImageText5=nil;
end



















function UIGuPiaoBuyCountWin:onLoaded(...)
self:bindComponents()
end


function UIGuPiaoBuyCountWin:__delete()
self:unbindComponents()
end




function UIGuPiaoBuyCountWin:onShow(argtable,afterOnloaded)
self.showdata=argtable

self.titleText:setText(self.showdata.title)

self.okText:setText(self.showdata.oktext)
self.speIcon:setActive(self.showdata.speIcon~=nil)
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
if self.showdata.refreshcallback1 then
local str=self.showdata.refreshcallback1(self.selectCnt)
self.linkImageText1:setActive(true)
self.linkImageText1:setText(str)
else
self.linkImageText1:setActive(false)
end
if self.showdata.refreshcallback2 then
local str=self.showdata.refreshcallback2(self.selectCnt)
self.linkImageText2:setActive(true)
self.linkImageText2:setText(str)
else
self.linkImageText2:setActive(false)
end
if self.showdata.refreshcallback3 then
local str=self.showdata.refreshcallback3(self.selectCnt)
self.linkImageText3:setActive(true)
self.linkImageText3:setText(str)
else
self.linkImageText3:setActive(false)
end
if self.showdata.refreshcallback4 then
local str=self.showdata.refreshcallback4(self.selectCnt)
self.linkImageText4:setActive(true)
self.linkImageText4:setText(str)
else
self.linkImageText4:setActive(false)
end
if self.showdata.refreshcallback5 then
local str=self.showdata.refreshcallback5(self.selectCnt)
self.linkImageText5:setActive(true)
self.linkImageText5:setText(str)
else
self.linkImageText5:setActive(false)
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
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIGuPiaoBuyCountWin'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

if self.showdata.text11 then
self.linkImageText11:setText(self.showdata.text11)
end
if self.showdata.text22 then
self.linkImageText22:setText(self.showdata.text22)
end
if self.showdata.text33 then
self.linkImageText33:setText(self.showdata.text33)
end
if self.showdata.text44 then
self.linkImageText44:setText(self.showdata.text44)
end
if self.showdata.text55 then
self.linkImageText55:setText(self.showdata.text55)
end

self.icon:setChildIcon(self.showdata.icon)
self.name:setText(self.showdata.name)
end


function UIGuPiaoBuyCountWin:onHide()

end

function UIGuPiaoBuyCountWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)

if self.showdata.refreshcallback1 then
local str=self.showdata.refreshcallback1(self.selectCnt)
self.linkImageText1:setText(str)
end
if self.showdata.refreshcallback2 then
local str=self.showdata.refreshcallback2(self.selectCnt)
self.linkImageText2:setText(str)
end
if self.showdata.refreshcallback3 then
local str=self.showdata.refreshcallback3(self.selectCnt)
self.linkImageText3:setText(str)
end
if self.showdata.refreshcallback4 then
local str=self.showdata.refreshcallback4(self.selectCnt)
self.linkImageText4:setText(str)
end
if self.showdata.refreshcallback5 then
local str=self.showdata.refreshcallback5(self.selectCnt)
self.linkImageText5:setText(str)
end
end





function UIGuPiaoBuyCountWin:onCloseBtn()
self:doClose()
end

function UIGuPiaoBuyCountWin:onBGClick()
self:doClose()
end



function UIGuPiaoBuyCountWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIGuPiaoBuyCountWin:onMaxCnt()
end



function UIGuPiaoBuyCountWin:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIGuPiaoBuyCountWin:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self:closeSelf()

if cancelcallback then
cancelcallback()
end
end



function UIGuPiaoBuyCountWin:onOkButton()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end

local okcallback=self.showdata.okcallback

self:closeSelf()

if okcallback then
okcallback(selectCnt)
end
end

function UIGuPiaoBuyCountWin:doClose()
local closecallback=self.showdata.closecallback

self:closeSelf()
if closecallback then
closecallback()
end
end

function UIGuPiaoBuyCountWin:doOk()
local okcallback=self.showdata.okcallback
self:closeSelf()
if okcallback then
okcallback()
end
end

function UIGuPiaoBuyCountWin:doCancel()
self:close()
end