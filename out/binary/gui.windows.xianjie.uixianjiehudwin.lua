







def_class("UIXianJieHudWin",UIWindowBase)









function UIXianJieHudWin:bindComponents()

self.hudRoot=UIObject.get(self,0)
self.hudRoot2=UIObject.get(self,1)



end


function UIXianJieHudWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hudRoot);self.hudRoot=nil;
_UIObject_release(self.hudRoot2);self.hudRoot2=nil;
end

















function UIXianJieHudWin:onLoaded(...)
self:bindComponents()
self:setAsFirstSibling(-1)
local hudWidgetRoot=self.hudRoot:getWidgetBase()
local hudWidgetRoot2=self.hudRoot2:getWidgetBase()
xianjieController:setHUDParent({hudWidgetRoot,hudWidgetRoot2})
end


function UIXianJieHudWin:__delete()
self:unbindComponents()
xianjieController:setHUDParent(nil)
clear_xjEntityHudWidgetPool()
end


function UIXianJieHudWin:onHide()

end




function UIXianJieHudWin:onShow(argtable,afterOnloaded)
local flag=xianjieController:checkHudWinActive()
self:activeWin(flag)
xianjieController:aWakeWaitHud()
end

function UIXianJieHudWin:activeWin(flag)
self.hudRoot:setChildCanvasGroupRaycast(flag)
end