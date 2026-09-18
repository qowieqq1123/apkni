







def_class("UIWanBaoShangHui_sellWin",UIWindowBase)









function UIWanBaoShangHui_sellWin:bindComponents()

self.effect_wan=UIObject.get(self,0)
self.filterBtn=UIButton.get(self,1)
self.itemBagScrollView=UIScrollViewSlow.get(self,2)
self.itemTypeScrollView=UIObject.get(self,3)
self.moneyBtn=UIButton.get(self,4)
self.moneyBtn_xianyu=UIButton.get(self,5)
self.moneyRoot=UIObject.get(self,6)
self.moneyRoot_xianyu=UIObject.get(self,7)
self.nullTxt=UIText.get(self,8)
self.sellingItemScroller=UIObject.get(self,9)
self.tipsText=UIText.get(self,10)
self.titleText=UIText.get(self,11)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.moneyBtn_xianyu:setButtonClick(function()self:onMoneyBtn_xianyu()end)



end


function UIWanBaoShangHui_sellWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect_wan);self.effect_wan=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.itemBagScrollView);self.itemBagScrollView=nil;
_UIObject_release(self.itemTypeScrollView);self.itemTypeScrollView=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyBtn_xianyu);self.moneyBtn_xianyu=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyRoot_xianyu);self.moneyRoot_xianyu=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.sellingItemScroller);self.sellingItemScroller=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
self.effect=nil;
self.moneyBtn=nil;
self.moneyRoot=nil;
end
















local _this
local _scrollLen=6

local sellItemIndex={
name=0,
state=1,
item=2,
nowPriceIcon=3,
nowPriceText=4,
cancelSellBtn=5,
remainingTimeText=6,
remainingTime=7,
}

local _cmpItemWidgetIdx=
{
cmpQuality=0,
cmpIcon=1,
cmpCountTxt=2,
cmpLock=3,
cmpStageTxt=4,
cmpSelect=5,
cmpBg=6,
cmpStageBg=7,
cmpNewFlag=8,
cmpCountBg=9,
cmpFabaoTag=10,
cmpReddot=11,
cmpEquipType=12,
}

local itemTypeToBagType={
[1]=BAG_TYPE.eEquipBag,
[5]=BAG_TYPE.eMaterialsBag,
[6]=BAG_TYPE.eGubaoBag,
[14]=BAG_TYPE.eFabaoBag,
[15]=BAG_TYPE.eFubaoBag,
}


local itemType1ToMainType={
[1]=ITEM_MAIN_TYPE.eEquip,
[5]=ITEM_MAIN_TYPE.eMaterials,
[6]=ITEM_MAIN_TYPE.eGubao,
[14]=ITEM_MAIN_TYPE.eFabao,
[15]=ITEM_MAIN_TYPE.eFubao,
[19]=ITEM_MAIN_TYPE.eFabaoYuanPei,
}

local _creatGirdPrecent=42
local _colomn=5




function UIWanBaoShangHui_sellWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)

self._on_it_item_click=function(...)
self:on_it_item_click(...)
end
self.itemTypeScrollView:setChildScrollViewInit(0,true,self._on_it_item_click,nil)
self.itemBagScrollView:setSlowClickAction(function(...)self:onScrollItemClick(...)end)
self.itemBagScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self._onMoneyChange=function(...)self:onMoneyChange(...)end

notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
end


function UIWanBaoShangHui_sellWin:__delete()
self:clearTimer()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
_this=nil
end




function UIWanBaoShangHui_sellWin:onShow(argtable,afterOnloaded)
self.auctionCfg=cfgHelper.get(cfg_auctionconfig_get,1)

self.itemTypeList=self.auctionCfg.sellBagItemTypeList
self.auctionType=AUCTION_AUCTION_TYPE.ePlayer
self.isRefreshingSellItemList=false
self.needRefreshSellItemList=false
self.moneyType=eMoneyType.mtLingShi
self.fmTweenerList={}

