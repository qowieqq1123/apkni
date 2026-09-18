







def_class("UIBottomMaskHJWin",UIWindowBase)









function UIBottomMaskHJWin:bindComponents()

self.root=UIObject.get(self,0)



end


function UIBottomMaskHJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
end



















function UIBottomMaskHJWin:onLoaded(...)
self:bindComponents()
end


function UIBottomMaskHJWin:__delete()
self:unbindComponents()
end




function UIBottomMaskHJWin:onShow(argtable,afterOnloaded)

end


function UIBottomMaskHJWin:onHide()

end



