







def_class("UIElementInfoWin",UIWindowBase)









function UIElementInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.elementBG=UIImage.get(self,1)
self.desc=UIText.get(self,2)
self.attrsGroup=UIObject.get(self,3)
self.elementName=UIText.get(self,4)



end


function UIElementInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.elementBG);self.elementBG=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.attrsGroup);self.attrsGroup=nil;
_UIObject_release(self.elementName);self.elementName=nil;
end



















function UIElementInfoWin:onLoaded(...)
self:bindComponents()
self.root:setScale(Vector3.New(0,0,1))
self.root:setChildDOScale(1,0.25,nil)
end


function UIElementInfoWin:__delete()
self:unbindComponents()
end




function UIElementInfoWin:onShow(argtable,afterOnloaded)
self.winlua:SetChildUIScreenPos(self.root:getID(),argtable.pos)
local offset=argtable.offset
if offset then
local apos=self.root:getChildAnchoredPosition()
apos.x=apos.x+offset[1]
apos.y=apos.y+offset[2]
self.root:setChildAnchoredPosition(apos)
end
local name=UIShouLanModel.getSpecialityNameStr(argtable.name)
local abName,frameIcon=UIShouLanModel.getSpecialityColorFrame(argtable.color,argtable.isElement)
self.elementName:setText(name)
self.elementBG:setSprite(abName,frameIcon)
self.desc:setText(argtable.desc)


local attrsDescList=argtable.attrsDescList
local isShowAttrsDesc=false
if attrsDescList then
local len=#attrsDescList
isShowAttrsDesc=len>0
if isShowAttrsDesc then
self.attrsGroup:setChildLayoutGroupCreateItems(len,function(index)
local widget=self.attrsGroup:getChildLayoutGroupGridItem(index-1)
local attrDescStr=attrsDescList[index]
if attrDescStr then
widget:SetChildActive(-1,true)
widget:SetChildText(-1,attrDescStr)
else
widget:SetChildActive(-1,false)
end
end)
end
end

self.attrsGroup:setActive(isShowAttrsDesc)
end


function UIElementInfoWin:onHide()

end




function UIElementInfoWin:onCloseClick()
self:closeSelf()
end