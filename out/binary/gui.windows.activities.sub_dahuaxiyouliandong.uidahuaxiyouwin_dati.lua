







def_class("UIDaHuaXiYouWin_DaTi",UIWindowBase)









function UIDaHuaXiYouWin_DaTi:bindComponents()

self.answer_1=UIButton.get(self,0)
self.answer_2=UIButton.get(self,1)
self.answer_3=UIButton.get(self,2)
self.answer_4=UIButton.get(self,3)
self.answers=UIObject.get(self,4)
self.background=UIButton.get(self,5)
self.bgmodel=UIObject.get(self,6)
self.bgmodel2=UIObject.get(self,7)
self.ChallengeAgainBtn=UIButton.get(self,8)
self.closeBtn=UIButton.get(self,9)
self.effect=UIObject.get(self,10)
self.effectE=UIObject.get(self,11)
self.FailurePanel=UIObject.get(self,12)
self.FailureText=UIText.get(self,13)
self.leftModel=UIObject.get(self,14)
self.nextBtn=UIButton.get(self,15)
self.nextTopicBtn=UIButton.get(self,16)
self.nextTopicText=UIText.get(self,17)
self.nextTx=UIText.get(self,18)
self.question=UIObject.get(self,19)
self.questionBg=UIObject.get(self,20)
self.questionDesc=UIText.get(self,21)
self.questionDesc2=UIText.get(self,22)
self.questionTx=UIText.get(self,23)
self.quitButton=UIButton.get(self,24)
self.result=UIObject.get(self,25)
self.resultImg=UIImage.get(self,26)
self.resultNumTx=UIText.get(self,27)
self.resultOverTx=UIText.get(self,28)
self.resultRewards=UIObject.get(self,29)
self.resultTx_1=UIObject.get(self,30)
self.resultTx_2=UIObject.get(self,31)
self.rewardContent=UIObject.get(self,32)
self.rewardScrollView=UIObject.get(self,33)
self.rightModel=UIObject.get(self,34)
self.rightTx=UIText.get(self,35)
self.SuccessPanel=UIObject.get(self,36)
self.SuccessRewardContent=UIObject.get(self,37)
self.SuccessrewardScrollView=UIObject.get(self,38)
self.SuccessText=UIText.get(self,39)
self.TipshudBg=UIImage.get(self,40)
self.TipshudTx=UILinkImageText.get(self,41)
self.wrongTx=UIText.get(self,42)
self.ziji=UIObject.get(self,43)
self.bgmodel3=UIObject.get(self,44)

self.answer_1:setButtonClick(function()self:onAnswer_1()end)

self.answer_2:setButtonClick(function()self:onAnswer_2()end)

self.answer_3:setButtonClick(function()self:onAnswer_3()end)

self.answer_4:setButtonClick(function()self:onAnswer_4()end)

self.background:setButtonClick(function()self:onBackground()end)

self.ChallengeAgainBtn:setButtonClick(function()self:onChallengeAgainBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.nextTopicBtn:setButtonClick(function()self:onNextTopicBtn()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)
self.answer={
self.answer_1,
self.answer_2,
self.answer_3,
self.answer_4,
}
self.resultTx={
self.resultTx_1,
self.resultTx_2,
}



end


function UIDaHuaXiYouWin_DaTi:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.answer_1);self.answer_1=nil;
_UIObject_release(self.answer_2);self.answer_2=nil;
_UIObject_release(self.answer_3);self.answer_3=nil;
_UIObject_release(self.answer_4);self.answer_4=nil;
_UIObject_release(self.answers);self.answers=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.bgmodel2);self.bgmodel2=nil;
_UIObject_release(self.ChallengeAgainBtn);self.ChallengeAgainBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effectE);self.effectE=nil;
_UIObject_release(self.FailurePanel);self.FailurePanel=nil;
_UIObject_release(self.FailureText);self.FailureText=nil;
_UIObject_release(self.leftModel);self.leftModel=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.nextTopicBtn);self.nextTopicBtn=nil;
_UIObject_release(self.nextTopicText);self.nextTopicText=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.question);self.question=nil;
_UIObject_release(self.questionBg);self.questionBg=nil;
_UIObject_release(self.questionDesc);self.questionDesc=nil;
_UIObject_release(self.questionDesc2);self.questionDesc2=nil;
_UIObject_release(self.questionTx);self.questionTx=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.result);self.result=nil;
_UIObject_release(self.resultImg);self.resultImg=nil;
_UIObject_release(self.resultNumTx);self.resultNumTx=nil;
_UIObject_release(self.resultOverTx);self.resultOverTx=nil;
_UIObject_release(self.resultRewards);self.resultRewards=nil;
_UIObject_release(self.resultTx_1);self.resultTx_1=nil;
_UIObject_release(self.resultTx_2);self.resultTx_2=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rightModel);self.rightModel=nil;
_UIObject_release(self.rightTx);self.rightTx=nil;
_UIObject_release(self.SuccessPanel);self.SuccessPanel=nil;
_UIObject_release(self.SuccessRewardContent);self.SuccessRewardContent=nil;
_UIObject_release(self.SuccessrewardScrollView);self.SuccessrewardScrollView=nil;
_UIObject_release(self.SuccessText);self.SuccessText=nil;
_UIObject_release(self.TipshudBg);self.TipshudBg=nil;
_UIObject_release(self.TipshudTx);self.TipshudTx=nil;
_UIObject_release(self.wrongTx);self.wrongTx=nil;
_UIObject_release(self.ziji);self.ziji=nil;
_UIObject_release(self.bgmodel3);self.bgmodel3=nil;
self.answer=nil;
self.resultTx=nil;
end
















