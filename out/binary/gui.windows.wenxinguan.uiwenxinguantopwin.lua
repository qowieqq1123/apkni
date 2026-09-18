







def_class("UIWenXinGuanTopWin",UIWindowBase)









function UIWenXinGuanTopWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.closeRoot=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.selectText=UIText.get(self,3)
self.toMainCloseBtn=UIButton.get(self,4)
self.toMainCloseRoot=UIObject.get(self,5)
self.toMainSelectText=UIText.get(self,6)
self.transitionImg=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.toMainCloseBtn:setButtonClick(function()self:onToMainCloseBtn()end)



end


function UIWenXinGuanTopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeRoot);self.closeRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.toMainCloseBtn);self.toMainCloseBtn=nil;
_UIObject_release(self.toMainCloseRoot);self.toMainCloseRoot=nil;
_UIObject_release(self.toMainSelectText);self.toMainSelectText=nil;
_UIObject_release(self.transitionImg);self.transitionImg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIWenXinGuanTopWin:onLoaded(...)
self:bindComponents()
end


function UIWenXinGuanTopWin:__delete()
self:unbindComponents()
end




function UIWenXinGuanTopWin:onShow(argtable,afterOnloaded)
self.return_jump_param=argtable
self.closeRoot:setActive(true)
self.transitionImg:setActive(false)
self.transitionImg:setChildCanvasGroupAlpha(0)
end


function UIWenXinGuanTopWin:onHide()

end

function UIWenXinGuanTopWin:onDoFade(value,time)
local tweener=self.Root:setChildCanvasGroupDOFade(value,time)
tweener:SetEase(DG.Tweening.Ease.Linear)
end




function UIWenXinGuanTopWin:onCloseBtn()
jumpManager:jump(self.return_jump_param)
self:closeSelf()
end


function UIWenXinGuanTopWin:onToMainCloseBtn()
local startCallback=function()
UIManager:closeWindow("UIWenXinGuanEnterBgWin")
UIFullWenXinGuanControl:closeUI(true)
self:closeSelf()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end