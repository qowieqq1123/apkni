platformSDK_OpenHarmony_XingJia=simple_class(platformSDK_OpenHarmony)
local cjson=require'cjson'
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _writablePath=CS.GamePath.writablePath



function platformSDK_OpenHarmony_XingJia:reqInit()
local typeStr=HarmonyReqType.eInit
self:callHMFunc(typeStr,'')
end


function platformSDK_OpenHarmony_XingJia:reqLogin(callback)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
local typeStr=HarmonyReqType.eLogin
self:addFunc(typeStr,callback)
self:callHMFunc(typeStr)
end


function platformSDK_OpenHarmony_XingJia:reqSwitchLogin()


end


function platformSDK_OpenHarmony_XingJia:reqLogout(callback)
local typeStr=HarmonyReqType.eLogout
self:addFunc(typeStr,callback)
self:callHMFunc(typeStr)
end


function platformSDK_OpenHarmony_XingJia:reqQuit(callback,args)
local typeStr=HarmonyReqType.eReqExit
self:addFunc(typeStr,callback)
self:callHMFunc(typeStr,args)
end


function platformSDK_OpenHarmony_XingJia:reqReport(typo,info)
local typeStr=HarmonyReqType.eReport
local playerInfo=platformHelper:getPlayerInfo()
info=platformHelper.concat(info,playerInfo)
info.json_type=sdkReportStr[typo]
local jsonStr=jsonHelper.encode(info)
self:callHMFunc(typeStr,jsonStr)
end


function platformSDK_OpenHarmony_XingJia:reqPay(id,count,params,subscribe)
local typeStr=HarmonyReqType.ePay

local info=platformHelper:getPlayerInfo()
local attach=platformHelper.getPayAttach(id,params)

local cfg=cfg_rechargeconfig_get(id)
local payUrl=gameInfo:getParams('paymentURL')or''
if payUrl==''then
loggerUtil.logErrFMT('当前平台：{0}没有下发paymentURL参数',loginModel:getPfid())
return
end
info.json_tradeId=platformHelper.getTradeId(id)
info.json_rmb=cfg.rmb
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
info.json_count=count
info.json_attach=attach
info.json_test=0
info.json_url=payUrl
info.subscribe=subscribe or false

local jsonStr=jsonHelper.encode(info)
loggerUtil.logFMT('鸿蒙支付请求：{0}',jsonStr)
self:callHMFunc(typeStr,jsonStr)
end


function platformSDK_OpenHarmony_XingJia:reqPhoneBingdingState()
local typeStr=HarmonyReqType.eGetPhoneBingdingState
self:callHMFunc(typeStr)
end


function platformSDK_OpenHarmony_XingJia:reqBingdingAccount()
local typeStr=HarmonyReqType.eBindingAccount
self:callHMFunc(typeStr)
end


function platformSDK_OpenHarmony_XingJia:reqBingdingAccountState()
local typeStr=HarmonyReqType.eBindingAccountState
self:callHMFunc(typeStr)
end


function platformSDK_OpenHarmony_XingJia:reqUnBingdingAccount()
local typeStr=HarmonyReqType.eUnBindingAccount
self:callHMFunc(typeStr)
end


function platformSDK_OpenHarmony_XingJia:reqSubscriptionStatus(id)
platformSDK.printSDK('reqSubscriptionStatus platformSDK_Android_XingJia')
local typeStr=HarmonyReqType.eSubscriptionStatus
local info=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
local jsonStr=jsonHelper.encode(info)
self:callHMFunc(typeStr,jsonStr)
end


function platformSDK_OpenHarmony_XingJia:reqPlayAD(adid,attach,callback)
local typeStr=HarmonyReqType.ePlayAD
local info=platformHelper:getPlayerInfo()
info.json_adid=adid
info.json_ext=attach
local jsonStr=jsonHelper.encode(info)
self:addArgsFunc(typeStr,attach,callback)
self:callHMFunc(typeStr,jsonStr)
end




