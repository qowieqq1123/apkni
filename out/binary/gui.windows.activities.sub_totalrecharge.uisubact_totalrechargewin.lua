







def_class("UISubAct_TotalRechargeWin",UIWindowBase)









function UISubAct_TotalRechargeWin:bindComponents()

self.hasModelPanel=UIObject.get(self,0)
self.itemModel=UIObject.get(self,1)
self.itemClick=UIButton.get(self,2)
self.infoBtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.freeRewardBtn=UIButton.get(self,5)
self.freeRewardReddot=UIObject.get(self,6)
self.itemImg=UIImage.get(self,7)
self.itemEffect=UIObject.get(self,8)
self.itemEffectBg=UIObject.get(self,9)
self.zuShiModel1=UIObject.get(self,10)
self.zuShiModel2=UIObject.get(self,11)
self.bubbleframeRoot=UIImage.get(self,12)
self.bubbleModel=UIObject.get(self,13)
self.headKuang=UIImage.get(self,14)
self.emotRoot=UIObject.get(self,15)
self.emoticon=UIImage.get(self,16)
self.showItemPos=UIObject.get(self,17)
self.showItemNameImage=UIImage.get(self,18)
self.bgModel=UIObject.get(self,19)
self.showItemPanel=UIObject.get(self,20)
self.notModelPanel=UIObject.get(self,21)
self.notModelItem=UIObject.get(self,22)
self.targetRechargeCount=UIText.get(self,23)
self.timeText=UIText.get(self,24)
self.totalCount=UIText.get(self,25)
self.leftBtn=UIButton.get(self,26)
self.rightBtn=UIButton.get(self,27)
self.helpBtn=UIButton.get(self,28)

self.itemClick:setButtonClick(function()self:onItemClick()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UISubAct_TotalRechargeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hasModelPanel);self.hasModelPanel=nil;
_UIObject_release(self.itemModel);self.itemModel=nil;
_UIObject_release(self.itemClick);self.itemClick=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.freeRewardReddot);self.freeRewardReddot=nil;
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
_UIObject_release(self.showItemNameImage);self.showItemNameImage=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.showItemPanel);self.showItemPanel=nil;
_UIObject_release(self.notModelPanel);self.notModelPanel=nil;
_UIObject_release(self.notModelItem);self.notModelItem=nil;
_UIObject_release(self.targetRechargeCount);self.targetRechargeCount=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.totalCount);self.totalCount=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
end
















local taskItemIndex={
titleText=0,
rewards=1,
getRewardBtn=2,
gotFlag=3,
gotoBtn=4,
back=5,
specialBack=6,
titleBg=7,
specialTitleBg=8,
}

local _daoBingBgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}



function UISubAct_TotalRechargeWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_TotalRechargeWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UISubAct_TotalRechargeWin:onShow(argtable,afterOnloaded)
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

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5224,1,{},eAnimationID.stand)
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:refresh(true,true)


self:setRemainingTimeTimer()
end


function UISubAct_TotalRechargeWin:onHide()
self:clearTimer()
self:clearShowItemModel()
end

function UISubAct_TotalRechargeWin:refresh(isInit,isResetModel)

self:refreshShowRewardModelPanel(isInit,isResetModel)


self:refreshTaskPanel()


local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
local totalRechargeRMB=math.floor(totalRechargeNum/10)
self.totalCount:setText(FMT.fmt("{0}",totalRechargeRMB))


self:refreshFreeReward()
end

function UISubAct_TotalRechargeWin:refreshTaskPanel()

self.taskSortList=self:getSortTaskList()
local taskCount=#self.taskSortList


self.taskScroller:setChildScrollViewCreateGrids(taskCount,0)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
self.finishAndNotGotList={}
for i=1,grids.Count do
local widget=grids[i-1]

self:refreshTaskItem(i,widget)
end
end


function UISubAct_TotalRechargeWin:refreshTaskItem(i,widget)
local taskData=self.taskSortList[i]
local taskTargetRechargeNum=taskData.targetRechargeNum
local taskIndex=taskData.taskIndex

