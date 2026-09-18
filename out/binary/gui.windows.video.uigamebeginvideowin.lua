







def_class("UIGameBeginVideoWin",UIWindowBase)









function UIGameBeginVideoWin:bindComponents()

self.bg=UIObject.get(self,0)
self.Player3=UIObject.get(self,1)
self.Player2=UIObject.get(self,2)
self.Player1=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)
self.RawImage2=UIObject.get(self,5)
self.RawImage1=UIObject.get(self,6)
self.otherUIRoot=UIObject.get(self,7)
self.videoUIRoot=UIObject.get(self,8)
self.bgBtn=UIButton.get(self,9)
self.btnSkip=UIButton.get(self,10)
self.topRoot=UIObject.get(self,11)
self.topBg=UIObject.get(self,12)
self.topTiltle=UIImage.get(self,13)
self.rightTiltle=UIImage.get(self,14)
self.rightBtn=UIButton.get(self,15)
self.rightEffectSmoke=UIObject.get(self,16)
self.rightEffect=UIObject.get(self,17)
self.leftTiltle=UIImage.get(self,18)
self.leftBtn=UIButton.get(self,19)
self.leftEffectSmoke=UIObject.get(self,20)
self.leftEffect=UIObject.get(self,21)
self.bottomTiltle=UIImage.get(self,22)
self.bottomTiltle2=UIImage.get(self,23)

self.bgBtn:setButtonClick(function()self:onBgBtn()end)

self.btnSkip:setButtonClick(function()self:onBtnSkip()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)



end


function UIGameBeginVideoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.Player3);self.Player3=nil;
_UIObject_release(self.Player2);self.Player2=nil;
_UIObject_release(self.Player1);self.Player1=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.RawImage2);self.RawImage2=nil;
_UIObject_release(self.RawImage1);self.RawImage1=nil;
_UIObject_release(self.otherUIRoot);self.otherUIRoot=nil;
_UIObject_release(self.videoUIRoot);self.videoUIRoot=nil;
_UIObject_release(self.bgBtn);self.bgBtn=nil;
_UIObject_release(self.btnSkip);self.btnSkip=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.topBg);self.topBg=nil;
_UIObject_release(self.topTiltle);self.topTiltle=nil;
_UIObject_release(self.rightTiltle);self.rightTiltle=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.rightEffectSmoke);self.rightEffectSmoke=nil;
_UIObject_release(self.rightEffect);self.rightEffect=nil;
_UIObject_release(self.leftTiltle);self.leftTiltle=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.leftEffectSmoke);self.leftEffectSmoke=nil;
_UIObject_release(self.leftEffect);self.leftEffect=nil;
_UIObject_release(self.bottomTiltle);self.bottomTiltle=nil;
_UIObject_release(self.bottomTiltle2);self.bottomTiltle2=nil;
end

















local _abName=globalABLookup.beginVideo
local _effect_click=10177
local _effect_disappear=10178
local _clickSoundId=
{
[1]=SOUND_TYPE.eBeginClick1,
[2]=SOUND_TYPE.eBeginClick2,
[3]=SOUND_TYPE.eBeginClick3,
}

local _retSoundId=
{

[1]=
{
[1]=
{
[1]=SOUND_TYPE.eBeginRetLeft1,
[2]=SOUND_TYPE.eBeginRetLeft2,
[3]=SOUND_TYPE.eBeginRetLeft3,
},
[2]=
{
[1]=SOUND_TYPE.eBeginRetRight1,
[2]=SOUND_TYPE.eBeginRetRight2,
[3]=SOUND_TYPE.eBeginRetRight3,
},
},
}


local _fileName=
{
[1]={'beginVideo1.mp4','beginVideo2.mp4','beginVideo3.mp4'},
[2]={'beginVideo1_HKD.mp4','beginVideo2.mp4','beginVideo3_HKD.mp4'},
[3]={'beginVideo1_VND.mp4','beginVideo2.mp4','beginVideo3_VND.mp4'},
[4]={'beginVideo1_OM.mp4','beginVideo2.mp4','beginVideo3_OM.mp4'},
}

local curPvIndex=0


function UIGameBeginVideoWin:onLoaded(...)
self:bindComponents()








self.winlua:SetURLVideoCompleteAction(self.Player1:getID(),function()self:onPlayFinish(1)end)
self.winlua:SetURLVideoCompleteAction(self.Player2:getID(),function()self:onPlayFinish(2)end)
self.winlua:SetURLVideoCompleteAction(self.Player3:getID(),function()self:onPlayFinish(3)end)

