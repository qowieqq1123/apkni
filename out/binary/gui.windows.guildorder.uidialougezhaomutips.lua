







def_class("UIDialougeZhaoMutips",UIWindowBase)









function UIDialougeZhaoMutips:bindComponents()

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

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeZhaoMutips:unbindComponents()
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
end

















local _this


function UIDialougeZhaoMutips:onLoaded(...)
self:bindComponents()
_this=self
self.fightSaveMode:setToggleChange(function(name,isOn)
self:onToggleChangetips(1,isOn)
end)
end


function UIDialougeZhaoMutips:__delete()
self:unbindComponents()
end




function UIDialougeZhaoMutips:onShow(argtable,afterOnloaded)

self.okText:setText('确认')
self.cancelText:setText('取消')
self.allow=false
self.fightSaveMode:setToggle(self.allow)
if argtable then
self.titleText:setText(argtable.title)

















local contentStr=FMT.fmt('取消选项后将自动拒绝<color=#efb150>绝伦</color>弟子，确认拒招吗？')
self.linkImageText1:setText(contentStr)



self.okcallback=argtable.okcallback


end
end



function UIDialougeZhaoMutips:onHide()

end





function UIDialougeZhaoMutips:onCloseBtn()


self:closeSelf()
end



function UIDialougeZhaoMutips:onMaxCnt()
end



function UIDialougeZhaoMutips:onSubBtn()
end



function UIDialougeZhaoMutips:onAddBtn()
end



function UIDialougeZhaoMutips:onCancelButton()

UIManager:closeWindow('UIDialougeZhaoMutips')
end



function UIDialougeZhaoMutips:onOkButton()











local okcallback=_this.okcallback
self:closeSelf()
if okcallback then
okcallback()
end

end



function UIDialougeZhaoMutips:onTipsRoot()
end



function UIDialougeZhaoMutips:onTipsBtn()
end


function UIDialougeZhaoMutips:onToggleChangetips(name,isOn)

_this.allow=isOn==true
end

