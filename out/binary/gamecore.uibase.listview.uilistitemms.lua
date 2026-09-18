












UIListItemMS=simple_class()

local _table_insert=table.insert
local _table_remove=table.remove
local _TOSTRING=tostring

function UIListItemMS:__init(parent_line,root_wnd,line_index)
self.parent_line=parent_line
self.line_index=line_index

self.is_select=false
self.multSelect={}

self.root_wnd=root_wnd
self.root_rect=ComponentHelper.GetComponent(self.root_wnd,RectTransform)
self.is_used=false

self.root_wnd.name="ItemMS_".._TOSTRING(line_index)

local event_listener=NonBlockEventListener.Get(self.root_wnd)
event_listener:BindPointerClick(function(position,delta)
self.parent_line.parent:HandleItemClick(self.parent_line:GetIndexInParent(),self.line_index)
end)
end

function UIListItemMS:GetWnd()
return self.root_wnd
end

function UIListItemMS:SetUsed(value)
self.is_used=value
self.root_wnd:SetActive(value)
end

function UIListItemMS:IsUsed()
return self.is_used
end

function UIListItemMS:GetChild(name)


local root_wnd_trans=self.root_wnd.transform
local itemChild=root_wnd_trans:Find(_TOSTRING(self.line_index)..name).gameObject
return itemChild
end

function UIListItemMS:SetSelected(logic_index)
local listMsparent=self.parent_line.parent
local main_index=self.parent_line:GetIndexInParent()
local sub_index=self.line_index
local pass_index=listMsparent.pass_index

self.readIndex=(main_index+pass_index-1)*listMsparent.line_count+sub_index
self.is_select=logic_index==self.readIndex and true or false

self.multSelect[self.readIndex]=listMsparent.sel_list[self.readIndex]

self:RefreshState()
end

function UIListItemMS:__delete()
end

function UIListItemMS:RefreshState()

end

function UIListItemMS:ClearSelected()

end

function UIListItemMS:RefreshDataInfo(cur_data)

end

function UIListItemMS:GetLogicIndex()
return self.readIndex
end





UIListItemMSLine=simple_class(UIListItem)

function UIListItemMSLine:__init(parent,parent_object,handle_prefab)
self.item_list={}

local item_class=self.parent:GetItemClass()
local line_count=self.parent:GetLineCount()
for index=1,line_count do
local root_wnd_trans=self.root_wnd.transform
local item_wnd=root_wnd_trans:Find(_TOSTRING(index)).gameObject
local handle_item=item_class.New(self,item_wnd,index)
_table_insert(self.item_list,handle_item)
end

self.line_data=nil
end

function UIListItemMSLine:__delete()
for k,handle_item in pairs(self.item_list)do
if handle_item then
handle_item:deleteSelf()
end
end
self.item_list={}
end

function UIListItemMSLine:GetItemList()
return self.item_list
end

function UIListItemMSLine:GetItem(index)
return self.item_list[index]
end

function UIListItemMSLine:BindClickEvent()

end

function UIListItemMSLine:RefreshState()
local line_count=self.parent:GetLineCount()
local logic_index=self.parent.sel_index
for index=1,line_count do
self.item_list[index]:SetSelected(logic_index)
end
end

function UIListItemMSLine:ClearSelected()
local line_count=self.parent:GetLineCount()
local logic_index=self.parent.sel_index
for index=1,line_count do
self.item_list[index]:ClearSelected()
end
end


function UIListItemMSLine:RefreshDataInfo(cur_data)
self.line_data=cur_data

local line_count=self.parent:GetLineCount()
local data
for index=1,line_count do
data=self.line_data and self.line_data[index]or nil
self.item_list[index]:RefreshDataInfo(data)
end
end

function UIListItemMSLine:UpdateItemTime()
local line_count=self.parent:GetLineCount()
for index=1,line_count do
self.item_list[index]:UpdateItemTime()
end
end

function UIListItemMSLine:SetIndexInParent(index)
self.index_in_parent=index
self.root_wnd.name="MSLine_".._TOSTRING(index)
end






UIListMS=simple_class(UIList)

function UIListMS:__init(parent_view)
self.line_count=1

