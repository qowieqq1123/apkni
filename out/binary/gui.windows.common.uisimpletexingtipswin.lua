







def_class("UISimpleTeXingTipsWin",UIWindowBase)









function UISimpleTeXingTipsWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.clicker=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.signBottomLeft=UIImage.get(self,3)
self.skillDescTxt=UIText.get(self,4)
self.skillIcon=UIImage.get(self,5)
self.skillname=UIText.get(self,6)

self.clicker:setButtonClick(function()self:onClicker()end)



end


function UISimpleTeXingTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.clicker);self.clicker=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.signBottomLeft);self.signBottomLeft=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillname);self.skillname=nil;
end















local _this=nil



function UISimpleTeXingTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISimpleTeXingTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UISimpleTeXingTipsWin:onShow(argtable,afterOnloaded)

self.skillname:setText(argtable.name)
self.skillIcon:setImageIcon(argtable.icon,true)
self.skillDescTxt:setText(argtable.desc)


if argtable.bottomLeft then
self.signBottomLeft:setSprite(argtable.bottomLeft[1],argtable.bottomLeft[2])
end


if argtable.rootPoint then
if argtable.rootPoint.anchorsMin and argtable.rootPoint.anchorsMax then
self.winlua:SetChildAnchors(self.root:getID(),argtable.rootPoint.anchorsMin,argtable.rootPoint.anchorsMax)
end
if argtable.rootPoint.pivot then
self.winlua:SetChildPivot(self.root:getID(),argtable.rootPoint.pivot)
end
if argtable.rootPoint.anchoredPosition then
self.winlua:SetChildAnchoredPosition(self.root:getID(),argtable.rootPoint.anchoredPosition)
end
end

self.arrow:setActive(argtable.arrowPos~=nil)
if argtable.arrowPos then
if argtable.arrowPos.anchorsMin and argtable.arrowPos.anchorsMax then
self.winlua:SetChildAnchors(self.arrow:getID(),argtable.arrowPos.anchorsMin,argtable.arrowPos.anchorsMax)
end
if argtable.arrowPos.pivot then
self.winlua:SetChildPivot(self.arrow:getID(),argtable.arrowPos.pivot)
end
if argtable.arrowPos.anchoredPosition then
self.winlua:SetChildAnchoredPosition(self.arrow:getID(),argtable.arrowPos.anchoredPosition)
end
if argtable.arrowPos.rotation then
self.winlua:SetChildRotation(self.arrow:getID(),argtable.arrowPos.rotation.x,argtable.arrowPos.rotation.y,argtable.arrowPos.rotation.z)
end
end
end


function UISimpleTeXingTipsWin:onHide()

end




function UISimpleTeXingTipsWin:onClicker()
self:closeSelf()
end

