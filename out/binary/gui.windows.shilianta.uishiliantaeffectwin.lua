







def_class("UIShiLianTaEffectWin",UIWindowBase)









function UIShiLianTaEffectWin:bindComponents()

self.smoke=UIObject.get(self,0)



end


function UIShiLianTaEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.smoke);self.smoke=nil;
end



















function UIShiLianTaEffectWin:onLoaded(...)
self:bindComponents()
end


function UIShiLianTaEffectWin:__delete()
self:unbindComponents()
end




function UIShiLianTaEffectWin:onShow(argtable,afterOnloaded)

end


function UIShiLianTaEffectWin:onHide()

end

function UIShiLianTaEffectWin:playEffect(id,pos)
self.smoke:setChildShowEffect(id,true)
if pos then
self.smoke:setChildUIScreenPos(pos)
end
end



