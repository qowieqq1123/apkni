







def_class("UIBottomMaskEmpty_black2Win",UIWindowBase)







local cshelper=CS.UIHelper

function UIBottomMaskEmpty_black2Win:auto_bind()
end















function UIBottomMaskEmpty_black2Win:onLoaded(...)

end


function UIBottomMaskEmpty_black2Win:__delete()

end


function UIBottomMaskEmpty_black2Win:onHide()

end




function UIBottomMaskEmpty_black2Win:onShow(argtable,afterOnloaded)
self:setAsFirstSibling()
end

function UIBottomMaskEmpty_black2Win:onBackClick()
fullScreenUI.closeActiveUI(true)
end
