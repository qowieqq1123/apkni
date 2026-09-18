







def_class("UIYunJiaYingWin",UIWindowBase)









function UIYunJiaYingWin:bindComponents()

self.allXsinfobg=UIObject.get(self,0)
self.allXsNumText=UIText.get(self,1)
self.arrowLeftBtn=UIButton.get(self,2)
self.arrowRightBtn=UIButton.get(self,3)
self.attrGridGroup=UIObject.get(self,4)
self.batchBtn=UIButton.get(self,5)
self.bdLevel=UIText.get(self,6)
self.breakBtn=UIButton.get(self,7)
self.cannotTrainTipsRoot=UIObject.get(self,8)
self.confirmBtn=UIButton.get(self,9)
self.Content=UIObject.get(self,10)
self.costJobAdd=UIObject.get(self,11)
self.costJobAddIcon=UIImage.get(self,12)
self.costJobAddTx=UIText.get(self,13)
self.costTimeText=UIText.get(self,14)
self.finishBtn=UIButton.get(self,15)
self.finishCostIcon=UIImage.get(self,16)
self.finishCostText=UIText.get(self,17)
self.hasXsNumText=UIText.get(self,18)
self.helpBtn=UIButton.get(self,19)
self.levelName=UIText.get(self,20)
self.levelScrollView=UIObject.get(self,21)
self.levelUpBtn=UIButton.get(self,22)
self.levelUpBtnText=UIText.get(self,23)
self.reviewBtn=UIButton.get(self,24)
self.ruleList=UIObject.get(self,25)
self.ruleMask=UIButton.get(self,26)
self.rulePart=UIObject.get(self,27)
self.soldierModel=UIObject.get(self,28)
self.speedUpBtn=UIButton.get(self,29)
self.trainCostRoot=UIObject.get(self,30)
self.trainCountRoot=UIObject.get(self,31)
self.trainCountSelectRoot=UIObject.get(self,32)
self.trainProcessRoot=UIObject.get(self,33)
self.xiushiText=UIText.get(self,34)
self.xsjNumText=UIText.get(self,35)

self.arrowLeftBtn:setButtonClick(function()self:onArrowLeftBtn()end)

self.arrowRightBtn:setButtonClick(function()self:onArrowRightBtn()end)

self.batchBtn:setButtonClick(function()self:onBatchBtn()end)

self.breakBtn:setButtonClick(function()self:onBreakBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.finishBtn:setButtonClick(function()self:onFinishBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.reviewBtn:setButtonClick(function()self:onReviewBtn()end)

self.ruleMask:setButtonClick(function()self:onRuleMask()end)

self.speedUpBtn:setButtonClick(function()self:onSpeedUpBtn()end)



end


function UIYunJiaYingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allXsinfobg);self.allXsinfobg=nil;
_UIObject_release(self.allXsNumText);self.allXsNumText=nil;
_UIObject_release(self.arrowLeftBtn);self.arrowLeftBtn=nil;
_UIObject_release(self.arrowRightBtn);self.arrowRightBtn=nil;
_UIObject_release(self.attrGridGroup);self.attrGridGroup=nil;
_UIObject_release(self.batchBtn);self.batchBtn=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.breakBtn);self.breakBtn=nil;
_UIObject_release(self.cannotTrainTipsRoot);self.cannotTrainTipsRoot=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costJobAdd);self.costJobAdd=nil;
_UIObject_release(self.costJobAddIcon);self.costJobAddIcon=nil;
_UIObject_release(self.costJobAddTx);self.costJobAddTx=nil;
_UIObject_release(self.costTimeText);self.costTimeText=nil;
_UIObject_release(self.finishBtn);self.finishBtn=nil;
_UIObject_release(self.finishCostIcon);self.finishCostIcon=nil;
_UIObject_release(self.finishCostText);self.finishCostText=nil;
_UIObject_release(self.hasXsNumText);self.hasXsNumText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.levelName);self.levelName=nil;
_UIObject_release(self.levelScrollView);self.levelScrollView=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.reviewBtn);self.reviewBtn=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
_UIObject_release(self.ruleMask);self.ruleMask=nil;
_UIObject_release(self.rulePart);self.rulePart=nil;
_UIObject_release(self.soldierModel);self.soldierModel=nil;
_UIObject_release(self.speedUpBtn);self.speedUpBtn=nil;
_UIObject_release(self.trainCostRoot);self.trainCostRoot=nil;
_UIObject_release(self.trainCountRoot);self.trainCountRoot=nil;
_UIObject_release(self.trainCountSelectRoot);self.trainCountSelectRoot=nil;
_UIObject_release(self.trainProcessRoot);self.trainProcessRoot=nil;
_UIObject_release(self.xiushiText);self.xiushiText=nil;
_UIObject_release(self.xsjNumText);self.xsjNumText=nil;
end
















local levelItemCmpIndex={
bg=0,
levelNameIcon=1,
select=2,
lockFlag=3,
lvUpFlag=4,
}
local _this
local maxScrollWidth=400
local soldierCfgList