self.winlua:SetURLVideoErrorAction(self.Player1:getID(),function(...)self:onPlayErr(1,...)end)
self.winlua:SetURLVideoErrorAction(self.Player2:getID(),function(...)self:onPlayErr(2,...)end)
self.winlua:SetURLVideoErrorAction(self.Player3:getID(),function(...)self:onPlayErr(3,...)end)


self.leftBtn:setActive(false)
self.rightBtn:setActive(false)
self.videoUIRoot:setActive(false)
self.topRoot:setActive(false)
self.bg:setActive(false)
self.uiRoot:setActive(false)
self.otherUIRoot:setActive(false)
self._playing=false

end

function UIGameBeginVideoWin:__delete()
self:stopTipsTimer()






self.winlua:SetURLVideoCompleteAction(self.Player1:getID(),nil)
self.winlua:SetURLVideoCompleteAction(self.Player2:getID(),nil)
self.winlua:SetURLVideoCompleteAction(self.Player3:getID(),nil)

self.winlua:SetURLVideoErrorAction(self.Player1:getID(),nil)
self.winlua:SetURLVideoErrorAction(self.Player2:getID(),nil)
self.winlua:SetURLVideoErrorAction(self.Player3:getID(),nil)
self:unbindComponents()
end

function UIGameBeginVideoWin:onShow(argtable,afterOnloaded)
end

function UIGameBeginVideoWin:onHide()

end





function UIGameBeginVideoWin:onLeftBtn()
self.leftBtn:setActive(false)
self.rightBtn:setActive(false)
self:playRetUI(true)
end



function UIGameBeginVideoWin:onRightBtn()
self.leftBtn:setActive(false)
self.rightBtn:setActive(false)
self:playRetUI(false)
end

function UIGameBeginVideoWin:isPlaying()
return self._playing==true
end

function UIGameBeginVideoWin:stopPlay()
self._playing=false
self.skipStamp=nil
self.index=nil
self.beginThree=nil
self:stopAllTimer()
self.leftBtn:setActive(false)
self.rightBtn:setActive(false)
self.videoUIRoot:setActive(false)
self.topRoot:setActive(false)
self.bg:setActive(false)
self.uiRoot:setActive(false)
self.otherUIRoot:setActive(false)
self.winlua:SetChildIconAlpha(self.RawImage1:getID(),1)
self.winlua:SetChildActive(self.Player1:getID(),true)
self.winlua:SetChildActive(self.Player2:getID(),true)
self.winlua:SetChildActive(self.Player3:getID(),true)




self.winlua:StopURLVideo(self.Player1:getID())
self.winlua:StopURLVideo(self.Player2:getID())
self.winlua:StopURLVideo(self.Player3:getID())

self.winlua:StopAudioSource(self.Player1:getID())
self.winlua:StopAudioSource(self.Player3:getID())
self.topTiltle:setChildIcon("",false)
self.bottomTiltle:setChildIcon("",false)
self.leftTiltle:setChildIcon("",false)
self.rightTiltle:setChildIcon("",false)
self:stopTipsTimer()
self.bottomTiltle2:setActive(false)
if self.loopWater then
AudioManager.stopAudioById(self.loopWater)
self.loopWater=nil
end
end

function UIGameBeginVideoWin:StopAudioSourcePlayer1()
if pfwindowslController:needFixedBeginVedio()then
self.winlua:SetAudioSourceVolume(self.Player1:getID(),0)
end
end

function UIGameBeginVideoWin:StopAudioSourcePlayer3()
if pfwindowslController:needFixedBeginVedio()then
self.winlua:SetAudioSourceVolume(self.Player3:getID(),0)
end
end

function UIGameBeginVideoWin:play()


self.abroadKey=pfwindowslController:getPvIndex()

if pfwindowslController:needFixedBeginVedio()then
_fileName=
{
[1]={'beginVideo1_HKD.mp4','beginVideo2.mp4','beginVideo3_HKD.mp4'},
[2]={'beginVideo1_HKD.mp4','beginVideo2.mp4','beginVideo3_HKD.mp4'},
}
end

if self.loadErr then
loginControl:onPlayFinishBeginVideo()
return
end
self._playing=true
self:onReConnection()
loginState:closeLoginWin()
self.bg:setActive(true)
self.uiRoot:setActive(true)
self.otherUIRoot:setActive(true)
if pfwindowslController:needFixedBeginVedio()then
AudioManager.playBgMusic(10011)

