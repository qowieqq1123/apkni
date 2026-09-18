







def_class("UIBackgroundComponent_XJFM",UIWindowBase)









function UIBackgroundComponent_XJFM:bindComponents()

self.closeButtonEx=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeButtonEx:setButtonClick(function()self:onCloseButtonEx()end)



end


function UIBackgroundComponent_XJFM:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButtonEx);self.closeButtonEx=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIBackgroundComponent_XJFM:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponent_XJFM:__delete()
self:unbindComponents()
end




function UIBackgroundComponent_XJFM:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIBackgroundComponent_XJFM:onHide()

end





function UIBackgroundComponent_XJFM:onCloseButtonEx()
local cb=self.closeCB
if cb then
cb()
end
gubaoModel:setYetGubaoIndex(0)
end

function UIBackgroundComponent_XJFM:setTitle(title)
self.title:setText(title or self.titleName)
end