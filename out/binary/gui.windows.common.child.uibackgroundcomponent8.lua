







def_class("UIBackgroundComponent8",UIWindowBase)









function UIBackgroundComponent8:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeButton:setButtonClick(function()self:onCloseButton()end)



end


function UIBackgroundComponent8:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIBackgroundComponent8:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponent8:__delete()
self:unbindComponents()
end




function UIBackgroundComponent8:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIBackgroundComponent8:onHide()

end





function UIBackgroundComponent8:onCloseButton()
local cb=self.closeCB
if cb then
cb()
end
gubaoModel:setYetGubaoIndex(0)
end

function UIBackgroundComponent8:setTitle(title)
self.title:setText(title or self.titleName)
end