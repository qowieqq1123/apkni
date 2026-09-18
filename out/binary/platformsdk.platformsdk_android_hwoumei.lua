platformSDK_Android_HWOuMei=simple_class(platformSDK_AndroidHW)
local cjson=require'cjson'
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _writablePath=CS.GamePath.writablePath
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;


local enterInfo=
{
[pfLocalZoneType.EU]=
{
infoUrl="https://euzqzs-eu-logpy.efunsea.com/euzqzs/api/getpfinfo",
logUploadURL_Release="https://euzqzs-eu-report.efunsea.com/report",
gameId=9048,
createOrderUrl="https://euzqzs-eu-logpy.efunsea.com/{0}/payment/createorder?"
},
[pfLocalZoneType.NA]=
{
infoUrl="https://euzqzs-us-logpy.efunsea.com/uszqzs/api/getpfinfo",
logUploadURL_Release="https://euzqzs-us-report.efunsea.com/report",
gameId=9050,
createOrderUrl="https://euzqzs-us-logpy.efunsea.com/{0}/payment/createorder?"
},
}

function platformSDK_Android_HWOuMei:getEnterInfo()
return enterInfo
end


function platformSDK_Android_HWOuMei:reqInit()
local typeStr=HWandroidReqType.eInit
androidTool.callFunc(typeStr)
end


function platformSDK_Android_HWOuMei:reqLogin(callback)
platformSDK.printSDK('reqLogin: ',pfwindowslController.initLocalZoneFinish)
if not pfwindowslController.initLocalZoneFinish then
platformSDK.printSDK('大区信息尚未初始化')
return
end
if self.onSwtichLoginData then
self:onLoginCallBack(self.onSwtichLoginData,self.onSwtichLoginData.JsonStr)
self.onSwtichLoginData=nil
return
end
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
local typeStr=HWandroidReqType.eLogin
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end



function platformSDK_Android_HWOuMei:reqLogout(callback)
self:reqChangeAccount()
end


function platformSDK_Android_HWOuMei:reqQuit(callback,args)
local typeStr=HWandroidReqType.eReqExit
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr,args)
end


function platformSDK_Android_HWOuMei:reqReport(typo,info)
local typeStr=HWandroidReqType.eReport
local playerInfo=platformHelper:getPlayerInfo()
local sex=playerModel:getActorSex()or'0'
playerInfo.json_sex=sex
playerInfo.json_vocname=1
info=platformHelper.concat(info,playerInfo)
info.json_type=sdkReportStr[typo]
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
local zmLV=zongmenModel:getLevel()or 1
if typo==sdkReportEnum.eEnterMainSceneReport and zmLV>=1 then
self:showOpenWebPage()
end
end


function platformSDK_Android_HWOuMei:reqPay(id,count,params,subscribe)
local typeStr=HWandroidReqType.ePay

local cfg=cfg_rechargeconfig_get(id)

local info=platformHelper:getPlayerInfo()
info.json_tradeId=platformHelper.getTradeId(id)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
info.json_rmb=cfg.pay[GameVersion][MoneyType]
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
info.json_count=count

info.json_test=0
info.json_url=''
info.subscribe=subscribe or false

info.json_productId="tw.zqzs.0.99usd"
if type(cfg.product_android_id)=='table'then
info.json_productId=cfg.product_android_id[GameVersion]
else
info.json_productId=cfg.product_android_id
end
info.json_payStone=cfg.yuanbao
info.json_productName=""
info.json_productDescription=""
info.json_currency=pfwindowslController:getPFMoneyType()
local function httpCallBack(message,err)
platformSDK.printSDK('Request Remark returned: ',message)
if err==""or not err then
local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
local content='Request Remark failed'
UIManager.info(content)
return
end
end
if json_table.data then
info.json_attach=json_table.data.remark or""
platformSDK.printSDK('remark value: ',info.json_attach)

local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end
end
end

local enterGameState=gameState.isEnter()
local sid=tostring(loginModel.be_server_id or 0)
local userid=tostring(loginModel.userid)
local actorId=tostring(playerModel:getActorID()or'')
local level=enterGameState and zongmenModel:getLevel()or 1

