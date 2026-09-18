







def_class("UILittleWorldZhenWuSlotWin",UIWindowBase)









function UILittleWorldZhenWuSlotWin:bindComponents()

self.slot=UIButton.get(self,0)

self.slot:setButtonClick(function()self:onSlot()end)



end


function UILittleWorldZhenWuSlotWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.slot);self.slot=nil;
end


















local zhenwuSlot={{}}


function UILittleWorldZhenWuSlotWin:onLoaded(...)
self:bindComponents()
self.slotEnt={}
end


function UILittleWorldZhenWuSlotWin:__delete()
self:unbindComponents()
end




function UILittleWorldZhenWuSlotWin:onShow(argtable,afterOnloaded)

end


function UILittleWorldZhenWuSlotWin:onHide()

end

function UILittleWorldZhenWuSlotWin:showSlot(idx)

end






function UILittleWorldZhenWuSlotWin:onSlot()
end

