







def_class("UISubAct_shenhaixunbaoWin",UIWindowBase)









function UISubAct_shenhaixunbaoWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.ruleBtn=UIButton.get(self,2)
self.rollBtnTxt=UIText.get(self,3)
self.rollBtn=UIButton.get(self,4)
self.freeCountText=UIText.get(self,5)
self.costBtn=UIButton.get(self,6)
self.timeText=UIText.get(self,7)
self.playerModel=UIObject.get(self,8)
self.rollBtnEffect=UIObject.get(self,9)
self.dicepanel=UIObject.get(self,10)
self.dicePerfab=UIObject.get(self,11)
self.costPanel=UIObject.get(self,12)
self.costIcon=UIImage.get(self,13)
self.costCountText=UIText.get(self,14)
self.diceEffect=UIObject.get(self,15)
self.diceEffect2=UIObject.get(self,16)
self.skipBtn=UIButton.get(self,17)
self.skipSelectImg=UIObject.get(self,18)
self.autoPanel=UIObject.get(self,19)
self.startAutoButton=UIButton.get(self,20)
self.cancelAutoButton=UIButton.get(self,21)
self.autoImg=UIObject.get(self,22)
self.preffect=UIObject.get(self,23)
self.isShowReddotBtn=UIButton.get(self,24)
self.mapGridsGroup=UIObject.get(self,25)
self.progressBtn=UIButton.get(self,26)
self.progressText=UIText.get(self,27)
self.progressReddot=UIObject.get(self,28)
self.wildDieBtn=UIButton.get(self,29)
self.wildDieCountText=UIText.get(self,30)
self.rewardGroup=UIObject.get(self,31)
self.recordBtn=UIButton.get(self,32)
self.notRewardTips=UIText.get(self,33)
self.autoImg2=UIObject.get(self,34)
self.skipNotSelectImg=UIObject.get(self,35)
self.dropPool=UIGameobjectClone.new(self,36)
self.dropRoot=UIObject.get(self,37)
self.dropTargetPos=UIObject.get(self,38)
self.dropEffectModel=UIObject.get(self,39)
self.wildDieNameText=UIText.get(self,40)
self.fastUseBtn=UIButton.get(self,41)
self.fastUseLockFlag=UIObject.get(self,42)
self.expArea=UIObject.get(self,43)
self.dropItemGroup=UIObject.get(self,44)
self.playerRoot=UIObject.get(self,45)
self.moneyRoot=UIObject.get(self,46)
self.moneyBtn=UIButton.get(self,47)
self.moneyIcon=UIImage.get(self,48)
self.money=UIText.get(self,49)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.rollBtn:setButtonClick(function()self:onRollBtn()end)

self.costBtn:setButtonClick(function()self:onCostBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.startAutoButton:setButtonClick(function()self:onStartAutoButton()end)

self.cancelAutoButton:setButtonClick(function()self:onCancelAutoButton()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)

self.progressBtn:setButtonClick(function()self:onProgressBtn()end)

self.wildDieBtn:setButtonClick(function()self:onWildDieBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.fastUseBtn:setButtonClick(function()self:onFastUseBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)



end


function UISubAct_shenhaixunbaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.rollBtnTxt);self.rollBtnTxt=nil;
_UIObject_release(self.rollBtn);self.rollBtn=nil;
_UIObject_release(self.freeCountText);self.freeCountText=nil;
_UIObject_release(self.costBtn);self.costBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.rollBtnEffect);self.rollBtnEffect=nil;
_UIObject_release(self.dicepanel);self.dicepanel=nil;
_UIObject_release(self.dicePerfab);self.dicePerfab=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costCountText);self.costCountText=nil;
_UIObject_release(self.diceEffect);self.diceEffect=nil;
_UIObject_release(self.diceEffect2);self.diceEffect2=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.autoPanel);self.autoPanel=nil;
_UIObject_release(self.startAutoButton);self.startAutoButton=nil;
_UIObject_release(self.cancelAutoButton);self.cancelAutoButton=nil;
_UIObject_release(self.autoImg);self.autoImg=nil;
_UIObject_release(self.preffect);self.preffect=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
_UIObject_release(self.mapGridsGroup);self.mapGridsGroup=nil;
_UIObject_release(self.progressBtn);self.progressBtn=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.progressReddot);self.progressReddot=nil;
_UIObject_release(self.wildDieBtn);self.wildDieBtn=nil;
_UIObject_release(self.wildDieCountText);self.wildDieCountText=nil;
_UIObject_release(self.rewardGroup);self.rewardGroup=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.notRewardTips);self.notRewardTips=nil;
_UIObject_release(self.autoImg2);self.autoImg2=nil;
_UIObject_release(self.skipNotSelectImg);self.skipNotSelectImg=nil;
self.dropPool:deleteSelf();self.dropPool=nil;
_UIObject_release(self.dropRoot);self.dropRoot=nil;
_UIObject_release(self.dropTargetPos);self.dropTargetPos=nil;
_UIObject_release(self.dropEffectModel);self.dropEffectModel=nil;
_UIObject_release(self.wildDieNameText);self.wildDieNameText=nil;
_UIObject_release(self.fastUseBtn);self.fastUseBtn=nil;
_UIObject_release(self.fastUseLockFlag);self.fastUseLockFlag=nil;
_UIObject_release(self.expArea);self.expArea=nil;
_UIObject_release(self.dropItemGroup);self.dropItemGroup=nil;
_UIObject_release(self.playerRoot);self.playerRoot=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.money);self.money=nil;
end
















local _this
local jump_speed=0.5

local _mapItemCmpIndex={
hasDataRoot=0,
color=1,
itemRoot=2,
itemIcon=3,
expText=4,
eventIcon=5,
boxIcon=6,
rareIcon=7,
startPoint=8,
centerPos=9,
effect=10,
selectEffect=11,
otherIcon=12,
eventModel=13,
startPointModel=14,
rareIconImage=15,
}

local _mapGridColorIconName={
[1]={
[1]="image_shxb_gezi_1",
[2]="image_shxb_gezi_2",
[3]="image_shxb_gezi_3",
[4]="image_shxb_gezi_4",
[5]="image_shxb_gezi_5",
},
[2]={
[1]="image_shxb_youhua_11",
[2]="image_shxb_youhua_12",
[3]="image_shxb_youhua_13",
[4]="image_shxb_youhua_14",
[5]="image_shxb_youhua_15",
}
}

local _mapGridColorItemIconName={
[1]={
[1]="image_shxb_youhua_1",
[2]="image_shxb_youhua_2",
[3]="image_shxb_youhua_3",
[4]="image_shxb_youhua_4",
[5]="image_shxb_youhua_5",
},
[2]={
[1]="image_shxb_youhua_6",
[2]="image_shxb_youhua_7",
[3]="image_shxb_youhua_8",
[4]="image_shxb_youhua_9",
[5]="image_shxb_youhua_10",
}
}

local _diceEffectIdList_notSkip={
[1]=10810,
[2]=10811,
[3]=10812,
[4]=10813,
[5]=10814,
[6]=10815,
}

local _diceEffectIdList_skip={
[1]=10816,
[2]=10817,
[3]=10818,
[4]=10819,
[5]=10820,
[6]=10821,
}

