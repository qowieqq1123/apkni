







def_class("UIShareImageWin",UIWindowBase)









function UIShareImageWin:bindComponents()

self.RawImage=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.photoKuang=UIObject.get(self,2)
self.photo=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.shareButton=UIButton.get(self,5)
self.saveButton=UIButton.get(self,6)
self.photoRoot=UIObject.get(self,7)
self.mask=UIButton.get(self,8)
self.leftDown=UIObject.get(self,9)
self.imageQRCode=UIImage.get(self,10)
self.headIconCreater=UIObject.get(self,11)
self.invitationCodeText=UIText.get(self,12)
self.playerName=UIText.get(self,13)
self.tipsTitle=UIText.get(self,14)
self.tipsText=UIText.get(self,15)
self.photoBg=UIImage.get(self,16)
self.playerInfo=UIObject.get(self,17)
self.waterMarkImage=UIObject.get(self,18)
self.changeBgBtn=UIButton.get(self,19)
self.discipleRoot=UIObject.get(self,20)
self.discipleModel=UIObject.get(self,21)
self.discipleNameText=UIText.get(self,22)
self.discipleColorIcon=UIImage.get(self,23)
self.discipleJobText=UIText.get(self,24)
self.disciplePosText=UIText.get(self,25)
self.discipleTipsImage=UIImage.get(self,26)
self.discipleTipsText=UIText.get(self,27)
self.skillsGroup=UIObject.get(self,28)
self.showInfoToggle=UIToggleButton.get(self,29)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.shareButton:setButtonClick(function()self:onShareButton()end)

self.saveButton:setButtonClick(function()self:onSaveButton()end)

self.mask:setButtonClick(function()self:onMask()end)

self.changeBgBtn:setButtonClick(function()self:onChangeBgBtn()end)


self.sprite_image_taptaplogo_4=0

end


function UIShareImageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.RawImage);self.RawImage=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.photoKuang);self.photoKuang=nil;
_UIObject_release(self.photo);self.photo=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.shareButton);self.shareButton=nil;
_UIObject_release(self.saveButton);self.saveButton=nil;
_UIObject_release(self.photoRoot);self.photoRoot=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.leftDown);self.leftDown=nil;
_UIObject_release(self.imageQRCode);self.imageQRCode=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.invitationCodeText);self.invitationCodeText=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.tipsTitle);self.tipsTitle=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.photoBg);self.photoBg=nil;
_UIObject_release(self.playerInfo);self.playerInfo=nil;
_UIObject_release(self.waterMarkImage);self.waterMarkImage=nil;
_UIObject_release(self.changeBgBtn);self.changeBgBtn=nil;
_UIObject_release(self.discipleRoot);self.discipleRoot=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleColorIcon);self.discipleColorIcon=nil;
_UIObject_release(self.discipleJobText);self.discipleJobText=nil;
_UIObject_release(self.disciplePosText);self.disciplePosText=nil;
_UIObject_release(self.discipleTipsImage);self.discipleTipsImage=nil;
_UIObject_release(self.discipleTipsText);self.discipleTipsText=nil;
_UIObject_release(self.skillsGroup);self.skillsGroup=nil;
_UIObject_release(self.showInfoToggle);self.showInfoToggle=nil;
end
















local writablePath=CS.GamePath.writablePath..'/'..'photo/'
local _this




function UIShareImageWin:onLoaded(...)
_this=self
self:bindComponents()
self.isToggle=userActorSetting.get('showShareImageSelfInfo',true)
self.showInfoToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isToggle)
end


function UIShareImageWin:__delete()
self:unbindComponents()
_this=nil
end




function UIShareImageWin:onShow(argtable,afterOnloaded)
self.shareImageType=argtable and argtable.shareImageType or 1
self.shareImageParam=argtable and argtable.param or{}
self.shareShowCfg=cfgHelper.get1(cfg_shareimagebaseconfig_get,self.shareImageType)
local cameraGO=mainControl:getUICamera()
self.cameraTF=cameraGO.transform
self.isFinishInit=false
self:initPlayerInfo()
self:refreshPhotoRoot()
self:refreshUIRoot()
self:delayDo(0.5,function()
self.isFinishInit=true
end)
end


