







def_class("UIZongMenPhotoWin",UIWindowBase)









function UIZongMenPhotoWin:bindComponents()

self.RawImage=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.photobg=UIObject.get(self,2)
self.photo=UIObject.get(self,3)
self.selectCntSlider=UIObject.get(self,4)
self.takeButton=UIButton.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.shareButton=UIButton.get(self,7)
self.saveButton=UIButton.get(self,8)
self.handleImg=UIObject.get(self,9)
self.subButton=UIButton.get(self,10)
self.addButton=UIButton.get(self,11)
self.photoRoot=UIObject.get(self,12)
self.playerInfo=UIObject.get(self,13)
self.waterMarkImage=UIObject.get(self,14)
self.imageQRCode=UIImage.get(self,15)
self.headIconCreater=UIObject.get(self,16)
self.invitationCodeText=UIText.get(self,17)
self.playerName=UIText.get(self,18)
self.tipsTitle=UIText.get(self,19)
self.tipsText=UIText.get(self,20)
self.leftDown=UIObject.get(self,21)
self.uiRawImage=UIObject.get(self,22)
self.uiPhoto=UIObject.get(self,23)
self.shareReward=UIObject.get(self,24)
self.shareRewardIcon=UIObject.get(self,25)
self.shareRewardCount=UIText.get(self,26)
self.showInfoToggle=UIToggleButton.get(self,27)
self.takePhotoPanel=UIObject.get(self,28)
self.finishPhotoPanel=UIObject.get(self,29)

self.takeButton:setButtonClick(function()self:onTakeButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.shareButton:setButtonClick(function()self:onShareButton()end)

self.saveButton:setButtonClick(function()self:onSaveButton()end)

self.subButton:setButtonClick(function()self:onSubButton()end)

self.addButton:setButtonClick(function()self:onAddButton()end)


self.sprite_image_taptaplogo_2=0

end


function UIZongMenPhotoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.RawImage);self.RawImage=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.photobg);self.photobg=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.takeButton);self.takeButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.shareButton);self.shareButton=nil;
_UIObject_release(self.saveButton);self.saveButton=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.subButton);self.subButton=nil;
_UIObject_release(self.addButton);self.addButton=nil;
_UIObject_release(self.photoRoot);self.photoRoot=nil;
_UIObject_release(self.playerInfo);self.playerInfo=nil;
_UIObject_release(self.waterMarkImage);self.waterMarkImage=nil;
_UIObject_release(self.imageQRCode);self.imageQRCode=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.invitationCodeText);self.invitationCodeText=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.tipsTitle);self.tipsTitle=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.uiRawImage);self.uiRawImage=nil;
_UIObject_release(self.uiPhoto);self.uiPhoto=nil;
_UIObject_release(self.shareReward);self.shareReward=nil;
_UIObject_release(self.shareRewardIcon);self.shareRewardIcon=nil;
_UIObject_release(self.shareRewardCount);self.shareRewardCount=nil;
_UIObject_release(self.showInfoToggle);self.showInfoToggle=nil;
_UIObject_release(self.takePhotoPanel);self.takePhotoPanel=nil;
_UIObject_release(self.finishPhotoPanel);self.finishPhotoPanel=nil;
end
















local _this



local _max_orthographic_size=10
local _min_orthographic_size=2
local _default_orthographic_size=4

local writablePath=CS.GamePath.writablePath..'/'..'photo/'


function UIZongMenPhotoWin:onLoaded(...)
_this=self
self:bindComponents()

self.showRawImage=false
local func=function(...)
self:onSliderChange(...)
end
local orthographicSize=cfgHelper.getdef(cfg_shareimagebaseconfig,"orthographicSize")
self.selectCnt=orthographicSize[3]
self.winlua:SetChildImageRaycast(self.handleImg:getID(),true)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,orthographicSize[1],orthographicSize[2],func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

self:addNotify(notifyConfig.pinch,function()self:on_pinch()end)


end


function UIZongMenPhotoWin:__delete()
_this=nil
self:unbindComponents()
self:closeScreenBlur()
isometricMapSystem:leavePhotoMode()
end

