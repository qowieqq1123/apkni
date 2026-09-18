







def_class("UICommonClickSceneEntityListWin",UIWindowBase)









function UICommonClickSceneEntityListWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.entityList=UIObject.get(self,2)
self.entityView=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.arrowLeft=UIObject.get(self,5)
self.arrowRight=UIObject.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UICommonClickSceneEntityListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.entityList);self.entityList=nil;
_UIObject_release(self.entityView);self.entityView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.arrowLeft);self.arrowLeft=nil;
_UIObject_release(self.arrowRight);self.arrowRight=nil;
end















local _this



function UICommonClickSceneEntityListWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UICommonClickSceneEntityListWin:__delete()
_this=nil
self:unbindComponents()
end




function UICommonClickSceneEntityListWin:onShow(argtable,afterOnloaded)
self.screenPoint=argtable and argtable.screenPoint
self.guidList=argtable and argtable.guidList
self:setRootPos()
self:refresh()
end


function UICommonClickSceneEntityListWin:onHide()

end

function UICommonClickSceneEntityListWin:refresh()
self.entityList:setChildLayoutGroupCreateItems(#self.guidList,function(index)
local item=self.entityList:getChildLayoutGroupGridItem(index-1)
local guid=self.guidList[index]
local nameStr=isometricMapSystem:getEntityName(guid)or"未知物体"
item:SetChildButtonClick(-1,function()
self:onClickItem(index)
end)
item:SetChildText(0,nameStr)
end)
self.entityView:setChildScrollRectEnable(#self.guidList>=3)
end



function UICommonClickSceneEntityListWin:setRootPos()
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local screenPos_x=self.screenPoint.x/scaleFactor.x
local screenPos_y=self.screenPoint.y/scaleFactor.y
local uiWidth=UnityEngine.Screen.width/scaleFactor.x
local uiHeight=UnityEngine.Screen.height/scaleFactor.y

local rt=self.background:getCommonComponent('RectTransform')



local pos_x
local pos_y
local arrowPos_x
local arrowPos_y
local posType=2

local itemWidth=self.root:getChildSizeDeltaX()
local itemHeight=self.root:getChildSizeDeltaY()
local halfItemWidth=itemWidth/2
local halfItemHeight=itemHeight/2

local anchorMinX=rt.anchorMin.x
local anchorMaxX=rt.anchorMax.x
local leftOffset=uiWidth*(anchorMinX-0)
local rightOffset=uiWidth*(1-anchorMaxX)
local halfWidth=(uiWidth-leftOffset-rightOffset)/2
local halfHeight=uiHeight/2
local originalPos_x=screenPos_x-halfWidth
local originalPos_y=screenPos_y-halfHeight

originalPos_x=originalPos_x-leftOffset/2+rightOffset/2
pos_x=originalPos_x+halfItemWidth+40
pos_y=originalPos_y+halfItemHeight-20

if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end

if pos_x+halfItemWidth>halfWidth then



posType=1
pos_x=originalPos_x-halfItemWidth-40
end


if pos_y-halfItemHeight<-halfHeight then
pos_y=-halfHeight+halfItemHeight
end

if pos_y+halfItemHeight>halfHeight then
pos_y=halfHeight-halfItemHeight
end

local minArrowPos=-87
local maxArrowPos=87
arrowPos_y=originalPos_y-pos_y
if arrowPos_y>maxArrowPos then
arrowPos_y=maxArrowPos
elseif arrowPos_y<minArrowPos then
arrowPos_y=minArrowPos
end

self.root:setChildAnchoredPos(pos_x,pos_y)
local arrowPos
self.arrowRight:setActive(posType==1)
self.arrowLeft:setActive(posType==2)
if posType==1 then

arrowPos=self.arrowRight:getChildAnchoredPosition()
self.arrowRight:setChildAnchoredPos(arrowPos.x,arrowPos_y)
elseif posType==2 then

arrowPos=self.arrowLeft:getChildAnchoredPosition()
self.arrowLeft:setChildAnchoredPos(arrowPos.x,arrowPos_y)
end
end




function UICommonClickSceneEntityListWin:onBackground()
self:onCloseBtn()
end



function UICommonClickSceneEntityListWin:onCloseBtn()
self:closeSelf()
end


function UICommonClickSceneEntityListWin:onClickItem(index)
local guid=self.guidList[index]
if guid and guid~=-1 then
local screenPoint=self.screenPoint
self:onCloseBtn()
isometricMapSystem:onTouchUp(screenPoint,guid)
else
UIManager.info("目标已消失")
self:onCloseBtn()
end
end