local _gridEffectFuncList={
[1]=function(effectType,params,posIdx,isNeedCheckNext)
local triggerGridGuid=params[1]
local targetGridGuid=params[2]
local gridTypeDataLookup=_this.myData.gridGuidDataLookup
local gridTypeData=gridTypeDataLookup[triggerGridGuid]
local gridType=gridTypeData.gridType
local targetGridIdx
if targetGridGuid then
local targetGridTypeData=gridTypeDataLookup[targetGridGuid]
targetGridIdx=targetGridTypeData and targetGridTypeData.gridIdx
end
local isShowSelectEffect=gridType==1
if isShowSelectEffect then

_this:showItemGridSelectEffectByAddReward(posIdx)
end

local itemList=params[3]
local isCanCheckNext=false
local delayTime
if not isNeedCheckNext then

isCanCheckNext=true
delayTime=2
end
local hasLevelUp=_this.hasLevelUpLookup[posIdx]
local isIgnoreTryCheckNext=false

local isShowDropAnim=gridType~=3
local showType=0
if gridType==3 then

showType=2
elseif not isNeedCheckNext or hasLevelUp then
showType=1
isShowDropAnim=false

if isNeedCheckNext and hasLevelUp then

isCanCheckNext=true
_this.needWaitLevelUpAnimPosLookup[posIdx]=true
isIgnoreTryCheckNext=true
end
end
_this:showAddRewardItem(targetGridIdx,itemList,posIdx,showType,isShowDropAnim,isNeedCheckNext,isIgnoreTryCheckNext)

return isCanCheckNext,delayTime
end,
[2]=function(effectType,params,posIdx,isNeedCheckNext)
local addExp=params[3]

local isCanCheckNext=true
local delayTime=0.5
local tryCheckNext=false
if isNeedCheckNext and _this.needWaitLevelUpAnimPosLookup[posIdx]then
isCanCheckNext=false
delayTime=2
tryCheckNext=true
end

_this:refreshGridAddExp(posIdx,addExp,tryCheckNext)
return isCanCheckNext,delayTime
end,
[3]=function(effectType,params,posIdx,isNeedCheckNext)
local triggerGridGuid=params[1]
local targetGridGuid=params[2]
local gridTypeDataLookup=_this.myData.gridGuidDataLookup
local gridTypeData=gridTypeDataLookup[triggerGridGuid]
local gridCfgId=gridTypeData and gridTypeData.data.confId
local targetGridIdx
if targetGridGuid then
local targetGridTypeData=gridTypeDataLookup[targetGridGuid]
targetGridIdx=targetGridTypeData and targetGridTypeData.gridIdx
end
local itemList=params[3]
local showType=0
_this:showAddRewardItem(targetGridIdx,itemList,posIdx,showType)

_this:showWindow("UISubAct_SHXB_eventTipsWin",{
parentWin=_this,
effectType=effectType,
params=params,
isAutoClose=_this.isAuto,
isSkipAnim=_this.isSkipAnim,
gridCfgId=gridCfgId,
})
local isCanCheckNext=false
return isCanCheckNext
end,
[4]=function(effectType,params,posIdx,isNeedCheckNext)
local triggerGridGuid=params[1]
local gridTypeDataLookup=_this.myData.gridGuidDataLookup
local gridTypeData=gridTypeDataLookup[triggerGridGuid]
local gridCfgId=gridTypeData and gridTypeData.data.confId
local moveCount=params[3]

_this:showWindow("UISubAct_SHXB_eventTipsWin",{
parentWin=_this,
effectType=effectType,
params=params,
isAutoClose=_this.isAuto,
isSkipAnim=_this.isSkipAnim,
gridCfgId=gridCfgId,
})
local isCanCheckNext=false
return isCanCheckNext
end,
[5]=function(effectType,params,posIdx,isNeedCheckNext)
local triggerGridGuid=params[1]
local gridTypeDataLookup=_this.myData.gridGuidDataLookup
local gridTypeData=gridTypeDataLookup[triggerGridGuid]
local gridCfgId=gridTypeData and gridTypeData.data.confId
local moveCount=params[3]

_this:showWindow("UISubAct_SHXB_eventTipsWin",{
parentWin=_this,
effectType=effectType,
params=params,
isAutoClose=_this.isAuto,
isSkipAnim=_this.isSkipAnim,
gridCfgId=gridCfgId,
})
local isCanCheckNext=false
return isCanCheckNext
end,
[6]=function(effectType,params,posIdx,isNeedCheckNext)
local triggerGridGuid=params[1]
local gridTypeDataLookup=_this.myData.gridGuidDataLookup
local gridTypeData=gridTypeDataLookup[triggerGridGuid]
local gridCfgId=gridTypeData and gridTypeData.data.confId
local addExp=params[3]

_this:showWindow("UISubAct_SHXB_eventTipsWin",{
parentWin=_this,
effectType=effectType,
params=params,
isAutoClose=_this.isAuto,
isSkipAnim=_this.isSkipAnim,
gridCfgId=gridCfgId,
})

local isCanCheckNext=false
return isCanCheckNext
end,
[7]=function(effectType,params,posIdx,isNeedCheckNext)
local gzGuid=params[2]
local posOld=params[3]
local posNew=params[4]
_this:showGridChangeEffect(posOld,posNew,gzGuid)

local isCanCheckNext=true
local delayTime=0.5
return isCanCheckNext,delayTime
end,
}



function UISubAct_shenhaixunbaoWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UISubAct_shenhaixunbaoWin:__delete()
self:setAutoMode(false)
self:clearDropObj()
self:clearAllTimer()
self:clearEffect()
_this=nil
self:unbindComponents()
end




function UISubAct_shenhaixunbaoWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end


self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self.beginTime=self.sub_actInfo.start_time
self.endTime=self.sub_actInfo.end_time

self.tempMapData={}
self.tempRewardData={}
self.tempGridGuid2GridIdxLookup={}
self.tempItemList={}
self.tempItemIdxLookup={}
self.isSkipAnim=userActorSetting.get('skipSHXBAnim',false)
self.dropObjList={}
self.dropObjTimer={}
self.dropObjListIdx=0
self.delayTimerList={}
self.isMoving=nil
self.isShowEffectNow=nil
self.moveQueue=nil
self.costLookup={}
self.cannotCheckNextCount=0

local recordItemLookup=self.config.recordItem
if recordItemLookup then
local k,v=next(recordItemLookup)
if k then
self.showMoneyType=k
end
end

local bgModelId=self.config.bgSpineId
if afterOnloaded then
if bgModelId then
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},eAnimationID.stand)
end


self.dropEffectModel:setChildUIModelShowTarget(6383,1,{},eAnimationID.stand,nil,nil,0)
end

local costItem=self.config.ptTouZi
local costItemId=costItem[1]
self.costLookup[costItemId]=true

local wildDieItem=self.config.wxTouZi
local wildDieItemId=wildDieItem[1]
self.costLookup[wildDieItemId]=true

self:initMap()
self:initDzModel()
self:initAddExpShow()
self:refresh(true)


self:setRemainingTimeTimer()
end


function UISubAct_shenhaixunbaoWin:onHide()
self:setAutoMode(false)
self:clearDropObj()
self:clearAllTimer()
self:clearEffect()
self.isShowEffectNow=nil
end

function UISubAct_shenhaixunbaoWin:refresh(isInit)

self:refreshCostPanel()


self:refreshMoneyPanel()


self:refreshProgressRewardPanel()


self:refreshRewardPanel(isInit)


self:refreshSkipAnimState()
end

function UISubAct_shenhaixunbaoWin:refreshCostPanel()

local freeNum=self.myData.freeNum
local maxFreeNum=self.config.freeNum
local remainingFreeCount=maxFreeNum-freeNum
local hasFree=remainingFreeCount>0
local hasDice=false
self.freeCountText:setActive(hasFree)
self.costPanel:setActive(not hasFree)
if hasFree then
hasDice=true
self.freeCountText:setText(FMT.fmt("免费次数:{0}",remainingFreeCount))
else
local costItem=self.config.ptTouZi
local costItemId=costItem[1]
local costCount=costItem[2]

local hasCount=itemsModel.getCount(costItemId)
local countStr=mathHelper.formatNumber(hasCount)
if hasCount<costCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
else
hasDice=true
end
self.costCountText:setText(countStr)
self.costIcon:setImageIcon(iconHelper.getIconName(costItemId),false)
end


local wildDieItem=self.config.wxTouZi
local wildDieItemId=wildDieItem[1]
local wildDieCount=wildDieItem[2]
local hasWildDieCount=itemsModel.getCount(wildDieItemId)
local countStr=mathHelper.formatNumber(hasWildDieCount)
self.wildDieCountText:setText(countStr)
local itemName=itemsModel.getName(wildDieItemId)
self.wildDieNameText:setText(itemName)

if hasDice then
self.rollBtnEffect:setChildShowEffect(10348,true)
else
self.rollBtnEffect:setChildShowEffect(0,false)
end


local isUnlock,needNum=self.sub_actInfo:checkIsUnlockFastUse()
self.fastUseLockFlag:setActive(not isUnlock)
self.fastUseBtn:setImageExGray(not isUnlock)
end

function UISubAct_shenhaixunbaoWin:refreshMoneyPanel()
local moneyType=self.showMoneyType
self.money:setText(moneyModel.getMoney(moneyType))
local moneyIconName=iconHelper.getIconName(moneyType)
self.moneyIcon:setChildIcon(moneyIconName,false)
end

function UISubAct_shenhaixunbaoWin:refreshProgressRewardPanel()
local nowScore=self.myData.jdrwScore or 0
local gotRewardVal=self.myData.jdrwMaxVal or 0

