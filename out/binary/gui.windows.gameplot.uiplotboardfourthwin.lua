







def_class("UIPlotBoardFourthWin",UIWindowBase)









function UIPlotBoardFourthWin:bindComponents()

self.root=UIObject.get(self,0)
self.testObj=UIObject.get(self,1)
self.shakeRoot=UIObject.get(self,2)
self.leftObj=UIObject.get(self,3)
self.rightObj=UIObject.get(self,4)
self.biaoqingObj=UIObject.get(self,5)



end


function UIPlotBoardFourthWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.testObj);self.testObj=nil;
_UIObject_release(self.shakeRoot);self.shakeRoot=nil;
_UIObject_release(self.leftObj);self.leftObj=nil;
_UIObject_release(self.rightObj);self.rightObj=nil;
_UIObject_release(self.biaoqingObj);self.biaoqingObj=nil;
end
















local lookingTime=60
local _this=nil


function UIPlotBoardFourthWin:onLoaded(...)
self:bindComponents()
_this=self
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
end


function UIPlotBoardFourthWin:__delete()
self:unbindComponents()

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end

_this=nil
if self.showblack then
gameplotController:closePlotBlack()
end
self:clearDelayCloseTimer()

if self.callCB and self.callback then
self.callback(false)
end
end


function UIPlotBoardFourthWin:onHide()

end




function UIPlotBoardFourthWin:onShow(argtable,afterOnloaded)






self.isAbroad=pfwindowslController:getVoiceVoiceVersion()

self.overPlot=false
self.actionPlaying=false

local showTest=false



self.testObj:setActive(showTest)

self:clearDelayCloseTimer()
self.dis_guid=argtable.dis_guid
self.name=argtable.name
self.groupid=argtable.groupid
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen
self.isReady=argtable.isReady
if self.isReady==nil then self.isReady=true end
self.image=argtable.image
self.callCB=argtable.callCB


self.showblack=argtable.showblack








if self.groupid~=nil then
self.groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,self.groupid)
self.dialoguelist=self.groupcfg.dialoguelist
else
self.groupcfg={}
self.dialoguelist=argtable.dialoguelist
end

self.dialogueNum=#self.dialoguelist
self.dialogueIndex=0

local isReady=self.isReady
self.root:setActive(isReady)
if self.isReady then


self:doNext()
end
end

function UIPlotBoardFourthWin:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UIPlotBoardFourthWin:setReady(flag)
self.isReady=flag
if flag then

self.root:setActive(true)

self:doNext()
else

self.root:setActive(false)
end
end


function UIPlotBoardFourthWin:refreshAnimModel(flag)
if flag then

self.root:setActive(false)
else

self.root:setActive(true)
end
end

function UIPlotBoardFourthWin:getSideObj(side)
return side==0 and self.leftObj or self.rightObj
end

function UIPlotBoardFourthWin:checkFinalDialogue()
return self.dialogueIndex>=self.dialogueNum
end

function UIPlotBoardFourthWin:doNext()
self.dialogueIndex=self.dialogueIndex+1
if self.dialogueIndex<=self.dialogueNum then
local dia_idx=self.dialoguelist[self.dialogueIndex]
self.dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,dia_idx)
if self.dialoguecfg.enterEffectList==nil then
self:initShow()
else
self:initEnterActions()
end
self:playDialogueBGM()
else
self:checkFinish()
end
end


function UIPlotBoardFourthWin:playDialogueBGM()
local dialogBGM=self.dialoguecfg.dialogBGM
if dialogBGM and dialogBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=dialogBGM
AudioManager.playBgMusic(dialogBGM,fadeTime)
end
end


function UIPlotBoardFourthWin:restoreBGM()
if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIPlotBoardFourthWin:checkFinish()
if not self.overPlot then
self.overPlot=true
if self.groupcfg.enterEffectList==nil and self.groupcfg.leaveEffectList==nil then
self:finishStory()
else
plotBoardController:handleLeaveAction()
end
end
end

function UIPlotBoardFourthWin:initEnterActions()
self:refreshAnimModel(true)

self.actionList=plotActionController.initActionList(self.dialoguecfg.enterEffectList)

for i,v in ipairs(self.actionList)do
if v.flag==nil then
v.flag=true
plotBoardController:doAction(v.effect)
end
end

self.actionPlaying=true
local time=self.dialoguecfg.enterLife or 1000
time=time/1000
local func=function()
self:refreshAnimModel(false)
self.actionPlaying=false
self:killActionList()
self:initShow()
end
self:delayDo(time,func)
end

