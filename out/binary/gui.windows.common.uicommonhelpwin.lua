







def_class("UICommonHelpWin",UIWindowBase)









function UICommonHelpWin:bindComponents()

self.tips=UIObject.get(self,0)
self.tipsbg=UIObject.get(self,1)
self.tipstext=UIText.get(self,2)



end


function UICommonHelpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsbg);self.tipsbg=nil;
_UIObject_release(self.tipstext);self.tipstext=nil;
end



















function UICommonHelpWin:onLoaded(...)
self:bindComponents()
end


function UICommonHelpWin:__delete()
self:unbindComponents()
end




function UICommonHelpWin:onShow(argtable,afterOnloaded)
local htype=argtable.htype
local content=argtable.content or'???'
local width=argtable.width or 237
local anchors=argtable.anchors
local x=argtable.x or 0
local y=argtable.y or 0
local worldPos=argtable.worldPos
local anchoredOffset=argtable.anchoredOffset
local sx,sy,px,py
local w=20
local h=30
local offset


if htype==1 then
sx=1
sy=1
px=0
py=0
offset=-5
elseif htype==2 then
sx=-1
sy=1
px=1
py=0
offset=-5
elseif htype==3 then
sx=1
sy=-1
px=0
py=1
offset=5
elseif htype==4 then
sx=-1
sy=-1
px=1
py=1
offset=5
end
local rt=self.tipsbg:getCommonComponent('RectTransform')
rt.localScale=Vector3.New(sx,sy,1)
rt.anchorMin=Vector2.New(0,0)
rt.anchorMax=Vector2.New(1,1)
rt.anchoredPosition=Vector2.New(0,offset)
rt.sizeDelta=Vector2.New(w,h)

self.winlua:SetChildPivot(self.tips:getID(),Vector2.New(px,py))
if worldPos then
self.tips:setChildPosition(worldPos)
else
self.tips:setChildAnchoredPosition(Vector2.New(x,y))
end
if anchoredOffset then
local apos=self.tips:getChildAnchoredPosition()
apos.x=apos.x+anchoredOffset[1]
apos.y=apos.y+anchoredOffset[2]
self.tips:setChildAnchoredPosition(apos)
end
self.tipstext:setChildSizeDelta(width,0)

self.tipstext:setText(content)

self.tips:setScale(Vector3.New(0,0,1))
local tweener=self.tips:setChildDOScale(1,0.35,nil)
tweener:SetEase(_Ease.OutBack)

if anchors then
local trt=self.tips:getCommonComponent('RectTransform')
trt.anchorMin=Vector2.New(anchors[1][1],anchors[1][2])
trt.anchorMax=Vector2.New(anchors[2][1],anchors[2][2])
end
end


function UICommonHelpWin:onHide()

end




function UICommonHelpWin:onCloseClick()
self:closeSelf()
end