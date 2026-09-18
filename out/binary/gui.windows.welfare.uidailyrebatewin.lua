







def_class("UIDailyRebateWin",UIWindowBase)









function UIDailyRebateWin:bindComponents()

self.showItemPanel=UIObject.get(self,0)
self.itemModel=UIObject.get(self,1)
self.itemClick=UIButton.get(self,2)
self.infoBtn=UIButton.get(self,3)
self.progressRewardScrollView=UIObject.get(self,4)
self.progressContent=UIObject.get(self,5)
self.progressBar=UIProgress.get(self,6)
self.rechargeCount=UIText.get(self,7)
self.goalScroller=UIObject.get(self,8)
self.goalTypeScrollView=UIObject.get(self,9)
self.dailyRewardBtn=UIButton.get(self,10)
self.dailyRewardReddot=UIObject.get(self,11)
self.itemImg=UIImage.get(self,12)
self.itemEffect=UIObject.get(self,13)
self.itemEffectBg=UIObject.get(self,14)
self.zuShiModel1=UIObject.get(self,15)
self.zuShiModel2=UIObject.get(self,16)
self.bubbleframeRoot=UIImage.get(self,17)
self.bubbleModel=UIObject.get(self,18)
self.headKuang=UIImage.get(self,19)
self.emotRoot=UIObject.get(self,20)
self.emoticon=UIImage.get(self,21)
self.showItemPos=UIObject.get(self,22)
self.showADImg=UIImage.get(self,23)
self.showItemNeedDay=UIText.get(self,24)
self.dailyRewardBtnOpen=UIObject.get(self,25)
self.showItemName=UIText.get(self,26)
self.progressValue=UIObject.get(self,27)
self.bgModel=UIObject.get(self,28)
self.modelMao=UIObject.get(self,29)

self.itemClick:setButtonClick(function()self:onItemClick()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.dailyRewardBtn:setButtonClick(function()self:onDailyRewardBtn()end)



end


function UIDailyRebateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.showItemPanel);self.showItemPanel=nil;
_UIObject_release(self.itemModel);self.itemModel=nil;
_UIObject_release(self.itemClick);self.itemClick=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rechargeCount);self.rechargeCount=nil;
_UIObject_release(self.goalScroller);self.goalScroller=nil;
_UIObject_release(self.goalTypeScrollView);self.goalTypeScrollView=nil;
_UIObject_release(self.dailyRewardBtn);self.dailyRewardBtn=nil;
_UIObject_release(self.dailyRewardReddot);self.dailyRewardReddot=nil;
_UIObject_release(self.itemImg);self.itemImg=nil;
_UIObject_release(self.itemEffect);self.itemEffect=nil;
_UIObject_release(self.itemEffectBg);self.itemEffectBg=nil;
_UIObject_release(self.zuShiModel1);self.zuShiModel1=nil;
_UIObject_release(self.zuShiModel2);self.zuShiModel2=nil;
_UIObject_release(self.bubbleframeRoot);self.bubbleframeRoot=nil;
_UIObject_release(self.bubbleModel);self.bubbleModel=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.emotRoot);self.emotRoot=nil;
_UIObject_release(self.emoticon);self.emoticon=nil;
_UIObject_release(self.showItemPos);self.showItemPos=nil;
_UIObject_release(self.showADImg);self.showADImg=nil;
_UIObject_release(self.showItemNeedDay);self.showItemNeedDay=nil;
_UIObject_release(self.dailyRewardBtnOpen);self.dailyRewardBtnOpen=nil;
_UIObject_release(self.showItemName);self.showItemName=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
end
















local goalTypeItemIndex={
bg=0,
name=1,
unSelectMask=2,
reddot=3,
selectEffModel=4,
cnyImage=5,
XyImage=6,
}

local goalItemIndex={
titleText=0,
rewards=1,
getRewardBtn=2,
gotFlag=3,
gotoBtn=4,
todayRechargeText=5,
}

local progressRewardItemIndex={
item=0,
gotFlag=1,
click=2,
dayText=3,
select=4,
}

local _daoBingBgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}



