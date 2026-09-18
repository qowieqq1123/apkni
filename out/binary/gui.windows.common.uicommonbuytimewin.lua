







def_class("UICommonBuyTimeWin",UIWindowBase)









function UICommonBuyTimeWin:bindComponents()

self.name=UIText.get(self,0)
self.desc=UIText.get(self,1)
self.item=UIBaseItem.get(self,2)
self.title=UIText.get(self,3)
self.btnDel=UIButton.get(self,4)
self.btnAdd=UIButton.get(self,5)
self.num=UIText.get(self,6)
self.btnUp=UIButton.get(self,7)

self.btnDel:setButtonClick(function()self:onBtnDel()end)

self.btnAdd:setButtonClick(function()self:onBtnAdd()end)

self.btnUp:setButtonClick(function()self:onBtnUp()end)



end


function UICommonBuyTimeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btnDel);self.btnDel=nil;
_UIObject_release(self.btnAdd);self.btnAdd=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.btnUp);self.btnUp=nil;
end


















function UICommonBuyTimeWin:onLoaded(...)
self:bindComponents()
self.item:setBaseItemClickEvent(function(...)itemsComponentHelper.onItemClick(...)end)
end

function UICommonBuyTimeWin:__delete()
self.item:setBaseItemClickEvent(nil)
self:unbindComponents()
end

function UICommonBuyTimeWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
local max=argtable.max
local costfunc=argtable.costfunc
local name=argtable.name
local desc=argtable.desc
local clickfunc=argtable.clickfunc
local numTitle=argtable.numTitle

self.clickfunc=clickfunc
self.max=max
self.costfunc=costfunc
self.itemid=itemid
self.numVal=1
self.title:setText(numTitle)
self.desc:setText(desc)
self.name:setText(name)
self:freshVal()
self:freshItemCost()
self:setItem(itemid)
end

function UICommonBuyTimeWin:onHide()

end


function UICommonBuyTimeWin:freshVal()
self.num:setText(FMT.fmt('{0}/{1}',self.numVal,self.max))
end

function UICommonBuyTimeWin:setItem(itemid)
local item={itemid=itemid}
local isEnough=self.hasItemNum>=self.costItemNum
local grayNum=isEnough and 0 or self.hasItemNum==0 and 3 or 2
local count=FMT.fmt('{0}/{1}',self.hasItemNum,self.costItemNum)
local conf={showname=false,itemcount=count,gray=grayNum}
local porp=itemsComponentHelper.getCommonFillData(item,conf)
self.item:setChildPropData(porp)
end

function UICommonBuyTimeWin:freshItemCost()
if self.costfunc then
self.hasItemNum=bagControl.invokeFuncByItemId(self.itemid,'getItemCountByItemID',self.itemid)
self.costItemNum=self.costfunc(self.numVal)
end
end

function UICommonBuyTimeWin:freshItemCount()
local isEnough=self.hasItemNum>=self.costItemNum
local count=FMT.fmt('{0}/{1}',self.hasItemNum,self.costItemNum)
local grayNum=isEnough and 0 or self.hasItemNum==0 and 3 or 2
local isGray=mathHelper.getBitValue(grayNum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(grayNum,eGrayType.eMaskGray-1)
self.item:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,4,count)
self.item:setChildItemDataByDataPropKey(DataPropKey.eWidgetGray,2,isGray)
self.item:setChildItemDataByDataPropKey(DataPropKey.eWidgetGray,3,isGray)
self.item:setChildItemDataByDataPropKey(DataPropKey.eWidgetActive,8,isGrayMask)
end



function UICommonBuyTimeWin:onBtnDel()
if self.numVal<=1 then return end
self.numVal=self.numVal-1
self:freshVal()
self:freshItemCost()
self:freshItemCount()
end



function UICommonBuyTimeWin:onBtnAdd()
if self.numVal>=self.max then return end
self.numVal=self.numVal+1
self:freshVal()
self:freshItemCost()
self:freshItemCount()
end



function UICommonBuyTimeWin:onBtnUp()
if self.costItemNum>self.hasItemNum then
local name=itemsConfig.getConfig(self.itemid).name
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(self.itemid)
return
end
if self.clickfunc then
self.clickfunc(self.numVal)
end
self:closeSelf()
end

