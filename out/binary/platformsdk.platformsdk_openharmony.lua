platformSDK_OpenHarmony=simple_class()

local cjson=require'cjson'
local _temp={}
local _HMSHelper=CS.HMSHelper


HarmonyReqType=
{

eInit='Init',

eLogin='Login',



eLogout='Logout',

ePay='Pay',

eReport='Report',

eReqExit='ReqExit',

eExit='Exit',

eRestart='DoRestart',


eBindingAccountState='BindingAccountState',


eBindingAccount='bindingAccount',


eUnBindingAccount='unbindingAccount',


eSubscriptionStatus='SubscriptionStatus',


eGetPhoneBingdingState='getPhoneBindingState',


ePlayAD='PlayAD',


eShareImage='ShareImage',
}


HarmonyCallType=
{

eOnLogin='onLogin',



eOnLogout='onLogout',

eOnInit='onInit',

eOnPay='onPay',

eOnReport='onReport',

eOnExit='onExit',


eOnKeyClick='onKeyClick',


eOnScreenChange='onScreenChange',


eOnUnBindingAccount='onUnBindingAccount',


eOnSubscriptionStatus='onSubscriptionStatus',


eOnBindingAccount="onBindingAccount",


eOnBindingAccountState='onBindingAccountState',


eOnGetPhoneBindingState='onGetPhoneBindingState',


eOnPlayAD='onPlayAD',


eOnShareImage='onShareImage',
}

local _HarmonyCallFunc=
{

[HarmonyCallType.eOnInit]='onInitCallBack',

[HarmonyCallType.eOnLogin]='onLoginCallBack',



[HarmonyCallType.eOnLogout]='onLogoutCallBack',

[HarmonyCallType.eOnPay]='onPayCallBack',

[HarmonyCallType.eOnReport]='onReportCallBack',

[HarmonyCallType.eOnExit]='onExitCallBack',

[HarmonyCallType.eOnKeyClick]='onKeyDownClick',

[HarmonyCallType.eOnScreenChange]='onScreenChangeCallBack',


[HarmonyCallType.eOnUnBindingAccount]='onUnBindingAccount',


[HarmonyCallType.eOnBindingAccount]='onBindingAccountCallBack',


[HarmonyCallType.eOnBindingAccountState]='onBindingAccountState',


[HarmonyCallType.eOnSubscriptionStatus]='onSubscriptionStatusCallBack',


[HarmonyCallType.eOnGetPhoneBindingState]='onGetPhoneBindingStateCallBack',


[HarmonyCallType.eOnPlayAD]='onPlayADCallBack',


[androidCallType.eOnShareImage]='onShareImageCallBack',
}


function platformSDK_OpenHarmony:__init(...)

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
local func=_HarmonyCallFunc[funcName]
platformSDK.printSDK('没有找到回调方法：',funcName,jsonStr)
if func and self[func]then
self:checkReport(funcName,json,jsonStr)
self[func](self,json,jsonStr)
else
platformSDK.printSDK('没有找到回调方法：',funcName,jsonStr)
end
end
_HMSHelper.SetCallbacks(cb)
self.funcList={}
self.funcArgsList={}
end





function platformSDK_OpenHarmony:reqLogin(callback)
platformSDK.printSDK('reqInit 未定义')
end


function platformSDK_OpenHarmony:reqSwitchLogin()

end


function platformSDK_OpenHarmony:reqLogout(callback)

end


function platformSDK_OpenHarmony:reqPay(id,count,params,subscribe)
platformSDK.printSDK('reqPay 未定义')
end


function platformSDK_OpenHarmony:reqReport(typo,args)
platformSDK.printSDK('reqReport 未定义')
end


function platformSDK_OpenHarmony:reqQuit(callback,args)
platformSDK.printSDK('reqQuit 未定义')
end


function platformSDK_OpenHarmony:reqInit(callback)
platformSDK.printSDK('reqInit 未定义')
end