local targetCfgList=self.sub_actInfo:getProgressTargetCfgList()
local nextScore
for i,cfg in ipairs(targetCfgList)do
local score=cfg.score
local isGot=gotRewardVal>=score
local isFinish=nowScore>=score
if not isFinish or not isGot then
nextScore=score
break
end
end

if not nextScore then

nextScore=targetCfgList[#targetCfgList].score
end

local showScore=nowScore
if showScore>nextScore then
showScore=nextScore
end

self.progressText:setText(FMT.fmt("{0}/{1}",showScore,nextScore))
local reddot=showScore>=nextScore and gotRewardVal<nextScore
self.progressReddot:setActive(reddot)
end

function UISubAct_shenhaixunbaoWin:refreshRewardPanel(isNeedReqNewData,isRefreshByTempData)
local recordRewardList
if isRefreshByTempData then
recordRewardList=self.tempRewardData
else
recordRewardList=self.myData.recordRewardList
self.tempRewardData={}
end

if not recordRewardList or isNeedReqNewData then

self:reqRecordNewData()
else
local showItemCount=#recordRewardList
local maxShowItemCount=20
if showItemCount>maxShowItemCount then
showItemCount=maxShowItemCount
end
self.rewardGroup:setChildLayoutGroupCreateItems(showItemCount,function(index)
local widget=self.rewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=recordRewardList[index]
if reward then
if not isRefreshByTempData then
self.tempRewardData[index]=reward
end

widget:SetChildActive(-1,true)
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end)
end

local hasReward=recordRewardList and#recordRewardList>0 or false
local recordList=self.myData.recordList
local hasRecord=recordList and#recordList>0 or false
self.recordBtn:setActive(hasRecord)
self.notRewardTips:setActive(not hasReward)
end

function UISubAct_shenhaixunbaoWin:reqRecordNewData()
self.sub_actInfo:reqGetRecordData()
end

function UISubAct_shenhaixunbaoWin:showAddRewardItem(targetGridIdx,itemList,posIdx,showType,isShowDropAnim,isNeedCheckNext,isIgnoreTryCheckNext)
showType=showType or 0


if not self.tempItemIdxLookup[targetGridIdx]then
self.tempItemIdxLookup[targetGridIdx]={}
end
if not self.tempItemList[targetGridIdx]then
self.tempItemList[targetGridIdx]={}
end
local tempItemIdxLookup=self.tempItemIdxLookup[targetGridIdx]
local tempItemList=self.tempItemList[targetGridIdx]
for i,v in ipairs(itemList)do
local itemId=v[1]
local itemCount=v[2]

local index=tempItemIdxLookup and tempItemIdxLookup[itemId]
if not index then
index=#tempItemList+1
tempItemList[index]={itemId,itemCount}
tempItemIdxLookup[itemId]=index
else
local count=tempItemList[index][2]+itemCount
tempItemList[index][2]=count
end
end

local callback=function()
for i,v in ipairs(tempItemList)do
local itemId=v[1]
local itemCount=v[2]
if showType==1 then
UIManager.rewardInfo(iconHelper.getIconName(itemId),FMT.fmt('X{0}',itemCount))
end
table.insert(self.tempRewardData,i,v)
end

if showType==2 then
self:showPrizeWin(tempItemList)
end

self:refreshRewardPanel(true,true)
self:refreshMoneyPanel()
if isNeedCheckNext and showType~=2 and not isIgnoreTryCheckNext then
return self:try_playerMoveCheckNext()
end
end

if isShowDropAnim then

self:animationDropItem(posIdx,tempItemList,callback)
else
callback()
end
end

function UISubAct_shenhaixunbaoWin:showDropFinishAnim()


self.dropEffectModel:setChildModelAnimationState(eAnimationID.enter)


self.bgModel:setChildModelAnimationState(eAnimationID.stand2)
self.delayTimerList[3]=self:delayDo(1,function()
if not _this or not _this.isVisible then return end
_this.bgModel:setChildModelAnimationState(eAnimationID.stand)
end)
end

function UISubAct_shenhaixunbaoWin:showPrizeWin(itemList)
local conf={}
for i,v in ipairs(itemList)do
local itemId=v[1]
local itemCount=v[2]
table.insert(conf,{itemid=itemId,num=itemCount})
end
local autoCloseDelayTime
if self.isAuto then
autoCloseDelayTime=2
end

local isSkipAnim=self.isSkipAnim
local callback=function()
if not _this or not _this.isVisible then
return
end
if not isSkipAnim then
_this:try_playerMoveCheckNext()
else
_this:playerMoveCheckRestart()
end
end
showPrizeControl.showWindow(conf,callback,{autoCloseDelayTime=autoCloseDelayTime})
end

function UISubAct_shenhaixunbaoWin:refreshSkipAnimState()
self.skipSelectImg:setActive(self.isSkipAnim)
end

function UISubAct_shenhaixunbaoWin:setAutoMode(isAuto)
if isAuto==self.isAuto then
return
end

if isAuto then


local isCanRoll=self:checkCanRoll()
if not isCanRoll then
return false
end
self.autoImg:setChildCanvasGroupAlpha(1)
self.isAuto=true
else

self.autoImg:setChildCanvasGroupAlpha(0)
self.isAuto=false
end
self.autoImg:setActive(self.isAuto or false)
self.startAutoButton:setActive(not self.isAuto)
self.cancelAutoButton:setActive(self.isAuto or false)

return true
end

function UISubAct_shenhaixunbaoWin:checkCanRoll()

local freeNum=self.myData.freeNum
local maxFreeNum=self.config.freeNum
local remainingFreeCount=maxFreeNum-freeNum
local hasFree=remainingFreeCount>0
if not hasFree then

local costItem=self.config.ptTouZi
local costItemId=costItem[1]
local costCount=costItem[2]

local ret=itemsModel:useItem(costItemId,costCount,function()end,WARNING_TYPE.eWarning)
if not ret then
return false
end
end

return true
end


function UISubAct_shenhaixunbaoWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_shenhaixunbaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_shenhaixunbaoWin:clearDiceTimer()
if self.diceTimer then
self:stopTimerByID(self.diceTimer)
self.diceTimer=nil
end
if self.diceTimer2 then
self:stopTimerByID(self.diceTimer2)
self.diceTimer2=nil
end
end


function UISubAct_shenhaixunbaoWin:clearAllTimer()
self:clearTimer()
self:clearDiceTimer()
self:clearDelayTimer()
self:clearDropTimer()
end


function UISubAct_shenhaixunbaoWin:clearDelayTimer()
if self.delayTimerList then
for i,delayTimer in pairs(self.delayTimerList)do
if delayTimer then
self:stopTimerByID(delayTimer)
self.delayTimerList[i]=nil
end
end
end
end
function UISubAct_shenhaixunbaoWin:clearEffect()
self.diceEffect:setChildShowEffect(0,false)
self.diceEffect2:setChildShowEffect(0,false)
end

function UISubAct_shenhaixunbaoWin:refreshByFastUse()
self:refresh(true)
self:refreshAllMapGrid()
end


function UISubAct_shenhaixunbaoWin:initMap(k1,k2)
self.mapCfg={
{2,4},{1,4},{1,3},{1,2},{2,2},{3,2},{4,2},{4,1},{5,1},{6,1},{7,1},{7,2},{8,2},{8,3},{8,4},
{7,4},{7,5},{7,6},{6,6},{6,7},{5,7},{4,7},{4,6},{3,6},{2,6},{2,5},
}

self.sortGridsList={}
self.gridIdx2MapIdxLookup={}

local rowMaxGridIdxList={}
for idx,v in ipairs(self.mapCfg)do
local pos=v
local col=v[1]
local row=v[2]
local sortWeight=col+100*row
self.sortGridsList[#self.sortGridsList+1]={
pos=pos,
idx=idx,
sortWeight=sortWeight,
}

local rowMaxCol=rowMaxGridIdxList[row]and rowMaxGridIdxList[row].col
if not rowMaxCol or col>rowMaxCol then
if not rowMaxGridIdxList[row]then
rowMaxGridIdxList[row]={}
end
rowMaxGridIdxList[row].col=col
rowMaxGridIdxList[row].idx=idx
end
end
self.rowMaxGridIdxList=rowMaxGridIdxList
table.sort(self.sortGridsList,function(a,b)
return a.sortWeight<b.sortWeight
end)


local gridWidth=105
local gridHeight=53
local offsetWidth=-206.5
local offsetHeight=17.5
local maxRow=8
local maxCol=9
k1=k1 or 78.5/104
k2=k2 or 33.5/52
local gridsCount=#self.sortGridsList

self.maxMapGridsCount=gridsCount
self.mapGridsGroup:setChildLayoutGroupCreateItems(gridsCount,function(index)
local widget=self.mapGridsGroup:getChildLayoutGroupGridItem(index-1)

local gridMapCfg=self.sortGridsList[index]
local posCfg=gridMapCfg.pos
local posNum_x=posCfg[1]
local posNum_y=posCfg[2]
local posX=(posNum_x-1)*gridWidth+(maxRow-posNum_y)*gridWidth*k1+offsetWidth
local posY=-(posNum_y-1)*gridHeight-(posNum_x-1)*gridHeight*k2+offsetHeight
widget:SetChildAnchoredPos(-1,posX,posY)


local gridIdx=gridMapCfg.idx
self.gridIdx2MapIdxLookup[gridIdx]=index

widget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,0,false)
self:refreshMapGrid(gridIdx,widget,nil,true)

widget:SetChildButtonClick(-1,function()
if _this==nil then return end
return _this:onClickMapGrid(gridIdx)
end,true)
end)
end

