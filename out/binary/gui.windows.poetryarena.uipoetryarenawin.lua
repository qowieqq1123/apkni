







def_class("UIPoetryArenaWin",UIWindowBase)









function UIPoetryArenaWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.cdTx=UIText.get(self,2)
self.descBg=UIObject.get(self,3)
self.selectBtn=UIButton.get(self,4)
self.timeProgress=UIProgressBarAni.get(self,5)
self.wrongTx=UIText.get(self,6)
self.nextBtn=UIButton.get(self,7)
self.rightTx=UIText.get(self,8)
self.rewardBtn=UIButton.get(self,9)
self.effect=UIObject.get(self,10)
self.effectE=UIObject.get(self,11)
self.questionBg=UIObject.get(self,12)
self.question=UIObject.get(self,13)
self.startBtn=UIButton.get(self,14)
self.result=UIObject.get(self,15)
self.npcModel=UIObject.get(self,16)
self.dzModel=UIObject.get(self,17)
self.questionDesc=UIText.get(self,18)
self.questionTx=UIText.get(self,19)
self.nextTx=UIText.get(self,20)
self.ziji=UIObject.get(self,21)
self.timeProgressTx=UIText.get(self,22)
self.resultImg=UIImage.get(self,23)
self.resultRewards=UIObject.get(self,24)
self.resultNumTx=UIText.get(self,25)
self.resultOverTx=UIText.get(self,26)
self.resultTx_1=UIObject.get(self,27)
self.resultTx_2=UIObject.get(self,28)
self.answer_2=UIButton.get(self,29)
self.answer_3=UIButton.get(self,30)
self.answer_4=UIButton.get(self,31)
self.answer_1=UIButton.get(self,32)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.answer_2:setButtonClick(function()self:onAnswer_2()end)

self.answer_3:setButtonClick(function()self:onAnswer_3()end)

self.answer_4:setButtonClick(function()self:onAnswer_4()end)

self.answer_1:setButtonClick(function()self:onAnswer_1()end)
self.resultTx={
self.resultTx_1,
self.resultTx_2,
}
self.answer={
self.answer_1,
self.answer_2,
self.answer_3,
self.answer_4,
}



end


function UIPoetryArenaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.timeProgress);self.timeProgress=nil;
_UIObject_release(self.wrongTx);self.wrongTx=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.rightTx);self.rightTx=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effectE);self.effectE=nil;
_UIObject_release(self.questionBg);self.questionBg=nil;
_UIObject_release(self.question);self.question=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.result);self.result=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.questionDesc);self.questionDesc=nil;
_UIObject_release(self.questionTx);self.questionTx=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.ziji);self.ziji=nil;
_UIObject_release(self.timeProgressTx);self.timeProgressTx=nil;
_UIObject_release(self.resultImg);self.resultImg=nil;
_UIObject_release(self.resultRewards);self.resultRewards=nil;
_UIObject_release(self.resultNumTx);self.resultNumTx=nil;
_UIObject_release(self.resultOverTx);self.resultOverTx=nil;
_UIObject_release(self.resultTx_1);self.resultTx_1=nil;
_UIObject_release(self.resultTx_2);self.resultTx_2=nil;
_UIObject_release(self.answer_2);self.answer_2=nil;
_UIObject_release(self.answer_3);self.answer_3=nil;
_UIObject_release(self.answer_4);self.answer_4=nil;
_UIObject_release(self.answer_1);self.answer_1=nil;
self.resultTx=nil;
self.answer=nil;
end
















local _this=nil
local _answerCmp={
wrong=0,
right=1,
cancel=2,
content=3,
}
local _modelCmp={
model=0,
button=1,
speakBg=2,
speakTx=3,
effect=4,
}



function UIPoetryArenaWin:onLoaded(argtable)
self:bindComponents()
_this=self

self.winlua:SetProgressBarAniUpdateAction(self.timeProgress:getID(),function(...)
self:onUpdateQuestionProgress(...)
end)




self.dzWidget=self.dzModel:getWidgetBase()
self.npcWidget=self.npcModel:getWidgetBase()