self:onShowArgRecv(argtable,afterOnloaded)
end


function UIWanBaoShangHui_sellWin:onHide()
self.effect_wan:setActive(false)
self:clearTimer()
end

function UIWanBaoShangHui_sellWin:onShowArgRecv(argtable,afterOnloaded)
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


auctionController:reqPersonAuctionListData()


local effectId=10256
self.effect_wan:setChildShowEffect(effectId,true)
self.effect_wan:setActive(true)

self:refresh()


self:freshMoney()
end

function UIWanBaoShangHui_sellWin:refresh()

self:refreshSellItemListPanel()


self:refreshItemTypeList()


self:selectItemType(self.itSelectIndex)
end


function UIWanBaoShangHui_sellWin:refreshSellItemListPanel()
if self.isRefreshingSellItemList then

self.needRefreshSellItemList=true
return
end
self.isRefreshingSellItemList=true


self.sellItemList=auctionModel:getPersonAuctionSellListData()or{}


self:refreshSellItemList_reset()

self.isRefreshingSellItemList=false
if self.needRefreshSellItemList then

self.needRefreshSellItemList=false
self:refreshSellItemListPanel()
end
end


function UIWanBaoShangHui_sellWin:refreshSellItemList_reset(isKeepPos)
local contentPos
if isKeepPos then

contentPos=self.sellingItemScroller:getChildAnchoredPosition()
end


self.sellItemSortList=self:sortSellItemList()


self:clearTimer()

local count=#self.sellItemSortList
if not isKeepPos then
self.sellingItemScroller:setChildScrollViewCreateGrids(0,0)
end
if count>0 then
self.nullTxt:setActive(false)
self.sellingItemScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.sellingItemScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshSellItem(grids[i-1],i)
end
else
self.nullTxt:setActive(true)
self.sellingItemScroller:setChildScrollViewCreateGrids(0,0)

self.nullTxt:setText("暂无已寄售物品")
end

local maxSellCount=cfgHelper.get2(cfg_auctionconfig_get,1,'personmax')
self.titleText:setText(FMT.fmt("已寄售物品（{0}/{1}）",count,maxSellCount))


self:setRemainingTimeTimer()

if isKeepPos then

local scrollerViewHight=self.sellingItemScroller:getChildSizeDeltaY()
local contentHight=self.sellingItemScroller:getChildSizeDeltaY()
local maxY=contentHight-scrollerViewHight
if maxY<0 then
maxY=0
end
local jumpY=contentPos.y<=maxY and contentPos.y or maxY
self.sellingItemScroller:setChildAnchoredPosition(Vector2.New(contentPos.x,jumpY))
end
end


function UIWanBaoShangHui_sellWin:refreshSellItemList_notReset(needSort)
if needSort then

self.sellItemSortList=self:sortSellItemList()
end

local count=#self.sellItemSortList
if count>0 then
self.nullTxt:setActive(false)
self.sellingItemScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.sellingItemScroller:getChildScrollViewItemWidgets()
local nowTime=gameUtilityModel.getServerShortTime()
for i=1,count do

self:refreshSellItemTime(grids[i-1],i,nowTime)
end
else
self.nullTxt:setActive(true)

self.nullTxt:setText("暂无已寄售物品")
end
if count<=0 then

self:clearTimer()
end
end


function UIWanBaoShangHui_sellWin:refreshSellItem(item,index)
if item==nil then
item=self.sellingItemScroller:getChildScrollViewItemWidget(index-1)
end

if item then
local itemData=self.sellItemSortList[index]

local itemid=itemData.itemid
local count=itemData.itemcount
local isEquip=itemsConfig.isEquip(itemid)
local isFabao=itemsConfig.isFabao(itemid)
local itemExtraData=itemData.itemData or{}
local jinglianlv=isEquip and itemExtraData.jinglianlv or
isFabao and itemExtraData.jilianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=''
if count>1 then
countStr=mathHelper.formatNumber(count)
end
local txt=(isEquip or isFabao)and jinglianStr or countStr
local showCountBG=txt~=''
local iconName=isFabao and itemsModel.getIconName(itemData)or nil

