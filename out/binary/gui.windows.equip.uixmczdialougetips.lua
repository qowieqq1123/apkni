







def_class("UIXMCZDialougeTips",UIWindowBase)









function UIXMCZDialougeTips:bindComponents()

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
self.tipss=UIText.get(self,20)
self.jumpbtn=UIButton.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.jumpbtn:setButtonClick(function()self:onJumpbtn()end)



end


function UIXMCZDialougeTips:unbindComponents()
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
_UIObject_release(self.tipss);self.tipss=nil;
_UIObject_release(self.jumpbtn);self.jumpbtn=nil;
end
















local _this



function UIXMCZDialougeTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXMCZDialougeTips:__delete()
self:unbindComponents()
_this=nil
end




function UIXMCZDialougeTips:onShow(argtable,afterOnloaded)
self.okText:setText('确认')
self.cancelText:setText('取消')
if argtable then
self.titleText:setText(argtable.title)
self.tipsText=argtable.tipsText or""
self.tipss:setText(self.tipsText)
self.cellcallback=argtable.cellcallback
self.cellcallback2=argtable.cellcallback2
self.cellcallback3=argtable.cellcallback3
self.setclosetop=argtable.setclosetop
self.closetopbtn=argtable.closetopbtn


self._okText=argtable._okText
self._cancelText=argtable._cancelText
if self._okText then
self.okText:setText(self._okText)
end
if self._cancelText then
self.cancelText:setText(self._cancelText)
end

end
if self.closetopbtn then
self.closeBtn:setActive(false)
end
end


function UIXMCZDialougeTips:onHide()

end





function UIXMCZDialougeTips:onCloseBtn()
local cb=self.cellcallback2
local isclose=self.setclosetop
self:closeSelf()
if cb and isclose then
cb()
end
end



function UIXMCZDialougeTips:onMaxCnt()
end



function UIXMCZDialougeTips:onSubBtn()
end



function UIXMCZDialougeTips:onAddBtn()
end



function UIXMCZDialougeTips:onCancelButton()
local cb=self.cellcallback2
self:closeSelf()
if cb then
cb()
end
end



function UIXMCZDialougeTips:onOkButton()
local cb=self.cellcallback
self:closeSelf()
if cb then
cb()
end
end



function UIXMCZDialougeTips:onTipsRoot()
end



function UIXMCZDialougeTips:onTipsBtn()
end

function UIXMCZDialougeTips:onJumpbtn()
local cb=self.cellcallback3
self:closeSelf()
if cb then
cb()
end
end
