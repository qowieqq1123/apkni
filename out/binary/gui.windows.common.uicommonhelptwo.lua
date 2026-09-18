







def_class("UICommonHelpTwo",UIWindowBase)









function UICommonHelpTwo:bindComponents()

self.root=UIObject.get(self,0)
self.content=UIText.get(self,1)



end


function UICommonHelpTwo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.content);self.content=nil;
end



















function UICommonHelpTwo:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(0,0,1))
end


function UICommonHelpTwo:__delete()
self:unbindComponents()

if self.closeCB then
self.closeCB()
end
end




function UICommonHelpTwo:onShow(argtable,afterOnloaded)
self.content:setText(argtable.content)
self.closeCB=argtable.closeCB


local ptype=argtable.ptype or 5
local atype=argtable.atype or 5
local x=argtable.x or 0
local y=argtable.y or 0
local width=argtable.width or 365
local px,py,aminx,aminy,amaxx,amaxy
local duration=argtable.duration or 0.35

self.doScaleType=argtable.doScaleType or 1

local worldPos=argtable.worldPos
local offset=argtable.offset
local pivot=argtable.pivot


if ptype==1 then
px=0
py=0
elseif ptype==2 then
px=1
py=0
elseif ptype==3 then
px=0
py=1
elseif ptype==4 then
px=1
py=1
elseif ptype==5 then
px=0.5
py=0.5
end


if atype==1 then
aminx=0
aminy=0
amaxx=0
amaxy=0
elseif atype==2 then
aminx=1
aminy=0
amaxx=1
amaxy=0
elseif atype==3 then
aminx=0
aminy=1
amaxx=0
amaxy=1
elseif atype==4 then
aminx=1
aminy=1
amaxx=1
amaxy=1
elseif atype==5 then
aminx=0.5
aminy=0.5
amaxx=0.5
amaxy=0.5
end

local pv=pivot or Vector2.New(px,py)
self.winlua:SetChildPivot(self.root:getID(),pv)
local rt=self.root:getCommonComponent('RectTransform')
rt.anchorMin=Vector2.New(aminx,aminy)
rt.anchorMax=Vector2.New(amaxx,amaxy)

if worldPos then
self.root:setChildPosition(worldPos)
else
self.root:setChildAnchoredPosition(Vector2.New(x,y))
end

if offset then
local apos=self.root:getChildAnchoredPosition()
apos.x=apos.x+offset[1]
apos.y=apos.y+offset[2]
self.root:setChildAnchoredPosition(apos)
end



self.content:setChildSizeDelta(width,0)

if self.doScaleType==1 then

self.root:setScale(Vector3.New(1,0,1))
self.root:setChildDOScaleY(1,duration,nil)
elseif self.doScaleType==2 then

self.root:setScale(Vector3.New(0,1,1))
self.root:setChildDOScaleX(1,duration,nil)
end
end


function UICommonHelpTwo:onHide()

end




function UICommonHelpTwo:onCloseClick()
self:closeSelf()
end