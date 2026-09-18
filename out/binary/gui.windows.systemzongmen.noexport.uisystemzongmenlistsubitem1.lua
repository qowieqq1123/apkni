







def_class("UISystemZongMenListSubItem1",UICloneObject)





UISystemZongMenListSubItem1.abName=""

UISystemZongMenListSubItem1.assetName="UISystemZongMenListSubItem1"


function UISystemZongMenListSubItem1:bindComponents()

self.bg=UIButton.get(self,0)
self.name=UIText.get(self,1)
self.level=UIText.get(self,2)
self.disBg=UIObject.get(self,3)
self.noneTips=UIText.get(self,4)
self.selected=UIObject.get(self,5)
self.reddot=UIObject.get(self,6)
self.icon=UIImage.get(self,7)
self.disIcon=UIObject.get(self,8)

self.bg:setButtonClick(function()self:onBg()end)

end


function UISystemZongMenListSubItem1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.disBg);self.disBg=nil;
_UIObject_release(self.noneTips);self.noneTips=nil;
_UIObject_release(self.selected);self.selected=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.disIcon);self.disIcon=nil;
end









function UISystemZongMenListSubItem1:onLoaded(...)
self:bindComponents()
end


function UISystemZongMenListSubItem1:__delete()
self:unbindComponents()
end




function UISystemZongMenListSubItem1:onShow(argtable,afterOnloaded)

end


function UISystemZongMenListSubItem1:onHide()

end


