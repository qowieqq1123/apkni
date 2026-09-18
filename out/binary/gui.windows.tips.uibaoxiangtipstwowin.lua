







def_class("UIBaoXiangTipsTwoWin",UITipsWin)




















UIBaoXiangTipsTwoWin.movePosX=
{
[TIPS_MOVE_POS.eRight]=276,
[TIPS_MOVE_POS.eLeft]=-276,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
}



function UIBaoXiangTipsTwoWin:onLoaded(...)
self._base.onLoaded(self)
end


function UIBaoXiangTipsTwoWin:__delete()

end




function UIBaoXiangTipsTwoWin:onShow(argtable,afterOnloaded)
self._base.onShow(self,argtable,afterOnloaded)
end


function UIBaoXiangTipsTwoWin:onHide()
self._base.onHide(self)
end





function UIBaoXiangTipsTwoWin:onClickOutArea()
UIManager:closeWindow('UITipsWin')
end
