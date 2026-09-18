







def_class("shareChildZongMenPhoto",UICloneObject)





shareChildZongMenPhoto.abName="ui/windows/shareimage/child/sharechildzongmenphoto.ab"

shareChildZongMenPhoto.assetName="shareChildZongMenPhoto"


function shareChildZongMenPhoto:bindComponents()

self.uiRoot=UIObject.get(self,0)
self.whiteBack=UIObject.get(self,1)
self.picture=UIImage.get(self,2)
self.photoKuang=UIObject.get(self,3)
self.rawImage=UIObject.get(self,4)
self.leftDown=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.photo=UIObject.get(self,7)
self.headIcon=UIObject.get(self,8)
self.waterMarkImage=UIObject.get(self,9)
self.qrCodeImage=UIImage.get(self,10)
self.invitationCodeTx=UIText.get(self,11)
self.playerNameTx=UIText.get(self,12)
self.playerInfoPanel=UIObject.get(self,13)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

end


function shareChildZongMenPhoto:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.whiteBack);self.whiteBack=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.waterMarkImage);self.waterMarkImage=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.invitationCodeTx);self.invitationCodeTx=nil;
_UIObject_release(self.playerNameTx);self.playerNameTx=nil;
_UIObject_release(self.playerInfoPanel);self.playerInfoPanel=nil;
end





local _this




function shareChildZongMenPhoto:onLoaded(...)
_this=self
self:bindComponents()
end


function shareChildZongMenPhoto:__delete()
if self.closeCallback then
self.closeCallback()
end
_this=nil
self:unbindComponents()
end




function shareChildZongMenPhoto:onShow(argtable,afterOnloaded)




local cfgId=argtable.cfgId
self.config=cfgHelper.get(cfg_shareimagebaseconfig_get,cfgId)
self.closeCallback=argtable.closeCallback
self.closeCallback_frame=argtable.closeCallback_frame
self.zmCameraTF=argtable.cameraTF
local cameraGO=mainControl:getUICamera()
self.uiCameraTF=cameraGO.transform

self:refreshPlayerInfo(true)
self:refreshQRCode()
self:refreshWaterMarkImage()
self:refreshZongMenPhoto()
end


function shareChildZongMenPhoto:onHide()

end

function shareChildZongMenPhoto:refreshPlayerInfo(isInit)
if isInit and self.isShowPlayerInfo_init~=nil then
self:changePlayerInfoShow(self.isShowPlayerInfo_init)
end
self:refreshInvitationCode()
playerController:setHeadIcon(self.widget,self.headIcon:getID(),{stopHeadKuangAnim=true})

local playerName=playerModel:getActorName()
self.playerNameTx:setText(FMT.fmt("祖师名：{0}",playerName))
end

function shareChildZongMenPhoto:refreshInvitationCode()
local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
local isOpen=welfareModel:isOpenYaoQingMa()
local isShowInvitationCode=isOpen and selfInvitationCode_int_64~=nil and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))
self.invitationCodeTx:setActive(isShowInvitationCode)
if isShowInvitationCode then
local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeTx:setText(FMT.fmt("邀请码：<color=#ECAF51>{0}</color>",invitationCode))
end
end

function shareChildZongMenPhoto:refreshQRCode()
local _QRCodeImage=shareImageModel:getQRCodeImageName()
if _QRCodeImage then
local _QRCodeAb=shareImageModel:getQRCodeImageAbName(_QRCodeImage)
self.qrCodeImage:setSprite(_QRCodeAb,_QRCodeImage)
self.qrCodeImage:setActive(true)
else
self.qrCodeImage:setActive(false)
end
end

function shareChildZongMenPhoto:refreshWaterMarkImage()

local waterMarkParam=self.config.waterMarkShowParam or{}
local waterMarkOffset=waterMarkParam.offset or{306,-225}
local waterMarkScale=waterMarkParam.scale or 1
self.waterMarkImage:setChildAnchoredPos(waterMarkOffset[1],waterMarkOffset[2])
self.waterMarkImage:setScale(Vector3.New(waterMarkScale,waterMarkScale,waterMarkScale))
end

function shareChildZongMenPhoto:refreshZongMenPhoto()
self.widget:SetChildCaptureTexture(self.picture:getID(),self.zmCameraTF)


end

function shareChildZongMenPhoto:takePhoto(callback)
local callback1=function()
if _this==nil or _this.isClose then return end
local fileName=FMT.fmt('shareImage{0}.png',os.date('%m%d%H%M%S'))
local filePath=FMT.fmt('{0}/photo/{1}',CS.GamePath.writablePath,fileName)
_this.widget:SaveTextue(_this.photo:getID(),filePath)
if callback then
return callback(fileName)
end
end
local callback2=function()
if _this==nil or _this.isClose then return end

_this.uiRoot:setChildCanvasEx('UITopModel',1010)
_this.widget:CroppingTexture(_this.photo:getID(),_this.uiCameraTF,_this.leftDown:getID(),callback1)

end

self.uiRoot:setChildCanvasEx('UISystemTip',2900)
self.widget:EnableCaptureScreen(self.rawImage:getID(),self.uiCameraTF,true,0,0,1,callback2)
end

function shareChildZongMenPhoto:changePlayerInfoShow(isShow,callback)
local alpha=isShow and 1 or 0
self.playerInfoPanel:setChildCanvasGroupAlpha(alpha)
if callback then
return callback()
end
end
function shareChildZongMenPhoto:initPlayerInfoShow(isShow,callback)
self.isShowPlayerInfo_init=isShow
if callback then
return callback()
end
end

function shareChildZongMenPhoto:onCloseBtn()
if self.closeCallback_frame then
self.closeCallback_frame()
end
end

