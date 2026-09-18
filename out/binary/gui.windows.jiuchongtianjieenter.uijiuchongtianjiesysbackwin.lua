







def_class("UIJiuChongTianJieSysBackWin",UIWindowBase)









function UIJiuChongTianJieSysBackWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.leaveBtn=UIButton.get(self,1)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)



end


function UIJiuChongTianJieSysBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
end















local _this=nil



function UIJiuChongTianJieSysBackWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIJiuChongTianJieSysBackWin:__delete()
self:unbindComponents()
_this=nil
end




function UIJiuChongTianJieSysBackWin:onShow(argtable,afterOnloaded)
self.backFunc=argtable.backFunc
self.leaveFunc=argtable.leaveFunc
end


function UIJiuChongTianJieSysBackWin:onHide()

end





function UIJiuChongTianJieSysBackWin:onBackBtn()
if self.backFunc then
self.backFunc()
end
end



function UIJiuChongTianJieSysBackWin:onLeaveBtn()
if self.leaveFunc then
self.leaveFunc()
end
end

