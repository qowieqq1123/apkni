







def_class("UI2048ResultWin",UIWindowBase)









function UI2048ResultWin:bindComponents()

self.bg=UIButton.get(self,0)
self.tipsTx=UIText.get(self,1)

self.bg:setButtonClick(function()self:onBg()end)



end


function UI2048ResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end
















local _this=nil




function UI2048ResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UI2048ResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UI2048ResultWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.tipsTx:setText(argtable.tips)
end


function UI2048ResultWin:onHide()

end



function UI2048ResultWin:onBg()
if self.callback()then
self.callback()
end
end