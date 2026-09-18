platformSDK_Android=simple_class()

local cjson=require'cjson'
local _temp={}


androidReqType=
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

eUploadChatMsg='UploadChatMsg',

eOpenCommunity='OpenCommunity',
}


androidCallType=
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
}

androidCallExType={}

local _androidCallFunc=
{
[androidCallType.eOnNetWork]='onNetWorkCallBack',

[androidCallType.eOnBattery]='onBatteryCallBack',

[androidCallType.eOnInit]='onInitCallBack',

[androidCallType.eOnReqLogin]='onReqLoginCallBack',

[androidCallType.eOnLogin]='onLoginCallBack',

[androidCallType.eOnSwitchLogin]='onSwtichLoginCallBack',

[androidCallType.eOnLogout]='onLogoutCallBack',

[androidCallType.eOnPay]='onPayCallBack',

[androidCallType.eOnReport]='onReportCallBack',

[androidCallType.eOnExit]='onExitCallBack',

[androidCallType.eOnKeyClick]='onKeyDownClick',

[androidCallType.eOnRealName]='onRealNameCallBack',

[androidCallType.eOnPlayAD]='onPlayADCallBack',

[androidCallType.eOnShareImage]='onShareImageCallBack',

[androidCallType.eOnSubscriptionStatus]='onSubscriptionStatusCallBack',

[androidCallType.eOnCustomServerReddot]='onCustomServerReddotCallBack',
}


function platformSDK_Android:__init(...)
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
platformSDK.printSDK(FMT.fmt('没有找到回调方法名：{0} 内容：{1}',funcName,jsonStr))
end
end
androidTool.setCallbacks(cb)
self.funcList={}
self.funcArgsList={}
end





function platformSDK_Android:reqLogin(callback)
platformSDK.printSDK('reqInit 未定义')
end


function platformSDK_Android:reqSwitchLogin()
platformSDK.printSDK('reqSwitchLogin 未定义')
end


function platformSDK_Android:reqLogout(callback)
platformSDK.printSDK('reqLogout 未定义')
end


function platformSDK_Android:reqPay(id,count,params,subscribe)
platformSDK.printSDK('reqPay 未定义')
end


function platformSDK_Android:reqReport(typo,args)
platformSDK.printSDK('reqReport 未定义')
end


function platformSDK_Android:reqQuit(callback,args)
platformSDK.printSDK('reqQuit 未定义')
end


function platformSDK_Android:reqInit(callback)
platformSDK.printSDK('reqInit 未定义')
end


function platformSDK_Android:reqPlayAD(adid,attach,callback)
platformSDK.printSDK('reqPlayAD 未定义')
end

function platformSDK_Android:reqShareUrl(url)
platformSDK.printSDK('reqShareUrl 未定义')
end

function platformSDK_Android:reqShareImage(fileName)
platformSDK.printSDK('reqShareImage 未定义')
end

function platformSDK_Android:reqReviews()
platformSDK.printSDK('reqReviews 未定义')
end

function platformSDK_Android:reqSubscriptionStatus(id)
platformSDK.printSDK('reqSubscriptionStatus 未定义')
end

function platformSDK_Android:reqCustomServerListener()
platformSDK.printSDK('reqCustomServerListener 未定义')
end

function platformSDK_Android:reqOpenCustomServer()
platformSDK.printSDK('reqOpenCustomServer 未定义')
end




function platformSDK_Android:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('onLoginCallBack 未定义')
end

function platformSDK_Android:onSwtichLoginCallBack(json,jsonStr)
platformSDK.printSDK('onSwtichLoginCallBack 未定义')
end


function platformSDK_Android:onLogoutCallBack(json,jsonStr)
platformSDK.printSDK('onLogoutCallBack 未定义')
end


function platformSDK_Android:onPayCallBack(json,jsonStr)
platformSDK.printSDK('onPayCallBack 未定义')
end


function platformSDK_Android:onReportCallBack(json,jsonStr)
platformSDK.printSDK('onReportCallBack 未定义')
end


function platformSDK_Android:onExitCallBack(json,jsonStr)
platformSDK.printSDK('onExitCallBack 未定义')
end

function platformSDK_Android:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('onKeyDownClick 未定义')
end

function platformSDK_Android:onRealNameCallBack(json,jsonStr)
platformSDK.printSDK('onRealNameCallBack 未定义')
end

function platformSDK_Android:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack 未定义')
end

function platformSDK_Android:onShareImageCallBack(json,jsonStr)
platformSDK.printSDK('onShareImageCallBack 未定义')
end

function platformSDK_Android:onSubscriptionStatusCallBack(json,jsonStr)
platformSDK.printSDK('onSubscriptionStatusCallBack 未定义')
end

function platformSDK_Android:onCustomServerReddotCallBack(json,jsonStr)
platformSDK.printSDK('onCustomServerReddotCallBack 未定义')
end





function platformSDK_Android:reqListenBattery(interval)
local ud={}
ud.interval=tostring(interval)
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(androidReqType.eListenerBattery,jsonStr)
end


function platformSDK_Android:reqListenNetwork()
androidTool.callFunc(androidReqType.eListenerNetwork,'')
end

function platformSDK_Android:getBattery()
return _temp["battery_total"],_temp['battery_current'],_temp['battery_percent'],_temp['battery_status']
end

function platformSDK_Android:getNetworkInfo()
return _temp["mobnetwork_type"],_temp["mobnetwork_level"]
end

function platformSDK_Android:reqRestart(delay)
local ud={}
ud.delay=tostring(math.floor(delay))
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(androidReqType.eRestart,jsonStr)
end

function platformSDK_Android:reqPermission(permissions,code)
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

function platformSDK_Android:hasPermission(permissions)
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





function platformSDK_Android:onBatteryCallBack(json,jsonStr)
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


function platformSDK_Android:onNetWorkCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
local params=json.JsonStr
local info=cjson.decode(params)

_temp['mobnetwork_type']=info.xType
_temp['mobnetwork_level']=info.level
notifySystem:postNotify(notifyConfig.networkChange)
end
end

function platformSDK_Android:onInitCallBack(json,jsonStr)
platformSDK.printSDK('onInitCallBack 未定义')
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isInit=isSuccess
end


function platformSDK_Android:checkReport(funcName,json,jsonStr)
platformSDK.printSDK('收到安卓回调：',funcName,jsonStr)
if funcName==androidCallType.eOnLogout then
loginControl:reportLogout()
elseif funcName==androidCallType.eOnExit then
loginControl:reportExitGame()
end
end


function platformSDK_Android:addFunc(typeStr,callback)
if typeStr==nil then return end
self.funcList[typeStr]=callback
end

function platformSDK_Android:callFunc(typeStr,isClear,...)
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

function platformSDK_Android:clearFunc(typeStr)
if typeStr==nil then return end
self.funcList[typeStr]=nil
end

function platformSDK_Android:addArgsFunc(typeStr,id,callback)
if typeStr==nil or id==nil then return end
if self.funcArgsList[typeStr]==nil then self.funcArgsList[typeStr]={}end
local argsList=self.funcArgsList[typeStr]
argsList[id]=callback
end


function platformSDK_Android:callArgsFunc(typeStr,id,isClear,argstable)
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

function platformSDK_Android:clearArgsFunc(typeStr,id)
if typeStr==nil then return end
if self.funcList[typeStr]==nil then return end
self.funcList[typeStr][id]=nil
end

function platformSDK_Android:getAppVersion()
return''
end