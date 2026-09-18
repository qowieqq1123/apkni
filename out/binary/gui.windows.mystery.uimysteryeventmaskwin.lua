







def_class("UIMysteryEventMaskWin",UIWindowBase)









function UIMysteryEventMaskWin:bindComponents()

self.ClickClose=UIButton.get(self,0)

self.ClickClose:setButtonClick(function()self:onClickClose()end)



end


function UIMysteryEventMaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ClickClose);self.ClickClose=nil;
end



















function UIMysteryEventMaskWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryEventMaskWin:__delete()
self:unbindComponents()
end




function UIMysteryEventMaskWin:onShow(argtable,afterOnloaded)
if argtable then
self.closeCallback=argtable.closeCallback
end
end


function UIMysteryEventMaskWin:onHide()

end

function UIMysteryEventMaskWin:onClickClose()
if self.closeCallback then
self.closeCallback()
end
self:closeSelf()
end



