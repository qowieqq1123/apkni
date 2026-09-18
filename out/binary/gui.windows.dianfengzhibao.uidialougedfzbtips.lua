







def_class("UIDialougeDFZBtips",UIWindowBase)









function UIDialougeDFZBtips:bindComponents()

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
self.tips1=UIText.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeDFZBtips:unbindComponents()
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
_UIObject_release(self.tips1);self.tips1=nil;
end
















local _this



function UIDialougeDFZBtips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDialougeDFZBtips:__delete()
self:unbindComponents()
_this=nil
end




function UIDialougeDFZBtips:onShow(argtable,afterOnloaded)
if argtable then
self.titleText:setText(argtable.title or"")
self.linkImageText1:setText(argtable.Str or"")
self.tips1:setText(argtable.tips1 or"")
self.okcallback=argtable.okcallback
self.oktext=argtable.oktext
self.canceltext=argtable.canceltext
end
self.okText:setText(self.oktext or"")
self.cancelText:setText(self.canceltext or"")
end


function UIDialougeDFZBtips:onHide()

end





function UIDialougeDFZBtips:onCloseBtn()
self:closeSelf()
end



function UIDialougeDFZBtips:onMaxCnt()
end



function UIDialougeDFZBtips:onSubBtn()
end



function UIDialougeDFZBtips:onAddBtn()
end



function UIDialougeDFZBtips:onCancelButton()
self:closeSelf()
end



function UIDialougeDFZBtips:onOkButton()
local okcallback=_this.okcallback
self:closeSelf()
if okcallback then
okcallback()
end
end



function UIDialougeDFZBtips:onTipsRoot()
end



function UIDialougeDFZBtips:onTipsBtn()
end