function platformSDK_OpenHarmony:reqPlayAD(adid,attach,callback)

end

function platformSDK_OpenHarmony:reqShareUrl(url)

end

function platformSDK_OpenHarmony:reqShareImage(fileName)

end




function platformSDK_OpenHarmony:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('onLoginCallBack 未定义')
end

function platformSDK_OpenHarmony:onSwtichLoginCallBack(json,jsonStr)

end


function platformSDK_OpenHarmony:onLogoutCallBack(json,jsonStr)

end


function platformSDK_OpenHarmony:onPayCallBack(json,jsonStr)
platformSDK.printSDK('onPayCallBack 未定义')
end


function platformSDK_OpenHarmony:onReportCallBack(json,jsonStr)
platformSDK.printSDK('onReportCallBack 未定义')
end


function platformSDK_OpenHarmony:onExitCallBack(json,jsonStr)
platformSDK.printSDK('onExitCallBack 未定义')
end

function platformSDK_OpenHarmony:onKeyDownClick(json,jsonStr)

end

function platformSDK_OpenHarmony:onRealNameCallBack(json,jsonStr)

end

function platformSDK_OpenHarmony:onPlayADCallBack(json,jsonStr)

end

function platformSDK_OpenHarmony:onScreenChangeCallBack(json,jsonStr)

end

function platformSDK_OpenHarmony:onBindingAccount(json,jsonStr)

end

















function platformSDK_OpenHarmony:getBattery()

end

function platformSDK_OpenHarmony:getNetworkInfo()

end

function platformSDK_OpenHarmony:reqRestart(delay)
local ud={}
ud.delay=tostring(math.floor(delay))
local jsonStr=jsonHelper.encode(ud)
_HMSHelper.ExecCmd(HarmonyReqType.eRestart,jsonStr)
end

function platformSDK_OpenHarmony:reqPermission(permissions,code)









end

function platformSDK_OpenHarmony:hasPermission(permissions)









return true
end





function platformSDK_OpenHarmony:onBatteryCallBack(json,jsonStr)











end


function platformSDK_OpenHarmony:onNetWorkCallBack(json,jsonStr)









end

function platformSDK_OpenHarmony:onInitCallBack(json,jsonStr)
platformSDK.printSDK('onInitCallBack 未定义')
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isInit=isSuccess
end


function platformSDK_OpenHarmony:checkReport(funcName,json,jsonStr)
platformSDK.printSDK('收到安卓回调：',funcName,jsonStr)
if funcName==HarmonyCallType.eOnLogout then
loginControl:reportLogout()
elseif funcName==HarmonyCallType.eOnExit then
loginControl:reportExitGame()
end
end


function platformSDK_OpenHarmony:addFunc(typeStr,callback)
if typeStr==nil then return end
self.funcList[typeStr]=callback
end

function platformSDK_OpenHarmony:callFunc(typeStr,isClear,...)
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

function platformSDK_OpenHarmony:clearFunc(typeStr)
if typeStr==nil then return end
self.funcList[typeStr]=nil
end

function platformSDK_OpenHarmony:addArgsFunc(typeStr,id,callback)
if typeStr==nil or id==nil then return end
if self.funcArgsList[typeStr]==nil then self.funcArgsList[typeStr]={}end
local argsList=self.funcArgsList[typeStr]
argsList[id]=callback
end


function platformSDK_OpenHarmony:callArgsFunc(typeStr,id,isClear,argstable)
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

function platformSDK_OpenHarmony:clearArgsFunc(typeStr,id)
if typeStr==nil then return end
if self.funcList[typeStr]==nil then return end
self.funcList[typeStr][id]=nil
end

function platformSDK_OpenHarmony:callHMFunc(funcName,args)
args=args or''
return _HMSHelper.ExecCmd(funcName,args)
end

function platformSDK_OpenHarmony:getAppVersion()
return''
end