function UIYunJiaYingWin:onLoaded(...)
_this=self
self:bindComponents()
soldierCfgList=cfg_fairylandsoldierconfig()
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addProNotify(40,1,self.on_40_1)
end


function UIYunJiaYingWin:__delete()
_this=nil
self:clearFinishTrainTimer()
self:clearWaitTrainTimer()
self:clearUpdateTimer()
self:unbindComponents()
end




function UIYunJiaYingWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
if guid>0 then
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
if argtable.unBuildID then
self.unBuildID=argtable.unBuildID
self.bdData=zongmenModel:getBuildingData(self.unBuildID)
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,self.bdData.level)
end


yunjiayingController:tryToFinishTrain()

self.selectLevelIdx=argtable and argtable.selectLevelIdx
if not self.selectLevelIdx then
self.selectLevelIdx=self:getDefaultSelectLevelIndex()
end
self:refresh(true)
self:setUpdateTimer()

self:checkUnlockSoldierShow_openWin()
end


function UIYunJiaYingWin:onHide()
self:clearFinishTrainTimer()
self:clearWaitTrainTimer()
self:clearUpdateTimer()
end

function UIYunJiaYingWin:onUpdate()

local nowPos=self.Content:getChildAnchoredPosition()
local showWidth=self.levelScrollView:getChildSizeDeltaX()
if showWidth<maxScrollWidth then

self:refreshArrowBtn()
return self:clearUpdateTimer()
end
local nowPosX_Left=nowPos.x
local nowPosX_Right=nowPos.x-showWidth
local pageShowItemIdx_left
local pageShowItemIdx_right
pageShowItemIdx_left=self:getScrollViewPosIndex(-nowPosX_Left,true)
pageShowItemIdx_right=self:getScrollViewPosIndex(-nowPosX_Right,false)

local hasChangeIndex=false
if self.pageShowItemIdx_left~=pageShowItemIdx_left or self.pageShowItemIdx_right~=pageShowItemIdx_right then
hasChangeIndex=true
end
self.pageShowItemIdx_left=pageShowItemIdx_left
self.pageShowItemIdx_right=pageShowItemIdx_right

if hasChangeIndex then
return self:refreshArrowBtn()
end
end

function UIYunJiaYingWin:refresh(isInit)

self:refreshLeftPanel(isInit)


self:refreshRightPanel()


self:refreshLevelUpPanel()
self:refreshSoldierModel()
end

function UIYunJiaYingWin:refreshLeftPanel(isInit)

self:refreshLevelScrollView(isInit)


self:refreshSoldierInfo()
end

function UIYunJiaYingWin:refreshLevelScrollView(isInit)
local levelCfgList=cfg_fairylandsoldierconfig()
local count=0
for i,v in ipairs(levelCfgList)do
if not v.isHide then
count=count+1
end
end
self.maxListIndex=count
self.levelScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.levelScrollView:getChildScrollViewItemWidgets()
local timeList=self.buildCfg.duration
local selectIndex
for i=1,grids.Count do
local widget=grids[i-1]
local levelCfg=levelCfgList[i]
if levelCfg then
if levelCfg.isHide then
widget:SetChildActive(-1,false)
else
widget:SetChildActive(-1,true)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(levelItemCmpIndex.bg,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(levelItemCmpIndex.levelNameIcon,iconAb,levelIconName)

local isSelect=self.selectLevelIdx==levelCfg.id
widget:SetChildActive(levelItemCmpIndex.select,isSelect)
if isSelect then
selectIndex=i
end

local isUnlock=timeList[levelCfg.id]~=nil
widget:SetChildActive(levelItemCmpIndex.lockFlag,not isUnlock)
if isUnlock then
widget:SetChildButtonClick(levelItemCmpIndex.bg,function()
return self:selectLevel(i)
end,true)
else

widget:SetChildButtonClick(levelItemCmpIndex.bg,function()
local unlockBuildLevel=yunjiayingModel:getSoldierUnlockBuildLevel(levelCfg.id)
if unlockBuildLevel then
return UIManager.error(FMT.fmt("云甲营{0}级解锁",unlockBuildLevel))
else
return UIManager.error("敬请期待")
end
end,true)
end

local isCanLvUp=yunjiayingModel:checkSoldierCanBreak(i)
widget:SetChildActive(levelItemCmpIndex.lvUpFlag,isCanLvUp)
end

else
widget:SetChildActive(-1,false)
end
end

if isInit and selectIndex then

self:jumpItem(selectIndex,nil,true)
end
end

function UIYunJiaYingWin:refreshSoldierInfo()
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,self.selectLevelIdx)

local name=FMT.fmt("{0}修士",cfg and cfg.name or"未知")
self.levelName:setText(name)




