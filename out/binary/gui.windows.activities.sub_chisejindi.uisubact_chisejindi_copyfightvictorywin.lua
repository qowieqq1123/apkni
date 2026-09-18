







def_class("UISubAct_ChiSeJinDi_CopyFightVictoryWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyFightVictoryWin:bindComponents()

self.levelList=UIObject.get(self,0)
self.levelTips=UIObject.get(self,1)
self.middleTips=UIText.get(self,2)



end


function UISubAct_ChiSeJinDi_CopyFightVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelList);self.levelList=nil;
_UIObject_release(self.levelTips);self.levelTips=nil;
_UIObject_release(self.middleTips);self.middleTips=nil;
end















local _this=nil
local _levelCmp={
image=0,
effect=1,
}



function UISubAct_ChiSeJinDi_CopyFightVictoryWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ChiSeJinDi_CopyFightVictoryWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ChiSeJinDi_CopyFightVictoryWin:onShow(argtable,afterOnloaded)
if argtable.level then
self.levelTips:setActive(true)
self.levelList:setChildLayoutGroupCreateItems(argtable.level,function(index)
if index==argtable.level then
local item=self.levelList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_levelCmp.image,false)
item:SetChildScale(_levelCmp.image,Vector3.one*5)
local tween=item:SetChildDOScale(_levelCmp.image,1,0.25)
local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(1)
sequence:AppendCallback(function()
item:SetChildActive(_levelCmp.image,true)
end)
sequence:Append(tween)
sequence:AppendCallback(function()
item:SetChildShowEffect(_levelCmp.effect,1,true)
end)
end
end)
self.winlua:ForceLayoutRect(self.levelTips:getID())
elseif argtable.tips then
self.middleTips:setText(argtable.tips)
self.levelTips:setActive(false)
else
self.levelTips:setActive(false)
end
end


function UISubAct_ChiSeJinDi_CopyFightVictoryWin:onHide()

end



