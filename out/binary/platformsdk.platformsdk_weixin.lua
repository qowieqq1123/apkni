








platformSDK_WeiXin=simple_class()

local webGLSDKHelper=CS.WebGLSDKHelper

webGLSDKCallType=
{
eInit='init',
eLogin='login',
eLogout='logout',
eReport='report',
ePay='pay',
ePlayAD='play_ad',
eShare='share',
eOnShare='on_share',
eGetShareConfig='get_share_config',
eCustomerService='open_customer_service',
eMsgSecCheck='msg_sec_check',
eCallSDKAPI='call_api',
eCallSDKAPISync='call_api_sync',
}

local _sdkCallBack=
{
[webGLSDKCallType.eInit]='onInitCallback',
[webGLSDKCallType.eLogin]='onLoginCallback',
[webGLSDKCallType.eLogout]='onLogoutCallback',
[webGLSDKCallType.eReport]='onReportCallback',
[webGLSDKCallType.ePay]='onPayCallback',
[webGLSDKCallType.ePlayAD]='onPlayADCallback',
[webGLSDKCallType.eShare]='onShareCallback',
[webGLSDKCallType.eOnShare]='onListenShareCallback',
[webGLSDKCallType.eGetShareConfig]='onShareConfigCallback',
[webGLSDKCallType.eMsgSecCheck]='onMsgSecCheck',
[webGLSDKCallType.eCallSDKAPI]='onCallSDKAPICallback',
}


function platformSDK_WeiXin:__init(...)
self.cbArgs={}
webGLSDKHelper.SetSDKCallback(function(id,ftype,success,result)
platformSDK.printSDK('SDK回调',id,ftype,success,result)
self:callCBFunc(id,ftype,success,result)
end)
end

function platformSDK_WeiXin:callCBFunc(id,ftype,success,result)
local func=self[_sdkCallBack[ftype]]
if func then
func(self,id,ftype,success,result)
end
end

function platformSDK_WeiXin:callSDKFunc(ftype,info)
local id=webGLSDKHelper.CallSDKFunc(ftype,info)
platformSDK.printSDK('SDK调用',id,ftype,info)
return id
end

function platformSDK_WeiXin:callSDKFuncSync(ftype,info)
platformSDK.printSDK('SDK同步调用',ftype,info)
return webGLSDKHelper.CallSDKFuncSync(ftype,info)
end


function platformSDK_WeiXin:addCallFunc(key,kName,cbName)
webGLSDKCallType[key]=kName
_sdkCallBack[kName]=cbName
end


function platformSDK_WeiXin:setCallbackArgs(id,args)
self.cbArgs[id]=args
end

function platformSDK_WeiXin:getCallbackArgs(id,blank)
local args=self.cbArgs[id]
if blank then
self.cbArgs[id]=nil
end
return args
end

function platformSDK_WeiXin:callSDKAPI(name,param,callback)
local data=
{
name=name,
param=param
}
local paramJson=jsonHelper.encode(data)
local id=self:callSDKFunc(webGLSDKCallType.eCallSDKAPI,paramJson)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_WeiXin:onCallSDKAPICallback(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(id,success,result)
end
end

function platformSDK_WeiXin:callSDKAPISync(name,param)
local data=
{
name=name,
param=param
}
local paramJson=jsonHelper.encode(data)
local res=self:callSDKFuncSync(webGLSDKCallType.eCallSDKAPISync,paramJson)
return res
end




function platformSDK_WeiXin:reqLogin()

end


function platformSDK_WeiXin:reqLogout(callback)

end


function platformSDK_WeiXin:reqQuit(finishCallback)

end


function platformSDK_WeiXin:reqRestart(delay)

end


function platformSDK_WeiXin:reqReport(typo)

end


function platformSDK_WeiXin:reqPay(id,count,params,subscribe)

end


function platformSDK_WeiXin:reqPlayAD(adid,attach,callback)

end


function platformSDK_WeiXin:reqInit()

end

function platformSDK_WeiXin:getBattery()
return 100,100,100;
end

function platformSDK_WeiXin:getNetworkInfo(callback)
if callback then
_WXInterface.GetNetworkType(function(success,proxy,type,strength,error)
callback(type,strength)
end)
end
end

function platformSDK_WeiXin:getAppVersion()
return''
end

function platformSDK_WeiXin:reqReviews()





end




function platformSDK_WeiXin:reqShareImage(path,shareType,platform)

end



function platformSDK_WeiXin:onKeyDownCallBack(keycode)
platformHelper:onKeyDownClick(keycode)
end