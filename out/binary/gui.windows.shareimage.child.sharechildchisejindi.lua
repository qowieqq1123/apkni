







def_class("shareChildChiSeJinDi",UICloneObject)





shareChildChiSeJinDi.abName="ui/windows/shareimage/child/sharechildchisejindi.ab"

shareChildChiSeJinDi.assetName="shareChildChiSeJinDi"


function shareChildChiSeJinDi:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.headIcon=UIObject.get(self,1)
self.invitationCodeTx=UIText.get(self,2)
self.leftDown=UIObject.get(self,3)
self.photo=UIObject.get(self,4)
self.photoKuang=UIObject.get(self,5)
self.picture=UIImage.get(self,6)
self.playerNameTx=UIText.get(self,7)
self.pos_1=UIObject.get(self,8)
self.pos_2=UIObject.get(self,9)
self.pos_3=UIObject.get(self,10)
self.pos_4=UIObject.get(self,11)
self.pos_5=UIObject.get(self,12)
self.qrCodeImage=UIImage.get(self,13)
self.rawImage=UIObject.get(self,14)
self.tipsTx=UIText.get(self,15)
self.uiRoot=UIObject.get(self,16)
self.whiteBack=UIObject.get(self,17)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.pos={
self.pos_1,
self.pos_2,
self.pos_3,
self.pos_4,
self.pos_5,
}

end


function shareChildChiSeJinDi:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.invitationCodeTx);self.invitationCodeTx=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.playerNameTx);self.playerNameTx=nil;
_UIObject_release(self.pos_1);self.pos_1=nil;
_UIObject_release(self.pos_2);self.pos_2=nil;
_UIObject_release(self.pos_3);self.pos_3=nil;
_UIObject_release(self.pos_4);self.pos_4=nil;
_UIObject_release(self.pos_5);self.pos_5=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.whiteBack);self.whiteBack=nil;
self.pos=nil;
end





local _posCmp={
widget=-1,
model=0,
color=1,
item=2,
itemIcon=3,
itemStarBg=4,
itemStarTx=5,
name=6,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"
local _this=nil



function shareChildChiSeJinDi:onLoaded(...)
self:bindComponents()
_this=self
end


function shareChildChiSeJinDi:__delete()
self:unbindComponents()
_this=nil
end




function shareChildChiSeJinDi:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.team=argtable.team
self.closeCallback=argtable.closeCallback
self.closeCallback_frame=argtable.closeCallback_frame

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local cameraGO=mainControl:getUICamera()
self.cameraTF=cameraGO.transform

self:refreshInfo()
self:refreshInvitationCode()
self:refreshPlayerInfo()
self:refreshQRCode()
self:refreshCloseBtn()
end


function shareChildChiSeJinDi:onHide()

end



function shareChildChiSeJinDi:onCloseBtn()
if self.closeCallback_frame then
self.closeCallback_frame()
end
if self.closeCallback then
self.closeCallback()
end
end

function shareChildChiSeJinDi:refreshCloseBtn()

self.closeBtn:setActive(true)
end

function shareChildChiSeJinDi:refreshQRCode()
local _QRCodeImage=shareImageModel:getQRCodeImageName()
if _QRCodeImage then
local _QRCodeAb=shareImageModel:getQRCodeImageAbName(_QRCodeImage)
self.qrCodeImage:setSprite(_QRCodeAb,_QRCodeImage)
self.qrCodeImage:setActive(true)
else
self.qrCodeImage:setActive(false)
end
end

function shareChildChiSeJinDi:refreshInvitationCode()
local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
if selfInvitationCode_int_64 then
local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeTx:setText(FMT.fmt("邀请码：<color=#ECAF51>{0}</color>",invitationCode))
else
self.invitationCodeTx:setText("")
end
end

function shareChildChiSeJinDi:refreshPlayerInfo()
playerController:setHeadIcon(self.widget,self.headIcon:getID(),{stopHeadKuangAnim=true})

local playerName=playerModel:getActorName()
self.playerNameTx:setText(FMT.fmt("祖师名：{0}",playerName))
end

function shareChildChiSeJinDi:takePhoto(callback)
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

function shareChildChiSeJinDi:refreshInfo()
local name=self.config.sub_name or cfgHelper.get2(cfg_subactivitytypeconfig_get,self.subType,'name')
self.tipsTx:setText(FMT.fmt("{0}通关阵容",name))

for index,cmp in ipairs(self.pos)do
local widget=cmp:getChildWidgetBase()
local posData=self.team[index]
widget:SetChildActive(_posCmp.widget,posData.disciple>0)
if posData.disciple>0 then
local discipleServer=self.config.disciple[posData.disciple]
local discipleColor=discipleServer[5]
local monsterId=discipleServer[1]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local modelParams=monsterCfg.modelid
widget:SetChildUIModelShowTarget(_posCmp.model,modelParams[1],0.75,modelParams[2]or{},eAnimationID.stand,false,false,0,nil)
widget:SetChildUIModelShowFlipX(_posCmp.model,true)
widget:SetChildText(_posCmp.name,monsterCfg.name)
widget:SetChildCSImageSprite(_posCmp.color,_abName,FMT.fmt("image_chiseshilian_pz{0}",discipleColor))
widget:SetChildActive(_posCmp.item,posData.weapon>0)
if posData.weapon>0 then
local weaponServer=self.config.treasure[posData.weapon]
local weaponClient=self.config.treasureClient[posData.weapon]
local weaponAttr=weaponServer[1]
local color=weaponServer[6]
local iconName=weaponClient[2]
local star=self.info:getCopyItemStar(posData.weapon)
widget:SetChildQulaity(_posCmp.item,color)
widget:SetChildCSImageIcon(_posCmp.itemIcon,iconName,false)
widget:SetChildActive(_posCmp.itemStarBg,star>0)
widget:SetChildText(_posCmp.itemStarTx,star>0 and star or"")
end
end
end
end