function UIZongMenPhotoWin:on_pinch()
if isometricMapSystem:isCanControl()then
local size=_MapManager.GetCameraOrthographicSize()
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),size)
end
end




function UIZongMenPhotoWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.sortLayer=argtable.sortLayer
self.sortOrder=argtable.sortOrder

isometricMapSystem:enterPhotoMode(true)

self.shareType=shareImageModel:getShareTypeByWinName(self.window_name)
self:setAsFirstSibling()

self.filePath=nil
self.fileName=nil
self.photoPanelType=1
dragonControl.lockEntity(true)
local cameraGO=mainControl:getUICamera()
self.uiCameraTF=cameraGO.transform



self:refreshShareRewardShow()


if self.sortLayer and self.sortOrder then
self:setImageCanvas(self.sortLayer,self.sortOrder)
end
end

function UIZongMenPhotoWin:initPlayerInfo()

local qrCodeImageName=shareImageModel:getQRCodeImageName()
local qrCodeImageAbName=shareImageModel:getQRCodeImageAbName(qrCodeImageName)
self.imageQRCode:setSprite(qrCodeImageAbName,qrCodeImageName)


local playerName=playerModel:getActorName()
self.playerName:setText(FMT.fmt("祖师名：{0}",playerName))


playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{scale=0.6,stopHeadKuangAnim=true})

local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
local isOpen=welfareModel:isOpenYaoQingMa()
local isShowInvitationCode=isOpen and selfInvitationCode_int_64~=nil and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))
local baseCfg=cfgHelper.get1(cfg_shareimagebaseconfig_get,1)
local tipsTitleStr=baseCfg.normalTipsTitleStr
local tipsTextStr=baseCfg.normalTipsTextStr
if isShowInvitationCode then

local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
if selfInvitationCode_int_64 and mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))then
local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeText:setText(FMT.fmt("邀请码：<color=#FFFF00>{0}</color>",invitationCode))
else
self.invitationCodeText:setText("")
end
tipsTitleStr="输入我的『邀请码』"
local rewardText=""
local const_def=cfg_yaoqingmaconfig().const_def
local rewards=const_def.bind_reward
local count=#rewards
for i,v in ipairs(rewards)do
local itemId=v[1]
local itemCount=v[2]
local itemcfg=itemsConfig.getConfig(itemId)
local s=FMT.fmt('{0}*{1}',itemcfg.name,itemCount)

if i<count then
rewardText=FMT.fmt('{0}{1}，',rewardText,s)
else
rewardText=FMT.fmt('{0}{1}',rewardText,s)
end
end

tipsTextStr=FMT.fmt("送您{0}",rewardText)
end
self.invitationCodeText:setActive(isShowInvitationCode)

self.tipsTitle:setText(tipsTitleStr)


self.tipsText:setText(tipsTextStr)
end

function UIZongMenPhotoWin:takeAPhoto()
self.showRawImage=true
self.photoRoot:setActive(false)
self.finishTakeZmPhoto=false
local camera=cameraControl.getCameraTransform()
if camera==nil then return end
local finishCallback=function()
self.RawImage:setActive(true)

self.takePhotoPanel:setActive(false)

self.RawImage:setChildCanvasGroupAlpha(0)
self.RawImage:setChildCanvasGroupDOFade(1,0.5,function()

self.widget:EnableCaptureScreenBlur(self.RawImage:getID(),camera)














local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
self.photoPanelType=2
local param={
cameraTF=camera,
closeCallback=function()
if _this==nil then return end
if UIManager:isActive("UIZongMenPhotoWin")then
_this:refreshFirstPanel()
end
end
}
shareImageController:showShareImageWin(shareShowType,param)
end)
end
self.widget:EnableCaptureScreen(self.RawImage:getID(),camera,true,0,0,1,finishCallback)
end

function UIZongMenPhotoWin:takeUIPhoto(callback)
if not self.finishTakeZmPhoto then
UIManager.error("点击过快 请稍后再试")
return
end

local finishCallback=function()
if _this==nil then return end



