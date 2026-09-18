local _helper=CS.UIHelper

UIRedItemM3=simple_class(UIRedItem)

function UIRedItemM3:__init(Obj,EventKeyName)

end

function UIRedItemM3:RefRedNum()
if self.RedNumText==nil then
self.RedNumText=_helper.FindText(self.Root,"Tips/Text")
end
local RedItem=self.EventItem
if RedItem==nil then
self.RedNumText.text=nil;
self.Root:SetActive(false)
else
local Num=RedItem:GetSelfEventNum();
if Num==0 then
self.RedNumText.text=nil;
self.Root:SetActive(false)
else
if Num==1 then
Num=nil
end
self.RedNumText.text=Num;
self.Root:SetActive(true)
end
end


end
