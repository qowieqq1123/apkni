







def_class("UIWanBaoShangHui_auctionWin",UIWindowBase)









function UIWanBaoShangHui_auctionWin:bindComponents()

self.refreshBtnText=UIText.get(self,0)
self.Content=UIObject.get(self,1)
self.itemScroller=UILoopListView.new(self,2)
self.nullTxt=UIText.get(self,3)
self.tipsText=UIText.get(self,4)
self.filterBtn=UIButton.get(self,5)
self.refreshBtn=UIButton.get(self,6)
self.itemTypeScrollView=UIObject.get(self,7)
self.effect_wan=UIObject.get(self,8)
self.priceSortBtn=UIButton.get(self,9)
self.searchInputField=UIInputField.get(self,10)
self.searchBtn=UIButton.get(self,11)
self.Placeholder=UIText.get(self,12)
self.priceSortIconASC=UIObject.get(self,13)
self.priceSortIconDESC=UIObject.get(self,14)
self.ruleBtn=UIButton.get(self,15)

self.itemScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.priceSortBtn:setButtonClick(function()self:onPriceSortBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.effect={
["wan"]=self.effect_wan,
}



end


function UIWanBaoShangHui_auctionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.refreshBtnText);self.refreshBtnText=nil;
_UIObject_release(self.Content);self.Content=nil;
self.itemScroller:deleteSelf();self.itemScroller=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.itemTypeScrollView);self.itemTypeScrollView=nil;
_UIObject_release(self.effect_wan);self.effect_wan=nil;
_UIObject_release(self.priceSortBtn);self.priceSortBtn=nil;
_UIObject_release(self.searchInputField);self.searchInputField=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.priceSortIconASC);self.priceSortIconASC=nil;
_UIObject_release(self.priceSortIconDESC);self.priceSortIconDESC=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
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
sellerName=7,
remainingTime=8,
hotFlag=9,
beSurpassedFlag=10,
selectBg=11,
selfSellFlag=12,
guanZhuFlag=13,
autojjBtn=14,
autotxt=15,
autotxt2=16,
}

local _this
local _scrollLen=6
local MaxValue=200
local RefreshBtnCd=3
local _creatGirdPrecent=10


local itemType1ToMainType={
[itemtype1Type.eEquip]=ITEM_MAIN_TYPE.eEquip,
[itemtype1Type.eMetrials]=ITEM_MAIN_TYPE.eMaterials,
[itemtype1Type.eGuBao]=ITEM_MAIN_TYPE.eGubao,
[itemtype1Type.eFaBao]=ITEM_MAIN_TYPE.eFabao,
[itemtype1Type.eFuBao]=ITEM_MAIN_TYPE.eFubao,
[itemtype1Type.eFaBaoYP]=ITEM_MAIN_TYPE.eFabaoYuanPei,
}




function UIWanBaoShangHui_auctionWin:onLoaded(...)
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
self.searchInputField:setChildInputFieldChange(true,function(...)self:onInputFieldChange(...)end)
end


function UIWanBaoShangHui_auctionWin:__delete()
self.isNeedKeepPos=nil
self:clearTimer()
self:clearDelayRefreshTimer()
self.loopListView:SetAction(nil,nil)
self.loopListView=nil
self:unbindComponents()
_this=nil
auctionModel:clearPersonAuctionConditionFilter()
end




function UIWanBaoShangHui_auctionWin:onShow(argtable,afterOnloaded)
self.auctionCfg=cfgHelper.get(cfg_auctionconfig_get,1)

self.itemTypeList=self.auctionCfg.personItemTypeList
self.auctionType=AUCTION_AUCTION_TYPE.ePlayer
self.autoRefreshDelayTime=1

self:onShowArgRecv(argtable,afterOnloaded)
end

function UIWanBaoShangHui_auctionWin:onShowArgRecv(argtable,afterOnloaded)
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