function UIPlotBoardFourthWin:initShow()
local oldSide=self.modelSide
local oldnpcID=self.npcID
self.modelSide=self.dialoguecfg.side
self.npcID=self.dialoguecfg.npcID
local changeSide=self.modelSide~=oldSide
local changenpc=self.npcID~=oldnpcID

self:initTalkActions()
self.leftObj:setActive(false)
self.rightObj:setActive(false)
self:showModel(changeSide,changenpc,oldnpcID)
self:showEmot()
self:showTalk()
self:showShake()
end



function UIPlotBoardFourthWin:showShake()
local shakeLevel=self.dialoguecfg.shake or 0
if shakeLevel>0 then
self.shakeScale=1+0.01*shakeLevel
self.shakeNum=3
self.shakeRoot:setScale(Vector3(1,1,1))
self:doShake()
end
end


function UIPlotBoardFourthWin:teskShake(shakeLevel,baseshake)
baseshake=baseshake or 0.01
if shakeLevel>0 then
self.shakeScale=1+baseshake*shakeLevel
self.shakeNum=3
self.shakeRoot:setScale(Vector3(1,1,1))
self:doShake()
end
end

function UIPlotBoardFourthWin:doShake()
if self.shakeNum<=0 then return end
self.shakeNum=self.shakeNum-1
if self.shakeTween~=nil then
self.shakeTween:Kill()
self.shakeTween=nil
end
self.shakeTween=self.shakeRoot:setChildDOScale(self.shakeScale,0.05,function()
if _this==nil then return end
_this.shakeTween=nil
_this:doShake2()
end)
end

function UIPlotBoardFourthWin:doShake2()
if self.shakeTween~=nil then
self.shakeTween:Kill()
self.shakeTween=nil
end
self.shakeTween=self.shakeRoot:setChildDOScale(1,0.05,function()
if _this==nil then return end
_this.shakeTween=nil
_this:doShake()
end)
end



function UIPlotBoardFourthWin:initTalkActions()
if self.dialoguecfg.effectlist~=nil then

self.actionList=plotActionController.initActionList(self.dialoguecfg.effectlist)

for i,v in ipairs(self.actionList)do
if v.flag==nil then
v.flag=true
plotBoardController:doAction(v.effect)
end
end
end
end

function UIPlotBoardFourthWin:showModel(changeSide,changenpc,oldnpcID)
local bodyid=nil
local components={}
local npcID=self.npcID
if npcID==0 then

if self.dis_guid==nil then
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
end

if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
elseif npcID==-3 then

local random_dis=MysteryModel:get_random_dizi_data()
self.dis_guid=random_dis.discipleguid


if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
elseif npcID==-4 then
if self.dis_guid==nil then
self.dis_guid=MysteryModel:get_team_first()
end

if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
elseif npcID>=0 then
local image=npcModel:getImageInfo(npcID)
if image then
bodyid=image.body
components=image.componets
end
end
local isshow=bodyid~=nil
local sideObj=self:getSideObj(self.modelSide)
local sideWidget=sideObj:getChildWidgetBase()
sideObj:setActive(true)

sideWidget:SetChildActive(0,isshow)

if isshow then
local modelParams={body=bodyid,componets=components}
comHelper.setChildModelRawImageEx(0,sideWidget,modelParams,eHeadCenterType.eHead)
end
end

function UIPlotBoardFourthWin:showEmot()
local emot=self.dialoguecfg.emot
local hasEmot=emot~=nil
self.biaoqingObj:setActive(hasEmot)
if hasEmot then
local bqWidget=self.biaoqingObj:getChildWidgetBase()
if self.modelSide==0 then

self.biaoqingObj:setLocalPosX(-450)
bqWidget:SetChildScale(0,Vector3.New(1,1,1))
bqWidget:SetChildAnchoredPos(1,4,0)
else

self.biaoqingObj:setLocalPosX(450)
bqWidget:SetChildScale(0,Vector3.New(-1,1,1))
bqWidget:SetChildAnchoredPos(1,0,0)
end

bqWidget:SetChildText(1,chatEmotHelper.decodeEmot(emot))

self.biaoqingObj:setChildCanvasGroupAlpha(0)
self.biaoqingObj:setScale(Vector3.New(0.8,0.8,0))

