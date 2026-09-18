







def_class("UIVideoTestWin",UIWindowBase)









function UIVideoTestWin:bindComponents()

self.abPanel=UIObject.get(self,0)
self.abPlayer=UIObject.get(self,1)
self.btnAB=UIButton.get(self,2)
self.btnContinue=UIButton.get(self,3)
self.btnLoad=UIButton.get(self,4)
self.btnLocal=UIButton.get(self,5)
self.btnPause=UIButton.get(self,6)
self.btnPlay=UIButton.get(self,7)
self.btnStop=UIButton.get(self,8)
self.btnStream=UIButton.get(self,9)
self.btnStreamMedia=UIButton.get(self,10)
self.btnTestClose=UIButton.get(self,11)
self.gmPanel=UIObject.get(self,12)
self.InputFieldFile=UIInputField.get(self,13)
self.InputFieldURL=UIInputField.get(self,14)
self.loadPanel=UIObject.get(self,15)
self.LoadPlayer=UIObject.get(self,16)
self.localPanel=UIObject.get(self,17)
self.localPlayer=UIObject.get(self,18)
self.mainPanel=UIObject.get(self,19)
self.streamPanel=UIObject.get(self,20)
self.streamPlayer=UIObject.get(self,21)
self.testPanel=UIObject.get(self,22)
self.Toggle=UIToggleButton.get(self,23)
self.URLPanel=UIObject.get(self,24)
self.URLPlayer=UIObject.get(self,25)
self.loading=UIObject.get(self,26)

self.btnAB:setButtonClick(function()self:onBtnAB()end)

self.btnContinue:setButtonClick(function()self:onBtnContinue()end)

self.btnLoad:setButtonClick(function()self:onBtnLoad()end)

self.btnLocal:setButtonClick(function()self:onBtnLocal()end)

self.btnPause:setButtonClick(function()self:onBtnPause()end)

self.btnPlay:setButtonClick(function()self:onBtnPlay()end)

self.btnStop:setButtonClick(function()self:onBtnStop()end)

self.btnStream:setButtonClick(function()self:onBtnStream()end)

self.btnStreamMedia:setButtonClick(function()self:onBtnStreamMedia()end)

self.btnTestClose:setButtonClick(function()self:onBtnTestClose()end)



end


function UIVideoTestWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.abPanel);self.abPanel=nil;
_UIObject_release(self.abPlayer);self.abPlayer=nil;
_UIObject_release(self.btnAB);self.btnAB=nil;
_UIObject_release(self.btnContinue);self.btnContinue=nil;
_UIObject_release(self.btnLoad);self.btnLoad=nil;
_UIObject_release(self.btnLocal);self.btnLocal=nil;
_UIObject_release(self.btnPause);self.btnPause=nil;
_UIObject_release(self.btnPlay);self.btnPlay=nil;
_UIObject_release(self.btnStop);self.btnStop=nil;
_UIObject_release(self.btnStream);self.btnStream=nil;
_UIObject_release(self.btnStreamMedia);self.btnStreamMedia=nil;
_UIObject_release(self.btnTestClose);self.btnTestClose=nil;
_UIObject_release(self.gmPanel);self.gmPanel=nil;
_UIObject_release(self.InputFieldFile);self.InputFieldFile=nil;
_UIObject_release(self.InputFieldURL);self.InputFieldURL=nil;
_UIObject_release(self.loadPanel);self.loadPanel=nil;
_UIObject_release(self.LoadPlayer);self.LoadPlayer=nil;
_UIObject_release(self.localPanel);self.localPanel=nil;
_UIObject_release(self.localPlayer);self.localPlayer=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.streamPanel);self.streamPanel=nil;
_UIObject_release(self.streamPlayer);self.streamPlayer=nil;
_UIObject_release(self.testPanel);self.testPanel=nil;
_UIObject_release(self.Toggle);self.Toggle=nil;
_UIObject_release(self.URLPanel);self.URLPanel=nil;
_UIObject_release(self.URLPlayer);self.URLPlayer=nil;
_UIObject_release(self.loading);self.loading=nil;
end

















local _type=
{
eAB=1,
eStream=2,
eLocal=3,
eLoad=4,
eURL=5,
}

function UIVideoTestWin:onLoaded(...)
self:bindComponents()
self.isToggle=false
self.Toggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle()
self.mainPanel:setActive(true)
self.testPanel:setActive(false)

