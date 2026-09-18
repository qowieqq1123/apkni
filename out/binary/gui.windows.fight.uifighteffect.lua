







def_class("UIFightEffect",UIWindowBase)









function UIFightEffect:bindComponents()

self.fightTimesBg=UIObject.get(self,0)
self.fightTimes=UIText.get(self,1)
self.TimesEffect=UIObject.get(self,2)
self.StateEffect=UIObject.get(self,3)



end


function UIFightEffect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fightTimesBg);self.fightTimesBg=nil;
_UIObject_release(self.fightTimes);self.fightTimes=nil;
_UIObject_release(self.TimesEffect);self.TimesEffect=nil;
_UIObject_release(self.StateEffect);self.StateEffect=nil;
end



















function UIFightEffect:onLoaded(...)
self:bindComponents()
end


function UIFightEffect:__delete()
self.delayTimer=nil
self:unbindComponents()
end




function UIFightEffect:onShow(argtable,afterOnloaded)

self.StateEffect:setChildShowEffect(argtable.para,true)

if argtable.fightTimes then
self:showFightTimes(argtable.fightTimes)
end

local delayClose=function()
if self.delayTimer~=nil then
self.delayTimer=nil
self:closeSelf()
end
end
self.delayTimer=self:setTimer(2.5,1,delayClose)
end

function UIFightEffect:showFightTimes(index)
self.TimesEffect:setChildShowEffect(10210,true)
self.fightTimes:setText(index)
self.fightTimesBg:setChildCanvasGroupAlpha(0)
local tweener=self.fightTimesBg:setChildCanvasGroupDOFade(1,0.75,function()
self.fightTimesBg:setChildCanvasGroupDOFade(0,0.8)
end)
tweener:SetDelay(0.28)
end


function UIFightEffect:onHide()

end



