






UIManager=gameState.addListener({})

local _ctor={}
local _refParentName={}
local GameObject=UnityEngine.GameObject
_CSUIManager=CS.UIManager
local _LoadWindow=_CSUIManager.LoadWindow
local _CancelShowWindow=_CSUIManager.CancelShowWindow
local _csuimgr=CS.CSGUIManager.Instance
local _table_insert=table.insert
local MsgDispatcher=CS.MessageInterface
local GlobalEventType=GlobalEventType
local _require=require
local _SetSafeAreaOffset=_CSUIManager.SetSafeAreaOffset

local function _PreloadCtor(info)

local ctor=_ctor[info.creator]
if _ctor[info.creator]==nil then
_require(info.src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
end
info.ctor=ctor
end




























local function get_window_config(name)
return UIWindowConfig_Auto[name]or UIWindowConfig[name]or UIWidgetConfig[name]
end
UIManager.get_window_config=get_window_config

PreloadCtor=_PreloadCtor
function UIManager.PreloadCtor(name)
local info=get_window_config(name)
PreloadCtor(info)
end


local function onUILoaded(name,winlua)
loggerUtil.log(FMT.fmt('Loaded 窗口：{0}',name))
local self=UIManager
local states=self.window_show_states[name]

if states==nil or states~=0 then
winlua:Close()
self.loading_win[name]=nil

else
local current_win_info=get_window_config(name)

local win=nil
local function startcallback(...)
local argtable=self._uishow_args[name]
self._uishow_args[name]=nil
self:postWindowStart(name,win,argtable)
end
if current_win_info.ctor==nil then

end

win=current_win_info.ctor(winlua.gameObject,winlua,current_win_info.events,startcallback,name)

self.active_win[name]=win
self.loading_win[name]=nil

local argtable=self._uishow_args[name]
win.window_name=name
win:show()


win:onLoaded(argtable)
self._uishow_args[name]=nil

UIManager.remove_cache_window(name)
self:postWindowAwake(name,win,argtable,true)

if states==0 then
win:onShow(argtable,true)
notifySystem:postNotify(notifyConfig.onShowUI,name,true)
else
win:onHide_before()
win:setVisible(false)
win:hideAllWindow()
win:onHide()
end
end

end


local isOpenGMWin=false
function UIManager:onAppStart()
self._is_init=true

self._current_win_name=""
self.active_win={}
self.inactive_win={}
self.loading_win={}
self.active_child_win={}
self.window_show_states={}
self._awake_listeners={}
self._start_listeners={}


self._uishow_args={}
self.isCloseing=false
self._uiActorRoot=nil
self._args={}
self._backargs={}

self._uiMainMenu=nil
_CSUIManager.sOnCSGUIWindowLuaLoaded=onUILoaded
UIManager:init()
UIDialogManager:onAppStart()
if not isOpenGMWin then
isOpenGMWin=true
UIManager:showWindow('UIGMWin')
end
UIManager.initCacheTimer()
notifySystem:postNotify(notifyConfig.onUIManagerInit)
UIManager:SetScreenAdaptiionOffset()
end

function UIManager:onEnterState()

end

function UIManager:onLeaveState(isReconnet)
if isReconnet then return end
self:closeAllGameWindow()
UIDialogManager.closeAll()
end


function UIManager:init()
local root_obj=GameObject.Find('GUI_ROOT')
self.root_obj=root_obj
self.root=self.root_obj.transform
self.defaultCanvas_trans=GameObject.Find('DefaultCanvas').transform

self:initWindowAwakeListener()
end

function UIManager:setCloseing(flag)
self.isCloseing=flag
end


function UIManager:showWindowImp(name,argtable)
UIManager:setArgs(name,argtable)
if self.isCloseing then

return false
end
if not viewModeControl:canOpen(name)then




return false
end

if not dialogueControl.show(name,argtable)then

return false
end

return UIManager:showWindowEx(name,argtable)
end

function UIManager:showWindowEx(name,argtable)
local win=self.active_win[name]

if win then
self.window_show_states[name]=0
UIManager.remove_cache_window(name)
win:show()
self:postWindowAwake(name,win,argtable,false)
win:onShow(argtable,false)
notifySystem:postNotify(notifyConfig.onShowUI,name,false)

return true
end

local info=get_window_config(name)
if info==nil then
logErr('no ui info found',name)
return false
end





loggerUtil.log(FMT.fmt('Reqshow窗口：{0}',name))

self._uishow_args[name]=argtable
self.window_show_states[name]=0
if self.loading_win[name]==true then
return false
end

PreloadCtor(info)

self.loading_win[name]=true


_CancelShowWindow(name)
_LoadWindow(name,info.ab,-1,true)

notifySystem:postNotify(notifyConfig.showUI,name)
return false
end

function UIManager:resetLoadingWindow(name)
self.loading_win[name]=nil
end

function UIManager:findLoadingWindow(name)
return self.loading_win[name]
end

function UIManager:findActiveWindow(name)
return self.active_win[name]
end

function UIManager:getAllActiveWindows()
return self.active_win,self.loading_win
end


function UIManager:isActive(name,withloading)
local v=self.active_win[name]
local ret=v and v.isVisible==true
local isLoading=self.loading_win[name]==true
if withloading then
return isLoading or ret
else
return ret
end
end

function UIManager:closeWindowImp(name,forceClose)
if deviceHelper.isRunEditor()then

else
loggerUtil.log(FMT.fmt('Closed 窗口：{0}',name))
end

if name==nil then
logErr("尝试关闭一个名字为nil的窗口，请检查调用堆栈。")
return
end
if not forceClose and UIManager.check_cache_window(name)then
UIManager.cache_window(name)
UIManager:hideWindow(name)
else
dialogueControl.delete(name)
local state=self.window_show_states[name]
self.window_show_states[name]=1
local win=self.active_win[name]
if win then
self.active_win[name]=nil

self.active_child_win[name]=nil
UIManager:_deleteWindow(win)
notifySystem:postNotify(notifyConfig.closeUI,name,true)
end
if state and state~=1 then
notifySystem:postNotify(notifyConfig.closeUIEx,name,true)
end
end
end

function UIManager:hideWindowImp(name)
dialogueControl.delete(name)
local state=self.window_show_states[name]
self.window_show_states[name]=2
local win=self.active_win[name]
if win then
notifySystem:postNotify(notifyConfig.hideUI,name)
win:onHide_before()
win:setVisible(false)
win:hideAllWindow()
win:onHide()
notifySystem:postNotify(notifyConfig.closeUI,name,false)
if state and state~=1 then
notifySystem:postNotify(notifyConfig.closeUIEx,name,false)
end
end
end

function UIManager:closeActiveWindow(name,withloading)
if self:isActive(name,withloading)then
UIManager:closeWindow(name)
end
end

function UIManager:closeWindowWithLoading(name,withloading)
local v=self.active_win[name]
local isLoading=self.loading_win[name]==true
local ret=v~=nil
if withloading then
ret=ret or isLoading
end
if ret then
UIManager:closeWindow(name)
end
end

function UIManager:setAllWindowVisible(value)
for name,win in pairs(self.active_win)do
win:setVisible(value)
end
end

function UIManager:closeAllWindow()
self.window_show_states={}
self.loading_win={}
UIManager.clearCache()

for key,win in pairs(self.active_win)do
UIManager:_deleteWindow(win)
end




self.active_child_win={}
self.active_win={}
LuaApplication.gc_step()
end













function UIManager:closeAllGameWindow()
UIManager.clearCache()
for k,v in pairs(self.window_show_states)do
if not self:forbidCloseByAll(k)then
self:closeWindow(k,true)
end
end
end

function UIManager:_deleteWindow(win)
win:close()
LuaApplication.gc_step()
end



function UIManager:listenWindowAwake(window_name,func)

if self._awake_listeners==nil then return false end
local notify=self._awake_listeners[window_name]
if not notify then
notify={}
self._awake_listeners[window_name]=notify
end
for i,f in ipairs(notify)do
if f==func then
return true
end
end


_table_insert(notify,func)
return true
end

function UIManager:removeWindowAwake(window_name)
if self._awake_listeners==nil then return false end
local notify=self._awake_listeners[window_name]
if notify~=nil then
self._awake_listeners[window_name]=nil
end
end



function UIManager:listenWindowStart(window_name,func)

local notify=self._start_listeners[window_name]
if not notify then
notify={}
self._start_listeners[window_name]=notify
end
for i,f in ipairs(notify)do
if f==func then
return
end
end


_table_insert(notify,func)
end


function UIManager:addUIObject(ui)
ui.transform:SetParent(self.root,false)
end


function UIManager:postWindowAwake(window_name,...)



local notify=self._awake_listeners[window_name]

if notify then
for i,f in pairs(notify)do
f(...)
end
end
end


function UIManager:postWindowStart(window_name,...)

local notify=self._start_listeners[window_name]
if notify then
for i,f in ipairs(notify)do
f(...)
end
end
end

function UIManager:onAppQuit()
if self._is_init==false then return end

for i,v in pairs(self.active_win)do
v:UnBindLua()
end

for i,v in pairs(self.inactive_win)do
v:UnBindLua()
end
end

function UIManager:showToast(msg)
_csuimgr:ShowToast(msg)
end

function UIManager:initWindowAwakeListener()

end



function UIManager:isDownLoaded(abName)
return not downAssetManager:needDownLoadBundle(abName)
end






local _calltable={}

local _calltable_method={['CloseWin']=true,['onRefresh']=true}

local _nullfunction=function(...)end

local _calltable_meta={
__index=function(t,k,v)
assert(_calltable_method[k])
return _nullfunction
end
}
setmetatable(_calltable,_calltable_meta)

function UIManager:invoke(name)
local win=UIManager:findActiveWindow(name)
win=win or _calltable
return win
end

function UIManager:callWindowFunc(name,func,...)
if reconnectState:isReconnectLeaveState(name)then return end
local win=UIManager:findActiveWindow(name)
if win and not win.isClose and win[func]then
return win[func](win,...)
end
end




function UIManager:invokeUIMethod(uiName,fName,...)
if reconnectState:isReconnectLeaveState(uiName)then return end
local v=self.active_win[uiName]
if v and v.isVisible then
local f=v[fName]
if f~=nil then
return f(v,...)
else
logErr(FMT.fmt("{0} 不存在方法 {1}",uiName,fName))
end
end
end

function UIManager:refresh(name,...)
local win=UIManager:findActiveWindow(name)
if win and win.onfresh then
if reconnectState:isReconnectLeaveState(name)then return end
win:onfresh(...)
else
UIManager:showWindow(name,...)
end
end

function UIManager:callAllWindowFunc(fName,...)
if reconnectState:isReconnectLeaveState()then return end
for k,v in pairs(self.active_win)do
if not v.isClose then
local f=v[fName]
if f then
f(v,...)
end
end
end
end


function UIManager:SetScreenAdaptiionOffset()
if deviceHelper.isRunEditor()then
return
end
if not api_Available_SetSafeAreaOffset()then return end
local _SafeAreaOffset=cfgHelper.get(cfg_globalconfig_get,1,"SafeAreaOffset")
local valueOffset=_SafeAreaOffset[2]
CS.UIManager.SetSafeAreaOffset(valueOffset)
end