local _this=nil
local _answerCmp={
wrong=0,
right=1,
cancel=2,
content=3,
icon=4,
}
local _modelCmp={
model=0,
button=1,
speakBg=2,
speakTx=3,
effect=4,
}

local textState=
{
none=1,
right=2,
Error=3,
}
local stringf=string.format

local abName="ui/windows/activities/sub_dahuaxiyouliandong/fangyingtingdati_atlas_pak.ab"



function UIDaHuaXiYouWin_DaTi:onLoaded(argtable)
self:bindComponents()
_this=self
self.leftModelWidget=self.leftModel:getWidgetBase()
self.rightModelWidget=self.rightModel:getWidgetBase()
end


function UIDaHuaXiYouWin_DaTi:__delete()

end




function UIDaHuaXiYouWin_DaTi:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.custom=(self.sub_actcfg and self.sub_actcfg.custonSpineConfig)or{}


self.selectWhichAct=self.myData.selectWhichAct
self.eventCfg=self.sub_actcfg.eventList[self.selectWhichAct]
if self.eventCfg[1]~=eFangYingTingEventType.AnswerQuestion then
UIManager.error('答题配置错误%s',self.selectWhichAct)
return
end

local otherdata=self.eventCfg[2]
self.QuestionBankId=otherdata[2]
self.baseCfg=cfgHelper.get1(cfg_datihuodongconfig_get,self.QuestionBankId)
self.DatiRecord=self.info:getFangYingTing_DatiRc()
if not self.DatiRecord.RecordCfg then
self:resetDatiRc()
else
if self.DatiRecord.RecordCfg.CorrectAnswer and self.DatiRecord.RecordCfg.AnsweredIncorrectly then
if(self.DatiRecord.RecordCfg.CorrectAnswer+self.DatiRecord.RecordCfg.AnsweredIncorrectly)>self.baseCfg.tmNum then
self:resetDatiRc()
end
end
end
self.jiesuan=false

self:showBgModel()
self:showForegroundModel()
self:showJuPaiModel()
self:refreshView()
end


function UIDaHuaXiYouWin_DaTi:showBgModel()

local spine1=self.custom[1]
local bgModelId=6215
if spine1 then
bgModelId=spine1
end


if bgModelId==6215 then
self.bgmodel:setChildUIModelShowTarget(bgModelId,1,nil,-1,false,false,0,function()end)
end
self.bgmodel:setChildUIModelShowTarget(bgModelId,1,nil,eAnimationID.stand,false,false,0,function()end)

end


function UIDaHuaXiYouWin_DaTi:showForegroundModel()

local spine2=self.custom[2]
local bgModelId=6216
if spine2 then
bgModelId=spine2
end


self.bgmodel2:setChildUIModelShowTarget(bgModelId,1,nil,eAnimationID.enter,false,false,0,function()end)

end


function UIDaHuaXiYouWin_DaTi:showJuPaiModel()
local spine3=self.custom[3]
local bgModelId=6217
if spine3 then
bgModelId=spine3
end

self.bgmodel3:setChildUIModelShowTarget(bgModelId,1,nil,eAnimationID.fyt_jupai_open,false,false,0,function()end)
end


function UIDaHuaXiYouWin_DaTi:onHide()

end

