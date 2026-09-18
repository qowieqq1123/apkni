











UIListItemDH=simple_class(UIListItem)

function UIListItemDH:__init(parent,parent_object,handle_prefab)

end

function UIListItemDH:GetItemHeight(user_data)
return 100
end





UIListDH=simple_class(UIListBase)

function UIListDH:__init(parent_view)
self.standard_item=nil
self.start_index=0
self.end_index=0

self.pre_height_set=false
end

function UIListDH:__delete()
self.standard_item:deleteSelf()
self.standard_item=nil
end

function UIListDH:GetStandardItem()
return self.standard_item
end

function UIListDH:Init(handle_object,item_prefab)
UIListDH._base.Init(self,handle_object,item_prefab)

self.standard_item=self:CreateNewItem()
self.standard_item:SetActive(false)
end

function UIListDH:SetData(handle_data,height_data)
self.data_list={}

local content_height=0
self.pre_height_set=false
for index,item_data in ipairs(handle_data)do
local list_item_data={}
list_item_data.src_data=item_data
list_item_data.item_height=height_data and height_data[index]or 0
content_height=content_height+list_item_data.item_height+self.item_padding
table.insert(self.data_list,list_item_data)
end

local container_size=self.container.sizeDelta
if height_data then
container_size.y=content_height>self.scroll_rect.rect.size.y and content_height or self.scroll_rect.rect.size.y
self.pre_height_set=true
else
container_size.y=self.scroll_rect.rect.size.y
end
self.container.sizeDelta=container_size

self:ClearData()
end

function UIListDH:GetContentHeight()
local accu_height=0
for index,list_item_data in ipairs(self.data_list)do
if list_item_data.item_height==0 then
self.standard_item:SetActive(true)
list_item_data.item_height=self.standard_item:GetItemHeight(list_item_data.src_data)
self.standard_item:SetActive(false)
end

accu_height=accu_height+list_item_data.item_height+self.item_padding
end
return accu_height
end

function UIListDH:ScrollToEnd()
self.scroll_view:StopMovement()

local accu_height=self:GetContentHeight()
local view_size=self.scroll_rect.rect.size
local offset=0
if accu_height>view_size.y then
offset=view_size.y-accu_height
end

self.container.anchoredPosition=Vector2.New(0,-offset)
self:UpdateList(offset,true)
end













function UIListDH:RefreshData(old_start_index,old_end_index,force)
if not old_start_index then
old_start_index=self.start_index
end
if not old_end_index then
old_end_index=self.end_index
end

local new_item_list={}
for _,view_item in ipairs(self.item_list)do
local logic_index=view_item:GetLogicIndex()
local remove=logic_index<self.start_index or logic_index>self.end_index
if remove or force then
view_item:SetActive(false)
table.insert(self.cache_list,view_item)
else
table.insert(new_item_list,view_item)
end
end

self.item_list=new_item_list

local update_start=0
local update_end=0

if not force then
if old_start_index<self.start_index or old_end_index<self.end_index then
update_start=old_end_index>self.start_index and old_end_index+1 or self.start_index
update_end=self.end_index
elseif old_start_index>self.start_index or old_end_index>self.end_index then
update_start=self.start_index
update_end=old_start_index<self.end_index and old_start_index-1 or self.end_index
end
else
update_start=self.start_index
update_end=self.end_index
end

local item_list_index=1

local cur_start=0
local cur_end=0
if#self.item_list~=0 then
cur_start=self.item_list[1]:GetLogicIndex()
cur_end=self.item_list[#self.item_list]:GetLogicIndex()
end

if update_start~=0 and update_end~=0 and update_start<=update_end then
local new_item_list={}

local accu_height=self.item_margin_begin
for handle_index,list_item_data in ipairs(self.data_list)do
if handle_index>=update_start and handle_index<=update_end then
local handle_item=self:CreateNewItem()
handle_item:SetActive(true)
handle_item:SetPosition(Vector2.New(0,-accu_height))

if self.select_type==UIListSelectType.Single then
handle_item:SetSelected(self.sel_index==handle_index)
else
handle_item:SetSelected(self.sel_list[handle_index]or false)
end

local list_item_data=self.data_list[handle_index]

handle_item:SetLogicIndex(handle_index)
handle_item:SetIndexInParent(#new_item_list+1)
table.insert(new_item_list,handle_item)

handle_item:RefreshDataInfo(list_item_data.src_data)
handle_item:RefreshState()

elseif handle_index>=cur_start and handle_index<=cur_end then
local handle_item=self.item_list[handle_index-cur_start+1]

handle_item:SetIndexInParent(#new_item_list+1)
table.insert(new_item_list,handle_item)
end

accu_height=accu_height+list_item_data.item_height+self.item_padding
end
self.item_list=new_item_list
end
end

function UIListDH:GetPrePostHeight(logic_index)

local accu_height=0
for index,list_item_data in ipairs(self.data_list)do
if list_item_data.item_height==0 then
self.standard_item:SetActive(true)
list_item_data.item_height=self.standard_item:GetItemHeight(list_item_data.src_data)
self.standard_item:SetActive(false)
end

if index==logic_index then
return accu_height,accu_height+list_item_data.item_height+self.item_padding
end

accu_height=accu_height+list_item_data.item_height+self.item_padding
end
return 0,0
end

function UIListDH:UpdateList(offset,force)
local view_size=self.scroll_rect.rect.size
offset=offset>0 and 0 or offset

local accu_height=self.item_margin_begin

local start_index=nil
local end_index=nil

for index,list_item_data in ipairs(self.data_list)do

if accu_height>=-offset and not start_index then
start_index=index-1
start_index=start_index<1 and 1 or start_index
end

if list_item_data.item_height==0 then
self.standard_item:SetActive(true)
list_item_data.item_height=self.standard_item:GetItemHeight(list_item_data.src_data)
self.standard_item:SetActive(false)
end

accu_height=accu_height+list_item_data.item_height+self.item_padding

if accu_height>-offset+view_size.y and not end_index then
end_index=index
break
end
end


if not start_index then
return
end

if not self.pre_height_set then
local container_size=self.container.sizeDelta
if container_size.y<accu_height then
container_size.y=accu_height
self.container.sizeDelta=container_size
end
end

if not end_index then
end_index=#self.data_list
end

if self.start_index~=start_index or self.end_index~=end_index or force then

local old_start_index=self.start_index
local old_end_index=self.end_index

self.start_index=start_index
self.end_index=end_index

self:RefreshData(old_start_index,old_end_index,force)
end

end