local func=function()
self.biaoqingObj:setChildCanvasGroupDOFade(1,0.1,nil)
local t1=self.biaoqingObj:setChildDOScale(1,0.4,nil)
t1:SetEase(_Ease.OutElastic)
end
self:delayDo(0.1,func)
end
end

function UIPlotBoardFourthWin:getName()
local npcID=self.npcID
local name=nil
if self.name then
name=self.name
else
if npcID==0 then
if self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID==-2 then
name=playerModel:getActorName()
elseif npcID==-3 then
if self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID>=0 then
name=npcModel:getName(npcID)
end
end

return name
end

function UIPlotBoardFourthWin:showTalk()
local sideObj=self:getSideObj(self.modelSide)
local sideWidget=sideObj:getChildWidgetBase()

local name=self:getName()or''
sideWidget:SetChildText(1,name)

local desc=self.dialoguecfg.dialogue or'未配置'
desc=gameplotModel:replaceName(desc,name)
local speed=40
local func=function()
if self and not self.isClose then
self:talkFinish()
end
end

if self.dialoguecfg.broadcast~=nil then
gameplotController.doDialogueBroadcast(name,self.dialoguecfg.broadcast)
end

local placeType=pfwindowslController:getVoiceVoiceVersion()
if placeType==pfwindowslController.VoiceType.guoyu then
self.talking=true
sideWidget:SetChildTrendsTextPlay(2,desc,speed,func)
else
sideWidget:SetChildText(2,desc)
if not verifyManager:isHideYuyin()then

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end


self.voiceId=self.dialoguecfg.voiceId

if self.voiceId then
self.audioHandle=AudioManager.playAudio(self.voiceId)
end
end
end

end

function UIPlotBoardFourthWin:talkFinish()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
end

function UIPlotBoardFourthWin:setLookingTimer()
local func=function()
self:talkEnd()
end
self.lookingTimer=self:setTimer(lookingTime,1,func)
end

function UIPlotBoardFourthWin:clearLookingTimer()
if self.lookingTimer~=nil then
self:stopTimerByID(self.lookingTimer)
self.lookingTimer=nil
end
end

function UIPlotBoardFourthWin:talkEnd()
if self.dialoguecfg.effectlist then
self:killActionList()
end
if self.dialoguecfg.leaveEffectList==nil then
self:doNext()
else
self:initLeaveActions()
end
end

function UIPlotBoardFourthWin:killActionList()
if self.actionList then
for i,v in ipairs(self.actionList)do
if v.flag==true then
v.flag=false
plotBoardController:killAction(v.effect)
end
end
end
self.actionList=nil
end

function UIPlotBoardFourthWin:initLeaveActions()
self:refreshAnimModel(true)

self.actionList=plotActionController.initActionList(self.dialoguecfg.leaveEffectList)

for i,v in ipairs(self.actionList)do
if v.flag==nil then
v.flag=true
plotBoardController:doAction(v.effect)
end
end

self.actionPlaying=true
local time=self.dialoguecfg.leaveLife or 3000
time=time/1000
local func=function()
self:refreshAnimModel(false)
self.actionPlaying=false
self:killActionList()
self:doNext()
end
self:delayDo(time,func)
end

function UIPlotBoardFourthWin:onBackClick()

if not self.isReady or self.actionPlaying or self.overPlot then return end

if self.talking then
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:talkEnd()
end
end


function UIPlotBoardFourthWin:onLeave()
self:finishStory()
end

function UIPlotBoardFourthWin:finishStory()
if self:checkFinalDialogue()then

local func=function()
self.delayCloseTimer=nil
self:closeBefore()
end
self.delayCloseTimer=self:setTimer(0.05,1,func)


self:restoreBGM()

if self.groupcfg.imagePool~=nil then
plotBoardController:closeStage(self.groupid)
end

local cb=self.callback
if cb~=nil then cb()end
end
end

function UIPlotBoardFourthWin:clearDelayCloseTimer()
if self.delayCloseTimer~=nil then
self:stopTimerByID(self.delayCloseTimer)
self.delayCloseTimer=nil
end
end

function UIPlotBoardFourthWin:closeBefore()
if self.isFullOpen then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eStoryBoard,'UIPlotBoardFourthWin')then
fullScreenUI.closeActiveUI()
end
else
UIManager:closeWindow('UIPlotBoardFourthWin')
end
end

function UIPlotBoardFourthWin:closeFullWin()
if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
UIManager:closeWindow('UIPlotBoardFourthWin')
end
end
