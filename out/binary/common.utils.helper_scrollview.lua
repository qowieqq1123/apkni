














function helper.changeScrollViewItemIndex_horizontal(sIndex,dIndex,scrollerView,hideX,moveTime,callback)
if sIndex==dIndex then
if callback then
callback()
end
return
end
local moveTime=moveTime or 1
local mTime=moveTime/3
local s_widget=scrollerView:getChildScrollViewItemWidget(sIndex)
local s_pos=s_widget:GetChildAnchoredPosition(-1)
local d_widget=scrollerView:getChildScrollViewItemWidget(dIndex)
local d_pos=d_widget:GetChildAnchoredPosition(-1)
local resPosX=s_pos.x
s_pos.x=hideX
s_pos.y=d_pos.y

local func=function()
s_widget:SetChildAnchoredPosition(-1,s_pos)
s_widget:SetChildDOAnchorPosX(-1,resPosX,mTime,function()
if callback then
callback()
end
end)
end
s_widget:SetChildDOAnchorPosX(-1,s_pos.x,mTime,function()
scrollerView:setChildScrollViewChangeItemList(sIndex,dIndex,false)
local sIdx,eIdx
if sIndex<dIndex then
sIdx=sIndex
eIdx=dIndex-1
else
sIdx=dIndex+1
eIdx=sIndex
end
for i=sIdx,eIdx do
local tweener=scrollerView:setChildScrollViewMoveItemToIndexPos(i,mTime)
if i==eIdx then
tweener:OnComplete(func)
end
end
end)
end