







def_class("shareChildRandomPicture",UICloneObject)





shareChildRandomPicture.abName="ui/windows/shareimage/child/sharechildrandompicture.ab"

shareChildRandomPicture.assetName="shareChildRandomPicture"


function shareChildRandomPicture:bindComponents()

self.uiRoot=UIObject.get(self,0)
self.whiteBack=UIObject.get(self,1)
self.picture=UIImage.get(self,2)
self.photoKuang=UIObject.get(self,3)
self.rawImage=UIObject.get(self,4)
self.leftDown=UIObject.get(self,5)
self.day=UIImage.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.photo=UIObject.get(self,8)
self.headIcon=UIObject.get(self,9)
self.qrCodeImage=UIImage.get(self,10)
self.invitationCodeTx=UIText.get(self,11)
self.playerNameTx=UIText.get(self,12)
self.enterDay=UIObject.get(self,13)
self.waterMarkImage=UIObject.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

end


function shareChildRandomPicture:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.whiteBack);self.whiteBack=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.day);self.day=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.invitationCodeTx);self.invitationCodeTx=nil;
_UIObject_release(self.playerNameTx);self.playerNameTx=nil;
_UIObject_release(self.enterDay);self.enterDay=nil;
_UIObject_release(self.waterMarkImage);self.waterMarkImage=nil;
end





local _this




function shareChildRandomPicture:onLoaded(...)
_this=self
self:bindComponents()
end


function shareChildRandomPicture:__delete()
_this=nil
self:unbindComponents()
end




function shareChildRandomPicture:onShow(argtable,afterOnloaded)




local cfgId=argtable.cfgId
self.isZHM=argtable.zhm
self.config=cfgHelper.get(cfg_shareimagebaseconfig_get,cfgId)
self.closeCallback=argtable.closeCallback
self.closeCallback_frame=argtable.closeCallback_frame
local cameraGO=mainControl:getUICamera()
self.cameraTF=cameraGO.transform

self.randomImageSaveData=nil
self.nowShowImage=nil
self.randomImageDataDateKey=nil

self:refreshPlayerInfo()
self:refreshQRCode()
self:refreshRandomImageShow()
self:refreshWaterMarkImage()
end


function shareChildRandomPicture:onHide()

end

function shareChildRandomPicture:refreshPlayerInfo()
self:refreshInvitationCode()
playerController:setHeadIcon(self.widget,self.headIcon:getID(),{stopHeadKuangAnim=true})

local playerName=playerModel:getActorName()
self.playerNameTx:setText(FMT.fmt("祖师名：{0}",playerName))
end

function shareChildRandomPicture:refreshInvitationCode()
local isShowReturnCode=false
if self.isZHM then
local selfReturnCode_int_64=welfareModel:getSelfReturnCode()
local isOpen=welfareModel:checkXianYouZhaoHuiOpen()
isShowReturnCode=isOpen and selfReturnCode_int_64~=nil and not mathHelper.compareInt64(selfReturnCode_int_64,int64.new('0'))
self.invitationCodeTx:setActive(isShowReturnCode)
if isShowReturnCode then
local zhm_const_def=cfg_zhaohuimaconfig().const_def
local returnCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfReturnCode_int_64),INVITATION_CODE_MIN_POS_COUNT,zhm_const_def.turnStr)
self.invitationCodeTx:setText(FMT.fmt("回归码：<color=#ECAF51>{0}</color>",returnCode))
end
end
if not isShowReturnCode then
local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
local isOpen=welfareModel:isOpenYaoQingMa()
local isShowInvitationCode=isOpen and selfInvitationCode_int_64~=nil and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))
self.invitationCodeTx:setActive(isShowInvitationCode)
if isShowInvitationCode then
local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeTx:setText(FMT.fmt("邀请码：<color=#ECAF51>{0}</color>",invitationCode))
end
end
end

function shareChildRandomPicture:refreshQRCode()
local _QRCodeImage=shareImageModel:getQRCodeImageName()
if _QRCodeImage then
local _QRCodeAb=shareImageModel:getQRCodeImageAbName(_QRCodeImage)
self.qrCodeImage:setSprite(_QRCodeAb,_QRCodeImage)
self.qrCodeImage:setActive(true)
else
self.qrCodeImage:setActive(false)
end
end

function shareChildRandomPicture:refreshWaterMarkImage()

local waterMarkParam=self.config.waterMarkShowParam or{}
local waterMarkOffset=waterMarkParam.offset or{306,-225}
local waterMarkScale=waterMarkParam.scale or 1
self.waterMarkImage:setChildAnchoredPos(waterMarkOffset[1],waterMarkOffset[2])
self.waterMarkImage:setScale(Vector3.New(waterMarkScale,waterMarkScale,waterMarkScale))
end

function shareChildRandomPicture:refreshRandomImageShow()

local randomImageList,allWeight=self:getRandomImageList()

local selectImage
local imageCount=0
if randomImageList and next(randomImageList)then
imageCount=#randomImageList
if imageCount==1 then
selectImage={imageName=randomImageList[1].imageName,weight=allWeight}
UIManager:invokeUIMethod("UIShareImageFrameWin","refreshChangeBgBtn",true)
else