self:reqRefreshData()


local effectId=10256
self.effect_wan:setChildShowEffect(effectId,true)
self.effect_wan:setActive(true)

self:refresh()
end


function UIWanBaoShangHui_auctionWin:onHide()
self.effect_wan:setActive(false)
self.isNeedKeepPos=nil
self:clearTimer()
self:clearDelayRefreshTimer()
end

function UIWanBaoShangHui_auctionWin:refresh(isKeepPos)

self.auctionList=auctionModel:getAuctionListData(self.serverType,self.auctionType)or{}

self:refreshItemTypeList()
if not isKeepPos and self.isNeedKeepPos then
isKeepPos=true
end
self.isNeedKeepPos=nil
self:selectItemType(self.itSelectIndex,isKeepPos)
end


function UIWanBaoShangHui_auctionWin:refreshItemTypeList()
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

function UIWanBaoShangHui_auctionWin:onStartView()

end

function UIWanBaoShangHui_auctionWin:onFreshListView(index,widget)
index=index+1
self:refreshAuctionItem(widget,index)
end

function UIWanBaoShangHui_auctionWin:refreshPriceSortBtn()
local isShowASC=self.priceSortMode==1
local isShowDESC=self.priceSortMode==2

self.priceSortIconASC:setActive(isShowASC)
self.priceSortIconDESC:setActive(isShowDESC)
end


function UIWanBaoShangHui_auctionWin:refreshAuctionItemList_reset(isKeepPos,priceSortMode)
local originalCount=self.auctionItemList and#self.auctionItemList or 0

if isKeepPos then

self.auctionItemList=self:keepSortAndAddAuctionItemList()
else

self.priceSortMode=priceSortMode
if priceSortMode and priceSortMode>0 then
self.auctionItemList=self:sortAuctionItemList_priceFirst()
else
self.auctionItemList=self:sortAuctionItemList()
end
end

self:refreshPriceSortBtn()


self:clearTimer()

local count=#self.auctionItemList
local prefabNameList={}
local itemIdList={}
for i=1,count do
prefabNameList[i]="wbsh_auctionItem"
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

self.nullTxt:setText("暂无拍卖品")
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


function UIWanBaoShangHui_auctionWin:refreshAuctionItemList_notReset(needSort)
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
if self.needAutoDelayRefresh then
self.needAutoDelayRefresh=nil
self:clearDelayRefreshTimer()
self.delayRefreshTimer=self:delayDo(self.autoRefreshDelayTime,function()

self:reqRefreshData()

auctionModel:setAuctionRefreshKeepPosFlag(true)
return self:clearDelayRefreshTimer()
end)


self.autoRefreshDelayTime=self.autoRefreshDelayTime+1
if self.autoRefreshDelayTime>10 then
self.autoRefreshDelayTime=10
end
elseif not self.delayRefreshTimer then

self.autoRefreshDelayTime=1
end
else
self.nullTxt:setActive(true)

self.nullTxt:setText("暂无拍卖品")
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


function UIWanBaoShangHui_auctionWin:refreshAuctionItem(item,index)
if item then
local auctionData=self.auctionItemList[index]

local itemid=auctionData.itemid
local count=auctionData.itemcount
local isEquip=itemsConfig.isEquip(itemid)
local isFabao=itemsConfig.isFabao(itemid)
local itemExtraData=auctionData.itemData or{}
local jinglianlv=isEquip and itemExtraData.jinglianlv or
isFabao and itemExtraData.jilianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=''
if count>1 then
countStr=mathHelper.formatNumber(count)
end
local txt=(isEquip or isFabao)and jinglianStr or countStr
local showCountBG=txt~=''
local iconName=itemsModel.getIconName(auctionData)

local conf={itemid=itemid,itemcount=txt,showCountBG=showCountBG,showname=false,showStage=true,iconName=iconName}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local isEquip=itemsConfig.isEquip(itemid)
local suitIcon=equipsHelper.getEquipSuitIcon(auctionData)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=isEquip
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon

