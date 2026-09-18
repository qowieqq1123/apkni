







def_class("UIJuQingDongHuaHeiBianWin",UIWindowBase)









function UIJuQingDongHuaHeiBianWin:bindComponents()

self.Image1=UIObject.get(self,0)
self.Image2=UIObject.get(self,1)



end


function UIJuQingDongHuaHeiBianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Image1);self.Image1=nil;
_UIObject_release(self.Image2);self.Image2=nil;
end



















function UIJuQingDongHuaHeiBianWin:onLoaded(...)
self:bindComponents()
end


function UIJuQingDongHuaHeiBianWin:__delete()
self:unbindComponents()
end




function UIJuQingDongHuaHeiBianWin:onShow(argtable,afterOnloaded)
self.Image1:setChildDOAnchorPosY(-60,1,nil)
self.Image2:setChildDOAnchorPosY(60,1,nil)
end


function UIJuQingDongHuaHeiBianWin:onHide()

end



function UIJuQingDongHuaHeiBianWin:closeWin()
local func=function(...)
self:closeSelf()
end
self.Image1:setChildDOAnchorPosY(0,1,nil)
self.Image2:setChildDOAnchorPosY(0,1,func)
end