self.winlua:SetURLVideoCompleteAction(self.localPlayer:getID(),function(...)self:onLocalFinish(...)end)
self.winlua:SetURLVideoCompleteAction(self.streamPlayer:getID(),function(...)self:onstreamFinish(...)end)
self.winlua:SetURLVideoCompleteAction(self.LoadPlayer:getID(),function(...)self:onLoadFinish(...)end)
self.winlua:SetURLVideoCompleteAction(self.URLPlayer:getID(),function(...)self:onURLLoadFinish(...)end)

self.winlua:SetClipVideoCompleteAction(self.abPlayer:getID(),function(...)self:onABFinish(...)end)

self.winlua:SetURLVideoWaitAction(self.URLPlayer:getID(),function(...)self:onVideoWaitLoad(...)end)
self.winlua:SetURLVideoDownedAction(self.URLPlayer:getID(),function(...)self:onVideoLoaded(...)end)

end

function UIVideoTestWin:__delete()
self:unbindComponents()
end

function UIVideoTestWin:onShow(argtable,afterOnloaded)

end

function UIVideoTestWin:onHide()

end


function UIVideoTestWin:freshToggle()
self.Toggle:setToggle(self.isToggle)
end




function UIVideoTestWin:onBtnStop()
loggerUtil.log('onBtnStop')
if self.videotype==_type.eAB then
self.winlua:StopClipVideo(self.abPlayer:getID())
elseif self.videotype==_type.eLocal then
self.winlua:StopURLVideo(self.localPlayer:getID())
elseif self.videotype==_type.eStream then
self.winlua:StopURLVideo(self.streamPlayer:getID())
elseif self.videotype==_type.eLoad then
self.winlua:StopURLVideo(self.LoadPlayer:getID())
elseif self.videotype==_type.eURL then
self.winlua:StopURLVideo(self.URLPlayer:getID())
end
end



function UIVideoTestWin:onBtnPause()
loggerUtil.log('onBtnPause')
if self.videotype==_type.eAB then
self.winlua:PauseClipVideo(self.abPlayer:getID())
elseif self.videotype==_type.eLocal then
self.winlua:PauseURLVideo(self.localPlayer:getID())
elseif self.videotype==_type.eStream then
self.winlua:PauseURLVideo(self.streamPlayer:getID())
elseif self.videotype==_type.eLoad then
self.winlua:PauseURLVideo(self.LoadPlayer:getID())
elseif self.videotype==_type.eURL then
self.winlua:PauseURLVideo(self.URLPlayer:getID())
end
end



function UIVideoTestWin:onBtnPlay()
loggerUtil.log('onBtnPlay')
if self.videotype==_type.eAB then
self.winlua:PlayClipVideo(self.abPlayer:getID(),self.isToggle)
elseif self.videotype==_type.eLocal then
local fileName=self.InputFieldFile:getInputFieldValue()
if fileName==''then
UIManager.error('文件名不能为空')
return
end
self.winlua:PlayURLVideo(self.localPlayer:getID(),'',fileName,self.isToggle,'')
elseif self.videotype==_type.eStream then
local fileName=self.InputFieldFile:getInputFieldValue()
if fileName==''then
UIManager.error('文件名不能为空')
return
end
self.winlua:PlayURLVideo(self.streamPlayer:getID(),'',fileName,self.isToggle,'')
loggerUtil.log(FMT.fmt('onBtnPlay!fileName:{0}',fileName))
elseif self.videotype==_type.eLoad then
local fileName=self.InputFieldFile:getInputFieldValue()
local URL=self.InputFieldURL:getInputFieldValue()
if fileName==''or URL==''then
UIManager.error('文件名或URL不能为空')
return
end
loggerUtil.log(FMT.fmt('onBtnPlay!fileName:{0} URL:{1}',fileName,URL))
self.winlua:PlayURLVideo(self.LoadPlayer:getID(),URL,fileName,self.isToggle,'')
elseif self.videotype==_type.eURL then
local URL=self.InputFieldURL:getInputFieldValue()
if URL==''then
UIManager.error('URL不能为空')
return
end
loggerUtil.log(FMT.fmt('onBtnPlay!URL:{0}',URL))
self.winlua:PlayURLVideo(self.URLPlayer:getID(),URL,'',self.isToggle,'')
end
end



