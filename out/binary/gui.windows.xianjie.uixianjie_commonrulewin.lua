







def_class("UIXianJie_commonRuleWin",UIWindowBase)









function UIXianJie_commonRuleWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.ruleList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXianJie_commonRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
end
















local _this




function UIXianJie_commonRuleWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_commonRuleWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_commonRuleWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.lang=argtable.lang
self.num=argtable.num or 10
self.screenPos=argtable.screenPos

self.arrow:setChildUIScreenPos(self.screenPos)

local rules={}
for i=1,self.num do
local str=cfgHelper.get1(cfg_lang_get,string.format(self.lang,i))
if str~=nil then
table.insert(rules,str)
end
end

self.ruleList:setChildLayoutGroupCreateItems(#rules,function(index)
local item=self.ruleList:getChildLayoutGroupGridItem(index-1)
local desc=rules[index]
local checkGo=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
desc=comHelper.getCheckLayoutStr(checkGo,width,desc)
item:SetChildText(0,desc)
item:ForceLayoutVertical(0)
end)
self.winlua:ForceLayoutVertical(self.ruleList:getID())
end


function UIXianJie_commonRuleWin:onHide()

end





function UIXianJie_commonRuleWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

