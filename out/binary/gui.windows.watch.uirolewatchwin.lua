







def_class("UIRoleWatchWin",UIWindowBase)









function UIRoleWatchWin:bindComponents()

self.name=UIText.get(self,0)
self.sever=UIText.get(self,1)
self.xianmeng=UIText.get(self,2)
self.SlotView=UIScrollView.get(self,3)
self.icon=UIButton.get(self,4)

self.icon:setButtonClick(function()self:onIcon()end)



end


function UIRoleWatchWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.sever);self.sever=nil;
_UIObject_release(self.xianmeng);self.xianmeng=nil;
_UIObject_release(self.SlotView);self.SlotView=nil;
_UIObject_release(self.icon);self.icon=nil;
end


















function UIRoleWatchWin:onLoaded(...)
self:bindComponents()
end

function UIRoleWatchWin:__delete()
self:unbindComponents()
end

function UIRoleWatchWin:onShow(argtable,afterOnloaded)

end

function UIRoleWatchWin:onHide()

end





function UIRoleWatchWin:onIcon()
end

