







def_class("UICommonHelpB",UIWindowBase)









function UICommonHelpB:bindComponents()

self.root=UIObject.get(self,0)
self.content=UIText.get(self,1)



end


function UICommonHelpB:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.content);self.content=nil;
end



















function UICommonHelpB:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(1,0,1))
end


function UICommonHelpB:__delete()
self:unbindComponents()

if self.closeCB then
self.closeCB()
end
end




function UICommonHelpB:onShow(argtable,afterOnloaded)
self.content:setText(argtable.content)
self.closeCB=argtable.closeCB
self.root:setChildDOScaleY(1,0.35,nil)
end


function UICommonHelpB:onHide()

end




function UICommonHelpB:onCloseClick()
self:closeSelf()
end