function UISubAct_shenhaixunbaoWin:refreshMapGrid(gridIdx,widget,isRefreshByTempMapData,isInit)
local mapData
if isRefreshByTempMapData then
mapData=self.tempMapData
else
mapData=self.myData.mapData
end
local gridData=mapData[gridIdx]
local maxColor
local gridBgType
local gridIconType
if gridData and next(gridData)~=nil then
widget:SetChildActive(_mapItemCmpIndex.hasDataRoot,true)
local itemGridData=gridData.itemGridData
local eventGridData=gridData.eventGridData
local boxGridData=gridData.boxGridData
local rareGridData=gridData.rareGridData
local spGridData=gridData.spGridData

if not isRefreshByTempMapData and not self.tempMapData[gridIdx]then
self.tempMapData[gridIdx]={}
self.tempMapData[gridIdx].itemGridData=itemGridData and table.weakCopy(itemGridData)or nil
self.tempMapData[gridIdx].eventGridData=eventGridData and table.weakCopy(eventGridData)or nil
self.tempMapData[gridIdx].boxGridData=boxGridData and table.weakCopy(boxGridData)or nil
self.tempMapData[gridIdx].rareGridData=rareGridData and table.weakCopy(rareGridData)or nil
self.tempMapData[gridIdx].spGridData=spGridData and table.weakCopy(spGridData)or nil
end

local setTempGuidLookupFunc=function(data)
local guid=data.gzGuid
self.tempGridGuid2GridIdxLookup[guid]=gridIdx
end

local isShowStartPoint=spGridData~=nil
widget:SetChildActive(_mapItemCmpIndex.startPoint,isShowStartPoint)
if isShowStartPoint then
setTempGuidLookupFunc(spGridData)
local gridCfgId=spGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
gridBgType=gridCfg.gridBgType or gridBgType
gridIconType=gridCfg.gridIconType or gridIconType
local gridColor=gridCfg.color or 1
if not maxColor or gridColor>maxColor then
maxColor=gridColor
end

if isInit then
widget:SetChildUIModelShowTarget(_mapItemCmpIndex.startPointModel,6374,1,{},eAnimationID.stand)
end
end

local isShowBox=boxGridData~=nil
if isShowBox then
setTempGuidLookupFunc(boxGridData)
local gridCfgId=boxGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
gridBgType=gridCfg.gridBgType or gridBgType
gridIconType=gridCfg.gridIconType or gridIconType
local gridColor=gridCfg.color or 1
if not maxColor or gridColor>maxColor then
maxColor=gridColor
end
end
widget:SetChildActive(_mapItemCmpIndex.boxIcon,isShowBox)

local isShowItem=itemGridData~=nil
widget:SetChildActive(_mapItemCmpIndex.itemRoot,isShowItem and not isShowBox)
if isShowItem then
setTempGuidLookupFunc(itemGridData)
local gridExp=itemGridData.exp or 0
local gridCfgId=itemGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
gridBgType=gridCfg.gridBgType or gridBgType
gridIconType=gridCfg.gridIconType or gridIconType
local expCfg=gridCfg.levelExp
local level=1
local showExp=0
local levelExp=0
local lastLevelExp=0
local maxLevel=#expCfg+1
for idx,lvExp in ipairs(expCfg)do
local lv=idx+1
showExp=gridExp-lastLevelExp
levelExp=lvExp-lastLevelExp
if gridExp>=lvExp then
level=lv
else
break
end
lastLevelExp=lvExp
end
local levelStr=""
if level>=maxLevel then
levelStr="满级"
else

levelStr=FMT.fmt("{0}级",level)
end
local gridColor=gridCfg.color or 1
local showColor=(gridColor-1)+level
if showColor>5 then

showColor=5
end

if not maxColor or showColor>maxColor then
maxColor=showColor
end

end

local isShowRare=rareGridData~=nil
if isShowRare then
setTempGuidLookupFunc(rareGridData)
local gridCfgId=rareGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
gridBgType=gridCfg.gridBgType or gridBgType
gridIconType=gridCfg.gridIconType or gridIconType
local gridColor=gridCfg.color or 1
if not maxColor or gridColor>maxColor then
maxColor=gridColor
end

local itemicon=iconHelper.getIconName(self.showMoneyType)
widget:SetChildIcon(_mapItemCmpIndex.rareIconImage,itemicon,true)
end
widget:SetChildActive(_mapItemCmpIndex.rareIcon,isShowRare and not isShowBox)

local isShowEvent=eventGridData~=nil
if isShowEvent then
setTempGuidLookupFunc(eventGridData)
local gridCfgId=eventGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
gridBgType=gridCfg.gridBgType or gridBgType
gridIconType=gridCfg.gridIconType or gridIconType
local gridColor=gridCfg.color or 1
if not maxColor or gridColor>maxColor then
maxColor=gridColor
end

if isInit then
widget:SetChildUIModelShowTarget(_mapItemCmpIndex.eventModel,6375,1,{},eAnimationID.stand)
end
end
widget:SetChildActive(_mapItemCmpIndex.eventIcon,isShowEvent and not isShowBox)
else
widget:SetChildActive(_mapItemCmpIndex.hasDataRoot,false)
end

local abName="ui/windows/activities/sub_shenhaixunbao/shenhaixunbao_grids_atlas_pak.ab"
gridBgType=gridBgType or 1
local colorIconName=_mapGridColorIconName[gridBgType]and _mapGridColorIconName[gridBgType][maxColor]or nil
if colorIconName then
widget:SetChildCSImageSprite(_mapItemCmpIndex.color,abName,colorIconName)
end

if gridIconType then
local colorItemIconName=_mapGridColorItemIconName[gridIconType][maxColor]and _mapGridColorItemIconName[gridIconType][maxColor]or nil
if colorItemIconName then
widget:SetChildCSImageSprite(_mapItemCmpIndex.itemIcon,abName,colorItemIconName)
end
end
end

function UISubAct_shenhaixunbaoWin:refreshAllMapGrid()
local grids=self.mapGridsGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local widget=grids[index-1]
local gridMapCfg=self.sortGridsList[index]

local gridIdx=gridMapCfg.idx
self:refreshMapGrid(gridIdx,widget)
end
self:initDzModel()
end

function UISubAct_shenhaixunbaoWin:initDzModel()

local isFlip=false
local playerPosIdx=self.myData.pos
local nextPosIdx=playerPosIdx>=self.maxMapGridsCount and 1 or playerPosIdx+1
local mapIdx=playerPosIdx and self.gridIdx2MapIdxLookup[playerPosIdx]
local nextPosMapIdx=nextPosIdx and self.gridIdx2MapIdxLookup[nextPosIdx]
local playerTran=self.playerRoot:getTransform()
if mapIdx then
local widget=self.mapGridsGroup:getChildLayoutGroupGridItem(mapIdx-1)

local gridAnchored_originalPos=widget:GetChildAnchoredPosition(-1)
local gridAnchored_centerPos=widget:GetChildAnchoredPosition(_mapItemCmpIndex.centerPos)
local gridPos=gridAnchored_originalPos+gridAnchored_centerPos

local gridMapCfg=self.sortGridsList[mapIdx]
local posCfg=gridMapCfg.pos
local row=posCfg[2]
local rowMaxGridIdx=self.rowMaxGridIdxList[row]and self.rowMaxGridIdxList[row].idx
local rowMaxMapIdx=self.gridIdx2MapIdxLookup[rowMaxGridIdx]
playerTran:SetSiblingIndex(rowMaxMapIdx)