local widget=item:GetChildWidgetBase(auctionItemIndex.item)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(auctionData.auctionseries,...)
end)


local itemConfig=itemsConfig.getConfig(itemid)
local itemName=isFabao and itemExtraData.name or itemsModel.getNameByItem(auctionData)
item:SetChildText(auctionItemIndex.name,itemName)


local nowTime=gameUtilityModel.getServerShortTime()
local isNeedRefresh=false
if auctionData.auctionsec then
local lerp=auctionData.auctionsec-nowTime
if lerp>0 then
local timeStr=nil

timeStr=timeHelper.format_time_stamp11(lerp,true)
item:SetChildText(auctionItemIndex.remainingTime,FMT.fmt("{0}",timeStr))
else
isNeedRefresh=true

item:SetChildText(auctionItemIndex.remainingTime,"待刷新")
end
end


if not isNeedRefresh then

item:SetChildButtonClick(auctionItemIndex.biddingBtn,function()
self:onClickBiddingBtn(auctionData.auctionseries)
end)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,function()
self:onautoClickBiddingBtn(auctionData.auctionseries,auctionData)
end)
else

local endFun=function()
UIManager.error("请刷新拍卖品状态")
end
item:SetChildButtonClick(auctionItemIndex.biddingBtn,endFun)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,endFun)
end



local isSelfSell=mathHelper.compareInt64(auctionData.auctionkey,self.selfActorId)
item:SetChildActive(auctionItemIndex.selfSellFlag,isSelfSell)

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
item:SetChildActive(auctionItemIndex.biddingFlag,not isSelfSell and isBidding and not isselfauto)
item:SetChildActive(auctionItemIndex.biddingBtn,not isSelfSell and not isBidding and not isselfauto)
item:SetChildActive(auctionItemIndex.autojjBtn,not isSelfSell and isBidding and isselfauto)



local nowPrice=auctionData.auctionprice
local moneyType=eMoneyType.mtXianYu
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

local isMinimumPrice=mathHelper.compareInt64(auctionData.auctionactorid,int64.new(0))
local stateStr=isMinimumPrice and"<color=#549327>[底价]</color>"or"<color=#ca631d>[竞拍中]</color>"
item:SetChildText(auctionItemIndex.state,stateStr)


local sellerName=(not auctionData.ownername or auctionData.ownername=="")and"<color=#65615f>匿名修士</color>"or auctionData.ownername
item:SetChildText(auctionItemIndex.sellerName,sellerName)


local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionData.auctionseries)~=nil
item:SetChildActive(auctionItemIndex.guanZhuFlag,isGuanZhu)


local beSurpassed=not isBidding and auctionController:checkIsBadeAuctionItem(self.auctionType,auctionData.auctionseries)
item:SetChildActive(auctionItemIndex.beSurpassedFlag,beSurpassed)


local isHot=auctionData.times>=self.auctionCfg.personHotCount
item:SetChildActive(auctionItemIndex.hotFlag,not beSurpassed and isHot)
end
end


function UIWanBaoShangHui_auctionWin:refreshAuctionItemTime(item,index,nowTime)
if item then
local auctionData=self.auctionItemList[index]

local isNeedRefresh=false
if auctionData.auctionsec then
local lerp=auctionData.auctionsec-nowTime
if lerp>0 then
local timeStr=nil

timeStr=timeHelper.format_time_stamp11(lerp,true)
item:SetChildText(auctionItemIndex.remainingTime,FMT.fmt("{0}",timeStr))
else
isNeedRefresh=true

item:SetChildText(auctionItemIndex.remainingTime,"待刷新")
if not self.delayRefreshTimer then
self.needAutoDelayRefresh=true
end
end
end


if not isNeedRefresh then

