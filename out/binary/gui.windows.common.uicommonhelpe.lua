







def_class("UICommonHelpE",UIWindowBase)









function UICommonHelpE:bindComponents()

self.root=UIObject.get(self,0)
self.content=UIText.get(self,1)



end


function UICommonHelpE:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.content);self.content=nil;
end



















function UICommonHelpE:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(1,0,1))
end


function UICommonHelpE:__delete()
self:unbindComponents()

if self.closeCB then
self.closeCB()
end
end




function UICommonHelpE:onShow(argtable,afterOnloaded)
self.content:setText(argtable.content)
self.closeCB=argtable.closeCB
if argtable.posx and argtable.posy then
self.winlua:SetChildLocalPosX(self.root:getID(),argtable.posx)
self.winlua:SetChildLocalPosY(self.root:getID(),argtable.posy)
end
self.root:setChildDOScaleY(1,0.35,nil)
end


function UICommonHelpE:onHide()

end




function UICommonHelpE:onCloseClick()
self:closeSelf()
end