_this.photoRoot:setChildCanvasEx('CanvasBottom',1100)
_this.widget:CroppingTexture(_this.uiPhoto:getID(),_this.uiCameraTF,_this.leftDown:getID())
if callback then
return callback()
end
end
self.photoRoot:setActive(true)
self.photoRoot:setScale(Vector3(0.625,0.625,0.625))

self.photoRoot:setChildCanvasEx('UISystemTip',2900)
self.widget:EnableCaptureScreen(self.uiRawImage:getID(),self.uiCameraTF,true,0,0,1,finishCallback)
end

function UIZongMenPhotoWin:setImageCanvas(sortLayer,sortOrder)

self.RawImage:setChildCanvasEx(sortLayer,sortOrder)
end

function UIZongMenPhotoWin:resetImageCanvas()
self.RawImage:setChildRemoveCanvas()
end

function UIZongMenPhotoWin:onHide()
self:closeScreenBlur()

isometricMapSystem:leavePhotoMode()
end

function UIZongMenPhotoWin:showW()
UIManager:showWindow("UIZongMenPhotoWin")
end

function UIZongMenPhotoWin:onSliderChange(value)
self.selectCnt=value
isometricMapSystem:setCameraOrthoSize(value,0)
end

function UIZongMenPhotoWin:refreshFirstPanel()
self.finishPhotoPanel:setActive(false)
self.takePhotoPanel:setActive(true)


self.photoRoot:setActive(false)
self.photoRoot:setChildCanvasGroupAlpha(0)
self.photoPanelType=1
self.fileName=nil
self.filePath=nil
self:closeScreenBlur()
end


function UIZongMenPhotoWin:refreshShareRewardShow()

local isShow=false
local isShowShareBtn=shareImageModel:isOpenShareImage()
if isShowShareBtn and self.shareType then
local canGetNum=shareImageModel:getShareRewardCanGetNumByType(self.shareType)
isShow=canGetNum>0
end
self.shareReward:setActive(isShow)
if isShow then

local rewards=cfgHelper.get(cfg_yaoqingmadailyconfig_get,self.shareType,"rewards")
if rewards then

local reward=rewards[1]
local itemId=reward[1]
local itemCount=reward[2]
local countStr=''
if itemCount>1 then
countStr=mathHelper.formatNumber(itemCount)
end
self.shareRewardIcon:setChildIcon(iconHelper.getIconName(itemId),false)
self.shareRewardCount:setText(countStr)
end
end
end



















function UIZongMenPhotoWin:closeScreenBlur()

if not self.showRawImage then return end
self.showRawImage=false
dragonControl.lockEntity(false)
self.RawImage:setActive(false)
self.RawImage:setChildCanvasGroupAlpha(0)
local camera,cameraType=cameraControl.getCameraTransform()
if camera==nil then
loggerUtil.logErrFMT('提示用！场景类型：{0}',tostring(cameraType))
return
end
self.widget:DisableCaptureScreenBlur(self.RawImage:getID(),camera)
end

function UIZongMenPhotoWin:onTakeButton()
self:takeAPhoto()
end

function UIZongMenPhotoWin:onCloseBtn()
if self.photoPanelType==2 then
self:refreshFirstPanel()
else
UIFullZongMenPhotoControl:closeUI(true,true)
end
end

function UIZongMenPhotoWin:onShareButton()
self:onSaveButton()
if self.fileName then
platformSDK:reqShareImage(self.fileName)
end


shareImageController:reqGetShareImageReward(self.shareType)
end

function UIZongMenPhotoWin:onSaveButton()
local name=FMT.fmt('zmPhoto{0}.png',os.date('%mm%dd%Hh%Mm%Ss'))
self.fileName=name
self.filePath=FMT.fmt("{0}{1}",writablePath,name)
local callback=function()
UIManager.info("保存成功")
self.widget:SaveTextue(self.uiPhoto:getID(),self.filePath)
end
self:takeUIPhoto(callback)
end

function UIZongMenPhotoWin:onAddButton()
if self.selectCnt>=_max_orthographic_size-0.1 then
return
end
self.selectCnt=self.selectCnt+0.2
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIZongMenPhotoWin:onSubButton()
if self.selectCnt<=_min_orthographic_size+0.1 then
return
end
self.selectCnt=self.selectCnt-0.2
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