function UIDailyRebateWin:onLoaded(...)
self:bindComponents()

self.goalTypeScrollView:setChildScrollViewInit(1,true,nil,nil)
self.goalScroller:setChildScrollViewInit(0,true,nil,nil)
end


function UIDailyRebateWin:__delete()
self:clearShowItemModel()
self:unbindComponents()
end




function UIDailyRebateWin:onShow(argtable,afterOnloaded)
self.initSelectGoalTypeIndex=1
self.selectGoalTypeIndex=nil

if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(4866,1,{},eAnimationID.stand)
self.modelMao:setChildUIModelShowTarget(4867,1,{},eAnimationID.enter)
end

self:refresh(true,true,true)
end


function UIDailyRebateWin:onShowArgRecv()
self.modelMao:setChildUIModelShowTarget(4867,1,{},eAnimationID.enter)
self:refresh(nil,true,true,nil,true)
end


function UIDailyRebateWin:onHide()
self:clearShowItemModel()
self.progressRewardScrollView:setActive(false)
end

function UIDailyRebateWin:refresh(isInit,isNeedRefreshShowModel,isResetListPos,isResetGoalListSort,isSelectReddotGTidx)
if isInit then

self:initCfgList_sort()
end

if not self.goalTypeCfgList or not next(self.goalTypeCfgList)then

UIManager.error("天天返利活动已结束")
return UIFullWelfareController:closeUI()
end

if isInit or isSelectReddotGTidx then

if isSelectReddotGTidx then
self.initSelectGoalTypeIndex=self.selectGoalTypeIndex
self.selectGoalTypeIndex=nil
end
for i,gtCfg in ipairs(self.goalTypeCfgList)do
local gradeId=gtCfg.gradeId
local reddot=welfareModel:checkDailyRebateGradeReddot(gradeId)
if reddot then
self.initSelectGoalTypeIndex=i
break
end
end
if not self.selectGoalTypeIndex or not self.goalTypeCfgList[self.selectGoalTypeIndex]then
self.selectGoalTypeIndex=self.initSelectGoalTypeIndex
end
end


self:refreshGoalTypePanel()


self:refreshGoalListPanel(isResetListPos,isResetGoalListSort)


self:refreshProgressPanel(isResetListPos)

if isNeedRefreshShowModel then

self:refreshShowModel()
end


self:refreshDailyRewardBtn()
end

function UIDailyRebateWin:initCfgList_sort()

local data=welfareModel:getDailyRebateData()or{}
self.goalTypeCfgList={}
for gradeId,v in pairs(data)do
local isOpen=welfareModel:checkDailyRebateGradeIsOpen(gradeId)
if isOpen then
local goalTypeCfg=cfgHelper.get1(cfg_tiantianfanlidangciactconfig_get,gradeId)
if goalTypeCfg then
local cfgItem={}
cfgItem.gradeId=gradeId

cfgItem.minRecharge=pfwindowsModel:getVersionAndPfCfg(goalTypeCfg.cznum)
cfgItem.sortId=goalTypeCfg.sortId
local roundIndex=v.roundIndex
local roundId=goalTypeCfg.lunci[roundIndex]
cfgItem.roundId=roundId
cfgItem.btnImageName=goalTypeCfg.btnImageName
cfgItem.firstRechargeId=goalTypeCfg.firstRechargeId

local allLevelTaskCfgList_lookup=cfgHelper.get2(cfg_tiantianfanlilunciactconfig_get,roundId,'czlist')
local allLevelTaskCfgList={}
for targetDay,rewardCfg in pairs(allLevelTaskCfgList_lookup)do
local taskCfgItem={}
taskCfgItem.targetDay=targetDay
taskCfgItem.rewardCfgList=rewardCfg
table.insert(allLevelTaskCfgList,taskCfgItem)
end
table.sort(allLevelTaskCfgList,function(a,b)
return a.targetDay<b.targetDay
end)
cfgItem.allLevelTaskCfgList=allLevelTaskCfgList

