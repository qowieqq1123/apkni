



















UIFrameView=simple_class(UIBaseView)

local CLOSE_BTN="SysBaseLayer/CloseBtn"
local HELP_BTN="SysBaseLayer/HelpBtn"
local RETURN_BTN="SysBaseLayer/ReturnBtn"
local TAB_BAR="SysBaseLayer/Bg/TabGroup"

local PAIRS=pairs
local UNPACK=unpack

local get_window_config=function(view_type)
return UIWindowConfig_Auto[view_type]or UIWindowConfig[view_type]or nil
end

function UIFrameView:__init()
self.is_single=true
self.is_always=false

self.prev_view_name=nil

self.enable_money_bar=true
self.enable_close_btn=true
self.enable_help_btn=false
self.enable_return_btn=false

self.tab_view_data={}
self.tab_view_table={}
self.cur_tab_type=1
self.tab_bar=nil
self.tab_btn_table={}

self.wallpaper=nil

self.old_tab_view=nil
end

function UIFrameView:IsSingle()
return self.is_single
end

function UIFrameView:IsAlways()
return self.is_always
end

function UIFrameView:Open(tab_type,prev_view_name,user_data)
if self.is_open then
return
end

self.prev_view_name=prev_view_name
self.cur_tab_type=tab_type or 1

if user_data then
self:ProcessOpenUserData(UNPACK(user_data))
end

UIFrameView._base.Open(self)
end

function UIFrameView:OpenIndeed()
if self.is_single then
UIViewManager.Instance:CloseOther(self.view_name)
end
UIFrameView._base.OpenIndeed(self)
end

function UIFrameView:Close(user_data)
if not self.is_open then
return
end

if user_data then
self:ProcessCloseUserData(UNPACK(user_data))
end

local handle_tab=self.tab_view_table[self.cur_tab_type]
if handle_tab then
handle_tab:InactiveCallback()
end

UIFrameView.super.Close(self)
end

function UIFrameView:OpenCallback()
self:SetCurTabType(self.cur_tab_type)
end

function UIFrameView:CloseCallback()

end

function UIFrameView:ProcessOpenUserData()

end

function UIFrameView:ProcessCloseUserData()

end

function UIFrameView:Return()
if not self.is_open then
return
end

if not self.prev_view_name then
UIViewManager.Instance:CloseView(self.view_name)
else
UIViewManager.Instance:OpenView(self.prev_view_name)
end
end

function UIFrameView:Help()
if not self.is_open then
return
end
end

function UIFrameView:LoadCallback()

if self.enable_close_btn then
local close_btn=self:FindButton(CLOSE_BTN)
if close_btn then
objectHelper.addListerner(close_btn,objectHelper.packFunc(self,self.OnClickCloseBtn))
end
end
if self.enable_help_btn then
local help_btn=self:FindButton(HELP_BTN)
if help_btn then
objectHelper.addListerner(help_btn,objectHelper.packFunc(self,self.OnClickHelpBtn))
end
end
if self.enable_return_btn then
local return_btn=self:FindButton(RETURN_BTN)
if return_btn then
objectHelper.addListerner(return_btn,objectHelper.packFunc(self,self.OnClickReturnBtn))
end
end

local tab_data_count=table.nums(self.tab_view_data)
local tab_object=self:FindTransform(TAB_BAR).gameObject

if tab_object and tab_data_count>0 then
local select_callback=function(view_type)
self:HandleTabView(view_type)
end
self.tab_bar=UITabBarEx.New(tab_object,select_callback)

self.tab_bar:SetTogglesVisible(self.view_name)
end










end


function UIFrameView:HandleTabView(view_type)

self.old_tab_view=self.tab_view_table[self.cur_tab_type]

local handle_tab=self:FetchTabView(view_type)
self.cur_tab_type=view_type
if handle_tab then
handle_tab:Open()
end
end


function UIFrameView:TabSubViewOpenCallback()

if self.old_tab_view then
self.old_tab_view:Close()
self.old_tab_view=nil
end
end


function UIFrameView:FetchTabView(view_type)
if self.tab_view_table[view_type]then
return self.tab_view_table[view_type]
end

local win_cfg=get_window_config(view_type)
if not win_cfg then
return
end
require(win_cfg.src)
local handle_view=win_cfg.creator.New(self)

handle_view:SetTabType(view_type)
handle_view:SetActive(false)
handle_view:SetOpenCallback(objectHelper.packFunc(self,self.TabSubViewOpenCallback))

self.tab_view_table[view_type]=handle_view
return handle_view
end

function UIFrameView:SetCurTabType(view_type)
if not self.tab_bar or not self.is_open then
self.cur_tab_type=view_type
else
self.tab_bar:SetSelected(view_type)
end
end

function UIFrameView:DestroyWindow()
UIFrameView._base.DestroyWindow(self)

for _,handle_tab in PAIRS(self.tab_view_table)do
handle_tab:DestroyWindow()
end
end

function UIFrameView:OnClickCloseBtn()
self:Close()
end

function UIFrameView:OnClickHelpBtn()
self:Help()
end

function UIFrameView:OnClickReturnBtn()
self:Return()
end




function UIFrameView:GetCurTabType()
return self.cur_tab_type
end

function UIFrameView:GetCurTabView()
return self.tab_view_table[self.cur_tab_type]
end

function UIFrameView:GetTabViewByType(view_type)
return self.tab_view_table[view_type]
end



