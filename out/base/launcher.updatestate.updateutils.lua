local _CSUIManager=CS.UIManager
local _LoadWindow=_CSUIManager.LoadWindow
local _callbacks={}
updateUtils={}
local function onUILoaded(name,winlua)
_callbacks[name](winlua)
end

function updateUtils.Init()
_CSUIManager.sOnCSGUIWindowLuaLoaded=onUILoaded
end

function updateUtils.LoadUI(key,assetbundleName,callback)
_callbacks[key]=callback
_LoadWindow(key,assetbundleName,nil,true)
end