item:SetChildButtonClick(auctionItemIndex.biddingBtn,function()
self:onClickBiddingBtn(auctionData.auctionseries)
end)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,function()
self:onautoClickBiddingBtn(auctionData.auctionseries,auctionData)
end)
else

local endFun=function()
UIManager.error("请刷新拍卖品状态")
end
item:SetChildButtonClick(auctionItemIndex.biddingBtn,endFun)
item:SetChildButtonClick(auctionItemIndex.autojjBtn,endFun)
end


local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionData.auctionseries)~=nil
item:SetChildActive(auctionItemIndex.guanZhuFlag,isGuanZhu)
end
end


function UIWanBaoShangHui_auctionWin:selectItemType(itIndex,isKeepPos)
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


self.firstFilterItemList=self:filterTypeAuctionItemList()

self.conditionFilterItemList=self:filterConditionAuctionItemList()
if not isKeepPos then

self.searchAuctionItemList=nil
end

self:refreshAuctionItemList_reset(isKeepPos)
end


function UIWanBaoShangHui_auctionWin:filterTypeAuctionItemList()
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

local personAuctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
local auctionSeriesStr=tostring(v.auctionseries)
if personAuctionSelfBiddingList[auctionSeriesStr]then

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


function UIWanBaoShangHui_auctionWin:filterConditionAuctionItemList()
local filterItemList={}
local filter=auctionModel:getPersonAuctionSecondFilter(self.itSelectIndex,FULL_TAB_TYPE.eWBSH_Auction)
for _,item in ipairs(self.firstFilterItemList)do
if itemsFilterHelper.isFilter(filter,item)then
filterItemList[#filterItemList+1]=item
end
end






return filterItemList
end


function UIWanBaoShangHui_auctionWin:sortAuctionItemList()
local personAuctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
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
local auctionSeriesStr1=tostring(a.auctionseries)
local auctionSeriesStr2=tostring(b.auctionseries)
local badeWeight1=personAuctionSelfBiddingList[auctionSeriesStr1]and 100 or 0
local badeWeight2=personAuctionSelfBiddingList[auctionSeriesStr2]and 100 or 0
local biddingWeight1=mathHelper.compareInt64(a.auctionactorid,self.selfActorId)and 100 or 0
local biddingWeight2=mathHelper.compareInt64(b.auctionactorid,self.selfActorId)and 100 or 0
local hotWeight1=a.times>=self.auctionCfg.personHotCount and 100 or 0
local hotWeight2=b.times>=self.auctionCfg.personHotCount and 100 or 0
local selfSellWeight1=mathHelper.compareInt64(a.auctionkey,self.selfActorId)and 100 or 0
local selfSellWeight2=mathHelper.compareInt64(b.auctionkey,self.selfActorId)and 100 or 0
local endTimeWeight1=timeHelper.isTodayStamp(timeHelper.convertLongStamp(a.auctionsec))and 100 or 0
local endTimeWeight2=timeHelper.isTodayStamp(timeHelper.convertLongStamp(b.auctionsec))and 100 or 0
local isGuanZhu1=auctionModel:getAuctionItemGuanZhuState(a.auctionseries)~=nil
local isGuanZhu2=auctionModel:getAuctionItemGuanZhuState(b.auctionseries)~=nil
local guanZhuWeight1=isGuanZhu1 and 100 or 0
local guanZhuWeight2=isGuanZhu2 and 100 or 0

if selfSellWeight1~=selfSellWeight2 then
return selfSellWeight1>selfSellWeight2
elseif biddingWeight1~=biddingWeight2 then
return biddingWeight1>biddingWeight2
elseif badeWeight1~=badeWeight2 then
return badeWeight1>badeWeight2
elseif guanZhuWeight1~=guanZhuWeight2 then
return guanZhuWeight1>guanZhuWeight2
elseif endTimeWeight1~=endTimeWeight2 then
return endTimeWeight1>endTimeWeight2
elseif hotWeight1~=hotWeight2 then
return hotWeight1>hotWeight2
elseif nowPrice1~=nowPrice2 then
return nowPrice1>nowPrice2
elseif quality1~=quality2 then
return quality1>quality2
else
return item_type1>item_type2
end
end

local itemList
if self.searchAuctionItemList then

itemList=table.weakCopy(self.searchAuctionItemList)
else

itemList=table.weakCopy(self.conditionFilterItemList)
end
if#itemList>1 then
table.sort(itemList,sort_func)
end
return itemList
end


function UIWanBaoShangHui_auctionWin:keepSortAndAddAuctionItemList()
if not self.auctionItemList then
self.auctionItemList={}
end

local nowAuctionItemIndexList_lookup={}
for i,auctionData in ipairs(self.auctionItemList)do
local auctionSeries=auctionData.auctionseries
local auctionSeriesStr=tostring(auctionSeries)
nowAuctionItemIndexList_lookup[auctionSeriesStr]=i
end
local priceSortMode=self.priceSortMode

local personAuctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
local sort_func=function(a,b)
local auctionSeriesStr1=tostring(a.auctionseries)
local auctionSeriesStr2=tostring(b.auctionseries)
local originalIndex1=nowAuctionItemIndexList_lookup[auctionSeriesStr1]or-1
local originalIndex2=nowAuctionItemIndexList_lookup[auctionSeriesStr2]or-1
local originalWeight1=originalIndex1>0 and 100 or 0
local originalWeight2=originalIndex2>0 and 100 or 0

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
local badeWeight1=personAuctionSelfBiddingList[auctionSeriesStr1]and 100 or 0
local badeWeight2=personAuctionSelfBiddingList[auctionSeriesStr2]and 100 or 0
local biddingWeight1=mathHelper.compareInt64(a.auctionactorid,self.selfActorId)and 100 or 0
local biddingWeight2=mathHelper.compareInt64(b.auctionactorid,self.selfActorId)and 100 or 0
local hotWeight1=a.times>=self.auctionCfg.personHotCount and 100 or 0
local hotWeight2=b.times>=self.auctionCfg.personHotCount and 100 or 0
local selfSellWeight1=mathHelper.compareInt64(a.auctionkey,self.selfActorId)and 100 or 0
local selfSellWeight2=mathHelper.compareInt64(b.auctionkey,self.selfActorId)and 100 or 0
local endTimeWeight1=timeHelper.isTodayStamp(timeHelper.convertLongStamp(a.auctionsec))and 100 or 0
local endTimeWeight2=timeHelper.isTodayStamp(timeHelper.convertLongStamp(b.auctionsec))and 100 or 0
local isGuanZhu1=auctionModel:getAuctionItemGuanZhuState(a.auctionseries)~=nil
local isGuanZhu2=auctionModel:getAuctionItemGuanZhuState(b.auctionseries)~=nil
local guanZhuWeight1=isGuanZhu1 and 100 or 0
local guanZhuWeight2=isGuanZhu2 and 100 or 0

if not priceSortMode or priceSortMode==0 then
if originalWeight1~=originalWeight2 then
return originalWeight1>originalWeight2
elseif originalIndex1~=originalIndex2 then
return originalIndex1<originalIndex2
elseif selfSellWeight1~=selfSellWeight2 then
return selfSellWeight1>selfSellWeight2
elseif biddingWeight1~=biddingWeight2 then
return biddingWeight1>biddingWeight2
elseif badeWeight1~=badeWeight2 then
return badeWeight1>badeWeight2
elseif guanZhuWeight1~=guanZhuWeight2 then
return guanZhuWeight1>guanZhuWeight2
elseif endTimeWeight1~=endTimeWeight2 then
return endTimeWeight1>endTimeWeight2
elseif hotWeight1~=hotWeight2 then
return hotWeight1>hotWeight2
elseif nowPrice1~=nowPrice2 then
return nowPrice1>nowPrice2
elseif quality1~=quality2 then
return quality1>quality2
else
return item_type1>item_type2
end
else
if originalWeight1~=originalWeight2 then
return originalWeight1>originalWeight2
elseif originalIndex1~=originalIndex2 then
return originalIndex1<originalIndex2
elseif selfSellWeight1~=selfSellWeight2 then
return selfSellWeight1>selfSellWeight2
elseif biddingWeight1~=biddingWeight2 then
return biddingWeight1>biddingWeight2
elseif badeWeight1~=badeWeight2 then
return badeWeight1>badeWeight2
elseif guanZhuWeight1~=guanZhuWeight2 then
return guanZhuWeight1>guanZhuWeight2
elseif nowPrice1~=nowPrice2 then
if priceSortMode==1 then
return nowPrice1<nowPrice2
elseif priceSortMode==2 then
return nowPrice1>nowPrice2
end
elseif endTimeWeight1~=endTimeWeight2 then
return endTimeWeight1>endTimeWeight2
elseif hotWeight1~=hotWeight2 then
return hotWeight1>hotWeight2
elseif quality1~=quality2 then
return quality1>quality2
else
return item_type1>item_type2
end
end
end

local itemList
if self.searchAuctionItemList then

itemList=table.weakCopy(self.searchAuctionItemList)
else

itemList=table.weakCopy(self.conditionFilterItemList)
end

if#itemList>1 then
table.sort(itemList,sort_func)
end

return itemList
end


function UIWanBaoShangHui_auctionWin:sortAuctionItemList_priceFirst()
local personAuctionSelfBiddingList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAuction,'personAuctionSelfBiddingList',{})
local priceSortMode=self.priceSortMode
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
local auctionSeriesStr1=tostring(a.auctionseries)
local auctionSeriesStr2=tostring(b.auctionseries)
local badeWeight1=personAuctionSelfBiddingList[auctionSeriesStr1]and 100 or 0
local badeWeight2=personAuctionSelfBiddingList[auctionSeriesStr2]and 100 or 0
local biddingWeight1=mathHelper.compareInt64(a.auctionactorid,self.selfActorId)and 100 or 0
local biddingWeight2=mathHelper.compareInt64(b.auctionactorid,self.selfActorId)and 100 or 0
local hotWeight1=a.times>=self.auctionCfg.personHotCount and 100 or 0
local hotWeight2=b.times>=self.auctionCfg.personHotCount and 100 or 0
local selfSellWeight1=mathHelper.compareInt64(a.auctionkey,self.selfActorId)and 100 or 0
local selfSellWeight2=mathHelper.compareInt64(b.auctionkey,self.selfActorId)and 100 or 0
local endTimeWeight1=timeHelper.isTodayStamp(timeHelper.convertLongStamp(a.auctionsec))and 100 or 0
local endTimeWeight2=timeHelper.isTodayStamp(timeHelper.convertLongStamp(b.auctionsec))and 100 or 0
local isGuanZhu1=auctionModel:getAuctionItemGuanZhuState(a.auctionseries)~=nil
local isGuanZhu2=auctionModel:getAuctionItemGuanZhuState(b.auctionseries)~=nil
local guanZhuWeight1=isGuanZhu1 and 100 or 0
local guanZhuWeight2=isGuanZhu2 and 100 or 0

