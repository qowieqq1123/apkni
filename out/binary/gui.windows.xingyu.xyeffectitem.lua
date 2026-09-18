







def_class("xyeffectItem",UICloneObject)





xyeffectItem.abName="ui/windows/xingyu/xyeffectitem.ab"

xyeffectItem.assetName="xyeffectItem"


function xyeffectItem:bindComponents()

self.xyeffectItem=UIObject.get(self,0)
self.effect=UIObject.get(self,1)

end


function xyeffectItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.xyeffectItem);self.xyeffectItem=nil;
_UIObject_release(self.effect);self.effect=nil;
end









function xyeffectItem:onLoaded(...)
self:bindComponents()
end


function xyeffectItem:__delete()
self:unbindComponents()
end




function xyeffectItem:onShow(argtable,afterOnloaded)

local temp=argtable
local sPos=temp.sPos
local epos=temp.epos
local effectCmp=self.xyeffectItem:getWidgetBase()
effectCmp:SetChildPosition(0,sPos)
effectCmp:SetChildShowEffect(1,10076,true)
math.randomseed(timeHelper.getServerShortTime())
self:setTimer(0.5,1,function()
if self and self.isClose then return end
if not effectCmp then return end
effectCmp:SetChildShowEffect(1,10077,true)
effectCmp:SetChildDOJump(0,epos,math.random(-1,1),1,1.5,function()
if self and self.isClose then return end
effectCmp:SetChildShowEffect(1,10078,true)
UIManager:invokeUIMethod("UIXingYuMainWin","playRewardBtnAnim",self:getId())
end)
end)

end


function xyeffectItem:onHide()

end