self.playerRoot:setChildAnchoredPosition(gridPos)

local nextWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(nextPosMapIdx-1)

local nextAnchored_originalPos=nextWidget:GetChildAnchoredPosition(-1)
local nextAnchored_centerPos=nextWidget:GetChildAnchoredPosition(_mapItemCmpIndex.centerPos)
local nextGridPos=nextAnchored_originalPos+nextAnchored_centerPos
isFlip=nextGridPos.x>gridPos.x
end
self.nowPosIdx=playerPosIdx
self.nowShowPosIdx=playerPosIdx

local dzGuid
if UIDiscipleModel:hasZongMenPost(eZongMenPostType.eZhangMen)then
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)
local netData=dis_list[1]
dzGuid=netData.discipleguid
else
local list=UIDiscipleModel:getFightTop5DiscipleGuidList()
dzGuid=list[1]and list[1].discipleguid
end

if not dzGuid then
local netData=UIDiscipleModel:getPlotDiscipleByIndex(1)
dzGuid=netData.discipleguid
end

local dzModelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzGuid,false,nil,{clothingStar=1})
self.playerModel:setChildUIModelShowTarget(dzModelParams.body,0.8,dzModelParams.componets,eAnimationID.stand,false,false,0)
self.playerModel:setChildUIModelShowFlipX(isFlip)

self:refreshSelectEffect()
self:refreshOtherIconShow(true)
end


function UISubAct_shenhaixunbaoWin:saveMapGridChangeData(posOld,posNew,gzGuid,gridDataName,gridType)













end

function UISubAct_shenhaixunbaoWin:startRoll(diceType,rollNum,startPos,targetPos,gridEffectList,hasLevelUpLookup)
self.hasLevelUpLookup=hasLevelUpLookup
self.needWaitLevelUpAnimPosLookup={}
local callback=function()
if not _this or not _this.isVisible then return end
_this:refreshProgressRewardPanel()
if _this.isSkipAnim then
_this:playerSkipByPath(gridEffectList,targetPos)
else
_this:playerMoveByPath(gridEffectList)
end
end


self:showDiceEffect(diceType,rollNum,startPos,targetPos,callback)

self:refreshCostPanel()
end


function UISubAct_shenhaixunbaoWin:refreshGridAddExp(posIdx,addExp,tryCheckNext)
local mapIdx=self.gridIdx2MapIdxLookup[posIdx]
if mapIdx then
local widget=self.mapGridsGroup:getChildLayoutGroupGridItem(mapIdx-1)
if widget then
local delayTime=0.5
local gridData=self.tempMapData[posIdx]
if gridData and gridData.itemGridData then
local originalExp=gridData.itemGridData.exp or 0
local gridCfgId=gridData.itemGridData.confId
local originalLevel=self:getItemGridLevel(originalExp,gridCfgId)
gridData.itemGridData.exp=gridData.itemGridData.exp+addExp
self:refreshMapGrid(posIdx,widget,true)

local nowExp=gridData.itemGridData.exp
local nowLevel=self:getItemGridLevel(nowExp,gridCfgId)
local isLevelUp=nowLevel>originalLevel
if isLevelUp then

widget:SetChildShowEffect(_mapItemCmpIndex.effect,10808,true)
delayTime=2
end
end

local pos=widget:GetChildScreenPointToLocalPointRectangle(_mapItemCmpIndex.centerPos)
local posX=pos.x
if posIdx==self.nowPosIdx then
posX=posX+50
end
self:addExpShow(addExp,{posX,pos.y+30})

if tryCheckNext then
local key=string.format('addExpTimer_%d',posIdx)
self.delayTimerList[key]=self:delayDo(delayTime,function()
if not _this or not _this.isVisible then return end
return _this:try_playerMoveCheckNext()
end)
end
end
end
end

function UISubAct_shenhaixunbaoWin:showGridChangeEffect(posOld,posNew,gridGuid)
local gridTypeDataLookup=self.myData.gridGuidDataLookup
local gridTypeData_now=gridTypeDataLookup[gridGuid]
local gridType=gridTypeData_now.gridType
local gridDataNameList={
[1]="spGridData",
[2]="itemGridData",
[3]="boxGridData",
[4]="rareGridData",
[5]="eventGridData",
}
local gridDataName=gridDataNameList[gridType]
local mapData=self.tempMapData
local gridData_old=mapData[posOld]
local gridTypeData=gridData_old[gridDataName]

if gridTypeData then
gridData_old[gridDataName]=nil
gridTypeData.pos=posNew
local gridData_new=mapData[posNew]
if gridData_new then
gridData_new[gridDataName]=gridTypeData
end
end


local refreshFunc=function(posIdx)
local mapIdx=self.gridIdx2MapIdxLookup[posIdx]
if mapIdx then
local widget=self.mapGridsGroup:getChildLayoutGroupGridItem(mapIdx-1)
if widget then
self:refreshMapGrid(posIdx,widget,true)
end
end
end
refreshFunc(posOld)
refreshFunc(posNew)
end

function UISubAct_shenhaixunbaoWin:getItemGridLevel(gridExp,gridCfgId)
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local expCfg=gridCfg.levelExp
local level=1
local lastLevelExp=0
local maxLevel=#expCfg+1
for idx,lvExp in ipairs(expCfg)do
local lv=idx+1
if gridExp>=lvExp then
level=lv
else
break
end
lastLevelExp=lvExp
end
local isMaxLv=level>=maxLevel
return level,isMaxLv
end

function UISubAct_shenhaixunbaoWin:playerMoveTo(targetPosIdx,callback)
local playerPosIdx=self.nowPosIdx or self.myData.pos
if playerPosIdx==targetPosIdx then
return false
end

local targetPosMapIdx=targetPosIdx and self.gridIdx2MapIdxLookup[targetPosIdx]
local playerTran=self.playerRoot:getTransform()
local targetPos
local rowMaxMapIdx
if targetPosMapIdx then
local nowAnchoredPos=self.playerRoot:getChildAnchoredPosition()
local gridMapCfg=self.sortGridsList[targetPosMapIdx]
local posCfg=gridMapCfg.pos
local row=posCfg[2]
local rowMaxGridIdx=self.rowMaxGridIdxList[row]and self.rowMaxGridIdxList[row].idx
rowMaxMapIdx=self.gridIdx2MapIdxLookup[rowMaxGridIdx]



local targetWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(targetPosMapIdx-1)
local targetAnchored_originalPos=targetWidget:GetChildAnchoredPosition(-1)
local targetAnchored_centerPos=targetWidget:GetChildAnchoredPosition(_mapItemCmpIndex.centerPos)
local targetAnchoredPos=targetAnchored_originalPos+targetAnchored_centerPos

targetPos=targetWidget:GetChildPosition(_mapItemCmpIndex.centerPos)
local isFlip=targetAnchoredPos.x>nowAnchoredPos.x
self.playerModel:setChildUIModelShowFlipX(isFlip)
end

self:hideSelectEffect()
self.playerModel:setChildModelAnimationState(2119,nil,function()
playerTran:SetSiblingIndex(rowMaxMapIdx)
_this.nowShowPosIdx=targetPosIdx
_this:refreshOtherIconShow(nil,1)
end)

self.moveTweener=self.playerRoot:setChildDOMove(targetPos,jump_speed,function()
if not _this or not _this.isVisible then return end
_this.playerModel:setChildModelAnimationState(eAnimationID.jump3)
_this.nowPosIdx=targetPosIdx


local nextPosIdx=targetPosIdx>=_this.maxMapGridsCount and 1 or targetPosIdx+1
local nextPosMapIdx=nextPosIdx and _this.gridIdx2MapIdxLookup[nextPosIdx]
if nextPosMapIdx then
local nowAnchoredPos=_this.playerRoot:getChildAnchoredPosition()
local nextWidget=_this.mapGridsGroup:getChildLayoutGroupGridItem(nextPosMapIdx-1)
local nextAnchored_originalPos=nextWidget:GetChildAnchoredPosition(-1)
local nextAnchored_centerPos=nextWidget:GetChildAnchoredPosition(_mapItemCmpIndex.centerPos)
local nextAnchoredPos=nextAnchored_originalPos+nextAnchored_centerPos
local isFlip=nextAnchoredPos.x>nowAnchoredPos.x
_this.playerModel:setChildUIModelShowFlipX(isFlip)
end

if callback then
return callback()
end
end)

return true
end

