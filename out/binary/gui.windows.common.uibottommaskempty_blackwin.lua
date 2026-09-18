







def_class("UIBottomMaskEmpty_blackWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIBottomMaskEmpty_blackWin:auto_bind()
end

















function UIBottomMaskEmpty_blackWin:onLoaded(...)

end


function UIBottomMaskEmpty_blackWin:__delete()

end




function UIBottomMaskEmpty_blackWin:onShow(argtable,afterOnloaded)
self:setAsFirstSibling()
end


function UIBottomMaskEmpty_blackWin:onHide()

end


function UIBottomMaskEmpty_blackWin:onBackClick()
fullScreenUI.closeActiveUI(true)
end