else
AudioManager.fadeoutBGMusic()
end
self.winlua:PlayURLVideo(self.Player1:getID(),'',_fileName[self.abroadKey][1],false,1)
self:StopAudioSourcePlayer1()
logPoint.UploadLog(logPoint.logExtType.startVideo1)
end

function UIGameBeginVideoWin:onPlayFinish(index)
curPvIndex=index
if index==1 then
self:delayDo(3,function()
self.winlua:SetChildActive(self.Player1:getID(),false)
end)
self:delayDo(1,function()
self.winlua:SetChildImageDOFade(self.RawImage1:getID(),0,1.5)
end)

if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
self.winlua:PlayURLVideo(self.Player2:getID(),'',_fileName[self.abroadKey][2],false,2)
else
self.winlua:PlayURLVideo(self.Player2:getID(),'',_fileName[self.abroadKey][2],true,2)
end
self.loopWater=AudioManager.playAudio(SOUND_TYPE.eBeginLoopWater)
self.videoUIRoot:setActive(true)
self.btnSkip:setActive(false)
self.showSkip=false
self.disableSkip=true
self.winlua:SetChildCanvasGroupAlpha(self.videoUIRoot:getID(),1)
self:playUI(1)
logPoint.UploadLog(logPoint.logExtType.startVideo2)
elseif index==2 then
if self.beginThree then
self.beginThree=nil
if not pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
self:delayDo(0.3,function()
self.winlua:SetChildActive(self.Player2:getID(),false)
end)
if self.loopWater then
AudioManager.stopAudioById(self.loopWater)
self.loopWater=nil
end

self.winlua:PlayURLVideo(self.Player3:getID(),'',_fileName[self.abroadKey][3],false,3)
self:StopAudioSourcePlayer3()
if pfwindowslController:needFixedBeginVedio()then
AudioManager.playBgMusic(10011)
end
self.disableSkip=false
end
logPoint.UploadLog(logPoint.logExtType.startVideo3)
else
self.winlua:PlayURLVideo(self.Player2:getID(),'',_fileName[self.abroadKey][2],false,2)
end
elseif index==3 then
loginControl:onPlayFinishBeginVideo()
end
end

function UIGameBeginVideoWin:playUI(index)

if index>3 then
if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
self:delayDo(0.1,function()
self.winlua:SetChildActive(self.Player2:getID(),false)
end)
if self.loopWater then
AudioManager.stopAudioById(self.loopWater)
self.loopWater=nil
end

self.winlua:PlayURLVideo(self.Player3:getID(),'',_fileName[self.abroadKey][3],false,3)
self.disableSkip=false
end
self.videoUIRoot:setActive(false)
self.beginThree=true
return
end
self.index=index
self.topRoot:setActive(true)
local cfg=cfg_beginvideoconfig_get(self.index)
local asset=cfg.asset

self.topTiltle:setCSImageSprite(FMT.fmt("ui/windows/video/sharedtextures/{0}.ab",asset[1]),asset[1])






local delay=index>1 and 5 or 2
self.leftBtn:setActive(false)
self.rightBtn:setActive(false)
local func1=function()

self.leftBtn:setActive(true)
self.winlua:SetChildUIWaterWaveDistortPlay(self.leftTiltle:getID(),1,true,true)
end
local func2=function()

self.rightBtn:setActive(true)
self.winlua:SetChildUIWaterWaveDistortPlay(self.rightTiltle:getID(),1,true,true)
end
local func3=function()
self.winlua:SetChildUIWaterWaveDistortPlay(self.topTiltle:getID(),1,true,true)
end
local func4=function()
self.winlua:SetChildUIWaterWaveDistortPlay(self.topBg:getID(),1,true,true)
end
local func5=function()
self.winlua:SetChildUIWaterWaveDistortPlay(self.bottomTiltle2:getID(),1,true,true)
end
self:delayDo(2,function()

self.leftTiltle:setCSImageSprite(FMT.fmt("ui/windows/video/sharedtextures/{0}.ab",asset[2][1]),asset[2][1])
self.rightTiltle:setCSImageSprite(FMT.fmt("ui/windows/video/sharedtextures/{0}.ab",asset[3][1]),asset[3][1])
self.winlua:SetChildUIWaterWaveDistortPlay(self.leftTiltle:getID(),0,false,false,-1,func1)
self.winlua:SetChildUIWaterWaveDistortPlay(self.rightTiltle:getID(),0,false,false,-1,func2)
end)
self.winlua:SetChildUIWaterWaveDistortPlay(self.topTiltle:getID(),0,false,false,-1,func3)
self.winlua:SetChildUIWaterWaveDistortPlay(self.topBg:getID(),0,false,false,-1,func4)
self:stopTipsTimer()
self.tipsTimer=self:delayDo(delay,function()
self.bottomTiltle2:setActive(true)
self.winlua:SetChildUIWaterWaveDistortPlay(self.bottomTiltle2:getID(),0,false,false,-1,func5)
end)
end














