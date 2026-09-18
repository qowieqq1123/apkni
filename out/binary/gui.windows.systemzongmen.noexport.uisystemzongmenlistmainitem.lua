







def_class("UISystemZongMenListMainItem",UICloneObject)





UISystemZongMenListMainItem.abName=""

UISystemZongMenListMainItem.assetName="UISystemZongMenListMainItem"


function UISystemZongMenListMainItem:bindComponents()

self.bg=UIButton.get(self,0)
self.name=UIText.get(self,1)
self.jiantou1=UIObject.get(self,2)
self.jiantou2=UIObject.get(self,3)
self.reddot=UIObject.get(self,4)

self.bg:setButtonClick(function()self:onBg()end)

end


function UISystemZongMenListMainItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.jiantou1);self.jiantou1=nil;
_UIObject_release(self.jiantou2);self.jiantou2=nil;
_UIObject_release(self.reddot);self.reddot=nil;
end









function UISystemZongMenListMainItem:onLoaded(...)
self:bindComponents()
end


function UISystemZongMenListMainItem:__delete()
self:unbindComponents()
end




function UISystemZongMenListMainItem:onShow(argtable,afterOnloaded)

end


function UISystemZongMenListMainItem:onHide()

end


