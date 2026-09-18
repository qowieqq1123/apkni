







def_class("UISubAct_ChiSeJinDi_CopyFightLoseWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyFightLoseWin:bindComponents()

self.hpTips=UIText.get(self,0)
self.middleTips=UIText.get(self,1)
self.hpList=UIObject.get(self,2)



end


function UISubAct_ChiSeJinDi_CopyFightLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hpTips);self.hpTips=nil;
_UIObject_release(self.middleTips);self.middleTips=nil;
_UIObject_release(self.hpList);self.hpList=nil;
end















local _this=nil
local _hpCmp={
image=0,
effect=1,
}



function UISubAct_ChiSeJinDi_CopyFightLoseWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ChiSeJinDi_CopyFightLoseWin:__delete()
self:unbindComponents()
_this=nil

if self.tween and self.tween:IsActive()then
self.tween:Kill()
end
end




function UISubAct_ChiSeJinDi_CopyFightLoseWin:onShow(argtable,afterOnloaded)
if argtable.hp then
local maxHp=argtable.maxhp or(argtable.hp+1)
self.hpList:setChildLayoutGroupCreateItems(maxHp,function(index)
local item=self.hpList:getChildLayoutGroupGridItem(index-1)
item:SetChildCanvasGroupAlpha(_hpCmp.image,index>argtable.hp+1 and 0 or 1)
if index==argtable.hp+1 then
self.tween=item:SetChildCanvasGroupDOFade(_hpCmp.image,0,0.5,function()
item:SetChildShowEffect(_hpCmp.effect,1,true)
end)
self.tween:SetDelay(2)
end
end)
elseif argtable.tips then
self.middleTips:setText(argtable.tips)
self.hpTips:setActive(false)
else
self.hpTips:setActive(false)
end
end


function UISubAct_ChiSeJinDi_CopyFightLoseWin:onHide()

end



