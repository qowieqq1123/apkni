







def_class("UIXM_XMDG_AuctionWin",UIWindowBase)









function UIXM_XMDG_AuctionWin:bindComponents()

self.refreshBtnText=UIText.get(self,0)
self.Content=UIObject.get(self,1)
self.itemScroller=UIObject.get(self,2)
self.nullTxt=UIText.get(self,3)
self.tipsText=UIText.get(self,4)
self.recordBtn=UIButton.get(self,5)
self.refreshBtn=UIButton.get(self,6)
self.rollLimitText=UIText.get(self,7)
self.model=UIObject.get(self,8)
self.tipsText2=UIText.get(self,9)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)



end


function UIXM_XMDG_AuctionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.refreshBtnText);self.refreshBtnText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.itemScroller);self.itemScroller=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.rollLimitText);self.rollLimitText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.tipsText2);self.tipsText2=nil;
end
















local auctionItemIndex={
name=0,
item=1,
costIcon=2,
costText=3,
playerInfo=4,
head=5,
playerName=6,
notPlayerTips=7,
biddingBtn=8,
biddingFlag=9,
maxRollPoint=10,
overLimitFlag=11,
limit=12,
biddingBtnText=13,
selfFlag=14,
}

local _autoRefreshCdTime=10
local _refreshBtnCdTime=2
local _creatGirdPrecent=10




function UIXM_XMDG_AuctionWin:onLoaded(...)
self:bindComponents()
self.loopListView=self.winlua:GetChildUILoopListView(self.itemScroller:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScroller:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
end


function UIXM_XMDG_AuctionWin:__delete()
self:clearAutoRefreshCdTimer()
self:clearRefreshBtnCdTimer()
self.loopListView:SetAction(nil,nil)
self.loopListView=nil
self:unbindComponents()
self:closeWindow("UITopMoneyWin2")
end




function UIXM_XMDG_AuctionWin:onShow(argtable,afterOnloaded)

self.itemCfg=cfg_xmdgshopitemconfig()
self.auctionBaseCfg=cfgHelper.get1(cfg_xmdgauctionconfig_get,1)


self.oldNotReadMsgList=table.weakCopy(xianmengdigongModel:getXMDG_allNewAuctionMsgAddTimeList())

if afterOnloaded then

local modelId=4107
self.model:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand,false,false,0)
self.model:setChildUIModelShowTargetOffset(-366,0)


xianmengdigongController:clearAllNotReadMsgList()
xianmengdigongController:checkReadAddAuctionMsgNum()
end

self:onShowArgRecv(argtable,afterOnloaded,true)
end

function UIXM_XMDG_AuctionWin:onShowArgRecv(argtable,afterOnloaded,isInit)
if isInit then

xianmengdigongController:reqAuctionItemList(true)
else

local isOverSettleTime=xianmengdigongController:checkIsOverSettleTime()
if isOverSettleTime then


self:clearAutoRefreshCdTimer()

xianmengdigongController:reqAuctionItemList(true)
end
end


self:refresh()


self:setRefreshBtnCdTimer()


local tipsText=self.auctionBaseCfg.tipsText
self.tipsText:setText(tipsText)


local tipsTextBottom=self.auctionBaseCfg.tipsTextBottom
self.tipsText2:setText(tipsTextBottom)


self:showTopMoney()
end


function UIXM_XMDG_AuctionWin:refreshByAutoCd(isIgnoreCdTimer)

if not isIgnoreCdTimer and self.autoRefreshCdTimer then
return
end

self:clearAutoRefreshCdTimer()
self.autoRefreshCdTimer=self:delayDo(_autoRefreshCdTime,function()
if xianmengdigongController:checkXMDGIsActive()then

self:refresh(true)
end
return self:clearAutoRefreshCdTimer()
end)
self:refresh(true)
end

function UIXM_XMDG_AuctionWin:onStartView()

end

function UIXM_XMDG_AuctionWin:onFreshListView(index,widget)
index=index+1
self:refreshAuctionItem(widget,index)
end

function UIXM_XMDG_AuctionWin:refresh(isKeepPos)
local originalCount=self.auctionItemSortList and#self.auctionItemSortList or 0

self.auctionItemList=xianmengdigongModel:getXMDG_auctionItemList()

self:sortAuctionItemList()

local count=#self.auctionItemSortList
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

self.nullTxt:setText("暂无重宝")
end
















local rollCount=xianmengdigongModel:getXMDG_auctionRollCount()or 0
local maxRollCount=self.auctionBaseCfg.roll_times
local remainingRollCount=maxRollCount-rollCount
local rollCountStr
if remainingRollCount<=0 then
rollCountStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",remainingRollCount,maxRollCount)
else
rollCountStr=FMT.cfmt(FONT_COLOR.eGreenColor,"{0}/{1}",remainingRollCount,maxRollCount)
end

