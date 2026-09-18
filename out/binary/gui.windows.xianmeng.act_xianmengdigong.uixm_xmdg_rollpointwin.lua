







def_class("UIXM_XMDG_RollPointWin",UIWindowBase)









function UIXM_XMDG_RollPointWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.rollRankScroller=UIObject.get(self,1)
self.nullTxt=UIText.get(self,2)
self.item=UIObject.get(self,3)
self.moneyText=UIText.get(self,4)
self.moneyIcon=UIImage.get(self,5)
self.helpBtn=UIButton.get(self,6)
self.numList=UIObject.get(self,7)
self.clickRollArea=UIButton.get(self,8)
self.bgModel=UIObject.get(self,9)
self.remainingCountText=UIText.get(self,10)
self.moneyRoot=UIObject.get(self,11)
self.moneyBtn=UIButton.get(self,12)
self.clickEffect=UIObject.get(self,13)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.clickRollArea:setButtonClick(function()self:onClickRollArea()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)



end


function UIXM_XMDG_RollPointWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.rollRankScroller);self.rollRankScroller=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.numList);self.numList=nil;
_UIObject_release(self.clickRollArea);self.clickRollArea=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.remainingCountText);self.remainingCountText=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.clickEffect);self.clickEffect=nil;
end
















local _this

local rankItemIndex={
selectBg=0,
head=1,
playerName=2,
rollPoint=3,
selectFlag=4,
}

local rollItemIndex={
num_now=0,
num_next=1,
numText_now=2,
numText_next=3,
}

local _minColor=0.5



function UIXM_XMDG_RollPointWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChange(...)end)
end


function UIXM_XMDG_RollPointWin:__delete()
local win=UIManager:findActiveWindow('UIXM_XMDG_AuctionWin')
if win then

win:showTopMoney()
end

self:unbindComponents()
self:clearUpdateTimer()
self:clearFMTweener()
_this=nil
end




function UIXM_XMDG_RollPointWin:onShow(argtable,afterOnloaded)
self.auctionItemIdx=argtable and argtable.auctionItemIdx
if not self.auctionItemIdx then
logErr("仙盟地宫竞投界面打开出错 未传入拍卖品的唯一标识 请前端确认界面传参是否正确")
return
end


local modelId=4102
self.bgModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand2,false,false,0)


xianmengdigongController:reqAuctionItemRollRankList(self.auctionItemIdx)
self.isRolling=nil
self.selfPlayerId=playerModel:getActorID()
self.fmTweener=nil
self.finishRollNum=nil
self.thisRoundRollPoint=nil

local rollParam=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'rollParam')or{}
self.delayStartRollTime=rollParam.delayStartRollTime or 0
self.speedLowTime=rollParam.speedLowTime or 4
self.maxSpeed=rollParam.maxSpeed or 35
self.delayTime=rollParam.delayTime or 0.1
self.baseRoundCount=rollParam.baseRoundCount or 1
self.addRoundCount=rollParam.addRoundCount or 1


local effectId=10045
self.clickEffect:setChildShowEffect(effectId,true)

self:initRollNumData()
self:refresh()

if self:checkCanRoll()then

self.bgModel:setChildModelAnimationState(eAnimationID.stand,1)
end
end


function UIXM_XMDG_RollPointWin:onHide()

end


function UIXM_XMDG_RollPointWin:initRollNumData()
self.rollNumItemList={}
local grids=self.numList:getChildCommonLayoutGroupWidgetList()
self.rollNumItemCount=grids.Count
for i=1,self.rollNumItemCount do
self.rollNumItemList[i]=grids[i-1]
end



self.numTable={0,9,8,7,6,5,4,3,2,1}
self.numTableIndexList_lookup={}
self.numNowSelectIndex={1,1,1,1}
self.numCount=#self.numTable
local count=#self.numTable
for i=1,count do
local num=self.numTable[i]
self.numTableIndexList_lookup[num]=i
end


self:refreshRoll()
end

function UIXM_XMDG_RollPointWin:refreshRoll()
for i=1,self.rollNumItemCount do
self:refreshRollItem(i)
end
end

function UIXM_XMDG_RollPointWin:refreshRollItem(itemIndex,isSetByRollData)
local rollItem=self.rollNumItemList[itemIndex]
local selectIndex=self.numNowSelectIndex[itemIndex]
local nowNum=self.numTable[selectIndex]
local nextIndex=selectIndex+1
if nextIndex>self.numCount then
nextIndex=1
end
local nextNum=self.numTable[nextIndex]
rollItem:SetChildText(rollItemIndex.numText_now,nowNum)

