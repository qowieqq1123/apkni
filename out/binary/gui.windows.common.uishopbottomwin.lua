







def_class("UIShopBottomWin",UIWindowBase)









function UIShopBottomWin:bindComponents()

self.title=UIText.get(self,0)



end


function UIShopBottomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
end



















function UIShopBottomWin:onLoaded(...)
self:bindComponents()
end


function UIShopBottomWin:__delete()
self:unbindComponents()
end




function UIShopBottomWin:onShow(argtable,afterOnloaded)

end


function UIShopBottomWin:onHide()

end




function UIShopBottomWin:setTitle(title)
self.title:setText(title)
end


function UIShopBottomWin:onClickCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UIShopBottomWin:onClickClose()
fullScreenUI.closeActiveUI()
end