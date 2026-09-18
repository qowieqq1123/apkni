







def_class("UISubAct_WanBaoJianShangActWin",UIWindowBase)









function UISubAct_WanBaoJianShangActWin:bindComponents()

self.npcModel=UIObject.get(self,0)
self.speakObj=UIObject.get(self,1)
self.speakText=UIText.get(self,2)
self.timeText=UIText.get(self,3)
self.infoText=UIText.get(self,4)
self.scoreText=UIText.get(self,5)
self.rewardList=UIObject.get(self,6)
self.progressBar=UIProgress.get(self,7)
self.gameBtn=UIButton.get(self,8)
self.gameReddot=UIObject.get(self,9)
self.bgModel=UIObject.get(self,10)

self.gameBtn:setButtonClick(function()self:onGameBtn()end)



end


function UISubAct_WanBaoJianShangActWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.scoreText);self.scoreText=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.gameBtn);self.gameBtn=nil;
_UIObject_release(self.gameReddot);self.gameReddot=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this
local rewardCmpIndex={
targetScore=0,
gotFlag=1,
boxImg=2,
reddot=3,
pointSelect=4,
}



function UISubAct_WanBaoJianShangActWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_WanBaoJianShangActWin:__delete()
self:clearAllTimer()
self:unbindComponents()
_this=nil
end




function UISubAct_WanBaoJianShangActWin:onShow(argtable,afterOnloaded)
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
self.bgModel:setChildUIModelShowTarget(5225,1,{},eAnimationID.stand)
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.boxPunchTweener={}
self.boxDelayTimerList={}
self.punchIntervalTime=2
self:stopAllBoxPunch()

self:refresh(true)
end

function UISubAct_WanBaoJianShangActWin:refresh(isInit)

self:refreshNPCModel(isInit)


self:refreshProgress()


local infoStr=self.config.infoText
self.infoText:setText(infoStr)


self:refreshChangeReddot()


self:setRemainingTimeTimer()
end


function UISubAct_WanBaoJianShangActWin:onHide()
self:clearAllTimer()
self:stopAllBoxPunch()
end


function UISubAct_WanBaoJianShangActWin:refreshProgress()
local targetCount=#self.config.box

local nowValue=0
local boxCfgList=self.config.box
local lastTargetScore=0
local nowScore=self.activityData.data.nowScore
local maxRewardGotScore=self.activityData.data.maxRewardGotScore
for i,v in ipairs(boxCfgList)do
local targetScore=v[1]
if nowScore>=targetScore then
nowValue=nowValue+1/targetCount
else
nowValue=nowValue+(nowScore-lastTargetScore)/(targetScore-lastTargetScore)*(1/targetCount)
break
end
lastTargetScore=targetScore
end
self.winlua:SetChildProgressValue(self.progressBar:getID(),nowValue*100,100)

self.scoreText:setText(nowScore)

local doPunchList={}
local hasNewPunch=false

local girds=self.rewardList:getChildCommonLayoutGroupWidgetList()
local abName="ui/windows/activities/sub_wanbaojianshangact/wanbaojianshangact_box_atlas_pak.ab"
for i=1,girds.Count do
local widget=girds[i-1]
local boxCfg=boxCfgList[i]
if boxCfg then
widget:SetChildActive(-1,true)

local boxIconName=boxCfg[3]
if boxIconName then
widget:SetChildCSImageSprite(rewardCmpIndex.boxImg,abName,boxIconName)
end


local targetScore=boxCfg[1]
widget:SetChildText(rewardCmpIndex.targetScore,targetScore)


local isGot=maxRewardGotScore>=targetScore
widget:SetChildActive(rewardCmpIndex.gotFlag,isGot)

widget:SetChildImageExGray(rewardCmpIndex.boxImg,isGot)


widget:SetChildButtonClick(rewardCmpIndex.boxImg,function()
self:onClickRewardBox(i)
end)


local isFinish=nowScore>=targetScore
local isCanGet=isFinish and not isGot
widget:SetChildActive(rewardCmpIndex.reddot,isCanGet)
widget:SetChildActive(rewardCmpIndex.pointSelect,isFinish)


if isCanGet then
local isDoPunch=self:checkBoxDoPunch(i)

if not hasNewPunch and not isDoPunch then
hasNewPunch=true
end
table.insert(doPunchList,i)
else
self:setBoxDoPunchRotation(i,isCanGet)
end
else
widget:SetChildActive(-1,false)
end
end



if hasNewPunch then
self:stopAllBoxPunch()
end
for _,boxIndex in ipairs(doPunchList)do
self:setBoxDoPunchRotation(boxIndex,true)
end
end

function UISubAct_WanBaoJianShangActWin:refreshChangeReddot()
local reddot=self.activityData:checkDailyChangeReddot()
self.gameReddot:setActive(reddot)
end


function UISubAct_WanBaoJianShangActWin:refreshNPCModel(isInit)
local fadeTime=isInit and 0.5 or 0
self.speakContent=self.config.npcTalk
local npcModelParms=self.config.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=self.config.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=self.config.npcTalkTime
self.npcTalkShowTime=self.config.npcTalkShowTime

if isInit then

self.speakObj:setScale(Vector3.zero)
end


self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UISubAct_WanBaoJianShangActWin:doSpeaking()
self:clearSpeakTimer()
self:clearModelSpeakAnimTimer()

