







def_class("UIFightPrepareMessageWin",UIWindowBase)









function UIFightPrepareMessageWin:bindComponents()

self.messageTx=UIText.get(self,0)



end


function UIFightPrepareMessageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.messageTx);self.messageTx=nil;
end



















function UIFightPrepareMessageWin:onLoaded(...)
self:bindComponents()
end


function UIFightPrepareMessageWin:__delete()
self:unbindComponents()
end




function UIFightPrepareMessageWin:onShow(argtable,afterOnloaded)
self.messageTx:setText(argtable.message)
end


function UIFightPrepareMessageWin:onHide()

end



