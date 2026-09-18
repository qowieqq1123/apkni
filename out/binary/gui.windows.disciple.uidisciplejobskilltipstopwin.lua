







def_class("UIDiscipleJobSkillTipsTopWin",UIDiscipleJobSkillTipsWin)
























function UIDiscipleJobSkillTipsTopWin:onLoaded(...)
self._base.onLoaded(self)
end


function UIDiscipleJobSkillTipsTopWin:__delete()

end




function UIDiscipleJobSkillTipsTopWin:onShow(argtable,afterOnloaded)
local layer=helper.getSortingLayerID('UITopModel')
self.winlua:SetChildCanvas(-1,layer,1001)
argtable.hideReport=true
self._base.onShow(self,argtable,afterOnloaded)
end


function UIDiscipleJobSkillTipsTopWin:onHide()
self._base.onHide(self)
end



