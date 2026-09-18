







def_class("UIEmergenciesWraning",UIWindowBase)









function UIEmergenciesWraning:bindComponents()

self.wraning=UIText.get(self,0)



end


function UIEmergenciesWraning:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.wraning);self.wraning=nil;
end



















function UIEmergenciesWraning:onLoaded(...)
self:bindComponents()
end


function UIEmergenciesWraning:__delete()
self:unbindComponents()
end




function UIEmergenciesWraning:onShow(argtable,afterOnloaded)
local eventId=argtable
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
self.wraning:setText(cfg.wraning)
end


function UIEmergenciesWraning:onHide()

end




function UIEmergenciesWraning:onCloseClick()
self:closeSelf()
end