local showModelParamsCfgList=cfgHelper.get2(cfg_tiantianfanlilunciactconfig_get,roundId,'showItemModelParams')
cfgItem.showModelParamsCfgList=showModelParamsCfgList
table.insert(self.goalTypeCfgList,cfgItem)
end
end
end
table.sort(self.goalTypeCfgList,function(a,b)
return a.sortId<b.sortId
end)
end


function UIDailyRebateWin:refreshGoalTypePanel()
local typeCount=#self.goalTypeCfgList
self.goalTypeScrollView:setChildScrollViewCreateGrids(typeCount,0)
local grids=self.goalTypeScrollView:getChildScrollViewItemWidgets()
local isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
for i=1,grids.Count do
local itemIndex=typeCount-i
local item=grids[itemIndex]

local gtCfg=self.goalTypeCfgList[i]
local gradeId=gtCfg.gradeId
local isSelect=self.selectGoalTypeIndex==i
local firstRechargeIdList=gtCfg.firstRechargeId
local showMoneyRechargeId=firstRechargeIdList[1]
local rechargecfg=cfg_rechargeconfig_get(showMoneyRechargeId)
local str=pfwindowslController:showDescFive_ByMoneyType(rechargecfg)
if not isGuoFu then
item:SetChildActive(goalTypeItemIndex.XyImage,true)
item:SetChildActive(goalTypeItemIndex.cnyImage,false)
if pfwindowslController:checkIsGameVersion_yuenan()then
str=str/1000
end
end
item:SetChildText(goalTypeItemIndex.name,str)

item:SetChildActive(goalTypeItemIndex.unSelectMask,not isSelect)

if gtCfg.btnImageName then
local abName="ui/windows/welfare/welfare_dailyrebate_atlas_pak.ab"
item:SetChildCSImageSprite(goalTypeItemIndex.bg,abName,gtCfg.btnImageName)
item:SetChildCSImageSprite(goalTypeItemIndex.unSelectMask,abName,gtCfg.btnImageName)
end








item:SetChildActive(goalTypeItemIndex.selectEffModel,isSelect)


local reddot=welfareModel:checkDailyRebateGradeReddot(gradeId)
item:SetChildActive(goalTypeItemIndex.reddot,reddot)


item:SetChildButtonClick(goalTypeItemIndex.bg,function()
self:selectGoalType(i)
end)
end


self.goalTypeScrollView:setActive(typeCount>1)
end

function UIDailyRebateWin:selectGoalType(goalTypeIndex)
if self.selectGoalTypeIndex==goalTypeIndex then
return
end

self.selectGoalTypeIndex=goalTypeIndex
self:refresh(nil,true,true)
end

function UIDailyRebateWin:refreshGoalListPanel(isResetListPos,isResetGoalListSort)
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
if not goalTypeCfg then
return
end
local gradeId=goalTypeCfg.gradeId

local taskCfgList=self:getSortTaskCfgList(isResetGoalListSort)

local taskCount=#taskCfgList
local rechargeDay=welfareModel:getDailyRebateRechargeDay(gradeId)
local maxGotDay=welfareModel:getDailyRebateMaxGotDay(gradeId)

self.goalScroller:setChildScrollViewCreateGrids(taskCount,0)
if isResetListPos then
self.goalScroller:setChildScrollRectEnable(false)
self.goalScroller:setChildScrollViewSelectItem(0,false,false,false)
self.goalScroller:setChildScrollRectEnable(true)
end
local grids=self.goalScroller:getChildScrollViewItemWidgets()
local isHasShowTodayChargeIndex=false
for i=1,grids.Count do
local widget=grids[i-1]
local taskCfg=taskCfgList[i]
local targetRechargeCount=taskCfg.targetDay


local firstRechargeIdList=goalTypeCfg.firstRechargeId
local showMoneyRechargeId=firstRechargeIdList[1]
local rechargecfg=cfg_rechargeconfig_get(showMoneyRechargeId)
local str=pfwindowslController:showDescTwo_ByMoneyType(targetRechargeCount,rechargecfg)
widget:SetChildText(goalItemIndex.titleText,str)


local rewardZmLevel=welfareModel:getDailyRebateOpenActZmLevel(gradeId)or 0
if rewardZmLevel<=0 then
rewardZmLevel=zongmenModel:getLevel()
end

