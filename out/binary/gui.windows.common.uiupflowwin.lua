







def_class("UIUpFlowWin",UIWindowBase)









function UIUpFlowWin:bindComponents()

self.effect=UIObject.get(self,0)
self.attr=UIObject.get(self,1)
self.attrItem_1=UIObject.get(self,2)
self.attrItem_2=UIObject.get(self,3)
self.attrItem_3=UIObject.get(self,4)
self.attrItem_4=UIObject.get(self,5)
self.attrItem_5=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.attrItem={
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
self.attrItem_4,
self.attrItem_5,
}



end


function UIUpFlowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.attrItem_1);self.attrItem_1=nil;
_UIObject_release(self.attrItem_2);self.attrItem_2=nil;
_UIObject_release(self.attrItem_3);self.attrItem_3=nil;
_UIObject_release(self.attrItem_4);self.attrItem_4=nil;
_UIObject_release(self.attrItem_5);self.attrItem_5=nil;
_UIObject_release(self.root);self.root=nil;
self.attrItem=nil;
end


















function UIUpFlowWin:onLoaded(...)
self:bindComponents()
self.rootpos=self.root:getChildLocalPosition()
end

function UIUpFlowWin:__delete()
self:unbindComponents()
end

function UIUpFlowWin:onShow(argtable,afterOnloaded)
self:showFlow(argtable)
end

function UIUpFlowWin:onHide()

end




function UIUpFlowWin:doMyAnim()
local delay=0
delay=delay+0.3
self.attr:setActive(false)
self:delayDo(delay,function()
self.attr:setActive(true)
end)

delay=delay+1
self.winlua:SetChildLocalPosY(self.root:getID(),self.rootpos.y)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),1)
self.rootAni=self:delayDo(delay,function()
local pos=self.root:getChildLocalPosition()
self.winlua:SetChildDOLocalMoveY(self.root:getID(),pos.y+100,0.5,nil)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),0,0.5,nil)
end)
delay=delay+0.5
self:delayDo(delay,function()
self:closeSelf()
end)
end

function UIUpFlowWin:showFlow(argtable)
local effectId=argtable.effect
local strs=argtable.strs

self:stopAllTimer()
self.effect:setChildShowEffect(effectId,true)

local len=#strs
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=len then
widget:SetChildText(1,strs[i])
end
end

self:doMyAnim()
end