if selfSellWeight1~=selfSellWeight2 then
return selfSellWeight1>selfSellWeight2
elseif biddingWeight1~=biddingWeight2 then
return biddingWeight1>biddingWeight2
elseif badeWeight1~=badeWeight2 then
return badeWeight1>badeWeight2
elseif guanZhuWeight1~=guanZhuWeight2 then
return guanZhuWeight1>guanZhuWeight2
elseif nowPrice1~=nowPrice2 then
if priceSortMode==1 then
return nowPrice1<nowPrice2
elseif priceSortMode==2 then
return nowPrice1>nowPrice2
end
elseif endTimeWeight1~=endTimeWeight2 then
return endTimeWeight1>endTimeWeight2
elseif hotWeight1~=hotWeight2 then
return hotWeight1>hotWeight2
elseif quality1~=quality2 then
return quality1>quality2
else
return item_type1>item_type2
end
end

local itemList
if self.searchAuctionItemList then

itemList=table.weakCopy(self.searchAuctionItemList)
else

itemList=table.weakCopy(self.conditionFilterItemList)
end
if#itemList>1 then
table.sort(itemList,sort_func)
end
return itemList
end

function UIWanBaoShangHui_auctionWin:filterAuctionItemListBySearchKeyWord(keyWord)

if not self.conditionFilterItemList or not next(self.conditionFilterItemList)then
return
end

