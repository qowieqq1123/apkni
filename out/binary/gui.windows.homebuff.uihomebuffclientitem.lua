







def_class("UIHomeBuffClientItem",UICloneObject)





UIHomeBuffClientItem.abName="ui/windows/homebuff/uihomebuffclientitem.ab"

UIHomeBuffClientItem.assetName="UIHomeBuffClientItem"


function UIHomeBuffClientItem:bindComponents()

self.icon=UIImage.get(self,0)
self.name=UIText.get(self,1)
self.line=UIObject.get(self,2)
self.desc1=UIText.get(self,3)

end


function UIHomeBuffClientItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.desc1);self.desc1=nil;
end







function UIHomeBuffClientItem:onLoaded(...)
self:bindComponents()
end


function UIHomeBuffClientItem:__delete()
self:unbindComponents()
end


function UIHomeBuffClientItem:onHide()

end




function UIHomeBuffClientItem:onShow(argtable,afterOnloaded)
local buffIcon=argtable.buffIcon
local buffName=argtable.buffName
local buffDesc=argtable.buffDesc
local idx=argtable.idx
local iconname=iconHelper.getzmStateIcon(buffIcon)
self.line:setActive(idx==1)
self.desc1:setText(buffDesc)
self.icon:setImageIcon(iconname,false)
self.name:setText(buffName)
end
