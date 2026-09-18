







def_class("UIYunJiaYing_batchWin",UIWindowBase)









function UIYunJiaYing_batchWin:bindComponents()

self.arrowLeftBtn=UIButton.get(self,0)
self.arrowRightBtn=UIButton.get(self,1)
self.breakBtn=UIButton.get(self,2)
self.breakBtnSelect=UIObject.get(self,3)
self.cannotTrainTips=UIObject.get(self,4)
self.cannotTrainTipsText=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.confirmBtn=UIButton.get(self,7)
self.confirmBtnText=UIText.get(self,8)
self.Content=UIObject.get(self,9)
self.costPanel=UIObject.get(self,10)
self.costTimeText=UIText.get(self,11)
self.finishBtn=UIButton.get(self,12)
self.finishCostIcon=UIImage.get(self,13)
self.finishCostText=UIText.get(self,14)
self.helpBtn=UIButton.get(self,15)
self.infoPanel=UIObject.get(self,16)
self.levelScrollView=UIObject.get(self,17)
self.mask=UIButton.get(self,18)
self.onekeyAllBtn=UIButton.get(self,19)
self.oneKeyBtn=UIButton.get(self,20)
self.onekeybtnimage=UIObject.get(self,21)
self.ruleList=UIObject.get(self,22)
self.ruleMask=UIButton.get(self,23)
self.rulePart=UIObject.get(self,24)
self.speedUpBtn=UIButton.get(self,25)
self.speedUpPanel=UIObject.get(self,26)
self.title=UIText.get(self,27)
self.titleText=UIText.get(self,28)
self.trainBtn=UIButton.get(self,29)
self.trainBtnSelect=UIObject.get(self,30)
self.trainListScrollView=UIObject.get(self,31)

self.arrowLeftBtn:setButtonClick(function()self:onArrowLeftBtn()end)

self.arrowRightBtn:setButtonClick(function()self:onArrowRightBtn()end)

self.breakBtn:setButtonClick(function()self:onBreakBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.finishBtn:setButtonClick(function()self:onFinishBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.onekeyAllBtn:setButtonClick(function()self:onOnekeyAllBtn()end)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)

self.ruleMask:setButtonClick(function()self:onRuleMask()end)

self.speedUpBtn:setButtonClick(function()self:onSpeedUpBtn()end)

self.trainBtn:setButtonClick(function()self:onTrainBtn()end)



end


function UIYunJiaYing_batchWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowLeftBtn);self.arrowLeftBtn=nil;
_UIObject_release(self.arrowRightBtn);self.arrowRightBtn=nil;
_UIObject_release(self.breakBtn);self.breakBtn=nil;
_UIObject_release(self.breakBtnSelect);self.breakBtnSelect=nil;
_UIObject_release(self.cannotTrainTips);self.cannotTrainTips=nil;
_UIObject_release(self.cannotTrainTipsText);self.cannotTrainTipsText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.confirmBtnText);self.confirmBtnText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTimeText);self.costTimeText=nil;
_UIObject_release(self.finishBtn);self.finishBtn=nil;
_UIObject_release(self.finishCostIcon);self.finishCostIcon=nil;
_UIObject_release(self.finishCostText);self.finishCostText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.levelScrollView);self.levelScrollView=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.onekeyAllBtn);self.onekeyAllBtn=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.onekeybtnimage);self.onekeybtnimage=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
_UIObject_release(self.ruleMask);self.ruleMask=nil;
_UIObject_release(self.rulePart);self.rulePart=nil;
_UIObject_release(self.speedUpBtn);self.speedUpBtn=nil;
_UIObject_release(self.speedUpPanel);self.speedUpPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.trainBtn);self.trainBtn=nil;
_UIObject_release(self.trainBtnSelect);self.trainBtnSelect=nil;
_UIObject_release(self.trainListScrollView);self.trainListScrollView=nil;
end















local abname='ui/windows/yunjiaying/yunjiaying_atlas_pak.ab'
local _trainItemCmpIndex={
bg=0,
selectBg=1,
processBar=2,
processText=3,
tipsText=4,
cancelBtn=5,
icon=6,
levelNameIcon=7,
stateText=8,
infoPanel=9,
addPanel=10,
lockPanel=11,
btnPanel=12,
trainBtn=13,
trainBtnSelect=14,
breakBtn=15,
breakBtnSelect=16,
jiasuBtn=17,
}
local _this

local _costPanelCmpIndex={
costItemGroup=0,
countInputText=1,
selectCntSlider=2,
clickMask=3,
subBtn=4,
addBtn=5,





titleText=6,
titleText2=7,
}
local _speedUpPanelCmpIndex={
speedUpItemGroup=0,
countInputText=1,
selectCntSlider=2,
clickMask=3,
subBtn=4,
addBtn=5,
speedUpTimeText=6,
speedUpItemScrollView=7,
}
local _levelItemCmpIndex={
iconBg=0,
levelNameIcon=1,
select=2,
lockFlag=3,
numText=4,
doingFlag=5,
waitingFlag=6,
bg=7,
xiaoshijienumText=8,
name1=9,
name2=10,
}
local _speedUpItemCmpIndex={
item=0,
select=1,
timeText=2,
itemPanel=3,
notPanel=4,
notClick=5,
}

local selectTrainType=
{
xunlian=1,
jingjietupo=2
}

local maxScrollWidth=660



function UIYunJiaYing_batchWin:onLoaded(...)
_this=self
self:bindComponents()

local clickEvent=function(...)

return self:onClickTrainItem(...)
end
self.trainListScrollView:setChildScrollViewInit(0.5,true,clickEvent,nil)
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:onTrainBtn(true)
end


function UIYunJiaYing_batchWin:__delete()
_this=nil
self:clearTrainTimer()
self:clearUpdateTimer()
self:unbindComponents()
end




function UIYunJiaYing_batchWin:onShow(argtable,afterOnloaded)
self.un_build_id=argtable and argtable.un_build_id
if self.un_build_id then
self.bdData=zongmenModel:getBuildingData(self.un_build_id)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,self.bdData.level)
end