local attrList_lookup={
[eAttributeType.eATK]=xjSoldierAttr.atk,
[eAttributeType.eDEF]=xjSoldierAttr.def,
[eAttributeType.eHP]=xjSoldierAttr.hp,
}
local attrList={}
for attrId,attrType in pairs(attrList_lookup)do
local attrValue=xianjieModel:getSoldierAttr(self.selectLevelIdx,attrType)or 0
local attrName=helper.getAttributeName(attrId)
local attrValueStr=helper.getAttributeStrEx(attrId,attrValue)
local sortWeight=attrId
attrList[#attrList+1]={
attrName=attrName,
attrValueStr=attrValueStr,
sortWeight=sortWeight,
}
end
if cfg.weight then

attrList[#attrList+1]={
attrName="负重",
attrValueStr=cfg.weight,
sortWeight=1000000,
}
end
if next(attrList)~=nil then
table.sort(attrList,function(a,b)
return a.sortWeight<b.sortWeight
end)
end

local grids=self.attrGridGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local attrData=attrList[i]
if attrData then
widget:SetChildActive(-1,true)
widget:SetChildText(0,FMT.fmt("<color=#7d3b17>{0}：</color>{1}",attrData.attrName,attrData.attrValueStr))
else
widget:SetChildActive(-1,false)
end
end
end

function UIYunJiaYingWin:refreshRightPanel(isOnlyUpdateSelect)
self:clearFinishTrainTimer()
self:clearWaitTrainTimer()
self.allMoneyCount=0
local soldierCountList={}

for soldierId,soldierCfg in ipairs(soldierCfgList)do
local soldierMoneyIdList=soldierCfg.money or{}
for hurtType,moneyId in ipairs(soldierMoneyIdList)do
local ignoreHurtType=xjSoldierHurtType.eSlightInjury
local healthCount=0
local injuryCount=0
if hurtType~=ignoreHurtType then
local hasCount=itemsModel.getCount(moneyId)
self.allMoneyCount=self.allMoneyCount+hasCount
if hurtType==xjSoldierHurtType.eHealthy then
healthCount=hasCount
elseif hurtType==xjSoldierHurtType.eSeriousInjury then
injuryCount=hasCount
end

if soldierCountList[soldierId]then
soldierCountList[soldierId].allCount=soldierCountList[soldierId].allCount+hasCount
soldierCountList[soldierId].healthCount=soldierCountList[soldierId].healthCount+healthCount
soldierCountList[soldierId].injuryCount=soldierCountList[soldierId].injuryCount+injuryCount
else
soldierCountList[soldierId]={
allCount=hasCount,
healthCount=healthCount,
injuryCount=injuryCount,
}
end
end
end
end

local cfg=soldierCfgList[self.selectLevelIdx]

local soldierCount_all=soldierCountList[self.selectLevelIdx]and soldierCountList[self.selectLevelIdx].allCount or 0
local soldierCount_health=soldierCountList[self.selectLevelIdx]and soldierCountList[self.selectLevelIdx].healthCount or 0
local soldierCount_injury=soldierCountList[self.selectLevelIdx]and soldierCountList[self.selectLevelIdx].injuryCount or 0


local name=FMT.fmt("{0}修士信息",cfg and cfg.name or"未知")

self.xiushiText:setText(name)


self.allXsNumText:setText(FMT.fmt("<color=#7d3b17>可出征人数：</color>{0}",mathHelper.formatNumber4(soldierCount_health,1)))


self.hasXsNumText:setText(FMT.fmt("<color=#7d3b17>负伤修士人数：</color>{0}",mathHelper.formatNumber4(soldierCount_injury,1)))



local xsjNum=yunjiayingModel:getXiuShiNumById(self.selectLevelIdx)
self.xsjNumText:setText(FMT.fmt("<color=#7d3b17>小世界现存{0}：</color>{1}",cfg.name,mathHelper.formatNumber4(xsjNum,1)))



local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local isCanBreak=soldierCount_health>0 and self.selectLevelIdx<nowMaxLevelIdx
self.breakBtn:setActive(isCanBreak)


local trainingData=yunjiayingModel:getTrainDataByLevelIdx(self.selectLevelIdx)
local isTraining=trainingData~=nil
if isTraining then

self.trainCostRoot:setActive(false)
self.trainCountSelectRoot:setActive(false)
self.cannotTrainTipsRoot:setActive(false)
self.trainCountRoot:setActive(true)
self.trainProcessRoot:setActive(true)


local countWidget=self.trainCountRoot:getWidgetBase()
local count=trainingData.trainCount
local countStr=mathHelper.formatNumber4(count,1)
countWidget:SetChildText(0,countStr)


local processRootWidget=self.trainProcessRoot:getWidgetBase()
local startTime=trainingData.startTime
local finishTime=trainingData.finishTime
local nowTime=timeHelper.getServerShortTime()
local isCanSpeedUp=false
local isWaiting=false
if nowTime<startTime then
processRootWidget:SetChildProgressValue(0,0,100)

processRootWidget:SetChildActive(3,false)
processRootWidget:SetChildActive(2,true)
processRootWidget:SetChildText(2,"等待中")
isWaiting=true

