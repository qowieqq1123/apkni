










local TABLE_INSERT=table.insert
local TABLE_REMOVE=table.remove
local PAIRS=pairs
local IPAIRS=ipairs

local CS_BindWindow=CS.BindWindow
local CS_CreateWindow=CS.UIManager.CreateWindow

UIBaseView=simple_class()

function UIBaseView:__init()
self.view_name=nil
self.assetbundle_name=nil
self.canvas_index=nil
self.winlua=nil
self.subview_list={}
self.release_ctrl_list={}
self.load_state=UILoadState.eUnLoad
self.close_mode=UICloseMode.eDestroy
self.is_open=false
self.is_hide=false
self.destroy_delay=2
self.destroy_timer=nil
end


function UIBaseView:RegisterSubView(sub_view)
TABLE_INSERT(self.subview_list,sub_view)
end


function UIBaseView:IsOpen()
return self.is_open
end


function UIBaseView:Open()
if self.is_open then
return
end

self.is_open=true

if self.destroy_timer then
self.destroy_timer:cancel()
self.destroy_timer=nil
end

if self.load_state==UILoadState.eLoaded then
self:OpenIndeed()
elseif self.load_state==UILoadState.eUnLoad then
self:LoadResource()
end
end


function UIBaseView:OpenIndeed()


self.winlua:Show()

for _,sub_view in PAIRS(self.subview_list)do
sub_view:Open()
end

self:OpenCallback()
end

function UIBaseView:OpenCallback()

end


function UIBaseView:LoadResource()
if not self.assetbundle_name then
return
end

self.load_state=UILoadState.eLoading

local load_finish=function(name,prefab)

if self.load_state==UILoadState.eUnLoad
or self.load_state==UILoadState.eFailed then
return
end

self.load_state=UILoadState.eLoaded

local winlua=self:CreateWinlua(prefab)
local go=winlua.gameObject
go.name=name

CS_BindWindow(winlua,self)
self:LoadCallback()

if self.is_open then
self:OpenIndeed()
else
self.winlua:SetActive(false)
end
end
assetLoader.LoadUI(self.view_name,self.assetbundle_name,false,load_finish)
end

function UIBaseView:LoadCallback()

end


function UIBaseView:Close()
if not self.is_open then
return
end
self.is_open=false

if self.load_state==UILoadState.eUnLoad then
return

elseif self.load_state==UILoadState.eLoading
or self.load_state==UILoadState.eFailed then

if self.close_mode==UICloseMode.eDestroy then
self.load_state=UILoadState.eUnLoad
end

elseif self.load_state==UILoadState.eLoaded then



self.winlua:Close()
end
end


function UIBaseView:CloseIndeed()
self:CloseCallback()

if self.close_mode==UICloseMode.eDestroy then
if self.destroy_delay>0 then
local destroy_func=function()
self.destroy_timer=nil
self:DestroyWindow()
end
self.destroy_timer=time.new()
self.destroy_timer:start(self.destroy_delay,destroy_func)
else
self:DestroyWindow()
end
end
end


function UIBaseView:CloseCallback()

end


function UIBaseView:DestroyWindow()
for _,sub_view in PAIRS(self.subview_list)do
sub_view:DestroyWindow()
end
self.subview_list={}

self:ClearReleaseCtrl()
self:DestroyCallback()

if self.winlua then
self.winlua:DestroySelf()
self.winlua=nil
end

self.load_state=UILoadState.eUnLoad
end

function UIBaseView:DestroyCallback()

end


function UIBaseView:Hide(value)
if self.is_hide==value then
return
end

self.is_hide=value

if self.winlua then
self.winlua:Hide(value)
end
end


function UIBaseView:DeleteResCtrl(delete_ctrl)
for index,handle_ctrl in IPAIRS(self.release_ctrl_list)do
if handle_ctrl==delete_ctrl then
delete_ctrl:deleteSelf()
TABLE_REMOVE(self.release_ctrl_list,index)
break
end
end
end


function UIBaseView:ClearReleaseCtrl()
for index,handle_ctrl in IPAIRS(self.release_ctrl_list)do
handle_ctrl:deleteSelf()
end
self.release_ctrl_list={}
end

function UIBaseView:SetActive(value)
if self.winlua then
self.winlua:SetActive(value)
end
end


function UIBaseView:CreateWinlua(prefab)
return CS_CreateWindow(prefab,self.canvas_index)
end
