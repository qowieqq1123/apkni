









shareImageModel={}


shareImageModel.data={}

SHARE_IMAGE_TYPE={
eRandomImage=1,
eDisciple=2,
eZongMenPhoto=3,
}

function shareImageModel:onAppStart()

end


function shareImageModel:onEnterState(isReconnect)

end


function shareImageModel:onProtocolReq()

end


function shareImageModel:onLeaveState(isReconnect)

self.data={}
end

function shareImageModel:initImageQRCode()

local pfId=loginModel:getPfid()or 0


local channelId=loginModel:getChannelID()or 0
if channelId==""then
channelId=nil
end


local qrCodeImageCfgList=cfg_shareimageqrcodeconfig()

local defaultChannelQRImgName

for i,v in ipairs(qrCodeImageCfgList)do
if v.platformId==pfId then
if v.channelId==channelId then
self.data.QRCodeImageName=v.imageName
self.data.QRCodeInit=true
return
elseif v.channelId==nil then
defaultChannelQRImgName=v.imageName
end
end
end


if defaultChannelQRImgName then
self.data.QRCodeImageName=defaultChannelQRImgName
self.data.QRCodeInit=true
end
end

function shareImageModel:getQRCodeImageName()
if not self.data.QRCodeInit then
self:initImageQRCode()
end
return self.data.QRCodeImageName
end

function shareImageModel:getQRCodeImageAbName(imageName)
return FMT.fmt("ui/windows/shareimage/sharedtextures/qrcodeimage/{0}.ab",imageName)
end

function shareImageModel:getRandomImageAbName(imageName)
return FMT.fmt("ui/windows/shareimage/sharedtextures/background/{0}.ab",imageName)
end


function shareImageModel:setShareRewardAllGotNum(num)
if not self.data.shareRewardData then
self.data.shareRewardData={}
end
self.data.shareRewardData.allGotNum=num
end


function shareImageModel:setShareRewardGotNumList(list)
if not self.data.shareRewardData then
self.data.shareRewardData={}
end
if not self.data.shareRewardData.gotNumList_lookup then
self.data.shareRewardData.gotNumList_lookup={}
end
if list then
for i,v in pairs(list)do
local shareType=v.param_1
local gotNum=v.param_2
self.data.shareRewardData.gotNumList_lookup[shareType]=gotNum
end
end
end


function shareImageModel:setShareRewardGotNumByType(shareType,num)
if not self.data.shareRewardData then
self.data.shareRewardData={}
end
if not self.data.shareRewardData.gotNumList_lookup then
self.data.shareRewardData.gotNumList_lookup={}
end

self.data.shareRewardData.gotNumList_lookup[shareType]=num
end


function shareImageModel:clearShareRewardGotNumByType()
self.data.shareRewardData=nil
end


function shareImageModel:getShareRewardCanGetNumByType(shareType)
local shareCfg=cfgHelper.get(cfg_yaoqingmadailyconfig_get,shareType)or{}
if not shareCfg then
return 0
end
local maxGetNum=shareCfg.maxNum or 0
if not self.data.shareRewardData or not self.data.shareRewardData.gotNumList_lookup then

return maxGetNum
end
local gotNum=self.data.shareRewardData.gotNumList_lookup[shareType]or 0
local canGetNum=maxGetNum-gotNum
return canGetNum
end


function shareImageModel:getShareTypeByWinName(winName)
local winCfgList=cfg_shareimagerewardwintypeconfig()
for i,v in ipairs(winCfgList)do
if v.winName==winName then
local shareShowType=v.shareShowType
local showCfg=cfgHelper.get1(cfg_shareimagebaseconfig_get,shareShowType)
if showCfg then
return showCfg.shareType
end
end
end
end


function shareImageModel:getShareShowTypeByWinName(winName)
local winCfgList=cfg_shareimagerewardwintypeconfig()
for i,v in ipairs(winCfgList)do
if v.winName==winName then
return v.shareShowType
end
end
end


function shareImageModel:IsShareDzBtnCanShow(color)
local isOpen=shareImageModel:isOpenShareImage()
if not isOpen then
return false
end

local minColor=cfgHelper.getdef1(cfg_shareimagebaseconfig,'dzShowBtnColor')
local showShareBtn=isOpen and minColor and color>=minColor or false
return showShareBtn
end

function shareImageModel:isOpenShareImage()
if systemModel.isOpen(SYSTEM_DEFINE.eDailyShare)then
local isHouTaiOpen,isShowErrTips=houtaiModel:isOpenShareImage()
return isHouTaiOpen
end
return false
end

function shareImageModel:checkOpenShareImageShowErrTips()
local errStr="当前版本无法分享，请前往应用商店更新"
local isHouTaiOpen,isShowErrTips=houtaiModel:isOpenShareImage()
return isShowErrTips,errStr
end


function shareImageModel:test_openShareImage()
if not houtaiModel.phpData then
houtaiModel.phpData={}
end

if not houtaiModel.phpData[HOUTAI_TYPE.eShareImage]then
houtaiModel.phpData[HOUTAI_TYPE.eShareImage]={}
end

houtaiModel.phpData[HOUTAI_TYPE.eShareImage]["is_open"]="1"
end


