appUtils={}

local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _GetVersionJsonByKey=CS.AppDataModel.GetVersionJsonByKey
local _SetVersionJsonByKey=CS.AppDataModel.SetVersionJsonByKey
local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest

appUtils.enableDebug=appConfigHelper.getBool('log.enableFileLog',false)

appUtils.enableErrDebug=appConfigHelper.getBool('log.enableErrFileLog',false)

appUtils.showErrLog=appConfigHelper.getBool('uploadFileLog',false)

appUtils.onlySaveLog=appConfigHelper.getBool('onlySaveLog',false)

appUtils.showMemory=appConfigHelper.getBool('showMemory',false)

appUtils.testPHP=appConfigHelper.getBool('testPHP',false)

appUtils.showActivityInfo=appConfigHelper.getBool('showActivityInfo',true)

appUtils.enableProfiler=CS.AppDataModel.GetOptionBool('option.LuaConst.enableProfiler')
appUtils.debugXianJie=appConfigHelper.getBool('enableDebugXianJie',false)

local _SimIMEI='sim_imei'
local _SimIMEI_Random='sim_imei_rand'
local __simIMEI=nil

local _SDKIMEI=''

function appUtils.init()
appUtils.isPublicVersion=api_Available_ChildRawImageLoader()
end


function appUtils.getSimIMEI()
if deviceHelper.getSimIMEI then
return deviceHelper.getSimIMEI()
end

deviceHelper.getSimIMEI=function()
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
return deviceHelper.getSimIMEI()
end


function appUtils.setAPILevel(level)
if deviceHelper.setAPILevel then
deviceHelper.setAPILevel(level)
end
if APILEVE~=nil then
APILEVE.setAPILevel(level)
end
CS.AppDataModel.API_LEVEL_NUM=level
end

local customAPILevel=appConfigHelper.getInt('testBuildinAPILevel',-1)
if customAPILevel~=-1 then
appUtils.setAPILevel(customAPILevel)
end

function appUtils.setSDKIMEI(imei)
if _SDKIMEI~=''and _SDKIMEI~=imei then
loggerUtil.logErrFMT('SDK返回唯一识别码前后不一致 old：{0} new:{1}',_SDKIMEI,imei)
end
loggerUtil.logFMT('设置SDKIMEI:{0}',imei)
_SDKIMEI=imei
end

function appUtils.getSDKIMEI()
return _SDKIMEI
end


































































