function UIGameBeginVideoWin:playRetAnimation(loop)
local cmp=self.bottomTiltle:getID()
self.winlua:SetChildUIWaterWaveDistortPlay(cmp,0,false,true,-1,function()
self:delayDo(loop,function()
self.winlua:SetChildUIWaterWaveDistortPlay(cmp,2,false,true,-1,function()
self.bottomTiltle:setChildIcon("",false)
self:playUI(self.index+1)
end)
end)
self.winlua:SetChildUIWaterWaveDistortPlay(cmp,1,true,true)
end)
end

function UIGameBeginVideoWin:playRetUI(left)

local clickCmp=left and self.leftTiltle or self.rightTiltle
local noClickCmp=left and self.rightTiltle or self.leftTiltle
local clickEffect=left and self.leftEffect or self.rightEffect
local clickSmokeEffect=left and self.leftEffectSmoke or self.rightEffectSmoke
local noClickSmokeEffect=left and self.rightEffectSmoke or self.leftEffectSmoke
local cfg=cfg_beginvideoconfig_get(self.index)
AudioManager.playAudio(_clickSoundId[self.index])
local asset=cfg.asset
local clickAsset=left and asset[2]or asset[3]
local noClickAsset=left and asset[3]or asset[2]
clickEffect:setChildShowEffect(_effect_click,true)

local delayTime=0.25
self:delayDo(0.3,function()

clickSmokeEffect:setChildShowEffect(clickAsset[4],true)
self.winlua:SetChildUIWaterWaveDistortPlay(clickCmp:getID(),3,false,true,delayTime,function()
clickCmp:setChildIcon("",false)
self.bottomTiltle:setCSImageSprite(FMT.fmt("ui/windows/video/sharedtextures/{0}.ab",clickAsset[2]),clickAsset[2])
local posindex=left and 1 or 2
if _retSoundId[self.abroadKey]then
AudioManager.playAudio(_retSoundId[self.abroadKey][posindex][self.index])
end
self:playRetAnimation(clickAsset[3])
end)
end)

self.winlua:SetChildUIWaterWaveDistortPlay(noClickCmp:getID(),3,false,true,delayTime,function()
noClickCmp:setChildIcon("",false)
end)
self.winlua:SetChildUIWaterWaveDistortPlay(self.topBg:getID(),2,false,true,delayTime)
self.winlua:SetChildUIWaterWaveDistortPlay(self.topTiltle:getID(),2,false,true,delayTime,function()
self.topTiltle:setChildIcon("",false)
end)
self:delayDo(delayTime,function()

noClickSmokeEffect:setChildShowEffect(noClickAsset[4],true)
end)
self:stopTipsTimer()
self.winlua:SetChildUIWaterWaveDistortPlay(self.bottomTiltle2:getID(),2,false,true,delayTime,function()
self.bottomTiltle2:setActive(false)
end)
pfCommonHelper.selectClickPoint(self.index)
end

function UIGameBeginVideoWin:onBtnSkip()
local stamp=os.time()
if self.skipStamp==nil or(stamp-self.skipStamp)>3 then
self.skipStamp=stamp
loginControl:onPlayFinishBeginVideo()
pfCommonHelper.skipPvPoint(curPvIndex)
end
end

function UIGameBeginVideoWin:onBgBtn()
if not self.disableSkip and not self.showSkip then
self.btnSkip:setActive(true)
self.showSkip=true
end
end

function UIGameBeginVideoWin:stopTipsTimer()
if self.tipsTimer then
self:stopTimerByID(self.tipsTimer)
self.tipsTimer=nil
end
end


function UIGameBeginVideoWin:onPlayErr(index,err)
self.loadErr=true
loginControl:onPlayFinishBeginVideo()
loggerUtil.debugErrFMT('第{0}个播放器播放错误!err:{1}',index,err)
end

function UIGameBeginVideoWin:resetError()
self.loadErr=false
end
