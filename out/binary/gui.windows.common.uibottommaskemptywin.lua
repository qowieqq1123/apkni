







def_class("UIBottomMaskEmptyWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIBottomMaskEmptyWin:auto_bind()
end















function UIBottomMaskEmptyWin:onLoaded(...)

end


function UIBottomMaskEmptyWin:__delete()

end


function UIBottomMaskEmptyWin:onHide()

end




function UIBottomMaskEmptyWin:onShow(argtable,afterOnloaded)
self:setAsFirstSibling()
end

function UIBottomMaskEmptyWin:setTitle()

end

function UIBottomMaskEmptyWin:onBackClick()
fullScreenUI.closeActiveUI(true)
end