local randomWeight
local useWeight=allWeight
if self.nowShowImage then
useWeight=allWeight-self.nowShowImage.weight
end

randomWeight=math.random(1,useWeight)
for i,v in ipairs(randomImageList)do
if not self.nowShowImage or v.imageName~=self.nowShowImage.imageName then
randomWeight=randomWeight-v.weight
if randomWeight<=0 then
selectImage={imageName=v.imageName,weight=v.weight}
break
end
end
end
end
end

if selectImage then
self.nowShowImage=selectImage
local abName=shareImageModel:getRandomImageAbName(selectImage.imageName)
self.picture:setSprite(abName,selectImage.imageName)
end

if self.config.isShowEnterDay then
local openDay=timeHelper.getServerOpenDay()
local showEnterDay=openDay>=1 and openDay<=7
if showEnterDay then
local abName="ui/windows/welfare/welfare_xianyuanshare_atlas_pak.ab"
local dayImageName=FMT.fmt("image_fenxiangtpccts_{0}",openDay)
self.day:setSprite(abName,dayImageName)
end
self.enterDay:setActive(showEnterDay)
end
end

function shareChildRandomPicture:getRandomImageList()
local randomLib=self.config.bgImageLib or{}
if#randomLib==1 then
local imageId=randomLib[1]
local iamgeCfg=cfgHelper.get1(cfg_shareimagebglistconfig_get,imageId)
local allWeight=iamgeCfg.baseWeight
local randomList={{imageName=iamgeCfg.imageName,weight=allWeight}}
return randomList,allWeight
end


local year,month,day=timeHelper.getServerData()
year=tonumber(year)
month=tonumber(month)
day=tonumber(day)
local dataDateKey=year*1000+month*100+day

local lunarDate_year,lunarDate_month,lunarDate_day,isLeapMonth
if api_Available_ToChineseCalendar()then
lunarDate_year,lunarDate_month,lunarDate_day,isLeapMonth=timeHelper.getChineseCalendarDateByDate(year,month,day)
end

local randomList={}
local allWeight=0
if self.randomImageSaveData and self.randomImageDataDateKey==dataDateKey then
randomList=self.randomImageSaveData.randomList
allWeight=self.randomImageSaveData.allWeight
else

local openDay=timeHelper.getServerOpenDay()
for i,imageId in ipairs(randomLib)do
local imageCfg=cfgHelper.get1(cfg_shareimagebglistconfig_get,imageId)
local weight=imageCfg.baseWeight
local imageName=imageCfg.imageName
if imageCfg.specialWeightParam then
local specialWeightParamList=imageCfg.specialWeightParam
for _,specialWeightParam in ipairs(specialWeightParamList)do
local specialType=specialWeightParam.type
local specialWeight=specialWeightParam.weight
local isSpecial=false
if specialType==1 then

local dateList=specialWeightParam.param
for _,dateParam in ipairs(dateList)do
local startDateStr=dateParam[1]
local endDateStr=dateParam[2]
local startDate=string.split(startDateStr,'-')
local endDate=string.split(endDateStr,'-')
local stareDate_month=tonumber(startDate[1])
local stareDate_day=tonumber(startDate[2])
local endDate_month=tonumber(endDate[1])
local endDate_day=tonumber(endDate[2])

if month>=stareDate_month and month<=endDate_month then
if day>=stareDate_day and day<=endDate_day then
isSpecial=true
break
end
end
end
elseif specialType==2 then

if not api_Available_ToChineseCalendar()then
break
end
local dateList=specialWeightParam.param
local isIncludeLeapMonth=dateList.isIncludeLeapMonth or false
if isIncludeLeapMonth or not isLeapMonth then
for _,dateParam in ipairs(dateList)do
local startDateStr=dateParam[1]
local endDateStr=dateParam[2]
local startDate=string.split(startDateStr,'-')
local endDate=string.split(endDateStr,'-')
local stareDate_month=tonumber(startDate[1])
local stareDate_day=tonumber(startDate[2])
local endDate_month=tonumber(endDate[1])
local endDate_day=tonumber(endDate[2])

if month>=stareDate_month and month<=endDate_month then
if day>=stareDate_day and day<=endDate_day then
isSpecial=true
break
end
end
end
end
elseif specialType==3 then

local dayList=specialWeightParam.param
for _,dayParam in ipairs(dayList)do
local minDay=dayParam[1]
local maxDay=dayParam[2]
if openDay>=minDay and openDay<=maxDay then
isSpecial=true
break
end
end
end

if isSpecial then
weight=specialWeight
break
end
end
end

if weight>0 then
table.insert(randomList,{imageName=imageName,weight=weight})
allWeight=allWeight+weight
end
end

self.randomImageSaveData={randomList=randomList,allWeight=allWeight}
self.randomImageDataDateKey=dataDateKey
end

return randomList,allWeight
end

function shareChildRandomPicture:takePhoto(callback)
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

function shareChildRandomPicture:changeBg(callback)
self:refreshRandomImageShow()

if callback then
return callback()
end
end

function shareChildRandomPicture:onCloseBtn()
if self.closeCallback_frame then
self.closeCallback_frame()
end
if self.closeCallback then
self.closeCallback()
end
end

