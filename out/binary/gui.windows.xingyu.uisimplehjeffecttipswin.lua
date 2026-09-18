







def_class("UISimpleHJEffectTipsWin",UIWindowBase)









function UISimpleHJEffectTipsWin:bindComponents()

self.tipRoot=UIObject.get(self,0)
self.clicker=UIButton.get(self,1)
self.desc=UIText.get(self,2)

self.clicker:setButtonClick(function()self:onClicker()end)



end


function UISimpleHJEffectTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipRoot);self.tipRoot=nil;
_UIObject_release(self.clicker);self.clicker=nil;
_UIObject_release(self.desc);self.desc=nil;
end



















function UISimpleHJEffectTipsWin:onLoaded(...)
self:bindComponents()
end


function UISimpleHJEffectTipsWin:__delete()
self:unbindComponents()
end




function UISimpleHJEffectTipsWin:onShow(argtable,afterOnloaded)
local desc=argtable.desc
self.desc:setText(desc)
local screenPoint=argtable.screenPoint
local tran=self.clicker:getCommonComponent('RectTransform')
local lpos=CS.CSGUIManager.Instance:ScreenPointToRectTransform(tran,screenPoint,true)

lpos.x=lpos.x+50
self.tipRoot:setChildAnchoredPosition(lpos)
end


function UISimpleHJEffectTipsWin:onHide()

end





function UISimpleHJEffectTipsWin:onClicker()
self:closeSelf()
end

