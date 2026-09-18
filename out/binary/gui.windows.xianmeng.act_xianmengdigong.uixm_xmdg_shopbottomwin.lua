







def_class("UIXM_XMDG_ShopBottomWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIXM_XMDG_ShopBottomWin:auto_bind()
end

















function UIXM_XMDG_ShopBottomWin:onLoaded(...)

end


function UIXM_XMDG_ShopBottomWin:__delete()

end




function UIXM_XMDG_ShopBottomWin:onShow(argtable,afterOnloaded)
self:setAsFirstSibling()
end


function UIXM_XMDG_ShopBottomWin:onHide()

end


function UIXM_XMDG_ShopBottomWin:onBackClick()
fullScreenUI.closeActiveUI(true)
end

