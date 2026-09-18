












UIListItem=simple_class()

local _TOSTRING=tostring
local _helper=CS.UIHelper

function UIListItem:__init(parent,parent_object,handle_prefab)
self.parent=parent
self.parent_object=parent_object
self.handle_prefab=handle_prefab

self.logic_index=0
self.index_in_parent=0
self.user_data=nil

self.pointer_down_callback=nil
self.pointer_up_callback=nil
self.pointer_exit_callback=nil




self.root_wnd=GameObject.Instantiate(handle_prefab)
self.root_rect=ComponentHelper.GetComponent(self.root_wnd,RectTransform)
EngineTools.AddChildUI(parent_object,self.root_wnd)

self.winlua=_helper.GetWindowLua(self.root_wnd)

self.rootCurrentActive=self.root_wnd.activeSelf







self:BindClickEvent()
self:BindPointerDownEvent()
self:BindPointerUpEvent()
self:BindPointerExitEvent()
end

function UIListItem:BindClickEvent()
local event_listener=NonBlockEventListener.Get(self.root_wnd)
event_listener:BindPointerClick(function(position,delta)
self.parent:HandleItemClick(self.index_in_parent)
end)
end

function UIListItem:BindPointerDownEvent()
local event_listener=NonBlockEventListener.Get(self.root_wnd)
event_listener:BindPointerDown(function(position,delta)
if self.pointer_down_callback then
self.pointer_down_callback(self.index_in_parent)
end
end)
end

function UIListItem:BindPointerUpEvent()
local event_listener=NonBlockEventListener.Get(self.root_wnd)
event_listener:BindPointerUp(function(position,delta)
if self.pointer_up_callback then
self.pointer_up_callback(self.index_in_parent)
end
end)
end

function UIListItem:BindPointerExitEvent()
local event_listener=NonBlockEventListener.Get(self.root_wnd)
event_listener:BindPointerExit(function(position,delta)
if self.pointer_exit_callback then
self.pointer_exit_callback(self.index_in_parent)
end
end)
end

function UIListItem:SetPointDownCallback(callback)
self.pointer_down_callback=callback
end

function UIListItem:SetPointUpCallback(callback)
self.pointer_up_callback=callback
end

function UIListItem:SetPointExitCallback(callback)
self.pointer_exit_callback=callback
end

function UIListItem:GetParent()
return self.parent
end

function UIListItem:GetRootObject()
return self.root_wnd
end

function UIListItem:GetRootRect()
return self.root_rect
end

function UIListItem:GetWidgetTable()
return self.widget_table
end

function UIListItem:SetIndexInParent(index)
self.index_in_parent=index
if self.root_wnd==nil then
return;
end
self.root_wnd.name="Item_".._TOSTRING(index)

end

function UIListItem:GetIndexInParent()
return self.index_in_parent
end

function UIListItem:SetLogicIndex(value)
self.logic_index=value
end

function UIListItem:GetLogicIndex()
return self.logic_index
end

function UIListItem:SetActive(value)


if self.rootCurrentActive~=value then
self.rootCurrentActive=value
self.root_wnd:SetActive(value)
end
end

function UIListItem:SetPosition(value)
self.root_rect.anchoredPosition=value
end

function UIListItem:IsSelect()
return self.is_select
end

function UIListItem:SetSelected(value)
self.is_select=value
self:RefreshState()
end

function UIListItem:SetUserData(value)
self.user_data=value
end

function UIListItem:GetUserData()
return self.user_data
end

function UIListItem:RefreshState()

end

function UIListItem:RefreshDataInfo(cur_data)

end

function UIListItem:__delete()


self.parent_object=nil
self.handle_prefab=nil
self.root_wnd=nil
self.root_rect=nil

self.rootCurrentActive=nil
end