local targetStr
local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
local totalRechargeRMB=math.floor(totalRechargeNum/10)
local taskTargetRechargeRMB=math.floor(taskTargetRechargeNum/10)
if taskData.isFinish then
targetStr=FMT.fmt("<color=#549327>{0}</color><color=#171311>/{1}</color>",totalRechargeRMB,taskTargetRechargeRMB)
else
targetStr=FMT.fmt("<color=#c82c2c>{0}</color><color=#171311>/{1}</color>",totalRechargeRMB,taskTargetRechargeRMB)
end
widget:SetChildText(taskItemIndex.titleText,FMT.fmt("累计获得（{0}）仙缘",targetStr))


local rewards=taskData.rewards or{}
local selectRewards=taskData.selectRewards or{}
local rewardsLen=#rewards
local hasSelect=next(selectRewards)~=nil
local isFinish=taskData.isFinish or false
local isGot=taskData.isGot or false

widget:SetChildLayoutGroupCreateItems(taskItemIndex.rewards,rewardsLen+#selectRewards)
local rwGrids=widget:GetChildLayoutGroupGridList(taskItemIndex.rewards)
for i=1,rwGrids.Count do
local rwWidget=rwGrids[i-1]
if i>rewardsLen then
i=i-rewardsLen
self:refreshSelectReward(rwWidget,taskIndex,i,selectRewards,isGot)
else
local reward=rewards[i]
self:refreshReward(rwWidget,reward)
end
end


local needSelect=false
local selectList={}
if isFinish and not isGot and hasSelect then
if hasSelect then
local selectData=self.activityData:getSelectDataByTaskIndex(taskIndex)or{}

for i,v in ipairs(selectRewards)do
if not selectData[i]then
needSelect=true
break
else
selectList[i]=selectData[i]
end
end
end
end

widget:SetChildActive(taskItemIndex.getRewardBtn,isFinish and not isGot)
widget:SetChildActive(taskItemIndex.gotoBtn,not isFinish and not isGot)

widget:SetChildButtonClick(taskItemIndex.getRewardBtn,function()
if needSelect then
UIManager.error("需选定奖励后再领取")
else
self:onGetRewardBtn(taskIndex)
end

end)


if isFinish and not isGot and not needSelect then

self.finishAndNotGotList=self.finishAndNotGotList or{}
table.insert(self.finishAndNotGotList,taskIndex)
end
widget:SetChildButtonClick(taskItemIndex.gotoBtn,function()
self:onClickGotoBtn()
end)


widget:SetChildActive(taskItemIndex.gotFlag,isGot)

local isSpecial=self.config.showItemModelParams[taskIndex]~=nil

widget:SetChildActive(taskItemIndex.back,not isSpecial)
widget:SetChildActive(taskItemIndex.specialBack,isSpecial)


widget:SetChildActive(taskItemIndex.titleBg,not isSpecial)
widget:SetChildActive(taskItemIndex.specialTitleBg,isSpecial)
end

function UISubAct_TotalRechargeWin:refreshTaskItemByTaskIndex(taskIndex)
for i,v in ipairs(self.taskSortList)do
if v.taskIndex==taskIndex then
local grid=self.taskScroller:getChildScrollViewItemWidget(i-1)
if grid then
self:refreshTaskItem(i,grid)
end
end
end
end

function UISubAct_TotalRechargeWin:refreshReward(rwWidget,reward)
local itemid=reward[1]
local count=reward.showCount or reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isShowEffect=reward.showEffect~=nil and reward.showEffect==1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=isShowEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)

rwWidget:SetChildActive(2,false)
rwWidget:SetChildActive(3,false)
rwWidget:SetChildActive(4,false)
rwWidget:SetChildActive(5,false)


rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

function UISubAct_TotalRechargeWin:refreshSelectReward(rwWidget,taskIndex,rewardIndex,selectRewards,isGot)
local reward=selectRewards[rewardIndex]
local selectid=reward[1]
local cfg=cfgHelper.get(cfg_rechargeact1selectconfig_get,selectid)
local selectIdx=self.activityData:getSelectData(taskIndex,rewardIndex)

