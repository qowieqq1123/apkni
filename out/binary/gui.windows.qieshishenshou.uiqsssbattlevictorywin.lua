







def_class("UIQSSSBattleVictoryWin",UIWindowBase)









function UIQSSSBattleVictoryWin:bindComponents()

self.tips=UIText.get(self,0)



end


function UIQSSSBattleVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tips);self.tips=nil;
end



















function UIQSSSBattleVictoryWin:onLoaded(...)
self:bindComponents()
end


function UIQSSSBattleVictoryWin:__delete()
self:unbindComponents()
end




function UIQSSSBattleVictoryWin:onShow(argtable,afterOnloaded)

end


function UIQSSSBattleVictoryWin:onHide()

end



