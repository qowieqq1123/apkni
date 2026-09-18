deviceHelper={}

local _GetRuntimePlatformStr=CS.GameInterface.GetRuntimePlatformStr
local _GetIMEI=CS.GameInterface.GetIMEI
local _GetSystemVersion=CS.GameInterface.GetSystemVersion
local _GetDeviceBrand=CS.GameInterface.GetDeviceBrand
local _GetSystemModel=CS.GameInterface.GetSystemModel
local _GetIPAddress=CS.NetworkHelper.GetIPAddress
local _GetOpenAppCount=CS.AppDataModel.GetOpenAppCount
local _API_LEVEL_NUM=CS.AppDataModel.API_LEVEL_NUM
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _GetVersionJsonByKey=CS.AppDataModel.GetVersionJsonByKey
local _SetVersionJsonByKey=CS.AppDataModel.SetVersionJsonByKey

local _SimIMEI='sim_imei'
local _SimIMEI_Random='sim_imei_rand'
local __simIMEI=nil
local _platformSDK
local _platformType


local miniGamePFCheckType={
weixin='weixin',
meituan='meituan',
douyin='douyin',
huawei_webgl='huawei_webgl',
alipay='alipay',
kuaishou='kuaishou',
Bzhan='Bzhan'
}


local mgNativePFCheckType={
douyin_native='douyin_native'
}


local __runtimePlatformStr=_GetRuntimePlatformStr()


function deviceHelper.getSimIMEI()
if __simIMEI==nil then
local simIMEI=_GetVersionJsonByKey(_SimIMEI,0)
local simIMEI_Random=_GetVersionJsonByKey(_SimIMEI_Random,0)
if simIMEI==0 then
simIMEI=os.time()
simIMEI_Random=math.random(100000,999999)
_SetVersionJsonByKey(_SimIMEI,simIMEI)
_SetVersionJsonByKey(_SimIMEI_Random,simIMEI_Random)
end
__simIMEI=tostring(simIMEI)..tostring(simIMEI_Random)
end
return __simIMEI
end



function deviceHelper.getIMEI()
return deviceHelper.getSimIMEI()
end


function deviceHelper.getRuntimePlatformStr()
local platform=__runtimePlatformStr








return platform
end


function deviceHelper.getSystemVersion()
if deviceHelper.isRunNoneOrEditor()then
return''
else
return _GetSystemVersion()
end
end


function deviceHelper.getDeviceBrand()
if deviceHelper.isRunNoneOrEditor()then
return''
else
return _GetDeviceBrand()
end
end


function deviceHelper.getSystemModel()
if deviceHelper.isRunNoneOrEditor()then
return''
else
return _GetSystemModel()
end
end


function deviceHelper.getUserAddress(ipv)
return _GetIPAddress(ipv or 0)
end


function deviceHelper.getOpenAppCount()
return _GetOpenAppCount()
end


function deviceHelper.getRuntimePlatformTag()
if deviceHelper.isRunAndroid()then
return 1
elseif deviceHelper.isRunIOS()then
return 2
elseif deviceHelper.isRunWebGL()then
return 1
elseif deviceHelper.isRunOpenHarmony()then
return 1
else
return 1
end
end

function deviceHelper.getMCC()
if deviceHelper.isRunAndroid()then
return''
end
end

function deviceHelper.getMNC()
if deviceHelper.isRunAndroid()then
return''
end
end

function deviceHelper.getNetworkCode()
if deviceHelper.isRunIOS()then
return""
elseif deviceHelper.isRunAndroid()then
return''
end
end

function deviceHelper.getNetworkType()
if deviceHelper.isRunIOS()then
return""
elseif deviceHelper.isRunAndroid()then
return''
end
return''
end


function deviceHelper.getAPILevel()
return _API_LEVEL_NUM
end

function deviceHelper.setAPILevel(num)
_API_LEVEL_NUM=num
end

function deviceHelper.isRunNonePlatform()
return deviceHelper.getAppPlatform()=='platformSDK_None'
end

