







def_class("UICommonShowPrizeXJAddTeamWin",UIWindowBase)









function UICommonShowPrizeXJAddTeamWin:bindComponents()

self.effect=UIObject.get(self,0)
self.Item=UIObject.get(self,1)
self.noteGridPanel=UIObject.get(self,2)
self.noteScrollView=UIObject.get(self,3)
self.tips=UILinkImageText.get(self,4)
self.tipsText=UIText.get(self,5)



end


function UICommonShowPrizeXJAddTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.Item);self.Item=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end



















function UICommonShowPrizeXJAddTeamWin:onLoaded(...)
self:bindComponents()
end


function UICommonShowPrizeXJAddTeamWin:__delete()
self:unbindComponents()
end




function UICommonShowPrizeXJAddTeamWin:onShow(argtable,afterOnloaded)
self.curStep=1
self:stopAllTimer()
self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'
self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

self:delayDo(0.3,function()
self.Item:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UICommonShowPrizeXJAddTeamWin:onHide()

end




function UICommonShowPrizeXJAddTeamWin:onClickClose()
self:closeSelf()
end