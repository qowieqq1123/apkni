







def_class("UIMoJieMoJunKillWin",UIWindowBase)









function UIMoJieMoJunKillWin:bindComponents()

self.background=UIButton.get(self,0)
self.Desc=UIText.get(self,1)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIMoJieMoJunKillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.Desc);self.Desc=nil;
end



















function UIMoJieMoJunKillWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieMoJunKillWin:__delete()
self:unbindComponents()
end




function UIMoJieMoJunKillWin:onShow(argtable,afterOnloaded)

end


function UIMoJieMoJunKillWin:onHide()

end





function UIMoJieMoJunKillWin:onBackground()
self:onCloseBtn()
end

function UIMoJieMoJunKillWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

