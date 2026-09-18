







def_class("shareChildDiscipleInfo",UICloneObject)





shareChildDiscipleInfo.abName="ui/windows/shareimage/child/sharechilddiscipleinfo.ab"

shareChildDiscipleInfo.assetName="shareChildDiscipleInfo"


function shareChildDiscipleInfo:bindComponents()

self.uiRoot=UIObject.get(self,0)
self.whiteBack=UIObject.get(self,1)
self.photoKuang=UIObject.get(self,2)
self.rawImage=UIObject.get(self,3)
self.leftDown=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.photo=UIObject.get(self,6)
self.headIcon=UIObject.get(self,7)
self.qrCodeImage=UIImage.get(self,8)
self.invitationCodeTx=UIText.get(self,9)
self.playerNameTx=UIText.get(self,10)
self.waterMarkImage=UIObject.get(self,11)
self.discipleColorIcon=UIImage.get(self,12)
self.discipleNameText=UIText.get(self,13)
self.discipleJobText=UIText.get(self,14)
self.disciplePosText=UIText.get(self,15)
self.polygonAttrPanel=UIObject.get(self,16)
self.descListPanel=UIObject.get(self,17)
self.discipleModel=UIObject.get(self,18)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

end


function shareChildDiscipleInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.whiteBack);self.whiteBack=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.invitationCodeTx);self.invitationCodeTx=nil;
_UIObject_release(self.playerNameTx);self.playerNameTx=nil;
_UIObject_release(self.waterMarkImage);self.waterMarkImage=nil;
_UIObject_release(self.discipleColorIcon);self.discipleColorIcon=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobText);self.discipleJobText=nil;
_UIObject_release(self.disciplePosText);self.disciplePosText=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
end





local _this
local maxShowSpecialityCount=4




function shareChildDiscipleInfo:onLoaded(...)
_this=self
self:bindComponents()
end


function shareChildDiscipleInfo:__delete()
_this=nil
self:unbindComponents()
end




function shareChildDiscipleInfo:onShow(argtable,afterOnloaded)





local cfgId=argtable.cfgId
self.config=cfgHelper.get(cfg_shareimagebaseconfig_get,cfgId)
self.disciple_guid=argtable.disciple_guid
self.closeCallback=argtable.closeCallback
self.closeCallback_frame=argtable.closeCallback_frame
local cameraGO=mainControl:getUICamera()
self.cameraTF=cameraGO.transform

self:refreshPlayerInfo()
self:refreshQRCode()
self:refreshDiscipleInfo()
self:refreshWaterMarkImage()
end


function shareChildDiscipleInfo:onHide()

end
function shareChildDiscipleInfo:refreshPlayerInfo()
self:refreshInvitationCode()
playerController:setHeadIcon(self.widget,self.headIcon:getID(),{stopHeadKuangAnim=true})

local playerName=playerModel:getActorName()
self.playerNameTx:setText(FMT.fmt("祖师名：{0}",playerName))
end

function shareChildDiscipleInfo:refreshInvitationCode()
local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
local isOpen=welfareModel:isOpenYaoQingMa()
local isShowInvitationCode=isOpen and selfInvitationCode_int_64~=nil and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))
self.invitationCodeTx:setActive(isShowInvitationCode)
if isShowInvitationCode then
local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeTx:setText(FMT.fmt("邀请码：<color=#ECAF51>{0}</color>",invitationCode))
end
end

function shareChildDiscipleInfo:refreshQRCode()
local _QRCodeImage=shareImageModel:getQRCodeImageName()
if _QRCodeImage then
local _QRCodeAb=shareImageModel:getQRCodeImageAbName(_QRCodeImage)
self.qrCodeImage:setSprite(_QRCodeAb,_QRCodeImage)
self.qrCodeImage:setActive(true)
else
self.qrCodeImage:setActive(false)
end
end

function shareChildDiscipleInfo:refreshWaterMarkImage()

local waterMarkParam=self.config.waterMarkShowParam or{}
local waterMarkOffset=waterMarkParam.offset or{306,-225}
local waterMarkScale=waterMarkParam.scale or 1
self.waterMarkImage:setChildAnchoredPos(waterMarkOffset[1],waterMarkOffset[2])
self.waterMarkImage:setScale(Vector3.New(waterMarkScale,waterMarkScale,waterMarkScale))
end

function shareChildDiscipleInfo:refreshDiscipleInfo()
if not self.disciple_guid then
return
end

local discipleGuid=self.disciple_guid

comHelper.setChildInSideModel(self.discipleModel,discipleGuid,0.85,nil,0,0,false,false)


self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(discipleGuid))


local jobId=UIDiscipleModel:getDiscipleJob(discipleGuid)
local jobName=UIDiscipleModel:getJobName(jobId)

local jobText=FMT.fmt('︻{0}︼',jobName)
self.discipleJobText:setText(jobText)


local dzId=UIDiscipleModel:getDiscipleID(self.disciple_guid)
local stand_str=UIDiscipleModel:getJobStandStr(jobId,dzId)
local posText=FMT.fmt('︻{0}︼',stand_str)
local showSplitMark=false
if string.find(posText,"/")then
showSplitMark=true
posText=string.gsub(posText,"/","\n<size=10>\n</size>")
end

self.disciplePosText:setText(posText)


local color=UIDiscipleModel:getDiscipleColor(discipleGuid)
local color_icon=FMT.fmt('image_pinjishibie_{0}',color)
self.discipleColorIcon:setSprite(globalABLookup.global,color_icon)


self:refreshPolygonAttrPanel()



local descList=self:getDiscipleSpecialityList()
local dataNum=#descList
if dataNum>maxShowSpecialityCount then
dataNum=maxShowSpecialityCount
end
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=descList[i]
local name=cfg.name
local framecolor=cfg.framecolor
local item=gridlist[i-1]
local discipleguid=self.disciple_guid
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=discipleguid,config=cfg})
end)
end
end

end


function shareChildDiscipleInfo:refreshPolygonAttrPanel()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v

allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end

local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#efb150>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=UIDiscipleModel:getDiscipleColor(self.disciple_guid)
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
end

function shareChildDiscipleInfo:takePhoto(callback)
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

function shareChildDiscipleInfo:getDiscipleSpecialityList()
local tempList={}
local randomList={}
local downShowList={}
local descList=UIDiscipleModel:getDiscipleSpecialityConfig(self.disciple_guid)
if descList then
for i,v in ipairs(descList)do

if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eBody then
table.insert(tempList,v)
elseif v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eTalent or v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eStrange then
if v.isShowShare then
table.insert(randomList,v)
else
table.insert(downShowList,v)
end
end
end

local descCount=#tempList

local remainingCount=maxShowSpecialityCount-descCount
if remainingCount>0 then
for i=1,remainingCount do
if#tempList>=maxShowSpecialityCount then
break
end

local count=#randomList
local downCount=#downShowList
if count>0 then

local randomIndex=1
if count>1 then
randomIndex=math.random(1,count)
end
local descItem=randomList[randomIndex]
table.insert(tempList,descItem)
table.remove(randomList,randomIndex)
elseif downCount>0 then

local randomIndex=1
if downCount>1 then
randomIndex=math.random(1,downCount)
end
local descItem=downShowList[randomIndex]
table.insert(tempList,descItem)
table.remove(downShowList,randomIndex)
end
end
end
end

return tempList
end

function shareChildDiscipleInfo:onCloseBtn()
if self.closeCallback_frame then
self.closeCallback_frame()
end
if self.closeCallback then
self.closeCallback()
end
end

