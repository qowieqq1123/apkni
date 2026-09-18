







def_class("UIAuctionWin",UIWindowBase)









function UIAuctionWin:bindComponents()

self.itemTypeScrollView=UIObject.get(self,0)
self.itemScroller=UIObject.get(self,1)
self.timeText=UIText.get(self,2)
self.recordBtn=UIButton.get(self,3)
self.nullTxt=UIText.get(self,4)
self.refreshBtn=UIButton.get(self,5)
self.tipsText=UIText.get(self,6)
self.refreshBtnText=UIText.get(self,7)
self.Content=UIObject.get(self,8)
self.remainderQuota=UIText.get(self,9)
self.quotaIcon=UIImage.get(self,10)
self.effect_wan=UIObject.get(self,11)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)
self.effect={
["wan"]=self.effect_wan,
}



end


function UIAuctionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemTypeScrollView);self.itemTypeScrollView=nil;
_UIObject_release(self.itemScroller);self.itemScroller=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.refreshBtnText);self.refreshBtnText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.remainderQuota);self.remainderQuota=nil;
_UIObject_release(self.quotaIcon);self.quotaIcon=nil;
_UIObject_release(self.effect_wan);self.effect_wan=nil;
self.effect=nil;
end
















local auctionItemIndex={
name=0,
state=1,
item=2,
nowPriceIcon=3,
nowPriceText=4,
biddingBtn=5,
biddingFlag=6,
buyPriceIcon=7,
buyPriceText=8,
buyBtn=9,
remainingTime=10,
hotFlag=11,
selectBg=12,
autojjBtn=13,
autotxt=14,
autotxt2=15,
}

local _scrollLen=6
local MaxValue=200
local RefreshBtnCd=3
local _this
local _creatGirdPrecent=10


local itemType1ToMainType={
[itemtype1Type.eEquip]=ITEM_MAIN_TYPE.eEquip,
[itemtype1Type.eMetrials]=ITEM_MAIN_TYPE.eMaterials,
[itemtype1Type.eGuBao]=ITEM_MAIN_TYPE.eGubao,
[itemtype1Type.eFaBao]=ITEM_MAIN_TYPE.eFabao,
[itemtype1Type.eFuBao]=ITEM_MAIN_TYPE.eFubao,
[itemtype1Type.eFaBaoYP]=ITEM_MAIN_TYPE.eFabaoYuanPei,
}




function UIAuctionWin:onLoaded(...)
_this=self
self:bindComponents()