function UIDaHuaXiYouWin_DaTi:initView()
local modelcfg=self.baseCfg.model
local leftmodelCfg=modelcfg[1]
local modelParams=npcModel:getImageInfoOutSide(leftmodelCfg[1])
self.leftModel:setChildUIModelShowTarget(modelParams.body,leftmodelCfg[2],modelParams.componets,modelParams.anim)
self.leftModel:setChildAnchoredPosition(Vector2.New(leftmodelCfg[3],leftmodelCfg[4]))
self.leftModel:setChildUIModelShowFlipX(true)
local leftWidget=self.leftModel:getWidgetBase()
leftWidget:SetChildButtonClick(_modelCmp.button,function()self:leftModelClick()end)

local rightModelCfg=modelcfg[2]
modelParams=npcModel:getImageInfoOutSide(rightModelCfg[1])
self.rightModel:setChildUIModelShowTarget(modelParams.body,rightModelCfg[2],modelParams.componets,modelParams.anim)
self.rightModel:setChildAnchoredPosition(Vector2.New(rightModelCfg[3],rightModelCfg[4]))
local rightWidget=self.rightModel:getWidgetBase()
rightWidget:SetChildButtonClick(_modelCmp.button,function()self:rightModelClick()end)

self.answerWidgetList={}
for i,v in ipairs(self.answer)do
self.answerWidgetList[i]=v:getWidgetBase()
self.winlua:SetChildButtonClick(v:getID(),function()
self:onAnswerBtn(i)
end)
end
end

function UIDaHuaXiYouWin_DaTi:showReward()
local otherdata=self.eventCfg[2]
local rewardList=otherdata[1]
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
end


function UIDaHuaXiYouWin_DaTi:leftModelClick()

end

function UIDaHuaXiYouWin_DaTi:rightModelClick()

end


function UIDaHuaXiYouWin_DaTi:refreshView()
self.timuconfig=cfg_datitimuconfig()
self.baseCfg=cfgHelper.get1(cfg_datihuodongconfig_get,self.QuestionBankId)
self:initView()
self:showReward()
self:refresTopicCfg(false)
self:setTipshudBg(true)
end


function UIDaHuaXiYouWin_DaTi:refresTopicCfg(next)
local spfNum=self.baseCfg.spfNum
self.nextTopicBtn:setActive(false)
self.rightTx:setText(string.format("答对(%s/%s)题可获得以下奖励",self.DatiRecord.RecordCfg.CorrectAnswer,spfNum))
_this:setQuestionTx()
_this:setQuestionDesc(textState.none)

local func=function()
if _this then
if next then
local AnimationID=eAnimationID.fyt_jupai_open
self.bgmodel3:setChildModelAnimationState(AnimationID)
end
end
end
self:delayDo(0.3,func)

local func=function()
if _this then
_this.answers:setChildCanvasGroupDOFade(1,0.5)
_this:setQuestionIcon()
if _this.nextTopicTimer then
_this:stopTimerByID(_this.nextTopicTimer)
_this.nextTopicTimer=nil
end
end
end
self:delayDo(0.5,func)
end

function UIDaHuaXiYouWin_DaTi:setQuestionTx()
self.MaxTopicNum=self.baseCfg.tmNum
self.questionTx:setText(stringf("题目%s(%s/%s)",eNumberType:getName(self.DatiRecord.RecordCfg.curAnswerIndex),self.DatiRecord.RecordCfg.curAnswerIndex,self.MaxTopicNum))
end

function UIDaHuaXiYouWin_DaTi:setQuestionDesc(flag,text)
local timuCfgIndex=self.baseCfg.tmLibs[self.DatiRecord.RecordCfg.curAnswerIndex]
self.curTopicCfg=self.timuconfig[timuCfgIndex]
local str=self.curTopicCfg.title

if textState.Error==flag then
text=stringf("（%s）",stringf("<color=#c82c2c>%s</color>",text))
str=string.gsub(str,"%（%s+%）",text)
elseif textState.right==flag then
text=stringf("（%s）",stringf("<color=#549327>%s</color>",text))
str=string.gsub(str,"%（%s+%）",text)
end
local obj=self.questionDesc2:getGameObject()
local width=self.questionDesc2:getChildSizeDeltaX()
str=comHelper.getCheckLayoutStr(obj,width,str)

self.questionDesc:setText(str)
end

