







def_class("UICommonEffectWin",UIWindowBase)









function UICommonEffectWin:bindComponents()

self.effect=UIObject.get(self,0)



end


function UICommonEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
end



















function UICommonEffectWin:onLoaded(...)
self:bindComponents()
end


function UICommonEffectWin:__delete()
self:unbindComponents()
end




function UICommonEffectWin:onShow(argtable,afterOnloaded)
local effectId=argtable.effect
local effectCfg=cfgHelper.get1(cfg_effectconfig_get,effectId)
local duration=effectCfg.lifetime/1000
self.effect:setChildShowEffect(effectId,true)
self:delayDo(duration,function()
self:closeSelf()
end)
end


function UICommonEffectWin:onHide()

end