local isSelected=selectIdx>0
rwWidget:SetChildActive(3,true)
if isSelected then
local item=cfg.selectlist[selectIdx]
local itemid=item[1]
local count=item[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isShowEffect=reward.showEffect==1 or reward[2]==1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=isShowEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildActive(0,true)
rwWidget:SetChildPropData(0,prop)

rwWidget:SetChildActive(2,false)

rwWidget:SetChildActive(4,true)
rwWidget:SetChildActive(5,false)

rwWidget:SetChildButtonClick(3,function()
if isGot then
itemsComponentHelper.onItemClick(itemid)
else
self:onClickSelectItem(taskIndex,rewardIndex)
end
end)

else
rwWidget:SetChildActive(0,false)
rwWidget:SetChildActive(2,true)
rwWidget:SetChildActive(4,false)
rwWidget:SetChildActive(5,false)

rwWidget:SetChildButtonClick(3,function()
if not isGot then
self:onClickSelectItem(taskIndex,rewardIndex)
end
end)
end





end

function UISubAct_TotalRechargeWin:getSortTaskList()
local allCfgList=self.config.recharge
local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
local taskList={}
for i,v in ipairs(allCfgList)do
local targetRechargeNum=v[1]

local rewards=v[2]
local selectRewards=v[3]
local sortWeight=i
local isFinish=totalRechargeNum>=targetRechargeNum
local isGot=self.activityData:checkTaskIsGot(i)
if isFinish then
sortWeight=sortWeight-100
end
if isGot then
sortWeight=sortWeight+10000
end
local taskItem={
taskIndex=i,
targetRechargeNum=targetRechargeNum,
rewards=rewards,
selectRewards=selectRewards,
sortWeight=sortWeight,
isFinish=isFinish,
isGot=isGot,
}
table.insert(taskList,taskItem)
end
table.sort(taskList,function(a,b)
return a.sortWeight<b.sortWeight
end)

return taskList
end

function UISubAct_TotalRechargeWin:onClickSelectItem(taskIndex,clickIndex)

self:showWindow("UIRechargeSelectLiBao_selectWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId,taskIndex=taskIndex,defaultSelect=clickIndex,selectCall=function(selectIdxList)
local select=false
for i,v in ipairs(selectIdxList)do
if v>0 then select=true break end
end
if select then
self.activityData:reqTotalRecharge_selectTaskReward(taskIndex,selectIdxList)
end

end})
end


function UISubAct_TotalRechargeWin:refreshFreeReward()

local isGot=self.activityData:reqTotalRecharge_checkFreeRewardsIsGot()


self.freeRewardBtn:setActive(not isGot)
end

function UISubAct_TotalRechargeWin:refreshShowRewardModelPanel(isInitModel,isResetModel)
if isInitModel then
self.selectShowRewardIndex=nil
self:initShowRewardModelList()

if not self.selectShowRewardIndex then
self.selectShowRewardIndex=#self.showRewardItemList
end
end

if not isResetModel and self.lastShowModelIndex and self.selectShowRewardIndex==self.lastShowModelIndex then

return
end


self:refreshShowItemModel()
self.lastShowModelIndex=self.selectShowRewardIndex


local hasLeft=self.selectShowRewardIndex>1
local hasRight=self.selectShowRewardIndex<#self.showRewardItemList
self.leftBtn:setActive(hasLeft)
self.rightBtn:setActive(hasRight)


local showRewardItem=self.showRewardItemList[self.selectShowRewardIndex]
local showRewardTaskIndex=showRewardItem.taskIndex
local allTaskCfgList=self.config.recharge
local taskCfg=allTaskCfgList[showRewardTaskIndex]
local targetRechargeNum=taskCfg[1]
local taskTargetRechargeRMB=math.floor(targetRechargeNum/10)
self.targetRechargeCount:setText(taskTargetRechargeRMB)
end

