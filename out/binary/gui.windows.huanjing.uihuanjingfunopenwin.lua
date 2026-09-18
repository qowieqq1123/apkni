







def_class("UIHuanJingFunOpenWin",UIWindowBase)









function UIHuanJingFunOpenWin:bindComponents()

self.backgrond=UIButton.get(self,0)
self.funcName=UIImage.get(self,1)
self.funcIcon=UIImage.get(self,2)
self.back=UIObject.get(self,3)

self.backgrond:setButtonClick(function()self:onBackgrond()end)



end


function UIHuanJingFunOpenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backgrond);self.backgrond=nil;
_UIObject_release(self.funcName);self.funcName=nil;
_UIObject_release(self.funcIcon);self.funcIcon=nil;
_UIObject_release(self.back);self.back=nil;
end















local _this=nil



function UIHuanJingFunOpenWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIHuanJingFunOpenWin:__delete()
self:unbindComponents()
_this=nil
end




function UIHuanJingFunOpenWin:onShow(argtable,afterOnloaded)
self.funcIcon:setSprite(argtable.iconAB,argtable.iconName)
self.funcName:setSprite(argtable.nameAB,argtable.nameName)
self.tweener=self.back:setChildCanvasGroupDOFade(1,1)
end


function UIHuanJingFunOpenWin:onHide()

end



function UIHuanJingFunOpenWin:onBackgrond()
if not self.tweener or not self.tweener:IsActive()then
self:closeSelf()
end
end