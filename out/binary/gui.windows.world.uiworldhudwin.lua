







def_class("UIWorldHUDWin",UIWindowBase)









function UIWorldHUDWin:bindComponents()

self.HUDRoot=UIObject.get(self,0)
self.HUDPool=UIGameobjectClone.new(self,1)



end


function UIWorldHUDWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.HUDRoot);self.HUDRoot=nil;
self.HUDPool:deleteSelf();self.HUDPool=nil;
end





















function UIWorldHUDWin:onLoaded(...)
self:bindComponents()


end


function UIWorldHUDWin:__delete()
self:unbindComponents()


end




function UIWorldHUDWin:onShow(argtable,afterOnloaded)

worldHUDModel:setHUDVisible(true)
end


function UIWorldHUDWin:onHide()

worldHUDModel:setHUDVisible(false)
end




































