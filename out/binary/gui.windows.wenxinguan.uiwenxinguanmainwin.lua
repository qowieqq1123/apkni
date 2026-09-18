







def_class("UIWenXinGuanMainWin",UIWindowBase)









function UIWenXinGuanMainWin:bindComponents()

self.actorModelRoot=UIObject.get(self,0)
self.actorRoot=UIObject.get(self,1)
self.answerText1=UIText.get(self,2)
self.answerText2=UIText.get(self,3)
self.backButton=UIButton.get(self,4)
self.choiceEffect=UIObject.get(self,5)
self.choicePos=UIObject.get(self,6)
self.choicePos1=UIObject.get(self,7)
self.clickEffect=UIObject.get(self,8)
self.clickGuide=UIButton.get(self,9)
self.descListPanel=UIObject.get(self,10)
self.devilbg=UIObject.get(self,11)
self.devilImg=UIObject.get(self,12)
self.devilText=UIText.get(self,13)
self.Effect_devil=UIObject.get(self,14)
self.Effect_Immortal=UIObject.get(self,15)
self.Effect_people=UIObject.get(self,16)
self.Effect_stand=UIObject.get(self,17)
self.emojiRoot=UIObject.get(self,18)
self.goBtn=UIButton.get(self,19)
self.goingImg=UIObject.get(self,20)
self.HLRoot=UIObject.get(self,21)
self.iconDevil=UIObject.get(self,22)
self.iconImmortal=UIObject.get(self,23)
self.iconPeople=UIImage.get(self,24)
self.immortalbg=UIObject.get(self,25)
self.immortalBtnImg1=UIObject.get(self,26)
self.immortalBtnImg2=UIObject.get(self,27)
self.immortalImg=UIObject.get(self,28)
self.immortalText=UIText.get(self,29)
self.itemPanel=UIObject.get(self,30)
self.jindu_1=UIObject.get(self,31)
self.jindu_10=UIObject.get(self,32)
self.jindu_2=UIObject.get(self,33)
self.jindu_3=UIObject.get(self,34)
self.jindu_4=UIObject.get(self,35)
self.jindu_5=UIObject.get(self,36)
self.jindu_6=UIObject.get(self,37)
self.jindu_7=UIObject.get(self,38)
self.jindu_8=UIObject.get(self,39)
self.jindu_9=UIObject.get(self,40)
self.jindus_1=UIObject.get(self,41)
self.jindus_10=UIObject.get(self,42)
self.jindus_2=UIObject.get(self,43)
self.jindus_3=UIObject.get(self,44)
self.jindus_4=UIObject.get(self,45)
self.jindus_5=UIObject.get(self,46)
self.jindus_6=UIObject.get(self,47)
self.jindus_7=UIObject.get(self,48)
self.jindus_8=UIObject.get(self,49)
self.jindus_9=UIObject.get(self,50)
self.leftPos=UIObject.get(self,51)
self.people=UIObject.get(self,52)
self.picture=UIImage.get(self,53)
self.questionButton1=UIObject.get(self,54)
self.questionButton2=UIObject.get(self,55)
self.questionRoot=UIObject.get(self,56)
self.questionText=UIText.get(self,57)
self.reaction=UIObject.get(self,58)
self.reddot=UIObject.get(self,59)
self.rightPos=UIObject.get(self,60)
self.Root=UIObject.get(self,61)
self.skipBtn=UIButton.get(self,62)
self.skipCheckBtn=UIButton.get(self,63)
self.skipSelectImg=UIObject.get(self,64)
self.speakObj=UIObject.get(self,65)
self.speakText=UIText.get(self,66)
self.standText=UIText.get(self,67)
self.stepCostRoot=UIObject.get(self,68)
self.stepText=UIText.get(self,69)
self.titleText=UIText.get(self,70)
self.wenxinImg=UIObject.get(self,71)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.clickGuide:setButtonClick(function()self:onClickGuide()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.skipCheckBtn:setButtonClick(function()self:onSkipCheckBtn()end)
self.jindu={
self.jindu_1,
self.jindu_2,
self.jindu_3,
self.jindu_4,
self.jindu_5,
self.jindu_6,
self.jindu_7,
self.jindu_8,
self.jindu_9,
self.jindu_10,
}
self.jindus={
self.jindus_1,
self.jindus_2,
self.jindus_3,
self.jindus_4,
self.jindus_5,
self.jindus_6,
self.jindus_7,
self.jindus_8,
self.jindus_9,
self.jindus_10,
}
self.Effect={
["devil"]=self.Effect_devil,
["Immortal"]=self.Effect_Immortal,
["people"]=self.Effect_people,
["stand"]=self.Effect_stand,
}



end


function UIWenXinGuanMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorModelRoot);self.actorModelRoot=nil;
_UIObject_release(self.actorRoot);self.actorRoot=nil;
_UIObject_release(self.answerText1);self.answerText1=nil;
_UIObject_release(self.answerText2);self.answerText2=nil;
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.choiceEffect);self.choiceEffect=nil;
_UIObject_release(self.choicePos);self.choicePos=nil;
_UIObject_release(self.choicePos1);self.choicePos1=nil;
_UIObject_release(self.clickEffect);self.clickEffect=nil;
_UIObject_release(self.clickGuide);self.clickGuide=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.devilbg);self.devilbg=nil;
_UIObject_release(self.devilImg);self.devilImg=nil;
_UIObject_release(self.devilText);self.devilText=nil;
_UIObject_release(self.Effect_devil);self.Effect_devil=nil;
_UIObject_release(self.Effect_Immortal);self.Effect_Immortal=nil;
_UIObject_release(self.Effect_people);self.Effect_people=nil;
_UIObject_release(self.Effect_stand);self.Effect_stand=nil;
_UIObject_release(self.emojiRoot);self.emojiRoot=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.goingImg);self.goingImg=nil;
_UIObject_release(self.HLRoot);self.HLRoot=nil;
_UIObject_release(self.iconDevil);self.iconDevil=nil;
_UIObject_release(self.iconImmortal);self.iconImmortal=nil;
_UIObject_release(self.iconPeople);self.iconPeople=nil;
_UIObject_release(self.immortalbg);self.immortalbg=nil;
_UIObject_release(self.immortalBtnImg1);self.immortalBtnImg1=nil;
_UIObject_release(self.immortalBtnImg2);self.immortalBtnImg2=nil;
_UIObject_release(self.immortalImg);self.immortalImg=nil;
_UIObject_release(self.immortalText);self.immortalText=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jindu_1);self.jindu_1=nil;
_UIObject_release(self.jindu_10);self.jindu_10=nil;
_UIObject_release(self.jindu_2);self.jindu_2=nil;
_UIObject_release(self.jindu_3);self.jindu_3=nil;
_UIObject_release(self.jindu_4);self.jindu_4=nil;
_UIObject_release(self.jindu_5);self.jindu_5=nil;
_UIObject_release(self.jindu_6);self.jindu_6=nil;
_UIObject_release(self.jindu_7);self.jindu_7=nil;
_UIObject_release(self.jindu_8);self.jindu_8=nil;
_UIObject_release(self.jindu_9);self.jindu_9=nil;
_UIObject_release(self.jindus_1);self.jindus_1=nil;
_UIObject_release(self.jindus_10);self.jindus_10=nil;
_UIObject_release(self.jindus_2);self.jindus_2=nil;
_UIObject_release(self.jindus_3);self.jindus_3=nil;
_UIObject_release(self.jindus_4);self.jindus_4=nil;
_UIObject_release(self.jindus_5);self.jindus_5=nil;
_UIObject_release(self.jindus_6);self.jindus_6=nil;
_UIObject_release(self.jindus_7);self.jindus_7=nil;
_UIObject_release(self.jindus_8);self.jindus_8=nil;
_UIObject_release(self.jindus_9);self.jindus_9=nil;
_UIObject_release(self.leftPos);self.leftPos=nil;
_UIObject_release(self.people);self.people=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.questionButton1);self.questionButton1=nil;
_UIObject_release(self.questionButton2);self.questionButton2=nil;
_UIObject_release(self.questionRoot);self.questionRoot=nil;
_UIObject_release(self.questionText);self.questionText=nil;
_UIObject_release(self.reaction);self.reaction=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.rightPos);self.rightPos=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipCheckBtn);self.skipCheckBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.standText);self.standText=nil;
_UIObject_release(self.stepCostRoot);self.stepCostRoot=nil;
_UIObject_release(self.stepText);self.stepText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.wenxinImg);self.wenxinImg=nil;
self.jindu=nil;
self.jindus=nil;
self.Effect=nil;
end


















