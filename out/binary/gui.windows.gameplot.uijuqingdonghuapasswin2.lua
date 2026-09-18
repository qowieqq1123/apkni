







def_class("UIJuQingDongHuaPassWin2",UIWindowBase)









function UIJuQingDongHuaPassWin2:bindComponents()

self.passBtn=UIButton.get(self,0)

self.passBtn:setButtonClick(function()self:onPassBtn()end)



end


function UIJuQingDongHuaPassWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.passBtn);self.passBtn=nil;
end



















function UIJuQingDongHuaPassWin2:onLoaded(...)
self:bindComponents()
end


function UIJuQingDongHuaPassWin2:__delete()
self:unbindComponents()
end




function UIJuQingDongHuaPassWin2:onShow(argtable,afterOnloaded)
self.clickFunc=argtable.clickFunc
local pos=self.winlua:GetChildUIScreenPos2Local(self.passBtn:getID(),argtable.pos)

self.passBtn:setChildAnchoredPosition({x=pos.x+667-85,y=pos.y+375-32,z=0})
self.passBtn:setChildSizeDelta(argtable.w+30,argtable.h+60)

weakGuideController:beginGuide(4163)
end


function UIJuQingDongHuaPassWin2:onHide()

end





function UIJuQingDongHuaPassWin2:onPassBtn()
if self.clickFunc then
self.clickFunc()
self.clickFunc=nil
end
self:closeSelf()
end