function UISubAct_shenhaixunbaoWin:playerMoveByPath(pathDataList)
if self.moveQueue and not self.moveQueue:isEmpty()then

return
end

if not self.moveQueue then
self.moveQueue=queue.New()
else
self.moveQueue:clear()
end

for i,pathData in ipairs(pathDataList)do
self.moveQueue:enqueue(pathData)
end
self:playerMoveCheckNext()
end

function UISubAct_shenhaixunbaoWin:playerSkipByPath(pathDataList,targetPosIdx,ignoreCheckStop,startEffectIdx)
self.isMoving=true
if not ignoreCheckStop then
self.stopStartPosIdx=nil
self.stopTargetPosIdx=nil
self.stopPathDataList=nil
self.stopEffectIdx=nil
local needStop=false
local pathDataList_before={}
local pathDataList_after={}
local maxPathIdx=#pathDataList
local effStartIdx=startEffectIdx
for pathIdx,pathData in ipairs(pathDataList)do
local gridData=pathData.grid
local posIdx=gridData.pos
local gridType=pathData.gridType
local effectList=pathData.effectList
if effectList then
if not needStop then
pathDataList_before[#pathDataList_before+1]=pathData
local maxEffectIdx=#effectList
effStartIdx=effStartIdx or 1

for effectIdx=effStartIdx,maxEffectIdx do

local jsonTable=effectList[effectIdx]
local effectType=jsonTable[1]
local params=jsonTable[2]
if pathIdx~=maxPathIdx or effectIdx~=maxEffectIdx then

if effectType==4 or effectType==5 or(effectType==1 and gridType==3)then

needStop=true
self.stopStartPosIdx=posIdx
if effectIdx~=maxEffectIdx then
self.stopEffectIdx=effectIdx
end
break
end
end
end
if needStop and self.stopEffectIdx then

pathDataList_after[#pathDataList_after+1]=pathData
end

effStartIdx=nil
else
pathDataList_after[#pathDataList_after+1]=pathData
end
end
end

if needStop then
self.stopPathDataList=pathDataList_after
self.stopTargetPosIdx=targetPosIdx
local tarPosIdx=self.stopStartPosIdx
return self:playerSkipByPath(pathDataList_before,tarPosIdx,true,startEffectIdx)
end
end

local finishFunc=function()
_this.isMoving=nil
local maxDelayTime
local effStartIdx=startEffectIdx
for i,pathData in ipairs(pathDataList)do
local gridData=pathData.grid
local posIdx=gridData.pos
local effectList=pathData.effectList
if effectList then
effStartIdx=effStartIdx or 1
local delayTime=_this:showGridMoveEffect(effectList,posIdx,false,nil,effStartIdx)
if delayTime and(not maxDelayTime or delayTime>maxDelayTime)then
maxDelayTime=delayTime
end
effStartIdx=nil
end
end

_this:refreshSelectEffect()
_this:refreshOtherIconShow(nil,2)

if _this.isAuto and not _this.stopStartPosIdx then

if not maxDelayTime then
return _this:onRollBtn(true)
else
_this.delayTimerList[1]=_this:delayDo(maxDelayTime,function()
return _this:onRollBtn(true)
end)
end
end
end

if targetPosIdx~=self.nowShowPosIdx then
local targetPosMapIdx=targetPosIdx and self.gridIdx2MapIdxLookup[targetPosIdx]
local playerTran=self.playerRoot:getTransform()
local targetPos
local rowMaxMapIdx
local targetAnchoredPos
local isFlip=false
if targetPosMapIdx then

local gridMapCfg=self.sortGridsList[targetPosMapIdx]
local posCfg=gridMapCfg.pos
local row=posCfg[2]
local rowMaxGridIdx=self.rowMaxGridIdxList[row]and self.rowMaxGridIdxList[row].idx
rowMaxMapIdx=self.gridIdx2MapIdxLookup[rowMaxGridIdx]


local targetWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(targetPosMapIdx-1)

local targetAnchored_originalPos=targetWidget:GetChildAnchoredPosition(-1)
local targetAnchored_centerPos=targetWidget:GetChildAnchoredPosition(_mapItemCmpIndex.centerPos)
targetAnchoredPos=targetAnchored_originalPos+targetAnchored_centerPos

local nextPosIdx=targetPosIdx>=_this.maxMapGridsCount and 1 or targetPosIdx+1
local nextPosMapIdx=nextPosIdx and _this.gridIdx2MapIdxLookup[nextPosIdx]
if nextPosMapIdx then
local nextWidget=_this.mapGridsGroup:getChildLayoutGroupGridItem(nextPosMapIdx-1)

local nextAnchored_originalPos=nextWidget:GetChildAnchoredPosition(-1)
local nextAnchored_centerPos=nextWidget:GetChildAnchoredPosition(_mapItemCmpIndex.centerPos)
local nextAnchoredPos=nextAnchored_originalPos+nextAnchored_centerPos
isFlip=nextAnchoredPos.x>targetAnchoredPos.x
end
end
self.nowShowPosIdx=targetPosIdx
self:refreshOtherIconShow(nil,1)
self:hideSelectEffect()


self.moveTweener=self.playerRoot:setChildCanvasGroupDOFade(0,0.5,function()
playerTran:SetSiblingIndex(rowMaxMapIdx)
_this.nowPosIdx=targetPosIdx
_this.playerModel:setChildUIModelShowFlipX(isFlip)
_this.preffect:setChildShowEffect(3,true)
_this.playerRoot:setChildAnchoredPosition(targetAnchoredPos)
_this.moveTweener=_this.playerRoot:setChildCanvasGroupDOFade(1,0.5,finishFunc)
end)
else
return finishFunc()
end

end

function UISubAct_shenhaixunbaoWin:playerMoveCheckRestart()
if self.stopStartPosIdx and self.stopPathDataList then
local targetPosIdx=self.stopTargetPosIdx
local pathDataList=self.stopPathDataList
local startEffIdx=self.stopEffectIdx and self.stopEffectIdx+1 or nil
self.stopStartPosIdx=nil
self.stopTargetPosIdx=nil
self.stopPathDataList=nil
self.stopEffectIdx=nil

return self:playerSkipByPath(pathDataList,targetPosIdx,nil,startEffIdx)
end
end

function UISubAct_shenhaixunbaoWin:try_playerMoveCheckNext()
self.cannotCheckNextCount=self.cannotCheckNextCount-1
if self.cannotCheckNextCount<=0 then
return self:playerMoveCheckNext()
end
end

function UISubAct_shenhaixunbaoWin:playerMoveCheckNext()
self.cannotCheckNextCount=0
if not self.moveQueue or self.moveQueue:isEmpty()then

self.isMoving=nil


self:refreshSelectEffect()

if self.isAuto then

return self:onRollBtn(true)
end
return
end

self.isMoving=true
local pathData=self.moveQueue:dequeue()
local gridData=pathData.grid
local posIdx=gridData.pos
local effectList=pathData.effectList
local callback=function()
if not _this or not _this.isVisible then
return
end

local isFinal=_this.moveQueue:isEmpty()
if effectList then
return _this:showGridMoveEffect(effectList,posIdx,true,isFinal)
else
return _this:playerMoveCheckNext()
end
end

local ret=self:playerMoveTo(posIdx,callback)
if not ret then


return callback()
end
end

function UISubAct_shenhaixunbaoWin:showGridMoveEffect(effectList,posIdx,isNeedCheckNext,isFinal,startEffectIdx)
if isFinal then

self:refreshOtherIconShow(nil,2)
end

table.clear(self.tempItemList)
table.clear(self.tempItemIdxLookup)
local isCanCheckNext_all=true
local maxDelayTime
local maxEffectIdx=#effectList
startEffectIdx=startEffectIdx or 1

for effectIdx=startEffectIdx,maxEffectIdx do

local jsonTable=effectList[effectIdx]
local effectType=jsonTable[1]
local params=jsonTable[2]
local delayTime

local isCanCheckNext=true
local effectFunc=_gridEffectFuncList[effectType]
if effectFunc then
local targetGridGuid=params[2]
local targetGridIdx=self.tempGridGuid2GridIdxLookup[targetGridGuid]

isCanCheckNext,delayTime=effectFunc(effectType,params,targetGridIdx,isNeedCheckNext)
end

if not isCanCheckNext then
isCanCheckNext_all=false
self.cannotCheckNextCount=self.cannotCheckNextCount+1
end

if delayTime and(not maxDelayTime or delayTime>maxDelayTime)then
maxDelayTime=delayTime
end
end

if isNeedCheckNext and isCanCheckNext_all then
return self:playerMoveCheckNext()
elseif not isNeedCheckNext then
return maxDelayTime
end
end

function UISubAct_shenhaixunbaoWin:refreshSelectEffect()
local lastPosIdx=self.lastPosIdx
local playerPosIdx=self.nowPosIdx

local lastPosMapIdx=lastPosIdx and self.gridIdx2MapIdxLookup[lastPosIdx]
if lastPosMapIdx then
local lastWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(lastPosMapIdx-1)
if lastWidget then

lastWidget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,0,false)
end
end

local nowPosMapIdx=playerPosIdx and self.gridIdx2MapIdxLookup[playerPosIdx]
if nowPosMapIdx then
local nowWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(nowPosMapIdx-1)
if nowWidget then

nowWidget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,10807,true)
end
end
self.lastPosIdx=playerPosIdx
end

function UISubAct_shenhaixunbaoWin:hideSelectEffect()
local lastPosIdx=self.lastPosIdx
local playerPosIdx=self.nowPosIdx

local lastPosMapIdx=lastPosIdx and self.gridIdx2MapIdxLookup[lastPosIdx]
if lastPosMapIdx then
local lastWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(lastPosMapIdx-1)
if lastWidget then

lastWidget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,0,false)
end
end

