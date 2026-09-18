


UIListRingH=simple_class(UIList)

local _helper=CS.UIHelper

function UIListRingH:__init()
self.old_list={}
self.old_sel=nil

self:SetDragStartCallback(objectHelper.packFunc(self,self.DragToBegin))
self:SetDragUpdateCallback(objectHelper.packFunc(self,self.DragToMoved))
self:SetDragEndCallback(objectHelper.packFunc(self,self.DragToEnded))
end

function UIListRingH:__delete()
self:clearSelTimer()
end


function UIListRingH:clearSelTimer()
if self.selTimer then
self.selTimer:cancel()
end
self.selTimer=nil
end


function UIListRingH:MarkListData(handle_data)
self.old_list=handle_data
if#handle_data<5 then return handle_data end

local new_data={handle_data[#handle_data-1],handle_data[#handle_data]}
for k,v in ipairs(handle_data)do
table.insert(new_data,clone(v))
end
table.insert(new_data,handle_data[1])
table.insert(new_data,handle_data[2])
return new_data
end

function UIListRingH:SetData(handle_data)
local new_data=self:MarkListData(handle_data)
UIListRingH._base.SetData(self,new_data)
self:UpdateItemPosition()
end

function UIListRingH:ChangeData(handle_data)
local new_data=self:MarkListData(handle_data)
UIListRingH._base.ChangeData(self,new_data)
self:UpdateItemPosition()
end

function UIListRingH:SetSelected(select_data)
self.old_sel=select_data

local index=select_data+2
if select_data>#self.old_list then
local index=#self.old_list
end
UIList.SetSelected(self,index)
end

function UIListRingH:DragToBegin()
self:clearSelTimer()
if self.tweener then
Lua.DOTweenProxyExtensions.DOKill(self.container)
end

self:SetSelected(-99)
end

function UIListRingH:DragToMoved()
self:UpdateItemPosition()
end

function UIListRingH:DragToEnded()









end

function UIListRingH:UpdateItemPosition()
local pos=self:GetContentPos()
local w=self:GetRectSize()


for _,item in ipairs(self.item_list)do
local ball=_helper.FindTransform(item.root_wnd,"ball")
local i=item.logic_index
local ix=item.root_rect.anchoredPosition.x+self.item_height/2

local r=w/2
local ty=-r
local u=math.abs(ix-(-pos+w/2))


ty=math.sqrt(math.pow(r,2)-math.pow(u,2))




ball.anchoredPosition=Vector2.New(self.item_padding,ty*0.5+250)

local s=0.7
if u<r then
s=0.7-(1-u/r)*0.2
end
ball.localScale=Vector2.New(s,s)
end
end

function UIListRingH:ScrollEndedSelect()
local pos=self:GetContentPos()
local w=self:GetRectSize()
local len=self:GetContainerSize()

local index=math.floor((math.abs(pos)-(self.item_height+self.item_padding)/2)/(self.item_height+self.item_padding))
if pos>0 then
index=1-2
end
if pos<-(len-w)then
index=#self.old_list-2
end

self:SetSelected(index+2)

local target_pos=-(index+1)*(self.item_height+self.item_padding)
self:StartTween(target_pos)

if self.select_callback then
self.select_callback(index+2)
end
end














function UIListRingH:GetContainerSize()
local size=0
if self.list_type==UIListType.Vertical then
size=self.container.sizeDelta.y
elseif self.list_type==UIListType.Horizontal then
size=self.container.sizeDelta.x
end

return size
end

function UIListRingH:HandleItemSelect(handle_index)
logErr("*********************",handle_index)
end
