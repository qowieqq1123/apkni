







def_class("UIXWSRankWin",UIWindowBase)









function UIXWSRankWin:bindComponents()

self.content=UIText.get(self,0)
self.mainPanel=UIObject.get(self,1)
self.mask=UIButton.get(self,2)
self.model=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.xbsRank=UIText.get(self,5)
self.xbsRankPanel=UIObject.get(self,6)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXWSRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.xbsRank);self.xbsRank=nil;
_UIObject_release(self.xbsRankPanel);self.xbsRankPanel=nil;
end



















function UIXWSRankWin:onLoaded(...)
self:bindComponents()
end


function UIXWSRankWin:__delete()
self:unbindComponents()
end




function UIXWSRankWin:onShow(argtable,afterOnloaded)
local gronp=argtable.group
local pos=argtable.pos
self.mainPanel:setChildCanvasGroupAlpha(0)
local tweener=self.mainPanel:setChildCanvasGroupDOFade(1,0.5)
tweener:SetDelay(1)
self.model:setActive(true)
self.xbsRank:setText(pos)
self.content:setText(FMT.fmt("祖师在问鼎苍穹-席位赛的{0}\n获得第<color=#c82c2c><size=36>{1}</size></color>名",WDCQCGroupNmae[gronp],pos))
end


function UIXWSRankWin:onHide()

end


function UIXWSRankWin:onMask()

self:closeSelf()
end