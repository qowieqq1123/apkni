platformSDK_AndroidHW=simple_class()

local cjson=require'cjson'
local _temp={}


HWandroidReqType=
{

eInit='Init',

eLogin='Login',

eSwitchLogin='SwitchLogin',

eLogout='Logout',

ePay='Pay',

eReport='Report',

eReqExit='ReqExit',

eExit='Exit',

eRestart='DoRestart',

eHasPermission='HasPermission',

eRequestPermission='RequestPermission',

eListenerBattery='ListenerBattery',

eListenerNetwork='ListenNetwork',

eCopyTextToClipboard='CopyTextToClipboard',

eGetClipboardText='GetClipboardText',

ePlayAD='PlayAD',

eShareImage='ShareImage',

eSubscriptionStatus='SubscriptionStatus',

eCustomServerListener='CustomServerListener',

eShowCustomServer='ShowCustomServer',

eOpenTapTap='OpenTapView',

eOpenForumPage='OpenForumPage',

eCloseForumPage='CloseForumPage',



eGetLocalRegionName='GetLocalRegionName',

eEfunShowPlatform='efunShowPlatform',

eEfunDestoryPlatform='efunDestoryPlatform',


eVerificationLogin='VerificationLogin',


eCheckEfunBind='checkEfunBind',


ePhoneCaptcha='PhoneCaptcha',


eReqPhoneBind='reqPhoneBind',


eShowEfunOpenScan='showEfunOpenScan',


eEfunTrackEvent='efunTrackEvent',


eShowOpenWebPage='showOpenWebPage',


eCheckGooglePurchase='CheckGooglePurchase',


eConsumeGooglePurchase='ConsumeGooglePurchase',





efunRequestReviewInApp='efunRequestReviewInApp',


eEfunBindAccount="reqAccountBind",
}


HWandroidCallType=
{

eOnNetWork='onNetWork',

eOnBattery='onBattery',

eOnReqLogin='onReqLogin',

eOnLogin='onLogin',

eOnSwitchLogin='onSwitchLogin',

eOnLogout='onLogout',

eOnInit='onInit',

eOnPay='onPay',

eOnReport='onReport',

eOnExit='onExit',

eOnKeyClick='onKeyClick',

eOnRealName='onRealName',

eOnPlayAD='onPlayAD',

eOnShareImage='onShareImage',

eOnSubscriptionStatus='onSubscriptionStatus',

eOnCustomServerReddot='onCustomServerReddot',


eOnGetLocalRegionName='onGetLocalRegionName',

eOnEfunBindInfo='onEfunBindInfo',

eOnPhoneCaptcha='onPhoneCaptcha',

eOnReqPhoneBind='onReqPhoneBind',

eOnShowEfunOpenScan='onShowEfunOpenScan',

eOnBackPressed='onBackPressed',


eOnShowOpenWebPage='onShowOpenWebPage',


eOnCheckGooglePurchase='onCheckGooglePurchase',


eOnConsumeGooglePurchase='onConsumeGooglePurchase',


eOnShowSurveyView='onShowSurveyView',



eOnEfunRequestReviewInApp="onEfunRequestReviewInApp",

eOnEfunBindAccount="onEfunBindAccount",

}

HWandroidCallExType={}

local _androidCallFunc=
{
[HWandroidCallType.eOnNetWork]='onNetWorkCallBack',

[HWandroidCallType.eOnBattery]='onBatteryCallBack',

[HWandroidCallType.eOnInit]='onInitCallBack',

[HWandroidCallType.eOnReqLogin]='onReqLoginCallBack',

[HWandroidCallType.eOnLogin]='onLoginCallBack',

[HWandroidCallType.eOnSwitchLogin]='onSwtichLoginCallBack',

[HWandroidCallType.eOnLogout]='onLogoutCallBack',

[HWandroidCallType.eOnPay]='onPayCallBack',

[HWandroidCallType.eOnReport]='onReportCallBack',

[HWandroidCallType.eOnExit]='onExitCallBack',

[HWandroidCallType.eOnKeyClick]='onKeyDownClick',

[HWandroidCallType.eOnRealName]='onRealNameCallBack',

[HWandroidCallType.eOnPlayAD]='onPlayADCallBack',

[HWandroidCallType.eOnShareImage]='onShareImageCallBack',

[HWandroidCallType.eOnSubscriptionStatus]='onSubscriptionStatusCallBack',

[HWandroidCallType.eOnCustomServerReddot]='onCustomServerReddotCallBack',


[HWandroidCallType.eOnGetLocalRegionName]='onGetLocalRegionName',


[HWandroidCallType.eOnEfunBindInfo]='onEfunBindInfo',


[HWandroidCallType.eOnPhoneCaptcha]='onPhoneCaptchaCallBack',


[HWandroidCallType.eOnReqPhoneBind]='onReqPhoneBindCallBack',


[HWandroidCallType.eOnShowEfunOpenScan]='onShowEfunOpenScanCallBack',


[HWandroidCallType.eOnBackPressed]='onBackPressed',


[HWandroidCallType.eOnShowOpenWebPage]='onShowOpenWebPage',


[HWandroidCallType.eOnCheckGooglePurchase]='onCheckGooglePurchase',


[HWandroidCallType.eOnConsumeGooglePurchase]='onConsumeGooglePurchase',



[HWandroidCallType.eOnShowSurveyView]='onShowSurveyView',




[HWandroidCallType.eOnEfunRequestReviewInApp]='onEfunRequestReviewInApp',


[HWandroidCallType.eOnEfunBindAccount]='OnEfunBindAccount',
}


