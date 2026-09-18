






UIListSelectType={
Single=1,
Muti=2,
}

UIListClickType={
None=1,
Smooth=2,
Immediat=3,
}

UIListType={
Vertical=1,
Horizontal=2,
}





UIListBase=simple_class()

function UIListBase:__init(parent_view)
self.parent_view=parent_view
self.handle_object=nil
self.item_prefab=nil

self.scroll_view=nil
self.scroll_rect=nil
self.container=nil

self.click_type=UIListClickType.None
self.click_callback=nil
self.click_tween=nil


self.item_class=nil
self.item_list={}
self.cache_list={}

self.data_list={}

self.item_margin_begin=0

self.item_padding=8
self.item_margin_end=0

self.item_margin_ex=0

self.select_type=UIListSelectType.Single
self.can_select_fun=nil
self.select_callback=nil
self.sel_index=-1
self.sel_list={}

self.cache_pos=0
self.pass_index=0

self.update_event_handle=nil
self.is_dragging=false

self.drag_start_callback=nil
self.drag_update_callback=nil
self.drag_end_callback=nil

self.upper_trigger_callback=nil
self.down_trigger_callback=nil
self.trigger_value=100
self.trigger_up=false
self.trigger_down=false

self.tween_end_time=0.3

self.list_type=UIListType.Vertical

self.left_arrow=nil
self.right_arrow=nil

self.jumpMoveSmooth=false

self.checkTimer=timer.new()


end








function UIListBase:SetUpperTriggerCallback(callback)
self.upper_trigger_callback=callback
end

function UIListBase:SetDownTriggerCallback(callback)
self.down_trigger_callback=callback
end

function UIListBase:SetDragStartCallback(callback)
self.drag_start_callback=callback
end

function UIListBase:SetDragUpdateCallback(callback)
self.drag_update_callback=callback
end

function UIListBase:SetDragEndCallback(callback)
self.drag_end_callback=callback
end

function UIListBase:GetParentView()
return self.parent_view
end

function UIListBase:GetSelectIndex()
return self.select_type==UIListSelectType.Single and self.sel_index or self.sel_list
end

function UIListBase:SetSelected(select_data)
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

function UIListBase:ClearSelected()
for index,handle_item in ipairs(self.item_list)do
handle_item:SetSelected(false)
end

self.sel_index=-1
self.sel_list={}
end

function UIListBase:SetSelectType(handle_type)
self.select_type=handle_type
end

function UIListBase:SetSelectCallback(callback)
self.select_callback=callback
end

function UIListBase:SetSelectConditionFunc(callback)
self.can_select_fun=callback
end

function UIListBase:SetClickType(handle_type)
self.click_type=handle_type
end

function UIListBase:SetClickCallback(callback)
self.click_callback=callback
end

function UIListBase:SetItemClass(item_class)
self.item_class=item_class
end

function UIListBase:SetItemPadding(value)
self.item_padding=value
end

function UIListBase:GetItemPadding()
return self.item_padding
end

function UIListBase:SetItemMarginBegin(value)
self.item_margin_begin=value
end

function UIListBase:SetItemMarginEnd(value)
self.item_margin_end=value
end

function UIListBase:SetItemMarginEx(value)
self.item_margin_ex=value
end

function UIListBase:GetItemMargin()
return self.item_margin_begin
end

function UIListBase:GetItemMarginEnd()
return self.item_margin_end
end

function UIListBase:GetScrollRect()
return self.scroll_view
end

function UIListBase:GetItemList()
return self.item_list
end

function UIListBase:SetTweenEndTime(value)
self.tween_end_time=value
end

function UIListBase:SetListType(value)

self.list_type=value
end

function UIListBase:SetJumpMoveSmooth(value)
self.jumpMoveSmooth=value
end

function UIListBase:SetJumpMoveCallback(callback)
self.JumpMoveCallback=callback
end

function UIListBase:Init(handle_object,item_prefab)
self.handle_object=handle_object
self.item_prefab=item_prefab

self.scroll_view=ComponentHelper.GetComponent(self.handle_object,UI.ScrollRect)
self.scroll_rect=ComponentHelper.GetComponent(self.handle_object,RectTransform)
self.container=self.scroll_view.content
self.cache_inertia=self.scroll_view.inertia

