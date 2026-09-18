







def_class("UIMDLingShouSelect",UIWindowBase)









function UIMDLingShouSelect:bindComponents()

self.btnFire=UIButton.get(self,0)
self.btnWork=UIButton.get(self,1)
self.check1=UIImage.get(self,2)
self.check2=UIImage.get(self,3)
self.condition=UIObject.get(self,4)
self.condition1=UIText.get(self,5)
self.condition2=UIText.get(self,6)
self.costTips=UIObject.get(self,7)
self.emptyIcon=UIObject.get(self,8)
self.emptyPart=UIObject.get(self,9)
self.emptyTip=UIText.get(self,10)
self.filterTip=UIText.get(self,11)
self.roleListPanel=UIObject.get(self,12)
self.searchBtn=UIButton.get(self,13)
self.searchCancelBtn=UIButton.get(self,14)
self.searchInput=UIInputField.get(self,15)
self.selectType=UIObject.get(self,16)
self.txtFire=UIText.get(self,17)
self.txtWork=UIText.get(self,18)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIMDLingShouSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.check1);self.check1=nil;
_UIObject_release(self.check2);self.check2=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.emptyIcon);self.emptyIcon=nil;
_UIObject_release(self.emptyPart);self.emptyPart=nil;
_UIObject_release(self.emptyTip);self.emptyTip=nil;
_UIObject_release(self.filterTip);self.filterTip=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.selectType);self.selectType=nil;
_UIObject_release(self.txtFire);self.txtFire=nil;
_UIObject_release(self.txtWork);self.txtWork=nil;
end



















function UIMDLingShouSelect:onLoaded(...)
self:bindComponents()
end


function UIMDLingShouSelect:__delete()
self:unbindComponents()
end




function UIMDLingShouSelect:onShow(argtable,afterOnloaded)

end


function UIMDLingShouSelect:onHide()

end





function UIMDLingShouSelect:onBtnFire()
end



function UIMDLingShouSelect:onBtnWork()
end



function UIMDLingShouSelect:onSearchBtn()
end



function UIMDLingShouSelect:onSearchCancelBtn()
end

