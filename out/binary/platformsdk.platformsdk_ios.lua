







local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString


platformSDK_iOS=simple_class()

local iOSSDKHelper=CS.IOSSDKHelper

iOSSDKCallType=
{

eLogin='login',
eLogout='logout',
eReport='report',
ePay='pay',
ePlayAD='playAD',
eReviews='reviews',
eShareImageWC='share_img_wechat',

eSDKFunc='sdkFunc',

eBatteryLevelChange='batteryLevelChange',
eBatteryStateChange='batteryStateChange',
eNetworkStateChange='networkStateChange',
eNotify='notify',
eOpenURL='open_url'
}

local _sdkCallBack=
{

[iOSSDKCallType.eLogin]='onLoginCallback',
[iOSSDKCallType.eLogout]='onLogoutCallback',
[iOSSDKCallType.ePay]='onPayCallback',
[iOSSDKCallType.ePlayAD]='onPlayADCallback',

[iOSSDKCallType.eSDKFunc]='onSDKFuncCallback',

[iOSSDKCallType.eBatteryLevelChange]='onBatteryLevelChange',
[iOSSDKCallType.eBatteryStateChange]='onBatteryStateChange',
[iOSSDKCallType.eNetworkStateChange]='onNetworkStateChange',
}


local _sdkSPFuncType=
{
_get_idfa=1,
_get_battery_level=2,
_get_battery_state=3,
_check_network=4,
_set_check_network=5,
_get_network_state=6,
_active_keyboard=7,
_set_brightness=8,
_get_brightness=9,
_exit_app=10,
_get_ipv6=11,
_set_clipboard_value=12,
_get_clipboard_value=13,
_get_imsi=14,
_system_vibrate=15,
_get_app_version=16,
}


function platformSDK_iOS:__init(...)
platformSDK.printSDK('SetSDKCallback s')
iOSSDKHelper.SetSDKCallback(function(id,ftype,success,result)
platformSDK.printSDK('SDK回调',id,ftype,success,result)
self:callCBFunc(id,ftype,success,result)
end)
platformSDK.printSDK('SetSDKCallback')

self.appVersion=''
self:callSDKSPFunc(_sdkSPFuncType._get_app_version,'')

self.networkData={ssid='',status=''}
end

function platformSDK_iOS:callCBFunc(id,ftype,success,result)
local func=self[_sdkCallBack[ftype]]
if func then
func(self,id,ftype,success,result)
end
end

function platformSDK_iOS:callSDKFunc(ftype,info)
return iOSSDKHelper.CallSDKFunc(ftype,info)
end


function platformSDK_iOS:addCallFunc(key,kName,cbName)
iOSSDKCallType[key]=kName
_sdkCallBack[kName]=cbName
end


function platformSDK_iOS:setCallbackArgs(id,args)
self.cbArgs[id]=args
end

function platformSDK_iOS:getCallbackArgs(id)
return self.cbArgs[id]
end

function platformSDK_iOS:callSDKSPFunc(sptype,info)
local data={sptype=sptype,info=info}
local jstr=jsonHelper.encode(data)
iOSSDKHelper.CallSDKFunc(iOSSDKCallType.eSDKFunc,jstr)
end

function platformSDK_iOS:my_xpcall(func,...)
xpcall(func,function(err)
end,...)
end

function platformSDK_iOS:onSDKFuncCallback(id,ftype,success,result)
self:my_xpcall(self.handleSDKFuncCallback,self,result)
end

function platformSDK_iOS:handleSDKFuncCallback(result)
local data=jsonHelper.decode(result)
local stype=data.stype
if stype==_sdkSPFuncType._get_app_version then
self.appVersion=data.info
end
end

function platformSDK_iOS:getProductId(rmb)
local pfName=loginModel:getPfname()
local pid
if pfName then
local cfg=cfgHelper.get1(cfg_iosproductidconfig_get,rmb)
pid=cfg and cfg[pfName]
end
if not pid then
pid=verifyManager:getProductId(rmb)
end
return pid or''
end

function platformSDK_iOS:getAppVersion()
return self.appVersion
end




function platformSDK_iOS:reqLogin()

end


function platformSDK_iOS:reqLogout(callback)

end


function platformSDK_iOS:reqQuit(finishCallback)

end


function platformSDK_iOS:reqRestart(delay)

end


function platformSDK_iOS:reqReport(typo)

end


function platformSDK_iOS:reqPay(id,count,params,subscribe)

end


function platformSDK_iOS:reqPlayAD(adid,attach,callback)

end

function platformSDK_iOS:reqReviews()

local appId=_AppConfig_GetString('appId','')
local data={appId=appId}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eReviews,jsonStr)
end




function platformSDK_iOS:reqShareImage(path,shareType,platform)
if path==nil then return end
local ud={}
ud.path=path
ud.shareType=shareType
ud.platform=platform
local jsonStr=jsonHelper.encode(ud)
jsonStr=string.gsub(jsonStr,"\\/","/")
self:callSDKFunc(iOSSDKCallType.eShareImageWC,jsonStr)
platformSDK.printSDK('req_shareImage platformSDK_iOS')
end


function platformSDK_iOS:reqInit()

end

function platformSDK_iOS:getBattery()
return 100,100,100;
end

function platformSDK_iOS:getNetworkInfo(callback)
if callback then
callback(self.networkData.ssid,0)
end
end



function platformSDK_iOS:onBatteryLevelChange(id,ftype,success,result)

end

function platformSDK_iOS:onBatteryStateChange(id,ftype,success,result)

end

function platformSDK_iOS:onNetworkStateChange(id,ftype,success,result)
if success then
self.networkData=jsonHelper.decode(result)
end
end




function platformSDK_iOS:onKeyDownCallBack(keycode)
platformHelper:onKeyDownClick(keycode)
end