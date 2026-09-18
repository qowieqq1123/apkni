







def_class("shareChildSimplePicture",UICloneObject)





shareChildSimplePicture.abName="ui/windows/shareimage/child/sharechildsimplepicture.ab"

shareChildSimplePicture.assetName="shareChildSimplePicture"


function shareChildSimplePicture:bindComponents()

self.uiRoot=UIObject.get(self,0)
self.whiteBack=UIObject.get(self,1)
self.picture=UIImage.get(self,2)
self.photoKuang=UIObject.get(self,3)
self.rawImage=UIObject.get(self,4)
self.leftDown=UIObject.get(self,5)
self.rumendi=UIObject.get(self,6)
self.word=UIImage.get(self,7)
self.tian=UIObject.get(self,8)
self.closeBtn=UIButton.get(self,9)
self.photo=UIObject.get(self,10)
self.headIcon=UIObject.get(self,11)
self.qrCodeImage=UIImage.get(self,12)
self.invitationCodeTx=UIText.get(self,13)
self.playerNameTx=UIText.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

end


function shareChildSimplePicture:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.whiteBack);self.whiteBack=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.rumendi);self.rumendi=nil;
_UIObject_release(self.word);self.word=nil;
_UIObject_release(self.tian);self.tian=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.invitationCodeTx);self.invitationCodeTx=nil;
_UIObject_release(self.playerNameTx);self.playerNameTx=nil;
end





local _this=nil



function shareChildSimplePicture:onLoaded(...)
self:bindComponents()
_this=self
end


function shareChildSimplePicture:__delete()
self:unbindComponents()
_this=nil
end




function shareChildSimplePicture:onShow(argtable,afterOnloaded)
self.picAB=argtable.picAB
self.picName=argtable.picName
self.wordAB=argtable.wordAB
self.wordName=argtable.wordName
self.closeCallback=argtable.closeCallback
self.closeCallback_frame=argtable.closeCallback_frame
local cameraGO=mainControl:getUICamera()
self.cameraTF=cameraGO.transform

self:refreshPlayerInfo()
self:refreshQRCode()
self:refreshCloseBtn()
self:refreshPicture()
end


function shareChildSimplePicture:onHide()

end




function shareChildSimplePicture:refreshPlayerInfo()
self:refreshInvitationCode()
playerController:setHeadIcon(self.widget,self.headIcon:getID(),{stopHeadKuangAnim=true})

local playerName=playerModel:getActorName()
self.playerNameTx:setText(FMT.fmt("祖师名：{0}",playerName))
end

function shareChildSimplePicture:refreshInvitationCode()
local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()


if selfInvitationCode_int_64 then
local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeTx:setText(FMT.fmt("邀请码：<color=#ECAF51>{0}</color>",invitationCode))
else
self.invitationCodeTx:setText("")
end
end

function shareChildSimplePicture:refreshQRCode()
local _QRCodeImage=shareImageModel:getQRCodeImageName()
if _QRCodeImage then
local _QRCodeAb=shareImageModel:getQRCodeImageAbName(_QRCodeImage)
self.qrCodeImage:setSprite(_QRCodeAb,_QRCodeImage)
self.qrCodeImage:setActive(true)
else
self.qrCodeImage:setActive(false)
end
end

function shareChildSimplePicture:refreshPicture()
self.picture:setSprite(self.picAB,self.picName)
self.word:setSprite(self.wordAB,self.wordName)
local show=self.wordAB~=nil and self.wordName~=nil
self.rumendi:setActive(show)
self.tian:setActive(show)
end

function shareChildSimplePicture:takePhoto(callback)

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
_this.widget:CroppingTexture(_this.photo:getID(),_this.cameraTF,_this.leftDown:getID(),callback1)

end

self.uiRoot:setChildCanvasEx('UISystemTip',2900)
self.widget:EnableCaptureScreen(self.rawImage:getID(),self.cameraTF,true,0,0,1,callback2)
end

function shareChildSimplePicture:onCloseBtn()
if self.closeCallback_frame then
self.closeCallback_frame()
end
if self.closeCallback then
self.closeCallback()
end
end

function shareChildSimplePicture:refreshCloseBtn()

self.closeBtn:setActive(true)
end