local curLocalZone=pfwindowslController:getLocalZone()
local createOrderUrl=enterInfo[curLocalZone].createOrderUrl
createOrderUrl=FMT.fmt(createOrderUrl,loginModel:getPfname())

local attachParams=params and params~=''and base64.enc(string.encodeURI(params))or''
local urlStr=FMT.fmt('{0}account={1}&actorId={2}&actorLevel={3}&sid={4}&payIndex={5}&param={6}&productId={7}',createOrderUrl,userid,actorId,level,sid,id,attachParams,info.json_productId)
platformSDK.printSDK('Request remarkurlStr: ',urlStr)
_httpGetRequest(urlStr,httpCallBack)
end


function platformSDK_Android_HWOuMei:reqPlayAD(adid,attach,callback)
local typeStr=HWandroidReqType.ePlayAD
local info=platformHelper:getPlayerInfo()
info.json_adid=adid
info.json_ext=attach
local jsonStr=jsonHelper.encode(info)
self:addArgsFunc(typeStr,attach,callback)
androidTool.callFunc(typeStr,jsonStr)
end

function platformSDK_Android_HWOuMei:reqReviews()
local pfid=loginModel:getPfid()
local cfg=cfg_pinglunurlconfig_get(pfid,false)
if cfg then
if deviceHelper.getAPILevel()<54 then
pfwindowslController:OpenURL_By_UIWebViewWin(cfg.url)

else
local typeStr=HWandroidReqType.eOpenTapTap
androidTool.callFunc(typeStr)
end
end
end




function platformSDK_Android_HWOuMei:reqShareImage(path,shareType,platform)
if path==nil then return end
local ud={}
ud.path=path
ud.shareType=shareType
ud.platform=platform
local jsonStr=jsonHelper.encode(ud)
jsonStr=string.gsub(jsonStr,"\\/","/")
local typeStr=HWandroidReqType.eShareImage
androidTool.callFunc(typeStr,jsonStr)
platformSDK.printSDK('req_shareImage platformSDK_Android_HWOuMei')
end

function platformSDK_Android_HWOuMei:reqSubscriptionStatus(id)
platformSDK.printSDK('reqSubscriptionStatus platformSDK_Android_HWOuMei')
local typeStr=HWandroidReqType.eSubscriptionStatus
local info=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:reqCustomServerListener()
local typeStr=HWandroidReqType.eCustomServerListener
androidTool.callFunc(typeStr,'')
end


function platformSDK_Android_HWOuMei:reqCustomerService()
local typeStr=HWandroidReqType.eShowCustomServer
local playerInfo=platformHelper:getPlayerInfo()
playerInfo.json_viplevel=0
playerInfo.json_remark=""
local jsonStr=jsonHelper.encode(playerInfo)
androidTool.callFunc(typeStr,jsonStr)
end



function platformSDK_Android_HWOuMei:reqChangeAccount()

local data={}
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(HWandroidReqType.eSwitchLogin,jsonStr)
platformSDK.printSDK('reqChangeAccount platformSDK_Android_HWOuMei')
end


function platformSDK_Android_HWOuMei:efunRequestReviewInApp()
local typeStr=HWandroidReqType.efunRequestReviewInApp
local playerInfo=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(playerInfo)
androidTool.callFunc(typeStr,jsonStr)
end














function platformSDK_Android_HWOuMei:onInitCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isInit=isSuccess
if not isSuccess then
self.isReqLogin=nil
logPoint.UploadLog(logPoint.logExtType.SDKInitFail)
else
logPoint.UploadLog(logPoint.logExtType.SDKInitSuccess)
end
end


function platformSDK_Android_HWOuMei:onReqLoginCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
local initSuccess=info.initSuccess
local initFailed=info.initFailed
local initCode=info.initCode
local devId=info.devId
appUtils.setSDKIMEI(devId)
if isSuccess then
self.isInit=true
logPoint.UploadLog(logPoint.logExtType.SDKInitSuccess,initCode)
logPoint.UploadLog(logPoint.logExtType.reqSDKLogin)
platformSDK.printSDK('onReqLoginCallBack platformSDK_Android_HWOuMei,reqlogin success')
else