self.rollLimitText:setText(rollCountStr)
end


function UIXM_XMDG_AuctionWin:onHide()
self:clearAutoRefreshCdTimer()
self:clearRefreshBtnCdTimer()
self:closeWindow("UITopMoneyWin2")
end


function UIXM_XMDG_AuctionWin:sortAuctionItemList()
self.auctionItemSortList={}
if not self.auctionItemList or not next(self.auctionItemList)then

return
end

for i,v in pairs(self.auctionItemList)do
local itemId=v.itemInfo.itemid

local cfg=self.itemCfg[itemId]
if cfg and cfg.shop_type==2 then
local sortWeight=cfg.sortId
local isBade=v.shop_roll_times and v.shop_roll_times>0 or false
if isBade then
sortWeight=sortWeight-100000
end

local item={
idx=v.idx,
actorId=v.actor_id,
actorName=v.actor_name,
iconInfo=v.iconInfo,
itemId=itemId,
itemInfo=v.itemInfo,
moneyType=cfg.cost[1],
price=cfg.cost[2],
addTime=v.add_time,
sortWeight=sortWeight,
maxRollPoint=v.max_roll,
exchangeTimes=v.exchange_times,
limit=cfg.limit_num or 0,
isBade=isBade,
}
table.insert(self.auctionItemSortList,item)
else
logErr(FMT.fmt("仙盟地宫道具配置表中未找到道具id为 {0}且类型为拍卖的道具，请检查配置是否正确",itemId))
end
end

table.sort(self.auctionItemSortList,function(a,b)
if a.sortWeight==b.sortWeight then
return a.itemId<b.itemId
else
return a.sortWeight<b.sortWeight
end
end)
end


function UIXM_XMDG_AuctionWin:refreshAuctionItem(item,index)
if item==nil then

item=self.itemScroller:getSlowItemByIndex(index-1)
end
local auctionData=self.auctionItemSortList[index]

if item and auctionData then
item:SetChildActive(-1,true)

local itemInfo=auctionData.itemInfo
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local count=itemInfo.itemcount
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isShowStage=itemsConfig.isMaterials(itemid)
local conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=isShowStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget=item:GetChildWidgetBase(auctionItemIndex.item)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(index,...)
end)


local isNew=true
local addTimeStr=tostring(auctionData.addTime)
if auctionData.addTime==0 or self.oldNotReadMsgList[addTimeStr]then
isNew=false
end
widget:SetChildActive(2,isNew)


local itemConfig=itemsConfig.getConfig(itemid)
local itemName=itemConfig.name
item:SetChildText(auctionItemIndex.name,itemName)


local cost=auctionData.price
local moneyType=auctionData.moneyType
local moneyCount=cost*count

item:SetChildActive(auctionItemIndex.costIcon,true)
item:SetChildIcon(auctionItemIndex.costIcon,iconHelper.getIconName(moneyType),false)

item:SetChildText(auctionItemIndex.costText,FMT.fmt("{0}",moneyCount))

local hasPlayer=auctionData.actorId and not mathHelper.compareInt64(auctionData.actorId,int64.new(0))
if hasPlayer then

item:SetChildActive(auctionItemIndex.notPlayerTips,false)
item:SetChildActive(auctionItemIndex.playerInfo,true)


local headArgs={}
headArgs.iconInfo=auctionData.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(item,-1,headArgs)
item:SetChildButtonClickWithID(auctionItemIndex.head,function(index)
self:onClickHead(auctionData.actorId)
end,index)

local playerName=auctionData.actorName
item:SetChildText(auctionItemIndex.playerName,playerName)


local isSelf=playerModel:checkActorId(auctionData.actorId)
item:SetChildActive(auctionItemIndex.selfFlag,isSelf)
else

item:SetChildActive(auctionItemIndex.notPlayerTips,true)
item:SetChildActive(auctionItemIndex.playerInfo,false)
end


local maxRollPointStr=auctionData.maxRollPoint and tostring(auctionData.maxRollPoint)or""
item:SetChildText(auctionItemIndex.maxRollPoint,maxRollPointStr)

local isOverLimit=false
if auctionData.limit and auctionData.limit~=0 then

local limit=math.abs(auctionData.limit)
local biddingCount=auctionData.exchangeTimes or 0
local remainingCount=limit-biddingCount
if remainingCount<=0 then
remainingCount=0
isOverLimit=true
end


local limitText=tostring(remainingCount)
if isOverLimit then
local showBiddingCount=biddingCount>limit and limit or biddingCount
limitText=FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",showBiddingCount,limit)
else
limitText=FMT.fmt("{0}/{1}",biddingCount,limit)
end
item:SetChildText(auctionItemIndex.limit,FMT.fmt("获得数量: {0}",limitText))
item:SetChildActive(auctionItemIndex.limit,true)
else