function UIShareImageWin:onHide()

end

function UIShareImageWin:initPlayerInfo()
local isShowInfoToggle=self.shareShowCfg.isShowInfoToggle or false
if isShowInfoToggle then
self.playerInfo:setChildCanvasGroupAlpha(self.isToggle and 1 or 0)
else
self.playerInfo:setChildCanvasGroupAlpha(1)
end

local qrCodeImageName=shareImageModel:getQRCodeImageName()
local qrCodeImageAbName=shareImageModel:getQRCodeImageAbName(qrCodeImageName)
self.imageQRCode:setSprite(qrCodeImageAbName,qrCodeImageName)


local playerName=playerModel:getActorName()
self.playerName:setText(FMT.fmt("祖师名：{0}",playerName))


playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{scale=0.6,stopHeadKuangAnim=true})

local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
local isOpen=welfareModel:isOpenYaoQingMa()
local isShowInvitationCode=isOpen and selfInvitationCode_int_64~=nil and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))
if isShowInvitationCode then

local invitationCode=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
self.invitationCodeText:setText(FMT.fmt("邀请码：<color=#FFFF00>{0}</color>",invitationCode))
end
self.invitationCodeText:setActive(isShowInvitationCode)

local tipsTitleStr=self.shareShowCfg.tipsTitleStr
if tipsTitleStr then
self.tipsTitle:setText(tipsTitleStr)
self.tipsTitle:setActive(true)
else
self.tipsTitle:setActive(false)
end


local tipsTextStr=self.shareShowCfg.tipsTextStr
if tipsTextStr then
self.tipsText:setText(tipsTextStr)
self.tipsText:setActive(true)
else
self.tipsText:setActive(false)
end
end

function UIShareImageWin:refreshPhotoRoot()
local isShowBg=self.shareShowCfg.bgImageLib~=nil and next(self.shareShowCfg.bgImageLib)~=nil
self.photoBg:setActive(isShowBg)
if isShowBg then
self:refreshRandomImageShow()
end

local isShowDz=self.shareShowCfg.isShowDz or false
self.discipleRoot:setActive(isShowDz)
if isShowDz then
self:refreshDiscipleShow()
end


local waterMarkParam=self.shareShowCfg.waterMarkShowParam or{}
local waterMarkOffset=waterMarkParam.offset or{360,250}
local waterMarkScale=waterMarkParam.scale or 1
self.waterMarkImage:setChildAnchoredPos(waterMarkOffset[1],waterMarkOffset[2])
self.waterMarkImage:setScale(Vector3.New(waterMarkScale,waterMarkScale,waterMarkScale))
end

function UIShareImageWin:refreshUIRoot()
local isShowChangeBtn=self.shareShowCfg.isShowChangeBtn or false
self.changeBgBtn:setActive(isShowChangeBtn)

local isShowInfoToggle=self.shareShowCfg.isShowInfoToggle or false
self.showInfoToggle:setActive(isShowInfoToggle)
end

function UIShareImageWin:refreshRandomImageShow()

local randomImageList,allWeight=self:getRandomImageList()

local selectImage
local imageCount=0
if randomImageList and next(randomImageList)then
imageCount=#randomImageList
if imageCount==1 then
selectImage={imageName=randomImageList[1].imageName,weight=allWeight}
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
self.photoBg:setSprite(abName,selectImage.imageName)
end
self.changeBgBtn:setActive(imageCount>1)
end

function UIShareImageWin:getRandomImageList()
local randomLib=self.shareShowCfg.bgImageLib or{}
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

for i,imageId in ipairs(randomLib)do
local imageCfg=cfgHelper.get1(cfg_shareimagebglistconfig_get,imageId)
local weight=imageCfg.baseWeight
local imageName=imageCfg.imageName
if imageCfg.specialWeightParam then
local specialType=imageCfg.specialWeightParam.type
local specialWeight=imageCfg.specialWeightParam.weight
local isSpecial=false
if specialType==1 then

