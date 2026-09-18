







def_class("UIBatchUseWin",UIWindowBase)









function UIBatchUseWin:bindComponents()

self.item=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.btnApply=UIButton.get(self,2)
self.slider=UIObject.get(self,3)
self.add=UIButton.get(self,4)
self.cut=UIButton.get(self,5)
self.count=UIText.get(self,6)

self.btnApply:setButtonClick(function()self:onBtnApply()end)

self.add:setButtonClick(function()self:onAdd()end)

self.cut:setButtonClick(function()self:onCut()end)



end


function UIBatchUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.btnApply);self.btnApply=nil;
_UIObject_release(self.slider);self.slider=nil;
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.cut);self.cut=nil;
_UIObject_release(self.count);self.count=nil;
end



















function UIBatchUseWin:onLoaded(...)
self:bindComponents()
end


function UIBatchUseWin:__delete()
self:unbindComponents()
end




function UIBatchUseWin:onShow(argtable,afterOnloaded)
self.currVal=argtable.currVal
self.minVal=argtable.minVal
self.maxVal=argtable.maxVal
self.itemData=argtable.itemData
self.descFunc=argtable.descFunc
self.applyFunc=argtable.applyFunc
self.winlua:SetChildSliderInit(self.slider:getID(),self.currVal,self.minVal,self.maxVal,function(val)
self.currVal=val
self.count:setText(val)
local desc=self.descFunc(val)
self.desc:setText(desc)
end)

widgetHelper.setNormalRewardItem(self.winlua,self.item:getID(),self.itemData)
end


function UIBatchUseWin:onHide()

end





function UIBatchUseWin:onBtnApply()
self.applyFunc(self.currVal)
self:onCloseClick()
end



function UIBatchUseWin:onAdd()
if self.currVal<self.maxVal then
self.currVal=self.currVal+1
self.winlua:SetChildSliderValue(self.slider:getID(),self.currVal)
end
end



function UIBatchUseWin:onCut()
if self.currVal>self.minVal then
self.currVal=self.currVal-1
self.winlua:SetChildSliderValue(self.slider:getID(),self.currVal)
end
end

function UIBatchUseWin:onCloseClick()
self:closeSelf()
end