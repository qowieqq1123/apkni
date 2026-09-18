







def_class("UIPlotBoardTwoWin",UIWindowBase)









function UIPlotBoardTwoWin:bindComponents()

self.leftObj=UIObject.get(self,0)
self.rightObj=UIObject.get(self,1)
self.skipBtn=UIButton.get(self,2)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIPlotBoardTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftObj);self.leftObj=nil;
_UIObject_release(self.rightObj);self.rightObj=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
end
















local lookingTime=3


function UIPlotBoardTwoWin:onLoaded(...)
self:bindComponents()
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
end


function UIPlotBoardTwoWin:__delete()
if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end

self:clearLookingTimer()

self:unbindComponents()
end


function UIPlotBoardTwoWin:onHide()

end




function UIPlotBoardTwoWin:onShow(argtable,afterOnloaded)
self.dis_guid=argtable.dis_guid
self.groupid=argtable.groupid
self.callback=argtable.callback
self.useUnscaledDeltaTime=argtable.useUnscaledDeltaTime

local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,self.groupid)
if groupcfg==nil then



self:closeFullWin()
return
end


local showSkip=groupcfg.allowskip
self.skipBtn:setActive(showSkip==true)

self.dialoguelist=groupcfg.dialoguelist
self.dialogueNum=#self.dialoguelist
self.dialogueIndex=0

self:doNext()
end

function UIPlotBoardTwoWin:getSideObj(side)
return side==0 and self.leftObj or self.rightObj
end

function UIPlotBoardTwoWin:checkFinalDialogue()
return self.dialogueIndex>=self.dialogueNum
end

function UIPlotBoardTwoWin:doNext()
self.dialogueIndex=self.dialogueIndex+1
if self.dialogueIndex<=self.dialogueNum then
self.leftObj:setChildCanvasGroupAlpha(0)
self.rightObj:setChildCanvasGroupAlpha(0)
local dia_idx=self.dialoguelist[self.dialogueIndex]
self.dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,dia_idx)
local oldSide=self.modelSide
self.modelSide=self.dialoguecfg.side
local changeSide=self.modelSide~=oldSide
self:showModelTalk(changeSide)
self:playDialogueBGM()
else
self:finishStory()
end
end


function UIPlotBoardTwoWin:playDialogueBGM()
local dialogBGM=self.dialoguecfg.dialogBGM
if dialogBGM and dialogBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=dialogBGM
AudioManager.playBgMusic(dialogBGM,fadeTime)
end
end


function UIPlotBoardTwoWin:restoreBGM()
if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIPlotBoardTwoWin:showModelTalk(changeSide)
local bodyid=nil
local components={}
local npcID=self.dialoguecfg.npcID
if npcID==0 then

if self.dis_guid==nil then
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
end

if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
elseif npcID>=0 then
local image=npcModel:getImageInfo(npcID)
if image then
bodyid=image.body
components=image.componets
end
end

local sideObj=self:getSideObj(self.modelSide)
local sideWidget=sideObj:getChildWidgetBase()
sideObj:setChildCanvasGroupAlpha(1)


local showBody=bodyid~=nil
sideWidget:SetChildActive(0,showBody)
if showBody then
local modelParams={body=bodyid,componets=components}
local dbcfg=cfgHelper.get1(cfg_dbbodyconfig_get,bodyid)
modelParams.icon_head=dbcfg.icon_head


comHelper.setChildModelRawImageEx(0,sideWidget,modelParams,eHeadCenterType.eHead)
end

local name=self:getName()
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

function UIPlotBoardTwoWin:stopTalkPlay()
local sideObj=self:getSideObj(self.modelSide)
local sideWidget=sideObj:getChildWidgetBase()
sideWidget:SetChildTrendsTextStop(2)

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end
end

function UIPlotBoardTwoWin:getName()
local npcID=self.dialoguecfg.npcID
local name='???'
if npcID==0 then
if self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID==-2 then
name=playerModel:getActorName()
elseif npcID>=0 then
name=npcModel:getName(npcID)
end
return name
end

function UIPlotBoardTwoWin:talkFinish()
self.talking=false

self:clearLookingTimer()
self:setLookingTimer()

end

function UIPlotBoardTwoWin:setLookingTimer()
local func=function()
if not self or self.isClose then return end
self:doNext()
end
if self.useUnscaledDeltaTime then
self.lookingTimer=Timer.New(func,lookingTime,1,false)
self.lookingTimer:Start()
else
self.lookingTimer=self:setTimer(lookingTime,1,func)
end

end

function UIPlotBoardTwoWin:clearLookingTimer()
if self.lookingTimer~=nil then
if self.useUnscaledDeltaTime then
self.lookingTimer:Stop()
else
self:stopTimerByID(self.lookingTimer)
end

self.lookingTimer=nil
end
end

function UIPlotBoardTwoWin:finishStory()
self:onCommitClick()
end

function UIPlotBoardTwoWin:onBackClick()
if self.talking then
self:stopTalkPlay()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:doNext()
end
end

function UIPlotBoardTwoWin:onCommitClick()
if self:checkFinalDialogue()then

self:restoreBGM()
local cb=self.callback
self:closeFullWin()
if cb~=nil then cb()end
end
end

function UIPlotBoardTwoWin:closeFullWin()
if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
UIManager:closeWindow('UIPlotBoardTwoWin')
end
end

function UIPlotBoardTwoWin:onSkipBtn()
if self.talking then
self:stopTalkPlay()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
end
local cb=self.callback
self:closeFullWin()
if cb~=nil then cb()end
end
