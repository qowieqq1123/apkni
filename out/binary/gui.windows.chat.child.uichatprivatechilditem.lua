







def_class("UIChatPrivateChildItem",UICloneObject)





UIChatPrivateChildItem.abName="ui/windows/chat/child/uichatprivatechilditem.ab"

UIChatPrivateChildItem.assetName="UIChatPrivateChildItem"


function UIChatPrivateChildItem:bindComponents()

self.showRoot=UIObject.get(self,0)
self.opRoot=UIObject.get(self,1)
self.icon=UIButton.get(self,2)
self.name=UIText.get(self,3)
self.online=UIText.get(self,4)
self.reddot=UIObject.get(self,5)
self.btnOpenArrow=UIButton.get(self,6)
self.name1=UIText.get(self,7)
self.online1=UIText.get(self,8)
self.btnCloseArrow=UIButton.get(self,9)
self.btnTop=UIButton.get(self,10)
self.btnDelete=UIButton.get(self,11)

self.icon:setButtonClick(function()self:onIcon()end)

self.btnOpenArrow:setButtonClick(function()self:onBtnOpenArrow()end)

self.btnCloseArrow:setButtonClick(function()self:onBtnCloseArrow()end)

self.btnTop:setButtonClick(function()self:onBtnTop()end)

self.btnDelete:setButtonClick(function()self:onBtnDelete()end)

end


function UIChatPrivateChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.showRoot);self.showRoot=nil;
_UIObject_release(self.opRoot);self.opRoot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.online);self.online=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.btnOpenArrow);self.btnOpenArrow=nil;
_UIObject_release(self.name1);self.name1=nil;
_UIObject_release(self.online1);self.online1=nil;
_UIObject_release(self.btnCloseArrow);self.btnCloseArrow=nil;
_UIObject_release(self.btnTop);self.btnTop=nil;
_UIObject_release(self.btnDelete);self.btnDelete=nil;
end








function UIChatPrivateChildItem:onLoaded(...)
self:bindComponents()
end

function UIChatPrivateChildItem:__delete()
self:unbindComponents()
end

function UIChatPrivateChildItem:onShow(argtable,afterOnloaded)

end

function UIChatPrivateChildItem:onHide()

end


