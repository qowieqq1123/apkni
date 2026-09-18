local _helper=CS.UIHelper
UISDKInitFail=simple_class()

function UISDKInitFail:auto_bind()
end

function UISDKInitFail:__init(...)

end

local _CSUIManager=CS.UIManager
local _CreateWindow=_CSUIManager.CreateWindow
local _BindWindow=CS.BindWindow
local _UpdateScript_LoadGameObjectFromBundle=CS.ResourceHelper.UpdateScript_LoadGameObjectFromBundle
local _UpdateScript_CreateWindow=CS.ResourceHelper.UpdateScript_CreateWindow
function UISDKInitFail.CreateWindow(finishcallback)

local function onLoadFinish(prefab)
local winlua=_UpdateScript_CreateWindow(prefab,10,'updatesystem/ui/uiupdatewindow.ab')
local window=UISDKInitFail()
window.winid=winlua
_BindWindow(winlua,window)
finishcallback(window)
end
_UpdateScript_LoadGameObjectFromBundle('updatesystem/ui/uisdkinitfail.ab','UISDKInitFail',onLoadFinish)
end
