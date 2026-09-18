







def_class("UIChatPrivateMainItem",UICloneObject)





UIChatPrivateMainItem.abName="ui/windows/chat/child/uichatprivatemainitem.ab"

UIChatPrivateMainItem.assetName="UIChatPrivateMainItem"


function UIChatPrivateMainItem:bindComponents()

self.name=UIText.get(self,0)
self.select=UIObject.get(self,1)
self.reddot=UIObject.get(self,2)
self.arrowAni=UIObject.get(self,3)

end


function UIChatPrivateMainItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.arrowAni);self.arrowAni=nil;
end








function UIChatPrivateMainItem:onLoaded(...)
self:bindComponents()
end

function UIChatPrivateMainItem:__delete()
self:unbindComponents()
end

function UIChatPrivateMainItem:onShow(argtable,afterOnloaded)

end

function UIChatPrivateMainItem:onHide()

end


