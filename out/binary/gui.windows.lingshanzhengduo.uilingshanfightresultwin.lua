







def_class("UILingShanFightResultWin",UIWindowBase)









function UILingShanFightResultWin:bindComponents()

self.resultText=UIText.get(self,0)
self.root=UIObject.get(self,1)



end


function UILingShanFightResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.resultText);self.resultText=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UILingShanFightResultWin:onLoaded(...)
self:bindComponents()

self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.5,nil)
tween:SetDelay(0.8)
end


function UILingShanFightResultWin:__delete()
self:unbindComponents()
end




function UILingShanFightResultWin:onShow(argtable,afterOnloaded)
local result=argtable.result
if result==1 then
self.resultText:setText('挑战成功，队伍已成功入驻灵山！')
elseif result==-1 then
self.resultText:setText('挑战失败，队伍入驻灵山失败！')
else
self.resultText:setText('平局')
end
end


function UILingShanFightResultWin:onHide()

end



