







def_class("UIBottomMaskEmptyExWin",UIWindowBase)









function UIBottomMaskEmptyExWin:bindComponents()

self.mask=UIButton.get(self,0)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIBottomMaskEmptyExWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
end



















function UIBottomMaskEmptyExWin:onLoaded(...)
self:bindComponents()
end


function UIBottomMaskEmptyExWin:__delete()
self:unbindComponents()
end




function UIBottomMaskEmptyExWin:onShow(argtable,afterOnloaded)

end


function UIBottomMaskEmptyExWin:onHide()

end



function UIBottomMaskEmptyExWin:onMask()

end