local rewards=self:getRewardByZmLevel(taskCfg.rewardCfgList,rewardZmLevel)or{}
widget:SetChildLayoutGroupCreateItems(goalItemIndex.rewards,#rewards)
local rwGrids=widget:GetChildLayoutGroupGridList(goalItemIndex.rewards)
for i=1,#rewards do
local rwWidget=rwGrids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward.showCount or reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local isFinish=rechargeDay>=targetRechargeCount or false
local isGot=maxGotDay>=targetRechargeCount or false

widget:SetChildActive(goalItemIndex.getRewardBtn,isFinish and not isGot)
widget:SetChildActive(goalItemIndex.gotoBtn,not isFinish and not isGot)
local isShowTodayCharge=false

local dailyRecharge=rechargeModel:getDailyRecharge()
if not isHasShowTodayChargeIndex and not isFinish and not isGot then
isShowTodayCharge=true
end
if isShowTodayCharge then
if dailyRecharge<goalTypeCfg.minRecharge then
local xianYuan=dailyRecharge/10
local str=pfwindowslController:showDescThree_ByMoneyType(xianYuan)
widget:SetChildText(goalItemIndex.todayRechargeText,str)
else
widget:SetChildText(goalItemIndex.todayRechargeText,"明日累充可领")
end
isHasShowTodayChargeIndex=true
end
widget:SetChildActive(goalItemIndex.todayRechargeText,isShowTodayCharge)

widget:SetChildButtonClick(goalItemIndex.getRewardBtn,function()
self:getGoalReward(gradeId)
end)
widget:SetChildButtonClick(goalItemIndex.gotoBtn,function()
self:onClickGotoBtn()
end)


widget:SetChildActive(goalItemIndex.gotFlag,isGot)
end
end

function UIDailyRebateWin:getRewardByZmLevel(rewardCfg,zmLevel)
for i,v in ipairs(rewardCfg)do
local minLv=v[1]
local maxLv=v[2]
local reward=v[3]
if zmLevel>=minLv and zmLevel<=maxLv then
return reward
end
end
end

function UIDailyRebateWin:refreshProgressPanel(isNeedJump)
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local gradeId=goalTypeCfg.gradeId
local showRewardCfgList=self:getShowRewardCfgList()
local showRewardCount=#showRewardCfgList
local rechargeDay=welfareModel:getDailyRebateRechargeDay(gradeId)
local maxGotDay=welfareModel:getDailyRebateMaxGotDay(gradeId)

self.progressRewardScrollView:setChildScrollViewCreateGrids(showRewardCount,showRewardCount)
local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
self.progressRewardScrollView:setActive(true)
local finalFinishIdx=0
for i=1,grids.Count do
local progressRewardItem=grids[i-1]
local cfg=showRewardCfgList[i]
if cfg then
local targetRechargeCount=cfg.targetRechargeCount
local reward=cfg.reward
local isGot=maxGotDay>=targetRechargeCount or false
local isFinish=rechargeDay>=targetRechargeCount or false

progressRewardItem:SetChildText(progressRewardItemIndex.dayText,FMT.fmt("{0}天",targetRechargeCount))

progressRewardItem:SetChildActive(progressRewardItemIndex.gotFlag,isGot)


progressRewardItem:SetChildActive(progressRewardItemIndex.select,false)

local rewardItem=progressRewardItem:GetChildWidgetBase(progressRewardItemIndex.item)
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf
local grayNum=isGot and 1 or 0
local colorEffect=not isGot and reward.isShowEff==1 or false
conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,gray=grayNum,colorEffect=colorEffect,showStage=true}

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildActive(-1,true)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)

if isFinish and i>finalFinishIdx then
finalFinishIdx=i
end
end
end
if isNeedJump then
local jumpIndex=finalFinishIdx
if jumpIndex<0 then
jumpIndex=0
end
self.progressRewardScrollView:setChildScrollRectEnable(false)
self.progressRewardScrollView:setChildScrollViewSelectItem(jumpIndex-1,false,false,false)
self.progressRewardScrollView:setChildScrollRectEnable(true)
end


