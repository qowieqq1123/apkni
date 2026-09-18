







def_class("UITipsExWin",UITipsWin)























function UITipsExWin:onLoaded(...)
self._base.onLoaded(self)
end


function UITipsExWin:__delete()

end

function UITipsExWin:onShow(argtable,afterOnloaded)
argtable.move=argtable.exWinMove or TIPS_MOVE_POS.eLeftTwo
self._base.onShow(self,argtable,afterOnloaded)
if UIManager:isActive('UITipsWin')then
UIManager:callWindowFunc('UITipsWin','setAsLastSibling')
end
end

function UITipsExWin:onHide()
self._base.onHide(self)
end