if initFailed then
self.isInit=false
logPoint.UploadLog(logPoint.logExtType.SDKInitFail,initCode)
self:reqInit()
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_HWOuMei,reqlogin failed !beacuse init failed:%s',tostring(initCode)))
elseif not initSuccess then
self.isInit=false
logPoint.UploadLog(logPoint.logExtType.SDKInitNoRet,initCode)
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_HWOuMei,reqlogin failed !beacuse init no ret:%s',tostring(initCode)))
else
self.isInit=true
platformSDK.printSDK('onReqLoginCallBack platformSDK_Android_HWOuMei,reqlogin failed !unknown why!')
end
end
end







function platformSDK_Android_HWOuMei:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isReqLogin=nil
if isSuccess then
local info=cjson.decode(params)
local phpParams={}
info.username="None"
phpParams.token=info.token
platformSDK.printSDK('登入資訊__刷新 LoginCallBack platformSDK_Android_HWOuMeiX',info.loginType)

pfwindowslController.setMacPlayer(info.loginType)


if loginModel.isLogin then
loginModel:onfreshLoginInfo(info,phpParams,"")
platformSDK.printSDK('登入資訊__刷新 LoginCallBack platformSDK_Android_HWOuMei')
else
loginModel:onLogin(info,phpParams,"")
platformSDK.printSDK('登入__成功 LoginCallBack platformSDK_Android_HWOuMei')

socketManager:closeDialogue()
self:callFunc(HWandroidReqType.eLogin)
end
loginControl:requestVerifyLastServerList()
else
logPoint.UploadLog(logPoint.logExtType.SDKLoginFail)
end
self:clearFunc(HWandroidReqType.eLogin)
end


function platformSDK_Android_HWOuMei:onLogoutCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isReqLogin=nil
if isSuccess then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
if not self:callFunc(HWandroidReqType.eLogout)then
loginState:logout()
end
end

end
self:clearFunc(HWandroidReqType.eLogout)
platformSDK.printSDK('LogoutCallBack platformSDK_Android_HWOuMei,param=%s,isShowLoginWindow=%s',tostring(jsonStr))
end



function platformSDK_Android_HWOuMei:onSwtichLoginCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
self.onSwtichLoginData=json
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
if not self:callFunc(HWandroidReqType.eLogout)then
loginState:logout()
end
end

end
end