local progressValueWidth=self.progressValue:getChildRectWidth()
local ignoreWidth=515
local invalidPercent_front=ignoreWidth/progressValueWidth
local ignoreWidth_singleItem=66
local nowRechargeCount=rechargeDay or 0
local nowValue=0
local allCount=#showRewardCfgList
local invalidPercent_allItem=(ignoreWidth_singleItem*allCount)/progressValueWidth
local validParecent=1-invalidPercent_front-invalidPercent_allItem
local lastTargetCount=0
local finishCount=0
for i,v in ipairs(showRewardCfgList)do
local targetRechargeCount=v.targetRechargeCount
if nowRechargeCount>=targetRechargeCount then
nowValue=nowValue+1/allCount
finishCount=finishCount+1
else
nowValue=nowValue+(nowRechargeCount-lastTargetCount)/(targetRechargeCount-lastTargetCount)*(1/allCount)
break
end
lastTargetCount=targetRechargeCount
end
if nowValue>0 then
nowValue=nowValue*validParecent+invalidPercent_front+(ignoreWidth_singleItem*finishCount)/progressValueWidth
end
self.progressBar:setProgressValue(nowValue*10000,10000)


self.rechargeCount:setText(nowRechargeCount)
end

function UIDailyRebateWin:refreshShowModel()
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local showModelParamsCfgList=goalTypeCfg.showModelParamsCfgList
local gradeId=goalTypeCfg.gradeId
local openZmLevel=welfareModel:getDailyRebateOpenActZmLevel(gradeId)or 0
if openZmLevel<=0 then
openZmLevel=zongmenModel:getLevel()
end
local showModelParam=self:getShowModelParamsByZmLevel(showModelParamsCfgList,openZmLevel)or{}
local itemId=showModelParam.itemid

local cfg=itemsConfig.getConfig(itemId)
local model=cfg.model
if itemsConfig.isDaoBingMaterials(itemId)then
local dbitemid=daobingConfig.getCombineDaoBing(itemId)
model=itemsConfig.getConfig(dbitemid).model
end

self:clearShowItemModel()
self.showModelItemId=itemId

if model then
if itemsConfig.isDaoBing(itemId)or itemsConfig.isDaoBingMaterials(itemId)then
self:showItemModel_DaoBing(itemId)
else
self:showItemModel_NormalItemModel(itemId,model)
end
elseif cfg.funcparam and cfg.funcparam.type==28 and cfg.type1==18 then
self:showItemModel_ZuShi(itemId)
elseif cfg.funcparam and cfg.funcparam.type==item_funtion_type.disciple and cfg.funcparam.isSpecial then
self:showItemModel_DiZi(itemId)
elseif cfg.relevantPram and cfg.type1==18 then
self:showItemModel_HeadKuangOrQiPaoKuangOrEmot(itemId)
elseif cfg.relevantPram then

local relevantPram=cfg.relevantPram
local modelType=relevantPram.relevantId
if modelType==1 then
self:showItemModel_GuBao(itemId,relevantPram)
else



end
else

self:showItemModel_NormalItemImage(itemId)
end
local offset=showModelParam.offset or{0,0}
local size=showModelParam.size or 1
self.showItemPos:setScale(Vector3.New(size,size,size))
self.showItemPos:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))


self.showItemName:setText(cfg.name)


if showModelParam.image then
local abName="ui/windows/welfare/welfare_dailyrebate_nameimg_atlas_pak.ab"
self.showADImg:setSprite(abName,showModelParam.image)
self.showADImg:setActive(true)
else
self.showADImg:setActive(false)
end


self.showItemNeedDay:setText(showModelParam.day)

end

function UIDailyRebateWin:refreshDailyRewardBtn()
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local gradeId=goalTypeCfg.gradeId
local isGot=welfareModel:getDailyRebateFreeRewardGotFlag(gradeId)

self.dailyRewardBtn:setActive(not isGot)
self.dailyRewardBtnOpen:setActive(isGot)
end

