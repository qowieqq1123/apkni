







def_class("tipsChildYuHuoSelectQuantity",UICloneObject)





tipsChildYuHuoSelectQuantity.abName="ui/windows/tips/child/tipschildyuhuoselectquantity.ab"

tipsChildYuHuoSelectQuantity.assetName="tipsChildYuHuoSelectQuantity"


function tipsChildYuHuoSelectQuantity:bindComponents()

self.cutBtn=UIButton.get(self,0)
self.addBtn=UIButton.get(self,1)
self.countSlider=UIObject.get(self,2)
self.title=UIText.get(self,3)

self.cutBtn:setButtonClick(function()self:onCutBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

end


function tipsChildYuHuoSelectQuantity:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cutBtn);self.cutBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.countSlider);self.countSlider=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildYuHuoSelectQuantity:onLoaded(...)
self:bindComponents()
end


function tipsChildYuHuoSelectQuantity:__delete()
self:unbindComponents()
end




function tipsChildYuHuoSelectQuantity:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid

self.maxNum=bagModel.getItemCountById(itemid)
self.currNum=1
self:setCount()
self.countSlider:setChildSliderInit(self.currNum,1,self.maxNum,function(...)self:onSliderChange(...)end)
end

function tipsChildYuHuoSelectQuantity:setCount()
self.title:setText(FMT.fmt('数量：<color=#d6d6d6>{0}/{1}</color>',self.currNum,self.maxNum))
end

function tipsChildYuHuoSelectQuantity:onSliderChange(val)
if val~=self.currNum then
self:setCount()
end
end


function tipsChildYuHuoSelectQuantity:onHide()

end


