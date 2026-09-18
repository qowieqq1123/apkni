







def_class("UIPrivateBtnWin",UIWindowBase)









function UIPrivateBtnWin:bindComponents()

self.btn=UIButton.get(self,0)

self.btn:setButtonClick(function()self:onBtn()end)



end


function UIPrivateBtnWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn);self.btn=nil;
end


















function UIPrivateBtnWin:onLoaded(...)
self:bindComponents()
end

function UIPrivateBtnWin:__delete()
self:unbindComponents()
end

function UIPrivateBtnWin:onShow(argtable,afterOnloaded)
self.args=argtable
end

function UIPrivateBtnWin:onHide()

end





function UIPrivateBtnWin:onBtn()
local formType=self.args.formType
local actorInfo=self.args.actorInfo
chatControl.talkToActor(formType,actorInfo)
self:closeSelf()
end

