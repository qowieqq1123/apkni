







def_class("UIBaseHeadItem",UICloneObject)





UIBaseHeadItem.abName="ui/windows/baseitem/uibaseheaditem.ab"

UIBaseHeadItem.assetName="UIBaseHeadItem"


function UIBaseHeadItem:bindComponents()

self.UIBaseHeadItem=UIObject.get(self,0)
self.icon=UIImage.get(self,1)
self.kuang=UIImage.get(self,2)
self.buleDiamond=UIObject.get(self,3)

end


function UIBaseHeadItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UIBaseHeadItem);self.UIBaseHeadItem=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.buleDiamond);self.buleDiamond=nil;
end








function UIBaseHeadItem:onLoaded(...)
self:bindComponents()
end

function UIBaseHeadItem:__delete()
self.widget:SetChildUIModelRemoveTarget(1)
self.widget:SetChildIcon(1,"",false)
self.widget:SetChildQualityEffect(2,-1)
self.widget:SetChildUIModelRemoveTarget(2)
self.widget:SetChildCSImageIcon(2,"",false)
self:unbindComponents()
end

function UIBaseHeadItem:onShow(argtable,afterOnloaded)
local iconInfo=argtable.iconInfo
local scale=argtable.scale or 1
local gray=argtable.gray or false
playerController:setWidgetHead96(self.widget,1,iconInfo)
playerController:setWidgetHeadKuangEx(self.widget,2,iconInfo)
playerController:setWidgetBlueDiamond(self.widget,3,iconInfo)
self.widget:SetChildScale(0,Vector3(scale,scale,scale))
self.widget:SetChildGray(-1,gray)
end

function UIBaseHeadItem:onHide()

end


