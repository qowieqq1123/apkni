







def_class("UIItemExpireSellTipWin",UIWindowBase)









function UIItemExpireSellTipWin:bindComponents()

self.center=UIObject.get(self,0)
self.costCount=UIText.get(self,1)
self.costIcon=UIImage.get(self,2)
self.itemContent=UIObject.get(self,3)
self.selectAll=UIToggleButton.get(self,4)
self.useBtn=UIButton.get(self,5)

self.useBtn:setButtonClick(function()self:onUseBtn()end)



end


function UIItemExpireSellTipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.itemContent);self.itemContent=nil;
_UIObject_release(self.selectAll);self.selectAll=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
end
















local this




function UIItemExpireSellTipWin:onLoaded(...)
self:bindComponents()
this=self
self.selectAll:setToggleChange(function(...)self:onSelectAll(...)end)
end


function UIItemExpireSellTipWin:__delete()
self:unbindComponents()
this=nil
end




function UIItemExpireSellTipWin:onShow(argtable,afterOnloaded)
self.selectItemIndex={}

local batchSellLookup=bagUseControl.getBatchSellLookup()
self.batchSellList={}
for itemguidStr,_ in pairs(batchSellLookup)do
local itemguid=int64.new(itemguidStr)
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local itemcount=item.itemcount
local itemConfig=itemsConfig.getConfig(itemid)
local sort=itemConfig.color*1000000-itemid
table.insert(self.batchSellList,{itemid=itemid,itemguid=itemguid,sort=sort,itemnum=itemcount})
end
end

if not next(self.batchSellList)then
return self:closeSelf()
else
table.sort(self.batchSellList,function(a,b)
return a.sort>b.sort
end)
local len=#self.batchSellList
self.itemContent:setChildLayoutGroupCreateItems(len,function(index)
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
local data=self.batchSellList[index]
local itemid=data.itemid
local itemguid=data.itemguid
local itemnum=data.itemnum
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local showCountBG=itemnum>1
local conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemChildIndex(1,index)
item:SetBaseItemClickEvent(1,function(...)
if not self or self.isClose then return end
self:onClickItem(...)
end)
item:SetBaseItemLongTouchEvent(1,function(...)
if not self or self.isClose then return end
self:onLongClickItem(...)
end)
item:SetChildPropData(1,prop)
item:SetBaseItemChildGUID(1,itemguid)


local widget=item:GetChildWidgetBase(1)
widget:SetChildGray(1,true)
widgetHelper.setItemQulaity(widget,itemid,0,0)

item:SetChildActive(2,false)
if index>=len then
self.selectAll:setToggle(true)
end
end)
end

end


function UIItemExpireSellTipWin:onHide()

end

function UIItemExpireSellTipWin:onSelectAll(name,on,data)
if on then
for index,_ in ipairs(self.batchSellList)do
if not self.selectItemIndex[index]then
self.selectItemIndex[index]=true
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,true)
end
end
else
for index,_ in ipairs(self.batchSellList)do
if self.selectItemIndex[index]then
self.selectItemIndex[index]=nil
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,false)
end
end
end
self:refreshCost()
end

function UIItemExpireSellTipWin:onClickItem(itemid,index,itemguid,attach)
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
if not self.selectItemIndex[index]then
self.selectItemIndex[index]=true
item:SetChildActive(2,true)
else
self.selectItemIndex[index]=nil
item:SetChildActive(2,false)
end
self:refreshCost()
end

function UIItemExpireSellTipWin:onLongClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end

function UIItemExpireSellTipWin:refreshCost()
local num=0
for index,flag in pairs(self.selectItemIndex)do
if flag then
local data=self.batchSellList[index]
local itemid=data.itemid
local itemnum=data.itemnum

local itemConfig=itemsConfig.getConfig(itemid)
local dealPrice=itemConfig.dealPrice
num=num+dealPrice[2]*itemnum
end
end
self.costCount:setText(FMT.fmt("<color=#7d3b17>{0}</color>",num))
end




function UIItemExpireSellTipWin:onUseBtn()
local sell_list={}
for index,flag in pairs(self.selectItemIndex)do
if flag then
local data=self.batchSellList[index]
local itemid=data.itemid
local itemguid=data.itemguid
local itemnum=data.itemnum
table.insert(sell_list,{itemguid,itemnum})
end
end
if#sell_list<=0 then
return UIManager.info("请祖师选择需要出售的道具")
end
bagProtocolControl.req_sell_item_list(#sell_list,sell_list)
self:closeSelf()
end

