






UISetPivotNode=simple_class(baseNode)

function UISetPivotNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local pivot=self:getData('pivot')
local rt=widget:GetCommonComponent(wIndex,"RectTransform")
local _Pivot=rt.pivot
local _sizeDelta=rt.sizeDelta
local _anchorPos=rt.anchoredPosition
widget:SetChildPivot(wIndex,Vector2.New(pivot[1],pivot[2]))
local x=_anchorPos.x+(pivot[1]-_Pivot.x)*_sizeDelta.x
local y=_anchorPos.y+(pivot[2]-_Pivot.y)*_sizeDelta.y
widget:SetChildAnchoredPos(wIndex,x,y)
return nodeState.success
end

function UISetPivotNode:skip()
return self:update()
end