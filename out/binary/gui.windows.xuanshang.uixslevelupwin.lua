







def_class("UIXSLevelUpWin",UIWindowBase)









function UIXSLevelUpWin:bindComponents()

self.level1=UIText.get(self,0)
self.level2=UIText.get(self,1)
self.desc=UIText.get(self,2)



end


function UIXSLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level1);self.level1=nil;
_UIObject_release(self.level2);self.level2=nil;
_UIObject_release(self.desc);self.desc=nil;
end



















function UIXSLevelUpWin:onLoaded(...)
self:bindComponents()
end


function UIXSLevelUpWin:__delete()
self:unbindComponents()
end




function UIXSLevelUpWin:onShow(argtable,afterOnloaded)
local lastLevel=argtable.lastLevel
local currLevel=argtable.currLevel
self.level1:setText(FMT.fmt('悬赏等级：{0}级',lastLevel))
self.level2:setText(FMT.fmt('{0}级',currLevel))

local cfg=cfgHelper.get1(cfg_zongmenxuanshangtasklevelconfig_get,currLevel)
self.desc:setText(cfg.levelUpDesc)
end


function UIXSLevelUpWin:onHide()

end




function UIXSLevelUpWin:onCloseClick()
self:closeSelf()
end