local searchAuctionItemList={}
for _,item in ipairs(self.conditionFilterItemList)do
local itemId=item.itemid
local itemExtraData=item.itemData or{}
local isFabao=itemsConfig.isFabao(itemId)
local itemName=isFabao and itemExtraData.name or itemsModel.getNameByItem(item)
if string.find(itemName,keyWord)~=nil then
searchAuctionItemList[#searchAuctionItemList+1]=item
end
end
self.searchAuctionItemList=searchAuctionItemList
end




function UIWanBaoShangHui_auctionWin:onFilterBtn()
self:showWindow("UIWanBaoShangHui_filterWin",{filterTypeCfgIndex=self.itSelectIndex,tabType=FULL_TAB_TYPE.eWBSH_Auction,winName="UIWanBaoShangHui_auctionWin"})
end



function UIWanBaoShangHui_auctionWin:onRefreshBtn(isauto)

local cur=auctionModel:getRefreshCdTime()
local isInCd=cur>0
if isInCd then

UIManager.error(FMT.fmt("{0}秒后可刷新",cur))
return
end


self:reqRefreshData()

local cdEndTime=gameUtilityModel.getServerShortTime()+RefreshBtnCd
auctionModel:setRefreshCdEndTime(cdEndTime)
if not isauto then
UIManager.info("刷新成功")
end
end

function UIWanBaoShangHui_auctionWin:on_it_item_click(clicknum,index)
local selectIndex=index+1

if selectIndex==self.itSelectIndex then
return
end

self:selectItemType(selectIndex)
end

function UIWanBaoShangHui_auctionWin:onClickBiddingBtn(auctionItemSeries)
local args={
auctionSeries=auctionItemSeries,
serverType=self.serverType,
auctionType=self.auctionType,
}
local showBiddingFun=function()
self:showWindow("UIAuctionBiddingWin",args)
end

local needReconfirm=false
local auctionItemData=auctionModel:getAuctionItemDataBySeries(self.serverType,self.auctionType,auctionItemSeries)
local auctionItemTypeName="拍卖品"
if auctionItemData and auctionItemData.data>0 then
local itemId=auctionItemData.itemid
local isEquip=itemsConfig.isEquip(itemId)
local isFabao=itemsConfig.isFabao(itemId)
local itemExtraData=auctionItemData.itemData or{}
local jinglianlv=isEquip and itemExtraData.jinglianlv or
isFabao and itemExtraData.jilianlv or 0
local lianhualv=isFabao and itemExtraData.lianhuanum or 0
needReconfirm=jinglianlv>0 or lianhualv>0
if isEquip then
auctionItemTypeName="装备"
end
if isFabao then
auctionItemTypeName="法宝"
end
end

local isHideReconfirmDialog=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eWBSHBuyEnhanced)
if needReconfirm and not isHideReconfirmDialog then
local contentStr=FMT.fmt("该{0}已强化，成功竞拍后需等待7天方可重新寄售，确定要竞拍吗？",auctionItemTypeName)
local func=function()
showBiddingFun()
end
UIDialogManager.getConfirmDialog3(nil,contentStr,func,REPEAT_TYPE.eWBSHBuyEnhanced,nil,nil)




















