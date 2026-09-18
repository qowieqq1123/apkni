

local helper=CS.UIHelper
updateDialogBox={name='updateDialogBox'}
local _BindWindow=CS.BindWindow
local helper=CS.UIHelper

local CSGUIWindowLua_SetChildIcon=CS.CSGUIWindowLua.SetChildIcon;

local CSGUIWindowLua_SetChildText=CS.CSGUIWindowLua.SetChildText;
local CSGUIWindowLua_SetButtonClick=CS.CSGUIWindowLua.SetChildButtonClick
function updateDialogBox:auto_bind()
end




function updateDialogBox:Init(name,gameObject,winlua)
self.__name=name or''
self.gameObject=gameObject
self.winlua=winlua
self.winid=winlua
self.transform=gameObject.transform
_BindWindow(winlua,self)
end









function updateDialogBox:Show()
self.gameObject:SetActive(true)
end
function updateDialogBox:Close()

self.gameObject:SetActive(false)
end





function updateDialogBox:ShowDialogBox(text,okBtnCallback)

CSGUIWindowLua_SetChildText(self.winid,0,text)
local okCallback=function()
updateDialogBox:Close()
if okBtnCallback~=nil then
okBtnCallback()
end

end
CSGUIWindowLua_SetButtonClick(self.winid,4,okCallback,true)
updateDialogBox:Show()
end




function updateDialogBox:set_Title(text)
CSGUIWindowLua_SetChildText(self.winid,1,text)
end




