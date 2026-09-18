







def_class("UISubAct_dzdzMaskWin",UIWindowBase)









function UISubAct_dzdzMaskWin:bindComponents()

self.maskBtn=UIButton.get(self,0)

self.maskBtn:setButtonClick(function()self:onMaskBtn()end)



end


function UISubAct_dzdzMaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBtn);self.maskBtn=nil;
end



















function UISubAct_dzdzMaskWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_dzdzMaskWin:__delete()
self:unbindComponents()
end




function UISubAct_dzdzMaskWin:onShow(argtable,afterOnloaded)

end


function UISubAct_dzdzMaskWin:onHide()

end





function UISubAct_dzdzMaskWin:onMaskBtn()
UIManager.error("正在锻造装备,不能退出界面!!")
end