local this
local endPos={35,30}
local immortalPosList={-241,-215,-188,-157,-123,-94,-66}
local devilPosList={237,209,183,152,118,88,60}

local abname="ui/windows/wenxinguan/wenxinguan_atlas_pak.ab"

local effectType={
["stand"]=20424,
["run"]=20425,
["walk"]=20425,
}

local stateType={
["stand"]=eAnimationID.stand,
["run"]=eAnimationID.run,
["walk"]=eAnimationID.walk,
}



function UIWenXinGuanMainWin:onLoaded(...)
this=self
self:bindComponents()
self.config=cfg_wenxinguanbaseconfig_get(1)
self.tmConfig=cfg_wenxinguantimuconfig()
self.canClickBtn=true
self.stepCount=WenXinGuanModel:getDzFinishnum()
self.xmzUp=0

if self.stepCount>=1 then
self.HLRoot:setActive(false)
self:recoveryBgModel()
self.actorRoot:setChildDOAnchorPosX(0,0)

if self.stepCount>=6 then
self.people:setChildDORotation(Vector3(0,0,5),0,DG.Tweening.RotateMode.Fast)
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
end


function UIWenXinGuanMainWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)
end




function UIWenXinGuanMainWin:onShow(argtable,afterOnloaded)
self.isFirstOpen=argtable.isFirstOpen
self.discipleGuid=argtable.guid
self.return_jump_param=argtable.return_jump_param

self:showBgModel()
self:refreshActorModel()
self:refreshStepCost()
self:showXMZPos()
self:refreshSKipCheck()

self:refreshPeopleEffect("stand")
end


function UIWenXinGuanMainWin:onHide()

end

function UIWenXinGuanMainWin:refreshSKipCheck()
local state=WenXinGuanModel:getFinishDzCount()>=5 or false
self.skipCheckBtn:setActive(state)
end


function UIWenXinGuanMainWin.onMoneyChange(moneyType,lastVal,val)
this:refreshStepCost()
end

function UIWenXinGuanMainWin:recoveryBgModel()
this.HLRoot:setChildUIModelRemoveTarget()
end

function UIWenXinGuanMainWin:showBgModel()
local animId=eAnimationID.stand
this.HLRoot:setChildUIModelShowTarget(5548,1,{},animId,false,false,0)
this.devilImg:setChildUIModelShowTarget(5546,1,{},animId,false,false,0)
this.immortalImg:setChildUIModelShowTarget(5545,1,{},animId,false,false,0)

UIManager:showWindow("UIWenXinGuanMainBgWin",self.stepCount)
local tweener=self.Root:setChildCanvasGroupDOFade(1,1.5)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:refreshXMZUp(value)
self.xmzUp=value
end


function UIWenXinGuanMainWin:showXMZPos()
self.iconPeople:setActive(false)
self.xmz_xian,self.xmz_mo=WenXinGuanModel:getDzXMZ(self.discipleGuid)

