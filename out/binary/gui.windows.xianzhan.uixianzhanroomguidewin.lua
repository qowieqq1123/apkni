







def_class("UIXianZhanRoomGuideWin",UIWindowBase)









function UIXianZhanRoomGuideWin:bindComponents()

self.rebuildBtn=UIButton.get(self,0)

self.rebuildBtn:setButtonClick(function()self:onRebuildBtn()end)



end


function UIXianZhanRoomGuideWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rebuildBtn);self.rebuildBtn=nil;
end

















function UIXianZhanRoomGuideWin:onLoaded(...)
self:bindComponents()
end


function UIXianZhanRoomGuideWin:__delete()
self:unbindComponents()
end


function UIXianZhanRoomGuideWin:onHide()

end




function UIXianZhanRoomGuideWin:onShow(argtable,afterOnloaded)

end

function UIXianZhanRoomGuideWin:onRebuildBtn()
if UIManager:isActive('UIXianZhanMapWin')then
UIManager:invokeUIMethod('UIXianZhanMapWin','onRoomClick',1)
end
end

