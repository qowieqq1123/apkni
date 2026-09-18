







def_class("UISubAct_SHXB_dialougeWin",UIWindowBase)









function UISubAct_SHXB_dialougeWin:bindComponents()

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
self.descText=UILinkImageText.get(self,11)
self.tipsText=UILinkImageText.get(self,12)
self.sliderRoot=UIObject.get(self,13)
self.selectCntSlider=UIObject.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UISubAct_SHXB_dialougeWin:unbindComponents()
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
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
end



















function UISubAct_SHXB_dialougeWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_SHXB_dialougeWin:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UISubAct_SHXB_dialougeWin:onShow(argtable,afterOnloaded)
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
self.descText:setText(str)
local tipsStr=self.showdata.tips or str2
if tipsStr then
self.tipsText:setText(tipsStr)
self.tipsText:setActive(true)
else
self.tipsText:setActive(false)
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

function UISubAct_SHXB_dialougeWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)

local str,str2=self.showdata.refreshcallback(value)
self.descText:setText(str)

if str2 then
self.tipsText:setActive(true)
self.tipsText:setText(str2)
else
self.tipsText:setActive(false)
end
end



function UISubAct_SHXB_dialougeWin:onHide()

end





function UISubAct_SHXB_dialougeWin:onCloseBtn()
self:doClose()
end



function UISubAct_SHXB_dialougeWin:onMaxCnt()
end



function UISubAct_SHXB_dialougeWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UISubAct_SHXB_dialougeWin:onAddBtn()




if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UISubAct_SHXB_dialougeWin:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

if cancelcallback then
cancelcallback()
end
self:closeSelf()
end



function UISubAct_SHXB_dialougeWin:onOkButton()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end

local okcallback=self.showdata.okcallback

if okcallback then
okcallback(selectCnt)
end
self:closeSelf()
end

function UISubAct_SHXB_dialougeWin:onLongPressBtn(id)
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

function UISubAct_SHXB_dialougeWin:onBGClick()
self:doClose()
end

function UISubAct_SHXB_dialougeWin:doClose()
local closecallback=self.showdata.closecallback
if closecallback then
closecallback()
end
self:closeSelf()
end

function UISubAct_SHXB_dialougeWin:doOk()
local okcallback=self.showdata.okcallback
if okcallback then
okcallback()
end
self:closeSelf()
end

function UISubAct_SHXB_dialougeWin:doCancel()
self:closeSelf()
end