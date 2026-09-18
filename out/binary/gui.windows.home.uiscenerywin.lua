







def_class("UISceneryWin",UIWindowBase)









function UISceneryWin:bindComponents()

self.title=UIText.get(self,0)
self.icon=UIObject.get(self,1)
self.destext=UIText.get(self,2)



end


function UISceneryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.destext);self.destext=nil;
end



















function UISceneryWin:onLoaded(...)
self:bindComponents()
end


function UISceneryWin:__delete()
self:unbindComponents()
end




function UISceneryWin:onShow(argtable,afterOnloaded)
local id=argtable
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
self.destext:setText(levelCfg.build_desc)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local scale=isometricMapSystem:getModelScale(cfg.model[1],true)
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,nil,eAnimationID.bd_stand)
end


function UISceneryWin:onHide()

end




function UISceneryWin:onCloseClick()
self:closeSelf()
end