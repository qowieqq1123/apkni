







def_class("UIXianGongChaoGongRechangeWin",UIWindowBase)









function UIXianGongChaoGongRechangeWin:bindComponents()

self.addBtn=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.itemList=UIObject.get(self,4)
self.okButton=UIButton.get(self,5)
self.selectCntSlider=UIObject.get(self,6)
self.selectCntText=UIText.get(self,7)
self.subBtn=UIObject.get(self,8)
self.target=UIBaseItem.get(self,9)

self.background:setButtonClick(function()self:onBackground()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIXianGongChaoGongRechangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.target);self.target=nil;
end















local _this=nil



function UIXianGongChaoGongRechangeWin:onLoaded(...)
self:bindComponents()
_this=self
self.winlua:SetChildLongPress(self.addBtn:getID(),0,function(id)
self:onAddBtn()
end,nil)
self.winlua:SetChildLongPress(self.subBtn:getID(),0,function(id)
self:onSubBtn()
end,nil)
end


function UIXianGongChaoGongRechangeWin:__delete()
self:unbindComponents()
_this=self
end




function UIXianGongChaoGongRechangeWin:onShow(argtable,afterOnloaded)
self.shopId=argtable.shopId
self.buyId=argtable.buyId
self.maxNum=argtable.maxNum
self.minNum=argtable.minNum or 0
self.parentWin=argtable.parentWin
self.config=funcShopModel.get_shop_item_conf(self.shopId,self.buyId)
self.selectNum=self.selectNum and Math.Clamp(self.selectNum,self.minNum,self.maxNum)or self.minNum

self.selectCntSlider:setChildSliderInit(self.selectNum,self.minNum,self.maxNum,function(value)
self:onSliderChange(value)
end)

local targetConf={itemid=self.config.itemId,itemcount=self.config.itemNum*self.selectNum,showCountBG=true,showname=false,showStage=true}
local targetProp=itemsComponentHelper.getCommonFillDataSmall(targetConf)
self.target:setChildPropData(targetProp)
self.target:setBaseItemClickEvent(itemsComponentHelper.onItemClickEx)

local rewards=self.config.consume or{self.config.money}
self.itemList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local reward=rewards[index]
local _conf={itemid=reward[1],itemcount="",showCountBG=false,showname=false,showStage=false}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(0,_prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildText(1,FMT.fmt("{0}/{1}",self.selectNum*reward[2],reward[2]))
end)
self.winlua:ForceLayoutRect(self.itemList:getID())
end


function UIXianGongChaoGongRechangeWin:onHide()

end




function UIXianGongChaoGongRechangeWin:onAddBtn()
if self.selectNum<self.maxNum then
self.selectCntSlider:setChildSliderValue(self.selectNum+1)
end
end


function UIXianGongChaoGongRechangeWin:onBackground()
self:onCloseBtn()
end


function UIXianGongChaoGongRechangeWin:onCancelButton()
self:onCloseBtn()
end


function UIXianGongChaoGongRechangeWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianGongChaoGongRechangeWin:onOkButton()
if self.selectNum>0 then
funcShopController.send_23_2(self.shopId,self.buyId,self.selectNum)
self:onCloseBtn()
else
UIManager.info("请先选择兑换的数量")
end
end


function UIXianGongChaoGongRechangeWin:onSubBtn()
if self.selectNum>self.minNum then
self.selectCntSlider:setChildSliderValue(self.selectNum-1)
end
end

function UIXianGongChaoGongRechangeWin:onSliderChange(value)
self.selectNum=value
self.selectCntText:setText(value)

local rewards=self.config.consume or{self.config.money}
local items=self.itemList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
local reward=rewards[i]
item:SetChildText(1,FMT.fmt("{0}/{1}",value*reward[2],reward[2]))
end

local prop={}
prop[PropIndex(DataPropKey.eWidgetText,3)]=self.config.itemNum*self.selectNum
self.target:setChildPropData(prop)
end