self._on_it_item_click=function(...)
self:on_it_item_click(...)
end
self.itemTypeScrollView:setChildScrollViewInit(0,true,self._on_it_item_click,nil)
self.loopListView=self.winlua:GetChildUILoopListView(self.itemScroller:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScroller:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
self:addNotify(notifyConfig.building_event,self.on_building_event)
end


function UIAuctionWin:__delete()
self:clearTimer()
self.loopListView:SetAction(nil,nil)
self.loopListView=nil
self:unbindComponents()
_this=nil
end




function UIAuctionWin:onShow(argtable,afterOnloaded)

local effectId=10256
self.effect_wan:setChildShowEffect(effectId,true)
self.effect_wan:setActive(true)

self.auctionCfg=cfgHelper.get(cfg_auctionconfig_get,1)

self.itemTypeList=self.auctionCfg.itemTypeList
self.auctionType=AUCTION_AUCTION_TYPE.eXianMeng
self:onShowArgRecv(argtable,afterOnloaded)
end

function UIAuctionWin:onShowArgRecv(argtable,afterOnloaded)
if argtable and argtable.serverType then
self.serverType=argtable.serverType
end

self.itSelectIndex=1
if argtable and argtable.selectItemType then

for index,type in pairs(self.itemTypeList)do
if type.filterType==argtable.selectItemType then
self.itSelectIndex=index
end
end
end

self.selfActorId=playerModel:getActorID()


if self.serverType==AUCTION_SERVER_TYPE.eLocal then

auctionController:reqAuctionListData(self.serverType,self.auctionType,1,MaxValue)
elseif self.serverType==AUCTION_SERVER_TYPE.eCross then

auctionController:reqCrossAuctionListData(self.serverType,self.auctionType,1,MaxValue)
end

self:refresh()
end


function UIAuctionWin:onHide()
self.effect_wan:setActive(false)
self:clearTimer()
end

function UIAuctionWin:refresh(isBiddingRecv)

if not xianmengModel:hasXM()then
self.auctionList={}
else
self.auctionList=auctionModel:getAuctionListData(self.serverType,self.auctionType)or{}
end

self:refreshItemTypeList()
self:selectItemType(self.itSelectIndex,isBiddingRecv)


local tipsStr=""
local isShowTips=false

if self.serverType==AUCTION_SERVER_TYPE.eLocal then

if self.auctionCfg.xianmengTips then
isShowTips=true
tipsStr=self.auctionCfg.xianmengTips
end
self.recordBtn:setActive(true)
else

if self.auctionCfg.crossTips then
isShowTips=true
tipsStr=self.auctionCfg.crossTips
end
self.recordBtn:setActive(false)
end
self.tipsText:setText(tipsStr)
self.tipsText:setActive(isShowTips)


self:refreshQuota()


self.timeText:setActive(false)
end


function UIAuctionWin:refreshQuota()
local remainderQuota=auctionModel:getRemainderQuota(self.serverType,self.auctionType)
self.remainderQuota:setText(remainderQuota)
local moneyType=eMoneyType.mtLingYu
self.quotaIcon:setChildIcon(iconHelper.getIconName(moneyType),false)
end


function UIAuctionWin:refreshItemTypeList()
local typeCount=#self.itemTypeList
self.winlua:SetChildScrollRectEnable(self.itemTypeScrollView:getID(),typeCount>_scrollLen)
self.itemTypeScrollView:setChildScrollViewCreateGrids(typeCount,0)
local grids=self.itemTypeScrollView:getChildScrollViewItemWidgets()
local count=typeCount
for i=0,count-1 do
local item=grids[i]
local index=i+1

item:SetChildActive(2,self.itSelectIndex==index)

local nameStr=""
if self.itSelectIndex~=index then
nameStr=FMT.fmt("<color=#ffe3bc>{0}</color>",self.itemTypeList[index].name)
else
nameStr=self.itemTypeList[index].name
end
item:SetChildText(1,nameStr)
end
end

function UIAuctionWin:onStartView()

end

function UIAuctionWin:onFreshListView(index,widget)
index=index+1
self:refreshAuctionItem(widget,index)
end


function UIAuctionWin:refreshAuctionItemList_reset(isKeepPos)
local originalCount=self.auctionItemList and#self.auctionItemList or 0


self.auctionItemList=self:sortAuctionItemList()


self:clearTimer()

local count=#self.auctionItemList
local prefabNameList={}
local itemIdList={}
for i=1,count do
prefabNameList[i]="auctionItem"
itemIdList[i]=i
end
if not isKeepPos then
self.loopListView:InitDataList(count,prefabNameList,itemIdList,nil,nil)
self.loopListView:JumpIndex(0)
else
if originalCount<count then

local addPrefabNameList={}
local addItemIdList={}
for i=originalCount+1,count do
addPrefabNameList[#addPrefabNameList+1]="auctionItem"
addItemIdList[#addItemIdList+1]=i
end
self.loopListView:AddItemList(#addItemIdList,addPrefabNameList,addItemIdList,nil,nil)
elseif originalCount>count then

local deleteItemIdList={}
for i=count+1,originalCount do
deleteItemIdList[#deleteItemIdList+1]=i
end
self.loopListView:DeleteItemListByItemId(deleteItemIdList)
end

local nowShowItemCount=self.loopListViewCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshAuctionItem(item.Widget,index)
end
end
end

if count>0 then
self.nullTxt:setActive(false)
else
self.nullTxt:setActive(true)
if xianmengModel:hasXM()then

self.nullTxt:setText("暂无拍卖品")
else

self.nullTxt:setText("未加入仙盟")
end
end

local cur=auctionModel:getRefreshCdTime()
local isRefreshBtnAvailable=cur<=0

if isRefreshBtnAvailable then

self.refreshBtnText:setText("刷新")
else

local cdStr=FMT.fmt("刷新({0})",cur)
self.refreshBtnText:setText(cdStr)
end


self:setRemainingTimeTimer()














end


function UIAuctionWin:refreshAuctionItemList_notReset(needSort)
if needSort then

self.auctionItemList=self:sortAuctionItemList()
end

local count=#self.auctionItemList
local nowTime=gameUtilityModel.getServerShortTime()
local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshAuctionItemTime(item.Widget,index,nowTime)
end
end

if count>0 then
self.nullTxt:setActive(false)
else
self.nullTxt:setActive(true)
if xianmengModel:hasXM()then

self.nullTxt:setText("暂无拍卖品")
else

self.nullTxt:setText("未加入仙盟")
end
end

local cur=auctionModel:getRefreshCdTime()
local isRefreshBtnAvailable=cur<=0

if isRefreshBtnAvailable then

self.refreshBtnText:setText("刷新")
else

local cdStr=FMT.fmt("刷新({0})",cur)
self.refreshBtnText:setText(cdStr)
end

if count<=0 and isRefreshBtnAvailable then

self:clearTimer()
end
end


function UIAuctionWin:refreshAuctionItem(item,index)
if item then
local auctionData=self.auctionItemList[index]

local itemid=auctionData.itemid
local itemguid=auctionModel:getItemguid(auctionData.auctionseries)
local count=auctionData.itemcount
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isShowStage=itemsConfig.isMaterials(itemid)
local conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=isShowStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local isEquip=itemsConfig.isEquip(itemid)
local suitIcon=equipsHelper.getEquipSuitIcon(auctionData)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=isEquip
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon

local widget=item:GetChildWidgetBase(auctionItemIndex.item)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


local itemConfig=itemsConfig.getConfig(itemid)
local itemName=itemConfig.name
item:SetChildText(auctionItemIndex.name,itemName)


local nowTime=gameUtilityModel.getServerShortTime()
local isEnd=false
local isNeedRefresh=false
if auctionData.auctionsec then
local lerp=auctionData.auctionsec-nowTime
if lerp>0 then
local timeStr=nil

timeStr=timeHelper.format_time_stamp11(lerp,true)
item:SetChildText(auctionItemIndex.remainingTime,FMT.fmt("{0}",timeStr))
else
isEnd=true
if self.serverType==AUCTION_SERVER_TYPE.eCross then

isNeedRefresh=true
item:SetChildText(auctionItemIndex.remainingTime,"待刷新")
else

item:SetChildText(auctionItemIndex.remainingTime,"已结束")
end
end
end


if not isEnd then

item:SetChildButtonClick(auctionItemIndex.biddingBtn,function()
self:onClickBiddingBtn(auctionData.auctionseries)
end)
item:SetChildButtonClick(auctionItemIndex.buyBtn,function()
self:onClickBuyBtn(auctionData.auctionseries)
end)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,function()
self:onautoClickBiddingBtn(auctionData.auctionseries,auctionData)
end)
else

local endFun
if not isNeedRefresh then
endFun=function()
UIManager.error("此拍卖品已经结束竞拍了")
end
else
endFun=function()
UIManager.error("请刷新拍卖品状态")
end
end
item:SetChildButtonClick(auctionItemIndex.biddingBtn,endFun)
item:SetChildButtonClick(auctionItemIndex.buyBtn,endFun)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,endFun)
end


local isBidding=auctionData.auctionactorid==self.selfActorId

local myselfvalue=0
local isselfauto=false
if auctionData.autoList then
for k,v in ipairs(auctionData.autoList)do
if mathHelper.compareInt64(v.param_1,self.selfActorId)then
isselfauto=true
myselfvalue=v.param_2
break
end
end
end

local biddingFlag=isBidding
local biddingBtnFlag=not isBidding
if isselfauto then
biddingFlag=false
biddingBtnFlag=false
end
item:SetChildActive(auctionItemIndex.biddingFlag,biddingFlag)
item:SetChildActive(auctionItemIndex.biddingBtn,biddingBtnFlag)

item:SetChildActive(auctionItemIndex.autojjBtn,isselfauto)

local nowPrice=auctionData.auctionprice
local moneyType=eMoneyType.mtLingYu
local moneyCount=nowPrice

if isselfauto and myselfvalue<=nowPrice then
item:SetChildActive(auctionItemIndex.autotxt,false)
item:SetChildActive(auctionItemIndex.autotxt2,true)
else
item:SetChildActive(auctionItemIndex.autotxt,true)
item:SetChildActive(auctionItemIndex.autotxt2,false)
end


item:SetChildActive(auctionItemIndex.nowPriceIcon,true)
item:SetChildIcon(auctionItemIndex.nowPriceIcon,iconHelper.getIconName(moneyType),false)

item:SetChildText(auctionItemIndex.nowPriceText,FMT.fmt("{0}",moneyCount))

local minimumSinglePrice=itemConfig.auction and itemConfig.auction[1]or nil
local minimumPrice=minimumSinglePrice and minimumSinglePrice*count or auctionData.auctionprice
local isMinimumPrice=mathHelper.compareInt64(auctionData.auctionactorid,int64.new(0))and auctionData.auctionprice==minimumPrice
local stateStr=isMinimumPrice and"<color=#549327>[底价]</color>"or"<color=#ca631d>[竞拍中]</color>"
stateStr=(isEnd and not isNeedRefresh)and"<color=#747474>[拍卖结束]</color>"or stateStr
item:SetChildText(auctionItemIndex.state,stateStr)


local singleBuyPrice=itemConfig.auction and itemConfig.auction[3]or nil
local buyPrice=singleBuyPrice and singleBuyPrice*count or auctionData.auctionprice
moneyCount=buyPrice

item:SetChildActive(auctionItemIndex.buyPriceIcon,true)
item:SetChildIcon(auctionItemIndex.buyPriceIcon,iconHelper.getIconName(moneyType),false)

item:SetChildText(auctionItemIndex.buyPriceText,FMT.fmt("{0}",moneyCount))


local isHot=auctionData.times>=self.auctionCfg.hotCount
item:SetChildActive(auctionItemIndex.hotFlag,isHot)
end
end


function UIAuctionWin:refreshAuctionItemTime(item,index,nowTime)
if item then
local auctionData=self.auctionItemList[index]

local isEnd=false
local isNeedRefresh=false
if auctionData.auctionsec then
local lerp=auctionData.auctionsec-nowTime
if lerp>0 then
local timeStr=nil

timeStr=timeHelper.format_time_stamp11(lerp,true)
item:SetChildText(auctionItemIndex.remainingTime,FMT.fmt("{0}",timeStr))
else
isEnd=true
if self.serverType==AUCTION_SERVER_TYPE.eCross then

isNeedRefresh=true
item:SetChildText(auctionItemIndex.remainingTime,"待刷新")
else

item:SetChildText(auctionItemIndex.remainingTime,"已结束")
end
end
end


if isEnd and not isNeedRefresh then
item:SetChildText(auctionItemIndex.state,"<color=#747474>[拍卖结束]</color>")
end


if not isEnd then

item:SetChildButtonClick(auctionItemIndex.biddingBtn,function()
self:onClickBiddingBtn(auctionData.auctionseries)
end)
item:SetChildButtonClick(auctionItemIndex.buyBtn,function()
self:onClickBuyBtn(auctionData.auctionseries)
end)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,function()
self:onautoClickBiddingBtn(auctionData.auctionseries,auctionData)
end)
else

local endFun
if not isNeedRefresh then
endFun=function()
UIManager.error("此拍卖品已经结束竞拍了")
end
else
endFun=function()
UIManager.error("请刷新拍卖品状态")
end
end
item:SetChildButtonClick(auctionItemIndex.biddingBtn,endFun)
item:SetChildButtonClick(auctionItemIndex.buyBtn,endFun)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,endFun)
end
end
end


function UIAuctionWin:selectItemType(itIndex,isKeepPos)
if itIndex~=self.itSelectIndex then
local item=self.itemTypeScrollView:getChildScrollViewItemWidget(self.itSelectIndex-1)
item:SetChildActive(2,false)
local nameStr=FMT.fmt("<color=#ffe3bc>{0}</color>",self.itemTypeList[self.itSelectIndex].name)
item:SetChildText(1,nameStr)

item=self.itemTypeScrollView:getChildScrollViewItemWidget(itIndex-1)
item:SetChildActive(2,true)
nameStr=self.itemTypeList[itIndex].name
item:SetChildText(1,nameStr)

self.itSelectIndex=itIndex
end


self.filterList=self:filterAuctionItemList()

self:refreshAuctionItemList_reset(isKeepPos)
end


function UIAuctionWin:filterAuctionItemList()
local selectType=self.itemTypeList[self.itSelectIndex]
local itemList={}
for i,v in ipairs(self.auctionList)do
local isInset=false

if not v.isHide then

if selectType.filterType==1 then

isInset=true
elseif selectType.filterType==2 then

if v.auctionactorid==self.selfActorId then
isInset=true
else

local auctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'auctionSelfBiddingList',{})
local auctionSeriesStr=tostring(v.auctionseries)
if auctionSelfBiddingList[auctionSeriesStr]then

