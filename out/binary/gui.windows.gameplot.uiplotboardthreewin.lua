







def_class("UIPlotBoardThreeWin",UIWindowBase)









function UIPlotBoardThreeWin:bindComponents()

self.root=UIObject.get(self,0)
self.testObj=UIObject.get(self,1)
self.talkdesc=UIText.get(self,2)
self.arrowShadow=UIObject.get(self,3)



end


function UIPlotBoardThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.testObj);self.testObj=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.arrowShadow);self.arrowShadow=nil;
end
















local lookingTime=60
local _this=nil


function UIPlotBoardThreeWin:onLoaded(...)
self:bindComponents()
_this=self
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
end


function UIPlotBoardThreeWin:__delete()
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
end


function UIPlotBoardThreeWin:onHide()

end




function UIPlotBoardThreeWin:onShow(argtable,afterOnloaded)
local showTest=false



self.testObj:setActive(showTest)

self:clearDelayCloseTimer()
self.groupid=argtable.groupid
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen


self.showblack=argtable.showblack








if self.groupid~=nil then
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,self.groupid)
self.dialoguelist=groupcfg.dialoguelist
elseif argtable.dialoguelist~=nil then
self.dialoguelist=argtable.dialoguelist
else
self.dialogueStrlist=argtable.dialogueStrlist
end

if self.dialoguelist~=nil then
self.dialogueNum=#self.dialoguelist
else
self.dialogueNum=#self.dialogueStrlist
end
self.dialogueIndex=0

self.root:setActive(true)
self:doNext()
end

function UIPlotBoardThreeWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIPlotBoardThreeWin:checkFinalDialogue()
return self.dialogueIndex>=self.dialogueNum
end

function UIPlotBoardThreeWin:doNext()
self.dialogueIndex=self.dialogueIndex+1
if self.dialogueIndex<=self.dialogueNum then
if self.dialoguelist~=nil then
local dia_idx=self.dialoguelist[self.dialogueIndex]
self.dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,dia_idx)
self:playDialogueBGM()
else
self.dialogueStr=self.dialogueStrlist[self.dialogueIndex]
end
self:initShow()
else
self:finishStory()
end
end


function UIPlotBoardThreeWin:playDialogueBGM()
local dialogBGM=self.dialoguecfg.dialogBGM
if dialogBGM and dialogBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=dialogBGM
AudioManager.playBgMusic(dialogBGM,fadeTime)
end
end


function UIPlotBoardThreeWin:restoreBGM()
if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIPlotBoardThreeWin:initShow()
self:showTalk()
end


function UIPlotBoardThreeWin:showTalk()


self.arrowShadow:setActive(true)
self.talkdesc:setChildCanvasGroupAlpha(0)


local desc
local broadcast
if self.dialoguecfg~=nil then
desc=self.dialoguecfg.dialogue
broadcast=self.dialoguecfg.broadcast
else
desc=self.dialogueStr
end







if broadcast~=nil then
gameplotController.doDialogueBroadcast(name,broadcast)
end
self.talking=true

self.talkdesc:setText(desc)

local placeType=pfwindowslController:getVoiceVoiceVersion()
if placeType~=pfwindowslController.VoiceType.guoyu then
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

self:talkFinish()

self.talkdesc:setChildCanvasGroupDOFade(1,0.3,nil)
end

function UIPlotBoardThreeWin:talkFinish()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
end

function UIPlotBoardThreeWin:setLookingTimer()
local func=function()
self:talkEnd()
end
self.lookingTimer=self:setTimer(lookingTime,1,func)
end

function UIPlotBoardThreeWin:clearLookingTimer()
if self.lookingTimer~=nil then
self:stopTimerByID(self.lookingTimer)
self.lookingTimer=nil
end
end

function UIPlotBoardThreeWin:talkEnd()
self:doNext()
end


function UIPlotBoardThreeWin:onBackClick()
if self.talking then

self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:talkEnd()
end
end

function UIPlotBoardThreeWin:finishStory()
if self:checkFinalDialogue()then

local func=function()
self.delayCloseTimer=nil
self:closeBefore()
end
self.delayCloseTimer=self:setTimer(0.05,1,func)


self:restoreBGM()

local cb=self.callback
if cb~=nil then cb()end
end
end

function UIPlotBoardThreeWin:clearDelayCloseTimer()
if self.delayCloseTimer~=nil then
self:stopTimerByID(self.delayCloseTimer)
self.delayCloseTimer=nil
end
end

function UIPlotBoardThreeWin:closeBefore()
if self.isFullOpen then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eStoryBoard,'UIPlotBoardThreeWin')then
fullScreenUI.closeActiveUI()
end
else
UIManager:closeWindow('UIPlotBoardThreeWin')
end
end