if self.xmz_xian>0 then
if self.xmz_xian>=8 then
local pos=endPos[1]
self.iconImmortal:setChildDOAnchorPosX(0,0)
self.iconImmortal:setChildDOAnchorPosY(pos,0)

self.iconPeople:setActive(true)
self.iconPeople:setCSImageSprite(abname,iconXMType.immortal)

self.Effect_people:setChildShowEffect(20428,true)
else
local pos=immortalPosList[self.xmz_xian]
self.iconImmortal:setChildDOAnchorPosX(pos,0)
end
end

if self.xmz_mo>0 then
if self.xmz_mo>=8 then
local pos=endPos[2]
self.winlua:SetChildScale(self.iconDevil:getID(),Vector3(0.8,0.8,0.8))
self.iconDevil:setChildDOAnchorPosX(0,0)
self.iconDevil:setChildDOAnchorPosY(pos,0)

self.iconPeople:setActive(true)
self.iconPeople:setCSImageSprite(abname,iconXMType.devil)

self.Effect_people:setChildShowEffect(20427,true)
else
local pos=devilPosList[self.xmz_mo]
self.iconDevil:setChildDOAnchorPosX(pos,0)
end
end
end


function UIWenXinGuanMainWin:refreshXMZ()
self.xmz_xian,self.xmz_mo=WenXinGuanModel:getDzXMZ(self.discipleGuid)

if self.xmzUp==1 then
self:refreshXMZUp(0)
self.Effect_Immortal:setChildShowEffect(20423,true)

if self.xmz_xian>=8 then
local pos=endPos[1]
self.iconImmortal:setChildDOAnchorPosX(0,2.5)
self.iconImmortal:setChildDOAnchorPosY(pos,2.5)

self.iconPeople:setActive(true)
self.iconPeople:setCSImageSprite(abname,iconXMType.immortal)

self:delayDo(2.3,function()
self.Effect_people:setChildShowEffect(20428,true)
end)
else
local pos=immortalPosList[self.xmz_xian]
self.iconImmortal:setChildDOAnchorPosX(pos,2.5)
end
end

if self.xmzUp==2 then
self:refreshXMZUp(0)
self.Effect_devil:setChildShowEffect(20421,true)

if self.xmz_mo>=8 then
local pos=endPos[2]
self.winlua:SetChildScale(self.iconDevil:getID(),Vector3(0.8,0.8,0.8))
self.iconDevil:setChildDOAnchorPosX(0,2.5)
self.iconDevil:setChildDOAnchorPosY(pos,2.5)

self.iconPeople:setActive(true)
self.iconPeople:setCSImageSprite(abname,iconXMType.devil)

self:delayDo(2.3,function()
self.Effect_people:setChildShowEffect(20427,true)
end)
else
local pos=devilPosList[self.xmz_mo]
self.iconDevil:setChildDOAnchorPosX(pos,2.5)
end
end
end


function UIWenXinGuanMainWin:refreshPeopleEffect(effectId)
local effectid=effectType[effectId]
self.people:setChildShowEffect(effectid,true)
end

function UIWenXinGuanMainWin:refreshActorModelAnim(id,flag)
local animId=stateType[id]
self:refreshPeopleEffect(id)

if flag then
self.actorModelRoot:setChildModelAnimationState(stateType["walk"])
self:delayDo(1,function()
self.actorModelRoot:setChildModelAnimationState(animId)
end)
else
self.actorModelRoot:setChildModelAnimationState(animId)
end
end

function UIWenXinGuanMainWin:onDoFadeQuestionRoot(value,callBack)
self.tweener=self.questionRoot:setChildCanvasGroupDOFade(value,1,callBack)
self.tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:refreshActorModel(animId)
local dzScale=1
local animId=animId or eAnimationID.stand
local info=UIDiscipleModel:getDiscipleImageInfo(self.discipleGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)

self.actorModelRoot:setChildUIModelShowTarget(modelParams.body,dzScale,modelParams.componets,animId)
self.actorModelRoot:setChildUIModelShowFlipX(true)
end

function UIWenXinGuanMainWin:doFadeActorModel(value,duration,callback)
local tweener=self.actorRoot:setChildCanvasGroupDOFade(value,duration,callback)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:refreshActorModelPos(callback,duration)
local pos=0
local duration=duration
local callback=callback
self.tweener=self.actorRoot:setChildDOAnchorPosX(pos,duration,callback)
self.tweener:SetEase(DG.Tweening.Ease.Linear)
self:delayDo(duration,function()
self.HLRoot:setActive(false)
end)
end

function UIWenXinGuanMainWin:doRotateBackground(rate,callback)
self.people:setChildDORotation(Vector3(0,0,rate),2.5,DG.Tweening.RotateMode.Fast)
UIManager:invokeUIMethod("UIWenXinGuanMainBgWin","doRotateBackground",rate,callback)
end

function UIWenXinGuanMainWin:onSetSpeedBackground(speed)
UIManager:invokeUIMethod("UIWenXinGuanMainBgWin","onSetSpeedBackground",speed)
end