function platformSDK_Android_HWOuMei:onPayCallBack(json,jsonStr)
platformSDK.printSDK(string.format('PayCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then

platformSDK.printSDK('Payment successful')
notifySystem:postNotify(notifyConfig.payRet,true)
if verifyManager:isHideBindAccount()then
return
end
if pfwindowslController.getMacPlayer()then
pfwindowslController:reqAccountBind_OuMei()
end
else
platformSDK.printSDK('Payment failed. Return info = %s',tostring(jsonStr))
notifySystem:postNotify(notifyConfig.payRet,false)
shushuReportHelper.Report_byEventName(shushuReportEventName.zqzs_pay_fail)
end
end


function platformSDK_Android_HWOuMei:onReportCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
platformSDK.printSDK('reportCallBack platformSDK_Android_HWOuMei 成功')
else
platformSDK.printSDK(string.format('reportCallBack platformSDK_Android_HWOuMei 失敗：%s',jsonStr))
end
end


function platformSDK_Android_HWOuMei:onExitCallBack(json,jsonStr)
platformSDK.printSDK(string.format('ExitCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr)))
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(HWandroidReqType.eExit,jsonStr)
end



function platformSDK_Android_HWOuMei:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('OnKeyDown_NativeClick platformSDK_Android_HWOuMei,num',json.JsonStr)
if tonumber(json.JsonStr)==4 then
baseFullScreenUI:goBack()
end
end



function platformSDK_Android_HWOuMei:onBackPressed(json,jsonStr)
platformSDK.printSDK('onBackPressed platformSDK_Android_HWOuMei,num',json.IsSuccess)
local isSuccess=json.IsSuccess
if isSuccess then
baseFullScreenUI:goBack()
end
end


function platformSDK_Android_HWOuMei:onRealNameCallBack(json,jsonStr)

end

function platformSDK_Android_HWOuMei:onShareImageCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onShareImageCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
platformSDK.printSDK('ShareImage - Start sharing')
else
platformSDK.printSDK(string.format('ShareImage - Share failed=%s',tostring(jsonStr)))
end
end

function platformSDK_Android_HWOuMei:onSubscriptionStatusCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onSubscriptionStatusCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local id=tonumber(info.productId)
local status=info.status
payControl:setSubscriptionStatus(id,status)
end
end

function platformSDK_Android_HWOuMei:onCustomServerReddotCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onCustomServerReddotCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local num=info.num
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
local adid=info.adid or'None'
local attach=info.attach
self:callArgsFunc(HWandroidReqType.ePlayAD,attach,true,{false,info})
loggerUtil.logFMT('Ad failed! adid: {0}',adid)
end

local handleAdClick=function(self,info)
local adType=info.type
local adid=info.adid or'None'
local attach=info.attach
loggerUtil.log(FMT.fmt('Tap the ad! adid:{0}',adid))
end

local handleAdShow=function(self,info)
local adType=info.type
local adid=info.adid or'None'
local attach=info.attach
loggerUtil.log(FMT.fmt('Play ad! adid: {0}',adid))
end

local handleAdSkiped=function(self,info)
local adType=info.type
local adid=info.adid or'None'
local attach=info.attach
self:callArgsFunc(HWandroidReqType.ePlayAD,attach,true,{true,info})
loggerUtil.log(FMT.fmt('Skip ad! adid: {0}',adid))
end

local handleAdComplete=function(self,info)
local adType=info.type
local adid=info.adid or'None'
local attach=info.attach
self:callArgsFunc(HWandroidReqType.ePlayAD,attach,true,{true,info})
loggerUtil.log(FMT.fmt('Complete Ad! AdID:{0}',adid))
end

local handleAdRewarded=function(self,info)
local adType=info.type
local adid=info.adid or'None'
local attach=info.attach

self:callArgsFunc(HWandroidReqType.ePlayAD,attach,true,{true,info})

loggerUtil.log(FMT.fmt('Claim advertisement rewards! adid: {0}',adid))
end

local handleAdClose=function(self,info)
local adType=info.type
local adid=info.adid or'None'
local attach=info.attach
loggerUtil.log(FMT.fmt('Close ad! adid: {0}',adid))
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


function platformSDK_Android_HWOuMei:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack platformSDK_Android_HWOuMei,param=%s',tostring(jsonStr))
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





function platformSDK_Android_HWOuMei:reqEfunShowPlatform()
local typeStr=HWandroidReqType.eEfunShowPlatform
local data=platformHelper:getPlayerInfo()
data.json_remark=""
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:reqEfunDestoryPlatform()
local typeStr=HWandroidReqType.eEfunDestoryPlatform
local data={}
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:reqVerificationLogin(sdkParams)
if not sdkParams then
platformSDK.printSDK(' Login verification missing parameters')
return
end
local typeStr=HWandroidReqType.eVerificationLogin
local data={}
loginModel:setUserId(tostring(sdkParams.userId))
data.userId=sdkParams.userId
data.event=sdkParams.event
data.expired=sdkParams.expired
data.accessToken=sdkParams.accessToken
data.sign=sdkParams.sign
data.timestamp=sdkParams.timestamp
pfwindowsModel:setSdkLoginData(data)
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:getEfunBindState()
local typeStr=HWandroidReqType.eCheckEfunBind
local data=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:getPhoneCaptcha(phoneNumber)
local typeStr=HWandroidReqType.ePhoneCaptcha
local data=platformHelper:getPlayerInfo()
data.json_phoneNumber=phoneNumber
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:reqPhoneBind()
local typeStr=HWandroidReqType.eReqPhoneBind
local data=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:showEfunOpenScan()
local typeStr=HWandroidReqType.eShowEfunOpenScan
local data={}
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_HWOuMei:eEfunTrackEvent(eventName)
local typeStr=HWandroidReqType.eEfunTrackEvent
local data=platformHelper:getPlayerInfo()
data.json_eventName=eventName
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end



function platformSDK_Android_HWOuMei:reqBindAccount()
local typeStr=HWandroidReqType.eEfunBindAccount
local data=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(data)
androidTool.callFunc(typeStr,jsonStr)
end



function platformSDK_Android_HWOuMei:onGetLocalRegionName(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
if isSuccess then
local LocalRegionName=info.priceCurrencyCode
pfwindowslController:setHWLocalRegionName(LocalRegionName)
platformSDK.printSDK('Region Return Successful',LocalRegionName)
end
end



function platformSDK_Android_HWOuMei:onEfunBindInfo(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
if isSuccess then
local isBindAccount=info.isBindAccount=="true"
local isBindPhone=info.isBindPhone=="true"
local isBindThirdPlatform=info.isBindThirdPlatform=="true"
pfwindowslController:setPhoneBindState(isBindAccount,isBindPhone,isBindThirdPlatform)
platformSDK.printSDK('Binding information returned!',isBindAccount,isBindPhone,isBindThirdPlatform)
end
end



function platformSDK_Android_HWOuMei:onPhoneCaptchaCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
platformSDK.printSDK('Request Verification Code returned',isSuccess)
if isSuccess then
pfwindowslController:getPhoneCaptchaCallBack(true)
else
pfwindowslController:getPhoneCaptchaCallBack(false)
end
end



function platformSDK_Android_HWOuMei:onReqPhoneBindCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
platformSDK.printSDK('Request to Bind Phone returned',isSuccess)
if isSuccess then
platformSDK.printSDK('Bind mobile phone return')
pfwindowslController:setBindPhone(true)
else
pfwindowslController:setBindPhone(false)
end
end


function platformSDK_Android_HWOuMei:OnEfunBindAccount(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
platformSDK.printSDK('OnEfunBindAccount returned',isSuccess)
if isSuccess then
platformSDK.printSDK('OnEfunBindAccount return')
pfwindowslController:setBindAccount_OM(true)
else
pfwindowslController:setBindAccount_OM(false)
end
end


function platformSDK_Android_HWOuMei:onShowEfunOpenScanCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
platformSDK.printSDK('Scan using mobile camera',isSuccess)
if isSuccess then
platformSDK.printSDK('Mobile QR Code Scan returned')
end
end




function platformSDK_Android_HWOuMei:showOpenWebPage()
local typeStr=HWandroidReqType.eShowOpenWebPage
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
platformSDK.printSDK('showOpenWebPage',typeStr)
end


function platformSDK_Android_HWOuMei:onShowOpenWebPage()
platformSDK.printSDK('onShowOpenWebPage')
end


function platformSDK_Android_HWOuMei:CheckGooglePurchase()
local typeStr=HWandroidReqType.eCheckGooglePurchase
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
platformSDK.printSDK('CheckGooglePurchase',typeStr)
end


function platformSDK_Android_HWOuMei:onCheckGooglePurchase(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
self:ConsumeGooglePurchase()
end
platformSDK.printSDK('onCheckGooglePurchase',params)
end


function platformSDK_Android_HWOuMei:ConsumeGooglePurchase()
local typeStr=HWandroidReqType.eConsumeGooglePurchase
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
platformSDK.printSDK('ConsumeGooglePurchase',typeStr)
end



function platformSDK_Android_HWOuMei:onConsumeGooglePurchase(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local contentStr='兌換成功！您已使用Play點數兌換豪華抽卡大禮包，可前往郵件查看。'
local show_data={
type='UIDialouge',
title='兌換提示',
content=contentStr,
oktext='確定',
okcallback=function()

end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
platformSDK.printSDK('onConsumeGooglePurchase',params)
end



function platformSDK_Android_HWOuMei:onEfunRequestReviewInApp(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then

end
end




local this
local url="https://mgr-tms.efunsea.com/gm/game/chat/transformSensitiveWords"
local gamecode="euzqzs"
local _httpJsonPostRequest=CS.ResourceHelper.HttpJsonPostRequest
local cjson=require'cjson'

local id=0
local AddIndex_=function()
id=(id+1)%100000
return id
end

local CBMsgType=
{
zhengchang=0,
pingbici=1,
heidongci=2,
}


function platformSDK_Android_HWOuMei:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
if not this then
this=self
end
local curid=AddIndex_()
self.secCheckCBDict[curid]=callback
local PJcontent=string.format("%s|%s|%s",curid,content,scene)
local info=platformHelper:getPlayerInfo()

if to_PrivatePlayerData then
info.to_roleid=tostring(to_PrivatePlayerData.actorId)
info.to_rolename=tostring(to_PrivatePlayerData.actorName)
end
local type="100"
if chatModel.channelId then
type=tostring(chatModel.channelId)
end
local sign=gamecode..type..info.json_roleid..PJcontent..info.json_sid
platformSDK.printSDK("reqMsgSecChecksign,",sign)
local requestHeader={
"Content-Type",
"application/json;charset=utf-8",
"sign",
CS.LuaHelper.GetMD5UTF8(sign),
"ts",
tostring(timeHelper.getServerLongTime()*1000),
}
platformSDK.printSDK("reqMsgSecChecksign1：,",timeHelper.getServerLongTime()*1000)
platformSDK.printSDK("reqMsgSecChecksign2：,",CS.LuaHelper.GetMD5UTF8(sign))
local rePortTable={}
rePortTable["gameCode"]=gamecode
rePortTable["serverIds"]=info.json_sid
rePortTable["type"]=type
rePortTable["roleId"]=info.json_roleid
rePortTable["receiveRoleId"]=info.to_roleid or""
rePortTable["uid"]=info.json_uid or""
rePortTable["content"]=PJcontent or""
local body=cjson.encode(rePortTable)
platformSDK.printSDK("reqMsgSecCheck,",body)
_httpJsonPostRequest(url,requestHeader,body,self.onreMsgSecCheck)

end



function platformSDK_Android_HWOuMei.onreMsgSecCheck(args)
local info=cjson.decode(args)
platformSDK.printSDK("onreMsgSecCheck1",info.code)
if info.code=="e1000"then
local data=info.data
local CBcontent=data.content
local originalContent=data.originalContent
originalContent=string.split(originalContent,'|')
local curid=originalContent[1]
local content=originalContent[2]
local scene=originalContent[3]
local callback=this.secCheckCBDict[tonumber(curid)]
platformSDK.printSDK("onreMsgSecCheck2:",data.type,CBcontent,originalContent)
if callback then
if data.type==CBMsgType.zhengchang or tonumber(data.type)==CBMsgType.zhengchang then
callback(content)
elseif data.type==CBMsgType.pingbici or tostring(data.type)==CBMsgType.pingbici then
callback(CBcontent)
else
if chatModel.channelId then

chatControl.reqLocalPublicMesg(chatModel.channelId,content)
end
end
end
else
UIManager.error('Failed to send the message')
platformSDK.printSDK("onreMsgSecCheck2：",info.message)
end
end

function platformSDK_Android_HWOuMei:get_permission(permissions)
if permissions==nil then return true end
local data={}
data.length=#permissions
for i,v in ipairs(permissions)do
local keyStr=string.format('permission_%d',i)
data[keyStr]=v
end
local jsonStr=helper.encode(data)
local ret=androidTool.callFunc('HasPermission',jsonStr)
return tostring(ret)==""
end

function platformSDK_Android_HWOuMei:request_permission(permissions,code)
if permissions==nil then return true end
local data={}
data.length=#permissions
for i,v in ipairs(permissions)do
local keyStr=string.format('permission_%d',i)
data[keyStr]=v
end
data.code=code
local jsonStr=helper.encode(data)
local ret=androidTool.callFunc('RequestPermission',jsonStr)
return tostring(ret)==""
end