function UISubAct_TotalRechargeWin:initShowRewardModelList()
local allTaskCfgList=self.config.recharge
local allShowRewardCfgList=self.config.showItemModelParams
local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
self.showRewardItemList={}
local listIndex=0
for index,v in ipairs(allTaskCfgList)do
local modelParam=allShowRewardCfgList[index]
if modelParam then
local targetRechargeNum=v[1]
local showRewardItem={
taskIndex=index,
modelParam=modelParam,
}
table.insert(self.showRewardItemList,showRewardItem)
listIndex=listIndex+1

local isFinish=totalRechargeNum>=targetRechargeNum
local isGot=self.activityData:checkTaskIsGot(index)
if(not isFinish or not isGot)and not self.selectShowRewardIndex then
self.selectShowRewardIndex=listIndex
end
end
end
end


function UISubAct_TotalRechargeWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

if self.nextRefreshTime and nowTime>=self.nextRefreshTime then
self:initDate()
self:refresh()
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_TotalRechargeWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_TotalRechargeWin:refreshShowItemModel()
self:clearShowModelFadeTweener()
self.showItemPanel:setChildCanvasGroupAlpha(0)
local showRewardItem=self.showRewardItemList[self.selectShowRewardIndex]
if showRewardItem then
local showModelParam=showRewardItem.modelParam
local itemId=showModelParam.itemid
local itemNum=showModelParam.itemNum
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

self:showItemModel_NormalItemImage(itemId,itemNum,showModelParam.colorEffect)
end
local offset=showModelParam.offset or{0,0}
local size=showModelParam.size or 1
self.showItemPos:setScale(Vector3.New(size,size,size))
self.showItemPos:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))

local itemNameImage=showModelParam.itemNameImage
if itemNameImage then
local itemNameImageAbName="ui/windows/activities/sub_totalrecharge/totalrecharge_nameimage_atlas_pak.ab"
self.showItemNameImage:setCSImageSprite(itemNameImageAbName,itemNameImage)
self.showItemNameImage:setActive(true)
else
self.showItemNameImage:setActive(false)
end
end

self.showModelFadeTweener=self.showItemPanel:setChildCanvasGroupDOFade(1,0.5)
end

function UISubAct_TotalRechargeWin:clearShowModelFadeTweener()
if self.showModelFadeTweener~=nil then
self.showModelFadeTweener:Complete()
self.showModelFadeTweener:Kill()
self.showModelFadeTweener=nil
self.showItemPanel:setChildCanvasGroupAlpha(1)
end
end

function UISubAct_TotalRechargeWin:clearShowItemModel()
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
self.hasModelPanel:setActive(false)
self.notModelPanel:setActive(false)

self.itemImg:setScale(Vector3.New(1,1,1))
self.itemEffect:setScale(Vector3.New(1,1,1))
self.itemEffectBg:setScale(Vector3.New(1,1,1))
end


function UISubAct_TotalRechargeWin:showItemModel_DaoBing(oItemId)
self.hasModelPanel:setActive(true)
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


function UISubAct_TotalRechargeWin:showItemModel_NormalItemModel(itemId,modelParams)
self.hasModelPanel:setActive(true)
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


function UISubAct_TotalRechargeWin:showItemModel_ZuShi(itemId)
self.hasModelPanel:setActive(true)
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


function UISubAct_TotalRechargeWin:showItemModel_HeadKuangOrQiPaoKuangOrEmot(itemId)
self.hasModelPanel:setActive(true)
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


function UISubAct_TotalRechargeWin:showItemModel_GuBao(itemId,relevantPram)
self.hasModelPanel:setActive(true)
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


function UISubAct_TotalRechargeWin:showItemModel_NormalItemImage(itemId,num,colorEffect)






self.notModelPanel:setActive(true)
local rwWidget=self.notModelItem:getWidgetBase()
local itemid=itemId
local countStr=num~=nil and num or''
local showCountBG=countStr~=''
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


function UISubAct_TotalRechargeWin:showItemModel_DiZi(itemId)
self.hasModelPanel:setActive(true)
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





function UISubAct_TotalRechargeWin:onItemClick()
local showModelItem=self.showRewardItemList[self.selectShowRewardIndex]
local showModelItemId=showModelItem.modelParam.itemid
self:onClickRewardItem(showModelItemId)
end



