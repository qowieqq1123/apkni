







def_class("shareChildDuJieFeiSheng",UICloneObject)





shareChildDuJieFeiSheng.abName="ui/windows/shareimage/child/sharechilddujiefeisheng.ab"

shareChildDuJieFeiSheng.assetName="shareChildDuJieFeiSheng"


function shareChildDuJieFeiSheng:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.headIcon=UIObject.get(self,1)
self.leftDown=UIObject.get(self,2)
self.photo=UIObject.get(self,3)
self.photoKuang=UIObject.get(self,4)
self.picture=UIObject.get(self,5)
self.playerNameTx=UIText.get(self,6)
self.playerServerNameTx=UIText.get(self,7)
self.qrCodeImage=UIImage.get(self,8)
self.rawImage=UIObject.get(self,9)
self.uiRoot=UIObject.get(self,10)
self.waterMarkImage=UIObject.get(self,11)
self.whiteBack=UIObject.get(self,12)
self.word_1=UIText.get(self,13)
self.word_2=UIText.get(self,14)
self.word_3=UIText.get(self,15)
self.word_4=UIText.get(self,16)
self.word_bg_1=UIObject.get(self,17)
self.word_bg_2=UIObject.get(self,18)
self.word_bg_3=UIObject.get(self,19)
self.word_bg_4=UIObject.get(self,20)
self.words=UIObject.get(self,21)
self.zsModel=UIObject.get(self,22)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.word={
self.word_1,
self.word_2,
self.word_3,
self.word_4,
}
self.word_bg={
self.word_bg_1,
self.word_bg_2,
self.word_bg_3,
self.word_bg_4,
}

end


function shareChildDuJieFeiSheng:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.playerNameTx);self.playerNameTx=nil;
_UIObject_release(self.playerServerNameTx);self.playerServerNameTx=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.waterMarkImage);self.waterMarkImage=nil;
_UIObject_release(self.whiteBack);self.whiteBack=nil;
_UIObject_release(self.word_1);self.word_1=nil;
_UIObject_release(self.word_2);self.word_2=nil;
_UIObject_release(self.word_3);self.word_3=nil;
_UIObject_release(self.word_4);self.word_4=nil;
_UIObject_release(self.word_bg_1);self.word_bg_1=nil;
_UIObject_release(self.word_bg_2);self.word_bg_2=nil;
_UIObject_release(self.word_bg_3);self.word_bg_3=nil;
_UIObject_release(self.word_bg_4);self.word_bg_4=nil;
_UIObject_release(self.words);self.words=nil;
_UIObject_release(self.zsModel);self.zsModel=nil;
self.word=nil;
self.word_bg=nil;
end





local _this




function shareChildDuJieFeiSheng:onLoaded(...)
_this=self
self:bindComponents()
end


function shareChildDuJieFeiSheng:__delete()
_this=nil
self:unbindComponents()
end




function shareChildDuJieFeiSheng:onShow(argtable,afterOnloaded)

local cfgId=argtable.cfgId
self.config=cfgHelper.get(cfg_shareimagebaseconfig_get,cfgId)
self.closeCallback=argtable.closeCallback
self.closeCallback_frame=argtable.closeCallback_frame

local cameraGO=mainControl:getUICamera()
self.cameraTF=cameraGO.transform

self:refreshPlayerInfo()
self:refreshQRCode()
self:refreshWaterMarkImage()
self:refreshShowWords()
end


function shareChildDuJieFeiSheng:onHide()

end

function shareChildDuJieFeiSheng:refreshPlayerInfo()
playerController:setHeadIcon(self.widget,self.headIcon:getID(),{stopHeadKuangAnim=true})

local playerName=playerModel:getActorName()
self.playerNameTx:setText(FMT.fmt("祖师名：{0}",playerName))

local serverId=playerModel:getActorServerID()
local serverName=loginModel:getServerName(serverId)
self.playerServerNameTx:setText(FMT.fmt("区服：{0}",serverName))
end

function shareChildDuJieFeiSheng:refreshQRCode()
local _QRCodeImage=shareImageModel:getQRCodeImageName()
if _QRCodeImage then
local _QRCodeAb=shareImageModel:getQRCodeImageAbName(_QRCodeImage)
self.qrCodeImage:setSprite(_QRCodeAb,_QRCodeImage)
self.qrCodeImage:setActive(true)
else
self.qrCodeImage:setActive(false)
end
end

function shareChildDuJieFeiSheng:refreshShowWords()
local blocks=JiuChongTianJieEnterModel:getReviewBlocks(2)

local wordBlocks=table.sub(blocks,1,4)

local words={}

for index,wordBlock in ipairs(wordBlocks)do
local word=wordBlock.cfg.shareWord
if wordBlock.cfg.type~=0 then
word=FMT.fmt(word,table.unpackEx(wordBlock.blockData.args))
end
word=JiuChongTianJieEnterController.replaceReviewInfo(word)

words[#words+1]=word
end

for index,wordBgItem in ipairs(self.word_bg)do
local info=words[index]
local isShow=info~=nil
wordBgItem:setActive(isShow)
if isShow then
local wordItem=self.word[index]
wordItem:setText(words[index])
end
end

local playerImage=playerImageModel:getPlayerImage()or
playerImageModel:getDefaultImage()
playerImageController.setPlayerModel(self.widget,self.zsModel:getID(),playerImage,1,eAnimationID.idle,0,0,playerController:supportDynamic())
end


function shareChildDuJieFeiSheng:refreshWaterMarkImage()

local waterMarkParam=self.config.waterMarkShowParam or{}
local waterMarkOffset=waterMarkParam.offset or{306,-225}
local waterMarkScale=waterMarkParam.scale or 1
self.waterMarkImage:setChildAnchoredPos(waterMarkOffset[1],waterMarkOffset[2])
self.waterMarkImage:setScale(Vector3.New(waterMarkScale,waterMarkScale,waterMarkScale))
end

function shareChildDuJieFeiSheng:takePhoto(callback)
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

function shareChildDuJieFeiSheng:onCloseBtn()
if self.closeCallback_frame then
self.closeCallback_frame()
end
if self.closeCallback then
self.closeCallback()
end
end


