



UnderlineBtn=simple_class()

local cshelper=CS.UIHelper

function UnderlineBtn:__init(obj,callBack)
self.root=obj

self._clickCallBack=callBack


self:InitUI()
self:InitLineText()
self:AddClickBtn()
end

function UnderlineBtn:__delete()
end

function UnderlineBtn:InitUI()
self.lineText=cshelper.FindText(self.root,"lineText")
self.costText=cshelper.FindText(self.root,"costText")
end


function UnderlineBtn:InitLineText()
local underline=GameObject.Instantiate(self.lineText)
local rect=underline.gameObject:GetComponent(typeof(RectTransform))

underline.name="Underline"
underline.text="_"
underline.transform:SetParent(self.lineText.transform,false)


rect.anchoredPosition3D=Vector3.zero
rect.offsetMax=Vector2.zero
rect.offsetMin=Vector2.zero
rect.anchorMax=Vector2.one
rect.anchorMin=Vector2.zero

self._perLineWidth=underline.preferredWidth
self._underline=underline
end


function UnderlineBtn:AddClickBtn()
if self._underline then

local btn=self._underline.gameObject:GetComponent("Button")
if btn==nil then
btn=self._underline.gameObject:AddComponent(typeof(UI.Button))
end
objectHelper.addListerner(btn,objectHelper.packFunc(self,self.OnClickBtn),nil,false)
end
end


function UnderlineBtn:OnClickBtn()
if self._clickCallBack then
self._clickCallBack(self)
end
end


function UnderlineBtn:SetClickCallBack(callBack)
self._clickCallBack=callBack
end


function UnderlineBtn:SetLineText(str)
self.lineText.text=str
self:UpdateLineText()
end


function UnderlineBtn:UpdateLineText()
if self.lineText==nil then
return
end
local width=self.lineText.preferredWidth

local lineStr=""
local format=string.format
local lineCount=math.ceil(width/self._perLineWidth)
for i=1,lineCount do
lineStr=format("%s%s",lineStr,"_")
end

self._underline.text=lineStr
end


function UnderlineBtn:SetColor(color)
if self.lineText==nil then
return
end
self._underline.color=color or self.lineText.color
end


function UnderlineBtn:SetCostText(str)
self.costText.text=str
end
