







def_class("UIXianJunYanZhenEffect",UIWindowBase)









function UIXianJunYanZhenEffect:bindComponents()

self.StateEffect=UIObject.get(self,0)



end


function UIXianJunYanZhenEffect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.StateEffect);self.StateEffect=nil;
end



















function UIXianJunYanZhenEffect:onLoaded(...)
self:bindComponents()
end


function UIXianJunYanZhenEffect:__delete()
self:unbindComponents()
end




function UIXianJunYanZhenEffect:onShow(argtable,afterOnloaded)
self.StateEffect:setChildShowEffect(argtable.para,true)

local delayClose=function()
if self.delayTimer~=nil then
self.delayTimer=nil
self:closeSelf()
end
end
self.delayTimer=self:setTimer(2.5,1,delayClose)
end


function UIXianJunYanZhenEffect:onHide()

end