local event_listener=BlockEventListener.Get(self.handle_object)
event_listener:BindBeginDrag(function(position,delta)
self.trigger_up=false
self.trigger_down=false

if self.checkTimer:isDead()then



self.checkTimer:start(0.01,objectHelper.packFunc(self,self.OnDragUpdating))
end


self.is_dragging=true

self.cache_pos=self:GetContentPos()

if self.drag_start_callback then
self.drag_start_callback()
end

if self.click_tween then
self.click_tween:Kill(false)
self.click_tween=nil
end
self.scroll_view.inertia=self.cache_inertia
end)

event_listener:BindEndDrag(function(position,delta)
self.is_dragging=false

if self.trigger_up and self.upper_trigger_callback then
self.upper_trigger_callback()
end
if self.trigger_down and self.down_trigger_callback then
self.down_trigger_callback()
end

if self.drag_end_callback then
self.drag_end_callback()
end
end)













end

function UIListBase:ClearData()
for _,handle_item in pairs(self.item_list)do
if handle_item then
handle_item:SetActive(false)
table.insert(self.cache_list,handle_item)
end
end
self.item_list={}
end

function UIListBase:SetData(handle_data)

end

function UIListBase:RefreshData()

end

function UIListBase:CreateNewItem()
local new_item=nil

if#self.cache_list~=0 then
new_item=table.remove(self.cache_list)
else
new_item=self.item_class.New(self,self.container.gameObject,self.item_prefab)
end

return new_item
end

function UIListBase:HandleItemClick(handle_index)
local logic_index=handle_index+self.pass_index



if self.click_callback then
self.click_callback(logic_index)
end

self:HandleItemSelect(handle_index)
end

function UIListBase:HandleItemSelect(handle_index)
local logic_index=handle_index+self.pass_index

local handle_item=self.item_list[handle_index]
if self.select_type==UIListSelectType.Single then
if self.sel_index==logic_index then
return
end

if self.can_select_fun and not self.can_select_fun(logic_index)then
return
end

for index,item_view in ipairs(self.item_list)do
if index~=handle_index then
item_view:SetSelected(false)
end
end

if handle_item then
handle_item:SetSelected(true)
end
else

if not self.sel_list[logic_index]then
if self.can_select_fun and not self.can_select_fun(logic_index)then
return
end
end

self.sel_list[logic_index]=not self.sel_list[logic_index]

if handle_item then
handle_item:SetSelected(self.sel_list[logic_index]or false)
end
end

self.sel_index=logic_index

if self.select_callback then
self.select_callback(logic_index)
end
end

function UIListBase:GetPrePostHeight(logic_index)
return 0,0
end

function UIListBase:HandleClickMove(logic_index,ext_type)
local click_type=ext_type or self.click_type
if self.click_type==UIListClickType.None then
return
end

local pre_height,post_height=self:GetPrePostHeight(logic_index)

local cur_pos=self:GetContentPos()
local view_size=self.scroll_rect and self.scroll_rect.rect.size or{x=0,y=0}

local target_pos=nil

if self.list_type==UIListType.Vertical then
if cur_pos>pre_height and cur_pos<post_height then
target_pos=pre_height
elseif cur_pos+view_size.y>pre_height and cur_pos+view_size.y<post_height then
target_pos=post_height-view_size.y
end
elseif self.list_type==UIListType.Horizontal then
if-cur_pos>pre_height and-cur_pos<post_height then
target_pos=-pre_height
elseif-cur_pos+view_size.x>pre_height and-cur_pos+view_size.x<post_height then
target_pos=view_size.x-post_height
end
end

if not target_pos then
return
end

if click_type==UIListClickType.Immediat then
self:SetContentPos(target_pos)
elseif click_type==UIListClickType.Smooth then
self:StartTween(target_pos)
end
end

function UIListBase:MoveToIndex(handle_index,offset)
local logic_index=handle_index
local post_height,_=self:GetPrePostHeight(logic_index)
post_height=self.list_type==UIListType.Vertical and post_height or-post_height
post_height=post_height+(offset or 0)
self:SetContentPos(post_height)
end

function UIListBase:StartTween(target_pos)
if self.tweener then
Lua.DOTweenProxyExtensions.DOKill(self.container)
end

self.scroll_view.inertia=false
self.scroll_view:StopMovement()



