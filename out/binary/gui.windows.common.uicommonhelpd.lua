







def_class("UICommonHelpD",UIWindowBase)









function UICommonHelpD:bindComponents()

self.root=UIObject.get(self,0)
self.content=UIText.get(self,1)



end


function UICommonHelpD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.content);self.content=nil;
end



















function UICommonHelpD:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(1,0,1))
end


function UICommonHelpD:__delete()
self:unbindComponents()

if self.closeCB then
self.closeCB()
end
end




function UICommonHelpD:onShow(argtable,afterOnloaded)
self.content:setText(argtable.content)
self.closeCB=argtable.closeCB
self.root:setChildDOScaleY(1,0.35,nil)
end


function UICommonHelpD:onHide()

end




function UICommonHelpD:onCloseClick()
self:closeSelf()
end