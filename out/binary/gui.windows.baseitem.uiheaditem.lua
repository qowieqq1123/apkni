







def_class("UIHeadItem",UICloneObject)





UIHeadItem.abName="ui/windows/baseitem/uiheaditem.ab"

UIHeadItem.assetName="UIHeadItem"


function UIHeadItem:bindComponents()

self.UIHeadItem=UIObject.get(self,0)
self.icon=UIImage.get(self,1)
self.kuang=UIImage.get(self,2)
self.buleDiamond=UIObject.get(self,3)

end


function UIHeadItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UIHeadItem);self.UIHeadItem=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.buleDiamond);self.buleDiamond=nil;
end








function UIHeadItem:onLoaded(...)
self:bindComponents()
end

function UIHeadItem:__delete()
self.widget:SetChildUIModelRemoveTarget(1)
self.widget:SetChildIcon(1,"",false)
self.widget:SetChildQualityEffect(2,-1)
self.widget:SetChildUIModelRemoveTarget(2)
self.widget:SetChildCSImageIcon(2,"",false)
self:unbindComponents()
end

function UIHeadItem:onShow(argtable,afterOnloaded)
local iconInfo=argtable.iconInfo
local scale=argtable.scale or 1
local gray=argtable.gray or false
playerController:setWidgetHead96(self.widget,1,iconInfo)
playerController:setWidgetHeadKuangEx(self.widget,2,iconInfo)
playerController:setWidgetBlueDiamond(self.widget,3,iconInfo)
self.widget:SetChildScale(0,Vector3(scale,scale,scale))
self.widget:SetChildGray(-1,gray)
end

function UIHeadItem:onHide()

end