self:setWaitTrainTimer()
elseif nowTime>=finishTime then
processRootWidget:SetChildProgressValue(0,100,100)

processRootWidget:SetChildActive(3,false)
processRootWidget:SetChildActive(2,true)
processRootWidget:SetChildText(2,"已完成")


yunjiayingController:tryToFinishTrain()
else
local allTime=finishTime-startTime
local curTime=nowTime-startTime
local precent=curTime/allTime*100
local deltaTime=finishTime-nowTime
processRootWidget:SetChildActive(3,true)
processRootWidget:SetChildProgressValue(0,precent,100)
processRootWidget:SetChildProgressText(0,timeHelper.format_time_stamp(deltaTime))
processRootWidget:SetChildActive(2,false)


self:setFinishTrainTimer()
isCanSpeedUp=true
end


processRootWidget:SetChildActive(4,isWaiting)
if isWaiting then
local needTime=finishTime-startTime
processRootWidget:SetChildText(4,timeHelper.format_time_stamp(needTime))
end


processRootWidget:SetChildButtonClick(1,function()
if not _this then return end
return self:onRemoveBtnClick(self.selectLevelIdx)
end,true)


self.speedUpBtn:setActive(isCanSpeedUp)

self.confirmBtn:setActive(false)

if isCanSpeedUp then

local needTime=finishTime-nowTime
self:showFinishBtn(needTime)
else

self.finishBtn:setActive(false)
end
else

self.trainCountRoot:setActive(false)
self.trainProcessRoot:setActive(false)

local maxCanHasCount=yunjiayingModel:getMaxCanMakeSoldierCount()
local trainingSoldierCount=yunjiayingModel:getTrainingSoldierCount()
if not isOnlyUpdateSelect then
local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
self.waiPaiAllSoldierCount=waiPaiAllSoldierCount
else
self.waiPaiAllSoldierCount=self.waiPaiAllSoldierCount or 0
end
local remainingCanHasCount=maxCanHasCount-self.allMoneyCount-trainingSoldierCount-self.waiPaiAllSoldierCount
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()
local maxCount=math.min(remainingCanHasCount,maxTrainCount,xsjNum)

if maxCount and maxCount>0 then

local count=self.trainSelectCount
if self.trainSelectCount then
count=self.trainSelectCount
else
local maxEnoughCount=yunjiayingModel:getTrainMaxEnoughCostCount(0,self.selectLevelIdx)
count=maxEnoughCount<maxCount and maxEnoughCount or maxCount
if count<=0 then
count=1
end
end


self.cannotTrainTipsRoot:setActive(false)
self.trainCostRoot:setActive(true)
self.trainCountSelectRoot:setActive(true)


local countSelectWidget=self.trainCountSelectRoot:getWidgetBase()
local minCount=1

countSelectWidget:SetChildActive(2,maxCount<=1)

countSelectWidget:SetChildInputFieldChange(0,true,function(...)
if not _this then return end
return _this:changeSelectCount(maxCount,...)
end)

local func=function(...)
if not _this then return end
return _this:onSliderChange(...)
end
countSelectWidget:SetChildSliderInit(1,count,minCount,maxCount,func)
countSelectWidget:SetChildInputFieldValue(0,count)
countSelectWidget:SetChildSliderValue(1,count)


countSelectWidget:SetChildButtonClick(3,function()
if not _this then return end
return _this:onSubBtn()
end,true)
countSelectWidget:SetChildButtonClick(4,function()
if not _this then return end
return _this:onAddBtn(maxCount)
end,true)


local costWidget=self.trainCostRoot:getWidgetBase()
local costList=yunjiayingModel:getTrainNeedCost(0,self.selectLevelIdx,count,true)
costWidget:SetChildLayoutGroupCreateItems(0,#costList)
local grids=costWidget:GetChildLayoutGroupGridList(0)
for i=1,grids.Count do
local widget=grids[i-1]
local item=costList[i]
local itemid=item[1]
local itemCount=item[2]
local hasCount=itemsModel.getCount(itemid)
local countStr=''
countStr=mathHelper.formatNumber(itemCount)
if hasCount<itemCount then
countStr=FMT.fmt("<color=#FF0000>{0}</color>",countStr)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


self.speedUpBtn:setActive(false)

self.confirmBtn:setActive(true)


local needTime=yunjiayingModel:getTrainNeedTime(0,self.selectLevelIdx,count)
self.costTimeText:setText(timeHelper.format_time_stamp(needTime))

self:refreshCostAdd()

local trainList=yunjiayingModel:getTrainList()or{}
if not next(trainList)then

self:showFinishBtn(needTime,true)
else

self.finishBtn:setActive(false)
end
else

self.trainCostRoot:setActive(false)
self.trainCountSelectRoot:setActive(false)
self.cannotTrainTipsRoot:setActive(true)

local tipsStr=""

if remainingCanHasCount<=0 then
tipsStr="云甲营容纳已达上限"
elseif xsjNum<=0 then
tipsStr="小世界现存修士<color=#c82c2c>不足</color>"
end

local widget=self.cannotTrainTipsRoot:getWidgetBase()
widget:SetChildText(0,tipsStr)


self.speedUpBtn:setActive(false)

self.confirmBtn:setActive(false)

self.finishBtn:setActive(false)
end
end
end

function UIYunJiaYingWin:refreshCostAdd()
self.activeXG=yunjiayingModel:getActiveXianGuan()
self.costJobAdd:setActive(self.activeXG~=nil)
if self.activeXG then
local xgList=cfgHelper.get2(cfg_yunjiayingbaseconfig_get,1,"xianguan")
local xgInfo=xgList[self.activeXG]
local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,xgInfo[1])
local addTips=xgInfo[3]
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
self.costJobAddIcon:setSprite(globalABLookup.xianguan,jobIconName)
self.costJobAddTx:setText(FMT.fmt(addTips,jobCfg.name))
end
end