else
showBiddingFun()
end
end

function UIWanBaoShangHui_auctionWin:onautoClickBiddingBtn(auctionItemSeries,auctionData)

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


function UIWanBaoShangHui_auctionWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshAuctionItemList_notReset()
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIWanBaoShangHui_auctionWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIWanBaoShangHui_auctionWin:onClickRewardItem(auctionSeries,itemId,index,guid,attach)

if itemId==-1 then
return
end

local auctionItemData=auctionModel:getAuctionItemDataBySeries(self.serverType,self.auctionType,auctionSeries)
local itemData=nil
if auctionItemData and auctionItemData.data>0 then
itemData=auctionItemData.itemData
end
local serverType=self.serverType
local auctionType=self.auctionType
local itemguid=auctionModel:getItemguid(auctionSeries)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eAuctionShowItem,
itemid=itemId,
itemguid=itemguid,
itemData=itemData,
showModel=true,
attach={
serverType=serverType,
auctionType=auctionType,
auctionSeries=auctionSeries,
},
move=TIPS_MOVE_POS.eRight})
end


function UIWanBaoShangHui_auctionWin:clearDelayRefreshTimer()
if self.delayRefreshTimer then
self:stopTimerByID(self.delayRefreshTimer)
self.delayRefreshTimer=nil
end
end


