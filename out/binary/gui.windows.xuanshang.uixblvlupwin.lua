







def_class("UIXBLvlUpWin",UIWindowBase)









function UIXBLvlUpWin:bindComponents()

self.level1=UIText.get(self,0)
self.level2=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.desc2=UIText.get(self,3)



end


function UIXBLvlUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level1);self.level1=nil;
_UIObject_release(self.level2);self.level2=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.desc2);self.desc2=nil;
end



















function UIXBLvlUpWin:onLoaded(...)
self:bindComponents()
end


function UIXBLvlUpWin:__delete()
self:unbindComponents()
end




function UIXBLvlUpWin:onShow(argtable,afterOnloaded)
local lastLevel=argtable.lastLevel
local currLevel=argtable.currLevel
self.level1:setText(FMT.fmt('仙榜等级：{0}级',lastLevel))
self.level2:setText(FMT.fmt('{0}级',currLevel))

self.desc:setText("提高紫、橙、红品质任务的出现概率")

local oldcfglvl=cfg_xianbanglevelconfig_get(lastLevel)
local newcfglvl=cfg_xianbanglevelconfig_get(currLevel)
self.desc:setText(oldcfglvl.updesc2 or"")












end


function UIXBLvlUpWin:onHide()

end




function UIXBLvlUpWin:onCloseClick()
self:closeSelf()
end