function deviceHelper.isRunNoneOrEditor()
return deviceHelper.isRunNonePlatform()or deviceHelper.isRunEditor()
end

function deviceHelper.isRunNoneNotEditor()
return deviceHelper.isRunNonePlatform()and not deviceHelper.isRunEditor()
end

function deviceHelper.isRunEditor()
local name=deviceHelper.getRuntimePlatformStr()
return name=='WindowsEditor'or name=='OSXEditor'
end

function deviceHelper.isRunInPlatform()
return deviceHelper.isRunAndroid()or deviceHelper.isRunIOS()or deviceHelper.isRunWebGL()or deviceHelper.isRunOpenHarmony()or deviceHelper.isRunPC()or deviceHelper.isRunUWP()
end

function deviceHelper.isRunSDK()
return not deviceHelper.isRunNoneOrEditor()and deviceHelper.isRunInPlatform()
end

function deviceHelper.isRunAndroid()
return deviceHelper.getRuntimePlatformStr()=='Android'
end

function deviceHelper.isRunWebGL()
local pf=deviceHelper.getRuntimePlatformStr()
local check=pf=='WebGLPlayer'or pf=='WeixinMiniGamePlayer'
return check
end

function deviceHelper.isRunWebGLOnly()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft=='webgl'
end

function deviceHelper.isRunWeiXin()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.weixin
end

function deviceHelper.isRunMeiTuan()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.meituan
end

function deviceHelper.isRunDouYin()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.douyin
end


function deviceHelper.isRunDouYinNative()
if not deviceHelper.isRunAndroid()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==mgNativePFCheckType.douyin_native
end

function deviceHelper.isRunHuaWeiMiniGame()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.huawei_webgl
end

function deviceHelper.isRunAlipayMiniGame()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.alipay
end

function deviceHelper.isRunKuaiShouMiniGame()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.kuaishou
end

function deviceHelper.isRunBzhan()
if not deviceHelper.isRunWebGL()then
return false
end
local pft=deviceHelper.getAppPlatformType()
return pft==miniGamePFCheckType.Bzhan
end

function deviceHelper.isRunMiniGame()
if not deviceHelper.isRunWebGL()then
return false
end






local pft=deviceHelper.getAppPlatformType()
local ret=miniGamePFCheckType[pft]~=nil or mgNativePFCheckType[pft]~=nil
return ret
end

function deviceHelper.isRunMGNative()
if not deviceHelper.isRunAndroid()then
return false
end

local pft=deviceHelper.getAppPlatformType()
local ret=mgNativePFCheckType[pft]~=nil
return ret
end

function deviceHelper.isRunIOS()
local name=deviceHelper.getRuntimePlatformStr()
return name=='IPhonePlayer'or name=='OSXPlayer'
end

function deviceHelper.isRunOpenHarmony()
local name=deviceHelper.getRuntimePlatformStr()
return name=='OpenHarmony'
end



function deviceHelper.isRunPC()
local name=deviceHelper.getRuntimePlatformStr()
return name=='WindowsPlayer'
end


function deviceHelper.isRunUWP()
local pfname=deviceHelper.getAppPlatform()
if pfname=="platformSDK_UWP"then
return true
else
return false
end
end



function deviceHelper.getAppPlatform()
if _platformSDK~=nil then return _platformSDK end
_platformSDK=_AppConfig_GetString('platformSDK','platformSDK_None')
return _platformSDK
end

function deviceHelper.getAppPlatformType()
if _platformType~=nil then return _platformType end
_platformType=_AppConfig_GetString('platformType','None')
return _platformType
end


function deviceHelper.getAppName()
return _AppConfig_GetString('APPName','');
end


function deviceHelper.vibrate()
if deviceHelper.isRunIOS()then

elseif deviceHelper.isRunAndroid()then

end
end

function deviceHelper.tapticNotification(typo)
if deviceHelper.isRunIOS()then

end
end

function deviceHelper.tapticImpact(typo)
if deviceHelper.isRunIOS()then

end
end
