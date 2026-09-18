







def_class("UIFeiShengTaiPassWin",UIWindowBase)









function UIFeiShengTaiPassWin:bindComponents()

self.passBtn=UIButton.get(self,0)
self.root=UIObject.get(self,1)

self.passBtn:setButtonClick(function()self:onPassBtn()end)



end


function UIFeiShengTaiPassWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.passBtn);self.passBtn=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIFeiShengTaiPassWin:onLoaded(...)
self:bindComponents()
end


function UIFeiShengTaiPassWin:__delete()
self:unbindComponents()
end




function UIFeiShengTaiPassWin:onShow(argtable,afterOnloaded)

end


function UIFeiShengTaiPassWin:onHide()

end





function UIFeiShengTaiPassWin:onPassBtn()
FeiShengTaiController:closeDuJieFeiSheng()
end