isInset=true
end
end
elseif selectType.filterType==3 then

if selectType.itemType and next(selectType.itemType)then
local itemType=itemsConfig.getConfig(v.itemid).type1
local itemMainType=itemsConfig.getMainType(v.itemid)
for j=1,#selectType.itemType do
local targetItemType1=selectType.itemType[j]
if itemType1ToMainType[targetItemType1]then

local targetItemMainType=itemType1ToMainType[targetItemType1]
if itemMainType==targetItemMainType then
isInset=true
break
end
else
if itemType==selectType.itemType[j]then
isInset=true
break
end
end
end
else
logErr(FMT.fmt("道具分类页签【{0}】类型为\"筛选道具\"，但没有找到筛选的道具类型，请检查配置是否正确",selectType.name))

isInset=true
end
elseif selectType.filterType==4 then

if selectType.itemType and next(selectType.itemType)then

local isExcept=false
local itemType=itemsConfig.getConfig(v.itemid).type1
local itemMainType=itemsConfig.getMainType(v.itemid)
for j=1,#selectType.itemType do
local targetItemType1=selectType.itemType[j]
if itemType1ToMainType[targetItemType1]then

local targetItemMainType=itemType1ToMainType[targetItemType1]
if itemMainType==targetItemMainType then
isExcept=true
break
end
else
if itemType==selectType.itemType[j]then
isExcept=true
break
end
end
end

