







def_class("UIDouYinMiniGameWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIDouYinMiniGameWin:auto_bind()
end

















function UIDouYinMiniGameWin:onLoaded(...)
self:bindComponents()
end


function UIDouYinMiniGameWin:__delete()

end




function UIDouYinMiniGameWin:onShow(argtable,afterOnloaded)
updateState.closeLoading()
end


function UIDouYinMiniGameWin:onHide()

end



