







def_class("UIConditionTipsOne",UIWindowBase)









function UIConditionTipsOne:bindComponents()

self.rightTalk=UIObject.get(self,0)
self.leftTalk=UIObject.get(self,1)
self.leftTopTalk=UIObject.get(self,2)
self.rightTopTalk=UIObject.get(self,3)



end


function UIConditionTipsOne:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rightTalk);self.rightTalk=nil;
_UIObject_release(self.leftTalk);self.leftTalk=nil;
_UIObject_release(self.leftTopTalk);self.leftTopTalk=nil;
_UIObject_release(self.rightTopTalk);self.rightTopTalk=nil;
end

























function UIConditionTipsOne:onLoaded(...)
self:bindComponents()
end


function UIConditionTipsOne:__delete()
self:unbindComponents()
local cb=self.callback
if cb then
cb()
end
end


function UIConditionTipsOne:onHide()

end
















function UIConditionTipsOne:onShow(argtable,afterOnloaded)
self.showType=argtable.showType or 1
self.callback=argtable.callback
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end




self.pos=pos
self.desc=argtable.str
self:updateView()
end

function UIConditionTipsOne:updateView()
self.rightTalk:setActive(self.showType==1)
self.leftTalk:setActive(self.showType==2)
self.leftTopTalk:setActive(self.showType==3)
self.rightTopTalk:setActive(self.showType==4)
local root=self.showType==1 and self.rightTalk or
self.showType==2 and self.leftTalk or
self.showType==3 and self.leftTopTalk or
self.rightTopTalk

local widget=root:getChildWidgetBase()
widget:SetChildText(0,self.desc)
root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
root:setChildCanvasGroupAlpha(0)
root:setChildCanvasGroupDOFade(1,0.1,nil)
root:setScale(Vector3.New(0,0,0))
local t1=root:setChildDOScale(1,0.2,nil)

end