function UIVideoTestWin:onBtnContinue()
loggerUtil.log('onBtnContinue')
if self.videotype==_type.eAB then
self.winlua:ContinueClipVideo(self.abPlayer:getID())
elseif self.videotype==_type.eLocal then
self.winlua:ContinueURLVideo(self.localPlayer:getID())
elseif self.videotype==_type.eStream then
self.winlua:ContinueURLVideo(self.streamPlayer:getID())
elseif self.videotype==_type.eLoad then
self.winlua:ContinueURLVideo(self.LoadPlayer:getID())
elseif self.videotype==_type.eURL then
self.winlua:ContinueURLVideo(self.URLPlayer:getID())
end
end



function UIVideoTestWin:onBtnTestClose()
self.mainPanel:setActive(true)
self.testPanel:setActive(false)
end



function UIVideoTestWin:onBtnAB()
self.mainPanel:setActive(false)
self.testPanel:setActive(true)

self.streamPanel:setActive(false)
self.localPanel:setActive(false)
self.abPanel:setActive(true)
self.loadPanel:setActive(false)
self.URLPanel:setActive(false)

self.InputFieldFile:setActive(false)
self.InputFieldURL:setActive(false)
self.videotype=_type.eAB
end



function UIVideoTestWin:onBtnLocal()
self.mainPanel:setActive(false)
self.testPanel:setActive(true)

self.streamPanel:setActive(false)
self.localPanel:setActive(true)
self.abPanel:setActive(false)
self.loadPanel:setActive(false)
self.URLPanel:setActive(false)


self.InputFieldFile:setActive(true)
self.InputFieldURL:setActive(false)
self.videotype=_type.eLocal
end



function UIVideoTestWin:onBtnStream()
self.mainPanel:setActive(false)
self.testPanel:setActive(true)

self.streamPanel:setActive(true)
self.localPanel:setActive(false)
self.abPanel:setActive(false)
self.loadPanel:setActive(false)
self.URLPanel:setActive(false)

self.InputFieldFile:setActive(true)
self.InputFieldURL:setActive(false)
self.videotype=_type.eStream
end

function UIVideoTestWin:onBtnLoad()
self.mainPanel:setActive(false)
self.testPanel:setActive(true)

self.streamPanel:setActive(false)
self.localPanel:setActive(false)
self.abPanel:setActive(false)
self.loadPanel:setActive(true)
self.URLPanel:setActive(false)

self.InputFieldFile:setActive(true)
self.InputFieldURL:setActive(true)
self.videotype=_type.eLoad
end

function UIVideoTestWin:onBtnStreamMedia()
self.mainPanel:setActive(false)
self.testPanel:setActive(true)

self.streamPanel:setActive(false)
self.localPanel:setActive(false)
self.abPanel:setActive(false)
self.loadPanel:setActive(false)
self.URLPanel:setActive(true)

self.InputFieldFile:setActive(false)
self.InputFieldURL:setActive(true)
self.videotype=_type.eURL
end

function UIVideoTestWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle
self:freshToggle()
if self.videotype==_type.eAB then
self.winlua:SetClipVideoLoop(self.abPlayer:getID(),isToggle)
elseif self.videotype==_type.eLocal then
self.winlua:SetURLVideoLoop(self.localPlayer:getID(),isToggle)
elseif self.videotype==_type.eStream then
self.winlua:SetURLVideoLoop(self.streamPlayer:getID(),isToggle)
elseif self.videotype==_type.eLoad then
self.winlua:SetURLVideoLoop(self.LoadPlayer:getID(),isToggle)
elseif self.videotype==_type.eURL then
self.winlua:SetURLVideoLoop(self.URLPlayer:getID(),isToggle)
end
end

function UIVideoTestWin:onABFinish()
loggerUtil.log('onABFinish')
end

function UIVideoTestWin:onLoadFinish()
loggerUtil.log('onLoadFinish')
end

function UIVideoTestWin:onstreamFinish()
loggerUtil.log('onstreamFinish')
end

function UIVideoTestWin:onLocalFinish()
loggerUtil.log('onLocalFinish')
end

function UIVideoTestWin:onURLLoadFinish()
loggerUtil.log('onURLLoadFinish')
end

function UIVideoTestWin:onVideoWaitLoad()
self:stopLoadingTimer()
self.loadingTimer=self:delayDo(1,function()
self.loading:setActive(true)
end)
end

function UIVideoTestWin:onVideoLoaded()
self:stopLoadingTimer()
self.loading:setActive(false)
end

function UIVideoTestWin:stopLoadingTimer()
if self.loadingTimer then
self:stopTimerByID(self.loadingTimer)
self.loadingTimer=nil
end
end