local conf={itemid=itemid,itemcount=txt,showCountBG=showCountBG,showname=false,showStage=true,iconName=iconName}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local isEquip=itemsConfig.isEquip(itemid)
local suitIcon=equipsHelper.getEquipSuitIcon(itemData)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=isEquip
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon
local widget=item:GetChildWidgetBase(sellItemIndex.item)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickSellingItem(itemData.auctionseries,...)
end)
widget:SetChildActive(2,isFabao)


local itemConfig=itemsConfig.getConfig(itemid)
local itemName=isFabao and itemExtraData.name or itemsModel.getNameByItem(itemData)
item:SetChildText(sellItemIndex.name,itemName)


local nowTime=gameUtilityModel.getServerShortTime()
if itemData.auctionsec then
local lerp=itemData.auctionsec-nowTime
if lerp>0 then
local timeStr=nil
timeStr=timeHelper.format_time_stamp11(lerp,true)
item:SetChildText(sellItemIndex.remainingTimeText,FMT.fmt("{0}",timeStr))
item:SetChildActive(sellItemIndex.remainingTime,true)
item:SetChildActive(sellItemIndex.state,false)
else
item:SetChildActive(sellItemIndex.remainingTime,false)
item:SetChildActive(sellItemIndex.state,true)
end
end


item:SetChildButtonClick(sellItemIndex.cancelSellBtn,function()
self:onClickCancelSellBtn(itemData.auctionseries)
end)


local nowPrice=itemData.auctionprice
local moneyType=eMoneyType.mtXianYu
local moneyCount=nowPrice

item:SetChildActive(sellItemIndex.nowPriceIcon,true)
item:SetChildIcon(sellItemIndex.nowPriceIcon,iconHelper.getIconName(moneyType),false)

item:SetChildText(sellItemIndex.nowPriceText,FMT.fmt("{0}",moneyCount))
end
end


function UIWanBaoShangHui_sellWin:refreshSellItemTime(item,index,nowTime)
if item==nil then
item=self.sellingItemScroller:getChildScrollViewItemWidget(index-1)
end

if item then
local itemData=self.sellItemSortList[index]

if itemData.auctionsec then
local lerp=itemData.auctionsec-nowTime
if lerp>0 then
local timeStr=nil

timeStr=timeHelper.format_time_stamp11(lerp,true)
item:SetChildText(sellItemIndex.remainingTimeText,FMT.fmt("{0}",timeStr))
item:SetChildActive(sellItemIndex.remainingTime,true)
item:SetChildActive(sellItemIndex.state,false)
else
item:SetChildActive(sellItemIndex.remainingTime,false)
item:SetChildActive(sellItemIndex.state,true)
end
end
end
end


function UIWanBaoShangHui_sellWin:refreshItemTypeList()
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


function UIWanBaoShangHui_sellWin:selectItemType(itIndex,isKeepPos)
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


self.bagCanSellItemList=self:filterSelectTypeItemListWithSort()or{}
self.bagCanSellItemList=self:filterConditionAuctionItemList()

self.curPageIndex=1
self.isSetZero=nil
self.itemBagScrollView:clearSlowItems()
self:refreshBagItemPanel()
end


function UIWanBaoShangHui_sellWin:refreshBagItemPanel()
local itemsLen=#self.bagCanSellItemList
self.tPage=math.ceil(itemsLen/_creatGirdPrecent)
local curPageIndex=self.curPageIndex
local tNum=curPageIndex*_creatGirdPrecent
tNum=math.min(tNum,itemsLen)
local row=math.ceil(tNum/_colomn)+2
local minRow=math.ceil(_creatGirdPrecent/_colomn)
if row<minRow then
row=minRow
end
tNum=row*_colomn
self.space={}
self.itemBagScrollView:freshSlowGrids(tNum,row,_colomn,not self.isSetZero)
self.isSetZero=true
end