function platformSDK_AndroidHW:__init(...)
self.secCheckCBDict={}
_temp["battery_total"]=100
_temp['battery_current']=100
_temp['battery_percent']=100
_temp['battery_status']=-1
_temp['battery_chargePlug']=-1

self:reqListenBattery(60000)

self:reqListenNetwork()

local sdkFuncs=self.funcs or{}
local cb=function(funcName,jsonStr)
local json={}
local s=pcall(function()
json=cjson.decode(jsonStr)
end)
if not s then
json.IsSuccess=false
json.JsonStr=''
else
if json.IsSuccess=='false'then json.IsSuccess=false end
if json.IsSuccess=='true'then json.IsSuccess=true end
end
local func=_androidCallFunc[funcName]
if func and self[func]then
self:checkReport(funcName,json,jsonStr)
self[func](self,json,jsonStr)
else
platformSDK.printSDK(FMT.fmt('沒有找到回檔方法名：{0} 內容：{1}',funcName,jsonStr))
end
end
androidTool.setCallbacks(cb)
self.funcList={}
self.funcArgsList={}
end









function platformSDK_AndroidHW:reqLogin(callback)
platformSDK.printSDK('reqInit 未定義')
end


function platformSDK_AndroidHW:reqSwitchLogin()
platformSDK.printSDK('reqSwitchLogin 未定義')
end


function platformSDK_AndroidHW:reqLogout(callback)
platformSDK.printSDK('reqLogout 未定義')
end


function platformSDK_AndroidHW:reqPay(id,count,params,subscribe)
platformSDK.printSDK('reqPay 未定義')
end


function platformSDK_AndroidHW:reqReport(typo,args)
platformSDK.printSDK('reqReport 未定義')
end


function platformSDK_AndroidHW:reqQuit(callback,args)
platformSDK.printSDK('reqQuit 未定義')
end


function platformSDK_AndroidHW:reqInit(callback)
platformSDK.printSDK('reqInit 未定義')
end


function platformSDK_AndroidHW:reqPlayAD(adid,attach,callback)
platformSDK.printSDK('reqPlayAD 未定義')
end

function platformSDK_AndroidHW:reqShareUrl(url)
platformSDK.printSDK('reqShareUrl 未定義')
end

function platformSDK_AndroidHW:reqShareImage(fileName)
platformSDK.printSDK('reqShareImage 未定義')
end

function platformSDK_AndroidHW:reqReviews()
platformSDK.printSDK('reqReviews 未定義')
end

function platformSDK_AndroidHW:reqSubscriptionStatus(id)
platformSDK.printSDK('reqSubscriptionStatus 未定義')
end

function platformSDK_AndroidHW:reqCustomServerListener()
platformSDK.printSDK('reqCustomServerListener 未定義')
end

function platformSDK_AndroidHW:reqOpenCustomServer()
platformSDK.printSDK('reqOpenCustomServer 未定義')
end




function platformSDK_AndroidHW:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('onLoginCallBack 未定義')
end

function platformSDK_AndroidHW:onSwtichLoginCallBack(json,jsonStr)
platformSDK.printSDK('onSwtichLoginCallBack 未定義')
end


function platformSDK_AndroidHW:onLogoutCallBack(json,jsonStr)
platformSDK.printSDK('onLogoutCallBack 未定義')
end


function platformSDK_AndroidHW:onPayCallBack(json,jsonStr)
platformSDK.printSDK('onPayCallBack 未定義')
end


function platformSDK_AndroidHW:onReportCallBack(json,jsonStr)
platformSDK.printSDK('onReportCallBack 未定義')
end


function platformSDK_AndroidHW:onExitCallBack(json,jsonStr)
platformSDK.printSDK('onExitCallBack 未定義')
end

function platformSDK_AndroidHW:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('onKeyDownClick 未定義')
end

function platformSDK_AndroidHW:onRealNameCallBack(json,jsonStr)
platformSDK.printSDK('onRealNameCallBack 未定義')
end

function platformSDK_AndroidHW:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack 未定義')
end

