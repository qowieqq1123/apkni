







def_class("UIXianYunGangAttrDescWin",UIWindowBase)









function UIXianYunGangAttrDescWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.buff=UIObject.get(self,1)
self.buffValue=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.root=UIObject.get(self,4)
self.title=UIText.get(self,5)



end


function UIXianYunGangAttrDescWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.buff);self.buff=nil;
_UIObject_release(self.buffValue);self.buffValue=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIXianYunGangAttrDescWin:onLoaded(...)
self:bindComponents()
end


function UIXianYunGangAttrDescWin:__delete()
self:unbindComponents()
local cb=self.closeCB
if cb then
cb()
end
end




function UIXianYunGangAttrDescWin:onShow(argtable,afterOnloaded)

local showBlack=argtable.showBlack
if showBlack==nil then showBlack=false end
self.blackBG:setActive(showBlack)

self.closeCB=argtable.closeCB
self.title:setText(argtable.title)
self.desc:setText(argtable.desc)
self.buff:setActive(argtable.buffText~=nil)
if argtable.buffText~=nil then
self.buffValue:setText(argtable.buffText)
end
self.winlua:SetChildAnchoredPosition(self.root:getID(),Vector2.New(argtable.pos[1],argtable.pos[2]))

local moveSortOrder=argtable.moveSortOrder
if moveSortOrder then
local pos=self:getChildCanvas(-1)
self:setChildCanvas(-1,pos[1],pos[2]+moveSortOrder)
end

self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.5)
tween:SetDelay(0.25)
end


function UIXianYunGangAttrDescWin:onHide()

end



