
local _helper=CS.UIHelper


UIRedItem=simple_class()

function UIRedItem:__init(Obj,EventKeyName,noShowNum)
self.Root=Obj
self.EventKeyName=EventKeyName
self.noShowNum=noShowNum or false
self.EventItem=RedEventManager.FindRedEvent(EventKeyName)
self.RedNumText=_helper.FindText(self.Root,"Num")or _helper.FindText(self.Root,"Tips/Text")
self:RefRedNum()
self:AddListener()

self.parentRoot=tostring(self.Root.transform.parent)
end

function UIRedItem:OnDestroy()
NotifyCenter:UnRegister(self)
self.Root:SetActive(false)
self.Root=nil
self.EventKeyName=nil
self.noShowNum=nil
self.EventItem=nil
self.parentRoot=nil
self.RedNumText=nil
end


function UIRedItem:RefEventKey(EventKeyName)
if self.EventItem~=nil then
self.EventItem:RemoveUI()
end

self.EventItem=RedEventManager.FindRedEvent(EventKeyName)
self.EventItem:BindUI(self)

self:RefRedNum()
end


function UIRedItem:RemoveListener()
NotifyCenter:UnRegister(self)
if self.EventItem==nil then
return
end
self.EventItem:RemoveUI()
end


function UIRedItem:AddListener()
if self.EventItem==nil then
return
end
self.EventItem:BindUI(self)
NotifyCenter:Register(self,EventConfigM9.EventRedChangem9,objectHelper.packFunc(self,self.ListenEventRedChangem9))
end

function UIRedItem:ListenEventRedChangem9(EventItem)
if self.EventKeyName==EventItem:GetEventName()then

self:RefRedNum()
end
end

function UIRedItem:RefRedNum()
if self.Root==nil then

return
end

if self.EventItem==nil then

self.EventItem=RedEventManager.FindRedEvent(self.EventKeyName)
if self.EventItem==nil then

self.Root:SetActive(false)
end
else
local Num=self.EventItem:GetSelfEventNum()
if Num>0 then
if self.RedNumText then
self.RedNumText.text=(Num==1 or self.noShowNum)and""or Num;
end
end
self.Root:SetActive(Num>0)
end
end
