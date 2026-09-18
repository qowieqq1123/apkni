







def_class("UIXFWDBottomWin",UIWindowBase)









function UIXFWDBottomWin:bindComponents()

self.bg=UIObject.get(self,0)



end


function UIXFWDBottomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
end



















function UIXFWDBottomWin:onLoaded(...)
self:bindComponents()

self.bg:setChildUIModelShowTarget(4093,1,nil,eAnimationID.stand)
self.bg:setChildModelAnimationState(eAnimationID.stand,0.3)
end


function UIXFWDBottomWin:__delete()
self:unbindComponents()
end




function UIXFWDBottomWin:onShow(argtable,afterOnloaded)
self.bg:setActive(true)
end


function UIXFWDBottomWin:onHide()
self.bg:setActive(false)
end