function UISubAct_TotalRechargeWin:onInfoBtn()
self:onItemClick()
end



function UISubAct_TotalRechargeWin:onFreeRewardBtn()

local isGot=self.activityData:reqTotalRecharge_checkFreeRewardsIsGot()
if isGot then

return
end


self.activityData:reqTotalRecharge_getFreeRewards()
end



function UISubAct_TotalRechargeWin:onLeftBtn()
if self.selectShowRewardIndex>1 then
self.selectShowRewardIndex=self.selectShowRewardIndex-1
self:refreshShowRewardModelPanel()
end
end



function UISubAct_TotalRechargeWin:onRightBtn()
if self.selectShowRewardIndex<#self.showRewardItemList then
self.selectShowRewardIndex=self.selectShowRewardIndex+1
self:refreshShowRewardModelPanel()
end
end

function UISubAct_TotalRechargeWin:onHelpBtn()
local rule_str="每充值1元可获得1仙缘"
local pos=Vector2.New(16,15)
self:showWindow('UIConditionTipsOne',{str=rule_str,posItem=self.helpBtn,pos=pos,showType=2})
end


function UISubAct_TotalRechargeWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_TotalRechargeWin:onGetRewardBtn(taskIndex,selectList)
























if self.finishAndNotGotList and next(self.finishAndNotGotList)then
self.activityData:reqTotalRecharge_getTaskReward(self.finishAndNotGotList)
else
UIManager.error("没有可领取的奖励")
end
end


function UISubAct_TotalRechargeWin:onClickGotoBtn()
if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then

local data,dataLen=firstRechargeModel:getFirstRechargeAllData()

if dataLen then
local sortCfgList=firstRechargeModel:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isCanShow=firstRechargeModel:checkTabCanShowByRechargeId(rechargeId)
if isCanShow and not firstRechargeModel:checkIsBought(rechargeId)then

local dayIndex=1
local tabIndex=firstRechargeModel:getShowTabIndexByRechargeId(rechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow("UIFirstRechargeWin",{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then

local data,dataLen=firstRechargeNewModel:getFirstRechargeAllData()

if dataLen then
local sortCfgList=firstRechargeNewModel:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isCanShow=firstRechargeNewModel:checkTabCanShowByRechargeId(rechargeId)
if isCanShow and not firstRechargeNewModel:checkIsBought(rechargeId)then

local dayIndex=1
local tabIndex=firstRechargeNewModel:getShowTabIndexByRechargeId(rechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow("UIFirstRechargeWin2",{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then

local data,dataLen=firstRecharge3Model:getFirstRechargeAllData()

if dataLen then
local sortCfgList=firstRecharge3Model:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isCanShow=firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId)
if isCanShow and not firstRecharge3Model:checkIsBought(rechargeId)then

local dayIndex=1
local tabIndex=firstRecharge3Model:getShowTabIndexByRechargeId(rechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow("UIFirstRechargeWin3",{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end


local tabType
if not tabType and systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then

local isBought=not rechargeController:checkDailyTeHuiTenDayIsExpire()
if not isBought then
tabType=FULL_TAB_TYPE.eRechargeDailyTeHui
end
end

if not tabType and systemModel.isOpen(SYSTEM_DEFINE.eNewDayDiscounts)then

local libaoAllCfg=cfg_daydiscountsnewconfig()
local isGotAll=true
for i,v in ipairs(libaoAllCfg)do
if v.recharge_id then

local isBought=rechargeModel:checkDailyTeHuiSingleDayGotByIndex(v.id)
if not isBought then
isGotAll=false
break
end
end
end

if not isGotAll then
tabType=FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay
end
end

if not tabType then

local config=cfg_limitedgiftconfig()
local giftType=1
for i,v in pairs(config)do
if v.gifttype==giftType then
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
local sellOut=buyNum>=v.maxcount
local rechargeid=v.rechargeid
if not sellOut and rechargeid then
tabType=FULL_TAB_TYPE.eReChargeLiBao
break
end
end
end
end

if not tabType then
tabType=FULL_TAB_TYPE.eRecharge
end
jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=tabType}})
end
