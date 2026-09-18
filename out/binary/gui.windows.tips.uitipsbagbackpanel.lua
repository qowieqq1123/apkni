







def_class("UITipsBagBackPanel",UIWindowBase)







local cshelper=CS.UIHelper

function UITipsBagBackPanel:auto_bind()
end
















function UITipsBagBackPanel:onLoaded(...)
self:setAsFirstSibling()
end

function UITipsBagBackPanel:__delete()
end

function UITipsBagBackPanel:onShow(argtable,afterOnloaded)

end

function UITipsBagBackPanel:onHide()

end



function UITipsBagBackPanel:closeSelf()
UIManager:closeWindow('UIDialgueBackPanel')
tipsManager.closeTips()
end