local nowScale=1
local nextScale=0
local nowColor=1
local nextColor=_minColor
if isSetByRollData then
nowScale=nowScale+self.rollRemainingData[itemIndex].remainingNowScale
nextScale=nextScale-self.rollRemainingData[itemIndex].remainingNextScale
nowColor=nowColor+self.rollRemainingData[itemIndex].remainingNowColor
nextColor=nextColor-self.rollRemainingData[itemIndex].remainingNextColor
end

rollItem:SetChildColor(rollItemIndex.num_now,Color.New(nowColor,nowColor,nowColor,1))
rollItem:SetChildScale(rollItemIndex.num_now,Vector3.New(1,nowScale,1))
rollItem:SetChildScale(rollItemIndex.num_next,Vector3.New(1,nextScale,1))
rollItem:SetChildColor(rollItemIndex.num_next,Color.New(nextColor,nextColor,nextColor,1))

rollItem:SetChildText(rollItemIndex.numText_next,nextNum)
end

function UIXM_XMDG_RollPointWin:refresh()

self.auctionItemData=xianmengdigongModel:getXMDG_auctionItemDataByIdx(self.auctionItemIdx)
if not self.auctionItemData then
logErr(FMT.fmt("仙盟地宫竞投界面获取拍卖品数据出错 找不到唯一标识为{0}对应的拍卖品数据 请前端检查数据是否正确",self.auctionItemIdx))
return
end


local itemInfo=self.auctionItemData.itemInfo
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid

local auctionItemCfg=cfgHelper.get1(cfg_xmdgshopitemconfig_get,itemid)
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
local widget=self.item:getWidgetBase()
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


self.cost=auctionItemCfg.cost[2]
self.moneyType=auctionItemCfg.cost[1]
local moneyCount=self.cost*count
self.moneyIcon:setChildIcon(iconHelper.getIconName(self.moneyType),false)
self.moneyText:setText(FMT.fmt("{0}",moneyCount))


local limit=auctionItemCfg.limit_num or 0
self.limitCount=math.abs(limit)


self:refreshRemainingCount()


self:refreshRollRank()


self:freshMoney()


local isShowClickEff=self:checkCanRoll()
self.clickEffect:setActive(isShowClickEff)
end


function UIXM_XMDG_RollPointWin:refreshRemainingCount()
local rollCount=xianmengdigongModel:getXMDG_auctionRollCount()or 0
local maxRollCount=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'roll_times')
local remainingRollCount=maxRollCount-rollCount
local remainingRollCountStr
if remainingRollCount<=0 then
remainingRollCountStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}",remainingRollCount)
else

remainingRollCountStr=FMT.cfmt(FONT_COLOR.eGreenColor,"{0}",remainingRollCount)
end
self.remainingCountText:setText(FMT.fmt("（今天投点次数：{0}）",remainingRollCountStr))
end


function UIXM_XMDG_RollPointWin:refreshRollRank()

self.auctionRankList=xianmengdigongModel:getXMDG_auctionRollRankList(self.auctionItemIdx)or{}


self.isRolled=self.auctionItemData.shop_roll_times and self.auctionItemData.shop_roll_times>0 or false
if self.isRolled then

local selfRollNum
if self.thisRoundRollPoint then
selfRollNum=self.thisRoundRollPoint
else
selfRollNum=xianmengdigongModel:getXMDG_auctionSelfRollNum(self.auctionItemIdx)
end

if selfRollNum then

self:changRollNum(selfRollNum)
end
end

if not self.isSortList then

self:sortAuctionRollRankList()
end

if not self.sortRankList or not next(self.sortRankList)then

self.nullTxt:setText("暂无盟员竞投")
self.nullTxt:setActive(true)
return
end

self.nullTxt:setActive(false)

