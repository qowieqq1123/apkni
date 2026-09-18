







def_class("UIBackgroundComponent",UIWindowBase)









function UIBackgroundComponent:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeButton:setButtonClick(function()self:onCloseButton()end)



end


function UIBackgroundComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIBackgroundComponent:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponent:__delete()
self:unbindComponents()
end




function UIBackgroundComponent:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIBackgroundComponent:onHide()

end





function UIBackgroundComponent:onCloseButton()
local cb=self.closeCB
if cb then
cb()
end
gubaoModel:setYetGubaoIndex(0)
end

function UIBackgroundComponent:setTitle(title)
self.title:setText(title or self.titleName)
end