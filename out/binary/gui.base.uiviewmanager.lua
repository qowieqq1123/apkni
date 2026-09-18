











UIViewManager=simple_class()

UIViewManager.Instance=nil

local get_window_config=function(view_type)
return UIWindowConfig_Auto[view_type]
or UIWindowConfig[view_type]
or nil
end

function UIViewManager:__init()
if UIViewManager.Instance then
error("Init Singleton Twice!")
return
end
UIViewManager.Instance=self

self.view_table={}
self.view_main_menu=nil
end

function UIViewManager:RegisterView(view_name)

end

function UIViewManager:InstantiateView(view_name)
local cfg=get_window_config(view_name)
if not cfg then

return nil
end
local src=cfg.src
local creator=cfg.creator
require(src)
local view=creator.New()
return view
end

function UIViewManager:OpenView(view_name,prev_view,...)
local view=self.view_table[view_name]
if not view then
view=self:InstantiateView(view_name)
end
if view then
view:Open(prev_view,{...})
return true
end
return false
end

function UIViewManager:CloseView(view_name,...)
local view=self.view_table[view_name]
if view then
view:Close({...})
return true
end
return false
end


function UIViewManager:CloseOther(view_name)
for index,handle_view in pairs(self.view_table)do
if index~=view_name and
handle_view:IsOpen()and
not handle_view:IsAlways()then
handle_view:Close()
end
end
end

function UIViewManager:HideView(view_name)
local view=self.view_table[view_name]
if view then
view:Hide()
end
end

function UIViewManager:GetViewByName(view_name)
return self.view_table[view_name]
end

function UIViewManager:__delete()
ViewManager.Instances=nil
end

