







def_class("UISGXDTieLianWin",UIWindowBase)









function UISGXDTieLianWin:bindComponents()

self.text=UIText.get(self,0)
self.gridRoot=UIObject.get(self,1)
self.closeBg=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.juanzhou_1=UIObject.get(self,4)
self.juanzhou_2=UIObject.get(self,5)
self.juanzhou_3=UIObject.get(self,6)
self.juanzhou_4=UIObject.get(self,7)
self.pos=UIObject.get(self,8)

self.closeBg:setButtonClick(function()self:onCloseBg()end)
self.juanzhou={
self.juanzhou_1,
self.juanzhou_2,
self.juanzhou_3,
self.juanzhou_4,
}



end


function UISGXDTieLianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.text);self.text=nil;
_UIObject_release(self.gridRoot);self.gridRoot=nil;
_UIObject_release(self.closeBg);self.closeBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.juanzhou_1);self.juanzhou_1=nil;
_UIObject_release(self.juanzhou_2);self.juanzhou_2=nil;
_UIObject_release(self.juanzhou_3);self.juanzhou_3=nil;
_UIObject_release(self.juanzhou_4);self.juanzhou_4=nil;
_UIObject_release(self.pos);self.pos=nil;
self.juanzhou=nil;
end



















function UISGXDTieLianWin:onLoaded(...)
self:bindComponents()
end


function UISGXDTieLianWin:__delete()
self:unbindComponents()
mysteryWeekActivityModel:setNewMytery(nil)
end




function UISGXDTieLianWin:onShow(argtable,afterOnloaded)
local list=mysteryWeekActivityModel:getMysteryUnitWinList()

self.gridRoot:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.gridRoot:getChildLayoutGroupGridItem(index-1)
self:refreshGrid(index,item,list[index])
end)

self.root:setChildCanvasGroupDOFade(1,0.5)
self.root:setChildDOScaleY(1,0.25)
end

function UISGXDTieLianWin:refreshGrid(index,item,data)
item:SetChildIcon(0,data.icon,true)
item:SetChildText(1,data.name)
end


function UISGXDTieLianWin:onHide()

end





function UISGXDTieLianWin:onCloseBg()
self.root:setChildCanvasGroupDOFade(0,0.5)
self.root:setChildDOScaleY(0,0.25)
self:delayDo(0.25,function()
for i=1,4 do
self.juanzhou[i]:setActive(true)
self:delayDo(0.1*i,function()
self.juanzhou[i]:setChildShowEffect(10077,true)
self.juanzhou[i]:setChildDOJump(self.pos:getChildPosition(),math.random(-1,1),1,0.75)
end)
end
self:delayDo(1,function()
self:closeSelf()
end)

end)
end

