local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _proxy=CS.AndroidSDKProxy
local _ExecCmd=_proxy.ExecCmd
local _IOSSDKHelper=CS.IOSSDKHelper
local cjson=require'cjson'
local _log=Debugger.Log
local _t_concat=table.concat
local cjson=require'cjson'

platformLogPoint={}



function platformLogPoint.otherPFLogPoint(logType)
local platform_name=deviceHelper.getAppPlatform()

local EventCfg=platformLogConfig.pfOtherEventName[platform_name]
platformLogPoint.PFLogPoint(EventCfg,platform_name,logType)

EventCfg=platformLogConfig.pfEventName[platform_name]
platformLogPoint.PFLogPoint(EventCfg,platform_name,logType)
end

function platformLogPoint.PFLogPoint(EventCfg,platform_name,logType)
if EventCfg and EventCfg[logType]then
local EventCode=EventCfg[logType]
if deviceHelper.isRunAndroid()then
local EventCodeData={}
EventCodeData.EventCode=EventCode
local jsonStr=cjson.encode(EventCodeData)
_ExecCmd('pfPointLog',jsonStr)
logPoint.printPoint("platformLogPoint.otherPFLogPoint"..logType..jsonStr)
elseif deviceHelper.isRunIOS()then
local data={}
data.eventName=EventCode
data.key=EventCode
data.value=1
local info=cjson.encode(data)
if platform_name=="platformSDK_iOS_FeiFang"then
_IOSSDKHelper.CallSDKFunc("event",info)
else
_IOSSDKHelper.CallSDKFunc("performanceranalysis",info)
end
end
end
end


function platformLogPoint.efunTrackEventPoint(eventName)
platformSDK:reqEfunTrackEvent(eventName)
end