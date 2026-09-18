







def_class("UILingYunLanZhongRuleShowWin",UIWindowBase)









function UILingYunLanZhongRuleShowWin:bindComponents()

self.root=UIObject.get(self,0)
self.startGameBtn=UIButton.get(self,1)

self.startGameBtn:setButtonClick(function()self:onStartGameBtn()end)



end


function UILingYunLanZhongRuleShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.startGameBtn);self.startGameBtn=nil;
end



















function UILingYunLanZhongRuleShowWin:onLoaded(...)
self:bindComponents()
end


function UILingYunLanZhongRuleShowWin:__delete()
self:unbindComponents()
end




function UILingYunLanZhongRuleShowWin:onShow(argtable,afterOnloaded)
self.showcallback=argtable.showcallback
end


function UILingYunLanZhongRuleShowWin:onHide()

end





function UILingYunLanZhongRuleShowWin:onStartGameBtn()
self.showcallback()
self:closeSelf()
end

