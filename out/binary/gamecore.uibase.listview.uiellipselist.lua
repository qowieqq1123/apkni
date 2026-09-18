





UIEllipseList=simple_class()

local _helper=CS.UIHelper
local _pai=2

function UIEllipseList:__init(list)
if not list then
logErr("error not list>>>>>>>>>",list)
return
end

self.sel_index=-1
self.sel_item={}

self.view=list
self.view:IntializeEditor()


self.view.onScrollSelect:AddListener(objectHelper.packFunc(self,self.OnScrollSelect))


self.view.onDragBegin:AddListener(objectHelper.packFunc(self,self.OnDragBegin))
self.view.onDrag:AddListener(objectHelper.packFunc(self,self.OnDrag))
self.view.onDragEnd:AddListener(objectHelper.packFunc(self,self.OnDragEnd))
end

function UIEllipseList:__delete()
self.view=nil
self.sel_item=nil
end


function UIEllipseList:SetSelectCallback(cb)
self.select_callback=cb
end


function UIEllipseList:SetDragBeginCallback(cb)
self.drag_begin_callback=cb
end


function UIEllipseList:SetDraCallback(cb)
self.drag_callback=cb
end


function UIEllipseList:SetDragEndCallback(cb)
self.drag_end_callback=cb
end


function UIEllipseList:StartFlotage(string)
self.view:StartFlotage(string)
end


function UIEllipseList:CancelFlotage()
self.view:CancelFlotage()
end


function UIEllipseList:MakeSelectItem(find_str)
for i=1,self.view.m_CreateCount do
local obj=self:GetItemByIndex(i)
local img_sel=_helper.FindTransform(obj,find_str).gameObject
if img_sel then
self.sel_item[i]=img_sel
end
end
end


function UIEllipseList:SetTweenEndTime(value)
self.view:SetTweenEndTime(value)
end


function UIEllipseList:StopAutoMove()
self.view:StopAutoMove()
end


function UIEllipseList:JumpToIndex(index,no_sel)
if index<0 or index>self.view.m_CreateCount then return end

self.view:JumpToIndex(index)
if not no_sel then
self:SetSelected(index)
end
end


function UIEllipseList:ScrollToIndex(index,no_sel)
if index<0 or index>self.view.m_CreateCount then return end

self.view:ScrollToIndex(index)
if not no_sel then
self:SetSelected(index)
end
end


function UIEllipseList:GetItemByIndex(index)
return self.view:GetItemByIndex(index)
end


function UIEllipseList:GetItemCount()
return self.view.m_CreateCount
end


function UIEllipseList:SetItemCount(count)
if count<=0 then return end
self.view.m_CreateCount=count
self.view:IntializeEditor()
end


function UIEllipseList:OnDragBegin()
self:ClearSelected()

if self.drag_begin_callback then
self.drag_begin_callback()
end
end


function UIEllipseList:OnDrag()
if self.drag_callback then
self.drag_callback()
end
end


function UIEllipseList:OnDragEnd()
if self.drag_end_callback then
self.drag_end_callback()
end
end


function UIEllipseList:OnScrollSelect()
local w=_pai/self.view.m_CreateCount
local pos=self.view.m_Scroll_x%_pai

local index=math.ceil((_pai-pos+w/2)*self.view.m_CreateCount/_pai)

index=index>self.view.m_CreateCount and 1 or index

self:ScrollToIndex(index)
end


function UIEllipseList:SetSelected(index)
if index<0 or index>self.view.m_CreateCount then return end

self:ClearSelected()

self.sel_index=index

if self.sel_item[self.sel_index]then
self.sel_item[self.sel_index]:SetActive(true)
end

if self.select_callback then
self.select_callback(index)
end
end


function UIEllipseList:ClearSelected()
if self.sel_item[self.sel_index]then
self.sel_item[self.sel_index]:SetActive(false)
end
self.sel_index=-1
end