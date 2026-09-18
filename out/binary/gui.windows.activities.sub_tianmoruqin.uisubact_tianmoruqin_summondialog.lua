







def_class("UISubAct_TianMoRuQin_SummonDialog",UIWindowBase)









function UISubAct_TianMoRuQin_SummonDialog:bindComponents()

self.background=UIButton.get(self,0)
self.summonBtn=UIButton.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.tips=UIText.get(self,3)
self.itemList=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.summonBtn:setButtonClick(function()self:onSummonBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_TianMoRuQin_SummonDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.summonBtn);self.summonBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _this=nil
local _itemCmp={
item=0,
selected=1,
}



function UISubAct_TianMoRuQin_SummonDialog:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
self.selected=nil
end


function UISubAct_TianMoRuQin_SummonDialog:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end




function UISubAct_TianMoRuQin_SummonDialog:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.data=argtable.items
local count=#self.data
self.itemCounts={}
self.itemList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local itemData=self.data[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local haveNum=itemsModel.getCount(itemId)
local showCountBG=haveNum>1
local countStr=showCountBG and haveNum or""
local gray=haveNum<itemNum and 1 or 0
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_itemCmp.item,prop)
item:SetBaseItemClickEvent(_itemCmp.item,function(...)
self:onClickItem(index)
end)
item:SetBaseItemLongTouchEvent(_itemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_itemCmp.selected,self.selected==index)
self.itemCounts[itemId]=index
end)
local tipsStr=self.selected and self.data[self.selected][3]or""
self.tips:setText(tipsStr)
end


function UISubAct_TianMoRuQin_SummonDialog:onHide()

end




function UISubAct_TianMoRuQin_SummonDialog:onSummonBtn()
if self.selected then
local itemData=self.data[self.selected]
local itemId=itemData[1]
local itemNum=itemData[2]
local haveNum=itemsModel.getCount(itemId)
if haveNum>=itemNum then
if self.callback then
self.callback(self.selected)
end
self:closeSelf()
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
end
else
UIManager.error("请先选择需要使用的道具")
end
end

function UISubAct_TianMoRuQin_SummonDialog:onCancelBtn()
self:closeSelf()
end

function UISubAct_TianMoRuQin_SummonDialog:onBackground()
self:closeSelf()
end

function UISubAct_TianMoRuQin_SummonDialog:onCloseBtn()
self:closeSelf()
end

function UISubAct_TianMoRuQin_SummonDialog:onClickItem(index)
if self.selected~=index then
if self.selected then
local item=self.itemList:getChildLayoutGroupGridItem(self.selected-1)
item:SetChildActive(_itemCmp.selected,false)
end
self.selected=index
local item=self.itemList:getChildLayoutGroupGridItem(self.selected-1)
item:SetChildActive(_itemCmp.selected,true)

local tipsStr=self.selected and self.data[self.selected][3]or""
self.tips:setText(tipsStr)
end
end

function UISubAct_TianMoRuQin_SummonDialog.on_money_changed(moneyType,lastVal,val)
if _this.itemCounts[moneyType]then
local index=_this.itemCounts[moneyType]
local item=_this.itemList:getChildLayoutGroupGridItem(index-1)
local itemData=_this.data[index]
local itemNum=itemData[2]
local haveNum=val
local old=lastlv<itemNum
local new=val<itemNum
local showCountBG=haveNum>1
local countStr=showCountBG and haveNum or""
local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
if old~=new then
prop[PropIndex(DataPropKey.eWidgetGray,0)]=new
prop[PropIndex(DataPropKey.eWidgetGray,1)]=new
prop[PropIndex(DataPropKey.eWidgetActive,7)]=new
end
item:SetChildPropData(_itemCmp.item,prop)
end
end

function UISubAct_TianMoRuQin_SummonDialog.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this.itemCounts[itemid]then
local index=_this.itemCounts[itemid]
local item=_this.itemList:getChildLayoutGroupGridItem(index-1)
local itemData=_this.data[index]
local itemNum=itemData[2]
local haveNum=newcount
local old=oldcount<itemNum
local new=newcount<itemNum
local showCountBG=haveNum>1
local countStr=showCountBG and haveNum or""
local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
if old~=new then
prop[PropIndex(DataPropKey.eWidgetGray,0)]=new
prop[PropIndex(DataPropKey.eWidgetGray,1)]=new
prop[PropIndex(DataPropKey.eWidgetActive,7)]=new
end
item:SetChildPropData(_itemCmp.item,prop)
end
end