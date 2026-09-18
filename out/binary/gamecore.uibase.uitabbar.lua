










UITabBar=simple_class()

function UITabBar:__init(tab_list,callback,disable_callback)
self.tab_list=tab_list
self.callback=callback
self.disable_callback=disable_callback

self.state_lock=false
self.select_index=0
self.toggles=ComponentHelper.GetComponentsInChildren(self.tab_list,UI.Toggle)
self.toggles_text={}
self.toggles_shadow={}
self.toggles_state={}
self.toggles_image={}
self.toggles_list={}

otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
local toggle_chg=function(value)
if not value or self.state_lock then return end

self:UpdateSelected(index)
AudioManager.playBtnClick()
end

handle_toggle.onValueChanged:AddListener(toggle_chg)
self.toggles_state[index]=true
if not self.toggles_list[index]then
self.toggles_list[index]=handle_toggle
end
end)
end

function UITabBar:SetDoAction()
otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
local touch=ComponentHelper.AddComponent(handle_toggle.gameObject,CS.TouchEvent)
touch.doAction=true
end)
end

function UITabBar:__delete()
self.tab_list=nil

otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
handle_toggle=nil
end)

self.toggles=nil

self.toggles_text={}
self.toggles_shadow={}
self.toggles_state={}

for _,handle_image in pairs(self.toggles_image)do
handle_image:deleteSelf()
end
self.toggles_image={}
end

function UITabBar:ClearSelect()
self.select_index=0
end

function UITabBar:SetSelected(select_index)
self:UpdateSelected(select_index)
self.state_lock=true
otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
handle_toggle.isOn=select_index==index
end)
self.state_lock=false
end

function UITabBar:UpdateSelected(index)
if not self.toggles_state[index]then
if self.disable_callback then
self.disable_callback(index)
end
self.state_lock=true
otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
handle_toggle.isOn=self.select_index==index
end)
self.state_lock=false
return
end
if self.select_index==index then
return
end
self.select_index=index
self:ExecuteSelect()
end

function UITabBar:GetSelected()
return self.select_index
end

function UITabBar:ExecuteSelect()
if self.callback then
self.callback(self.select_index)
end
end

function UITabBar:SetTabVisible(tab_index,visible)
self.toggles[tab_index].gameObject:SetActive(visible)
end

function UITabBar:SetTabEnable(index,is_enable)
self.toggles_state[index]=is_enable






















end

function UITabBar:ScrollToBegin()
self.tab_list.anchoredPosition=Vector2.zero
end