function UIYunJiaYingWin:infoCostAdd()
if self.activeXG then
local xgList=cfgHelper.get2(cfg_yunjiayingbaseconfig_get,1,"xianguan")
local xgInfo=xgList[self.activeXG]
local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,xgInfo[1])
local addTips=xgInfo[4]
UIManager.info(FMT.fmt(addTips,jobCfg.name))
end
end

function UIYunJiaYingWin:refreshRightPanel_onlyProcess()
local trainingData=yunjiayingModel:getTrainDataByLevelIdx(self.selectLevelIdx)
local isTraining=trainingData~=nil
if isTraining then

local processRootWidget=self.trainProcessRoot:getWidgetBase()
local startTime=trainingData.startTime
local finishTime=trainingData.finishTime
local nowTime=timeHelper.getServerShortTime()
if nowTime>=startTime and nowTime<finishTime then
local allTime=finishTime-startTime
local curTime=nowTime-startTime
local precent=curTime/allTime*100
local deltaTime=finishTime-nowTime
processRootWidget:SetChildActive(3,true)
processRootWidget:SetChildProgressValue(0,precent,100)
processRootWidget:SetChildProgressText(0,timeHelper.format_time_stamp(deltaTime))
processRootWidget:SetChildActive(2,false)


local needTime=finishTime-nowTime
self:showFinishBtn(needTime)
elseif nowTime>=finishTime then
processRootWidget:SetChildActive(3,false)
processRootWidget:SetChildProgressValue(0,100,100)
processRootWidget:SetChildText(2,"已完成")
processRootWidget:SetChildActive(2,true)
self.finishBtn:setActive(false)


yunjiayingController:tryToFinishTrain()


return self:clearFinishTrainTimer()
end
else
return self:refreshRightPanel()
end
end

function UIYunJiaYingWin:selectLevel(levelIdx)
if self.selectLevelIdx==levelIdx then
return
end
self.selectLevelIdx=levelIdx
self.trainSelectCount=nil
self.refreshSoldierModelisInit=false
self:refresh()
end

function UIYunJiaYingWin:changeSelectCount(maxCount,str)

local count=tonumber(str)

local originalCount=self.trainSelectCount or 0
local isNeedReset=false
if count==nil then

count=1
isNeedReset=true
elseif count==originalCount then

return
elseif count<1 then

count=1
isNeedReset=true
elseif count>maxCount then

count=maxCount
isNeedReset=true
end

if isNeedReset then
local countSelectWidget=self.trainCountSelectRoot:getWidgetBase()
countSelectWidget:SetChildInputFieldValue(0,count)
return
end

if self.trainSelectCount==count then
return
end


self.trainSelectCount=count
self:refreshRightPanel(true)
end

function UIYunJiaYingWin:onSliderChange(value)
if not value then
return
end

if self.trainSelectCount==value then
return
end


self.trainSelectCount=value

self:refreshRightPanel(true)
end

function UIYunJiaYingWin:getScrollViewPosIndex(posX,isLeft)
local leftOffset=6
local rightOffset=16
local itemWeight=96
local itemSpace=4
local offset=20
local index=0
local itemCount=self.maxListIndex
if posX<=leftOffset then

return nil
elseif posX>=leftOffset+(itemWeight+itemSpace)*itemCount-itemSpace then

return nil
end

if isLeft then
local tmp=(posX-leftOffset)%(itemWeight+itemSpace)
index=math.floor((posX-leftOffset)/(itemWeight+itemSpace))
if tmp>0 then
if tmp>=offset then
index=index+1
end
end
else
local tmp=(posX-leftOffset+itemSpace)%(itemWeight+itemSpace)
index=math.ceil((posX-leftOffset+itemSpace)/(itemWeight+itemSpace))
if tmp>0 then
if tmp>(itemWeight+itemSpace-offset)then
index=index+1
end
elseif tmp==0 then
index=index+1
end
end

if index==0 or index>itemCount then
index=nil
end
return index
end