if not isExcept then
isInset=true
end
else
logErr(FMT.fmt("道具分类页签【{0}】类型为\"其他道具\"，但没有找到需要剔除的道具类型，请检查配置是否正确",selectType.name))
end
else
logErr(FMT.fmt("道具分类页签【{0}】找不到筛选类型filterType，请检查配置是否正确",selectType.name))
end
end

if isInset then
itemList[#itemList+1]=v
end
end

return itemList
end


function UIAuctionWin:sortAuctionItemList()
local sort_func=function(a,b)
local item_id1=a.itemid
local item_id2=b.itemid
local itemCfg1=itemsConfig.getConfig(item_id1)
local itemCfg2=itemsConfig.getConfig(item_id2)
local quality1=itemCfg1.color
local quality2=itemCfg2.color
local item_type1=itemCfg1.type1 or 2
local item_type2=itemCfg2.type1 or 2
local nowPrice1=a.auctionprice
local nowPrice2=b.auctionprice
local biddingWeight1=a.auctionactorid==self.selfActorId and 100 or 0
local biddingWeight2=b.auctionactorid==self.selfActorId and 100 or 0
local hotWeight1=a.times>=self.auctionCfg.hotCount and 100 or 0
local hotWeight2=b.times>=self.auctionCfg.hotCount and 100 or 0

if biddingWeight1==biddingWeight2 then
if hotWeight1==hotWeight2 then
if nowPrice1==nowPrice2 then
if quality1==quality2 then
return item_type1>item_type2
else
return quality1>quality2
end
else
return nowPrice1>nowPrice2
end
else
return hotWeight1>hotWeight2
end
else
return biddingWeight1>biddingWeight2
end
end

local itemList=table.weakCopy(self.filterList)
if#itemList>1 then
table.sort(itemList,sort_func)
end
return itemList
end





function UIAuctionWin:onRecordBtn()

if not xianmengModel:hasXM()then
UIManager.error(cfgHelper.getlang("haveNotXianMengTips"))
return
end

UIFullAuctionController:showWindow("UIAuctionRecordWin")
end

function UIAuctionWin:onRefreshBtn(isauto)

local cur=auctionModel:getRefreshCdTime()
local isInCd=cur>0
if isInCd then

UIManager.error(FMT.fmt("{0}秒后可刷新",cur))
return
end



if self.serverType==AUCTION_SERVER_TYPE.eLocal then

auctionController:reqAuctionListData(self.serverType,self.auctionType,1,MaxValue)
elseif self.serverType==AUCTION_SERVER_TYPE.eCross then

auctionController:reqCrossAuctionListData(self.serverType,self.auctionType,1,MaxValue)
end

local cdEndTime=gameUtilityModel.getServerShortTime()+RefreshBtnCd
auctionModel:setRefreshCdEndTime(cdEndTime)
if not isauto then
UIManager.info("刷新成功")
end

end

function UIAuctionWin:on_it_item_click(clicknum,index)
local selectIndex=index+1

if selectIndex==self.itSelectIndex then
return
end

self:selectItemType(selectIndex)
end


function UIAuctionWin:onClickBiddingBtn(auctionItemSeries)


local auctionItemData=auctionModel:getAuctionItemDataBySeries(self.serverType,self.auctionType,auctionItemSeries)
local nowPrice=auctionItemData.auctionprice
local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,nowPrice)
if not isEnough then
UIManager.error("可用额度不足")
return
end

