







def_class("UIAirMiniGameHUDWin",UIWindowBase)









function UIAirMiniGameHUDWin:bindComponents()

self.hud=UIGameobjectClone.new(self,0)



end


function UIAirMiniGameHUDWin:unbindComponents()
local _UIObject_release=UIObject.release
self.hud:deleteSelf();self.hud=nil;
end


















function UIAirMiniGameHUDWin:onLoaded(...)
self:bindComponents()
airHUDSystem:onInitHUDRoot(self.winlua,self.hud,self.hud:getID())
end

function UIAirMiniGameHUDWin:__delete()
airHUDSystem:onDeleteHUDRoot()
self:unbindComponents()
end

function UIAirMiniGameHUDWin:onShow(argtable,afterOnloaded)

end

function UIAirMiniGameHUDWin:onHide()

end