self.selectItemCount=nil
self:refresh(true)
self:setUpdateTimer()
self.trainListScrollView:setChildScrollViewSelectItem(self.selectTrainIndex-1,false,false,true)
end


function UIYunJiaYing_batchWin:onHide()
self:clearTrainTimer()
self:clearUpdateTimer()
end

function UIYunJiaYing_batchWin:onUpdate()
self.onekeyAllBtn:setActive(self.trainDataList and#self.trainDataList>1)

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

function UIYunJiaYing_batchWin:refresh(needJump)
self.selectLevelIndex=self.selectLevelIndex or self:getDefaultSelectLevelIndex()
self.selectTrainIndex=yunjiayingModel:getFreeTrainIndex()
self.maxTrainCount=yunjiayingModel:getTrainMaxCount()
self.trainDataList=yunjiayingModel:getTrainList()
self.unlockListCount=yunjiayingModel:getCanTrainCount()


self:refreshLeftPanel()


self:refreshRightPanel(true)

if needJump then
self:jumpItem(self.selectLevelIndex,false,true)
end
end

function UIYunJiaYing_batchWin:refreshLeftPanel()
self:clearTrainTimer()

self.trainListScrollView:setChildScrollViewCreateGrids(self.maxTrainCount,1)
local grids=self.trainListScrollView:getChildScrollViewItemWidgets()
local hasFinishTrain=false
local hasDoingTrain=false
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local trainingData=self.trainDataList[i]
local isSelect=self.selectTrainIndex==i
if trainingData then

widget:SetChildActive(-1,true)



widget:SetChildActive(_trainItemCmpIndex.infoPanel,true)
widget:SetChildActive(_trainItemCmpIndex.addPanel,false)

widget:SetChildActive(_trainItemCmpIndex.lockPanel,false)

local levelId=trainingData.startId==0 and trainingData.targetId or trainingData.startId
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,levelId)
local isxunlian=trainingData.startId==0

local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_trainItemCmpIndex.icon,iconAb,isxunlian and bgIconName or levelCfg.bgIcon2)


local levelName=levelCfg.name
local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_trainItemCmpIndex.levelNameIcon,iconAb,isxunlian and levelIconName or levelCfg.nameIcon3)


local startTime=trainingData.startTime
local finishTime=trainingData.finishTime
local isWait=false
local isFinish=false
if nowTime<startTime then
widget:SetChildProgressValue(_trainItemCmpIndex.processBar,0,100)
widget:SetChildActive(_trainItemCmpIndex.processText,true)
widget:SetChildActive(_trainItemCmpIndex.tipsText,false)

local deltaTime=finishTime-startTime
widget:SetChildProgressText(_trainItemCmpIndex.processBar,timeHelper.format_time_stamp(deltaTime))
isWait=true
elseif nowTime>=finishTime then
widget:SetChildProgressValue(_trainItemCmpIndex.processBar,100,100)
widget:SetChildActive(_trainItemCmpIndex.processText,false)
widget:SetChildActive(_trainItemCmpIndex.tipsText,true)
widget:SetChildText(_trainItemCmpIndex.tipsText,"已完成")
isFinish=true
hasFinishTrain=true
else
local allTime=finishTime-startTime
local curTime=nowTime-startTime
local precent=curTime/allTime*100
local deltaTime=finishTime-nowTime
widget:SetChildActive(_trainItemCmpIndex.processText,true)
widget:SetChildProgressValue(_trainItemCmpIndex.processBar,precent,100)
widget:SetChildProgressText(_trainItemCmpIndex.processBar,timeHelper.format_time_stamp(deltaTime))
widget:SetChildActive(_trainItemCmpIndex.tipsText,false)
end


widget:SetChildButtonClick(_trainItemCmpIndex.cancelBtn,function()
if not _this then return end
return self:onCancelBtnClick(trainingData.idx,levelId)
end,true)

widget:SetChildActive(_trainItemCmpIndex.jiasuBtn,i==1)


widget:SetChildButtonClick(_trainItemCmpIndex.jiasuBtn,function()
if _this then
self:newSpeedUpBtn()
end
end,true)


local isxunlian=trainingData.startId==0
local stateStr
local count=trainingData.trainCount
if isWait then
if isxunlian then
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n等待训练",count,levelName)
else
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n等待突破",count,levelName)
end
elseif isFinish then
if isxunlian then
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n已完成训练",count,levelName)
else
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n已完成突破",count,levelName)
end
else
if isxunlian then
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n正在训练",count,levelName)
else
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n正在突破",count,levelName)
end
end
widget:SetChildText(_trainItemCmpIndex.stateText,stateStr)
hasDoingTrain=true
elseif i<=self.unlockListCount then

widget:SetChildActive(-1,true)


widget:SetChildActive(_trainItemCmpIndex.jiasuBtn,false)


widget:SetChildActive(_trainItemCmpIndex.addPanel,true)

widget:SetChildActive(_trainItemCmpIndex.infoPanel,false)
widget:SetChildActive(_trainItemCmpIndex.lockPanel,false)
elseif i>self.unlockListCount and i<=self.maxTrainCount then

widget:SetChildActive(-1,true)
widget:SetChildActive(_trainItemCmpIndex.jiasuBtn,false)



widget:SetChildActive(_trainItemCmpIndex.infoPanel,false)
widget:SetChildActive(_trainItemCmpIndex.addPanel,false)
widget:SetChildActive(_trainItemCmpIndex.btnPanel,false)
widget:SetChildActive(_trainItemCmpIndex.lockPanel,true)
else
widget:SetChildActive(-1,false)
end
end

if hasDoingTrain then

self:setTrainTimer()
end

if hasFinishTrain then

yunjiayingController:tryToFinishTrain()
end
end

function UIYunJiaYing_batchWin:refreshLeftPanel_onlyProcess()

self.trainListScrollView:setChildScrollViewCreateGrids(self.maxTrainCount,1)
local grids=self.trainListScrollView:getChildScrollViewItemWidgets()
local hasFinishTrain=false
local hasDoingTrain=false
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local trainingData=self.trainDataList[i]
if trainingData then