function UIDailyRebateWin:getShowModelParamsByZmLevel(showModelParamsCfg,zmLevel)
for i,v in ipairs(showModelParamsCfg)do
local minLv=v[1]
local maxLv=v[2]
local param=v[3]
if zmLevel>=minLv and zmLevel<=maxLv then
return param
end
end
end

function UIDailyRebateWin:getShowRewardCfgList()
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local gradeId=goalTypeCfg.gradeId
local taskCfgList=goalTypeCfg.allLevelTaskCfgList
local showRewardCfg={}
for i,v in ipairs(taskCfgList)do
local targetRechargeCount=v.targetDay
local rewardCfgList=v.rewardCfgList
local rewardZmLevel=welfareModel:getDailyRebateOpenActZmLevel(gradeId)or 0
if rewardZmLevel<=0 then
rewardZmLevel=zongmenModel:getLevel()
end
local rewardList=self:getRewardByZmLevel(rewardCfgList,rewardZmLevel)or{}
for _,reward in ipairs(rewardList)do
if reward.isRare==1 then
local cfg={
targetRechargeCount=targetRechargeCount,
reward=reward,
}
table.insert(showRewardCfg,cfg)
end
end
end
return showRewardCfg
end

function UIDailyRebateWin:getSortTaskCfgList(isResetGoalListSort)
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local taskCfgList=goalTypeCfg.allLevelTaskCfgList
if not self.sortTaskCfgList then
self.sortTaskCfgList={}
end
if not isResetGoalListSort and self.sortTaskCfgList[self.selectGoalTypeIndex]then
return self.sortTaskCfgList[self.selectGoalTypeIndex]
end
self.sortTaskCfgList[self.selectGoalTypeIndex]={}
local gradeId=goalTypeCfg.gradeId
local rechargeDay=welfareModel:getDailyRebateRechargeDay(gradeId)
local maxGotDay=welfareModel:getDailyRebateMaxGotDay(gradeId)
for i,v in ipairs(taskCfgList)do
local isFinish=rechargeDay>=v.targetDay
local isGot=maxGotDay>=v.targetDay
local sortWeight=v.targetDay

if isFinish and not isGot then
sortWeight=sortWeight-1000
elseif isGot then
sortWeight=sortWeight+10000
end
local taskCfgItem={}
taskCfgItem.targetDay=v.targetDay
taskCfgItem.rewardCfgList=v.rewardCfgList
taskCfgItem.sortWeight=sortWeight
table.insert(self.sortTaskCfgList[self.selectGoalTypeIndex],taskCfgItem)
end
table.sort(self.sortTaskCfgList[self.selectGoalTypeIndex],function(a,b)
return a.sortWeight<b.sortWeight
end)

return self.sortTaskCfgList[self.selectGoalTypeIndex]
end

function UIDailyRebateWin:clearShowItemModel()
self.showModelItemId=nil
self.itemModel:setChildUIModelRemoveTarget()
self.zuShiModel1:setChildUIModelRemoveTarget()
self.zuShiModel2:setChildUIModelRemoveTarget()
self.winlua:SetChildDOTweenAnimation_DOPause(self.itemImg:getID())
self.itemImg:setChildAnchoredPos(0,0)
self.itemImg:setActive(false)
self.itemEffect:setChildShowEffect(0,false)
self.itemEffectBg:setChildShowEffect(0,false)
playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID())
self.headKuang:setActive(false)
self.bubbleModel:setChildUIModelRemoveTarget()
self.bubbleframeRoot:setImageIcon("",false)
self.bubbleframeRoot:setActive(false)
self.emoticon:setImageIcon("",false)
self.emotRoot:setActive(false)

self.itemImg:setScale(Vector3.New(1,1,1))
self.itemEffect:setScale(Vector3.New(1,1,1))
self.itemEffectBg:setScale(Vector3.New(1,1,1))
end


function UIDailyRebateWin:showItemModel_DaoBing(oItemId)
local itemId=oItemId
if itemsConfig.isDaoBingMaterials(oItemId)then
itemId=itemsConfig.getConfig(oItemId).piece[1]
end
local isMaxStar
local maxlv=daobingConfig.getStarMaxLv(itemId)
local starlv=0
isMaxStar=starlv==maxlv
local itemCfg=itemsConfig.getConfig(itemId)
local color=itemCfg.color

