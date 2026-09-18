







def_class("UI_MiniGame_BackWin",UIWindowBase)









function UI_MiniGame_BackWin:bindComponents()

self.backButton=UIButton.get(self,0)

self.backButton:setButtonClick(function()self:onBackButton()end)



end


function UI_MiniGame_BackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
end



















function UI_MiniGame_BackWin:onLoaded(...)
self:bindComponents()
end


function UI_MiniGame_BackWin:__delete()
self:unbindComponents()
end




function UI_MiniGame_BackWin:onShow(argtable,afterOnloaded)

end


function UI_MiniGame_BackWin:onHide()

end





function UI_MiniGame_BackWin:onBackButton()
self:closeSelf()
mainControl:enterHome()
end