widget:SetChildActive(-1,true)

local levelId=trainingData.startId==0 and trainingData.targetId or trainingData.startId
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,levelId)
local levelName=levelCfg.name

local startTime=trainingData.startTime
local finishTime=trainingData.finishTime
local isWait=false
local isFinish=false
if nowTime<startTime then
widget:SetChildProgressValue(_trainItemCmpIndex.processBar,0,100)
widget:SetChildActive(_trainItemCmpIndex.processText,true)
widget:SetChildActive(_trainItemCmpIndex.tipsText,false)

local deltaTime=finishTime-startTime
widget:SetChildProgressText(_trainItemCmpIndex.processBar,timeHelper.format_time_stamp(deltaTime))

isWait=true
elseif nowTime>=finishTime then
widget:SetChildProgressValue(_trainItemCmpIndex.processBar,100,100)
widget:SetChildActive(_trainItemCmpIndex.processText,false)
widget:SetChildActive(_trainItemCmpIndex.tipsText,true)
widget:SetChildActive(_trainItemCmpIndex.tipsText,true)
widget:SetChildText(_trainItemCmpIndex.tipsText,"已完成")
isFinish=true
hasFinishTrain=true
else
local allTime=finishTime-startTime
local curTime=nowTime-startTime
local precent=curTime/allTime*100
local deltaTime=finishTime-nowTime
widget:SetChildActive(_trainItemCmpIndex.processText,true)
widget:SetChildProgressValue(_trainItemCmpIndex.processBar,precent,100)
widget:SetChildProgressText(_trainItemCmpIndex.processBar,timeHelper.format_time_stamp(deltaTime))
widget:SetChildActive(_trainItemCmpIndex.tipsText,false)
end


local stateStr
local count=trainingData.trainCount
local isxunlian=trainingData.startId==0
if isWait then
if isxunlian then
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n等待训练",count,levelName)
else
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n等待突破",count,levelName)
end
elseif isFinish then
if isxunlian then
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n已完成训练",count,levelName)
else
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n已完成突破",count,levelName)
end
else
if isxunlian then
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n正在训练",count,levelName)
else
stateStr=FMT.fmt("<color=#ca631d><size=22>{0}</size></color>名{1}修士\n正在突破",count,levelName)
end
end
widget:SetChildText(_trainItemCmpIndex.stateText,stateStr)
hasDoingTrain=true
end
end

if not hasDoingTrain then
self:clearTrainTimer()
end

if hasFinishTrain then

yunjiayingController:tryToFinishTrain()
end
end

function UIYunJiaYing_batchWin:refreshRightPanel(isInit)
local levelCfgList=cfg_fairylandsoldierconfig()
local canSelectList={}
local trainingList_lookup={}
for _,v in pairs(self.trainDataList)do
local levelIdx=v.startId==0 and v.targetId or v.startId
trainingList_lookup[levelIdx]=true
end
local count=0
for i,cfg in ipairs(levelCfgList)do
local levelIdx=cfg.id
local isTraining=trainingList_lookup[levelIdx]
if not isTraining then
canSelectList[#canSelectList+1]=levelIdx
end
if not cfg.isHide then
count=count+1
end
end

local trainingData=self.trainDataList[self.selectTrainIndex]
local isCreate=not trainingData
local selectLevelIndex=self.selectLevelIndex
if isCreate then
self.selectLevelIndex=self.selectLevelIndex or self:getDefaultSelectLevelIndex()
selectLevelIndex=self.selectLevelIndex
end
self.initFinishTime=trainingData and trainingData.finishTime or nil


self.soldierCountList={}
self.allMoneyCount=0
local soldierCfgList=cfg_fairylandsoldierconfig()
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

if self.soldierCountList[soldierId]then
self.soldierCountList[soldierId].allCount=self.soldierCountList[soldierId].allCount+hasCount
self.soldierCountList[soldierId].healthCount=self.soldierCountList[soldierId].healthCount+healthCount
self.soldierCountList[soldierId].injuryCount=self.soldierCountList[soldierId].injuryCount+injuryCount
else
self.soldierCountList[soldierId]={
allCount=hasCount,
healthCount=healthCount,
injuryCount=injuryCount,
}
end
end
end
end

self.maxListIndex=count
self.levelScrollView:setChildScrollViewCreateGrids(count,count)
local levelGrids=self.levelScrollView:getChildScrollViewItemWidgets()
for index=1,levelGrids.Count do
local widget=levelGrids[index-1]
local levelIdx=index
local levelCfg=levelCfgList[index]
local isSelect=selectLevelIndex==levelIdx
local isTraining=trainingList_lookup[levelIdx]~=nil
local timeList=self.buildCfg.duration
local isUnlock=timeList[levelCfg.id]~=nil

local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_levelItemCmpIndex.iconBg,iconAb,self.selectCreateTrainType==1 and bgIconName or levelCfg.bgIcon2)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_levelItemCmpIndex.levelNameIcon,iconAb,self.selectCreateTrainType==1 and levelIconName or levelCfg.nameIcon3)


widget:SetChildCSImageSprite(_levelItemCmpIndex.bg,abname,self.selectCreateTrainType==1 and'image_xunlianyingui_1'or'image_tupodiwen_1')


widget:SetChildCSImageSprite(_levelItemCmpIndex.select,abname,self.selectCreateTrainType==1 and'image_xunlianyingui_2'or'image_tupodiwen_2')
widget:SetChildActive(_levelItemCmpIndex.select,isSelect)