local modelParams=itemsConfig.getConfig(itemId).model
local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
self.itemEffect:setChildShowEffect(effectInfo[1],true)
self.itemEffectBg:setChildShowEffect(_daoBingBgEffectId[color],true)

local size=0.8
self.itemEffect:setScale(Vector3.New(size,size,size))
self.itemEffectBg:setScale(Vector3.New(size,size,size))
end


function UIDailyRebateWin:showItemModel_NormalItemModel(itemId,modelParams)
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}
local size=modelParams.scale or defsize[1]or 1
local componnets=modelParams.cmp or{}
local animationID=modelParams.ani or 0
local offset=modelParams.offset
self.itemModel:setChildUIModelShowTarget(modelID,size,componnets,animationID)
if offset then
self.itemModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
end
end


function UIDailyRebateWin:showItemModel_ZuShi(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local sex=playerModel:getActorSex()

local list=itemCfg.funcparam.list[sex]
local modelParams=itemCfg.funcparam.model or{}
local scale=modelParams.scale or 0.5
local offsetX=modelParams.offsetX or 0
local offsetY=modelParams.offsetY or 0
if#(list or 0)==1 and list[1][1]==10 then
local temp={}
temp[list[1][1]]=list[1][2]
comHelper.setChildPlayerImage2(self.winlua,self.zuShiModel2:getID(),temp,sex,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
else
local selfImageList=playerImageModel:getDefaultImage()
local getImageId=function(tabid)
for i,v in ipairs(list)do
if v[1]==tabid then
return v[2]
end
end
end
local playerImage={}
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
playerImage[tabid]=getImageId(tabid)or selfImageList[tabid]
end
playerImageController.setPlayerModel(self.winlua,self.zuShiModel1:getID(),playerImage,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
end
end


function UIDailyRebateWin:showItemModel_HeadKuangOrQiPaoKuangOrEmot(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local itemType1=itemCfg.type1
local itemType2=itemCfg.type2
local relevantPram=itemCfg.relevantPram
if itemType1==18 then
if itemType2==1 then

local headKuangId=relevantPram.relevantId
local headKuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,headKuangId)
if headKuangCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local kuangAnimType,kuangAnim,enterAnimId=playerModel:getActorFrameAnimById(headKuangId)
playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID(),headKuangCfg.icon,kuangAnimType,kuangAnim,nil,enterAnimId)
self.headKuang:setScale(Vector3.New(size,size,size))
self.headKuang:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.headKuang:setActive(true)
end
elseif itemType2==2 then

local bubbleFrameId=relevantPram.relevantId
local bubbleFrameCfg=cfgHelper.get1(cfg_bubbleframeconfig_get,bubbleFrameId)
if bubbleFrameCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local bgmodel=bubbleFrameCfg.setmodel
if bgmodel then
self.bubbleModel:setChildUIModelShowTarget(bgmodel,1,{},eAnimationID.stand)
else
local kuangIconName=iconHelper.getChatKuangIcon(bubbleFrameCfg.icon)
self.bubbleframeRoot:setImageIcon(kuangIconName,false)
end
self.bubbleframeRoot:setScale(Vector3.New(size,size,size))
self.bubbleframeRoot:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.bubbleframeRoot:setActive(true)
end
elseif itemType2==4 then

local bigEmotId=relevantPram.relevantId
local bigEmotCfg=cfgHelper.get1(cfg_chatebigmotconfig_get,bigEmotId)
if bigEmotCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local bigEmotName=iconHelper.getBigEmotIcon(bigEmotId)
self.emoticon:setImageIcon(bigEmotName,false)
self.emotRoot:setScale(Vector3.New(size,size,size))
self.emotRoot:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.emotRoot:setActive(true)
end
end
end
end


function UIDailyRebateWin:showItemModel_GuBao(itemId,relevantPram)
local pram=relevantPram.pram
local icon=pram.icon or''
local effectid=pram.effectid
self.itemImg:setImageIcon(icon,true)
local needMove=icon~=''
if needMove then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.itemImg:getID())
self.itemImg:setActive(true)
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.itemImg:getID())
self.itemImg:setChildAnchoredPos(0,0)
self.itemImg:setActive(false)
end

