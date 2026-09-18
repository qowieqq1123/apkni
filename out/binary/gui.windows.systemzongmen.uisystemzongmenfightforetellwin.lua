







def_class("UISystemZongMenFightForetellWin",UIWindowBase)









function UISystemZongMenFightForetellWin:bindComponents()

self.background=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.model_1=UIObject.get(self,2)
self.model_2=UIObject.get(self,3)
self.model_3=UIObject.get(self,4)
self.tips=UIText.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)
self.model={
self.model_1,
self.model_2,
self.model_3,
}



end


function UISystemZongMenFightForetellWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.model_3);self.model_3=nil;
_UIObject_release(self.tips);self.tips=nil;
self.model=nil;
end



















function UISystemZongMenFightForetellWin:onLoaded(...)
self:bindComponents()
end


function UISystemZongMenFightForetellWin:__delete()
self:unbindComponents()
end




function UISystemZongMenFightForetellWin:onShow(argtable,afterOnloaded)
self:delayDo(3,function()
self.tips:setActive(true)
self.canClose=true
end)
end


function UISystemZongMenFightForetellWin:onHide()

end



function UISystemZongMenFightForetellWin:onBackground()
if self.canClose then
self:closeSelf()
end
end