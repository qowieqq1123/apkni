







def_class("UIJiuChongTianJieStoryWin",UIWindowBase)









function UIJiuChongTianJieStoryWin:bindComponents()

self.back=UIObject.get(self,0)
self.btn=UIButton.get(self,1)
self.downProgressItem=UIObject.get(self,2)
self.precent=UIText.get(self,3)
self.progress=UIProgressBarAni.get(self,4)
self.root=UIObject.get(self,5)
self.story1=UIObject.get(self,6)
self.story1BtnClickEffect=UIObject.get(self,7)
self.story1BtnClickEffect2=UIObject.get(self,8)
self.story1BtnEffect=UIObject.get(self,9)
self.story1Effect=UIObject.get(self,10)
self.story1GoBtn=UIButton.get(self,11)
self.story1Txt=UIObject.get(self,12)
self.story1TxtMask=UIObject.get(self,13)
self.story2=UIObject.get(self,14)
self.story2BtnClickEffect=UIObject.get(self,15)
self.story2BtnEffect=UIObject.get(self,16)
self.story2Effect=UIObject.get(self,17)
self.story2GoBtn=UIButton.get(self,18)
self.story2Txt=UIText.get(self,19)
self.story2TxtMask=UIObject.get(self,20)
self.storyBg=UIObject.get(self,21)

self.btn:setButtonClick(function()self:onBtn()end)

self.story1GoBtn:setButtonClick(function()self:onStory1GoBtn()end)

self.story2GoBtn:setButtonClick(function()self:onStory2GoBtn()end)



end


function UIJiuChongTianJieStoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.downProgressItem);self.downProgressItem=nil;
_UIObject_release(self.precent);self.precent=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.story1);self.story1=nil;
_UIObject_release(self.story1BtnClickEffect);self.story1BtnClickEffect=nil;
_UIObject_release(self.story1BtnClickEffect2);self.story1BtnClickEffect2=nil;
_UIObject_release(self.story1BtnEffect);self.story1BtnEffect=nil;
_UIObject_release(self.story1Effect);self.story1Effect=nil;
_UIObject_release(self.story1GoBtn);self.story1GoBtn=nil;
_UIObject_release(self.story1Txt);self.story1Txt=nil;
_UIObject_release(self.story1TxtMask);self.story1TxtMask=nil;
_UIObject_release(self.story2);self.story2=nil;
_UIObject_release(self.story2BtnClickEffect);self.story2BtnClickEffect=nil;
_UIObject_release(self.story2BtnEffect);self.story2BtnEffect=nil;
_UIObject_release(self.story2Effect);self.story2Effect=nil;
_UIObject_release(self.story2GoBtn);self.story2GoBtn=nil;
_UIObject_release(self.story2Txt);self.story2Txt=nil;
_UIObject_release(self.story2TxtMask);self.story2TxtMask=nil;
_UIObject_release(self.storyBg);self.storyBg=nil;
end
















local _this




function UIJiuChongTianJieStoryWin:onLoaded(...)

_this=self

self:bindComponents()
end


function UIJiuChongTianJieStoryWin:__delete()

_this=nil

self:unbindComponents()
end




function UIJiuChongTianJieStoryWin:onShow(argtable,afterOnloaded)
local type=argtable.type

self.isShowStory1=type==1
self.isShowStory2=type==2

self.story1:setActive(self.isShowStory1)
self.story2:setActive(self.isShowStory2)




local bgEffectId=self.isShowStory1 and 20490 or 20495
self.storyBg:setChildShowEffect(bgEffectId,true)

self.story1TxtMask:setChildIconFillAmount(0)
self.story2TxtMask:setChildSizeDelta(1000,0)
self:showDownProgress()
if argtable.isShowAni then
self:showAni()
end
end


function UIJiuChongTianJieStoryWin:onHide()

end

function UIJiuChongTianJieStoryWin:showAni()


if self.isShowStory1 then



JiuChongTianJieEnterController:stopAudio(1023)
JiuChongTianJieEnterController:playAudio(1023)
self.story1TxtMask:setChildIconFillAmount(0)
self.story1TxtMask:setChildImageDOFillAmount(1,6)

self.story1Effect:setChildShowEffect(20492,true)
elseif self.isShowStory2 then
AudioManager.setPauseBGMusic(false)
AudioManager.playBgMusic(1025)
local story2Desc=cfgHelper.get2(cfg_zongmenhuigubaseconfig_get,1,'story2Desc')
story2Desc=JiuChongTianJieEnterController.replaceReviewInfo(story2Desc)
self.story2Txt:setText(story2Desc)
self.story2TxtMask:setChildDOSizeDelta(Vector2(1000,245),6)

self.story2Effect:setChildShowEffect(20497,true)
end
end



function UIJiuChongTianJieStoryWin:onStory1GoBtn()
AudioManager.playAudio(1024)


if not JiuChongTianJieEnterController:pvPlayComicPlot()then
local fileGroupid=JiuChongTianJieEnterController.getFileGroupId()
if downloadAssetWithFileManager:stratDownLoad(fileGroupid,true)then
return
end
end

self.story1BtnClickEffect:setChildShowEffect(20493,true)
self.story1BtnClickEffect2:setChildShowEffect(20509,true)
self.story1BtnEffect:setChildShowEffect(20491,true)

self:delayDo(1,function()
local isPlay=JiuChongTianJieEnterController:playPv()
if not isPlay then return end
JiuChongTianJieEnterController:stopAudio(1023)
if _this==nil then return end
self:delayDo(1,function()
_this:closeSelf()
end)
end)
end

function UIJiuChongTianJieStoryWin:onStory2GoBtn()
AudioManager.playAudio(1026)

self.story2BtnClickEffect:setChildShowEffect(20498,true)
self.story2BtnEffect:setChildShowEffect(20496,true)


self.story2:setChildCanvasGroupDOFade(0,0.4)

UIManager:showWindow("UIPlotDecorationWin",{canvas=9,effectIdList={20494},autoCloseTime=4})


self:delayDo(1.5,function()
JiuChongTianJieEnterController:startReview()
if _this==nil then return end
_this:closeSelf()
end)
end

function UIJiuChongTianJieStoryWin:onBtn()
local id=JiuChongTianJieEnterController.getFileGroupId()
downloadAssetWithFileManager:stratDownLoad(id,true)
end

function UIJiuChongTianJieStoryWin:showDownProgress()
local id=JiuChongTianJieEnterController.getFileGroupId()
local isLoading=downloadAssetWithFileManager:isDownLoadingAsset(id)
self.downProgressItem:setActive(isLoading)
if isLoading then
local downSize,totalSize=downloadAssetWithFileManager:getProgress()
local progress=downSize/totalSize
local value=math.floor(100*progress)
self.precent:setText(FMT.fmt('{0}%',math.floor(progress*100)))
self.progress:animateThreeParams(value,100,0.2)
end
end

function UIJiuChongTianJieStoryWin:refreshProgress(fileGroupid,downSize,totalSize)

local id=JiuChongTianJieEnterController.getFileGroupId()
if fileGroupid==id then
local progress=downSize/totalSize
local value=math.floor(100*progress)
self.precent:setText(FMT.fmt('{0}%',math.floor(progress*100)))
self.progress:animateThreeParams(value,100,0.2)
end
end
