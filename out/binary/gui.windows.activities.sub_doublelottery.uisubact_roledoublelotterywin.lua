







def_class("UISubAct_roledoubleLotteryWin",UIWindowBase)









function UISubAct_roledoubleLotteryWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.probabilityRoot=UIButton.get(self,1)
self.probabilityBtn=UIButton.get(self,2)
self.targetRewardBtn=UIButton.get(self,3)
self.jumpAnimToggle=UIToggleButton.get(self,4)
self.box2Panel=UIObject.get(self,5)
self.clickMask=UIObject.get(self,6)
self.box1Panel=UIObject.get(self,7)
self.moneyBtnType1=UIButton.get(self,8)
self.moneyBtnType2=UIButton.get(self,9)
self.jumpAnimToggleText=UIText.get(self,10)
self.targetRewardReddot=UIObject.get(self,11)
self.rewardList=UIObject.get(self,12)
self.moneyRootType2=UIObject.get(self,13)
self.moneyRootType1=UIObject.get(self,14)
self.rewardView=UIObject.get(self,15)
self.timeText=UIText.get(self,16)
self.boxRewardName2=UIObject.get(self,17)
self.boxRewardName1=UIObject.get(self,18)
self.probabilityPanel=UIObject.get(self,19)
self.probabilityName_1=UIText.get(self,20)
self.probabilityList_1=UIObject.get(self,21)
self.probabilityName_2=UIText.get(self,22)
self.probabilityList_2=UIObject.get(self,23)

self.probabilityRoot:setButtonClick(function()self:onProbabilityRoot()end)

self.probabilityBtn:setButtonClick(function()self:onProbabilityBtn()end)

self.targetRewardBtn:setButtonClick(function()self:onTargetRewardBtn()end)

self.moneyBtnType1:setButtonClick(function()self:onMoneyBtnType1()end)

self.moneyBtnType2:setButtonClick(function()self:onMoneyBtnType2()end)
self.probabilityName={
self.probabilityName_1,
self.probabilityName_2,
}
self.probabilityList={
self.probabilityList_1,
self.probabilityList_2,
}



end


function UISubAct_roledoubleLotteryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.probabilityRoot);self.probabilityRoot=nil;
_UIObject_release(self.probabilityBtn);self.probabilityBtn=nil;
_UIObject_release(self.targetRewardBtn);self.targetRewardBtn=nil;
_UIObject_release(self.jumpAnimToggle);self.jumpAnimToggle=nil;
_UIObject_release(self.box2Panel);self.box2Panel=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.box1Panel);self.box1Panel=nil;
_UIObject_release(self.moneyBtnType1);self.moneyBtnType1=nil;
_UIObject_release(self.moneyBtnType2);self.moneyBtnType2=nil;
_UIObject_release(self.jumpAnimToggleText);self.jumpAnimToggleText=nil;
_UIObject_release(self.targetRewardReddot);self.targetRewardReddot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.moneyRootType2);self.moneyRootType2=nil;
_UIObject_release(self.moneyRootType1);self.moneyRootType1=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.boxRewardName2);self.boxRewardName2=nil;
_UIObject_release(self.boxRewardName1);self.boxRewardName1=nil;
_UIObject_release(self.probabilityPanel);self.probabilityPanel=nil;
_UIObject_release(self.probabilityName_1);self.probabilityName_1=nil;
_UIObject_release(self.probabilityList_1);self.probabilityList_1=nil;
_UIObject_release(self.probabilityName_2);self.probabilityName_2=nil;
_UIObject_release(self.probabilityList_2);self.probabilityList_2=nil;
self.probabilityName=nil;
self.probabilityList=nil;
end
















local boxWidgetItemIndex={

boxModel=0,
reddot=1,
progressbarPanel=2,
progressbar=3,
boxNameText=4,
effect=5,
drawBtnPanel=6,
drawBtnOne=7,
drawOneMoneyTxt=8,
drawOneMoneyImg=9,
drawOneFreeText=10,
drawOneReddot=11,
drawBtnMany=12,
drawBtnManyText=13,
drawManyMoneyTxt=14,
drawManyMoneyImg=15,
drawManyReddot=16,
drawClickMask=17,
clickArea=18,
selectEffect=19,
boxNamePanel=20,
probabilityBtn=21,
}
local _effectColor={
[eQualityColor.eWhite]=10427,
[eQualityColor.eGreen]=10427,
[eQualityColor.eBlue]=10427,
[eQualityColor.ePurple]=10428,
[eQualityColor.eOrange]=10429,
[eQualityColor.eRed]=10430,
[eQualityColor.ePink]=10431,
}