self.arena=poetryArenaModel:getArenaData(argtable.guid)
self.config=cfgHelper.get1(cfg_wendouleitaiconfig_get,self.arena.id)
self.baseCfg=cfgHelper.get1(cfg_wendouleitaibaseconfig_get,1)
self:initView()
end


function UIPoetryArenaWin:__delete()
if not self.arena.question then
poetryArenaModel:setArenaDisciple(self.arena.guid,int64.zero)
end
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end





self:stopActivityTick()
self:stopQuestionTick()

self:unbindComponents()
_this=nil
end




function UIPoetryArenaWin:onShow(argtable,afterOnloaded)
self:refreshView()
end


function UIPoetryArenaWin:onHide()

end




function UIPoetryArenaWin:onCloseBtn()
UIFullPoetryArenaController:closeUI(true)
end


function UIPoetryArenaWin:onRewardBtn()
UIFullPoetryArenaController:showRewardWindow(self.arena.id)
end


function UIPoetryArenaWin:onSelectBtn()
local args={
guid=self.arena.guid,
select=self.arena.disciple,
}
UIFullPoetryArenaController:showSelectWindow(args)
end


function UIPoetryArenaWin:onNextBtn()
local question=self.arena.question
if question and not question.intoNext then
local sTime=question.startTime
local now=timeHelper.getServerShortTime()
local delta=now-sTime
if question.answer>0 or delta>=self.arena.duration then
poetryArenaController.send_248_42(self.arena.guid,question.index+1,self.arena.conghui,timeHelper.getServerShortTime())
end
end
end

function UIPoetryArenaWin:onBackground()
self:onCloseBtn()
end

function UIPoetryArenaWin:onAnswerBtn(index)
local question=self.arena.question
local answerId=question.sort[index]

if question and not question.select and question.answer<=0 and not mathHelper.getBitValue(question.culls,answerId-1)then
local sTime=question.startTime
local now=timeHelper.getServerShortTime()
local delta=now-sTime
if delta<self.arena.duration then
question.select=index
poetryArenaController.send_248_43(self.arena.guid,question.index,question.sort[index],timeHelper.getServerShortTime())
end
end
end

function UIPoetryArenaWin:onStartBtn()
if self.arena.disciple~=int64.zero and self.arena.disciple~=nil then
if not self.arena.started then
local func=function()
poetryArenaController:countDownStart(self.arena.guid,self.arena.disciple,self.arena.conghui)
self:showEffect(1)
self.descBg:setActive(false)
self.rewardBtn:setActive(false)
self.ziji:setActive(true)
self.startBtn:setActive(false)
end
local time=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eWenDouLeiTai)
if time<=self.baseCfg.countdown then
local showdata={
type='UIDialouge',
title='提示',
content="活动即将结束，是否仍要挑战",
oktext='确定',
canceltext='取消',
allowclickBG=false,
okcallback=func,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
func()
end
end
end
end

function UIPoetryArenaWin:onClickDz()
if not self.arena.started then
local args={
guid=self.arena.guid,
select=self.arena.disciple,
}
UIFullPoetryArenaController:showSelectWindow(args)
end
end











function UIPoetryArenaWin:startActivityTick()
if not self.cdTick then
self:onActivityTick()
self.cdTick=self:setTimer(1,0,function()
self:onActivityTick()
end)
end
end

function UIPoetryArenaWin:stopActivityTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
self.cdTx:setText("")
end

function UIPoetryArenaWin:onActivityTick()
local time=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eWenDouLeiTai)
if time<=0 then
self:stopActivityTick()
elseif time<=self.baseCfg.countdown then
local cdStr=FMT.fmt("<color=#F0B559>活动剩余时间:</color>{0}",timeHelper.format_time_stamp2(time))
self.cdTx:setText(cdStr)
end
end

function UIPoetryArenaWin:initView()
local modelParams=npcModel:getImageInfoOutSide(self.config.npc)
self.npcModel:setChildUIModelShowTarget(modelParams.body,0.8,modelParams.componets,modelParams.anim)

self.dzWidget:SetChildButtonClick(_modelCmp.button,function()self:onClickDz()end)
for i,v in ipairs(self.answer)do
self.winlua:SetChildButtonClick(v:getID(),function()
self:onAnswerBtn(i)
end)
end
self:startActivityTick()
end

