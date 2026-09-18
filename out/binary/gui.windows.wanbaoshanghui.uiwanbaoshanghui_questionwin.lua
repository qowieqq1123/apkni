







def_class("UIWanBaoShangHui_questionWin",UIWindowBase)









function UIWanBaoShangHui_questionWin:bindComponents()

self.npcModel=UIObject.get(self,0)
self.speakObj=UIObject.get(self,1)
self.speakText=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.repairTips=UIText.get(self,4)
self.rewardBtn=UIButton.get(self,5)
self.finishCount=UIText.get(self,6)
self.reddot=UIObject.get(self,7)
self.questionPanel=UIObject.get(self,8)
self.questionNum=UIText.get(self,9)
self.questionDesc=UIText.get(self,10)
self.answerList=UIObject.get(self,11)
self.rewardTips=UIText.get(self,12)
self.finishQuestionTips=UIObject.get(self,13)
self.name=UIText.get(self,14)
self.questionMask=UIObject.get(self,15)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIWanBaoShangHui_questionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.repairTips);self.repairTips=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.finishCount);self.finishCount=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.questionPanel);self.questionPanel=nil;
_UIObject_release(self.questionNum);self.questionNum=nil;
_UIObject_release(self.questionDesc);self.questionDesc=nil;
_UIObject_release(self.answerList);self.answerList=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.finishQuestionTips);self.finishQuestionTips=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.questionMask);self.questionMask=nil;
end


local _this
















function UIWanBaoShangHui_questionWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIWanBaoShangHui_questionWin:__delete()
self:clearAllTimer()
self:unbindComponents()
_this=nil
end




function UIWanBaoShangHui_questionWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self.baseConfig=cfgHelper.get1(cfg_wanbaoshanghuibaseconfig_get,1)
self:initWin()
end


function UIWanBaoShangHui_questionWin:onHide()
self:clearAllTimer()
end

function UIWanBaoShangHui_questionWin:initWin()
self:initData()
self:refresh(true)
end

function UIWanBaoShangHui_questionWin:initData()



local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)

local nowTime=timeHelper.getServerShortTime()

local beginTime=cddata.beginTime or nowTime

self.todayIndex=timeHelper.getPassDay(timeHelper.convertLongStamp(beginTime))
end

function UIWanBaoShangHui_questionWin:refresh(isInit)

self:refreshNPCModel(isInit)


self:refreshInfo()


self:refreshQuestion()
end


function UIWanBaoShangHui_questionWin:refreshNPCModel(isInit)

local npcName=self.baseConfig.npcName or"未知名称"
self.name:setText(npcName)

local fadeTime=isInit and 0.5 or 0

self.speakContent=self.baseConfig.npcTalk
self.speakContent_finishAnswer=self.baseConfig.npcTalk_finishAnswer
self.speakContent_true=self.baseConfig.npcTalk_true
self.speakContent_false=self.baseConfig.npcTalk_false
local npcModelParms=self.baseConfig.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=self.baseConfig.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=self.baseConfig.npcTalkTime
self.npcTalkShowTime=self.baseConfig.npcTalkShowTime

if isInit then

self:delayDo(0.3,function()
self:doSpeaking()
end)
end
end


function UIWanBaoShangHui_questionWin:doSpeaking(isAnswerSpeak,answerResult)
self:clearSpeakTimer()
self:clearModelSpeakAnimTimer()

local speakStr
if isAnswerSpeak then

local speakContentList
if answerResult then

speakContentList=self.speakContent_true
else

speakContentList=self.speakContent_false
end

local count=#speakContentList
if count>1 then

local randomIndex=math.random(1,count)
speakStr=speakContentList[randomIndex]
else

speakStr=speakContentList[1]
end
else

local questionDayCfg=cfgHelper.get1(cfg_wanbaoshanghuiconfig_get,self.todayIndex)
local answeredCount=wanBaoShangHuiModel:getWBSHAnsweredQuestionIndex()
local maxQuestionCount=#questionDayCfg
local isFinishAnswered=answeredCount>=maxQuestionCount
if not isFinishAnswered then

speakStr=self.speakContent
else

speakStr=self.speakContent_finishAnswer
end
end

if speakStr then
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(eAnimationID.button_click)
self.modelSpeakAnimTimer=self:delayDo(2.6,function()
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
end)
self:doTalkAnim()
end
end


function UIWanBaoShangHui_questionWin:doTalkAnim()
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


function UIWanBaoShangHui_questionWin:talkEnd()
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

function UIWanBaoShangHui_questionWin:refreshInfo()

local desc=self.baseConfig.repairDesc
self.desc:setText(desc)









self:setRemainingTimeTimer()

end

function UIWanBaoShangHui_questionWin:refreshQuestion()
if self.delayTimer then

return
end

if self.answerDayIndex and self.answerDayIndex~=self.todayIndex then

return
end

