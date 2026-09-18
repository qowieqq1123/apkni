







def_class("UIQieCuoLoseWin",UIWindowBase)









function UIQieCuoLoseWin:bindComponents()

self.dragonBack=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.fightCountBtn=UIButton.get(self,2)
self.fightRestartBtn=UIButton.get(self,3)
self.closeTips=UIButton.get(self,4)
self.quitButton=UIButton.get(self,5)
self.quitText=UIText.get(self,6)
self.finalHpPanel=UIObject.get(self,7)
self.finalHpProgress=UIProgress.get(self,8)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UIQieCuoLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
_UIObject_release(self.finalHpPanel);self.finalHpPanel=nil;
_UIObject_release(self.finalHpProgress);self.finalHpProgress=nil;
end



















function UIQieCuoLoseWin:onLoaded(...)
self:bindComponents()
end


function UIQieCuoLoseWin:__delete()
self:unbindComponents()
end




function UIQieCuoLoseWin:onShow(argtable,afterOnloaded)

end


function UIQieCuoLoseWin:onHide()

end





function UIQieCuoLoseWin:onFightCountBtn()
end



function UIQieCuoLoseWin:onFightRestartBtn()
end



function UIQieCuoLoseWin:onCloseTips()
end



function UIQieCuoLoseWin:onQuitButton()
end