if effectid then
self.itemEffect:setChildShowEffect(effectid,true)
else
self.itemEffect:setChildShowEffect(0,false)
end

local size=0.8
self.itemImg:setScale(Vector3.New(size,size,size))
self.itemEffect:setScale(Vector3.New(size,size,size))
end


function UIDailyRebateWin:showItemModel_NormalItemImage(itemId)
local iconName=iconHelper.getIconName(itemId)
self.itemImg:setImageIcon(iconName,false)
self.itemImg:setChildSizeDelta(250,250)
self.itemImg:setActive(true)
end


function UIDailyRebateWin:showItemModel_DiZi(itemId)
local data=UIDiscipleModel:getItemDiscipleDataByItemId(itemId)
if not data then
return
end

if not data.hasFixedImage then

logErr(FMT.fmt("展示弟子道具 {0} 对应的弟子id: {1} 没有配置固定组件库 无法加载形象",itemId,data.id))
return
end

local info=data.imageInfo
if info then

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
local scale=1
local animId=eAnimationID.stand
self.zuShiModel1:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,animId)
end
end





function UIDailyRebateWin:onItemClick()
self:onClickRewardItem(self.showModelItemId)
end



function UIDailyRebateWin:onInfoBtn()
self:onClickRewardItem(self.showModelItemId)
end



function UIDailyRebateWin:onDailyRewardBtn()
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local gradeId=goalTypeCfg.gradeId

local isGot=welfareModel:getDailyRebateFreeRewardGotFlag(gradeId)
if isGot then
return
end

welfareController:reqDailyRebateGetFreeReward(gradeId)
end


function UIDailyRebateWin:getGoalReward(gradeId)

welfareController:reqDailyRebateGetRoundReward(gradeId)
end

function UIDailyRebateWin:onClickGotoBtn()
local goalTypeCfg=self.goalTypeCfgList[self.selectGoalTypeIndex]
local firstRechargeIdList=goalTypeCfg.firstRechargeId
if firstRechargeIdList then
for _,firstRechargeId in ipairs(firstRechargeIdList)do
local firstRechargeType=0
local isOpenSys=false
local firstRechargeCfg_1=cfgHelper.get1(cfg_firstchargeconfig_get,firstRechargeId)
local firstRechargeCfg_2=cfgHelper.get1(cfg_firstcharge2config_get,firstRechargeId)
local firstRechargeCfg_3=cfgHelper.get1(cfg_firstcharge3config_get,firstRechargeId)
local firstRechargeData
if firstRechargeCfg_1 then
firstRechargeType=1
isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)
elseif firstRechargeCfg_2 then
firstRechargeType=2
isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)
elseif firstRechargeCfg_3 then
firstRechargeType=3
isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)
end

if isOpenSys then
local dataModel
local winName
if firstRechargeType==1 then
dataModel=firstRechargeModel
winName="UIFirstRechargeWin"
elseif firstRechargeType==2 then
dataModel=firstRechargeNewModel
winName="UIFirstRechargeWin2"
elseif firstRechargeType==3 then
dataModel=firstRecharge3Model
winName="UIFirstRechargeWin3"
end

local data,dataLen=dataModel:getFirstRechargeAllData()

if dataLen then
local isCanShow=dataModel:checkTabCanShowByRechargeId(firstRechargeId)
if isCanShow and not dataModel:checkIsBought(firstRechargeId)then

local dayIndex=1
local tabIndex=dataModel:getShowTabIndexByRechargeId(firstRechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow(winName,{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end
end

local tabType=FULL_TAB_TYPE.eRecharge
if systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then
tabType=FULL_TAB_TYPE.eRechargeDailyTeHui
elseif systemModel.isOpen(SYSTEM_DEFINE.eNewDayDiscounts)then
tabType=FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay
end

jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=tabType}})
end


function UIDailyRebateWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end
