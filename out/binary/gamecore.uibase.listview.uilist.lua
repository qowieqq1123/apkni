











UIList=simple_class(UIListBase)

local _table_insert=table.insert
local _table_remove=table.remove
local _math_floor=math.floor

function UIList:__init(parent_view,isDelayLoad,preFrameLoadCount,delayTime)
self.item_height=30
self.max_show_count=10

self.isDelayLoad=isDelayLoad
if self.isDelayLoad then

self.preFrameLoadCount=preFrameLoadCount
if self.preFrameLoadCount==nil then
self.preFrameLoadCount=1
end

self.delayTime=delayTime
if self.delayTime==nil then
self.delayTime=0.02
end

self.loadTimer=timer.new()
end
end

function UIList:__delete()
if self.loadTimer then
self.loadTimer:cancel()
self.loadTimer=nil
end
end

function UIList:GetItemHeight()
return self.item_height
end

function UIList:GetPrePostHeight(logic_index)
return self.item_margin_begin+(self.item_height+self.item_padding)*(logic_index-1),
self.item_margin_begin+(self.item_height+self.item_padding)*logic_index
end


function UIList:Init(handle_object,item_prefab,item_height)
UIList._base.Init(self,handle_object,item_prefab)

self.item_height=item_height



local view_size=self.scroll_rect.rect.size

if self.list_type==UIListType.Vertical then
self.max_show_count=math.ceil(view_size.y/(self.item_height+self.item_padding))
else
self.max_show_count=math.ceil(view_size.x/(self.item_height+self.item_padding))
end
self.max_show_count=self.max_show_count+1
end

function UIList:SetArrow(left_arrow,right_arrow)
self.left_arrow=left_arrow
self.right_arrow=right_arrow











self.left_arrow:SetActive(self.container.anchoredPosition.x<-10)
self.right_arrow:SetActive(self.container.anchoredPosition.x>self.scroll_rect.rect.width-self.container.rect.width+10)
end

























function UIList:ChangeData(handle_data)
self.data_list=handle_data
end

function UIList:SetData(handle_data)
self.data_list=handle_data

self:ClearData()

local need_count=#self.data_list
if need_count>self.max_show_count then
need_count=self.max_show_count
end

if self.isDelayLoad then
self.allQueueCount=need_count
need_count=1

if not self.loadTimer:isDead()then
self.loadTimer:cancel()
end
local invokeCount=(self.allQueueCount-1)/self.preFrameLoadCount+1
self.loadTimer:start(self.delayTime,objectHelper.packFunc(self,self.DoQueueSetData),invokeCount)
else
self:DoSetData(need_count)
end
end

function UIList:DoQueueSetData()
local doLoadCount=math.min(self.preFrameLoadCount,self.allQueueCount)
for i=1,doLoadCount do
self:DoSetData(1)
self:RefreshData()
self.allQueueCount=self.allQueueCount-1
end

if self.allQueueCount<=0 then
self.loadTimer:cancel()
end
end

function UIList:DoSetData(need_count)
if self.list_type==UIListType.Vertical then
self:SetVerticalData(need_count)
elseif self.list_type==UIListType.Horizontal then
self:SetHorizontalData(need_count)
end
end

function UIList:SetVerticalData(need_count)
local cur_pos_y=-self.item_margin_begin
for index=1,need_count do
local handle_item=self:CreateNewItem()
handle_item:SetActive(true)

