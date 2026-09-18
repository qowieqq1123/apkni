
resolutionUtility={}







resolutionUtility.enableMinAspect=true
resolutionUtility.curMinAspect=16/9

local landscapeRecord

function _setWeiXinSafeArea(val,val2,val3)
local so
if webGLHelper:isRunDouYin()then
local lv
if not landscapeRecord or(val3>=-105 and val3<=-75)then
lv=3
elseif not landscapeRecord or(val3>=75 and val3<=105)then
lv=4
end
if not lv or lv==landscapeRecord then
return
end
landscapeRecord=lv
so=lv
else
so=val=='landscapeReverse'and 4 or 3
end

_WXInterface.SetScreenOrientation(so)


local sysInfo=webGLHelper:getSystemInfoSync(true)

local safeArea=sysInfo.safeArea
local dpr=webGLHelper:getDPR()
if sysInfo.platform==webGLMGPlatform.ios then
local left=safeArea.left*dpr
if left>0 then
local offset=cfgHelper.getglobal('SafeAreaOffset')
CS.UIManager.SetSafeAreaOffset(offset[2]/sysInfo.pixelRatio*dpr)
end

CS.GameInterface.SetCustomArea(true,left,0,sysInfo.screenWidth*dpr-left,sysInfo.screenHeight*dpr)
else

local left=sysInfo.screenWidth-safeArea.width
if webGLHelper:isRunDouYin()then
if sysInfo.platform==webGLMGPlatform.devtools then
left=math.max(safeArea.left,safeArea.top)
end
end
left=left*dpr
CS.GameInterface.SetCustomArea(true,left,0,safeArea.width*dpr,safeArea.height*dpr)
end
end

function resolutionUtility.checkForbidenSafeDevice()
if webGLHelper:isRunMiniGame()then

_WXInterface.SetKeepScreenOn(true,nil,nil)


if webGLHelper:isRunDouYin()then
_setWeiXinSafeArea(0,0,0)
elseif webGLHelper:isRunWeiXin()then
local info=webGLHelper:getBaseInfo()
_setWeiXinSafeArea(info.deviceOrientation)
else
return
end

_WXInterface.OnDeviceOrientationChange(_setWeiXinSafeArea)
else
local forbidenSafeAreaDevice=require'data/config/forbidenSafeAreaDeviceCfg'
local fitDevice=CS.GameInterface.GetDeviceModel()
if forbidenSafeAreaDevice~=nil then
for i,v in ipairs(forbidenSafeAreaDevice)do
if v.deviceModel==fitDevice then
CS.AppDataModel.SetOption("option.CSGUI.CSGUIWindowBase.ForbidApplySafeArea",true)
break
end
end
end
end
end


function resolutionUtility.init()
local apilevel=deviceHelper.getAPILevel()
if apilevel>=48 and resolutionUtility.enableMinAspect then
resolutionUtility.curMinAspect=16/9
CS.AppDataModel.SetOption("option.CameraAdaptation.EnableAdaptation",false)
CS.AppDataModel.SetOption("option.LockViewAnchors.EnableMinAspect",true)
end
if webGLHelper:isRunWebGL()then
if webGLHelper:isRunDouYin()then

if webGLHelper:getPlatformName()~=webGLMGPlatform.android then
webGLHelper:setDPI(0.5)
end
elseif webGLHelper:isRunWeiXin()
or webGLHelper:isRunMeiTuan()
or webGLHelper:isRunAlipayMiniGame()
or webGLHelper:isRunKuaiShouMiniGame()then

webGLHelper:setDPI(0.5)
end

CS.UIManager.SetSafeAreaOffset(0)
end
resolutionUtility.checkForbidenSafeDevice()

if deviceHelper.isRunIOS()and api_Available_SetScreenOrientation()then
CS.GameInterface.SetScreenOrientation(5)
end
end

function resolutionUtility:showTopMaskWin()
UIManager:showWindow("UITopMaskWin")
end

function resolutionUtility:hideTopMaskWin()
UIManager:hideWindow("UITopMaskWin")
end

