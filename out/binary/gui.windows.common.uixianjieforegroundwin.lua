







def_class("UIXianJieForeGroundWin",UIWindowBase)









function UIXianJieForeGroundWin:bindComponents()

self.foureground=UIObject.get(self,0)



end


function UIXianJieForeGroundWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.foureground);self.foureground=nil;
end



















function UIXianJieForeGroundWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieForeGroundWin:__delete()
self:unbindComponents()
end




function UIXianJieForeGroundWin:onShow(argtable,afterOnloaded)

end


function UIXianJieForeGroundWin:onHide()

end