item:SetChildActive(auctionItemIndex.limit,false)
end



item:SetChildActive(auctionItemIndex.biddingBtn,true)
item:SetChildButtonClick(auctionItemIndex.biddingBtn,function()
self:onClickBiddingBtn(auctionData.idx)
end)
local isBade=auctionData.isBade
local btnText=isBade and"已竞投"or"竞投"
item:SetChildText(auctionItemIndex.biddingBtnText,btnText)


item:SetChildActive(auctionItemIndex.biddingFlag,false)



item:SetChildActive(auctionItemIndex.overLimitFlag,false)
else
item:SetChildActive(-1,false)
end
end





function UIXM_XMDG_AuctionWin:onRecordBtn()
if not xianmengdigongController:checkXMDGIsActive(true)then

return
end

local isNewData=xianmengdigongController:checkXMDGAuctionDataIsNew()
if not isNewData then
UIManager.error("本轮地宫活动已结束，请刷新页面")
return
end

local isOverSettleTime=xianmengdigongController:checkIsOverSettleTime()
if isOverSettleTime then
UIManager.error("本次竞投已结束，请刷新页面")
return
end


self:showWindow("UIXM_XMDG_RecordWin",{recordType=XMDG_Shop_Record_Type.eAuction})
end



function UIXM_XMDG_AuctionWin:onRefreshBtn()
if not xianmengdigongController:checkXMDGIsActive(true)then

return
end

local cur=xianmengdigongModel:getXMDG_auctionRefreshBtnCd()
local isInCd=cur>0
if isInCd then


UIManager.error("刷新过于频繁，请稍候重试")
return
end


self.oldNotReadMsgList=table.weakCopy(xianmengdigongModel:getXMDG_allNewAuctionMsgAddTimeList())


xianmengdigongController:reqAuctionItemList()


local cdEndTime=gameUtilityModel.getServerShortTime()+_refreshBtnCdTime
xianmengdigongModel:setXMDG_auctionRefreshBtnCdEndTime(cdEndTime)
self:setRefreshBtnCdTimer()
end


function UIXM_XMDG_AuctionWin:onClickRewardItem(auctionItemSortIndex,itemId,index,guid,attach)
if itemId==-1 then
return
end

local watch=watchModel.getItem(guid)
if watch==nil then
local auctionData=self.auctionItemSortList[auctionItemSortIndex]
local itemInfo=auctionData.itemInfo
watchModel.setItem(itemInfo)
end

tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end


function UIXM_XMDG_AuctionWin:onClickHead(actorId)
if playerModel:checkActorId(actorId)then

return
end

otherPlayerController:openOtherPlayerInfoWin(actorId)
end


function UIXM_XMDG_AuctionWin:onClickBiddingBtn(auctionItemIdx)
if not xianmengdigongController:checkXMDGIsActive(true)then

return
end

local isNewData=xianmengdigongController:checkXMDGAuctionDataIsNew()
if not isNewData then
UIManager.error("本轮地宫活动已结束，请刷新页面")
return
end

local isOverSettleTime=xianmengdigongController:checkIsOverSettleTime()
if isOverSettleTime then
UIManager.error("本次竞投已结束，请刷新页面")
return
end

self:showWindow("UIXM_XMDG_RollPointWin",{auctionItemIdx=auctionItemIdx})


self:closeWindow("UITopMoneyWin2")
end

function UIXM_XMDG_AuctionWin:clearAutoRefreshCdTimer()
if self.autoRefreshCdTimer then
self:stopTimerByID(self.autoRefreshCdTimer)
self.autoRefreshCdTimer=nil
end
end

function UIXM_XMDG_AuctionWin:setRefreshBtnCdTimer()
self:clearRefreshBtnCdTimer()
local func=function()
local cur=xianmengdigongModel:getXMDG_auctionRefreshBtnCd()
local isInCd=cur>0
if isInCd then
self.refreshBtnText:setText(FMT.fmt("刷新({0})",cur))
else
self.refreshBtnText:setText("刷新")
return self:clearRefreshBtnCdTimer()
end
end

self.refreshBtnCdTimer=self:setTimer(1,0,func)

func()
end

function UIXM_XMDG_AuctionWin:clearRefreshBtnCdTimer()
if self.refreshBtnCdTimer then
self:stopTimerByID(self.refreshBtnCdTimer)
self.refreshBtnCdTimer=nil
end
end

function UIXM_XMDG_AuctionWin:showTopMoney()

self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtDiGongContribute}},offsetX=90,offsetY=-25})
end