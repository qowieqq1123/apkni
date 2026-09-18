







def_class("UIMoJie_mojun_resultWin",UIWindowBase)









function UIMoJie_mojun_resultWin:bindComponents()

self.desc=UIText.get(self,0)



end


function UIMoJie_mojun_resultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end



















function UIMoJie_mojun_resultWin:onLoaded(...)
self:bindComponents()
end


function UIMoJie_mojun_resultWin:__delete()
self:unbindComponents()
end




function UIMoJie_mojun_resultWin:onShow(argtable,afterOnloaded)

end


function UIMoJie_mojun_resultWin:onHide()

end



