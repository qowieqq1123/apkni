







def_class("UIXianJie_firstEntryXianJieTipsWin",UIWindowBase)









function UIXianJie_firstEntryXianJieTipsWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.desc_1=UIText.get(self,1)
self.desc_2=UIText.get(self,2)
self.desc_3=UIText.get(self,3)
self.desc_4=UIText.get(self,4)
self.icon_1=UIObject.get(self,5)
self.icon_2=UIObject.get(self,6)
self.icon_3=UIObject.get(self,7)
self.icon_4=UIObject.get(self,8)
self.mbg=UIObject.get(self,9)
self.name_1=UIText.get(self,10)
self.name_2=UIText.get(self,11)
self.name_3=UIText.get(self,12)
self.name_4=UIText.get(self,13)
self.root=UIObject.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.desc={
self.desc_1,
self.desc_2,
self.desc_3,
self.desc_4,
}
self.icon={
self.icon_1,
self.icon_2,
self.icon_3,
self.icon_4,
}
self.name={
self.name_1,
self.name_2,
self.name_3,
self.name_4,
}



end


function UIXianJie_firstEntryXianJieTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc_1);self.desc_1=nil;
_UIObject_release(self.desc_2);self.desc_2=nil;
_UIObject_release(self.desc_3);self.desc_3=nil;
_UIObject_release(self.desc_4);self.desc_4=nil;
_UIObject_release(self.icon_1);self.icon_1=nil;
_UIObject_release(self.icon_2);self.icon_2=nil;
_UIObject_release(self.icon_3);self.icon_3=nil;
_UIObject_release(self.icon_4);self.icon_4=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.name_1);self.name_1=nil;
_UIObject_release(self.name_2);self.name_2=nil;
_UIObject_release(self.name_3);self.name_3=nil;
_UIObject_release(self.name_4);self.name_4=nil;
_UIObject_release(self.root);self.root=nil;
self.desc=nil;
self.icon=nil;
self.name=nil;
end



















function UIXianJie_firstEntryXianJieTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_firstEntryXianJieTipsWin:__delete()
self:unbindComponents()
end




function UIXianJie_firstEntryXianJieTipsWin:onShow(argtable,afterOnloaded)

end


function UIXianJie_firstEntryXianJieTipsWin:onHide()

end




function UIXianJie_firstEntryXianJieTipsWin:onCloseBtn()
self:closeSelf()
end