self.rollRankScroller:setChildScrollViewCreateGrids(#self.sortRankList,1)
local grids=self.rollRankScroller:getChildScrollViewItemWidgets()
for i=1,grids.Count do
self:refreshRankItem(grids[i-1],i)
end
end


function UIXM_XMDG_RollPointWin:sortAuctionRollRankList()
self.sortRankList={}
if not self.auctionRankList or not next(self.auctionRankList)then
return
end

local list={}
for i,v in ipairs(self.auctionRankList)do
local item={}

item.actorId=v.actor_id
item.actorName=v.actor_name
item.iconInfo=v.iconInfo
item.rollNum=v.roll_num
item.rollTime=v.roll_time or 0
table.insert(list,item)
end

table.sort(list,function(a,b)
if a.rollNum==b.rollNum then

return a.rollTime<b.rollTime
else
return a.rollNum>b.rollNum
end
end)
self.sortRankList=list
end


function UIXM_XMDG_RollPointWin:refreshRankItem(item,index)
if item==nil then
item=self.rollRankScroller:getChildScrollViewItemWidget(index-1)
end

if item then
local rankData=self.sortRankList[index]
local name=rankData.actorName
local point=rankData.rollNum
item:SetChildText(rankItemIndex.playerName,name)
item:SetChildText(rankItemIndex.rollPoint,FMT.fmt("({0})",point))


local headArgs={}
headArgs.iconInfo=rankData.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(item,-1,headArgs)
item:SetChildButtonClickWithID(rankItemIndex.head,function(index)
self:onClickHead(rankData.actorId)
end,index)

local actorId=rankData.actorId
local isSelf=mathHelper.compareInt64(actorId,self.selfPlayerId)
item:SetChildActive(rankItemIndex.selectBg,isSelf)

local isFirst=index==1
item:SetChildActive(rankItemIndex.selectFlag,isFirst)
end
end

function UIXM_XMDG_RollPointWin:freshMoney()
self.moneyRoot:setActive(true)

local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.moneyType

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,true)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end

