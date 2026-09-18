









LuaTextLineButton=simple_class()

function LuaTextLineButton:__init(text,callBack)

self._text=text
self._clickCallBack=callBack

self:InitLineText()
self:UpdateLineText()
self:AddClickBtn()
end

function LuaTextLineButton:__delete()
self._text=nil
self._clickCallBack=nil
self._underline=nil
end

function LuaTextLineButton:InitLineText()
if nil==self._text then return end

local underline=GameObject.Instantiate(self._text)
CS.UIHelper.DestoryAllChildren(underline.gameObject)

local rect=underline.gameObject:GetComponent(typeof(RectTransform))

underline.name="Underline"
underline.text="_"
underline.transform:SetParent(self._text.transform,false)


rect.anchoredPosition3D=Vector3.zero
rect.offsetMax=Vector2.zero
rect.offsetMin=Vector2.zero
rect.anchorMax=Vector2.one
rect.anchorMin=Vector2.zero

self._perLineWidth=underline.preferredWidth
self._underline=underline
end

function LuaTextLineButton:UpdateLineText(width)
if nil==self._text then return end
width=width or self._text.preferredWidth

local lineStr=""
local lineCount=math.ceil(width/self._perLineWidth)
for i=1,lineCount do
lineStr=string.format("%s%s",lineStr,"_")
end

self._underline.text=lineStr
self._underline.color=self.textColor or self._text.color
end

function LuaTextLineButton:SetColor(color)
if nil==self._text then return end
self.textColor=color
self._underline.color=self.textColor or self._text.color
end

function LuaTextLineButton:SetClickCallBack(callBack)
if self._clickCallBack then return end

self._clickCallBack=callBack
self:AddClickBtn()
end

function LuaTextLineButton:AddClickBtn()
if self._clickCallBack and self._underline then

local btn=self._underline.gameObject:GetComponent("Button")
if btn==nil then
btn=self._underline.gameObject:AddComponent(typeof(UI.Button))
end
objectHelper.addListerner(btn,objectHelper.packFunc(self,self.OnClickBtn))
end
end

function LuaTextLineButton:OnClickBtn()
if self._clickCallBack then
self._clickCallBack(self)
end
end

function LuaTextLineButton:SetText(str)
self._text.text=str
self:UpdateLineText()
end

function LuaTextLineButton:SetActive(value)
if self._text then
self._text.gameObject:SetActive(value)
end
if self._underline then
self._underline.gameObject:SetActive(value)
end
end

function LuaTextLineButton:HideLine(isHide)
if self._underline then
self._underline.gameObject:SetActive(not isHide)
end
end