local rand=math.random(1,#self.speakContent)
local speakStr=self.speakContent[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(eAnimationID.button_click)
self.modelSpeakAnimTimer=self:delayDo(2.6,function()
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
end)
self:doTalkAnim()
end


function UISubAct_WanBaoJianShangActWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UISubAct_WanBaoJianShangActWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
if self.modelSpeakAnimTimer then
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
self:clearModelSpeakAnimTimer()
end

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UISubAct_WanBaoJianShangActWin:checkBoxDoPunch(boxIndex)
if self.boxPunchTweener and self.boxPunchTweener[boxIndex]~=nil then
return true
end
return false
end

function UISubAct_WanBaoJianShangActWin:setBoxDoPunchRotation(boxIndex,isPunch)
local widget=self.rewardList:getChildCommonLayoutGroupWidgetItem(boxIndex-1)
if isPunch then
if self.boxPunchTweener[boxIndex]==nil then
self:clearBoxDelayTimerList(boxIndex)
widget:SetChildRotation(rewardCmpIndex.boxImg,0,0,0)
local tweener=widget:SetChildDOPunchRotation(rewardCmpIndex.boxImg,Vector3(0,0,10),1,5,1,function()
if _this==nil then return end
_this.boxDelayTimerList[boxIndex]=_this:delayDo(_this.punchIntervalTime,function()
if _this==nil then return end
if _this.boxPunchTweener[boxIndex]then
_this:setBoxDoPunchRotation(boxIndex,false)
return _this:setBoxDoPunchRotation(boxIndex,isPunch)
end
end)
end)
tweener:SetEase(_Ease.Linear)

self.boxPunchTweener[boxIndex]=tweener
end
else
if self.boxPunchTweener[boxIndex]~=nil then
self.boxPunchTweener[boxIndex]:Complete()
self.boxPunchTweener[boxIndex]:Kill()
self.boxPunchTweener[boxIndex]=nil
widget:SetChildRotation(rewardCmpIndex.boxImg,0,0,0)
end
self:clearBoxDelayTimerList(boxIndex)
end
end

function UISubAct_WanBaoJianShangActWin:stopAllBoxPunch()
for boxIndex,tweener in pairs(self.boxPunchTweener)do
self:setBoxDoPunchRotation(boxIndex,false)
end
end


function UISubAct_WanBaoJianShangActWin:clearBoxDelayTimerList(boxIndex)
if self.boxDelayTimerList[boxIndex]then
self:stopTimerByID(self.boxDelayTimerList[boxIndex])
self.boxDelayTimerList[boxIndex]=nil
end
end





function UISubAct_WanBaoJianShangActWin:onGameBtn()

local callback=function(resultLV,score)
if _this==nil or _this.isClose then return end

_this.activityData:reqAddWBJSActMaxScore(score)

if resultLV==0 then

local winArgs={
extraWin="UISubAct_WanBaoJianShangAct_settlementWin",
extraParams={
score=score,
result=resultLV,
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonLoseWin")
end,
}
UIManager:showWindow("UICommonLoseWin",winArgs)
elseif resultLV==1 then

local winArgs={
extraWin="UISubAct_WanBaoJianShangAct_settlementWin",
extraParams={
score=score,
result=resultLV,
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonVictoryWin")
end,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
end

end
local gameId=self.config.gameId
if not gameId then
logErr("找不到万宝鉴赏活动小游戏id配置 请检查配置是否正确")
return
end

self.activityData:setDailyChangeReddot()
UILittleGameController:openLittleGame(littleGameType.eWanBaoJianShang,{mapId=gameId,showEffect=false},callback)
end


function UISubAct_WanBaoJianShangActWin:onNPCClick()
self:doSpeaking()
end


function UISubAct_WanBaoJianShangActWin:onClickRewardBox(index)
local boxCfgList=self.config.box
local boxCfg=boxCfgList[index]
local dropId=boxCfg[2]
local targetScore=boxCfg[1]
local rewards=zongmenControl:getRewardConfigData(dropId,zongmenModel:getLevel())or{}
local nowScore=self.activityData.data.nowScore
local maxRewardGotScore=self.activityData.data.maxRewardGotScore

local isFinish=nowScore>=targetScore

local isGot=maxRewardGotScore>=targetScore
if not isFinish or isGot then

local content=FMT.fmt("<color=#171311>{0}游戏分数达到<color=#ca631d>{1}</color>分可领取\n以下奖励：</color>",self.config.sub_name,targetScore)
local args={
title='分数奖励',
rewardTitle=-1,
desc1=content,
rewards=rewards,
showCancel=false,
commitName='确定',
}
self:showWindow('UIDialougeRewardWin',args)
else

self.activityData:reqGetWBJSActReward()
end
end


function UISubAct_WanBaoJianShangActWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_WanBaoJianShangActWin:clearAllTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end

if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end

if self.modelSpeakAnimTimer then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
end


function UISubAct_WanBaoJianShangActWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_WanBaoJianShangActWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UISubAct_WanBaoJianShangActWin:clearModelSpeakAnimTimer()
if self.modelSpeakAnimTimer then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
end



function UISubAct_WanBaoJianShangActWin:checkEnd()
local isEnd=false
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.activityData.end_time-nowTime
if lerp<=0 then
isEnd=true
end

return isEnd
end