local args={
auctionSeries=auctionItemSeries,
serverType=self.serverType
}

UIFullAuctionController:showWindow("UIAuctionBiddingWin",args)
end

function UIAuctionWin:onautoClickBiddingBtn(auctionItemSeries,auctionData)

local isselfauto=false
if auctionData.autoList then
for k,v in ipairs(auctionData.autoList)do
if mathHelper.compareInt64(v.param_1,self.selfActorId)then
isselfauto=true
break
end
end
end
local args={
auctionSeries=auctionItemSeries,
serverType=self.serverType,
auctionType=self.auctionType,
islockjj=true,
isopenjj=isselfauto,
}
local showBiddingFun=function()
self:showWindow("UIAuctionBiddingWin",args)
end
showBiddingFun()
end



function UIAuctionWin:onClickBuyBtn(auctionItemSeries)

local auctionItemData=nil
for i=1,#self.auctionList do
if self.auctionList[i].auctionseries==auctionItemSeries then
auctionItemData=self.auctionList[i]
break
end
end

if not auctionItemData then
return
end

local itemId=auctionItemData.itemid
local itemCfg=itemsConfig.getConfig(itemId)
local singleBuyPrice=itemCfg.auction and itemCfg.auction[3]or nil
local price=singleBuyPrice and singleBuyPrice*auctionItemData.itemcount or auctionItemData.auctionprice


