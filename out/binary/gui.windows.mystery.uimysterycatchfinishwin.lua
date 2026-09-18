







def_class("UIMysteryCatchFinishWin",UIWindowBase)









function UIMysteryCatchFinishWin:bindComponents()

self.effect=UIObject.get(self,0)



end


function UIMysteryCatchFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
end



















function UIMysteryCatchFinishWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryCatchFinishWin:__delete()
self:unbindComponents()
end




function UIMysteryCatchFinishWin:onShow(argtable,afterOnloaded)
local delayCb=function()
self:closeSelf()
MysteryLingshouModel:ShowLingShouWin()

end
self.effect:setChildShowEffect(18065,true)
local delay=self:setTimer(2,1,delayCb)
end


function UIMysteryCatchFinishWin:onHide()

end