local nowPosMapIdx=playerPosIdx and self.gridIdx2MapIdxLookup[playerPosIdx]
if nowPosMapIdx then
local nowWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(nowPosMapIdx-1)
if nowWidget then

nowWidget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,0,false)
end
end
end

function UISubAct_shenhaixunbaoWin:refreshOtherIconShow(isInit,checkType)
local lastPosIdx=self.lastShowPosIdx
local playerPosIdx=self.nowShowPosIdx
checkType=checkType or 0

if checkType==0 or checkType==1 then
local lastPosMapIdx=lastPosIdx and self.gridIdx2MapIdxLookup[lastPosIdx]
if lastPosMapIdx then
local lastWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(lastPosMapIdx-1)
if lastWidget then

if isInit then
lastWidget:SetChildCanvasGroupAlpha(_mapItemCmpIndex.otherIcon,1)
else
lastWidget:SetChildCanvasGroupDOFade(_mapItemCmpIndex.otherIcon,1,0.1)
end
end
end
self.lastShowPosIdx=nil
end


if checkType==0 or checkType==2 then
local nowPosMapIdx=playerPosIdx and self.gridIdx2MapIdxLookup[playerPosIdx]
if nowPosMapIdx then
local nowWidget=self.mapGridsGroup:getChildLayoutGroupGridItem(nowPosMapIdx-1)
if nowWidget then

if isInit then
nowWidget:SetChildCanvasGroupAlpha(_mapItemCmpIndex.otherIcon,0)
else
nowWidget:SetChildCanvasGroupDOFade(_mapItemCmpIndex.otherIcon,0,0.1)
end
end
end
self.lastShowPosIdx=playerPosIdx
end
end

function UISubAct_shenhaixunbaoWin:showItemGridSelectEffectByAddReward(posIdx)
if posIdx==self.nowPosIdx then
return
end

local posMapIdx=posIdx and self.gridIdx2MapIdxLookup[posIdx]
if posMapIdx then

local widget=self.mapGridsGroup:getChildLayoutGroupGridItem(posMapIdx-1)
if widget then
widget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,10807,true)

local delayTime=1
self.delayTimerList[2]=self:delayDo(delayTime,function()
if not _this or not _this.isVisible then return end
widget:SetChildShowEffect(_mapItemCmpIndex.selectEffect,0,false)
end)
end
end
end


function UISubAct_shenhaixunbaoWin:showDiceEffect(diceType,point,startPos,targetPos,callback)
if diceType==1 then

self.autoImg:setChildCanvasGroupAlpha(0)
self.autoImg:setActive(false)
self.isShowEffectNow=true
if not self.isSkipAnim then
self.diceEffect:setChildShowEffect(10809,true)
local effectId=_diceEffectIdList_notSkip[point]
self.diceTimer=self:delayDo(0.2,function()
if not _this or not _this.isVisible then return end
_this.diceEffect2:setChildShowEffect(effectId,true)
end)
self.diceTimer2=self:delayDo(4,function()
if _this.isAuto then
_this.autoImg:setChildCanvasGroupDOFade(1,0.5,nil)
else
_this.autoImg:setChildCanvasGroupAlpha(0)
end
_this.autoImg:setActive(_this.isAuto or false)
_this.isShowEffectNow=nil
if callback then
return callback()
end
end)
else
local effectId=_diceEffectIdList_skip[point]
self.diceEffect2:setChildShowEffect(effectId,true)
self.diceTimer=self:delayDo(0.6,function()
if not _this or not _this.isVisible then return end
if _this.isAuto then
_this.autoImg:setChildCanvasGroupDOFade(1,0.5,nil)
else
_this.autoImg:setChildCanvasGroupAlpha(0)
end
_this.autoImg:setActive(_this.isAuto or false)
_this.diceEffect2:setChildShowEffect(-1,false)

_this.isShowEffectNow=nil
if callback then
return callback()
end
end)
end
else

local movePos=point
local moveStr="前行{0}格"









UIManager.info(FMT.fmt(moveStr,movePos))
if callback then
return callback()
end
end
end

function UISubAct_shenhaixunbaoWin:animationDropItem(posIdx,itemList,callback)
local cmpId=self.dropRoot:getID()
local posMapIdx=posIdx and self.gridIdx2MapIdxLookup[posIdx]
if posMapIdx then

local widget=self.mapGridsGroup:getChildLayoutGroupGridItem(posMapIdx-1)
if widget then
local dropObjListIdx=self.dropObjListIdx
self.dropObjList[dropObjListIdx]={}
self.dropObjListIdx=self.dropObjListIdx+1


local formPos=widget:GetChildPosition(_mapItemCmpIndex.centerPos)


local targetPos=self.dropTargetPos:getChildPosition()
local order=0
local params={
itemList=itemList,
toPos=targetPos,
formPos=formPos,
}
local luaid=self.dropPool:createObject('UISubAct_SHXB_dropItem',cmpId,order,params)
table.insert(self.dropObjList[dropObjListIdx],luaid)
local itemCount=#itemList
local delayTime=2.5
if itemCount<=1 then
delayTime=2
end
local dropTimer=self:delayDo(delayTime,function()
self:showDropFinishAnim()

for i,v in ipairs(self.dropObjList[dropObjListIdx])do
self.dropPool:recycleItemById(v)
end
self.dropObjList[dropObjListIdx]=nil
if self.dropObjTimer[dropObjListIdx]then
self:stopTimerByID(self.dropObjTimer[dropObjListIdx])
self.dropObjTimer[dropObjListIdx]=nil
end

if callback then
return callback()
end
end)
self.dropObjTimer[dropObjListIdx]=dropTimer
end
end
end

function UISubAct_shenhaixunbaoWin:clearDropTimer()
if self.dropObjTimer then
for i,v in pairs(self.dropObjTimer)do
self:stopTimerByID(v)
self.dropObjTimer[i]=nil
end
end
end

function UISubAct_shenhaixunbaoWin:clearDropObj()
for dropObjListIdx,objList in pairs(self.dropObjList)do
for i,v in ipairs(objList)do
self.dropPool:recycleItemById(v)
end
self.dropObjList[dropObjListIdx]=nil
end
end



function UISubAct_shenhaixunbaoWin:initAddExpShow()
local maxExpItemCount=10
self.expArea:setChildLayoutGroupCreateItems(maxExpItemCount,function(index)
local widget=self.expArea:getChildLayoutGroupGridItem(index-1)
widget:SetChildActive(2,false)
end)
end


function UISubAct_shenhaixunbaoWin:addExpShow(exp,pos)
local expStr=string.format("经验 + %s",exp)

local expItemIndex=self:getExpItemIndex()
self.nowSelectExpItemIndex=expItemIndex
local item=self.expArea:getChildLayoutGroupGridItem(expItemIndex-1)
local delayTime=self.isSkipAnim and 0.1 or 1
if item then
item:SetChildAnchoredPos(-1,pos[1],pos[2])
item:SetChildText(1,expStr)
item:SetChildActive(2,false)
self:delayDo(delayTime,function()
if not _this then return end
item:SetChildActive(2,true)
end)
end
end

function UISubAct_shenhaixunbaoWin:getExpItemIndex()
local nextIndex=self.nowSelectExpItemIndex and self.nowSelectExpItemIndex+1 or 1
if nextIndex>10 then
nextIndex=1
end