function UIWanBaoShangHui_auctionWin:reqRefreshData(isNeedKeepPos)
self.isNeedKeepPos=isNeedKeepPos


if self.serverType==AUCTION_SERVER_TYPE.eLocal then

auctionController:reqAuctionListData(self.serverType,self.auctionType,1,MaxValue)
elseif self.serverType==AUCTION_SERVER_TYPE.eCross then

auctionController:reqCrossAuctionListData(self.serverType,self.auctionType,1,MaxValue)
end
end


function UIWanBaoShangHui_auctionWin:onPriceSortBtn()
if not self.priceSortMode then
self.priceSortMode=0
end
local priceSortMode=self.priceSortMode+1
if priceSortMode>2 then
priceSortMode=nil
end
self:refreshAuctionItemList_reset(nil,priceSortMode)
end

function UIWanBaoShangHui_auctionWin:onSearchBtn()
local keyWord=self.searchInputField:getInputFieldValue()
if not keyWord or keyWord==''then
if self.searchAuctionItemList and next(self.searchAuctionItemList)then
self.searchAuctionItemList=nil
else
return
end
else
if helper.check_spec_chars(keyWord)then
UIManager.error("输入内容有误")
return
end

local originalList=self.searchAuctionItemList
self:filterAuctionItemListBySearchKeyWord(keyWord)
if not self.searchAuctionItemList or not next(self.searchAuctionItemList)then
UIManager.error("即使神识再强大，也无法搜索到任何内容")
self.searchAuctionItemList=originalList
return
end
end
self:refreshAuctionItemList_reset()
end

function UIWanBaoShangHui_auctionWin:onRuleBtn()
local d={}
d.title='拍卖说明'
d.mode=3
d.name='ui_wbsh_end_help_%d'
d.closeCB=function()
self.ruleBtn:setSprite(globalABLookup.global,'button_tyjieshao_1')
end
self.ruleBtn:setSprite(globalABLookup.global,'button_tyjieshao_2')
self:showWindow('UIRuleWin',d)
end

function UIWanBaoShangHui_auctionWin:onClickInput()
self.Placeholder:setActive(false)
end


function UIWanBaoShangHui_auctionWin:onExitInput()
local str=self.searchInputField:getInputFieldValue()
if not str or str==''then
self.Placeholder:setActive(true)
end
end

function UIWanBaoShangHui_auctionWin:onInputFieldChange(str)


end