if self.list_type==UIListType.Vertical then

self.tweener=Lua.DOTweenProxyExtensions.DOAnchorPosY(self.container,target_pos,self.tween_end_time)
elseif self.list_type==UIListType.Horizontal then

self.tweener=Lua.DOTweenProxyExtensions.DOAnchorPosX(self.container,target_pos,self.tween_end_time)
end

if self.checkTimer:isDead()then
self.checkTimer:start(0.01,objectHelper.packFunc(self,self.OnDragUpdating))
end

self.tweener:OnComplete(function()
self.tweener=nil

self.scroll_view.inertia=self.cache_inertia
if self.JumpMoveCallback then
self.JumpMoveCallback()
end

if not self.checkTimer:isDead()then
self.checkTimer:cancel()
end
end)

if not self.update_event_handle then



end
end

function UIListBase:ScrollToBegin()
self.scroll_view:StopMovement()
self.container.anchoredPosition=Vector2.zero
self:UpdateList(0,true)
end

function UIListBase:ScrollToEnd()

end

function UIListBase:GetContentPos()
local cur_pos
if self.list_type==UIListType.Vertical then
cur_pos=self.container.anchoredPosition.y
elseif self.list_type==UIListType.Horizontal then
cur_pos=self.container.anchoredPosition.x
end

return cur_pos
end

function UIListBase:SetContentPos(value)
self.scroll_view:StopMovement()

if self.jumpMoveSmooth then
self:StartTween(value)
else
if self.list_type==UIListType.Vertical then
self.container.anchoredPosition=Vector2.New(self.container.anchoredPosition.x,value)
elseif self.list_type==UIListType.Horizontal then
self.container.anchoredPosition=Vector2.New(value,self.container.anchoredPosition.y)
end
end
self:UpdateList(-value,true)
end

function UIListBase:UpdateList(offset,force)

end

function UIListBase:OnDragUpdating()
if objectHelper.isNil(self.handle_object)then
if not self.checkTimer:isDead()then


self.checkTimer:cancel()
end
return
end

local cur_pos=self:GetContentPos()
if cur_pos<-self.trigger_value then
self.trigger_up=true
elseif cur_pos>self.container.sizeDelta.y-self.scroll_rect.rect.size.y+self.trigger_value then
self.trigger_down=true
end

local offset=-cur_pos
self:UpdateList(offset,false)

if self.drag_update_callback then
self.drag_update_callback()
end

if not self.is_dragging then
if math.abs(self.cache_pos-cur_pos)<0.05 then
if not self.checkTimer:isDead()then

self.checkTimer:cancel()



end

end
self.cache_pos=cur_pos
end

if self.left_arrow then
self.left_arrow:SetActive(self.container.anchoredPosition.x<-10)
end

if self.right_arrow then
self.right_arrow:SetActive(self.container.anchoredPosition.x>self.scroll_rect.rect.width-self.container.rect.width+10)
end
end

function UIListBase:GetRectSize()
local size=0
if self.list_type==UIListType.Vertical then
size=self.scroll_rect.sizeDelta.y
elseif self.list_type==UIListType.Horizontal then
size=self.scroll_rect.sizeDelta.x
end

return size
end

function UIListBase:__delete()

for index,handle_item in ipairs(self.item_list)do
handle_item:deleteSelf()
handle_item=nil
end

for index,handle_item in ipairs(self.cache_list)do
handle_item:deleteSelf()
handle_item=nil
end

self.parent_view=nil
self.handle_object=nil
self.item_prefab=nil

self.scroll_view=nil
self.scroll_rect=nil
self.container=nil

self.click_type=nil
self.click_callback=nil
self.click_tween=nil

self.item_class=nil
self.item_list={}
self.cache_list={}

self.data_list={}

self.item_margin_begin=0
self.item_padding=2
self.item_margin_end=0

self.select_type=nil
self.can_select_fun=nil
self.select_callback=nil
self.sel_index=-1
self.sel_list={}

self.cache_pos=0
self.pass_index=0

self.update_event_handle=nil
self.is_dragging=false

self.drag_start_callback=nil
self.drag_update_callback=nil
self.drag_end_callback=nil

self.tween_end_time=0.3

self.list_type=nil

if self.checkTimer then
self.checkTimer:cancel()
end
end
