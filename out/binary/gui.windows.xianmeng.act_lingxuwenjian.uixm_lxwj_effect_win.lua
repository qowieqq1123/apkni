







def_class("UIXM_LXWJ_Effect_win",UIWindowBase)









function UIXM_LXWJ_Effect_win:bindComponents()

self.frameEffect=UIObject.get(self,0)



end


function UIXM_LXWJ_Effect_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameEffect);self.frameEffect=nil;
end

















function UIXM_LXWJ_Effect_win:onLoaded(...)
self:bindComponents()
end


function UIXM_LXWJ_Effect_win:__delete()
self:unbindComponents()
end


function UIXM_LXWJ_Effect_win:onHide()

end




function UIXM_LXWJ_Effect_win:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.frameEffect:setChildShowEffect(10358,true)
end
end