function UIYunJiaYingWin:setFinishTrainTimer()
self:clearFinishTrainTimer()
local func=function()
return self:refreshRightPanel_onlyProcess()
end

self.finishTrainTimer=self:setTimer(1,0,func)
end

function UIYunJiaYingWin:clearFinishTrainTimer()
if self.finishTrainTimer then
self:stopTimerByID(self.finishTrainTimer)
self.finishTrainTimer=nil
end
end

function UIYunJiaYingWin:setWaitTrainTimer()
self:clearWaitTrainTimer()
local func=function()
local trainingData=yunjiayingModel:getTrainDataByLevelIdx(self.selectLevelIdx)
local isTraining=trainingData~=nil
if isTraining then
local startTime,finishTime=yunjiayingModel:getTrainingDataTimeByIdx(trainingData.idx)
local nowTime=timeHelper.getServerShortTime()
if nowTime>=startTime and nowTime<finishTime then







return self:refreshRightPanel()
end
else

return self:refreshRightPanel()
end
end

self.waitTrainTimer=self:setTimer(1,0,func)
end

function UIYunJiaYingWin:clearWaitTrainTimer()
if self.waitTrainTimer then
self:stopTimerByID(self.waitTrainTimer)
self.waitTrainTimer=nil
end
end

function UIYunJiaYingWin:setUpdateTimer()
self:clearUpdateTimer()
self.updateTimer=self:setTimer(0.1,0,function()self:onUpdate()end)

self:onUpdate()
end

function UIYunJiaYingWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIYunJiaYingWin:refreshArrowBtn()
local isShowLeftBtn=false
local isShowRightBtn=false

if self.pageShowItemIdx_left and self.pageShowItemIdx_left>=1 then
isShowLeftBtn=true
end
if self.pageShowItemIdx_right and self.pageShowItemIdx_right<=self.maxListIndex then
isShowRightBtn=true
end

self.arrowLeftBtn:setActive(isShowLeftBtn)
self.arrowRightBtn:setActive(isShowRightBtn)
end

function UIYunJiaYingWin:jumpItem(index,animation,alignEnd)
local jumpIndex=index
if jumpIndex<=1 then
jumpIndex=0
elseif jumpIndex>=self.maxListIndex then
jumpIndex=self.maxListIndex+1
end
self.levelScrollView:setChildScrollViewSelectItem(jumpIndex-1,animation or false,false,alignEnd or false)
end

function UIYunJiaYingWin:refreshLevelUpPanel()
self.bdLevel:setText(FMT.fmt("{0}级{1}",self.bdData.level,self.config.name))
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end

function UIYunJiaYingWin:showFinishBtn(needTime,needStart)

local spcfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_allow',speedUpType.eYunJiaYingTrain)or{}
if spcfg[speedUpMode.eMoneyBuilding]then
self.finishBtn:setActive(true)
local baseCfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_times')
local costParamList=baseCfg[speedUpMode.eMoneyBuilding]
local costParam=costParamList[self.bdData.build_id]
if costParam then
local costMoneyType=costParam[1]
local costMoneyNum=costParam[2]
local costTime=costParam[3]

local needMoneyCount=math.ceil(needTime/costTime)*costMoneyNum

local moneyIconName=iconHelper.getIconName(costMoneyType)
self.finishCostIcon:setChildIcon(moneyIconName)


local hasCount=itemsModel.getCount(costMoneyType)
local moneyStr=mathHelper.formatNumber(needMoneyCount)
if hasCount<needMoneyCount then
moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,moneyStr)
end
self.finishCostText:setText(moneyStr)
self.finishBtnCost={costMoneyType,needMoneyCount}
self.needStart=needStart
else

self.finishBtn:setActive(false)
end
else

self.finishBtn:setActive(false)
end
end

function UIYunJiaYingWin:getDefaultSelectLevelIndex()
local defaultIdx
local trainList=yunjiayingModel:getTrainList()
if trainList and trainList[1]then

local trainData=trainList[1]
local startIdx=trainData.startId
local targetIdx=trainData.targetId
if startIdx==0 then
defaultIdx=targetIdx
else
defaultIdx=startIdx
end
else
local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
defaultIdx=nowMaxLevelIdx
end

return defaultIdx
end

function UIYunJiaYingWin:checkConfirm()

local maxCanHasCount=yunjiayingModel:getMaxCanMakeSoldierCount()
local trainingSoldierCount=yunjiayingModel:getTrainingSoldierCount()
local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
local remainingCanHasCount=maxCanHasCount-self.allMoneyCount-trainingSoldierCount-waiPaiAllSoldierCount
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()
local xsjNum=yunjiayingModel:getXsjSoldierCount()
local maxCount=math.min(remainingCanHasCount,maxTrainCount,xsjNum)
if not maxCount or maxCount<0 then
local tipsStr=""
if remainingCanHasCount<=0 then
tipsStr="云甲营容纳已达上限"
elseif xsjNum<=0 then
tipsStr="小世界现存修士不足"
end
UIManager.error(tipsStr)
return false
end


