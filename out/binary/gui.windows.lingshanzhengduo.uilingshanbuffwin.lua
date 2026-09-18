







def_class("UILingShanBuffWin",UIWindowBase)









function UILingShanBuffWin:bindComponents()

self.buffDesc=UIText.get(self,0)
self.buffIcon=UIObject.get(self,1)
self.buffName=UIText.get(self,2)
self.root=UIObject.get(self,3)
self.teamCount1=UIText.get(self,4)
self.teamCount2=UIText.get(self,5)



end


function UILingShanBuffWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buffDesc);self.buffDesc=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.teamCount1);self.teamCount1=nil;
_UIObject_release(self.teamCount2);self.teamCount2=nil;
end



















function UILingShanBuffWin:onLoaded(...)
self:bindComponents()
end


function UILingShanBuffWin:__delete()
self:unbindComponents()
end




function UILingShanBuffWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UILingShanBuffWin:onHide()

end

function UILingShanBuffWin:refresh()
local buffType=1
local cfg=cfgHelper.get1(cfg_lingshanbuffconfig_get,buffType)
self.buffIcon:setChildIcon(cfg.icon,true)
self.buffName:setText(cfg.name)
local args=self:countBuffArgs(buffType)
local desc=FMT.fmt(cfg.desc,unpack(args))
self.buffDesc:setText(desc)
self.teamCount1:setText(UILSZDControl:getTeamNumByMountType(2,true))
self.teamCount2:setText(UILSZDControl:getTeamNumByMountType(1,true))
end

function UILingShanBuffWin:countBuffArgs(buffType)
local args=UILSZDControl:countBuffArgs(buffType)
return args
end




function UILingShanBuffWin:onCloseClick()
self:closeSelf()
end