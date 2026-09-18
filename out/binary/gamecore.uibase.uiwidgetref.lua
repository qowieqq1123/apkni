







UIWidgetRef=simple_class()
local _Destroy=UnityEngine.GameObject.Destroy
local _BindWindow=CS.BindWindow
local helper=CS.UIHelper
local FindButton=helper.FindButton
local FindInputField=helper.FindInputField
local FindImage=helper.FindImage
local FindImageGray=helper.FindImageGray
local FindText=helper.FindText
local FindCSGUIProgressbar=helper.FindCSGUIProgressbar
local FindToggle=helper.FindToggle
local FindToggleGroup=helper.FindToggleGroup
local FindSlider=helper.FindSlider
local FindWindowLua=helper.FindWindowLua
local FindEnhancedScrollerLua=helper.FindEnhancedScrollerLua
local FindTransform=helper.FindTransform
local FindImageEx=helper.FindImageEx

local FindRollNumText=helper.FindRollNumText
local FindRectTransform=helper.FindRectTransform
local FindCSGUIImage=helper.FindCSGUIImage
local FindGradient=helper.FindGradient

local GetButton=helper.GetButton
local GetInputField=helper.GetInputField
local GetImage=helper.GetImage
local GetText=helper.GetText
local GetWindowLua=helper.GetWindowLua
local GetRectTransform=helper.GetRectTransform
local GetCSGUIWidgetBase=helper.GetCSGUIWidgetBase


function UIWidgetRef:__init(gameObject)
self.gameObject=gameObject
self.transform=gameObject.transform
end

function UIWidgetRef:__delete()
for k in pairs(self)do
self[k]=nil;
end
end

function UIWidgetRef:OnDestroy()
self:deleteSelf()
end

function UIWidgetRef:FindButton(name)
return FindButton(self.gameObject,name)
end
function UIWidgetRef:FindTransform(name)
return FindTransform(self.gameObject,name)
end

function UIWidgetRef:FindInputField(name)
return FindInputField(self.gameObject,name)
end

function UIWidgetRef:FindImage(name)
return FindImage(self.gameObject,name)
end

function UIWidgetRef:FindSlider(name)
return FindSlider(self.gameObject,name)
end

function UIWidgetRef:FindText(name)
return FindText(self.gameObject,name)
end

function UIWidgetRef:FindToggle(name)
return FindToggle(self.gameObject,name)
end

function UIWidgetRef:FindToggleGroup(name)
return FindToggleGroup(self.gameObject,name)
end

function UIWidgetRef:FindCSGUIProgressbar(name)
return FindCSGUIProgressbar(self.gameObject,name)
end

function UIWidgetRef:FindWindowLua(name)
return FindWindowLua(self.gameObject,name)
end

function UIWidgetRef:FindEnhancedScrollerLua(name)
return FindEnhancedScrollerLua(self.gameObject,name)
end

function UIWidgetRef:FindImageEx(name)
return FindImageEx(self.gameObject,name)
end

function UIWidgetRef:FindImageGray(name)
return FindImageGray(self.gameObject,name)
end

function UIWidgetRef:FindTextEx(name)
return helper.FindTextEx(self.gameObject,name)
end

function UIWidgetRef:FindCSGUIImage(name)
return FindCSGUIImage(self.gameObject,name)
end

function UIWidgetRef:FindGradient(name)
return FindGradient(self.gameObject,name)
end


function UIWidgetRef:GetRectTransform()
return GetRectTransform(self.gameObject)
end

function UIWidgetRef:GetButton()
return GetButton(self.gameObject)
end

function UIWidgetRef:GetInputField()
return GetInputField(self.gameObject)
end

function UIWidgetRef:GetImage()
return GetImage(self.gameObject)
end


function UIWidgetRef:GetText()
return GetText(self.gameObject)
end

function UIWidgetRef:GetWindowLua()
return GetWindowLua(self.gameObject)
end

function UIWidgetRef:GetCSGUIWidgetBase()
return GetCSGUIWidgetBase(self.gameObject)
end

function UIWidgetRef:FindRectTransform(name)
return FindRectTransform(self.gameObject,name)
end

function UIWidgetRef:FindRollNumText(name)
return FindRollNumText(self.gameObject,name)
end