function UIDaHuaXiYouWin_DaTi:setQuestionIcon()
local timuCfgIndex=self.baseCfg.tmLibs[self.DatiRecord.RecordCfg.curAnswerIndex]
self.curTopicCfg=self.timuconfig[timuCfgIndex]
local choiceIcon=self.curTopicCfg.choiceIcon
for i,grid in ipairs(self.answerWidgetList)do
local icon=choiceIcon[i]
grid:SetChildCSImage(_answerCmp.icon,abName,icon,false)
grid:SetChildActive(_answerCmp.right,false)
grid:SetChildActive(_answerCmp.wrong,false)
end
end


function UIDaHuaXiYouWin_DaTi:QuestionDescShow(flag)
local timuCfgIndex=self.baseCfg.tmLibs[self.DatiRecord.RecordCfg.curAnswerIndex]
self.curTopicCfg=self.timuconfig[timuCfgIndex]
self.questionDesc:setText(self.curTopicCfg.title)
end

function UIDaHuaXiYouWin_DaTi:onBackground()

end

local Correct=1
local wrong=2
local left=1
local right=2
local newDelayTime=5

function UIDaHuaXiYouWin_DaTi:onAnswerBtn(index)
if self.nextTopicTimer or self.jiesuan then
return
end

local answer=self.curTopicCfg.answer
local grid=self.answerWidgetList[index]
grid:SetChildActive(_answerCmp.right,false)
local answerText=self.curTopicCfg.answerOptions[index]
if index==answer then

self:setQuestionDesc(textState.right,answerText)
grid:SetChildActive(_answerCmp.right,true)

self.DatiRecord.RecordCfg.CorrectAnswer=self.DatiRecord.RecordCfg.CorrectAnswer+1
self.effectE:setChildShowEffect(10232,true)
self:showSpeak(Correct,left)
self:showSpeak(Correct,right)
else

self:setQuestionDesc(textState.Error,answerText)
grid:SetChildActive(_answerCmp.wrong,true)

self.DatiRecord.RecordCfg.AnsweredIncorrectly=self.DatiRecord.RecordCfg.AnsweredIncorrectly+1
self.effectE:setChildShowEffect(10233,true)
self:showSpeak(wrong,left)
self:showSpeak(wrong,right)
end


self.DatiRecord.RecordCfg.curAnswerIndex=self.DatiRecord.RecordCfg.curAnswerIndex+1


if self.DatiRecord.RecordCfg.CorrectAnswer>=self.baseCfg.spfNum then

self.jiesuan=true
if self.baseCfg.successStory==nil then
self:Success()
else
local args={isFullOpen=false,}
local PlotID=self.baseCfg.successStory
local PlotCompletedCD=function()
if _this==nil then return end
_this:Success()
end
worldStoryController:showStoryTree(PlotID,PlotCompletedCD,nil,nil,args)
end
return
else
if self.DatiRecord.RecordCfg.AnsweredIncorrectly>(self.MaxTopicNum-self.baseCfg.spfNum)then

self.jiesuan=true
self:Failure()
return
end
end


self.nextTopicBtn:setActive(true)
_this.nextTopicText:setText(stringf("下一题(%s)",newDelayTime))
self.nextTopicTimer=self:setTimer(1,newDelayTime,function(delay,times,count)
if _this then
_this.nextTopicText:setText(stringf("下一题(%s)",count-1))
if count==1 then
_this:onNextTopicBtn()
end
if count==2 then

end
end
end)
end

local function isChineseChar(char)
return#char==3 and string.byte(char,1)>=0xE0
end


local function insertNewline(text)
local result=""
local len=#text
local i=1
local chineseCount=0

while i<=len do

local byte=string.byte(text,i)
local charLen=(byte>=0xF0 and 4)or
(byte>=0xE0 and 3)or
(byte>=0xC0 and 2)or
1

local char=string.sub(text,i,i+charLen-1)

if isChineseChar(char)then
chineseCount=chineseCount+1
end

if chineseCount==12 then
result=result..char.."\n"
chineseCount=0
else
result=result..char
end
i=i+charLen
end

return result
end

function UIDaHuaXiYouWin_DaTi:showSpeak(result,LR)
local timuindexcfg=self.baseCfg.tmLibs[self.DatiRecord.RecordCfg.curAnswerIndex]
local curtimucfg=self.timuconfig[timuindexcfg]

local speakCfg=result==Correct and curtimucfg.answerStr1 or curtimucfg.answerStr2
local str=speakCfg[LR]

if str and LR==left then
self.leftModelWidget:SetChildActive(_modelCmp.speakBg,true)
str=insertNewline(str)
self.leftModelWidget:SetChildText(_modelCmp.speakTx,str)
self.leftModelWidget:ForceLayoutRect(_modelCmp.speakBg)
end

