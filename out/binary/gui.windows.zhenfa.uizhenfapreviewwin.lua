







def_class("UIZhenFaPreviewWin",UIWindowBase)









function UIZhenFaPreviewWin:bindComponents()

self.background=UIButton.get(self,0)
self.image=UIObject.get(self,1)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIZhenFaPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.image);self.image=nil;
end



















function UIZhenFaPreviewWin:onLoaded(...)
self:bindComponents()
end


function UIZhenFaPreviewWin:__delete()
self:unbindComponents()
end




function UIZhenFaPreviewWin:onShow(argtable,afterOnloaded)
self.zfId=argtable.zfId

end


function UIZhenFaPreviewWin:onHide()

end





function UIZhenFaPreviewWin:onBackground()
self:closeSelf()
end

