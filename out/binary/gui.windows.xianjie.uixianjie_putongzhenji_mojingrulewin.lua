







def_class("UIXianJie_puTongZhenJi_mojingRuleWin",UIWindowBase)









function UIXianJie_puTongZhenJi_mojingRuleWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.ruleList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXianJie_puTongZhenJi_mojingRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
end



















function UIXianJie_puTongZhenJi_mojingRuleWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_puTongZhenJi_mojingRuleWin:__delete()
self:unbindComponents()
end




function UIXianJie_puTongZhenJi_mojingRuleWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.descStrList=argtable.descStrList
self.lang=argtable.lang
self.num=argtable.num or 10
self.screenPos=argtable.screenPos
self.width=argtable.width or 365

self.arrow:setChildUIScreenPos(self.screenPos)
self.ruleList:setChildSizeDelta(self.width,0)

local rules={}
if self.descStrList then
for i,str in ipairs(self.descStrList)do
table.insert(rules,str)
end
else
for i=1,self.num do
local str=cfgHelper.get1(cfg_lang_get,string.format(self.lang,i))
if str~=nil then
table.insert(rules,str)
end
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


function UIXianJie_puTongZhenJi_mojingRuleWin:onHide()

end





function UIXianJie_puTongZhenJi_mojingRuleWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

