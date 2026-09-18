







def_class("UIDialougeBMFaBaoGuiYuan",UIWindowBase)









function UIDialougeBMFaBaoGuiYuan:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.okTipsIcon=UIObject.get(self,1)
self.cancelText=UIText.get(self,2)
self.okText=UIText.get(self,3)
self.okTipsText=UIText.get(self,4)
self.cancelButton=UIButton.get(self,5)
self.okButton=UIButton.get(self,6)
self.titleText=UIText.get(self,7)
self.dialougeText=UIText.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBMFaBaoGuiYuan:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.okTipsIcon);self.okTipsIcon=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.okTipsText);self.okTipsText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
end



















function UIDialougeBMFaBaoGuiYuan:onLoaded(...)
self:bindComponents()
end


function UIDialougeBMFaBaoGuiYuan:__delete()
self:unbindComponents()
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIDialougeBMFaBaoGuiYuan:onShow(argtable,afterOnloaded)
self.showdata=argtable

self.titleText:setText(self.showdata.title)
self.dialougeText:setText(self.showdata.content)
self.okText:setText(self.showdata.oktext)
self.okTipsText:setText(self.showdata.okTipsText or"")
self.okTipsIcon:setIcon(self.showdata.okTipsIcon,false)

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


function UIDialougeBMFaBaoGuiYuan:onHide()

end





function UIDialougeBMFaBaoGuiYuan:onCloseBtn()
self:doClose()
end



function UIDialougeBMFaBaoGuiYuan:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()

if cancelcallback then
cancelcallback()
end
end



function UIDialougeBMFaBaoGuiYuan:onOkButton()
local okcallback=self.showdata.okcallback

self.showdata:deleteSelf()
self:close()

if okcallback then
okcallback()
end
end

function UIDialougeBMFaBaoGuiYuan:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()
self:close()
if closecallback then
closecallback()
end
end

function UIDialougeBMFaBaoGuiYuan:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

