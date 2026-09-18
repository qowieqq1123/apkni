







def_class("UIAuctionRecordWin",UIWindowBase)









function UIAuctionRecordWin:bindComponents()

self.infoPanel=UIObject.get(self,0)
self.listPanel=UIObject.get(self,1)
self.nullTxt=UIText.get(self,2)
self.jifenText=UIText.get(self,3)
self.recordScroller=UIObject.get(self,4)
self.btnClose=UIButton.get(self,5)

self.btnClose:setButtonClick(function()self:onClickClose()end)



end


function UIAuctionRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.listPanel);self.listPanel=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.jifenText);self.jifenText=nil;
_UIObject_release(self.recordScroller);self.recordScroller=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end


local recordItemIndex={
itemName=0,
item=1,
msg=2,
}
















function UIAuctionRecordWin:onLoaded(...)
self:bindComponents()
end


function UIAuctionRecordWin:__delete()
self:unbindComponents()
end




function UIAuctionRecordWin:onShow(argtable,afterOnloaded)

auctionController:reqAuctionXianMengScore()
self.auctionType=AUCTION_AUCTION_TYPE.eXianMeng

auctionController:reqAuctionRecordList(self.auctionType)
self:refresh()
end


function UIAuctionRecordWin:onHide()

end

function UIAuctionRecordWin:refresh()

local jifen=auctionModel:getAuctionXianMengScore()
self.jifenText:setText(jifen)


self.recordList=auctionModel:getAuctionRecordListData(self.auctionType)or{}
local count=#self.recordList
if count>0 then
self.infoPanel:setActive(true)
self.listPanel:setActive(true)
self.nullTxt:setActive(false)
self.recordScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.recordScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshAuctionRecordItem(grids[i-1],i)
end
else
self.infoPanel:setActive(false)
self.listPanel:setActive(false)
self.nullTxt:setActive(true)
if xianmengModel:hasXM()then

self.nullTxt:setText("暂无竞拍信息")
else

self.nullTxt:setText("未加入仙盟")
end
end
end



function UIAuctionRecordWin:refreshAuctionRecordItem(item,index)
if item==nil then
item=self.recordScroller:getChildScrollViewItemWidget(index-1)
end

if item then
local recordData=self.recordList[index]

local itemid=recordData.itemid
local count=recordData.itemcount
local itemguid=auctionModel:getItemguid(recordData.auctionseries)
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget=item:GetChildWidgetBase(recordItemIndex.item)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


local itemConfig=itemsConfig.getConfig(itemid)
local itemName=itemConfig.name
item:SetChildText(recordItemIndex.itemName,itemName)


local actorName=recordData.auctionactorname
local price=recordData.auctionprice

local msgStr=FMT.fmt("<color=#ca631d>{0}</color> 以<color=#549327>{1}</color>灵玉成功竞拍",actorName,price)
item:SetChildText(recordItemIndex.msg,msgStr)
end
end


function UIAuctionRecordWin:onClickClose()
self:closeSelf()
end


function UIAuctionRecordWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end