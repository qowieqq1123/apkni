







def_class("UIDialougeYJDZtips",UIWindowBase)









function UIDialougeYJDZtips:bindComponents()

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
self.fightSaveMode=UIToggleButton.get(self,19)
self.Imagegou=UIObject.get(self,20)
self.ysdztxt=UIText.get(self,21)
self.ysdztxt2=UIText.get(self,22)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeYJDZtips:unbindComponents()
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
_UIObject_release(self.fightSaveMode);self.fightSaveMode=nil;
_UIObject_release(self.Imagegou);self.Imagegou=nil;
_UIObject_release(self.ysdztxt);self.ysdztxt=nil;
_UIObject_release(self.ysdztxt2);self.ysdztxt2=nil;
end
















local _this



function UIDialougeYJDZtips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDialougeYJDZtips:__delete()
self:unbindComponents()
self:stopLeftTimer()
_this=nil
end




function UIDialougeYJDZtips:onShow(argtable,afterOnloaded)
if argtable then
self.titleText:setText(argtable.title or"")
self.ysdztxt:setText(argtable.ysdztxt or"")
self.ysdzdjsTime=argtable.ysdzdjsTime
self.okcallback=argtable.okcallback
self.oktext=argtable.oktext
self.canceltext=argtable.canceltext
end
self.okText:setText(self.oktext or"")
self.cancelText:setText(self.canceltext or"")

if self.ysdzdjsTime then
self:stopLeftTimer()
local func=function()
if self==nil then return end
local nowTime=timeHelper.getServerLongTime()
local nTime=self.ysdzdjsTime-nowTime
if nTime<=0 then
self:stopLeftTimer()
UIManager.info('可再次易容')
self:closeSelf()
else
self.ysdztxt2:setText(FMT.fmt("适应时间：<color=#c82c2c>{0}</color>",timeHelper.format_time_stamp3(nTime)))
end
end
self.ticktimer=self:setTimer(1,0,func)
func()
end
end
function UIDialougeYJDZtips:stopLeftTimer(widgetId)
if self.ticktimer then
self:stopTimerByID(self.ticktimer)
self.ticktimer=nil
end
end

function UIDialougeYJDZtips:onHide()
self:stopLeftTimer()
end





function UIDialougeYJDZtips:onCloseBtn()
self:closeSelf()
end



function UIDialougeYJDZtips:onMaxCnt()
end



function UIDialougeYJDZtips:onSubBtn()
end



function UIDialougeYJDZtips:onAddBtn()
end



function UIDialougeYJDZtips:onCancelButton()
self:closeSelf()
end



function UIDialougeYJDZtips:onOkButton()
local okcallback=_this.okcallback
self:closeSelf()
if okcallback then
okcallback()
end
end



function UIDialougeYJDZtips:onTipsRoot()
end



function UIDialougeYJDZtips:onTipsBtn()
end


function UIDialougeYJDZtips:onToggleChangetips(name,isOn)

_this.allow=isOn==true
_this.Imagegou:setActive(_this.allow)
end

