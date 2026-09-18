







def_class("UIBackgroundComponentSmall2",UIWindowBase)









function UIBackgroundComponentSmall2:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeButton:setButtonClick(function()self:onCloseButton()end)



end


function UIBackgroundComponentSmall2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIBackgroundComponentSmall2:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponentSmall2:__delete()
self:unbindComponents()
end




function UIBackgroundComponentSmall2:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIBackgroundComponentSmall2:onHide()

end



function UIBackgroundComponentSmall2:onCloseButton()
local cb=self.closeCB
if cb then
cb()
end
end

function UIBackgroundComponentSmall2:setTitle(title)
self.title:setText(title or self.titleName)
end