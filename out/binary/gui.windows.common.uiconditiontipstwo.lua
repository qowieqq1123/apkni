







def_class("UIConditionTipsTwo",UIWindowBase)









function UIConditionTipsTwo:bindComponents()

self.leftBottomTalk=UIObject.get(self,0)
self.creator=UIGameobjectClone.new(self,1)
self.rightBottomTalk=UIObject.get(self,2)
self.leftTopTalk=UIObject.get(self,3)
self.rightTopTalk=UIObject.get(self,4)



end


function UIConditionTipsTwo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftBottomTalk);self.leftBottomTalk=nil;
self.creator:deleteSelf();self.creator=nil;
_UIObject_release(self.rightBottomTalk);self.rightBottomTalk=nil;
_UIObject_release(self.leftTopTalk);self.leftTopTalk=nil;
_UIObject_release(self.rightTopTalk);self.rightTopTalk=nil;
end


















local itemName='UIChildTalkRightItem'
local parentFun=
{
[eArrowDirectionType.eBottomLeft]=function(self)
return self.leftBottomTalk:getID()
end,
[eArrowDirectionType.eBottomRight]=function(self)
return self.rightBottomTalk:getID()
end,
[eArrowDirectionType.eTopLeft]=function(self)
return self.leftTopTalk:getID()
end,
[eArrowDirectionType.eTopRight]=function(self)
return self.rightTopTalk:getID()
end,
}

function UIConditionTipsTwo:onLoaded(...)
self:bindComponents()
end

function UIConditionTipsTwo:__delete()
self:unbindComponents()
end

function UIConditionTipsTwo:onShow(argtable,afterOnloaded)
local showType=argtable.showType or eArrowDirectionType.eBottomLeft
local showTitle=argtable.showTitle
if showTitle==nil then
showTitle=true
end
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

local descTable=argtable.descTable
self.closeCall=argtable.closeCall
local parentIdx=parentFun[showType](self)



if pos then
self.winlua:SetChildLocalPosition(parentIdx,Vector3.New(pos.x,pos.y,0))
end



self.winlua:SetChildCanvasGroupDOFade(parentIdx,1,0.5,nil)
for i=1,#descTable do
local desc=descTable[i]
self.creator:createObject(itemName,parentIdx,i,{desc=desc,showTitle=showTitle})
end
end

function UIConditionTipsTwo:onHide()

end

function UIConditionTipsTwo:__delete()
if self.closeCall then
self.closeCall()
end
end