function UIWanBaoShangHui_sellWin:sortSellItemList()
local sort_func=function(a,b)
return a.auctionsec<b.auctionsec
end

local itemList=table.weakCopy(self.sellItemList)
if#itemList>1 then
table.sort(itemList,sort_func)
end
return itemList
end

function UIWanBaoShangHui_sellWin:filterSelectTypeItemListWithSort()

local selectTypeParam=self.itemTypeList[self.itSelectIndex]
local itemList={}
local itemMainType=selectTypeParam.itemType

local filterFun=function(selectTypeParam)
local itemType=selectTypeParam.itemType
local bagType=itemTypeToBagType[itemType]
local filter={[ITEM_FILTER_TYPE.eItemConfigAttr]={ITEM_FILTER_COMPARE.eNotNull,{'wbsh'}}}

if not bagType then
bagType=BAG_TYPE.eItemBag
end

if itemType1ToMainType[itemType]then

local mainType=itemType1ToMainType[itemType]
filter[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{mainType}}

if mainType==ITEM_MAIN_TYPE.eEquip then

filter[ITEM_FILTER_TYPE.eDianHuaEquip]={ITEM_FILTER_COMPARE.eEquals,false}


filter[ITEM_FILTER_TYPE.eIsBinding]={ITEM_FILTER_COMPARE.eEquals,false}
end
else

filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{itemType}}
end

if selectTypeParam.color then

local color=selectTypeParam.color
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,{color}}
end

if selectTypeParam.stage then

local stage=selectTypeParam.stage
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,{stage}}
end

return bagControl.getBagItemsByFilter(bagType,filter,function(list)
return list
end)
end

if itemMainType==-1 then

local tmpItemList={}
for i,v in ipairs(self.itemTypeList)do
if v.itemType~=-1 then
tmpItemList=filterFun(v)
end

if tmpItemList and next(tmpItemList)then

for i,v in ipairs(tmpItemList)do
itemList[#itemList+1]=v
end
end
end

else

itemList=filterFun(selectTypeParam)
end


table.sort(itemList,function(a,b)
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
local aCdTime=a.itemflag and mathHelper.getBitValue(a.itemflag,4-1)and a.itemtime or 0
local bCdTime=b.itemflag and mathHelper.getBitValue(b.itemflag,4-1)and b.itemtime or 0
if aConfig.color~=bConfig.color then
return aConfig.color>bConfig.color
elseif aConfig.stage and bConfig.stage and aConfig.stage~=bConfig.stage then
return aConfig.stage>bConfig.stage
elseif aCdTime~=bCdTime then
return aCdTime<bCdTime
elseif a.itemid~=b.itemid then
return a.itemid<b.itemid
else
return false
end
end)

return itemList
end
function UIWanBaoShangHui_sellWin:bindGrid(index,item)
local itemInfo=self.bagCanSellItemList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local showCount=count>1
local countStr=showCount and count or''
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local isEquip=itemsConfig.isEquip(itemid)
local isFabao=itemsConfig.isFabao(itemid)
local itemData=itemInfo.itemData or{}
local jinglianlv=isEquip and itemData.jinglianlv or
isFabao and itemData.jilianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local txt=(isEquip or isFabao)and jinglianStr or countStr
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local hasStage=stageStr~=''
local isLock=bagUseControl.isItemInAuctionSellCd(itemguid)
local isEquip=itemsConfig.isEquip(itemid)
local suitIcon=equipsHelper.getEquipSuitIcon(itemInfo)


widgetHelper.setItemQulaity(item,itemid,_cmpItemWidgetIdx.cmpQuality)
item:SetChildIcon(_cmpItemWidgetIdx.cmpIcon,iconName,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpIcon,true)
item:SetChildText(_cmpItemWidgetIdx.cmpCountTxt,txt)
item:SetChildActive(_cmpItemWidgetIdx.cmpStageBg,hasStage)
item:SetChildText(_cmpItemWidgetIdx.cmpStageTxt,stageStr)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpBg,true)
item:SetChildActive(_cmpItemWidgetIdx.cmpLock,isLock)
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,txt~='')
item:SetChildActive(_cmpItemWidgetIdx.cmpFabaoTag,isFabao)
item:SetChildActive(_cmpItemWidgetIdx.cmpReddot,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpEquipType,isEquip)
item:SetChildIcon(_cmpItemWidgetIdx.cmpEquipType,suitIcon,false)
item:SetBaseItemChildID(-1,itemid)
item:SetBaseItemChildGUID(-1,itemguid)
else
item:SetChildActive(_cmpItemWidgetIdx.cmpQuality,false)
item:SetChildIcon(_cmpItemWidgetIdx.cmpIcon,'',false)
item:SetChildActive(_cmpItemWidgetIdx.cmpIcon,false)
item:SetChildText(_cmpItemWidgetIdx.cmpCountTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpStageBg,false)
item:SetChildText(_cmpItemWidgetIdx.cmpStageTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpBg,true)
item:SetChildActive(_cmpItemWidgetIdx.cmpLock,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpFabaoTag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpReddot,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpEquipType,false)
item:SetBaseItemChildID(-1,-1)
item:SetBaseItemChildGUID(-1,-1)
end
end