local _selectEffectList={
[1]=10461,
[2]=10426,
}

local _this



function UISubAct_roledoubleLotteryWin:onLoaded(...)
_this=self
self:bindComponents()
self.isToggle=userActorSetting.get('skipRoleDoubleLotteryAnim',false)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
self.jumpAnimToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isToggle)
end


function UISubAct_roledoubleLotteryWin:__delete()
self:clearTimer()
self:unbindComponents()
self:clearAllFMTweener()
_this=nil
end




function UISubAct_roledoubleLotteryWin:onShow(argtable,afterOnloaded)
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

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time
self.fmTweenerList={}
self.showMoneyType={}

self.rewardView:setActive(true)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),4923,1,{},eAnimationID.stand)
end

if not self.isInLotteryAnim then
self.selectBoxIndex=self:getDefaultBoxIndex()
end

self:refresh(afterOnloaded,true)
end


function UISubAct_roledoubleLotteryWin:onHide()
self:clearTimer()
self:clearAllFMTweener()
self.rewardView:setActive(false)
end

function UISubAct_roledoubleLotteryWin:refresh(isInit,isFromShowFun)

self:refreshBoxPanel(1,isInit)


self:refreshBoxPanel(2,isInit)


self:selectBox(self.selectBoxIndex,isInit or isFromShowFun)

if isInit or isFromShowFun then

self:refreshAllMoney()
end


self:refreshDrawBtn()


local targetReddot=self.activityData:checkTargetReddot()
self.targetRewardReddot:setActive(targetReddot)


self:setRemainingTimeTimer()
end

function UISubAct_roledoubleLotteryWin:refreshBoxPanel(boxIndex,isInit)
local boxWidget=self:getBoxPanelWidgetBase(boxIndex)
local data=self.activityData.data or{}
if boxWidget then
local showParamCfg=self.config.boxShowParam[boxIndex]

local name=showParamCfg.name
boxWidget:SetChildText(boxWidgetItemIndex.boxNameText,name)


local reddot=self.activityData:checkBoxReddotByIndex(boxIndex)
boxWidget:SetChildActive(boxWidgetItemIndex.reddot,reddot)

if isInit then

local modelId=showParamCfg.modelid
if modelId then
boxWidget:SetChildUIModelShowTarget(boxWidgetItemIndex.boxModel,modelId,1,{},eAnimationID.stand)
end

boxWidget:SetChildButtonClick(boxWidgetItemIndex.probabilityBtn,function()
self:onClickProbability(boxIndex)
end)
end


local effectOffset=showParamCfg.effOffset
if effectOffset then
boxWidget:SetChildAnchoredPos(boxWidgetItemIndex.effect,effectOffset[1],effectOffset[2])
end


local drawPoolCfg=self.config.box_times_pool[boxIndex]
local targetCount=drawPoolCfg[#drawPoolCfg][2]
local cur=data.boxDrawCountList[boxIndex]and data.boxDrawCountList[boxIndex].drawCount or 0
if cur>targetCount then
cur=targetCount
end
boxWidget:SetChildProgressValue(boxWidgetItemIndex.progressbar,cur,targetCount)
boxWidget:SetChildProgressText(boxWidgetItemIndex.progressbar,FMT.fmt('{0}/{1}',cur,targetCount))


boxWidget:SetChildButtonClick(boxWidgetItemIndex.clickArea,function()
self:onClickBoxPanel(boxIndex)
end)
end
end

function UISubAct_roledoubleLotteryWin:getBoxPanelWidgetBase(boxIndex)
local boxWidget
if boxIndex==1 then
boxWidget=self.box1Panel:getWidgetBase()
elseif boxIndex==2 then
boxWidget=self.box2Panel:getWidgetBase()
end
return boxWidget
end

function UISubAct_roledoubleLotteryWin:selectBox(boxIndex,isInit)
if not isInit and self.selectBoxIndex==boxIndex then
return
end

if self.isInAnim or self.isInLotteryAnim then
return
end

local originalBoxIndex
if boxIndex==1 then
originalBoxIndex=2
elseif boxIndex==2 then
originalBoxIndex=1
end

local originalBoxWidget=self:getBoxPanelWidgetBase(originalBoxIndex)
local selectBoxWidget=self:getBoxPanelWidgetBase(boxIndex)


local darkColor=Color.New(0.5,0.5,0.5,1)
local lightColor=Color.white
if isInit then



originalBoxWidget:SetChildUIModelShowColor(boxWidgetItemIndex.boxModel,darkColor)
originalBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.progressbarPanel,0.5)
originalBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.boxNamePanel,0.5)
originalBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.drawBtnPanel,0)
originalBoxWidget:SetChildActive(boxWidgetItemIndex.drawClickMask,true)
originalBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.probabilityBtn,0.5)