local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,price)
if not isEnough then
UIManager.error("可用额度不足")
return
end

local moneyType=eMoneyType.mtLingYu
local exchangeType=eMoneyType.mtXianYu

local showDiaLog=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eAuctionBuyDialog)
if not showDiaLog then

local iconname=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local str=FMT.fmt('是否确认花费<color=#B44200>{0} {1} </color>一口价\n购买<color=#B44200>{2}</color>？',iconStr,price,itemCfg.name)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='购买',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
if self.serverType==AUCTION_SERVER_TYPE.eLocal then

local endTime=auctionItemData.auctionsec

local nowTime=gameUtilityModel.getServerShortTime()
if endTime then
local lerp=endTime-nowTime
if lerp<=0 then
UIManager.error("此拍卖品已经结束竞拍了")
return
end
end
moneySystem:useMoney(moneyType,price,function()

auctionController:reqAuctionBidding(self.serverType,self.auctionType,auctionItemData.auctionseries,price)
end,WARNING_TYPE.eWarning,exchangeType)
elseif self.serverType==AUCTION_SERVER_TYPE.eCross then
moneySystem:useMoney(moneyType,price,function()

auctionController:reqCrossAuctionBidding(self.serverType,self.auctionType,auctionItemData.auctionseries,price)
end,WARNING_TYPE.eWarning,exchangeType)
end
end,
showclosebtn=true,
choosetext='今日不再提示',
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eAuctionBuyDialog,flag)
end,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else

moneySystem:useMoney(moneyType,price,function()

if self.serverType==AUCTION_SERVER_TYPE.eLocal then

auctionController:reqAuctionBidding(self.serverType,self.auctionType,auctionItemData.auctionseries,price)
elseif self.serverType==AUCTION_SERVER_TYPE.eCross then

auctionController:reqCrossAuctionBidding(self.serverType,self.auctionType,auctionItemData.auctionseries,price)
end
end,WARNING_TYPE.eWarning,exchangeType)
end
end


function UIAuctionWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end


function UIAuctionWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshAuctionItemList_notReset()
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIAuctionWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIAuctionWin.on_building_event(etype,arg1,arg2)
if etype==buildingEvent.zongmenLevelUp then

_this:refreshQuota()
end
end