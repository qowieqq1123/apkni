







def_class("UIBackgroundComponentSmall",UIWindowBase)









function UIBackgroundComponentSmall:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeButton:setButtonClick(function()self:onCloseButton()end)



end


function UIBackgroundComponentSmall:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIBackgroundComponentSmall:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponentSmall:__delete()
self:unbindComponents()
end




function UIBackgroundComponentSmall:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIBackgroundComponentSmall:onHide()

end





function UIBackgroundComponentSmall:onCloseButton()
local cb=self.closeCB
if cb then
cb()
end
end

function UIBackgroundComponentSmall:setTitle(title)
self.title:setText(title or self.titleName)
end