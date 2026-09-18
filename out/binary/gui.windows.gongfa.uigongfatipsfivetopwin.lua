







def_class("UIGongFaTipsFiveTopWin",UIGongFaTipsFiveWin)
























function UIGongFaTipsFiveTopWin:onLoaded(...)
self._base.onLoaded(self)
end


function UIGongFaTipsFiveTopWin:__delete()

end




function UIGongFaTipsFiveTopWin:onShow(argtable,afterOnloaded)
local layer=helper.getSortingLayerID('UITopModel')
self.winlua:SetChildCanvas(-1,layer,1001)
self._base.onShow(self,argtable,afterOnloaded)
end


function UIGongFaTipsFiveTopWin:onHide()
self._base.onHide(self)
end



