







def_class("UIDialougeLevelUp",UIWindowBase)









function UIDialougeLevelUp:bindComponents()

self.afterTx=UIText.get(self,0)
self.beforeTx=UIText.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.cancelText=UIText.get(self,3)
self.chooseBox=UIToggleButton.get(self,4)
self.chooseText=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.linkImageText=UILinkImageText.get(self,7)
self.okButton=UIButton.get(self,8)
self.okText=UIText.get(self,9)
self.titleText=UIText.get(self,10)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeLevelUp:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.afterTx);self.afterTx=nil;
_UIObject_release(self.beforeTx);self.beforeTx=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIDialougeLevelUp:onLoaded(...)
self:bindComponents()
end


function UIDialougeLevelUp:__delete()
self:unbindComponents()
end




function UIDialougeLevelUp:onShow(showdata,afterOnloaded)
self.showdata=showdata

self.titleText:setText(showdata.title)
self.linkImageText:setText(showdata.content)
self.beforeTx:setText(showdata.beforeTx)
self.afterTx:setText(showdata.afterTx)

self.okText:setText(showdata.oktext)
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

if showdata.choosetext~=nil and showdata.choosecallback~=nil then
self.chooseBox:setActive(true)
self.chooseText:setText(showdata.choosetext)
else
self.chooseBox:setActive(false)
end
end


function UIDialougeLevelUp:onHide()

end




function UIDialougeLevelUp:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end
self.showdata:deleteSelf()

self:close()
if cancelcallback then
cancelcallback()
end
end


function UIDialougeLevelUp:onCloseBtn()
self:doClose()
end


function UIDialougeLevelUp:onOkButton()
local okcallback=self.showdata.okcallback

local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end
self.showdata:deleteSelf()

self:close()
if okcallback then
okcallback()
end
end

function UIDialougeLevelUp:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIDialougeLevelUp:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeLevelUp:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeLevelUp:doCancel()
self.showdata:deleteSelf()
self:close()
end

function UIDialougeLevelUp:onChangeChoose()

AudioManager.playBtnClick()
end