







def_class("UIItemBatchUseWin",UIWindowBase)









function UIItemBatchUseWin:bindComponents()

self.center=UIObject.get(self,0)
self.itemContent=UIObject.get(self,1)
self.selectAll=UIToggleButton.get(self,2)
self.useBtn=UIButton.get(self,3)

self.useBtn:setButtonClick(function()self:onUseBtn()end)



end


function UIItemBatchUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.itemContent);self.itemContent=nil;
_UIObject_release(self.selectAll);self.selectAll=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
end



















local this
function UIItemBatchUseWin:onLoaded(...)
self:bindComponents()
this=self
self.selectAll:setToggleChange(function(...)self:onSelectAll(...)end)
end


function UIItemBatchUseWin:__delete()
self:unbindComponents()
this=nil
end




function UIItemBatchUseWin:onShow(argtable,afterOnloaded)
self.selectItemIndex={}
local batchUseLookup=bagUseControl.getBatchUseLookup()
self.batchUseList={}
local itemidLookup={}
for itemguidStr,_ in pairs(batchUseLookup)do
local itemguid=int64.new(itemguidStr)
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
if not itemidLookup[itemid]then
itemidLookup[itemid]=true
local itemConfig=itemsConfig.getConfig(itemid)
local sort=itemConfig.color*1000000-itemid
local itemnum=itemsModel.getCount(itemid)
table.insert(self.batchUseList,{itemid=itemid,sort=sort,itemnum=itemnum})
end
end
end
if#self.batchUseList<=0 then
return self:closeSelf()
else
table.sort(self.batchUseList,function(a,b)
return a.sort>b.sort
end)
local len=#self.batchUseList
self.itemContent:setChildLayoutGroupCreateItems(len,function(index)
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
local data=self.batchUseList[index]
local itemid=data.itemid
local itemnum=data.itemnum
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local showCountBG=itemnum>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
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
item:SetChildActive(2,false)
if index>=len then
self.selectAll:setToggle(true)
end
end)
end




end

function UIItemBatchUseWin:onSelectAll(name,on,data)
if on then
for index,_ in ipairs(self.batchUseList)do
if not self.selectItemIndex[index]then
self.selectItemIndex[index]=true
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,true)
end
end
else
for index,_ in ipairs(self.batchUseList)do
if self.selectItemIndex[index]then
self.selectItemIndex[index]=nil
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,false)
end
end
end
end

function UIItemBatchUseWin:onClickItem(itemid,index,itemguid,attach)
local item=self.itemContent:getChildLayoutGroupGridItem(index-1)
if not self.selectItemIndex[index]then
self.selectItemIndex[index]=true
item:SetChildActive(2,true)
else
self.selectItemIndex[index]=nil
item:SetChildActive(2,false)
end
end

function UIItemBatchUseWin:onLongClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end


function UIItemBatchUseWin:onUseBtn()
local use_list={}
for index,flag in pairs(self.selectItemIndex)do
if flag then
local data=self.batchUseList[index]
local itemid=data.itemid
local itemnum=data.itemnum
table.insert(use_list,{itemid,itemnum})
end
end
if#use_list<=0 then
return UIManager.info("请祖师选择需要使用的道具")
end
bagProtocolControl.req_use_item_list(#use_list,use_list)
self:closeSelf()
end