







def_class("UIBaoXiangTipsWin",UITipsWin)




















UIBaoXiangTipsWin.movePosX=
{
[TIPS_MOVE_POS.eRight]=276,
[TIPS_MOVE_POS.eLeft]=-276,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
}



function UIBaoXiangTipsWin:onLoaded(...)
self._base.onLoaded(self)
end


function UIBaoXiangTipsWin:__delete()
UIManager:closeWindow('UITipsWin')
UIManager:closeWindow('UIBaoXiangTipsTwoWin')
end




function UIBaoXiangTipsWin:onShow(argtable,afterOnloaded)
self._base.onShow(self,argtable,afterOnloaded)
end


function UIBaoXiangTipsWin:onHide()
self._base.onHide(self)
end




function UIBaoXiangTipsWin:onClickOutArea()
UIManager:closeWindow('UITipsWin')
UIManager:closeWindow('UIBaoXiangTipsTwoWin')
end