local costList=yunjiayingModel:getTrainNeedCost(0,self.selectLevelIdx,self.trainSelectCount)
for _,v in ipairs(costList)do
local itemId=v[1]
local itemCount=v[2]
local isEnough=itemsModel.checkItemEnough(itemId,itemCount)
if not isEnough then
local itemName=itemsModel.getName(itemId)
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(itemId)
return false
end
end


local freeCount=yunjiayingModel:getFreeTrainCount()
if not freeCount or freeCount<=0 then
UIManager.error("当前训练队伍队列已满")
return false
end
return true
end

function UIYunJiaYingWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if not _this or not _this.isVisible then
return
end
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.levelUpComplete
or etype==buildingEvent.levelUpStart then
if _this.entityId>0 then
_this.bdData=zongmenModel:findBuildingByEntityId(_this.entityId)
end
if _this.unBuildID then
_this.bdData=zongmenModel:getBuildingData(_this.unBuildID)
end
_this.config=cfgHelper.get1(cfg_monijybuildconfig_get,_this.bdData.build_id)
_this:refresh()
end
end

function UIYunJiaYingWin.on_40_1()
if not _this or not _this.isVisible then
return
end
_this:refreshCostAdd()
end

function UIYunJiaYingWin:refreshRulePart(ruleName)
local desclist={}
local name=ruleName
for i=1,10 do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(desclist,str)
end
end

local descLen=#desclist
self.ruleList:setChildLayoutGroupCreateItems(descLen,function(index)
local item=self.ruleList:getChildLayoutGroupGridItem(index-1)
local desc=desclist[index]
item:SetChildText(0,desc)
end)
end


function UIYunJiaYingWin:checkUnlockSoldierShow(buildLv)
local lastBuildLv=buildLv and buildLv-1 or 0
if lastBuildLv<=0 then
return
end

local hasUnlockSoldier=false
local unlockSoldierIdx
local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
local lastBuildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,lastBuildLv)
if buildCfg and lastBuildCfg then
local timeList=buildCfg.duration
local maxLevelIdx=#timeList
local timeList_last=lastBuildCfg.duration
local maxLevelIdx_last=#timeList_last
if maxLevelIdx>maxLevelIdx_last then
hasUnlockSoldier=true
unlockSoldierIdx=maxLevelIdx
end
end

userActorSetting.set("yunjiaying_unlock_oldLevel",nil)
userActorSetting.flush()

if hasUnlockSoldier then
self:showWindow("UIYunJiaYing_unlockSoldierWin",{soldierIdx=unlockSoldierIdx})
end
end

function UIYunJiaYingWin:checkUnlockSoldierShow_openWin()
local oldLevel=userActorSetting.get("yunjiaying_unlock_oldLevel",nil)

if oldLevel then
local bdData=self.bdData or zongmenModel:findBuildingByEntityId(self.entityId)
if bdData and bdData.level>oldLevel then
self:checkUnlockSoldierShow(bdData.level)
end
end
end





function UIYunJiaYingWin:onBreakBtn()
local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
if self.selectLevelIdx==nowMaxLevelIdx then
UIManager.error("该等级为当前最高突破等级")
return
end

local ubdId=self.bdData.un_build_id












self:showWindow("UIYunJiaYing_breakWin",{un_build_id=ubdId,levelIdx=self.selectLevelIdx})
end



function UIYunJiaYingWin:onFinishBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法立即完成")
return
end
local needStart=self.needStart
if needStart and not self:checkConfirm()then
return
end

if not self.finishBtnCost or not next(self.finishBtnCost)then
return
end

local moneyType=self.finishBtnCost[1]
local moneyCount=self.finishBtnCost[2]
local moneyName=moneyModel.getMoneyName(moneyType)
local targetId=self.selectLevelIdx
local trainCount=self.trainSelectCount
local ubdId=self.bdData.un_build_id
local content=FMT.fmt("是否花费<color=#549327>{0}</color>{1}\n立即完成这批修士的训练",mathHelper.formatNumber(moneyCount),moneyName)
local okCallback=function()
moneySystem:useMoney(moneyType,moneyCount,function()

return yunjiayingController:reqFastFinishTrain(ubdId,0,targetId,trainCount,{moneyType,moneyCount},needStart)
end,WARNING_TYPE.eWarning)
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYJYFastFinish)
if flag then
okCallback()
return
end

local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okCallback,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYJYFastFinish,flag)
end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end



function UIYunJiaYingWin:onConfirmBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法新增训练")
return
end
if not self:checkConfirm()then
return
end


local targetLevelIdx=self.selectLevelIdx
local trainCount=self.trainSelectCount
local trainList={{0,targetLevelIdx,trainCount}}
yunjiayingController:reqStartTrain(trainList)

self:infoCostAdd()
end



function UIYunJiaYingWin:onSpeedUpBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法加速")
return
end
local trainingData=yunjiayingModel:getTrainDataByLevelIdx(self.selectLevelIdx)
if trainingData then
local startTime,finishTime=yunjiayingModel:getTrainingDataTimeByIdx(trainingData.idx)

