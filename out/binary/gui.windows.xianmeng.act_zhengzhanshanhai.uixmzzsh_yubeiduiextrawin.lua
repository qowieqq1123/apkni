







def_class("UIXMZZSH_YuBeiDuiExtraWin",UIWindowBase)









function UIXMZZSH_YuBeiDuiExtraWin:bindComponents()

self.Image=UIObject.get(self,0)



end


function UIXMZZSH_YuBeiDuiExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Image);self.Image=nil;
end



















function UIXMZZSH_YuBeiDuiExtraWin:onLoaded(...)
self:bindComponents()
end


function UIXMZZSH_YuBeiDuiExtraWin:__delete()
self:unbindComponents()
end




function UIXMZZSH_YuBeiDuiExtraWin:onShow(argtable,afterOnloaded)

end


function UIXMZZSH_YuBeiDuiExtraWin:onHide()

end