self.item_class=UIListItemMSLine
self.item_sub_class=UIListItemMS
self.select_type=UIListSelectType.Muti

self.raw_data={}
end

function UIListMS:Init(handle_object,item_prefab,item_height,line_count)
UIListMS._base.Init(self,handle_object,item_prefab,item_height)

self.line_count=line_count
end

function UIListMS:SetItemClass(item_sub_class)
self.item_sub_class=item_sub_class
end

function UIListMS:GetItemClass()
return self.item_sub_class
end

function UIListMS:GetLineCount()
return self.line_count
end

function UIListMS:ClearData()
UIListMS._base.ClearData(self)

self.raw_data={}
end

function UIListMS:ChangeData(handle_data)
local ui_data=self:DataAdaptive(handle_data)

UIListMS._base.ChangeData(self,ui_data)
end

function UIListMS:SetData(handle_data)
local ui_data=self:DataAdaptive(handle_data)

UIListMS._base.SetData(self,ui_data)
end

function UIListMS:DataAdaptive(handle_data)
self.raw_data=handle_data

local ui_data={}

local data_count=#handle_data
local item_count=math.ceil(data_count/self.line_count)
for index=1,item_count do
local item_data_list={}
for sub_index=1,self.line_count do
local cur_index=(index-1)*self.line_count+sub_index
if cur_index<=data_count then
_table_insert(item_data_list,handle_data[cur_index])
end
end
_table_insert(ui_data,item_data_list)
end

return ui_data
end

function UIListMS:SetSelected(select_data)
self:ClearSelected()

if self.select_type==UIListSelectType.Single then
self.sel_index=select_data
else
for _,handle_index in pairs(select_data)do
self.sel_list[handle_index]=true
end
end

self:RefreshData()
end

function UIListMS:ClearSelected()
self.sel_list={}
self.sel_index=-1

end

function UIListMS:HandleItemClick(main_index,sub_index)
local logic_index=(main_index+self.pass_index-1)*self.line_count+sub_index

self:HandleClickMove(main_index+self.pass_index)

if self.click_callback then
self.click_callback(logic_index)
end

self:HandleItemSelect(main_index,sub_index)
end

function UIListMS:HandleItemSelect(main_index,sub_index)
local logic_index=(main_index+self.pass_index-1)*self.line_count+sub_index

if self.select_type==UIListSelectType.Single then
if self.sel_index==logic_index then
return
end
self.sel_index=logic_index

for _,itemMSLine in pairs(self.item_list)do
itemMSLine:RefreshState(logic_index)
end
else

if not self.sel_list[logic_index]then
if self.can_select_fun and not self.can_select_fun(logic_index)then
return
end
end

if self.sel_list[logic_index]then
self.sel_list[logic_index]=nil
else
self.sel_list[logic_index]=true
end

self.sel_index=logic_index

for _,itemMSLine in pairs(self.item_list)do
itemMSLine:RefreshState()
end


end

if self.select_callback then
self.select_callback(logic_index)
end
end

function UIListMS:RefreshItem(index,handle_data)
if handle_data then
self:ChangeData(handle_data)
end
for _,lineMS in pairs(self.item_list)do
for _,Item in pairs(lineMS:GetItemList())do
if Item:GetLogicIndex()==index then
Item:RefreshDataInfo(self.raw_data[index])
end
end
end
end

function UIListMS:CancelSelected()
self:ClearSelected()
if self.item_list~=nil and self.item_list~={}then
for _,lineMS in pairs(self.item_list)do
if lineMS:ClearSelected()then
lineMS:ClearSelected()
end
end
end
end


function UIListMS:RefreshAllItem(handle_data)
if handle_data then
self:ChangeData(handle_data)
end
local index=1
for _,lineMS in pairs(self.item_list)do
for _,Item in pairs(lineMS:GetItemList())do
index=Item:GetLogicIndex()
Item:RefreshDataInfo(self.raw_data[index])
end
end

if self.list_type==UIListType.Vertical then
self:RefreshVerticalSize()
elseif self.list_type==UIListType.Horizontal then
self:RefreshHorizontalSize()
end
end

function UIListMS:MoveToIndexMS(logic_index,offset)
local index=math.ceil(logic_index/self.line_count)
self:MoveToIndex(index,offset)
end