selectBoxWidget:SetChildUIModelShowColor(boxWidgetItemIndex.boxModel,lightColor)
selectBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.drawBtnPanel,1)
selectBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.progressbarPanel,1)
selectBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.boxNamePanel,1)
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawClickMask,false)
selectBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.probabilityBtn,1)
else
self.isInAnim=true
local duration=0.6



originalBoxWidget:SetChildUIModelShowFadeToColor(boxWidgetItemIndex.boxModel,darkColor,duration,0,nil)
originalBoxWidget:SetChildCanvasGroupDOFade(boxWidgetItemIndex.progressbarPanel,0.5,duration)
originalBoxWidget:SetChildCanvasGroupDOFade(boxWidgetItemIndex.boxNamePanel,0.5,duration)
originalBoxWidget:SetChildCanvasGroupDOFade(boxWidgetItemIndex.drawBtnPanel,0,duration)
originalBoxWidget:SetChildActive(boxWidgetItemIndex.drawClickMask,true)
originalBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.probabilityBtn,0.5)




selectBoxWidget:SetChildUIModelShowFadeToColor(boxWidgetItemIndex.boxModel,lightColor,duration,0,nil)
selectBoxWidget:SetChildCanvasGroupDOFade(boxWidgetItemIndex.drawBtnPanel,1,duration)
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawClickMask,false)
selectBoxWidget:SetChildCanvasGroupDOFade(boxWidgetItemIndex.boxNamePanel,1,duration)
selectBoxWidget:SetChildCanvasGroupDOFade(boxWidgetItemIndex.progressbarPanel,1,duration,function()
if _this==nil then return end
_this.isInAnim=false
end)
selectBoxWidget:SetChildCanvasGroupAlpha(boxWidgetItemIndex.probabilityBtn,1)
end
local selectEffectId=_selectEffectList[boxIndex]

originalBoxWidget:SetChildShowEffect(boxWidgetItemIndex.selectEffect,0,false)

selectBoxWidget:SetChildShowEffect(boxWidgetItemIndex.selectEffect,selectEffectId,true)

self.selectBoxIndex=boxIndex


self:refreshDrawBtn()


self:refreshShowReward()
end

function UISubAct_roledoubleLotteryWin:refreshDrawBtn()
local costCfg=self.config.box_cost_item[self.selectBoxIndex]
local selectBoxWidget=self:getBoxPanelWidgetBase(self.selectBoxIndex)
local itemId=costCfg[1]
local needCnt=costCfg[2]
local iconName=iconHelper.getIconName(itemId)
local hasItemCount=itemsModel.getCount(itemId)
local remainingDrawCount=self.activityData:getRemainingFreeDrawCount(self.selectBoxIndex)
if remainingDrawCount>0 then
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawOneMoneyTxt,false)
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawOneFreeText,true)
selectBoxWidget:SetChildText(boxWidgetItemIndex.drawOneFreeText,FMT.fmt("免费次数：{0}",remainingDrawCount))
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawOneReddot,true)
else
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawOneMoneyTxt,true)
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawOneFreeText,false)
selectBoxWidget:SetChildCSImageIcon(boxWidgetItemIndex.drawOneMoneyImg,iconName,false)
local isEnough=hasItemCount>=needCnt
if isEnough then
selectBoxWidget:SetChildText(boxWidgetItemIndex.drawOneMoneyTxt,needCnt)
else
selectBoxWidget:SetChildText(boxWidgetItemIndex.drawOneMoneyTxt,FMT.cfmt(FONT_COLOR.eRedColor,'{0}',needCnt))
end
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawOneReddot,isEnough)
end

selectBoxWidget:SetChildCSImageIcon(boxWidgetItemIndex.drawManyMoneyImg,iconName,false)
local manyDrawCount=self.config.lottery_list[2]
selectBoxWidget:SetChildText(boxWidgetItemIndex.drawBtnManyText,FMT.fmt("打开{0}次",manyDrawCount))
local isEnough=hasItemCount>=(needCnt*manyDrawCount)
if isEnough then
selectBoxWidget:SetChildText(boxWidgetItemIndex.drawManyMoneyTxt,needCnt*manyDrawCount)
else
selectBoxWidget:SetChildText(boxWidgetItemIndex.drawManyMoneyTxt,FMT.cfmt(FONT_COLOR.eRedColor,'{0}',needCnt*manyDrawCount))
end
selectBoxWidget:SetChildActive(boxWidgetItemIndex.drawManyReddot,isEnough)


