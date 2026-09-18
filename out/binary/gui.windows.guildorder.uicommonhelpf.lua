







def_class("UICommonHelpF",UIWindowBase)









function UICommonHelpF:bindComponents()

self.root=UIObject.get(self,0)
self.content=UIText.get(self,1)



end


function UICommonHelpF:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.content);self.content=nil;
end



















function UICommonHelpF:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(1,0,1))
end


function UICommonHelpF:__delete()
self:unbindComponents()

if self.closeCB then
self.closeCB()
end
end




function UICommonHelpF:onShow(argtable,afterOnloaded)
self.content:setText(argtable.content)
self.closeCB=argtable.closeCB
if argtable.posx and argtable.posy then
self.winlua:SetChildLocalPosX(self.root:getID(),argtable.posx)
self.winlua:SetChildLocalPosY(self.root:getID(),argtable.posy)
end
self.root:setChildDOScaleY(1,0.35,nil)
end


function UICommonHelpF:onHide()

end




function UICommonHelpF:onCloseClick()
self:closeSelf()
end