if str and LR==right then
self.rightModelWidget:SetChildActive(_modelCmp.speakBg,true)
str=insertNewline(str)
self.rightModelWidget:SetChildText(_modelCmp.speakTx,str)
self.rightModelWidget:ForceLayoutRect(_modelCmp.speakBg)
end
self:setTipshudBg(false)
end


function UIDaHuaXiYouWin_DaTi:hideSpeak()
self.leftModelWidget:SetChildActive(_modelCmp.speakBg,false)
self.rightModelWidget:SetChildActive(_modelCmp.speakBg,false)
self:setTipshudBg(true)
end


function UIDaHuaXiYouWin_DaTi:setTipshudBg(flag)
self.TipshudBg:setActive(flag)
self.TipshudTx:setText("请选择最下方的卷轴\n内的图形来进行回答")
self.winlua:ForceLayoutRect(40)
end


function UIDaHuaXiYouWin_DaTi:onNextTopicBtn()
_this.answers:setChildCanvasGroupDOFade(0,0.5)
self.nextTopicBtn:setActive(false)
self:hideSpeak()

local func=function()
if _this then
local AnimationID=eAnimationID.fyt_jupai_close
_this.bgmodel3:setChildModelAnimationState(AnimationID)
end
end
self:delayDo(0.5,func)
local func=function()
if _this then
_this:refresTopicCfg(true)
end
end
self:delayDo(0.8,func)
end


function UIDaHuaXiYouWin_DaTi:resetDatiRc()

self.DatiRecord.RecordCfg={}
self.DatiRecord.RecordCfg.curAnswerIndex=1
self.DatiRecord.RecordCfg.CorrectAnswer=0
self.DatiRecord.RecordCfg.AnsweredIncorrectly=0
self.info:setFangYingTing_DatiRc(self.DatiRecord)
end


function UIDaHuaXiYouWin_DaTi:Failure()
self.FailureText:setText(stringf("答题题目数量：%s题",self.DatiRecord.RecordCfg.CorrectAnswer))

self.answers:setChildCanvasGroupDOFade(0,0.5)
local AnimationID=eAnimationID.fyt_bai_close
self.bgmodel2:setChildModelAnimationState(AnimationID)

local AnimationID=eAnimationID.fyt_jupai_close
self.bgmodel3:setChildModelAnimationState(AnimationID)


self:delayDo(1,function()
if _this then
_this.FailurePanel:setActive(true)
_this.FailurePanel:setChildCanvasGroupDOFade(1,1)
end
end)

self:resetDatiRc()
end



function UIDaHuaXiYouWin_DaTi:Success()

call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_EventStart",self.actID,self.subType,self.subid)

self.answers:setChildCanvasGroupDOFade(0,0)
local AnimationID=eAnimationID.fyt_sheng_close
self.bgmodel2:setChildModelAnimationState(AnimationID)

local AnimationID=eAnimationID.fyt_jupai_close
self.bgmodel3:setChildModelAnimationState(AnimationID)
local otherdata=self.eventCfg[2]
local rewardList=otherdata[1]
self.SuccessRewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.SuccessRewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
self.SuccessText:setText(stringf("答题题目数量：%s题",self.DatiRecord.RecordCfg.CorrectAnswer))


self:delayDo(1,function()
if _this then
_this.SuccessPanel:setActive(true)
_this.SuccessPanel:setChildCanvasGroupDOFade(1,1)
end
end)
self:resetDatiRc()
end



function UIDaHuaXiYouWin_DaTi:onCloseBtn()
self.info:setFangYingTing_DatiRc(self.DatiRecord)
if UIManager:isActive("UIFightPrepareLoading")then
_this:closeSelf()
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
_this:closeSelf()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end
end


function UIDaHuaXiYouWin_DaTi:onQuitButton()
UIManager:callWindowFunc('UIDaHuaXiYouWin','PlotSelectChange')
self:onCloseBtn()
end


function UIDaHuaXiYouWin_DaTi:onChallengeAgainBtn()
local AnimationID=eAnimationID.fyt_bai_open
self.bgmodel2:setChildModelAnimationState(AnimationID)

local AnimationID=eAnimationID.fyt_jupai_open
self.bgmodel3:setChildModelAnimationState(AnimationID)
self:hideSpeak()
self.FailurePanel:setChildCanvasGroupDOFade(0,0)
self.FailurePanel:setActive(false)
self.SuccessPanel:setChildCanvasGroupDOFade(0,0)
self.SuccessPanel:setActive(false)
self:refreshView()
self.jiesuan=false
end




