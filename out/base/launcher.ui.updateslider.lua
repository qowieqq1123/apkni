


UpdateSlider={name='UpdateSlider'}
local CSGUIWindowLua_SetChildText=CS.CSGUIWindowLua.SetChildText;
local _BindWindow=CS.BindWindow
local _FindCompent=CS.CSGUIWindowLua.GetCommonComponent

function UpdateSlider:auto_bind()
end




function UpdateSlider:set_Text(text)
CSGUIWindowLua_SetChildText(self.winid,0,text)
end

function UpdateSlider:Init(name,gameObject,winlua)
self.__name=name or''
self.gameObject=gameObject
self.winlua=winlua
self.winid=winlua
self.transform=gameObject.transform
self.slider=_FindCompent(self.winid,1,'Slider')
_BindWindow(winlua,self)
end
function UpdateSlider:set_Value(value)
self.slider.value=value
end
function UpdateSlider:Show()
if self.gameObject.activeSelf~=true then
self.gameObject:SetActive(true)
end
end
function UpdateSlider:Close()
self.gameObject:SetActive(false)
end