widget:SetChildCSImageSprite(_levelItemCmpIndex.lockFlag,abname,self.selectCreateTrainType==1 and'image_xunlianyingui_3'or'image_tupodiwen_3')
widget:SetChildActive(_levelItemCmpIndex.lockFlag,not isUnlock)
self.selectCreateTrainType=self.selectCreateTrainType or 1
local selectCreateTrainType=self.selectCreateTrainType
local num=self.soldierCountList[levelIdx]and self.soldierCountList[levelIdx].healthCount or 0
widget:SetChildText(_levelItemCmpIndex.numText,FMT.fmt("云甲营:{0}",mathHelper.formatNumber4(num,1)))
local xiaoshijienum=yunjiayingModel:getXiuShiNumById(index)
widget:SetChildText(_levelItemCmpIndex.xiaoshijienumText,FMT.fmt("小世界:{0}",mathHelper.formatNumber4(xiaoshijienum,1)))

if isUnlock then
widget:SetChildButtonClick(_levelItemCmpIndex.bg,function()
return self:selectLevel(index)
end,true)
widget:SetChildActive(_levelItemCmpIndex.numText,selectCreateTrainType==2)
widget:SetChildActive(_levelItemCmpIndex.xiaoshijienumText,selectCreateTrainType==1)
else
widget:SetChildButtonClick(_levelItemCmpIndex.bg,function()
local unlockBuildLevel=yunjiayingModel:getSoldierUnlockBuildLevel(levelCfg.id)
if unlockBuildLevel then
return UIManager.error(FMT.fmt("云甲营{0}级解锁",unlockBuildLevel))
else
return UIManager.error("敬请期待")
end
end,true)
widget:SetChildActive(_levelItemCmpIndex.numText,false)
widget:SetChildActive(_levelItemCmpIndex.xiaoshijienumText,false)
end
end


self:refreshRightPanel_infoLayout(nil,isInit)


local titleStr=self.selectCreateTrainType==1 and"批量训练"or"批量突破"
self.title:setText(titleStr)
local titleStr2=self.selectCreateTrainType==1 and"可训练数量："or"可突破数量："
self.titleText:setText(titleStr2)
end

function UIYunJiaYing_batchWin:refreshRightPanel_infoLayout(isUpdate,isInit,isOnlyUpdateSelect)
self.needUpdateInfo=nil
local trainingData=self.trainDataList[self.selectTrainIndex]
if trainingData then
self.costPanel:setActive(false)
self.confirmBtn:setActive(false)

self.cannotTrainTips:setActive(true)
self.cannotTrainTipsText:setText("暂无空闲训练队列")
else

self.speedUpPanel:setActive(false)
self.infoPanel:setActive(false)

local selectCreateTrainType=self.selectCreateTrainType
local panelWidget=self.costPanel:getWidgetBase()


local maxCanHasCount=yunjiayingModel:getMaxCanMakeSoldierCount()
local trainingSoldierCount=yunjiayingModel:getTrainingSoldierCount()

if not isOnlyUpdateSelect then
local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
self.waiPaiAllSoldierCount=waiPaiAllSoldierCount
else
self.waiPaiAllSoldierCount=self.waiPaiAllSoldierCount or 0
end
local remainingCanHasCount=maxCanHasCount-self.allMoneyCount-trainingSoldierCount-self.waiPaiAllSoldierCount
local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()

local soldierCount_health=self.soldierCountList[self.selectLevelIndex]and self.soldierCountList[self.selectLevelIndex].healthCount or 0

local xsjNum=yunjiayingModel:getXiuShiNumById(self.selectLevelIndex)
local maxCount
local isMaxLevel=self.selectLevelIndex==nowMaxLevelIdx
if selectCreateTrainType==selectTrainType.xunlian then









maxCount=math.min(remainingCanHasCount,maxTrainCount,xsjNum)
elseif selectCreateTrainType==selectTrainType.jingjietupo then

maxCount=math.min(maxTrainCount,soldierCount_health)
end
local isCanTrain=maxCount and maxCount>0
if isMaxLevel and selectCreateTrainType==selectTrainType.jingjietupo then
isCanTrain=false
end
self.costPanel:setActive(isCanTrain)
self.cannotTrainTips:setActive(not isCanTrain)
if not isCanTrain then
local tipsStr=""
if selectCreateTrainType==selectTrainType.xunlian then
if remainingCanHasCount<=0 then
tipsStr="云甲营容纳已达上限"
elseif xsjNum<=0 or maxCount<=0 then
tipsStr="小世界现存修士<color=#c82c2c>不足</color>"
end
elseif selectCreateTrainType==selectTrainType.jingjietupo and isMaxLevel then
tipsStr="该等级为当前最高等级，无法进行突破"
elseif selectCreateTrainType==selectTrainType.jingjietupo and soldierCount_health<=0 then
tipsStr="该等级修士可突破数量<color=#c82c2c>不足</color>"
end
self.cannotTrainTipsText:setText(tipsStr)

self.finishBtn:setActive(false)
self.confirmBtn:setActive(false)
self.speedUpBtn:setActive(false)
self.oneKeyBtn:setActive(false)
else
local count=self.trainSelectCount
if self.trainSelectCount then
count=self.trainSelectCount
if count>maxCount then
count=maxCount
end
else
local maxEnoughCount
if selectCreateTrainType==selectTrainType.xunlian then
maxEnoughCount=yunjiayingModel:getTrainMaxEnoughCostCount(0,self.selectLevelIndex)
elseif selectCreateTrainType==selectTrainType.jingjietupo then
maxEnoughCount=yunjiayingModel:getTrainMaxEnoughCostCount(self.selectLevelIndex,nowMaxLevelIdx)
end

count=maxEnoughCount<maxCount and maxEnoughCount or maxCount
if count<=0 then
count=1
end
end

local minCount=1

panelWidget:SetChildActive(_costPanelCmpIndex.clickMask,maxCount<=1)

panelWidget:SetChildInputFieldChange(_costPanelCmpIndex.countInputText,true,function(...)
if not _this then return end
return _this:changeTrainSelectCount(maxCount,...)
end)

local func=function(...)
if not _this then return end
return _this:onTrainSliderChange(...)
end
panelWidget:SetChildSliderInit(_costPanelCmpIndex.selectCntSlider,count,minCount,maxCount,func)
panelWidget:SetChildInputFieldValue(_costPanelCmpIndex.countInputText,count)
panelWidget:SetChildSliderValue(_costPanelCmpIndex.selectCntSlider,count)