function UIXM_XMDG_RollPointWin:freshMoneyValue(moneyType,lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweener()
self.fmTweener=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UIXM_XMDG_RollPointWin:refreshCatModelAndEff()
local isCanRoll=self:checkCanRoll()

if isCanRoll then

self.bgModel:setChildModelAnimationState(eAnimationID.stand,1)
else

self.bgModel:setChildModelAnimationState(eAnimationID.stand2,1)
end


self.clickEffect:setActive(isCanRoll)
end

function UIXM_XMDG_RollPointWin:roll2NextByRollIndex(index,speed,delayStartTime,isResetRemainingData)
if not self.needUpdateRollList then
self.needUpdateRollList={}
end

if not self.needUpdateRollList[index]then
self.needUpdateRollList[index]={}
end

if not self.rollRemainingData then
self.rollRemainingData={}
end

if not self.rollRemainingData[index]then
self.rollRemainingData[index]={}
end

if isResetRemainingData then
self.rollRemainingData[index].remainingNowScale=0
self.rollRemainingData[index].remainingNextScale=0
self.rollRemainingData[index].remainingNowColor=0
self.rollRemainingData[index].remainingNextColor=0
end

self.needUpdateRollList[index].delayStartTime=delayStartTime or 0
self.needUpdateRollList[index].speed=speed
self.needUpdateRollList[index].numNowScale=1+self.rollRemainingData[index].remainingNowScale
self.needUpdateRollList[index].numNextScale=0-self.rollRemainingData[index].remainingNextScale
self.needUpdateRollList[index].numNowColor=1+self.rollRemainingData[index].remainingNowColor
self.needUpdateRollList[index].numNextColor=_minColor-self.rollRemainingData[index].remainingNextColor

self:startUpdateTimer()
end

function UIXM_XMDG_RollPointWin:startUpdateTimer()
if self.updateTimer==nil then
local updateFunc=function()
local deltaTime=Time.deltaTime
self:onUpdate(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)
end
end

function UIXM_XMDG_RollPointWin:onUpdate(deltaTime)
if not next(self.needUpdateRollList)then

return self:clearUpdateTimer()
end

for index,data in pairs(self.needUpdateRollList)do
local isFinishCount=0
if not data.isFinish then
if data.delayStartTime and data.delayStartTime>0 then

data.delayStartTime=data.delayStartTime-deltaTime
if data.delayStartTime<0 then
data.delayStartTime=0
end
else
local speed=data.speed*deltaTime
local sizeChangeValue=speed/10
local colorChangeValue=speed/10*(1-_minColor)
local rollItem=self.rollNumItemList[index]


local targetNumNowScale=data.numNowScale-sizeChangeValue
if targetNumNowScale<=0 then
self.rollRemainingData[index].remainingNowScale=targetNumNowScale

isFinishCount=isFinishCount+1
end
rollItem:SetChildScale(rollItemIndex.num_now,Vector3.New(1,targetNumNowScale,1))
data.numNowScale=targetNumNowScale

local targetNumNextScale=data.numNextScale+sizeChangeValue
if targetNumNextScale>=1 then
self.rollRemainingData[index].remainingNextScale=1-targetNumNextScale

isFinishCount=isFinishCount+1
end
rollItem:SetChildScale(rollItemIndex.num_next,Vector3.New(1,targetNumNextScale,1))
data.numNextScale=targetNumNextScale

local targetNumNowColor=data.numNowColor-colorChangeValue
if targetNumNowColor<=_minColor then
self.rollRemainingData[index].remainingNowColor=targetNumNowColor-_minColor

isFinishCount=isFinishCount+1
end
rollItem:SetChildColor(rollItemIndex.num_now,Color.New(targetNumNowColor,targetNumNowColor,targetNumNowColor,1))
data.numNowColor=targetNumNowColor

local targetNumNextColor=data.numNextColor+colorChangeValue
if targetNumNextColor>=1 then
self.rollRemainingData[index].remainingNextColor=1-targetNumNextColor

isFinishCount=isFinishCount+1
end
rollItem:SetChildColor(rollItemIndex.num_next,Color.New(targetNumNextColor,targetNumNextColor,targetNumNextColor,1))
data.numNextColor=targetNumNextColor

if isFinishCount>=4 then
data.isFinish=true
self:finishRoll2Next(index,data.speed)
end
end
end
end
end

function UIXM_XMDG_RollPointWin:finishRoll2Next(index,speed)
self.needUpdateRollList[index]=nil
local selectIndex=self.numNowSelectIndex[index]+1
if selectIndex>self.numCount then
selectIndex=1
end
self.numNowSelectIndex[index]=selectIndex

local rollTime=self.rollTimeList[index]or 0
rollTime=rollTime-1
if rollTime<=0 then
rollTime=0
end
self.rollTimeList[index]=rollTime
if rollTime>0 then
if rollTime<=self.speedLowTime then
local downLowSpeedValue=self.maxSpeed/(self.speedLowTime+1)*0.8
speed=speed-downLowSpeedValue
end
self:refreshRollItem(index,true)
return self:roll2NextByRollIndex(index,speed)
else
self:refreshRollItem(index)
return self:finishRollByIndex(index)
end
end

function UIXM_XMDG_RollPointWin:clearUpdateTimer()
if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
end

function UIXM_XMDG_RollPointWin:roll2Num(num)
self:clearUpdateTimer()
self:refreshRoll()

self.finishRollNum=num
local posNum=self:getPosNumListByNum(num)

self.rollFinishCount=0
self.rollTimeList={}
local speed=self.maxSpeed
local round=self.baseRoundCount
local finishOneNextTime=self.delayTime
for i=1,self.rollNumItemCount do
local nowSelectIndex=self.numNowSelectIndex[i]
local nowNum=self.numTable[nowSelectIndex]
local needCount=self:getNow2TargetNumNeedCount(nowNum,posNum[i])
self.rollTimeList[i]=(round+i*self.addRoundCount)*self.numCount+needCount
local delayTime=(i-1)*finishOneNextTime
self:roll2NextByRollIndex(i,speed,delayTime,true)
end
end


function UIXM_XMDG_RollPointWin:changRollNum(num)
local posNumList=self:getPosNumListByNum(num)


for i=1,self.rollNumItemCount do
local posNum=posNumList[i]
local posNumIndex=self.numTableIndexList_lookup[posNum]
self.numNowSelectIndex[i]=posNumIndex
end


self:refreshRoll()
end


function UIXM_XMDG_RollPointWin:getNow2TargetNumNeedCount(nowNum,targetNum)
local nowNumIndex=self.numTableIndexList_lookup[nowNum]
local targetNumIndex=self.numTableIndexList_lookup[targetNum]
if targetNumIndex>nowNumIndex then
return targetNumIndex-nowNumIndex
else
return self.numCount-nowNumIndex+targetNumIndex
end
end

function UIXM_XMDG_RollPointWin:getPosNumListByNum(num)
local posNum={}
posNum[1]=num%10
posNum[2]=num<10 and 0 or math.floor(num%100/10)
posNum[3]=num<100 and 0 or math.floor(num%1000/100)
posNum[4]=num<1000 and 0 or math.floor(num/1000)

return posNum
end

function UIXM_XMDG_RollPointWin:finishRollByIndex(rollIndex)
self.rollFinishCount=self.rollFinishCount+1
if self.rollFinishCount>=self.rollNumItemCount then

self.isRolling=nil

local num=self.finishRollNum
self.finishRollNum=nil
self:showRollFinishTips(num)

self:refreshCatModelAndEff()


return self:refreshRollRank()
end
end

function UIXM_XMDG_RollPointWin:showRollFinishTips(num)

local auctionItemData=xianmengdigongModel:getXMDG_auctionItemDataByIdx(self.auctionItemIdx)
local tipsList=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'rollFinishTips')or{}
local tipsStr
local checkNum=num