selectBoxWidget:SetChildButtonClick(boxWidgetItemIndex.drawBtnOne,function()
self:onDrawBtnOne(self.selectBoxIndex)
end)
selectBoxWidget:SetChildButtonClick(boxWidgetItemIndex.drawBtnMany,function()
self:onDrawBtnMany(self.selectBoxIndex)
end)
end

function UISubAct_roledoubleLotteryWin:refreshAllMoney()
for i=1,2 do
self:refreshMoneyByBoxIndex(i)
end
end

function UISubAct_roledoubleLotteryWin:refreshMoneyByBoxIndex(boxIndex)
local widget
if boxIndex==1 then
widget=self.moneyRootType1:getWidgetBase()
elseif boxIndex==2 then
widget=self.moneyRootType2:getWidgetBase()
end
if widget then
local costCfg=self.config.box_cost_item[boxIndex]
local moneyType=costCfg[1]
local isAdd=true
local moneyVal=0
self.showMoneyType[moneyType]=boxIndex
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
end

function UISubAct_roledoubleLotteryWin:refreshMoneyValueByBoxIndex(boxIndex,lastVal)
local widget
if boxIndex==1 then
widget=self.moneyRootType1:getWidgetBase()
elseif boxIndex==2 then
widget=self.moneyRootType2:getWidgetBase()
end
if widget then
local costCfg=self.config.box_cost_item[boxIndex]
local moneyType=costCfg[1]
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(boxIndex)
self.fmTweenerList[boxIndex]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end
end

function UISubAct_roledoubleLotteryWin:refreshShowReward()
self.boxRewardName1:setActive(self.selectBoxIndex==1)
self.boxRewardName2:setActive(self.selectBoxIndex==2)