local args={}
args.titleName="修士训练加速"
args.pos=2
args.extraWin='UIXJBuildingSpeedUpWin'
local ubdId=self.bdData.un_build_id
local trainingIdx=trainingData.idx
local initFinishTimeFunc=function()
local startTime,finishTime=yunjiayingModel:getTrainingDataTimeByIdx(trainingIdx)
if not finishTime then
finishTime=0
end
return finishTime
end
args.extraParams={
trainIndex=trainingData.idx,
un_build_id=ubdId,
build_id=SLG_SYSTEM_TYPE.eYunJiaYing,
speedType=speedUpType.eYunJiaYingTrain,
finishTime=finishTime,
initFinishTimeFunc=initFinishTimeFunc,
tipsText="训练",
XJSpeedUp=REPEAT_TYPE.eXJJunJiaYingoneSpeedUp,
backImg={"ui/windows/yunjiaying/yunjiaying_atlas_pak.ab","image_xunlianjiasu_1"},
}
args.showClose=false
self:showWindow('UIXJBuildingPageBgWin',args)

end
end



function UIYunJiaYingWin:onBatchBtn()
local ubdId=self.bdData.un_build_id
self:showWindow("UIYunJiaYing_batchWin",{un_build_id=ubdId})
end

function UIYunJiaYingWin:onArrowLeftBtn()
if not self.pageShowItemIdx_left then
return
end

self:jumpItem(self.pageShowItemIdx_left,true)
end

function UIYunJiaYingWin:onArrowRightBtn()
if not self.pageShowItemIdx_right then
return
end

self:jumpItem(self.pageShowItemIdx_right,true,true)
end

function UIYunJiaYingWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIYunJiaYingWin:onSubBtn()
if self.trainSelectCount<=1 then
return
end
local originalCount=self.trainSelectCount
self.trainSelectCount=self.trainSelectCount-1
if self.trainSelectCount<1 then
self.trainSelectCount=1
end

self:refreshRightPanel(true)
end

function UIYunJiaYingWin:onAddBtn(maxCount)
if self.trainSelectCount>=maxCount then
return
end
local originalCount=self.trainSelectCount
self.trainSelectCount=self.trainSelectCount+1
if self.trainSelectCount>maxCount then
self.trainSelectCount=maxCount
end

self:refreshRightPanel(true)
end

function UIYunJiaYingWin:onRemoveBtnClick(levelIdx)
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法取消训练")
return
end

local showdata=
{
type='UIDialouge',
title='提示',
content='是否取消训练？\n已消耗的加速道具不会返还，\n只返还部分未消耗的资源',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()

local trainingData=yunjiayingModel:getTrainDataByLevelIdx(levelIdx)
if trainingData then
local startTime,finishTime=yunjiayingModel:getTrainingDataTimeByIdx(trainingData.idx)
local nowTime=timeHelper.getServerShortTime()
if nowTime>=finishTime then
return UIManager.error("当前训练已完成")
else

yunjiayingController:tryToFinishTrain()
yunjiayingController:reqCancelTrain(trainingData.idx)
end
else
return UIManager.error("找不到正在进行的训练，请重试")
end
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function UIYunJiaYingWin:onLevelUpBtn()
self:showWindow("UIXJBuildingInfoWin",self.bdData)
end

function UIYunJiaYingWin:onHelpBtn()
local ruleName="yunjiaying_help_%d"
self:refreshRulePart(ruleName)
self.rulePart:setActive(true)
self.ruleMask:setActive(true)
end

function UIYunJiaYingWin:onRuleMask()
self.rulePart:setActive(false)
self.ruleMask:setActive(false)
end

function UIYunJiaYingWin:refreshSoldierModel()

local cfg=soldierCfgList[self.selectLevelIdx]
local jiankangmoney=cfg.money[1]
local zhongshangmoney=cfg.money[3]
local allSoldierCount=itemsModel.getCount(jiankangmoney)+itemsModel.getCount(zhongshangmoney)
local showMaxSoldier=100000
local percent=allSoldierCount/showMaxSoldier
if percent>1 then
percent=1
end
if percent<0.2 then
percent=0.2
end
if not self.refreshSoldierModelisInit then
local jzCfg=cfgHelper.get(cfg_jzconfig_get,self.selectLevelIdx)
local abName=jzCfg.uiModel

local maxShowNum=50
self.winlua:SetChildTroop(self.soldierModel:getID(),abName,maxShowNum,percent,function()
return
end)
self.refreshSoldierModelisInit=true
else
self.winlua:SetChildTroopProgress(self.soldierModel:getID(),percent)
end
end

function UIYunJiaYingWin:onReviewBtn()

local args={}
args.titleName="修士总览"
args.pos=2
args.extraWin='UIYunJiaYing_reviewWin'
args.showClose=false
self:showWindow('UICommonPageWin',args)
end