if auctionItemData.max_roll and num>=auctionItemData.max_roll then
if auctionItemData.actor_id and playerModel:checkActorId(auctionItemData.actor_id)then
checkNum=-1
end
end

for i,v in ipairs(tipsList)do
local minNum=v[1]
local maxNum=v[2]
local tips=v[3]
if checkNum>=minNum and checkNum<=maxNum then
tipsStr=FMT.fmt(tips,num)
break
end
end

if tipsStr then
UIManager.info(tipsStr)
end
end


function UIXM_XMDG_RollPointWin:onClickRollArea()
if self.isRolling then
return
end

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

if not self:checkCanRoll(true)then

return
end


local itemInfo=self.auctionItemData.itemInfo
local count=itemInfo.itemcount
local moneyType=self.moneyType
local price=self.cost*count
moneySystem:useMoney(moneyType,price,function()

local animId=2091
self.bgModel:setChildModelAnimationState(animId,1)


xianmengdigongController:reqAuctionItemStartRollPoint(self.auctionItemIdx)
self.isRolling=true


self.clickEffect:setActive(false)
end,WARNING_TYPE.eWarning)


end


function UIXM_XMDG_RollPointWin:onBtnClose()
self:closeSelf()
end



function UIXM_XMDG_RollPointWin:onHelpBtn()

local langId=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'rollRuleLangId')
local d={}
d.title='重宝竞投规则介绍'
d.mode=3
d.name=langId
d.moveSortOrder=2
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UIXM_XMDG_RollPointWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end

local watch=watchModel.getItem(guid)
if watch==nil then
local itemInfo=self.auctionItemData.itemInfo
watchModel.setItem(itemInfo)
end

tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIXM_XMDG_RollPointWin:startRollWithRecv(idx,num)
if not idx or idx~=self.auctionItemIdx then
return
end
self.isRolled=true

self:refreshRemainingCount()

self.thisRoundRollPoint=num

if self.delayStartRollTime>0 then
self:delayDo(self.delayStartRollTime,function()
return self:roll2Num(num)
end)
else
return self:roll2Num(num)
end
end


function UIXM_XMDG_RollPointWin:onClickHead(actorId)
if mathHelper.compareInt64(actorId,self.selfPlayerId)then

return
end

otherPlayerController:openOtherPlayerInfoWin(actorId)
end


function UIXM_XMDG_RollPointWin:onMoneyBtn()
gainControl:showGainWin(self.moneyType)
end

function UIXM_XMDG_RollPointWin:onAddClick(moneyType)
gainControl:showGainWin(moneyType)
end

function UIXM_XMDG_RollPointWin:onMoneyChange(moneyType,lastVal,val)
if self.moneyType==moneyType then
self:freshMoneyValue(self.moneyType,lastVal)
end
end

function UIXM_XMDG_RollPointWin:clearFMTweener()
if self.fmTweenerList then
self.fmTweenerList:Kill()
self.fmTweenerList=nil
end
end

function UIXM_XMDG_RollPointWin:checkCanRoll(isWarning)











if self.limitCount and self.limitCount~=0 then

local biddingCount=self.auctionItemData.exchange_times or 0
if biddingCount>=self.limitCount then
if isWarning then
UIManager.error("已达本轮活动获得上限")
end
return false
end
end


local rollCount=xianmengdigongModel:getXMDG_auctionRollCount()or 0
local maxRollCount=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'roll_times')
local remainingRollCount=maxRollCount-rollCount
if remainingRollCount<=0 then

if isWarning then
UIManager.error("当前剩余投点次数不足")
end
return false
end

return true
end



function UIXM_XMDG_RollPointWin.test_getRollNum()
if _this==nil then return end
local posNum={}

for i=1,_this.rollNumItemCount do
local nowSelectIndex=_this.numNowSelectIndex[i]
posNum[i]=_this.numTable[nowSelectIndex]
end

UIManager.info(FMT.fmt("当前滚轮数字为：{0}{1}{2}{3}",posNum[4],posNum[3],posNum[2],posNum[1]))
end



function UIXM_XMDG_RollPointWin.test_startRoll2Num(num)
if _this==nil then return end
_this:roll2Num(num)
end



function UIXM_XMDG_RollPointWin.test_setRollNum(num)
if _this==nil then return end
_this:changRollNum(num)
end



function UIXM_XMDG_RollPointWin:test_showRollFinishTips(num)
if _this==nil then return end
_this:showRollFinishTips(num)
end