panelWidget:SetChildButtonClick(_costPanelCmpIndex.subBtn,function()
if not _this then return end
return _this:onTrainSubBtn()
end,true)
panelWidget:SetChildButtonClick(_costPanelCmpIndex.addBtn,function()
if not _this then return end
return _this:onTrainAddBtn(maxCount)
end,true)

local confirmBtnStr
local needTime
local costList
if selectCreateTrainType==1 then
confirmBtnStr="训练"
needTime=yunjiayingModel:getTrainNeedTime(0,self.selectLevelIndex,count)
costList=yunjiayingModel:getTrainNeedCost(0,self.selectLevelIndex,count,true)
elseif selectCreateTrainType==2 then
confirmBtnStr="突破"
needTime=yunjiayingModel:getTrainNeedTime(self.selectLevelIndex,nowMaxLevelIdx,count)
costList=yunjiayingModel:getTrainNeedCost(self.selectLevelIndex,nowMaxLevelIdx,count,true)
end


panelWidget:SetChildLayoutGroupCreateItems(_costPanelCmpIndex.costItemGroup,#costList)
local grids=panelWidget:GetChildLayoutGroupGridList(_costPanelCmpIndex.costItemGroup)
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

local titleStr=FMT.fmt("修士{0}数量：",confirmBtnStr)
panelWidget:SetChildText(_costPanelCmpIndex.titleText,titleStr)
local titleStr2=FMT.fmt("修士{0}消耗：",confirmBtnStr)
panelWidget:SetChildText(_costPanelCmpIndex.titleText2,titleStr2)


if not self.trainDataList or not next(self.trainDataList)then
self:showFinishBtn(needTime,false)
else
self.finishBtn:setActive(false)
end
self.confirmBtn:setActive(true)
self.speedUpBtn:setActive(false)
self.oneKeyBtn:setActive(false)
self.confirmBtnText:setText(confirmBtnStr)


self.costTimeText:setText(timeHelper.format_time_stamp(needTime))
end
end
end

function UIYunJiaYing_batchWin:setTrainTimer()
self:clearTrainTimer()
local func=function()
if self.needUpdateInfo then
self:refreshRightPanel_infoLayout()
end
return self:refreshLeftPanel_onlyProcess()
end

self.trainTimer=self:setTimer(1,0,func)
end

function UIYunJiaYing_batchWin:clearTrainTimer()
if self.trainTimer then
self:stopTimerByID(self.trainTimer)
self.trainTimer=nil
end
end

function UIYunJiaYing_batchWin:showAddExtraTrainWin()

local args={}
args.titleName="训练拓展"
args.pos=2
args.extraWin='UIYunJiaYing_extraAddWin'
args.showClose=false
self:showWindow('UICommonPageWin',args)

end

function UIYunJiaYing_batchWin:changeSelectCreateTrainType(selectType)
if not selectType or self.selectCreateTrainType==selectType then
return
end

self.selectCreateTrainType=selectType
self.trainSelectCount=nil
self.selectItemCount=nil
local widget=self.trainListScrollView:getChildScrollViewItemWidget(self.selectTrainIndex-1)
local selectCreateTrainType=self.selectCreateTrainType
widget:SetChildActive(_trainItemCmpIndex.trainBtnSelect,selectCreateTrainType==1)
widget:SetChildActive(_trainItemCmpIndex.breakBtnSelect,selectCreateTrainType==2)

self:refreshRightPanel(true)
end

function UIYunJiaYing_batchWin:getSortSpeedUpItemList(isReset)
if not isReset and self.speedUpItemList and next(self.speedUpItemList)then
return self.speedUpItemList
end

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local itemList={}
for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local itemCount=itemsModel.getCount(itemId)
local canUseBuildList=v[4]
local isCanUse=false
local isOnly
if not canUseBuildList or canUseBuildList[SLG_SYSTEM_TYPE.eYunJiaYing]then
isCanUse=true
isOnly=true
for buildId,_ in pairs(canUseBuildList)do
if buildId~=SLG_SYSTEM_TYPE.eYunJiaYing then
isOnly=false
break
end
end
end
if isCanUse and itemCount>0 then
itemList[#itemList+1]={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
isOnly=isOnly,
}
end
end

if next(itemList)then
table.sort(itemList,function(a,b)
local isOnly_a=a.isOnly and 100 or 0
local isOnly_b=b.isOnly and 100 or 0

if isOnly_a==isOnly_b then
if a.itemColor==b.itemColor then
if a.speedUpTime==b.speedUpTime then
return a.itemId<b.itemId
else
return a.speedUpTime<b.speedUpTime
end
else
return a.itemColor<b.itemColor
end
else
return isOnly_a>isOnly_b
end
end)
end

self.speedUpItemList=itemList
return self.speedUpItemList
end

function UIYunJiaYing_batchWin:getSpeedUpAllTime()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local item=speedUpItemList[self.selectSpeedItemIndex]
local speedUpTime=item and item.speedUpTime*self.selectItemCount or 0

return speedUpTime
end

function UIYunJiaYing_batchWin:getMaxItemSelectCount()
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local selectItem=speedUpItemList[self.selectSpeedItemIndex]
if not selectItem then
return 0
end
local singleTime=selectItem.speedUpTime
local count=math.ceil(remainingTime/singleTime)
return count
end

function UIYunJiaYing_batchWin:selectSpeedUpItem(index)
if index==self.selectSpeedItemIndex then
return
end
self.selectSpeedItemIndex=index
self.selectItemCount=nil
return self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:selectLevel(index)
if index==self.selectLevelIndex then
return
end
self.selectLevelIndex=index
self.selectItemCount=nil
self.trainSelectCount=nil
self.speedUpItemList=nil
self.selectSpeedItemIndex=nil
return self:refreshRightPanel(true)
end

function UIYunJiaYing_batchWin:changeSpeedUpSelectCount(str)

local count=tonumber(str)

local originalCount=self.selectItemCount or self.minSelectCount
local isNeedReset=false
if count==nil then

count=self.minSelectCount
isNeedReset=true
elseif count==originalCount then

return
elseif count<self.minSelectCount then

count=self.minSelectCount
isNeedReset=true
elseif count>self.maxSelectCount then

count=self.maxSelectCount
isNeedReset=true
end

if isNeedReset then
local panelWidget=self.speedUpPanel:getWidgetBase()
panelWidget:SetChildInputFieldValue(_speedUpPanelCmpIndex.countInputText,count)
return
end

if self.selectItemCount==count then
return
end

self.selectItemCount=count
return self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:onSpeedUpSliderChange(value)
if not value then return end
if self.selectItemCount==value then return end

self.selectItemCount=value
return self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:changeTrainSelectCount(maxCount,str)

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
local panelWidget=self.costPanel:getWidgetBase()
panelWidget:SetChildInputFieldValue(_costPanelCmpIndex.countInputText,count)
return
end

if self.trainSelectCount==count then
return
end


self.trainSelectCount=count
self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:onTrainSliderChange(value)
if not value then
return
end

if self.trainSelectCount==value then
return
end


self.trainSelectCount=value

self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:getMinSpeedUpItem()
if self.minSpeedUpItem and next(self.minSpeedUpItem)then
return self.minSpeedUpItem
end

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local minSpeedUpItem
local checkFunc=function(a,b)
local isOnly_a=a.isOnly and 100 or 0
local isOnly_b=b.isOnly and 100 or 0

if isOnly_a==isOnly_b then
if a.speedUpTime==b.speedUpTime then
if a.itemColor==b.itemColor then
return a.itemId<b.itemId
else
return a.itemColor<b.itemColor
end
else
return a.speedUpTime<b.speedUpTime
end
else
return isOnly_a>isOnly_b
end
end

for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local canUseBuildList=v[4]
local isCanUse=false
local isOnly
if not canUseBuildList or canUseBuildList[SLG_SYSTEM_TYPE.eYunJiaYing]then
isCanUse=true
isOnly=true
for buildId,_ in pairs(canUseBuildList)do
if buildId~=SLG_SYSTEM_TYPE.eYunJiaYing then
isOnly=false
break
end
end
end
if isCanUse then
local item={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
isOnly=isOnly,
}
if not minSpeedUpItem or checkFunc(item,minSpeedUpItem)then
minSpeedUpItem=item
end
end
end

self.minSpeedUpItem=minSpeedUpItem
return self.minSpeedUpItem
end

function UIYunJiaYing_batchWin:getScrollViewPosIndex(posX,isLeft)
local leftOffset=12
local rightOffset=24
local itemWeight=215
local itemSpace=0
local offset=50
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

function UIYunJiaYing_batchWin:refreshArrowBtn()
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

function UIYunJiaYing_batchWin:jumpItem(index,animation,alignEnd)
local jumpIndex=index
if jumpIndex<=1 then
jumpIndex=0
elseif jumpIndex>=self.maxListIndex then
jumpIndex=self.maxListIndex+1
end
self.levelScrollView:setChildScrollViewSelectItem(jumpIndex-1,animation or false,false,alignEnd or false)
end

function UIYunJiaYing_batchWin:setUpdateTimer()
self:clearUpdateTimer()
self.updateTimer=self:setTimer(0.1,0,function()self:onUpdate()end)

self:onUpdate()
end

function UIYunJiaYing_batchWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end



function UIYunJiaYing_batchWin:showFinishBtn(needTime,needStart)

local spcfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_allow',speedUpType.eYunJiaYingTrain)or{}
if spcfg[speedUpMode.eMoneyBuilding]then
self.finishBtn:setActive(false)
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
if not needStart then
self.needUpdateInfo=true
end
else

self.finishBtn:setActive(false)
end
else

self.finishBtn:setActive(false)
end
end

function UIYunJiaYing_batchWin:checkConfirm()
local maxCanHasCount=yunjiayingModel:getMaxCanMakeSoldierCount()
local trainingSoldierCount=yunjiayingModel:getTrainingSoldierCount()

local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
local remainingCanHasCount=maxCanHasCount-self.allMoneyCount-trainingSoldierCount-waiPaiAllSoldierCount
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()

local soldierCount_health=self.soldierCountList[self.selectLevelIndex]and self.soldierCountList[self.selectLevelIndex].healthCount or 0
local xsjNum=yunjiayingModel:getXsjSoldierCount()
local maxCount
if self.selectCreateTrainType==1 then
maxCount=math.min(remainingCanHasCount,maxTrainCount,xsjNum)
elseif self.selectCreateTrainType==2 then
maxCount=math.min(maxTrainCount,soldierCount_health)
end
local isCanTrain=maxCount and maxCount>0
if not isCanTrain then
local tipsStr=""
if self.selectCreateTrainType==1 then
if remainingCanHasCount<=0 then
tipsStr="云甲营容纳已达上限"
elseif xsjNum<=0 then
tipsStr="小世界现存修士不足"
end
elseif self.selectCreateTrainType==2 and soldierCount_health<=0 then
tipsStr="该等级修士可突破数量不足"
end
UIManager.error(tipsStr)
return false
end

local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local startLevelIdx
local targetLevelIdx=self.selectLevelIndex
local trainCount=self.trainSelectCount
if self.selectCreateTrainType==1 then
startLevelIdx=0
targetLevelIdx=self.selectLevelIndex
elseif self.selectCreateTrainType==2 then
startLevelIdx=self.selectLevelIndex
targetLevelIdx=nowMaxLevelIdx
end

local costList=yunjiayingModel:getTrainNeedCost(startLevelIdx,targetLevelIdx,self.trainSelectCount)
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

function UIYunJiaYing_batchWin:getDefaultSelectSpeedUpItemIndex()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local defaultIndex
local selectItemTime
for i,v in ipairs(speedUpItemList)do
if not selectItemTime or v.speedUpTime>selectItemTime then
if v.speedUpTime<remainingTime then
defaultIndex=i
selectItemTime=v.speedUpTime
else
break
end
end
end
if not defaultIndex then
defaultIndex=1
end
return defaultIndex
end

function UIYunJiaYing_batchWin:getDefaultSelectLevelIndex()
local defaultIndex
if self.selectCreateTrainType==1 then

defaultIndex=yunjiayingModel:getTrainMaxBreakLevel()
elseif self.selectCreateTrainType==2 then

defaultIndex=yunjiayingModel:getTrainMinCanBreakLevel(self.bdData.level)
end

return defaultIndex
end

function UIYunJiaYing_batchWin.on_building_event(etype,sfId,ubdId)
if not _this then return end
if etype==buildingEvent.speedUpComplete and sfId==mapIdType.fort and ubdId==_this.un_build_id then
return _this:onSpeedUpRecv()
end
end

function UIYunJiaYing_batchWin:onSpeedUpRecv()
self.speedUpItemList=nil
self.selectItemCount=nil
self.selectSpeedItemIndex=nil
self:refresh()
end

function UIYunJiaYing_batchWin:refreshRulePart(ruleName)
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




function UIYunJiaYing_batchWin:onMask()
self:onCloseBtn()
end



function UIYunJiaYing_batchWin:onCloseBtn()
self:closeSelf()
end



function UIYunJiaYing_batchWin:onFinishBtn()

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

local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local startLevelIdx
local targetLevelIdx=self.selectLevelIndex
local trainCount=self.trainSelectCount
if self.selectCreateTrainType==1 then
startLevelIdx=0
targetLevelIdx=self.selectLevelIndex
elseif self.selectCreateTrainType==2 then
startLevelIdx=self.selectLevelIndex
targetLevelIdx=nowMaxLevelIdx
end


local moneyType=self.finishBtnCost[1]
local moneyCount=self.finishBtnCost[2]
local moneyName=moneyModel.getMoneyName(moneyType)
local ubdId=self.un_build_id
local content=FMT.fmt("是否花费<color=#549327>{0}</color>{1}\n立即完成这批修士的训练",mathHelper.formatNumber(moneyCount),moneyName)
local okCallback=function()
moneySystem:useMoney(moneyType,moneyCount,function()

return yunjiayingController:reqFastFinishTrain(ubdId,startLevelIdx,targetLevelIdx,trainCount,{moneyType,moneyCount},needStart)
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



function UIYunJiaYing_batchWin:onConfirmBtn()
local trainingData=self.trainDataList[self.selectTrainIndex]
if trainingData then

local levelIdx=trainingData.startId==0 and trainingData.targetId or trainingData.startId
self:onCancelBtnClick(trainingData.idx,levelIdx)
else


if self.bdData.flag==buildingStateType.eUpgrading then
local str=""
if self.selectCreateTrainType==1 then
str="新增训练"
elseif self.selectCreateTrainType==2 then
str="新增突破"
end
UIManager.error(FMT.fmt("云甲营正在升级中，暂时无法{0}",str))
return
end

if not self:checkConfirm()then
return
end

local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local startLevelIdx
local targetLevelIdx=self.selectLevelIndex
local trainCount=self.trainSelectCount
if self.selectCreateTrainType==1 then
startLevelIdx=0
targetLevelIdx=self.selectLevelIndex
elseif self.selectCreateTrainType==2 then
startLevelIdx=self.selectLevelIndex
targetLevelIdx=nowMaxLevelIdx
end

local trainList={{startLevelIdx,targetLevelIdx,trainCount}}
yunjiayingController:reqStartTrain(trainList)
end
end



function UIYunJiaYing_batchWin:onSpeedUpBtn()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local item=speedUpItemList[self.selectSpeedItemIndex]
local itemCount=1
local itemId=item.itemId
local ubdId=self.un_build_id
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,speedUpType.eYunJiaYingTrain,mapIdType.fort,0,{{ubdId,itemCount,itemId}})
end


function UIYunJiaYing_batchWin:newSpeedUpBtn()

if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法加速")
return
end
local trainingData=self.trainDataList[1]
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



function UIYunJiaYing_batchWin:onOneKeyBtn()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local itemList={}
local itemIdxList_lookup={}
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=itemsModel.getCount(itemId)
local speedUpTime=v.speedUpTime
local price=v.isOnly and 100 or 0
if itemCount>0 then
itemList[#itemList+1]={itemId,itemCount,speedUpTime,price}
itemIdxList_lookup[itemId]=i
end
end
local selectList_lookup=zongmenControl:getSpeedUpItemAutoSelectList(itemList,remainingTime)
local selectList={}
local speedUpAllTime=0
local useList={}
local ubdId=self.un_build_id
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=selectList_lookup[itemId]
if itemCount and itemCount>0 then
local speedUpTime=v.speedUpTime
selectList[#selectList+1]={itemId,itemCount,speedUpTime}
useList[#useList+1]={ubdId,itemCount,itemId}
speedUpAllTime=speedUpAllTime+speedUpTime*itemCount
end
end

if not next(selectList)then

local item=speedUpItemList[1]
local itemId=item.itemId
local itemCount=1
local speedUpTime=item.speedUpTime
selectList[#selectList+1]={itemId,itemCount,speedUpTime}
useList[#useList+1]={ubdId,itemCount,itemId}
speedUpAllTime=speedUpAllTime+speedUpTime*itemCount
end

local selectItemList=selectList
local showPage=2

local trainingData=self.trainDataList[self.selectTrainIndex]
if trainingData then
local startTime,finishTime=yunjiayingModel:getTrainingDataTimeByIdx(trainingData.idx)
local args={}
args.titleName="修士训练加速"
args.pos=2
args.extraWin='UIXJBuildingSpeedUpWin'
local ubdId=self.un_build_id
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
showPage=showPage,
selectItemList=selectItemList,
useList=useList,
speedUpAllTime=speedUpAllTime,
un_build_id=ubdId,
build_id=SLG_SYSTEM_TYPE.eYunJiaYing,
speedType=speedUpType.eYunJiaYingTrain,
finishTime=finishTime,
initFinishTimeFunc=initFinishTimeFunc,
tipsText="训练",
backImg={"ui/windows/yunjiaying/yunjiaying_atlas_pak.ab","image_xunlianjiasu_1"}
}
args.showClose=false
self:showWindow('UIXJBuildingPageBgWin',args)
end
end


function UIYunJiaYing_batchWin:onClickTrainItem(clickNum,i)
local index=i+1


local isUnlock=index<=self.unlockListCount
if not isUnlock then

return self:buyExtraTrainCount()












end
end

function UIYunJiaYing_batchWin:onCancelBtnClick(trainIdx,levelIdx)
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

local trainingData=yunjiayingModel:getTrainDataByTrainDataIdx(trainIdx,levelIdx)
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

function UIYunJiaYing_batchWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIYunJiaYing_batchWin:onSpeedUpSubBtn()
if self.selectItemCount<=self.minSelectCount then
return
end

self.selectItemCount=self.selectItemCount-1
if self.selectItemCount<self.minSelectCount then
self.selectItemCount=self.minSelectCount
end
self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:onSpeedUpAddBtn()
if self.selectItemCount>=self.maxSelectCount then
return
end

self.selectItemCount=self.selectItemCount+1
if self.selectItemCount>self.maxSelectCount then
self.selectItemCount=self.maxSelectCount
end
self:refreshRightPanel_infoLayout(nil,nil,true)
end


function UIYunJiaYing_batchWin:onTrainSubBtn()
if self.trainSelectCount<=1 then
return
end

self.trainSelectCount=self.trainSelectCount-1
if self.trainSelectCount<1 then
self.trainSelectCount=1
end
self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:onTrainAddBtn(maxCount)
if self.trainSelectCount>=maxCount then
return
end

self.trainSelectCount=self.trainSelectCount+1
if self.trainSelectCount>maxCount then
self.trainSelectCount=maxCount
end
self:refreshRightPanel_infoLayout(nil,nil,true)
end

function UIYunJiaYing_batchWin:onClickNotItem()
local item=self:getMinSpeedUpItem()
local itemId=item.itemId
gainControl:showGainWin(itemId)
end

function UIYunJiaYing_batchWin:onArrowLeftBtn()
if not self.pageShowItemIdx_left then
return
end

self:jumpItem(self.pageShowItemIdx_left,true)
end

function UIYunJiaYing_batchWin:onArrowRightBtn()
if not self.pageShowItemIdx_right then
return
end

self:jumpItem(self.pageShowItemIdx_right,true,true)
end



function UIYunJiaYing_batchWin:RefreshSelect(first)
local selectCreateTrainType=self.selectCreateTrainType
self.selectTrainIndex=yunjiayingModel:getFreeTrainIndex()
self.trainBtnSelect:setActive(selectCreateTrainType==1)
self.breakBtnSelect:setActive(selectCreateTrainType==2)
self:changeSelectCreateTrainType(self.selectCreateTrainType)
if not first then
self.selectLevelIndex=self:getDefaultSelectLevelIndex()
self:refreshRightPanel(false)
self:jumpItem(self.selectLevelIndex,false,true)
end
end


function UIYunJiaYing_batchWin:onTrainBtn(first)
self.selectCreateTrainType=1
self.trainSelectCount=nil
self:RefreshSelect(first)
end
function UIYunJiaYing_batchWin:onBreakBtn()
self.selectCreateTrainType=2
self.trainSelectCount=nil
self:RefreshSelect()
end

function UIYunJiaYing_batchWin:buyExtraTrainCount()

local moneyList=cfgHelper.getdef(cfg_yunjiayingconfig,'money')or{}
local moneyNum=yunjiayingModel:getMoneyNum()or 0
local price=moneyList[moneyNum+1]
if not price then
logErr(FMT.fmt("找不到货币购买类型第{0}次对应的消耗配置",moneyNum))
return
end
local priceMoneyType=price[1][1]
local priceMoneyCount=price[1][2]
local moneyName=moneyModel.getMoneyName(priceMoneyType)
local content=FMT.fmt("是否花费<color=#549327>{0}</color>{1}\n永久解锁1个训练计划栏",mathHelper.formatNumber(priceMoneyCount),moneyName)
local okCallback=function()
moneySystem:useMoney(priceMoneyType,priceMoneyCount,function()
yunjiayingController:reqBuyExtraTrainCountByMoney(1)
UIManager:closeWindow('UICommonPageWin')
end,WARNING_TYPE.eWarning)
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
moneytypes={{priceMoneyType}},
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIYunJiaYing_batchWin:onHelpBtn()
local ruleName="yunjiaying_batch_help_%d"
self:refreshRulePart(ruleName)
self.rulePart:setActive(true)
self.ruleMask:setActive(true)
end

function UIYunJiaYing_batchWin:onRuleMask()
self.rulePart:setActive(false)
self.ruleMask:setActive(false)
end






function UIYunJiaYing_batchWin:onOnekeyAllBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法加速")
return
end

local finishTime=yunjiayingModel:getAllTrainFinalFinishTime()
if finishTime<=0 then
return
end

local args={}
args.titleName="批量加速"
args.pos=2
args.extraWin='UIXJBuildingSpeedUpWin'
local ubdId=self.bdData.un_build_id

local initFinishTimeFunc=function()
local finishTime=yunjiayingModel:getAllTrainFinalFinishTime()
if not finishTime then
finishTime=0
end
return finishTime
end
args.extraParams={

un_build_id=ubdId,
build_id=SLG_SYSTEM_TYPE.eYunJiaYing,
speedType=speedUpType.eYunJiaYingTrain,
finishTime=finishTime,

initFinishTimeFunc=initFinishTimeFunc,
tipsText="总训练",

XJSpeedUp=REPEAT_TYPE.eXJJunJiaYingSpeedUp,
backImg={"ui/windows/yunjiaying/yunjiaying_atlas_pak.ab","image_xunlianjiasu_1"},
}
args.showClose=false
self:showWindow('UIXJBuildingPageBgWin',args)
end
