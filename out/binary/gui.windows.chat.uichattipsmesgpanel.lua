







def_class("UIChatTipsMesgPanel",UIWindowBase)







local cshelper=CS.UIHelper

function UIChatTipsMesgPanel:auto_bind()
end
















function UIChatTipsMesgPanel:onLoaded(...)
self:bindComponents()
end

function UIChatTipsMesgPanel:__delete()
self:unbindComponents()
end

function UIChatTipsMesgPanel:onShow(mesg,afterOnloaded)
self:set_txt(mesg)
end

function UIChatTipsMesgPanel:onHide()

end



