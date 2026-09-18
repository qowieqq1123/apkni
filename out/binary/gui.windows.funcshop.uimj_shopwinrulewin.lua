







def_class("UIMJ_ShopWinRuleWin",UIWindowBase)









function UIMJ_ShopWinRuleWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.ruleList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIMJ_ShopWinRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
end
















local _this=nil



function UIMJ_ShopWinRuleWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMJ_ShopWinRuleWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMJ_ShopWinRuleWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.lang=argtable.lang
self.num=argtable.num or 10
self.screenPos=argtable.screenPos



local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end

self.pos=pos
self.arrow:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))


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



item:SetChildText(0,desc)
item:ForceLayoutVertical(0)
end)
self.winlua:ForceLayoutVertical(self.ruleList:getID())
end


function UIMJ_ShopWinRuleWin:onHide()

end




function UIMJ_ShopWinRuleWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end
