







def_class("UIDialougeKuFangCount",UIWindowBase)









function UIDialougeKuFangCount:bindComponents()

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
self.tipsRoot=UIButton.get(self,15)
self.tipsPanel=UIObject.get(self,16)
self.tipsTx=UIText.get(self,17)
self.tipsBtn=UIButton.get(self,18)
self.newtips=UIText.get(self,19)
self.newtip3=UIText.get(self,20)
self.paneltipsa=UIText.get(self,21)
self.paneltipsb=UIText.get(self,22)
self.paneltipsc=UIText.get(self,23)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeKuFangCount:unbindComponents()
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
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.newtips);self.newtips=nil;
_UIObject_release(self.newtip3);self.newtip3=nil;
_UIObject_release(self.paneltipsa);self.paneltipsa=nil;
_UIObject_release(self.paneltipsb);self.paneltipsb=nil;
_UIObject_release(self.paneltipsc);self.paneltipsc=nil;
end



















function UIDialougeKuFangCount:onLoaded(...)
self:bindComponents()
end


function UIDialougeKuFangCount:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIDialougeKuFangCount:onShow(argtable,afterOnloaded)
self.showdata=argtable

self.titleText:setText(self.showdata.title)
if self.showdata.tips then
self.linkImageText2:setText(self.showdata.tips)
else
self.linkImageText2:setActive(false)
end
if self.showdata.tips2 then
self.newtips:setText(self.showdata.tips2)
self.sliderRoot:setLocalPosY(-34)
else
self.newtips:setActive(false)
self.sliderRoot:setLocalPosY(-16)
end
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
local str=self.showdata.refreshcallback(self.selectCnt)

self.newtip3:setText(str)

if self.showdata.tips3 then
self.linkImageText1:setText(self.showdata.tips3)
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
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeKuFangCount'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

self.tipsTx:setText(self.showdata.tipContent)
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
self.winlua:SetChildAnchoredPosition(self.tipsPanel:getID(),self.showdata.tipsPos)
self.tipsRoot:setActive(false)

if self.showdata.paneltipsa then
self.paneltipsa:setText(self.showdata.paneltipsa)
end
if self.showdata.paneltipsb then
self.paneltipsb:setText(self.showdata.paneltipsb)
end
if self.showdata.paneltipsc then
self.paneltipsc:setText(self.showdata.paneltipsc)
end
if self.showdata.sliderRootposY then
self.winlua:SetChildLocalPosY(self.sliderRoot:getID(),self.showdata.sliderRootposY)
end
end

function UIDialougeKuFangCount:onSliderChange(value)
self.selectCnt=value
local num=self.selectCnt
if self.showdata.singlenum then
num=mathHelper.formatNumber4(self.showdata.singlenum*num,1)
end
self.selectCntText:setText(num)

local str=self.showdata.refreshcallback(value)

self.newtip3:setText(str)
end


function UIDialougeKuFangCount:onHide()

end





function UIDialougeKuFangCount:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()

if cancelcallback then
cancelcallback()
end
end


function UIDialougeKuFangCount:onOkButton()
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


function UIDialougeKuFangCount:onMaxCnt()
end


function UIDialougeKuFangCount:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIDialougeKuFangCount:onAddBtn()




if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIDialougeKuFangCount:onLongPressBtn(id)
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

function UIDialougeKuFangCount:onCloseBtn()
self:doClose()
end

function UIDialougeKuFangCount:onBGClick()
self:doClose()
end

function UIDialougeKuFangCount:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeKuFangCount:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeKuFangCount:doCancel()
self.showdata:deleteSelf()
self:close()
end

function UIDialougeKuFangCount:onTipsRoot()
self.tipsRoot:setActive(false)
end

function UIDialougeKuFangCount:onTipsBtn()
self.tipsRoot:setActive(true)
end