function UIPoetryArenaWin:refreshDisciple()
self:hideSpeak(self.npcWidget)
self:hideSpeak(self.dzWidget)

if self.arena.disciple==int64.zero then
self.dzModel:setChildUIModelRemoveTarget()
self.dzWidget:SetChildActive(_modelCmp.button,false)
self.npcModel:setChildAnchoredPosition(Vector2.New(0,230))
self.npcModel:setChildUIModelShowFlipX(false)
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
local args={
dzWidget=self.npcWidget,
dzIndex=_modelCmp.model,
speak=self.config.waitStr or self.baseCfg.waitStr,
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_wdlt_npc",nil,true,args,true)












else
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.arena.disciple,false,1)
self.dzModel:setChildUIModelShowTarget(modelParams.body,0.8,modelParams.componets,modelParams.anim)
self.dzModel:setChildUIModelShowFlipX(true)
self.dzWidget:SetChildActive(_modelCmp.button,true)
self.npcModel:setChildAnchoredPosition(Vector2.New(392,230))
self.npcModel:setChildUIModelShowFlipX(false)
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
if not self.arena.started then
local args={
npcWidget=self.npcWidget,
npcSpeak=self.config.startStr1 or self.baseCfg.startStr1,
dzWidget=self.dzWidget,
dzSpeak=self.config.startStr2 or self.baseCfg.startStr2,
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_wdlt_wait",nil,true,args,true)
end




end
end

function UIPoetryArenaWin:refreshStartBtn()
self.startBtn:setActive(not self.arena.started and self.arena.disciple~=int64.zero)
end

function UIPoetryArenaWin:showEffect(index)
local cfg=self.baseCfg.effect0

if index<=4 then
self.effect:setChildShowEffect(cfg[index],true)
else
self.effectE:setChildShowEffect(cfg[index],true)
end


if index==1 then

AudioManager.playAudio(588)
elseif index==2 then

AudioManager.playAudio(589)
elseif index==3 or index==4 then

AudioManager.playAudio(590)
elseif index==5 or index==7 then

AudioManager.playAudio(591)
elseif index==6 then

AudioManager.playAudio(592)
end
end

function UIPoetryArenaWin:showSpeak(widget,lib)
local libId
if type(lib)=="number"then
libId=lib
else
libId=pfwindowsModel:getVersionAndPfCfg(lib)
end
local libCfg=cfgHelper.get1(cfg_wendouleitaitextconfig_get,libId)
local r=math.random(1,#libCfg.lib)
local str=libCfg.lib[r]
widget:SetChildActive(_modelCmp.speakBg,true)
widget:SetChildText(_modelCmp.speakTx,str)
widget:ForceLayoutRect(_modelCmp.speakBg)
end

function UIPoetryArenaWin:hideSpeak(widget)
widget:SetChildActive(_modelCmp.speakBg,false)
end

function UIPoetryArenaWin:checkAnswerEffect()

local question=self.arena.question
if question and question.answer>0 then
local questionCfg=cfgHelper.get1(cfg_wendouleitaitimuconfig_get,question.id)
local isRight=question.answer==questionCfg.answer
self:showEffect(isRight and 2 or 3)
end

end

function UIPoetryArenaWin:refreshModelEffect()
local question=self.arena.question
if question then
local rNum=self.arena.right
local wNum=question.index-rNum-(question.answer<=0 and 1 or 0)
for i=rNum,1,-1 do
local effectId=self.baseCfg.effect2[i]
if effectId then
if self.dzEffect~=effectId then
self.dzEffect=effectId
self.dzWidget:SetChildShowEffect(_modelCmp.effect,effectId,true)
end
break
end
if i==1 then
self.dzWidget:SetChildShowEffect(_modelCmp.effect,-1,false)
self.dzEffect=nil
end
end
for i=wNum,1,-1 do
local effectId=self.baseCfg.effect1[i]
if effectId then
if self.npcEffect~=effectId then
self.npcEffect=effectId
self.npcWidget:SetChildShowEffect(_modelCmp.effect,effectId,true)
end
break
end
if i==1 then
self.npcWidget:SetChildShowEffect(_modelCmp.effect,-1,false)
self.npcEffect=nil
end
end
else
self.dzWidget:SetChildShowEffect(_modelCmp.effect,-1,false)
self.npcWidget:SetChildShowEffect(_modelCmp.effect,-1,false)
self.dzEffect=nil
self.npcEffect=nil
end
end

function UIPoetryArenaWin:refreshSpeak(check)
local question=self.arena.question
if not self.arena.valid and not check then
if self.arena.percent then
local rightNum=self.arena.right
if self.config.spfNum[1]<=rightNum then
self:showSpeak(self.npcWidget,self.config.victoryStr1 or self.baseCfg.victoryStr1)
self:showSpeak(self.dzWidget,self.config.victoryStr2 or self.baseCfg.victoryStr2)
elseif self.config.spfNum[2]<=rightNum then
self:showSpeak(self.npcWidget,self.config.drawStr1 or self.baseCfg.drawStr1)
self:showSpeak(self.dzWidget,self.config.drawStr2 or self.baseCfg.drawStr2)
else
self:showSpeak(self.npcWidget,self.config.defeatedStr1 or self.baseCfg.defeatedStr1)
self:showSpeak(self.dzWidget,self.config.defeatedStr2 or self.baseCfg.defeatedStr2)
end
end
else
if question then
local questionCfg=cfgHelper.get1(cfg_wendouleitaitimuconfig_get,question.id)
if question.answer>0 then
local isRight=question.answer==questionCfg.answer
if questionCfg.answerStr1 and questionCfg.answerStr1[question.answer]then
self:showSpeak(self.npcWidget,questionCfg.answerStr1[question.answer])
else
if isRight then
self:showSpeak(self.npcWidget,self.baseCfg.rightStr1)
else
self:showSpeak(self.npcWidget,self.baseCfg.wrongStr1)
end
end

if questionCfg.answerStr2 and questionCfg.answerStr2[question.answer]then
self:showSpeak(self.dzWidget,questionCfg.answerStr2[question.answer])
else
if isRight then
self:showSpeak(self.dzWidget,self.baseCfg.rightStr2)
else
self:showSpeak(self.dzWidget,self.baseCfg.wrongStr2)
end
end
else
local sTime=question.startTime
local now=timeHelper.getServerShortTime()
local delta=now-sTime
if not question.select and delta>=self.arena.duration then
self:showSpeak(self.npcWidget,questionCfg.timeoutStr1 or self.baseCfg.timeoutStr1)
self:showSpeak(self.dzWidget,questionCfg.timeoutStr2 or self.baseCfg.timeoutStr2)
else
self:hideSpeak(self.npcWidget)
self:hideSpeak(self.dzWidget)
end
end
else







end
end
end

function UIPoetryArenaWin:showResult()
self:stopQuestionTick()
self:checkStartQuestion()


local show=not self.arena.valid and self.arena.percent~=nil
self.result:setActive(show)
if show then
self:refreshSpeak(false)
self.question:setActive(false)
self.questionBg:setScale(Vector3.zero)
self.nextBtn:setActive(false)
self.timeProgress:setActive(false)

local rightNum=self.arena.right
local percent=self.arena.percent
self.resultNumTx:setText(FMT.fmt("<color=#7D3B17>答对题目数：</color>{0}题",rightNum))
self.resultOverTx:setText(FMT.fmt("超越了<color=#CA631D>{0}%</color>的仙友",percent))
local effectType=nil
local rewardList=nil
if self.config.spfNum[1]<=rightNum then
effectType=5
rewardList=self.config.winRewards
elseif self.config.spfNum[2]<=rightNum then
effectType=7
rewardList=self.config.equalRewards
else
effectType=6
rewardList=self.config.failRewards
end


self.resultTx_2:setActive(false)
self.resultTx_1:setActive(false)
self.resultRewards:setActive(true)
local level=zongmenModel:getLevel()

self:showEffect(effectType)
for i,v in ipairs(rewardList)do

if v[1]<=level and level<=v[2]then
local itemList=v[3]
self.resultRewards:setChildLayoutGroupCreateItems(#itemList,function(index)
local item=self.resultRewards:getChildLayoutGroupGridItem(index-1)
local itemData=itemList[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClickEx(...)end)
end)
return
end
end













end
end

function UIPoetryArenaWin:refreshSelectBtn()
self.selectBtn:setActive(not mathHelper.validInt64(self.arena.disciple))
end

function UIPoetryArenaWin:refreshDesc()
self.descBg:setActive(not self.arena.started)
self.rewardBtn:setActive(not self.arena.started)
self.ziji:setActive(self.arena.started)
end

function UIPoetryArenaWin:onRefreshDisciple(guid)
if mathHelper.compareInt64(self.arena.guid,guid)then
self:refreshDisciple()
self:refreshSelectBtn()
self:refreshStartBtn()
self:refreshSpeak()
end
end

function UIPoetryArenaWin:onEnterQuestion(guid)
if mathHelper.compareInt64(self.arena.guid,guid)then

self:hideSpeak(self.npcWidget)
self:hideSpeak(self.dzWidget)
self:refreshStartBtn()
self:checkStartQuestion()
end
end

function UIPoetryArenaWin:onSelectQuestion(guid)
if mathHelper.compareInt64(self.arena.guid,guid)then

self:checkStartQuestion()
self:refreshSpeak(true)

self:checkAnswerEffect()
self:refreshModelEffect()
end
end

function UIPoetryArenaWin:onFinishQuestion(guid)
if mathHelper.compareInt64(self.arena.guid,guid)then
local question=self.arena.question
if question then
local eIdx=4
local answer=cfgHelper.get2(cfg_wendouleitaitimuconfig_get,question.id,"answer")
local temp=0
if question.answer>0 then
eIdx=question.answer==answer and 2 or 3
else
temp=self.arena.duration
end
local eId=cfgHelper.get3(cfg_wendouleitaibaseconfig_get,1,"effect0",eIdx)
local eDuration=cfgHelper.get2(cfg_effectconfig_get,eId,"lifetime")or 1000
eDuration=eDuration/1000
local now=timeHelper.getServerShortTime()
local delay=now-question.startTime-temp+eDuration

if delay>0 then
self:delayDo(delay,function()
self:showResult()
end)
else
self:showResult()
end
else
self:showResult()
end
end
end

function UIPoetryArenaWin:refreshView()
self:refreshDisciple()
self:refreshStartBtn()
self:refreshSelectBtn()
self:refreshDesc()
self:refreshSpeak()

if self.arena.started then

self:showResult()
self:refreshModelEffect()
end
end

function UIPoetryArenaWin:checkStartQuestion()

if self.arena.question then
local question=self.arena.question
local questionCfg=cfgHelper.get1(cfg_wendouleitaitimuconfig_get,question.id)
local now=timeHelper.getServerShortTime()
local pass=now-question.startTime


self.rightTx:setText(self.arena.right)
local wrongNum=self.arena.question.index-self.arena.right
if self.arena.question.result==0 then
wrongNum=wrongNum-1
end
self.wrongTx:setText(wrongNum)

self.question:setActive(true)
self.questionBg:setScale(Vector3.one)
self.questionTx:setText(FMT.fmt("题目{0}（{1}/{2}）",mathHelper.numberToChinese(question.index),question.index,self.config.tmNum))
self.questionDesc:setText(questionCfg.title)
local culls=question.culls
local selected=question.answer
local right=questionCfg.answer
for i,v in ipairs(self.answer)do
local answerWidget=v:getWidgetBase()
local answerId=question.sort[i]
local answerTx=questionCfg.choice[answerId]
answerWidget:SetChildText(_answerCmp.content,answerTx)
answerWidget:SetChildActive(_answerCmp.cancel,mathHelper.getBitValue(culls,answerId-1))
answerWidget:SetChildActive(_answerCmp.right,selected>0 and answerId==right)
answerWidget:SetChildActive(_answerCmp.wrong,selected==answerId and selected~=right)
end

self.timeProgress:setActive(true)
if question.answer<=0 and question.select==nil then
local progress=math.min(pass,self.arena.duration)
local least=self.arena.duration-progress
self.timeProgress:animateThreeParams(least*100,self.arena.duration*100,0)
self.timeProgress:animateFourParams(0,self.arena.duration*100,least,true)



end

if self.arena.duration<=pass and question.index<self.config.tmNum then
local wait=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"nextWait")

local eTime=question.startTime+(selected>0 and wait or(self.arena.duration+wait))
local least=math.max(eTime-now,0)
self.nextBtn:setActive(true)
local leastStr=least>0 and FMT.fmt("（{0}）",least)or least
self.nextTx:setText(FMT.fmt("下一题{0}",leastStr))
else
self.nextBtn:setActive(false)
end

self:startQuestionTick()
else
self.question:setActive(false)
self.questionBg:setScale(Vector3.zero)
self.nextBtn:setActive(false)
self.timeProgress:setActive(false)
self.rightTx:setText("")
self.wrongTx:setText("")
self:stopQuestionTick()
end
end

function UIPoetryArenaWin:startQuestionTick()
if not self.questionTick then

self.questionTick=self:setTimer(0.5,0,function()
self:onQuestionTick()
end)
end
end

function UIPoetryArenaWin:stopQuestionTick()
if self.questionTick then
self:stopTimerByID(self.questionTick)
self.questionTick=nil
end
end

function UIPoetryArenaWin:onQuestionTick()
local question=self.arena.question
local questionCfg=cfgHelper.get1(cfg_wendouleitaitimuconfig_get,question.id)
local now=timeHelper.getServerShortTime()
local pass=now-question.startTime
local inQuestion=pass<self.arena.duration and question.answer<=0 and question.select==nil
if inQuestion then
local btnActive=self.winlua:GetChildActiveSelf(self.nextBtn:getID())
if btnActive then
self.nextBtn:setActive(false)
end
end
if pass>=self.arena.duration or question.answer>0 then
if question.index<self.config.tmNum then
local wait=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"nextWait")
local least=0
if question.index<self.config.tmNum then
local eTime=question.startTime+(question.answer>0 and wait or(self.arena.duration+wait))
least=math.max(eTime-now,0)
end
local leastStr=least>0 and FMT.fmt("（{0}）",least)or least
self.nextTx:setText(FMT.fmt("下一题{0}",leastStr))
local btnActive=self.winlua:GetChildActiveSelf(self.nextBtn:getID())
if not btnActive then
self.nextBtn:setActive(true)
if question.answer<=0 and question.select==nil then
self:showSpeak(self.npcWidget,questionCfg.timeoutStr1 or self.baseCfg.timeoutStr1)
self:showSpeak(self.dzWidget,questionCfg.timeoutStr2 or self.baseCfg.timeoutStr2)
self:showEffect(4)
end
end
elseif question.answer<=0 and question.select==nil then
self:showSpeak(self.npcWidget,questionCfg.timeoutStr1 or self.baseCfg.timeoutStr1)
self:showSpeak(self.dzWidget,questionCfg.timeoutStr2 or self.baseCfg.timeoutStr2)
self:showEffect(4)
self:stopQuestionTick()
end
end
end

function UIPoetryArenaWin:fadeQuestion(guid)
if mathHelper.compareInt64(guid,self.arena.guid)then
local cmp=self.question:getID()
self.winlua:SetChildCanvasGroupAlpha(cmp,0)
self.questionBg:setScale(Vector3.one)
self.questionBg:setChildModelAnimationState(2082,1,function()
self.winlua:SetChildCanvasGroupDOFade(cmp,1,1)
end)
self:hideSpeak(self.npcWidget)
self:hideSpeak(self.dzWidget)
end
end

function UIPoetryArenaWin:onUpdateQuestionProgress(progress,time)
local timeTx=timeHelper.format_time_stamp2(math.floor(progress*self.arena.duration))
self.timeProgressTx:setText(timeTx)

local question=self.arena.question
if question.answer>0 then
self.timeProgress:animateThreeParams(progress*self.arena.duration*100,self.arena.duration*100,0)
end
end