return nextIndex
end




function UISubAct_shenhaixunbaoWin:test_playerMoveToNext()
local playerPosIdx=self.nowPosIdx or self.myData.pos
local nextPosIdx=playerPosIdx>=self.maxMapGridsCount and 1 or playerPosIdx+1
self:playerMoveTo(nextPosIdx)
end



function UISubAct_shenhaixunbaoWin:test_showDiceEffect(point,skipFlag)
self.isSkipAnim=skipFlag
self:showDiceEffect(point)
end


function UISubAct_shenhaixunbaoWin:test_initMap(k1,k2)
self:initMap(k1,k2)
end


function UISubAct_shenhaixunbaoWin:test_dropAnim(posIdx)
local itemList={{1,10},{2,100},{3,200},{11011,10}}
self:animationDropItem(posIdx,itemList)
end





function UISubAct_shenhaixunbaoWin:onRuleBtn()
local langId=self.config.ruleLangId
local d={}
d.title='规则'
d.mode=3
d.name=langId
d.showBlack=true
self:showWindow('UIRuleWin',d)
end



function UISubAct_shenhaixunbaoWin:onRollBtn(isInAutoCb)
if not isInAutoCb and self.isAuto then
UIManager.info("请先取消自动寻宝")
return
end

if self.isMoving or self.isShowEffectNow then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end


local isCanRoll=self:checkCanRoll()
if not isCanRoll then

self:setAutoMode(false)
return
end

self.sub_actInfo:reqRollDice()
end



function UISubAct_shenhaixunbaoWin:onCostBtn()
local costItem=self.config.ptTouZi
local costItemId=costItem[1]
local costCount=costItem[2]

gainControl:showGainWin(costItemId)
end



function UISubAct_shenhaixunbaoWin:onSkipBtn()
if self.isAuto then
UIManager.info("请先取消自动寻宝")
return
end

if self.isMoving or self.isShowEffectNow then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end

self.isSkipAnim=not self.isSkipAnim
userActorSetting.flushVal('skipSHXBAnim',self.isSkipAnim)


self:refreshSkipAnimState()
end



function UISubAct_shenhaixunbaoWin:onStartAutoButton()
if self.isMoving or self.isShowEffectNow then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end

local ret=self:setAutoMode(true)
if ret then
UIManager.info("开始自动寻宝")
self.sub_actInfo:reqRollDice()
end
end



function UISubAct_shenhaixunbaoWin:onCancelAutoButton()
self:setAutoMode(false)
UIManager.info("取消自动寻宝")
end



function UISubAct_shenhaixunbaoWin:onIsShowReddotBtn()
end



function UISubAct_shenhaixunbaoWin:onProgressBtn()







self:showWindow("UISubAct_shenhaixunbao_progressWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId})
end

function UISubAct_shenhaixunbaoWin:onWildDieBtn()
if self.isAuto then
UIManager.info("请先取消自动寻宝")
return
end

if self.isMoving or self.isShowEffectNow then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end

local wildDieItem=self.config.wxTouZi
local wildDieItemId=wildDieItem[1]
local wildDieCount=wildDieItem[2]

local sendFunc=function()
if not _this or not _this.isVisible then
return
end

local posVector2=_this.wildDieBtn:getChildScreenPointToLocalPointRectangle()
local pos={posVector2.x,posVector2.y+70}
local offset={0,0}
self:showWindow("UISubAct_SHXB_wildDieSelectWin",{act_id=_this.activityId,sub_act_type=_this.subType,sub_act_id=_this.subId,parentWin=_this,pos=pos,offset=offset})
end

itemsModel:useItem(wildDieItemId,wildDieCount,sendFunc,WARNING_TYPE.eWarning)
end

function UISubAct_shenhaixunbaoWin:onClickMapGrid(gridIdx)







self:showWindow("UISubAct_SHXB_gridInfoWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId,gridIdx=gridIdx})
end

function UISubAct_shenhaixunbaoWin:onRecordBtn()
local isIgnoreNewData
if self.isMoving or self.isShowEffectNow or self.isAuto then




isIgnoreNewData=true
end


self:showWindow("UISubAct_shenhaixunbao_recordWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId,isIgnoreNewData=isIgnoreNewData})
end


function UISubAct_shenhaixunbaoWin:onFastUseBtn()

local isUnlock,needNum=self.sub_actInfo:checkIsUnlockFastUse()
if not isUnlock then

UIManager.error(FMT.fmt("再寻宝{0}次可解锁快速寻宝",needNum))
return
end

if self.isAuto then
UIManager.info("请先取消自动寻宝")
return
end

if self.isMoving or self.isShowEffectNow then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end

local isCanRoll=self:checkCanRoll()
if not isCanRoll then

return
end

local costItem=self.config.ptTouZi
local costItemId=costItem[1]
local costCount=costItem[2]

local freeNum=self.myData.freeNum
local maxFreeNum=self.config.freeNum
local remainingFreeCount=maxFreeNum-freeNum
if remainingFreeCount<0 then
remainingFreeCount=0
end
local hasFree=remainingFreeCount>0

local hasCount=itemsModel.getCount(costItemId)
local canRollCount=hasCount+remainingFreeCount
local maxCount=self.config.ksxbMax
local lerpUseNum=canRollCount>maxCount and maxCount or canRollCount

local getTipsStrFunc=function(num)
if not hasFree or num<=remainingFreeCount then
return nil
end

local tipsStr=FMT.fmt("（含{0}次免费次数）",remainingFreeCount)
return tipsStr
end


local refreshFunc=function(num)
local have=itemsModel.getCount(costItemId)
local itemNum
local costStr
if hasFree then
itemNum=(num-remainingFreeCount)*costCount
else
itemNum=num*costCount
end

if itemNum>0 then
local colorStr=have>=itemNum and"ca631dFF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemId)
costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
if pfwindowslController:checkIsGameVersion_yuenan()then
costStr=FMT.fmt(" quad-icon={2}-quad <color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
end
else
costStr=FMT.fmt("<color=#ca631dFF>{0}次免费次数</color>",num)
end
local contentStr=FMT.fmt('将消耗{0}进行快速寻宝',costStr)

local tipsStr=getTipsStrFunc(num)

return contentStr,tipsStr
end

local tipsStr=getTipsStrFunc(1)
local selectNum=self.sub_actInfo:getFastUseLastSelectCount()
if selectNum and selectNum>lerpUseNum then
selectNum=lerpUseNum
end

local show_data={
type='UISubAct_SHXB_dialougeWin',
title='提示',
refreshcallback=refreshFunc,
max=lerpUseNum,
tips=tipsStr,
oktext='确定',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end
local useItemNum=0
local useFreeNum=0
if hasFree then
useItemNum=(num-remainingFreeCount)*costCount
useFreeNum=num>remainingFreeCount and remainingFreeCount or num
if useItemNum<0 then
useItemNum=0
end
else
useItemNum=num*costCount
end
_this.sub_actInfo:setFastUseLastSelectCount(num)
_this.sub_actInfo:reqGetFastUse(useFreeNum,useItemNum)
end,
moneytypes={{costItemId},},
defaultCnt=selectNum,
}
self:showWindow("UISubAct_SHXB_dialougeWin",show_data)
end

function UISubAct_shenhaixunbaoWin:onMoneyBtn()
local moneyType=self.showMoneyType
gainControl:showGainWin(moneyType)
end

function UISubAct_shenhaixunbaoWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UISubAct_shenhaixunbaoWin.on_item_list_changed(args)
if _this==nil then return end
for i,v in ipairs(args)do
local itemid=v[3]
if _this.costLookup[itemid]then
return _this:refreshCostPanel()
end
end
end

function UISubAct_shenhaixunbaoWin.on_money_changed(moneyType,oldVal,newVal)
if _this==nil then return end
if _this.costLookup[moneyType]then
_this:refreshCostPanel()
end

if moneyType==_this.showMoneyType and not _this.isMoving then
_this:refreshMoneyPanel()
end
end


function UISubAct_shenhaixunbaoWin:testFunc_createDropItem(animId,isClear)
if isClear then
self.dropItemGroup:setChildLayoutGroupCreateItems(0)
end
self.dropItemGroup:setChildLayoutGroupCreateItems(1,function(index)
local widget=self.dropItemGroup:getChildLayoutGroupGridItem(index-1)
widget:SetChildActive(-1,true)
widget:SetChildSpineAnimation(1,animId,1,nil)
end)
end