function UIWanBaoShangHui_sellWin:freshMoneyValue(moneyType,lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(1)
self.fmTweenerList[1]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UIWanBaoShangHui_sellWin:freshMoneyValue_xianyu(lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_xianyu:getID())
local moneyVal=0
local moneyType=eMoneyType.mtXianYu
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(2)
self.fmTweenerList[2]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UIWanBaoShangHui_sellWin:clearFMTweenerByIndex(index)
if self.fmTweenerList[index]then
self.fmTweenerList[index]:Kill()
self.fmTweenerList[index]=nil
end
end

function UIWanBaoShangHui_sellWin:clearAllFMTweener()
for index,tweener in pairs(self.fmTweenerList)do
tweener:Kill()
self.fmTweenerList[index]=nil
end
end

function UIWanBaoShangHui_sellWin:freshMoney()
self.moneyRoot:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.moneyType
local isAdd=true
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)

self.moneyRoot_xianyu:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_xianyu:getID())
local moneyType=eMoneyType.mtXianYu
local isAdd=true
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end


function UIWanBaoShangHui_sellWin:filterConditionAuctionItemList()
local filterItemList={}
local filter=auctionModel:getPersonAuctionSecondFilter(self.itSelectIndex,FULL_TAB_TYPE.eWBSH_Sell)
for _,item in ipairs(self.bagCanSellItemList)do
if itemsFilterHelper.isFilter(filter,item)then
filterItemList[#filterItemList+1]=item
end
end






return filterItemList
end

function UIWanBaoShangHui_sellWin:on_it_item_click(clicknum,index)
local selectIndex=index+1

if selectIndex==self.itSelectIndex then
return
end

self:selectItemType(selectIndex)
end


function UIWanBaoShangHui_sellWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshSellItemList_notReset()
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIWanBaoShangHui_sellWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIWanBaoShangHui_sellWin:onEdgeEvent()
if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:refreshBagItemPanel()
end


function UIWanBaoShangHui_sellWin:onScrollItemClick(id,index,guid,attach)
if id==-1 then return end
local itemConfig=itemsConfig.getConfig(id)
if itemConfig then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eAuctionSellItem,
itemid=id,

backType=TIPS_BACK_TYPE.eNomal,
itemguid=guid,})
else
loggerUtil.logErrFMT('没有找到此道具：',id)
end
end


