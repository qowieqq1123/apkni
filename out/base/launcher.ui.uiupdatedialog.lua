



local _helper=CS.UIHelper
UIUpdateDialog=simple_class()
local CSGUIWindowLua_SetChildButtonClick=CS.CSGUIWindowLua.SetChildButtonClick;



local CSGUIWindowLua_SetChildText=CS.CSGUIWindowLua.SetChildText;

function UIUpdateDialog:auto_bind()
end




function UIUpdateDialog:set_TitleText(text)
CSGUIWindowLua_SetChildText(self.winid,0,text)
end




function UIUpdateDialog:set_DialogText(text)
CSGUIWindowLua_SetChildText(self.winid,1,text)
end




function UIUpdateDialog:set_OKText(text)
CSGUIWindowLua_SetChildText(self.winid,2,text)
end




function UIUpdateDialog:set_CancelText(text)
CSGUIWindowLua_SetChildText(self.winid,3,text)
end



function UIUpdateDialog:set_UIDialog(text)
CSGUIWindowLua_SetChildText(self.winid,4,text)
end







function UIUpdateDialog:set_Cancel(action,removeAllListeners)
CSGUIWindowLua_SetChildButtonClick(self.winid,5,action,removeAllListeners)
end

function UIUpdateDialog:setCancelVis(vis)
CS.CSGUIWindowLua.SetChildActive(self.winid,5,vis)
end


local _CSUIManager=CS.UIManager
local _CreateWindow=_CSUIManager.CreateWindow
local _BindWindow=CS.BindWindow
local _UpdateScript_LoadGameObjectFromBundle=CS.ResourceHelper.UpdateScript_LoadGameObjectFromBundle
local _UpdateScript_CreateWindow=CS.ResourceHelper.UpdateScript_CreateWindow

function UIUpdateDialog:__init(...)

end
function UIUpdateDialog:onOKClick()
if self.okCallback then
self.okCallback()
end
if self.okClose~=false then
self.winid:Close()
end
end

function UIUpdateDialog:onCancelClick()
if self.cancelCallback then
self.cancelCallback()
end
self.winid:Close()
end

function UIUpdateDialog.ShowDialogBox(title,content,okCallback,cancelCallback,cancelVis,okClose)

if okClose==nil then okClose=true end
if cancelVis==nil then cancelVis=true end
local function onLoadFinish(prefab)

local winlua=_UpdateScript_CreateWindow(prefab,10,'updatesystem/ui/uiupdatedialog.ab')
local window=UIUpdateDialog()
window.winid=winlua
_BindWindow(winlua,window)
window:set_TitleText(title)
window:set_UIDialog(content)
window.okCallback=okCallback
window.cancelCallback=cancelCallback
window:setCancelVis(cancelVis)
window.okClose=okClose
end
_UpdateScript_LoadGameObjectFromBundle('updatesystem/ui/uiupdatedialog.ab','UIUpdateDialog',onLoadFinish)
end
