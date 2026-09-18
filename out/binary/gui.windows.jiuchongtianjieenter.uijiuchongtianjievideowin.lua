







def_class("UIJiuChongTianJieVideoWin",UIWindowBase)









function UIJiuChongTianJieVideoWin:bindComponents()

self.bg=UIObject.get(self,0)
self.bgBtn=UIButton.get(self,1)
self.btnSkip=UIButton.get(self,2)
self.otherUIRoot=UIObject.get(self,3)
self.Player1=UIObject.get(self,4)
self.RawImage1=UIObject.get(self,5)
self.uiRoot=UIObject.get(self,6)

self.bgBtn:setButtonClick(function()self:onBgBtn()end)

self.btnSkip:setButtonClick(function()self:onBtnSkip()end)



end


function UIJiuChongTianJieVideoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.bgBtn);self.bgBtn=nil;
_UIObject_release(self.btnSkip);self.btnSkip=nil;
_UIObject_release(self.otherUIRoot);self.otherUIRoot=nil;
_UIObject_release(self.Player1);self.Player1=nil;
_UIObject_release(self.RawImage1);self.RawImage1=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIJiuChongTianJieVideoWin:onLoaded(...)
self:bindComponents()

self.winlua:SetURLVideoCompleteAction(self.Player1:getID(),function(...)self:onPlayFinish(...)end)
self.winlua:SetURLVideoErrorAction(self.Player1:getID(),function(...)self:onPlayErr(...)end)

AudioManager.setPauseBGMusic(true)
UIManager.setMoneyMsgShowState(false,true)
end


function UIJiuChongTianJieVideoWin:__delete()
self.winlua:SetURLVideoCompleteAction(self.Player1:getID(),nil)

self:unbindComponents()
cameraControl.setCameraActive(true)
AudioManager.setPauseBGMusic(false)
UIManager.setMoneyMsgShowState(true,true)
end




function UIJiuChongTianJieVideoWin:onShow(argtable,afterOnloaded)
cameraControl.setCameraActive(false)
self.callback=argtable.callback
self.url=argtable.url
self.fileName=argtable.name
self:play()
end

function UIJiuChongTianJieVideoWin:play()

if self.loadErr then
self:onPlayFinish()
return
end
self._playing=true

self.bg:setActive(true)
self.uiRoot:setActive(true)
self.otherUIRoot:setActive(true)

self.winlua:PlayURLVideo(self.Player1:getID(),self.url or'',self.fileName,false,'')
downloadAssetWithFileManager:stratDownLoad(LOAD_ASSET_TYPE.xianjie)
end


function UIJiuChongTianJieVideoWin:onHide()

end



function UIJiuChongTianJieVideoWin:onPlayFinish()
if self.callback then self.callback()end
self:delayDo(0.5,function()
if self and not self.isClose then
self:closeSelf()
end
end)
end

function UIJiuChongTianJieVideoWin:onPlayErr(err)
self.loadErr=true

self:onPlayFinish()

loggerUtil.debugErrFMT('播放器播放错误!err:{0}',err)
end




function UIJiuChongTianJieVideoWin:onBgBtn()
end



function UIJiuChongTianJieVideoWin:onBtnSkip()
end



function UIJiuChongTianJieVideoWin:onLeftBtn()
end



function UIJiuChongTianJieVideoWin:onRightBtn()
end

