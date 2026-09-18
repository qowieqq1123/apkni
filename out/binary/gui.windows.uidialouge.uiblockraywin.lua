







def_class("UIBlockRayWin",UIWindowBase)









function UIBlockRayWin:bindComponents()

self.Image=UIObject.get(self,0)



end


function UIBlockRayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Image);self.Image=nil;
end



















function UIBlockRayWin:onLoaded(...)
self:bindComponents()
end


function UIBlockRayWin:__delete()
self:unbindComponents()
end




function UIBlockRayWin:onShow(argtable,afterOnloaded)

end


function UIBlockRayWin:onHide()

end