function platformSDK_OpenHarmony_XingJia:reqShareImage(path,shareType,platform)
if path==nil then return end
local ud={}
ud.path=path
ud.shareType=shareType
ud.platform=platform
local jsonStr=jsonHelper.encode(ud)
jsonStr=string.gsub(jsonStr,"\\/","/")
local typeStr=HarmonyReqType.eShareImage
self:callHMFunc(typeStr,jsonStr)
platformSDK.printSDK('req_shareImage platformSDK_Android_XingJia')
end





function platformSDK_OpenHarmony_XingJia:onInitCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isInit=isSuccess
if not isSuccess then
self.isReqLogin=nil
end
end







function platformSDK_OpenHarmony_XingJia:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack platformSDK_OpenHarmony_XingJia,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isReqLogin=nil
if isSuccess then
local info=cjson.decode(params)

local phpParams={}
phpParams.uid=info.uid
phpParams.sign=info.token




if loginModel.isLogin and info.username==loginModel.username then
loginModel:onfreshLoginInfo(info,phpParams,info.uid)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_OpenHarmony_XingJia')
else
loginModel:onLogin(info,phpParams,info.uid)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_OpenHarmony_XingJia')
self:callFunc(HarmonyReqType.eLogin)
end
end
self:clearFunc(HarmonyReqType.eLogin)
end