handle_item:SetIndexInParent(#self.item_list+1)
handle_item:SetPosition(Vector2.New(self.item_margin_ex,cur_pos_y))
cur_pos_y=cur_pos_y-self.item_height-self.item_padding

_table_insert(self.item_list,handle_item)
end

local view_size=self.scroll_rect.rect.size
local canvas_height=(self.item_height+self.item_padding)*#self.data_list+self.item_margin_begin+self.item_margin_end
if canvas_height>view_size.y then
view_size.y=canvas_height
end

self.container.sizeDelta=Vector2.New(self.container.sizeDelta.x,view_size.y)
end

function UIList:SetHorizontalData(need_count)
local cur_pos_x=self.item_margin_begin
for index=1,need_count do
local handle_item=self:CreateNewItem()
handle_item:SetActive(true)
handle_item:SetIndexInParent(#self.item_list+1)
handle_item:SetPosition(Vector2.New(cur_pos_x,self.item_margin_ex))
cur_pos_x=cur_pos_x+self.item_height+self.item_padding

_table_insert(self.item_list,handle_item)
end

local view_size=self.scroll_rect.rect.size
local canvas_height=(self.item_height+self.item_padding)*#self.data_list+self.item_margin_begin+self.item_margin_end
if canvas_height>view_size.x then
view_size.x=canvas_height
end
self.container.sizeDelta=Vector2.New(view_size.x,self.container.sizeDelta.y)
end

function UIList:RefreshVerticalSize()
local view_size=self.scroll_rect.rect.size
local canvas_height=(self.item_height+self.item_padding)*#self.data_list+self.item_margin_begin+self.item_margin_end
if canvas_height>view_size.y then
view_size.y=canvas_height
end

self.container.sizeDelta=Vector2.New(self.container.sizeDelta.x,view_size.y)
end

function UIList:RefreshHorizontalSize()
local view_size=self.scroll_rect.rect.size
local canvas_height=(self.item_height+self.item_padding)*#self.data_list+self.item_margin_begin+self.item_margin_end
if canvas_height>view_size.x then
view_size.x=canvas_height
end
self.container.sizeDelta=Vector2.New(view_size.x,self.container.sizeDelta.y)
end

function UIList:ScrollToEnd()
self.scroll_view:StopMovement()

local view_size=self.scroll_rect.rect.size
local content_size=self.container.sizeDelta

local offset=0

if self.list_type==UIListType.Vertical then
if content_size.y>view_size.y then
offset=view_size.y-content_size.y
end

self.container.anchoredPosition=Vector2.New(0,-offset)
elseif self.list_type==UIListType.Horizontal then
if content_size.x>view_size.x then
offset=view_size.x-content_size.x
end

self.container.anchoredPosition=Vector2.New(-offset,0)
end
self:UpdateList(offset,true)
end

function UIList:RefreshData(pass_index,offset)
pass_index=pass_index or self.pass_index
offset=offset or 0

local need_count=#self.item_list
if need_count>self.max_show_count then
need_count=self.max_show_count
end

local index_start=1
local index_end=need_count
if offset~=0 and math.abs(offset)<need_count then
local is_dirty=false
if offset>0 then
for index=1,offset do
local handle_item=_table_remove(self.item_list,1)
_table_insert(self.item_list,handle_item)
is_dirty=true
end

index_start=need_count-offset
else
for index=1,-offset do
local handle_item=_table_remove(self.item_list)
_table_insert(self.item_list,1,handle_item)
is_dirty=true
end

index_end=-offset
end

if is_dirty then
for index,handle_item in ipairs(self.item_list)do
handle_item:SetLogicIndex(pass_index+index)
handle_item:SetIndexInParent(index)
end
end
end

for index=index_start,index_end do
if self.list_type==UIListType.Vertical then
self:VerticalRefreshHanleItemData(index,pass_index)
elseif self.list_type==UIListType.Horizontal then
self:HorizontalRefreshHanleItemData(index,pass_index)
end
end
end

function UIList:VerticalRefreshHanleItemData(index,pass_index)

local handle_item=self.item_list[index]

if handle_item==nil then
return
end

local pos_y=-(pass_index+index-1)*(self.item_height+self.item_padding)-self.item_margin_begin
handle_item:SetPosition(Vector2.New(self.item_margin_ex,pos_y))

local real_index=pass_index+index

if self.select_type==UIListSelectType.Single then
handle_item:SetSelected(self.sel_index==real_index)
else
handle_item:SetSelected(self.sel_list[real_index]or false)
end

local user_data=self.data_list[real_index]
handle_item:SetLogicIndex(real_index)
handle_item:RefreshDataInfo(user_data,real_index)
handle_item:RefreshState()
end

function UIList:HorizontalRefreshHanleItemData(index,pass_index)
local handle_item=self.item_list[index]

if handle_item==nil then return end

local pos_y=(pass_index+index-1)*(self.item_height+self.item_padding)+self.item_margin_begin
handle_item:SetPosition(Vector2.New(pos_y,self.item_margin_ex))

local real_index=pass_index+index
if self.select_type==UIListSelectType.Single then
handle_item:SetSelected(self.sel_index==real_index)
else
handle_item:SetSelected(self.sel_list[real_index]or false)
end

local user_data=self.data_list[real_index]
handle_item:SetLogicIndex(real_index)
handle_item:RefreshDataInfo(user_data)
handle_item:RefreshState()
end

function UIList:UpdateList(offset,force)
if self.list_type==UIListType.Vertical then
self:UpdateListVertical(offset,force)
elseif self.list_type==UIListType.Horizontal then
self:UpdateListHorizontal(offset,force)
end
end

function UIList:UpdateListVertical(offset,force)
local view_size=self.scroll_rect.rect.size
local container_size=self.container.sizeDelta

if(self.item_padding+self.item_height)*#self.item_list+self.item_margin_begin<view_size.y then
offset=0
if not force then
return
end
end

local need_show_height=#self.item_list*(self.item_height+self.item_padding)+self.item_margin_begin
if offset>=0 then
offset=0
elseif offset<need_show_height-container_size.y then
offset=need_show_height-container_size.y
end

local pass_index=math.floor(-offset/(self.item_height+self.item_padding))
if self.pass_index~=pass_index or force then
local index_offset=pass_index-self.pass_index
self.pass_index=pass_index
self:RefreshData(pass_index,force and 0 or index_offset)
end
end

function UIList:UpdateListHorizontal(offset,force)
local view_size=self.scroll_rect.rect.size
local container_size=self.container.sizeDelta

if(self.item_padding+self.item_height)*#self.item_list+self.item_margin_begin<view_size.x then
offset=0
if not force then
return
end
end

local need_show_height=#self.item_list*(self.item_height+self.item_padding)+self.item_margin_begin
local a=1
if offset<=0 then
offset=0
elseif offset>container_size.x-need_show_height then
offset=container_size.x-need_show_height
a=2
end

local pass_index=math.floor(offset/(self.item_height+self.item_padding))

if self.pass_index~=pass_index or force then
local index_offset=pass_index-self.pass_index
self.pass_index=pass_index
self:RefreshData(pass_index,force and 0 or index_offset)
end
end

function UIList:DoItemClickByIndex(logic_index,moveTo)
moveTo=moveTo or false

if moveTo==true then
self:MoveToIndex(logic_index)
end

if self.click_callback then
self.click_callback(logic_index)
end
local handle_index=logic_index-self.pass_index
self:HandleItemSelect(handle_index)
end

function UIList:GetIndexByPos(position,startIndex,endIndex)
if startIndex>=endIndex then
return startIndex
end

local middleIndex=_math_floor((startIndex+endIndex)/2)

local pre_height,post_height=self:GetPrePostHeight(middleIndex)
if post_height>=position then
return self:GetIndexByPos(position,startIndex,middleIndex)
else
return self:GetIndexByPos(position,middleIndex+1,endIndex)
end
end