local dateList=imageCfg.specialWeightParam.param
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
local dateList=imageCfg.specialWeightParam.param
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
end

if isSpecial then
weight=specialWeight
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

function UIShareImageWin:refreshDiscipleShow()
local discipleGuid=self.shareImageParam.disciple_guid
if discipleGuid then

comHelper.setChildInSideModel(self.discipleModel,discipleGuid,0.85,nil,0,0,false,false)


self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(discipleGuid))


local jobId=UIDiscipleModel:getDiscipleJob(discipleGuid)
local jobName=UIDiscipleModel:getJobName(jobId)

self.discipleJobText:setText(jobName)


local dzId=UIDiscipleModel:getDiscipleID(self.disciple_guid)
local stand_str=UIDiscipleModel:getJobStandStr(jobId,dzId)
local posText=FMT.fmt('推荐{0}',stand_str)
self.disciplePosText:setText(posText)


local color=UIDiscipleModel:getDiscipleColor(discipleGuid)
local color_icon=FMT.fmt('image_pinjishibie_{0}',color)
self.discipleColorIcon:setSprite(globalABLookup.global,color_icon)


local netData=UIDiscipleModel:getDiscipleData(discipleGuid)
local skillList=UIDiscipleModel:getDiscipleJobSkillList(discipleGuid)
local grids=self.skillsGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local sdata=skillList[i]
if sdata then
item:SetChildActive(-1,true)
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local icon=skillModel.getSkillIconChange(skillCfg,netData)
item:SetChildIcon(0,iconHelper.getSkillIcon(icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
else
item:SetChildActive(-1,false)
end
end




















end
end

function UIShareImageWin:takePhoto(callback)
if not self.isFinishInit then
UIManager.error("点击过快 请稍后再试")
return
end

local finishCallback=function()
if _this==nil then return end

_this.photoRoot:setChildCanvasEx('UITop',2000)
_this.widget:CroppingTexture(_this.photo:getID(),_this.cameraTF,_this.leftDown:getID())
if callback then
return callback()
end
end
self.photoRoot:setActive(true)
self.photo:setActive(false)

self.photoRoot:setChildCanvasEx('UISystemTip',2900)
self.widget:EnableCaptureScreen(self.RawImage:getID(),self.cameraTF,true,0,0,1,finishCallback)
end


function UIShareImageWin:freshToggle(isToggle)
self.showInfoToggle:setToggle(isToggle)
local isOpen=shareImageModel:isOpenShareImage()

local isShow=isOpen and isToggle
self.playerInfo:setChildCanvasGroupAlpha(isShow and 1 or 0)
self.showInfoToggle:setActive(isOpen)
end

function UIShareImageWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle
userActorSetting.flushVal('showShareImageSelfInfo',isToggle)
self:freshToggle(isToggle)
end




function UIShareImageWin:onCloseBtn()
self:closeSelf()
end



function UIShareImageWin:onShareButton()

local shareType=self.shareShowCfg.shareType
if self.shareImageParam.callback~=nil then
self.shareImageParam.callback(shareType)
else
shareImageController:reqGetShareImageReward(shareType)
end
end



function UIShareImageWin:onSaveButton()
local callback=function()
local name=FMT.fmt('shareImage{0}.png',os.date('%m%d%H%M%S'))
self.fileName=FMT.fmt("{0}{1}",writablePath,name)
self.widget:SaveTextue(self.photo:getID(),self.fileName)

UIManager.info("保存成功")
end
self:takePhoto(callback)
end

function UIShareImageWin:onMask()
self:onCloseBtn()
end

function UIShareImageWin:onChangeBgBtn()

self.isFinishInit=false
self:refreshPhotoRoot()
self:delayDo(0.5,function()
self.isFinishInit=true
end)
end

function UIShareImageWin.test_reshow()
_this:onShow()
end


function UIShareImageWin.test_RawImage()
local rawImageCmp=_this.RawImage:getCommonComponent('RawImage')
if rawImageCmp.texture==nil then
UIManager.info("暂无图片")
end
end