function UIWanBaoShangHui_sellWin:onClickCancelSellBtn(auctionSeries)
if not auctionSeries then
logErr("未传入下架拍卖品的唯一标识 请确认前端逻辑是否正确")
return
end

local auctionItemData=auctionModel:getPersonAuctionSellItemDataByAuctionSeries(auctionSeries)
if not auctionItemData then

logErr(FMT.fmt("找不到唯一标识为{0}的寄售道具 请检查前端逻辑是否正确",auctionSeries))
return
end


local hasActor=not mathHelper.compareInt64(auctionItemData.auctionactorid,int64.new(0))
if hasActor then
UIManager.error("已有人竞拍此物品，无法下架")
return
end


auctionController:reqPersonAuctionCancelGrounding(auctionSeries)
end


function UIWanBaoShangHui_sellWin:on_item_list_changed(argstable)
local finishCheckItemBagType={}
local needRefreshBagItemList=false

local showItemTypeList={}
local selectTypeParam=self.itemTypeList[self.itSelectIndex]
local selectItemType=selectTypeParam.itemType
if selectItemType==-1 then
for i,v in ipairs(self.itemTypeList)do
if v.itemType~=-1 then
local bagType=itemTypeToBagType[v.itemType]or BAG_TYPE.eItemBag
showItemTypeList[bagType]=true
end
end
else
local bagType=itemTypeToBagType[selectItemType]or BAG_TYPE.eItemBag
showItemTypeList[bagType]=true
end


for i,v in ipairs(argstable)do
local itemid=v[3]

local itemBagType=itemsConfig.getBagType(itemid)
if not finishCheckItemBagType[itemBagType]then
finishCheckItemBagType[itemBagType]=true
if showItemTypeList[itemBagType]then
needRefreshBagItemList=true
break
end
end
end

if needRefreshBagItemList then

self:selectItemType(self.itSelectIndex)
end
end


function UIWanBaoShangHui_sellWin:onClickSellingItem(auctionSeries,itemId,index,guid,attach)

if itemId==-1 then
return
end

local auctionItemData=auctionModel:getPersonAuctionSellItemDataByAuctionSeries(auctionSeries)
local itemData=nil
if auctionItemData and auctionItemData.data>0 then
itemData=auctionItemData.itemData
end

local itemguid=auctionModel:getItemguid(auctionSeries)
local nowTime=gameUtilityModel.getServerShortTime()
if auctionItemData.auctionsec then
local lerp=auctionItemData.auctionsec-nowTime
if lerp<=0 then

tipsManager.showTips({formType=TIPS_FORM_TYPE.eAuctionSellItem,
itemid=itemId,
itemguid=itemguid,
itemData=itemData,
isReSell=true,
auctionSeries=auctionSeries,
move=TIPS_MOVE_POS.eRight,})
return
end
end


tipsManager.showTips({itemid=itemId,itemguid=itemguid,itemData=itemData,move=TIPS_MOVE_POS.eRight})
end

function UIWanBaoShangHui_sellWin:onMoneyBtn()
if self.moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(self.moneyType)
end
end

function UIWanBaoShangHui_sellWin:onMoneyBtn_xianyu()
UIFullRechargeController:showRechargeWindow()
end

function UIWanBaoShangHui_sellWin:onMoneyChange(moneyType,lastVal,val)
if self.moneyType==moneyType then
self:freshMoneyValue(self.moneyType,lastVal)
end

if moneyType==eMoneyType.mtXianYu then
self:freshMoneyValue_xianyu(lastVal)
end
end

function UIWanBaoShangHui_sellWin:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UIWanBaoShangHui_sellWin:onFilterBtn()
self:showWindow("UIWanBaoShangHui_filterWin",{filterTypeCfgIndex=self.itSelectIndex,tabType=FULL_TAB_TYPE.eWBSH_Sell,winName="UIWanBaoShangHui_sellWin"})
end