local questionDayCfg=cfgHelper.get1(cfg_wanbaoshanghuiconfig_get,self.todayIndex)


local answeredCount=wanBaoShangHuiModel:getWBSHAnsweredQuestionIndex()
local maxQuestionCount=#questionDayCfg
local isFinishAnswered=answeredCount>=maxQuestionCount

self.questionPanel:setActive(not isFinishAnswered)
self.finishQuestionTips:setActive(isFinishAnswered)

if not isFinishAnswered then

local questionIndex=answeredCount+1
local questionData=questionDayCfg[questionIndex]
if questionData then

self.questionNum:setText(FMT.fmt("第 {0} 题",questionData.qid))
self.questionDesc:setText(questionData.question)


local optionList=questionData.option
local optionCount=#optionList
local grids=self.answerList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local optionItem=grids[i-1]
if i<=optionCount then
optionItem:SetChildActive(-1,true)

local optionDesc=optionList[i]
optionItem:SetChildText(0,optionDesc)


optionItem:SetChildButtonClick(-1,function()
self:clickOption(questionData.qid,i)
end)


optionItem:SetChildActive(1,false)
optionItem:SetChildActive(2,false)
else
optionItem:SetChildActive(-1,false)
end
end
end
end



local isGotReward=wanBaoShangHuiModel:getWBSHGetQuestionRewardFlag()
self.rewardBtn:setActive(not isGotReward)

self.canGotReward=not isGotReward and isFinishAnswered
self.reddot:setActive(self.canGotReward)
self:doPunchRotation(self.canGotReward)
self.finishCount:setText(FMT.fmt("({0}/{1})",answeredCount,maxQuestionCount))
end


function UIWanBaoShangHui_questionWin:answeredQuestionRecv(qid,answeredIndex)
local questionDayIndex=self.todayIndex
if self.answerDayIndex~=self.todayIndex then

questionDayIndex=self.answerDayIndex
end


local questionCfg=cfgHelper.get2(cfg_wanbaoshanghuiconfig_get,questionDayIndex,qid)
if questionCfg then
local trueAnswer=questionCfg.answer
local isTrue=answeredIndex==trueAnswer
local optionSelectItem=self.answerList:getChildCommonLayoutGroupWidgetItem(answeredIndex-1)
optionSelectItem:SetChildActive(1,isTrue)
optionSelectItem:SetChildActive(2,not isTrue)
if not isTrue then

local trueOptionItem=self.answerList:getChildCommonLayoutGroupWidgetItem(trueAnswer-1)
trueOptionItem:SetChildActive(1,true)
trueOptionItem:SetChildActive(2,false)
end


self.questionMask:setActive(true)


self:doSpeaking(true,isTrue)

self:clearDelayTimer()

self.delayTimer=self:delayDo(1,function()

self.answerDayIndex=nil
self.delayTimer=nil
self:refreshQuestion()
self.questionMask:setActive(false)
end)
end
end




function UIWanBaoShangHui_questionWin:onRewardBtn()

if wanBaoShangHuiModel:getWBSHGetQuestionRewardFlag()then

UIManager.error("您已领取过今日的额外奖励了")
return
end


if not self.canGotReward then

UIManager.error("您还未完成今日所有答题")
return
end


wanBaoShangHuiController:reqWBSHGetQuestionReward()
end


function UIWanBaoShangHui_questionWin:onNPCClick()
self:doSpeaking()
end


function UIWanBaoShangHui_questionWin:clickOption(questionIndex,optionIndex)
if self.selectAnswerIndex==optionIndex then
return
end



self.answerDayIndex=self.todayIndex


wanBaoShangHuiController:reqWBSHAnswerQuestion(questionIndex,optionIndex)

end


function UIWanBaoShangHui_questionWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UIWanBaoShangHui_questionWin:clearModelSpeakAnimTimer()
if self.modelSpeakAnimTimer then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
end


function UIWanBaoShangHui_questionWin:clearDelayTimer()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
end


function UIWanBaoShangHui_questionWin:clearAllTimer()
self:clearTimer()
self:clearSpeakTimer()
self:clearModelSpeakAnimTimer()
self:clearDelayTimer()
self:doPunchRotation(false)
end


function UIWanBaoShangHui_questionWin:onCloseClick()
self:closeSelf()
end

function UIWanBaoShangHui_questionWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.reddot:setRotation(0,0,0)
local tweener=self.reddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.reddot:setRotation(0,0,0)
end
end
end



function UIWanBaoShangHui_questionWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()


local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
local lerp=cddata.cd or 0
if lerp>0 then
local timeStr
if lerp>=3600 then

timeStr=timeHelper.format_time_stamp8(lerp)
else

timeStr=timeHelper.format_time_stamp12(lerp)
end
self.repairTips:setText(FMT.fmt("万宝商会将在{0}后建造完成",timeStr))
else

self.repairTips:setText("万宝商会已建造完成")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIWanBaoShangHui_questionWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end