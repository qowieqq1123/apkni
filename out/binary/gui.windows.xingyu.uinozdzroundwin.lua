







def_class("UINoZDZRoundWin",UIWindowBase)









function UINoZDZRoundWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UINoZDZRoundWin")end)



end


function UINoZDZRoundWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UINoZDZRoundWin:onLoaded(...)
self:bindComponents()
end


function UINoZDZRoundWin:__delete()
self:unbindComponents()
end




function UINoZDZRoundWin:onShow(argtable,afterOnloaded)

end


function UINoZDZRoundWin:onHide()

end





function UINoZDZRoundWin:onCloseButton()
self:closeSelf()
end

