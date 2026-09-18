

UIListPage=simple_class(UIList)

local snapWatchOffset=0.5
local _snapJumping=false
local _math_floor=math.floor
local _mathf_clamp=Mathf.Clamp

function UIListPage:__init()
self:SetDragEndCallback(objectHelper.packFunc(self,self.Snap))
end

function UIListPage:Snap(index)
local size=self:GetRectSize()
local ScrollPosition=self:GetContentPos()

local snapPosition=ScrollPosition+(size*snapWatchOffset)
index=index or self:GetIndexByPos(snapPosition,1,#self.data_list)
if self.LimitRange and#self.LimitRange>=2 then
index=_mathf_clamp(index,self.LimitRange[1],self.LimitRange[2])
end


self:MoveToIndex(index,-(size*snapWatchOffset)+_math_floor(self.item_height/2))
if self.selectCallback then
self.selectCallback(index)
end
end

function UIListPage:SetSelectPageCallback(callback)
self.selectCallback=callback
end

function UIListPage:SetSelectedSnap(index)
UIListPage._base.SetSelected(self,index)
self:Snap(index)
end

function UIListPage:SetLimitRange(data)
self.LimitRange=data
end