local rewardList=self.config.boxShowReward[self.selectBoxIndex]or{}
local specialItemList_lookup=self.config.reset_items[self.selectBoxIndex]or{}
self.rewardList:setChildLayoutGroupCreateItems(#rewardList)
local grids=self.rewardList:getChildLayoutGroupGridList()
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=rewardList[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local colorEffect=specialItemList_lookup[itemId]or false
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name='',colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)



item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


function UISubAct_roledoubleLotteryWin:getDefaultBoxIndex()
local defaultIndex=2

local reddot_1=self.activityData:checkBoxReddotByIndex(1)
local reddot_2=self.activityData:checkBoxReddotByIndex(2)
if reddot_1 and not reddot_2 then
defaultIndex=1
end

return defaultIndex
end


function UISubAct_roledoubleLotteryWin:clearFMTweenerByIndex(index)
if self.fmTweenerList[index]then
self.fmTweenerList[index]:Kill()
self.fmTweenerList[index]=nil
end
end

function UISubAct_roledoubleLotteryWin:clearAllFMTweener()
for index,tweener in pairs(self.fmTweenerList)do
tweener:Kill()
self.fmTweenerList[index]=nil
end
end


function UISubAct_roledoubleLotteryWin:playLotteryAnim(maxItemColor,boxIndex,callback)
self.isInLotteryAnim=true
local effectId=_effectColor[maxItemColor]





local effectDelay=2.8

self.clickMask:setActive(true)
if self.selectBoxIndex~=boxIndex then
self:selectBox(boxIndex,true)
end
local boxWidget=self:getBoxPanelWidgetBase(boxIndex)

boxWidget:SetChildShowEffect(boxWidgetItemIndex.effect,effectId,true)
boxWidget:SetChildModelAnimationState(boxWidgetItemIndex.boxModel,2160)
if maxItemColor>=eQualityColor.eOrange then

AudioManager.playAudio(652)
else

AudioManager.playAudio(653)
end

local finishDelay=effectDelay+3
self:delayDo(effectDelay,function()
if _this==nil then return end
self.isInLotteryAnim=nil

boxWidget:SetChildShowEffect(boxWidgetItemIndex.effect,0,false)
boxWidget:SetChildModelAnimationState(boxWidgetItemIndex.boxModel,eAnimationID.stand)
self.clickMask:setActive(false)
if callback then
return callback()
end
end)
end


function UISubAct_roledoubleLotteryWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("<color=#efb150>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end



function UISubAct_roledoubleLotteryWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_roledoubleLotteryWin:onItemListChanged(argsTable)
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local lastcount=v[4]
local itemcount=v[5]
self:onItemChanged(changeType,itemguid,itemid,lastcount,itemcount)
end
end

function UISubAct_roledoubleLotteryWin:onItemChanged(changeType,itemguid,itemid,lastcount,itemcount)
if self.showMoneyType[itemid]then
local boxIndex=self.showMoneyType[itemid]
self:refreshMoneyValueByBoxIndex(boxIndex,lastcount)

if boxIndex==self.selectBoxIndex then
self:refreshDrawBtn()
end
end
end

function UISubAct_roledoubleLotteryWin:onMoneyChanged(moneyType,lastVal,val)
if self.showMoneyType[moneyType]then
local boxIndex=self.showMoneyType[moneyType]
self:refreshMoneyValueByBoxIndex(boxIndex,lastVal)

if boxIndex==self.selectBoxIndex then
self:refreshDrawBtn()
end
end
end

function UISubAct_roledoubleLotteryWin:freshToggle(isToggle)
self.jumpAnimToggle:setToggle(isToggle)
end

function UISubAct_roledoubleLotteryWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle
userActorSetting.flushVal('skipRoleDoubleLotteryAnim',isToggle)
self:freshToggle(isToggle)
end


function UISubAct_roledoubleLotteryWin:onDrawBtnOne(boxIndex)
if not boxIndex then
boxIndex=self.selectBoxIndex
end

self.activityData:reqDoubleLotteryDraw(boxIndex,1)
end

function UISubAct_roledoubleLotteryWin:onDrawBtnMany(boxIndex)
if not boxIndex then
boxIndex=self.selectBoxIndex
end

self.activityData:reqDoubleLotteryDraw(boxIndex,2)
end



function UISubAct_roledoubleLotteryWin:onMoneyBtnType1()
local boxIndex=1
local costCfg=self.config.box_cost_item[boxIndex]
local moneyType=costCfg[1]
self:onAddClick(moneyType)
end



function UISubAct_roledoubleLotteryWin:onMoneyBtnType2()
local boxIndex=2
local costCfg=self.config.box_cost_item[boxIndex]
local moneyType=costCfg[1]
self:onAddClick(moneyType)
end



function UISubAct_roledoubleLotteryWin:onTargetRewardBtn()
self:showWindow('UISubAct_roledoubleLottery_TargetWin',{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId})
end



function UISubAct_roledoubleLotteryWin:onProbabilityBtn()
local percentCfgList=self.config.probabilityShow
self:showWindow('UISubAct_roledoubleLottery_PercentWin',{percentList=percentCfgList})
end

function UISubAct_roledoubleLotteryWin:onClickBoxPanel(boxIndex)
self:selectBox(boxIndex)
end

function UISubAct_roledoubleLotteryWin:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end


function UISubAct_roledoubleLotteryWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end


function UISubAct_roledoubleLotteryWin.test_showLotteryAnim(color)
_this:playLotteryAnim(color or 3)
end

function UISubAct_roledoubleLotteryWin:onClickProbability(boxIndex)
self.probabilityRoot:setActive(true)
self.probabilityTween=self.probabilityPanel:setChildDOScale(1,0.2)
local probabilityShow=self.config.probabilityShow
local addIdx=boxIndex==1 and 0 or 2
local add=0
for i=1,2 do
local showInfo=probabilityShow[i+addIdx]
local name=showInfo.name
local rewards=showInfo.rewards
self.probabilityName[i]:setText(FMT.fmt("    {0}",name))
local rewardCnt=#rewards
add=add+math.max(1,math.ceil(rewardCnt/6))*120
self.probabilityList[i]:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local rewardProbability=rewardData[3]
local rewardItem=self.probabilityList[i]:getChildLayoutGroupGridItem(index-1)
local showCountBG=rewardNum>1
local countStr=showCountBG and rewardNum or""
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildText(1,FMT.fmt("{0}%",rewardProbability))
end)
self.winlua:ForceLayoutRect(self.probabilityList[i]:getID())
self.winlua:ForceLayoutRect(self.probabilityName[i]:getID())
end
if boxIndex==2 then
self.probabilityPanel:setChildAnchoredPos(345,0)
else
self.probabilityPanel:setChildAnchoredPos(-220,0)
end
self.winlua:ForceLayoutRect(self.probabilityPanel:getID())

self.probabilityPanel:setChildSizeDelta(557,139+add)
end

function UISubAct_roledoubleLotteryWin:onProbabilityRoot()
self.probabilityRoot:setActive(false)

if self.probabilityTween and self.probabilityTween:IsActive()then
self.probabilityTween:Kill()
end
self.probabilityPanel:setScale(Vector3.zero)
end