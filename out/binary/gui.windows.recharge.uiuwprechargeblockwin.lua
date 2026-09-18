







def_class("UIUWPRechargeBlockWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIUWPRechargeBlockWin:auto_bind()
end

















function UIUWPRechargeBlockWin:onLoaded(...)
self:bindComponents()
end


function UIUWPRechargeBlockWin:__delete()
self:unbindComponents()
end




function UIUWPRechargeBlockWin:onShow(argtable,afterOnloaded)

end


function UIUWPRechargeBlockWin:onHide()

end