function UIWenXinGuanMainWin:onDoFadeGoingImg(value,cb)
local tweener=self.goingImg:setChildCanvasGroupDOFade(value,1,cb)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:onDoFadeStepCost(value,callback)
local tweener=self.stepCostRoot:setChildCanvasGroupDOFade(value,1,callback)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:onDoFadePicture(value)
local tweener=self.wenxinImg:setChildCanvasGroupDOFade(value,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:resetXMFade()
if this.tweenerDevil then
this.tweenerDevil:Kill()
end

if this.tweenerImmortal then
this.tweenerImmortal:Kill()
end

if this.tweenerTalkDevil then
this.tweenerTalkDevil:Kill()
end

if this.tweenerTalkImmortal then
this.tweenerTalkImmortal:Kill()
end
end

function UIWenXinGuanMainWin:onDoFadeImmortal(value,callBack)
self.tweenerImmortal=self.immortalImg:setChildCanvasGroupDOFade(value,1,callBack)
self.tweenerImmortal:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:onDoFadeDevil(value,callBack)
self.tweenerDevil=self.devilImg:setChildCanvasGroupDOFade(value,1,callBack)
self.tweenerDevil:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:onDoFadeImmortalText(value,time,callBack)
self.tweenerTalkImmortal=self.immortalbg:setChildCanvasGroupDOFade(value,time,callBack)
self.tweenerTalkImmortal:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:onDoFadeDevilText(value,time,callBack)
self.tweenerTalkDevil=self.devilbg:setChildCanvasGroupDOFade(value,time,callBack)
self.tweenerTalkDevil:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:checkIsHaveTextConfig(type,isChoice,isEnd)
local talk
local tmID=WenXinGuanModel:getDzTmId()
local answer=WenXinGuanModel:getDzChoice()
local config=self.tmConfig[tmID]

if type==1 then
talk=config.talkA
else
talk=config.talkB
end

if isChoice and type==1 then
talk=self.config.ctalkA[answer]
elseif isChoice and type==2 then
talk=self.config.ctalkB[answer]
elseif isEnd then
talk=config.endtalk[answer]
end

if talk then
return 1
end

return 0
end


function UIWenXinGuanMainWin:refreshImmortalTalk(isChoice,isEnd)
local answer=WenXinGuanModel:getDzChoice()
local tmID=WenXinGuanModel:getDzTmId()
local config=self.tmConfig[tmID]
local talk=config.talkA
if not talk then talk=''end

if isChoice then
config=self.config.ctalkA[answer]
local index=math.random(1,#config)
talk=config[index]
end

self.immortalText:setText(talk)
end


function UIWenXinGuanMainWin:refreshDevilTalk(isChoice,isEnd)
local answer=WenXinGuanModel:getDzChoice()
local tmID=WenXinGuanModel:getDzTmId()
local config=self.tmConfig[tmID]
local talk=config.talkB
if not talk then talk=''end

if isChoice then
config=self.config.ctalkB[answer]
local index=math.random(1,#config)
talk=config[index]
end

self.devilText:setText(talk)
end


function UIWenXinGuanMainWin:refreshTopicDesc()
local tmID=WenXinGuanModel:getDzTmId()
if not tmID or tmID==0 then
self.canClickBtn=true
return
end

local config=self.tmConfig[tmID]
local desc=config.desc
local choiceA=config.choiceA
local choiceB=config.choiceB

self.answerText1:setText(choiceA)
self.answerText2:setText(choiceB)
self.questionText:setText(desc)
end

function UIWenXinGuanMainWin:killStep()
local callBack=function()

this:resetQustionChoice()
if this.stepCount>=10 then
WenXinGuanModel:clearDzFinishWXG(this.discipleGuid)
this:jumpToTransferWinDelay()
else
this:onDoFadePicture(1)
this:refreshStepCost()
this:onDoFadeStepCost(1,function()this.canClickBtn=true end)
end
end

this:doFadeStand(0)
this:onDoFadeDevil(0)
this:doFadeSkipBtn(0)
this:onDoFadeImmortal(0)
this:onDoFadeDevilText(0,0)
this:onDoFadeImmortalText(0,0)
this:onDoFadeQuestionRoot(0,callBack)
WenXinGuanModel:clearDzAnswer()
end

function UIWenXinGuanMainWin:onSkipBtn()
if this.tweener then
this.tweener:Kill()
end

if this.clickGuidTweener then
this.clickGuidTweener:Kill()
end

if this.emojiTimer then
this:stopTimerByID(this.emojiTimer)
this.emojiTimer=nil
end

if this.talkTimer then
this:stopTimerByID(this.talkTimer)
this.talkTimer=nil
end

this:doFadeEmoji(0)
this:onDoFadeGoingImg(0)
this:onSetSpeedBackground(0)
this:refreshActorModelAnim("stand")

this:resetXMFade()
this:refreshXMZ()
this:resetSpeakObj()
this:resetSpecialityItem()
this:resetChoiceTimer()

this:killStep()
end

function UIWenXinGuanMainWin:onSkipCheckBtn()
if not self.skipState then
self.skipState=true
else
self.skipState=false
end

self.skipSelectImg:setActive(self.skipState)
end


function UIWenXinGuanMainWin:jumpToTransferWinDelay()
local winName,posX,posY=WenXinGuanModel:checkDzIsFinishWXG(self.discipleGuid)




this.picture:setActive(true)
this.picture:setChildCanvasGroupDOFade(1,0.5)
this:refreshActorModelAnim("walk")

local argstable={
guid=this.discipleGuid,
return_jump_param=this.return_jump_param,
}

this:delayDo(1,function()







this.canClickBtn=true
UIManager:showWindow(winName,argstable)
end)

local cb=function()
this:refreshActorModelAnim("stand")
end

local cbKill=function()
self:onBackButton(true)
end

local sequence=Lua.SequenceProxy.New()
local tweener=this.actorRoot:setChildDOAnchorPosX(posX,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tweener)
tweener=this.actorRoot:setChildDOAnchorPosY(posY,1,cb)
tweener:SetEase(DG.Tweening.Ease.Linear)
sequence:Insert(0,tweener)
tweener=this.Root:setChildCanvasGroupDOFade(0,0.8,cbKill)
tweener:SetEase(DG.Tweening.Ease.Linear)
sequence:Insert(0.5,tweener)
end

function UIWenXinGuanMainWin:resetQustionChoice()
self.clickGuide:setActive(false)

self.immortalBtnImg1:setChildCanvasGroupDOFade(0,0)
self.immortalBtnImg2:setChildCanvasGroupDOFade(0,0)
self.questionButton1:setChildCanvasGroupDOFade(0,0)
self.questionButton2:setChildCanvasGroupDOFade(0,0)

this.winlua:SetChildDOAnchorPosX(self.questionButton1:getID(),178,0)
this.winlua:SetChildDOAnchorPosX(self.questionButton2:getID(),556,0)
self.winlua:SetChildAnchoredPosition(self.choiceEffect:getID(),Vector3.zero)

self.winlua:SetChildScale(self.questionButton1:getID(),Vector3(1,1,1))
self.winlua:SetChildScale(self.questionButton2:getID(),Vector3(1,1,1))
end

function UIWenXinGuanMainWin:doFadeClickGuide(value)
local play
local effectid
if value==1 then
play=true
effectid=10045
self.clickGuide:setActive(true)
self.clickGuidTweener=self.clickGuide:setChildCanvasGroupDOFade(value,1)
self.clickGuidTweener:SetEase(DG.Tweening.Ease.Linear)
else
play=false
effectid=0
self.clickGuide:setChildCanvasGroupDOFade(value,0,function()
self.clickGuide:setActive(false)
end)
end

self.clickEffect:setChildShowEffect(effectid,play)
end

function UIWenXinGuanMainWin:doFadeChoice()
local cb=function()
self.choiceSequence=nil
this:doFadeClickGuide(1)
end

self.choiceSequence=Lua.SequenceProxy.New()
local tweener=self.questionButton1:setChildCanvasGroupDOFade(1,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
self.choiceSequence:Append(tweener)
tweener=self.questionButton2:setChildCanvasGroupDOFade(1,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
self.choiceSequence:Append(tweener)
self.choiceSequence:AppendCallback(cb)
end

function UIWenXinGuanMainWin:resetChoiceTimer()
if self.choiceSequence then
self.choiceSequence:TogglePause()
end

if self.hideQueSequence then
self.hideQueSequence:TogglePause()
end

if this.choiceTimer then
this:stopTimerByID(this.choiceTimer)
this.choiceTimer=nil
end

if self.choiceTweener~=nil then
self.choiceTweener:Kill()
self.choiceTweener=nil
end

if self.choiceItemTweener~=nil then
self.choiceItemTweener:Kill()
self.choiceItemTweener=nil
end
end




function UIWenXinGuanMainWin:playChoicEffect(choice)
local rx=choice==2 and-5 or 5
local ry=-3
local choiceTran=choice==2 and this.choicePos or this.choicePos1

local endPos1=choiceTran:getChildPosition()
local btnTran=choice==2 and this.questionButton1 or this.questionButton2

local effectId1=choice==2 and 22514 or 22511
local effectId2=choice==2 and 22515 or 22512
local effectId3=choice==2 and 22516 or 22513

local spos=this.winlua:GetChildPosition(this.choiceEffect:getID())
local tran=this.winlua:GetCommonComponent(this.choiceEffect:getID(),'Transform')

local call=function()
local cb=function()
self:refreshXMZ(true)
self:delayDo(0.7,function()
this:killStep()
end)
end

this.choiceEffect:setChildShowEffect(effectId2,true)
this.choiceTimer=this:delayDo(1.2,function()
this.choiceTimer=nil
this.choiceEffect:setChildShowEffect(effectId3,true)
end)

this.choiceTweener=_DOTweenProxy.DoPath(tran,{endPos1,Vector3(spos.x+rx,spos.y+ry,0),Vector3(endPos1.x+rx,endPos1.y-ry,0)},1.5,_pathType.CubicBezier)
this.choiceTweener:SetEase(DG.Tweening.Ease.OutQuad)
this.choiceTweener:OnComplete(cb)
end

this.choiceEffect:setChildShowEffect(effectId1,true)
this.choiceItemTweener=this.winlua:SetChildDOScale(btnTran:getID(),0,0.5,call)
end


function UIWenXinGuanMainWin:hideQuestionAnswer(type,callback)
if type==1 then
self.hideQueSequence=Lua.SequenceProxy.New()
local tweener=self.questionButton1:setChildCanvasGroupDOFade(0,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
self.hideQueSequence:Append(tweener)
tweener=this.winlua:SetChildDOAnchorPosX(self.questionButton2:getID(),367,0.5)
tweener:SetEase(DG.Tweening.Ease.Linear)
self.hideQueSequence:Append(tweener)
self.hideQueSequence:AppendCallback(callback)
else
self.hideQueSequence=Lua.SequenceProxy.New()
local tweener=self.questionButton2:setChildCanvasGroupDOFade(0,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
self.hideQueSequence:Append(tweener)
tweener=this.winlua:SetChildDOAnchorPosX(self.questionButton1:getID(),367,0.5)
tweener:SetEase(DG.Tweening.Ease.Linear)
self.hideQueSequence:Append(tweener)
self.hideQueSequence:AppendCallback(callback)
end
end


function UIWenXinGuanMainWin:showQuestionAnswer()
local answer=WenXinGuanModel:getDzChoice()

local value1=0
local value2=0
local stateA=answer==1 or false
local stateB=answer==2 or false

if stateA then
value1=1
local cb=function()
local time=0.5
local value=self:checkIsHaveTextConfig(1,true,false)
if value==0 then time=0 end
local cbHide=function()
local cb_end=function()
self:delayDo(0.5,function()
self:playChoicEffect(2)
end)
end

local time=0.5
local value=self:checkIsHaveTextConfig(2,true,false)
if value==0 then time=0 end

self:delayDo(0.5,function()
self:onDoFadeDevil(1)
self:delayDo(0.2,function()
self:onDoFadeDevilText(value,time,function()
self:hideQuestionAnswer(2,cb_end)
self.talkTimer=self:delayDo(1,function()
self.talkTimer=nil
self:onDoFadeImmortalText(0,0.5,nil)
self:onDoFadeDevilText(0,0.5)
end)
end)
end)
end)

end

self:onDoFadeImmortal(1)
self:refreshDevilTalk(true,false)
self:refreshImmortalTalk(true,false)
self:delayDo(0.2,function()
self:onDoFadeImmortalText(value,time,cbHide)
end)
end
local tweener1=self.immortalBtnImg1:setChildCanvasGroupDOFade(1,1,cb)
tweener1:SetEase(DG.Tweening.Ease.Linear)
else
local tweener1=self.questionButton1:setChildCanvasGroupDOFade(0.5,1)
tweener1:SetEase(DG.Tweening.Ease.Linear)
end

if stateB then
value2=1
local cb=function()
local time=0.5
local value=self:checkIsHaveTextConfig(1,true,false)
if value==0 then time=0 end
local cbHide=function()
local time=0.5
local value=self:checkIsHaveTextConfig(2,true,false)
if value==0 then time=0 end

local cb_end=function()
self:delayDo(0.5,function()
self:playChoicEffect(1)
end)
end

self:delayDo(0.5,function()
self:onDoFadeImmortal(1)
self:delayDo(0.2,function()
self:onDoFadeImmortalText(value,time,function()
self:hideQuestionAnswer(1,cb_end)
self.talkTimer=self:delayDo(1,function()
self.talkTimer=nil
self:onDoFadeImmortalText(0,0.5,nil)
self:onDoFadeDevilText(0,0.5)
end)
end)
end)
end)
end

self:onDoFadeDevil(1)
self:refreshDevilTalk(true,false)
self:refreshImmortalTalk(true,false)
self:delayDo(0.2,function()
self:onDoFadeDevilText(value,time,cbHide)
end)
end

local tweener2=self.immortalBtnImg2:setChildCanvasGroupDOFade(1,1,cb)
tweener2:SetEase(DG.Tweening.Ease.Linear)
else
local tweener2=self.questionButton2:setChildCanvasGroupDOFade(0.5,1)
tweener2:SetEase(DG.Tweening.Ease.Linear)
end

if answer==3 then
local cb=function()
local time=0.5
local value=self:checkIsHaveTextConfig(1,true,false)
if value==0 then time=0 end

local cbHide=function()
local time=0.5
local value=self:checkIsHaveTextConfig(2,true,false)
if value==0 then time=0 end

local cb_end=function()
self:refreshXMZ(true)
this:killStep()
end

self:delayDo(0.5,function()
self:onDoFadeImmortal(1)
self:delayDo(0.2,function()
self:onDoFadeImmortalText(value,time,function()
self.talkTimer=self:delayDo(1.5,function()
self.talkTimer=nil
self:onDoFadeImmortalText(0,0.5,nil)
self:onDoFadeDevilText(0,0.5,cb_end)
end)
end)
end)
end)
end

self:onDoFadeDevil(1)
self:refreshDevilTalk(true,false)
self:refreshImmortalTalk(true,false)
self:delayDo(0.2,function()
self:onDoFadeDevilText(value,time,cbHide)
end)
end

local tweener1=self.questionButton1:setChildCanvasGroupDOFade(0.5,1)
tweener1:SetEase(DG.Tweening.Ease.Linear)
local tweener2=self.questionButton2:setChildCanvasGroupDOFade(0.5,1,cb)
tweener2:SetEase(DG.Tweening.Ease.Linear)
end
end


function UIWenXinGuanMainWin:doFadeStand(value,callBack)
self.standTweener=self.standText:setChildCanvasGroupDOFade(value,1,callBack)
self.standTweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:refreshStand(value)
local netData=UIDiscipleModel:getDiscipleData(self.discipleGuid)
local stand=cfgHelper.get2(cfg_disciplestandconfig_get,netData.stand,'name')
self.standText:setText(string.format("立场：%s",stand))

local cb=function()
local animCb=function()
local callBack=function()
self:returnSpeAnim()
self:doSpeaking()
end
self:doSpeDisapperAnim(callBack)
end

local time
local tmId=WenXinGuanModel:getDzTmId()
self:refreshSpecialityItem(tmId)

if self.desclist and next(self.desclist)then
time=1
else
time=0
end

self:doFadeSpecialityItem(value,animCb,time)
end

self:doFadeStand(value,cb)
end

function UIWenXinGuanMainWin:returnSpeAnim()
if this.desclist then
local count=#this.desclist
local gridlist=this.descListPanel:getChildLayoutGroupGridList()

if count>0 then
self:delayDo(1,function()
for i=1,count do
local item=gridlist[i-1]
local endPos=Vector3(0,0,0)

item:SetChildDOScale(3,1,0)
item:SetChildAnchoredPosition(2,endPos)
end
end)

end
end
end

function UIWenXinGuanMainWin:resetSpecialityItem()
if this.desclist then
local gridlist=this.descListPanel:getChildLayoutGroupGridList()
local count=#this.desclist

if not gridlist then return end
for i=1,count do
local item=gridlist[i-1]
item:SetChildShowEffect(2,0,false)
end
end

if this.speTimer then
this:stopTimerByID(this.speTimer)
this.speTimer=nil
end

if self.speTweener~=nil then
self.speTweener:Kill()
self.speTweener=nil
end

if self.itemTweener~=nil then
self.itemTweener:Kill()
self.itemTweener=nil
end

if self.standTweener~=nil then
self.standTweener:Kill()
self.standTweener=nil
end

if self.fadeSpeTweener~=nil then
self.fadeSpeTweener:Kill()
self.fadeSpeTweener=nil
end

self:returnSpeAnim()
self:doFadeSpecialityItem(0,nil,0)
end

function UIWenXinGuanMainWin:doSpeDisapperAnim(callBack)
local cb
local doAnim
local i=0
local gridlist=this.descListPanel:getChildLayoutGroupGridList()
local count=#this.desclist
local halfCount=math.floor(count/2)

if count>0 then

cb=function()
i=i+1

if i<count then
doAnim(i)
else
this:doFadeSpecialityItem(0,callBack,0.1)
end
end


doAnim=function(i)
local effectId1=22514
local effectId2=22515
local effectId3=22516
local item=gridlist[i]
local call=function()
local temp
local rx=-5
local ry=-3
if i+1<=halfCount then
temp=this.leftPos
else
rx=5
temp=this.rightPos
end

if this.speList and this.speList[i+1]then
local type=this.speList[i+1]

if type==2 then
effectId1=22511
effectId2=22512
effectId3=22513
end
end

local spos=item:GetChildPosition(2)
local tran=item:GetCommonComponent(2,'Transform')
local endPos=this.winlua:GetChildPosition(temp:getID())

item:SetChildShowEffect(2,effectId2,true)
self.speTimer=this:delayDo(0.8,function()
self.speTimer=nil
item:SetChildShowEffect(2,effectId3,true)
end)

self.speTweener=_DOTweenProxy.DoPath(tran,{endPos,Vector3(spos.x+rx,spos.y+ry,0),Vector3(endPos.x+rx,endPos.y-ry,0)},1,_pathType.CubicBezier)
self.speTweener:SetEase(DG.Tweening.Ease.OutQuad)
self.speTweener:OnComplete(cb)
end

item:SetChildShowEffect(2,effectId1,true)
self.itemTweener=item:SetChildDOScale(3,0,0.5,call)
end

doAnim(i)
else

self:doFadeSpecialityItem(0,callBack,0)
end
end


function UIWenXinGuanMainWin:doFadeSpecialityItem(value,callBack,time)
self.fadeSpeTweener=self.descListPanel:setChildCanvasGroupDOFade(value,time,callBack)
self.fadeSpeTweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainWin:clearSpecialityItem()
this.descListPanel:setChildLayoutGroupClearAllItems()
end

function UIWenXinGuanMainWin:refreshSpecialityItem(tmId)

self.speList={}
this.descListPanel:setChildLayoutGroupClearAllItems()
self.desclist=WenXinGuanModel:getSpeListByTm(tmId,self.discipleGuid)


local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local data=self.desclist[i]
local id=data.id
local typo=data.typo
local item=gridlist[i-1]
local cfg=UIDiscipleModel:getSpecialityConfig(typo,id)

local name=UIDiscipleModel.getSpecialityNameStr(cfg.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(cfg.framecolor)

item:SetChildText(0,name)
item:SetChildCSImageSprite(1,abName,frameIcon)
item:SetChildActive(2,true)

local type=WenXinGuanModel:checkSpestate(typo,id)
table.insert(self.speList,type)
end
end
end

function UIWenXinGuanMainWin:onDescSlotClick(idx,cfg,item)
UIManager:showWindow('UISpecialityWin',{item=item,node='top',guid=self.disciple_guid,config=cfg})
end

function UIWenXinGuanMainWin:doFadeEmoji(value)
local time=0
local endValue=0
if self.stepCount>5 and value>0 then
time=1.5
endValue=value
end

self.emojiTimer=self:delayDo(time,function()
self.emojiRoot:setChildCanvasGroupDOFade(endValue,0.5)
end)
end

function UIWenXinGuanMainWin:doFadeReaction(endValue)
self.reaction:setChildCanvasGroupDOFade(endValue,0.5)
end

function UIWenXinGuanMainWin:doFadeSkipBtn(endValue)
local cb
local time=0

if endValue==1 then
self.skipBtn:setActive(true)
if self.stepCount==1 or self.stepCount==6 then
time=4
end
elseif endValue==0 then
cb=function()
self.skipBtn:setActive(false)
end
end

self:delayDo(time,function()
self.skipBtn:setChildCanvasGroupDOFade(endValue,1,cb)
end)
end





function UIWenXinGuanMainWin:onClickGuide()
this:doFadeClickGuide(0)
self:refreshStand(1)
end


function UIWenXinGuanMainWin:onBackButton(isTran)
if self.stepCount==10 and not self.canClickBtn then return end
local guid=self.discipleGuid
UIManager:invokeUIMethod("UIWenXinGuanMainBgWin","closeWindow")
fullScreenUI.clearAllCallback()

if isTran then
UIFullWenXinGuanMainControl:closeUI(true)
else
if self.isFirstOpen then
UIManager:closeWindow('UIWenXinGuanMainWin')
else
if not self.return_jump_param then
UIFullWenXinGuanMainControl:closeUI(true)
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=guid})
else
jumpManager:jump(self.return_jump_param)
end
end
end
end


function UIWenXinGuanMainWin:onGoBtn()
if not self.canClickBtn then return end
if not self:checkIsEnoughCost()then return end

self.canClickBtn=false
self.isFirstOpen=false
WenXinGuanModel:checkTmAndAnswer(self.discipleGuid)

if not self.skipState then
self:onDoFadePicture(0)
self:onDoFadeStepCost(0)

self:delayDo(0.5,function()
local cb=function()
self:doFadeChoice()
end

local callback=function()
local callBack=function()
self:refreshTopicDesc()
self:onDoFadeQuestionRoot(1,cb)
end
self.tweener=nil
self:doFadeEmoji(0)
self:onDoFadeGoingImg(0,callBack)
self:onSetSpeedBackground(0)
self:refreshActorModelAnim("stand")
end

local speed=0.3
local duration=0
local anim="run"

if self.stepCount>5 then
speed=0.1
anim="walk"
end

if self.stepCount==1 then
duration=2
speed=0
elseif self.stepCount==6 then
duration=3.5
self:delayDo(1,function()
self:doRotateBackground(5)
end)
elseif self.stepCount>=7 then
duration=2+(self.stepCount-5)*0.5
else
duration=4
end



local len=WenXinGuanModel:getFinishDzCount()
if len and len>=1 then
self:doFadeSkipBtn(1)
end

self:onDoFadeGoingImg(1)
self:onSetSpeedBackground(speed)
self:refreshActorModelAnim(anim)
self:doFadeEmoji(1)
self:refreshActorModelPos(callback,duration)
end)
else
local cb=function()
if self.stepCount==1 then
self:refreshActorModelPos(nil,0)
end

self:refreshActorModelAnim("walk")
self:doFadeActorModel(1,0.5,function()
UIManager.info(string.format('问心关·%s 已完成',mathHelper.numberToChinese(self.stepCount)))
self:refreshActorModelAnim("stand")
self:refreshXMZ()
end)
end

self:refreshActorModelAnim('run')
self:doFadeActorModel(0,0.5,cb)

self:delayDo(2.5,function()
this.canClickBtn=true
this:refreshStepCost()
WenXinGuanModel:clearDzAnswer()
if this.stepCount>=10 then
WenXinGuanModel:clearDzFinishWXG(this.discipleGuid)
this:jumpToTransferWinDelay()
end
end)
end
end

function UIWenXinGuanMainWin:resetSpeakObj()
if this.doTalk1 then
this:stopTimerByID(this.doTalk1)
this.doTalk1=nil
end

if this.speakShowTimer then
this:stopTimerByID(this.speakShowTimer)
this.speakShowTimer=nil
end

if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end

self.speakObj:setChildCanvasGroupAlpha(0)
self.winlua:SetChildScale(self.speakObj:getID(),Vector3.zero)
end


function UIWenXinGuanMainWin:doSpeaking()
local speakStr
local speed=30
if pfwindowslController:checkIsGameVersion_yuenan()then
speed=80
end
local answer=WenXinGuanModel:getDzChoice()
local tmID=WenXinGuanModel:getDzTmId()
local config=self.tmConfig[tmID]

if config then
if config.dztalk and config.dztalk[answer]then
speakStr=config.dztalk[answer]
end
end

if speakStr then
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end
end

function UIWenXinGuanMainWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end

self.winlua:SetChildScale(self.speakObj:getID(),Vector3.zero)
self.doTalk=self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScaleY(1.2,0.2,function()
if self==nil then return end
self.talkTween=nil
self.talkTween=self.speakObj:setChildDOScale(0.8,0.1,function()
if self==nil then return end
self.talkTween=nil
return self:talkEnd()
end)
end)
end)
end

function UIWenXinGuanMainWin:talkEnd()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(2.5,function()

if self==nil then return end
self.winlua:SetChildScale(self.speakObj:getID(),Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(0)
self:showQuestionAnswer()

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end

function UIWenXinGuanMainWin:refreshStepCount()
self.stepCount=WenXinGuanModel:getDzFinishnum()
end

function UIWenXinGuanMainWin:checkIsEnoughCost(flag)
if self.itemList then
for k,v in ipairs(self.itemList)do
if v then
local itemId=v[1]
local needNum=v[2]
local haveNum=itemsModel.getCount(itemId)

if haveNum<needNum then
local name=itemsModel.getName(itemId)
if not flag then
gainControl:showGainWin(itemId)
local str=string.format("%s数量不足，无法进行问心关",name)
UIManager.error(str)
end
return false
end
end
end
return true
end
end

function UIWenXinGuanMainWin:refreshStepPoint()
local all=10

for i=1,all do
local temp=self.jindus[i]
if i<=self.stepCount then
temp:setActive(true)
else
temp:setActive(false)
end
end
end


function UIWenXinGuanMainWin:refreshStepCost()
if not self.config or not self.config.dtitems then
logErr('配置表读取失败，请检查问心关配置表')
end

local stepCount=self.stepCount+1
local stepNum=#self.config.dtitems

if stepCount>stepNum then
stepCount=stepNum
end

local Str=mathHelper.numberToChinese(stepCount)
Str=string.format('问心 · %s',Str)
self.titleText:setText(Str)

local itemList=self.config.dtitems[stepCount]
self.itemList=itemList
if itemList then
local count=#itemList
self.itemPanel:setChildLayoutGroupCreateItems(count)

self:refreshStepPoint()

local grids=self.itemPanel:getChildLayoutGroupGridList()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local reward=itemList[i+1]

if reward then
local rewardNum=reward[2]
local haveNum=itemsModel.getCount(reward[1])
local gray=0
local countStr=''
local showCountBG=rewardNum>1
local probability=rewardNum==-1

if rewardNum>=1 then
if haveNum<rewardNum then
gray=1
rewardNum=mathHelper.formatNumber(rewardNum)
countStr=string.format('<color=red>%s</color>',rewardNum)
else
rewardNum=mathHelper.formatNumber(rewardNum)
countStr=string.format("%s",rewardNum)
end
end

local conf={itemid=reward[1],showCountBG=showCountBG,itemcount=countStr,showStage=probability,showname=false,itemIndex=i,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,self.onClickItem)
item:SetChildPropData(2,prop)
item:SetChildActive(0,false)
else
item:SetChildActive(1,false)
end
end
else
local str=string.format("问心关配置表读取不到第%s题答题消耗，请检查！！",stepCount)
logErr(str)
end

local flag=self:checkIsEnoughCost(true)
self.reddot:setActive(flag)
self.goBtn:setButtonEnable(true,not flag)
end

function UIWenXinGuanMainWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end