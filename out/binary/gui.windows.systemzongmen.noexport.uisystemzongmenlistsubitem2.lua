







def_class("UISystemZongMenListSubItem2",UICloneObject)





UISystemZongMenListSubItem2.abName=""

UISystemZongMenListSubItem2.assetName="UISystemZongMenListSubItem2"


function UISystemZongMenListSubItem2:bindComponents()

self.click=UIButton.get(self,0)
self.name=UIText.get(self,1)
self.level=UIText.get(self,2)
self.selected=UIObject.get(self,3)
self.disIcon=UIObject.get(self,4)

self.click:setButtonClick(function()self:onClick()end)

end


function UISystemZongMenListSubItem2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.selected);self.selected=nil;
_UIObject_release(self.disIcon);self.disIcon=nil;
end









function UISystemZongMenListSubItem2:onLoaded(...)
self:bindComponents()
end


function UISystemZongMenListSubItem2:__delete()
self:unbindComponents()
end




function UISystemZongMenListSubItem2:onShow(argtable,afterOnloaded)

end


function UISystemZongMenListSubItem2:onHide()

end