function platformSDK_AndroidHW:onShareImageCallBack(json,jsonStr)
platformSDK.printSDK('onShareImageCallBack 未定義')
end

function platformSDK_AndroidHW:onSubscriptionStatusCallBack(json,jsonStr)
platformSDK.printSDK('onSubscriptionStatusCallBack 未定義')
end

function platformSDK_AndroidHW:onCustomServerReddotCallBack(json,jsonStr)
platformSDK.printSDK('onCustomServerReddotCallBack 未定義')
end





function platformSDK_AndroidHW:reqListenBattery(interval)
local ud={}
ud.interval=tostring(interval)
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(androidReqType.eListenerBattery,jsonStr)
end


function platformSDK_AndroidHW:reqListenNetwork()
androidTool.callFunc(androidReqType.eListenerNetwork,'')
end

function platformSDK_AndroidHW:getBattery()
return _temp["battery_total"],_temp['battery_current'],_temp['battery_percent'],_temp['battery_status']
end

function platformSDK_AndroidHW:getNetworkInfo()
return _temp["mobnetwork_type"],_temp["mobnetwork_level"]
end

function platformSDK_AndroidHW:reqRestart(delay)
local ud={}
ud.delay=tostring(math.floor(delay))
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(androidReqType.eRestart,jsonStr)
end

function platformSDK_AndroidHW:reqPermission(permissions,code)
local ud={}
ud.length=2
for i,v in ipairs(permissions)do
local keyStr=string.format('permission_%d',i)
ud[keyStr]=v
end
ud.code=code
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(androidReqType.eRequestPermission,jsonStr)
end

function platformSDK_AndroidHW:hasPermission(permissions)
local ud={}
ud.length=2
for i,v in ipairs(permissions)do
local keyStr=string.format('permission_%d',i)
ud[keyStr]=v
end
local jsonStr=jsonHelper.encode(ud)
local ret=androidTool.callFunc(androidReqType.eHasPermission,jsonStr)
return ret==''
end





function platformSDK_AndroidHW:onBatteryCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
local params=json.JsonStr
local batteryInfo=cjson.decode(params)
_temp["battery_total"]=tonumber(batteryInfo.total)
_temp['battery_current']=tonumber(batteryInfo.current)
_temp['battery_percent']=tonumber(batteryInfo.percent)
_temp['battery_status']=tonumber(batteryInfo.status)
_temp['battery_chargePlug']=tonumber(batteryInfo.chargePlug)
notifySystem:postNotify(notifyConfig.batteryChange)
end
end


function platformSDK_AndroidHW:onNetWorkCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
local params=json.JsonStr
local info=cjson.decode(params)

_temp['mobnetwork_type']=info.xType
_temp['mobnetwork_level']=info.level
notifySystem:postNotify(notifyConfig.networkChange)
end
end

function platformSDK_AndroidHW:onInitCallBack(json,jsonStr)
platformSDK.printSDK('onInitCallBack 未定義')
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isInit=isSuccess
end


function platformSDK_AndroidHW:checkReport(funcName,json,jsonStr)
platformSDK.printSDK('收到安卓回檔：',funcName,jsonStr)
if funcName==androidCallType.eOnLogout then
loginControl:reportLogout()
elseif funcName==androidCallType.eOnExit then
loginControl:reportExitGame()
end
end


function platformSDK_AndroidHW:addFunc(typeStr,callback)
if typeStr==nil then return end
self.funcList[typeStr]=callback
end

function platformSDK_AndroidHW:callFunc(typeStr,isClear,...)
if typeStr==nil then return end
local func=self.funcList[typeStr]
if func then
func(...)
if isClear then
self.funcList[typeStr]=nil
end
return true
end
return false
end

function platformSDK_AndroidHW:clearFunc(typeStr)
if typeStr==nil then return end
self.funcList[typeStr]=nil
end

function platformSDK_AndroidHW:addArgsFunc(typeStr,id,callback)
if typeStr==nil or id==nil then return end
if self.funcArgsList[typeStr]==nil then self.funcArgsList[typeStr]={}end
local argsList=self.funcArgsList[typeStr]
argsList[id]=callback
end


function platformSDK_AndroidHW:callArgsFunc(typeStr,id,isClear,argstable)
if typeStr==nil or id==nil then return end
local argsList=self.funcArgsList[typeStr]
if argsList then
local func=argsList[id]
if func then
if argstable then
func(unpack(argstable))
else
func()
end
if isClear then
self.funcList[typeStr]=nil
end
return true
end
end
return false
end

function platformSDK_AndroidHW:clearArgsFunc(typeStr,id)
if typeStr==nil then return end
if self.funcList[typeStr]==nil then return end
self.funcList[typeStr][id]=nil
end

function platformSDK_AndroidHW:getAppVersion()
return''
end