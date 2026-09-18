


UIListRing=simple_class(UIList)

local _helper=CS.UIHelper

function UIListRing:__init()
self.old_list={}
self.old_sel=nil
self.hou_list=nil

self:SetDragStartCallback(objectHelper.packFunc(self,self.DragToBegin))
self:SetDragUpdateCallback(objectHelper.packFunc(self,self.DragToMoved))
self:SetDragEndCallback(objectHelper.packFunc(self,self.DragToEnded))
end

function UIListRing:__delete()
self:clearSelTimer()
end


function UIListRing:clearSelTimer()
if self.selTimer then
self.selTimer:cancel()
end
self.selTimer=nil
end


function UIListRing:MarkListData(handle_data)
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

function UIListRing:SetData(handle_data)
self:RefreshHouList(handle_data)

local new_data=self:MarkListData(handle_data)
UIListRing._base.SetData(self,new_data)
self:UpdateItemPosition()
end

function UIListRing:ChangeData(handle_data)
self:RefreshHouList(handle_data)

local new_data=self:MarkListData(handle_data)
UIListRing._base.ChangeData(self,new_data)
self:UpdateItemPosition()
end

function UIListRing:SetSelected(select_data)
self.old_sel=select_data

local index=select_data+2
if select_data>#self.old_list then
local index=#self.old_list
end
UIList.SetSelected(self,index)
end

function UIListRing:DragToBegin()
self:clearSelTimer()
if self.tweener then
Lua.DOTweenProxyExtensions.DOKill(self.container)
end

self:SetSelected(-99)
end

function UIListRing:DragToMoved()
self:UpdateItemPosition()
end

function UIListRing:DragToEnded()




self:clearSelTimer()
self.selTimer=timer.new()
self.selTimer:start(0.5,function()
self:ScrollEndedSelect()
end,1)
end

function UIListRing:UpdateItemPosition()
local pos=self:GetContentPos()
local w=self:GetRectSize()

if self.hou_list then
local len=self.hou_list:GetContainerSize()
local hw=self.hou_list:GetRectSize()
self.hou_list:SetContentPos(hw-len-pos)
self.hou_list:UpdateItemPosition()
end

for _,item in ipairs(self.item_list)do
local ball=_helper.FindTransform(item.root_wnd,"ball")
local i=item.logic_index
local ix=item.root_rect.anchoredPosition.x+self.item_height/2

local r=w/2
local ty=r
local u=math.abs(ix-(-pos+w/2))


ty=math.sqrt(math.pow(r,2)-math.pow(u,2))




ball.anchoredPosition=Vector2.New(0,-ty*0.6)

local s=0.8
if u<r then
s=0.8+(1-u/r)*0.2
end
ball.localScale=Vector2.New(s,s)
end
end

function UIListRing:ScrollEndedSelect()
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

function UIListRing:ScrollToLogicIndex(index)
if index<=2 or index>#self.old_list+2 then return end

self:SetSelected(index-2)

local target_pos=-(index-3)*(self.item_height+self.item_padding)
self:StartTween(target_pos)

if self.select_callback then
self.select_callback(index-2)
end
end

function UIListRing:GetContainerSize()
local size=0
if self.list_type==UIListType.Vertical then
size=self.container.sizeDelta.y
elseif self.list_type==UIListType.Horizontal then
size=self.container.sizeDelta.x
end

return size
end





function UIListRing:SetHouList(wlist,wcell,wclass)
if not self.hou_list then
self.hou_list=UIListRingH(self.parent_view)
self.hou_list:SetListType(UIListType.Horizontal)
self.hou_list:SetItemClass(wclass)
self.hou_list:SetItemPadding(self.item_padding)


self.hou_list:Init(wlist,wcell,self.item_height)
end
end

function UIListRing:RefreshHouList(data)
if not self.hou_list then return end

self.hou_data={}
for i=#data,1,-1 do
table.insert(self.hou_data,clone(data[i]))
end
for i=1,#data/2 do
local t=clone(self.hou_data[i])
self.hou_data[i]=clone(self.hou_data[i+#data/2])
self.hou_data[i+#data/2]=t
end
self.hou_list:SetData(self.hou_data)
self.hou_list:RefreshData()
end

function UIListRing:ScrollToBegin()
UIListRing._base.ScrollToBegin(self)
self:UpdateItemPosition()
end