function platformSDK_OpenHarmony_XingJia:onSwtichLoginCallBack(json,jsonStr)
platformSDK.printSDK('SwtichLoginCallBack platformSDK_OpenHarmony_XingJia,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
self.isReqLogin=nil
if isSuccess then
loginModel.isLogin=false
local win=UIManager:findActiveWindow("UILogin")
if win then

else
if not self:callFunc(HarmonyReqType.eLogout,true)then
loginState:logout()
end
end
end
self:clearFunc(HarmonyReqType.eLogin)
self:callFunc(HarmonyReqType.eLogout)
end


function platformSDK_OpenHarmony_XingJia:onLogoutCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isReqLogin=nil
if isSuccess then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
if not self:callFunc(HarmonyReqType.eLogout)then
loginState:logout()
end
end
end
self:clearFunc(HarmonyReqType.eLogout)
platformSDK.printSDK('LogoutCallBack platformSDK_OpenHarmony_XingJia,param=%s,isShowLoginWindow=%s',tostring(jsonStr))
end



function platformSDK_OpenHarmony_XingJia:onPayCallBack(json,jsonStr)
platformSDK.printSDK(string.format('PayCallBack platformSDK_OpenHarmony_XingJia,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then

platformSDK.printSDK('支付成功')
else
platformSDK.printSDK('支付失败 返回信息=%s',tostring(jsonStr))
shushuReportHelper.Report_byEventName(shushuReportEventName.zqzs_pay_fail)
end
end


function platformSDK_OpenHarmony_XingJia:onReportCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
platformSDK.printSDK('reportCallBack platformSDK_OpenHarmony_XingJia 成功')
else
platformSDK.printSDK(string.format('reportCallBack platformSDK_OpenHarmony_XingJia 失败：%s',jsonStr))
end
end


function platformSDK_OpenHarmony_XingJia:onExitCallBack(json,jsonStr)
platformSDK.printSDK(string.format('ExitCallBack platformSDK_OpenHarmony_XingJia,param=%s',tostring(jsonStr)))
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
self:callHMFunc(HarmonyReqType.eExit,jsonStr)
end




function platformSDK_OpenHarmony_XingJia:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('OnKeyDown_NativeClick platformSDK_OpenHarmony_XingJia,num',json.JsonStr)
local hasExit=json.IsSuccess
local keycode='None'
if tonumber(json.JsonStr)==4 then
keycode='Escape'
if hasExit then
local data=platformHelper:getPlayerInfo()
local infoStr=jsonHelper.encode(data)
self:reqQuit(nil,infoStr)
return
end
end
platformHelper:onKeyDownClick(keycode)
end

function platformSDK_OpenHarmony_XingJia:onRealNameCallBack(json,jsonStr)

end


function platformSDK_OpenHarmony_XingJia:onShareImageCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onShareImageCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
platformSDK.printSDK('ShareImage开始分享')
else
platformSDK.printSDK(string.format('ShareImage 分享失败=%s',tostring(jsonStr)))
end
end


function platformSDK_OpenHarmony_XingJia:onSubscriptionStatusCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onSubscriptionStatusCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local id=tonumber(info.productId)
local status=info.status
payControl:setSubscriptionStatus(id,status)
end
end

local phoneBindingState=false
local AccountBingState=false

function platformSDK_OpenHarmony_XingJia:onUnBindingAccount(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
UIManager.info("解绑成功")
else
UIManager.info("解绑失败")
end
AccountBingState=not isSuccess
UIManager:invokeUIMethod("UIPlayerInfoWin","freshShowAccountBindBtn",AccountBingState)
platformSDK.printSDK('unbindingAccount',isSuccess)
end


function platformSDK_OpenHarmony_XingJia:onBindingAccountState(json,jsonStr)
local isSuccess=json.IsSuccess
AccountBingState=isSuccess
UIManager:invokeUIMethod("UIPlayerInfoWin","freshShowAccountBindBtn",AccountBingState)
end


function platformSDK_OpenHarmony_XingJia:onBindingAccountCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
UIManager.info("绑定成功")
else
UIManager.info("绑定失败")
end
phoneBindingState=not isSuccess
UIManager:invokeUIMethod("UIPlayerInfoWin","freshShowPhoneBindBtn",phoneBindingState)
end





function platformSDK_OpenHarmony_XingJia:onGetPhoneBindingStateCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
phoneBindingState=not isSuccess
UIManager:invokeUIMethod("UIPlayerInfoWin","freshShowPhoneBindBtn",phoneBindingState)
end



function platformSDK_OpenHarmony_XingJia:onScreenChangeCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
platformSDK.printSDK('onScreenChange platformSDK_OpenHarmony_XingJia',json.JsonStr)
if isSuccess then
self.DeviceScreenInfo={}
local info=cjson.decode(params)
self.DeviceScreenInfo.width=info.width
self.DeviceScreenInfo.height=info.height
self.DeviceScreenInfo.rotation=info.rotation
if api_Available_ChangeScreen()then
CS.GameInterface.ChangeScreen(info.width,info.height,info.rotation,true)
end
end
end







local _adType=
{
eErr=0,
eClick=1,
eShow=2,
eSkipped=3,
eComplete=4,
eReward=5,
eClose=6,
}


local handleAdErr=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
self:callArgsFunc(androidReqType.ePlayAD,attach,true,{false,info})
loggerUtil.logFMT('广告播放失败!adid:{0}',adid)
end

local handleAdClick=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('点击广告!adid:{0}',adid))
end

local handleAdShow=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('播放广告!adid:{0}',adid))
end

local handleAdSkiped=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
self:callArgsFunc(androidReqType.ePlayAD,attach,true,{true,info})
loggerUtil.log(FMT.fmt('跳过广告!adid:{0}',adid))
end

local handleAdComplete=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
self:callArgsFunc(androidReqType.ePlayAD,attach,true,{true,info})
loggerUtil.log(FMT.fmt('完成广告!adid:{0}',adid))
end

local handleAdRewarded=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach

self:callArgsFunc(androidReqType.ePlayAD,attach,true,{true,info})

loggerUtil.log(FMT.fmt('领取广告奖励!adid:{0}',adid))
end

local handleAdClose=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('关闭广告!adid:{0}',adid))
end

local _adfunc=
{
[_adType.eErr]=function(...)
handleAdErr(...)
end,
[_adType.eClick]=function(...)
handleAdClick(...)
end,
[_adType.eShow]=function(...)
handleAdShow(...)
end,
[_adType.eSkipped]=function(...)
handleAdSkiped(...)
end,
[_adType.eComplete]=function(...)
handleAdComplete(...)
end,
[_adType.eReward]=function(...)
handleAdRewarded(...)
end,
[_adType.eClose]=function(...)
handleAdClose(...)
end,
}


function platformSDK_OpenHarmony_XingJia:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack platformSDK_OpenHarmony_XingJia,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
if isSuccess then
local adType=info.type
local func=_adfunc[adType]
if func then
func(self,info)
end
end
end

