platformSDK_Android_yuenan=simple_class(platformSDK_AndroidHW)
local cjson=require'cjson'
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString



local cjson=require'cjson'


local json_coinType=
{
coin=1,
package=2,
}


function platformSDK_Android_yuenan:reqInit()
local typeStr=HWandroidReqType.eInit
androidTool.callFunc(typeStr)
end


function platformSDK_Android_yuenan:reqLogin(callback)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
local typeStr=HWandroidReqType.eLogin
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end


function platformSDK_Android_yuenan:reqSwitchLogin()
local typeStr=HWandroidReqType.eSwitchLogin
androidTool.callFunc(typeStr)
end


function platformSDK_Android_yuenan:reqLogout(callback)
local typeStr=HWandroidReqType.eLogout
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end


function platformSDK_Android_yuenan:reqQuit(callback,args)
local typeStr=HWandroidReqType.eReqExit
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr,args)
end


function platformSDK_Android_yuenan:reqReport(typo,info)
local typeStr=HWandroidReqType.eReport
local playerInfo=platformHelper:getPlayerInfo()
local sex=playerModel:getActorSex()or'0'
playerInfo.json_sex=sex
playerInfo.json_vocname=1
playerInfo.json_xy=moneyModel.getMoney(eMoneyType.mtXianYu)
info=platformHelper.concat(info,playerInfo)
info.json_type=sdkReportStr[typo]
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
local zmLV=zongmenModel:getLevel()or 1
if typo==sdkReportEnum.eEnterMainSceneReport and zmLV>=15 then

end
end


function platformSDK_Android_yuenan:reqPay(id,count,params,subscribe)
local typeStr=HWandroidReqType.ePay

local cfg=cfg_rechargeconfig_get(id)

local info=platformHelper:getPlayerInfo()
local attach=platformHelper.getPayAttach(id,params)
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
info.json_ly=moneyModel.getMoney(eMoneyType.mtXianYu)
info.json_coin=json_coinType.coin

info.json_productId="zqzs.and.5000vnd"
if type(cfg.product_android_id)=='table'then
info.json_productId=cfg.product_android_id[GameVersion]
else
info.json_productId=cfg.product_android_id
end

info.json_payStone=cfg.yuanbao

info.json_cpid=string.format('%s_%s_%s_%s',info.json_productId,info.json_sid,info.json_roleid,tostring(os.time()))
info.json_currency=pfwindowslController:getPFMoneyType()

info.json_attack=attach

local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_yuenan:reqPlayAD(adid,attach,callback)
local typeStr=HWandroidReqType.ePlayAD
local info=platformHelper:getPlayerInfo()
info.json_adid=adid
info.json_ext=attach
local jsonStr=jsonHelper.encode(info)
self:addArgsFunc(typeStr,attach,callback)
androidTool.callFunc(typeStr,jsonStr)
end

function platformSDK_Android_yuenan:reqReviews()
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




function platformSDK_Android_yuenan:reqShareImage(path,shareType,platform)
if path==nil then return end
local ud={}
ud.path=path
ud.shareType=shareType
ud.platform=platform
local jsonStr=jsonHelper.encode(ud)
jsonStr=string.gsub(jsonStr,"\\/","/")
local typeStr=HWandroidReqType.eShareImage
androidTool.callFunc(typeStr,jsonStr)
platformSDK.printSDK('req_shareImage platformSDK_Android_yuenan')
end

function platformSDK_Android_yuenan:reqSubscriptionStatus(id)
platformSDK.printSDK('reqSubscriptionStatus platformSDK_Android_yuenan')
local typeStr=HWandroidReqType.eSubscriptionStatus
local info=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_yuenan:reqCustomServerListener()
local typeStr=HWandroidReqType.eCustomServerListener
androidTool.callFunc(typeStr,'')
end

function platformSDK_Android_yuenan:reqOpenCustomServer()
local typeStr=HWandroidReqType.eShowCustomServer
local playerInfo=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(playerInfo)
androidTool.callFunc(typeStr,jsonStr)
end















function platformSDK_Android_yuenan:onInitCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isInit=isSuccess
if not isSuccess then
self.isReqLogin=nil
logPoint.UploadLog(logPoint.logExtType.SDKInitFail)
else
logPoint.UploadLog(logPoint.logExtType.SDKInitSuccess)
end
end


function platformSDK_Android_yuenan:onReqLoginCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr)))
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
platformSDK.printSDK('onReqLoginCallBack platformSDK_Android_yuenan,reqlogin success')
else

if initFailed then
self.isInit=false
logPoint.UploadLog(logPoint.logExtType.SDKInitFail,initCode)
self:reqInit()
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_yuenan,reqlogin failed !beacuse init failed:%s',tostring(initCode)))
elseif not initSuccess then
self.isInit=false
logPoint.UploadLog(logPoint.logExtType.SDKInitNoRet,initCode)
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_yuenan,reqlogin failed !beacuse init no ret:%s',tostring(initCode)))
else
self.isInit=true
platformSDK.printSDK('onReqLoginCallBack platformSDK_Android_yuenan,reqlogin failed !unknown why!')
end
end
end







function platformSDK_Android_yuenan:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isReqLogin=nil
if isSuccess then
local info=cjson.decode(params)
local phpParams={}
info.username="Vô"
phpParams.uid=info.uid
phpParams.token=info.token



if loginModel.isLogin then
loginModel:onfreshLoginInfo(info,phpParams,info.uid)
platformSDK.printSDK('登入資訊__刷新 LoginCallBack platformSDK_Android_yuenan')
else
loginModel:onLogin(info,phpParams,info.uid)
platformSDK.printSDK('登入__成功 LoginCallBack platformSDK_Android_yuenan')

socketManager:closeDialogue()
self:callFunc(HWandroidReqType.eLogin)
end
else
logPoint.UploadLog(logPoint.logExtType.SDKLoginFail)
end
self:clearFunc(HWandroidReqType.eLogin)
end


function platformSDK_Android_yuenan:onSwtichLoginCallBack(json,jsonStr)
platformSDK.printSDK('SwtichLoginCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
self.isReqLogin=nil
if isSuccess then
loginModel.isLogin=false
local win=UIManager:findActiveWindow("UILogin")
if win then

else
if not self:callFunc(HWandroidReqType.eLogout,true)then
loginState:logout()
end
end
end
self:clearFunc(HWandroidReqType.eLogin)
self:clearFunc(HWandroidReqType.eLogout)
end


function platformSDK_Android_yuenan:onLogoutCallBack(json,jsonStr)
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
platformSDK.printSDK('LogoutCallBack platformSDK_Android_yuenan,param=%s,isShowLoginWindow=%s',tostring(jsonStr))
end


function platformSDK_Android_yuenan:onPayCallBack(json,jsonStr)
platformSDK.printSDK(string.format('PayCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then

platformSDK.printSDK('Thanh toán thành công')
notifySystem:postNotify(notifyConfig.payRet,true)
else
platformSDK.printSDK('Thanh toán thất bại Thông tin trả về = %s',tostring(jsonStr))
notifySystem:postNotify(notifyConfig.payRet,false)
shushuReportHelper.Report_byEventName(shushuReportEventName.zqzs_pay_fail)
end
end


function platformSDK_Android_yuenan:onReportCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
platformSDK.printSDK('reportCallBack platformSDK_Android_yuenan 成功')
else
platformSDK.printSDK(string.format('reportCallBack platformSDK_Android_yuenan 失敗：%s',jsonStr))
end
end


function platformSDK_Android_yuenan:onExitCallBack(json,jsonStr)
platformSDK.printSDK(string.format('ExitCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr)))
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(HWandroidReqType.eExit,jsonStr)
end



function platformSDK_Android_yuenan:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('OnKeyDown_NativeClick platformSDK_Android_yuenan,num',json.JsonStr)
if tonumber(json.JsonStr)==4 then
baseFullScreenUI:goBack()
end
end



function platformSDK_Android_yuenan:onBackPressed(json,jsonStr)
platformSDK.printSDK('onBackPressed platformSDK_Android_yuenan,num',json.IsSuccess)
local isSuccess=json.IsSuccess
if isSuccess then
baseFullScreenUI:goBack()
end
end


function platformSDK_Android_yuenan:onRealNameCallBack(json,jsonStr)

end

function platformSDK_Android_yuenan:onShareImageCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onShareImageCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
platformSDK.printSDK('ShareImage bắt đầu chia sẻ  ')
else
platformSDK.printSDK(string.format('ShareImage chia sẻ thất bại = %s  ',tostring(jsonStr)))
end
end

function platformSDK_Android_yuenan:onSubscriptionStatusCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onSubscriptionStatusCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local id=tonumber(info.productId)
local status=info.status
payControl:setSubscriptionStatus(id,status)
end
end

function platformSDK_Android_yuenan:onCustomServerReddotCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onCustomServerReddotCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local num=info.num
end
end



function platformSDK_Android_yuenan:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack platformSDK_Android_yuenan,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
if isSuccess then

end
end



function platformSDK_Android_yuenan:get_permission(permissions)
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

function platformSDK_Android_yuenan:request_permission(permissions,code)
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





function platformSDK_Android_yuenan:reqGooglePlay()

androidTool.callFunc('GooglePlay')
end


function platformSDK_Android_yuenan:reqfbshare()

androidTool.callFunc('fbShare')
end


function platformSDK_Android_yuenan:reqDianzan()

androidTool.callFunc('dianzan')
end


function platformSDK_Android_yuenan:reqShowSurveyView(surveyId)
local info={}
info.json_surveyId=surveyId or 0

local jsonStr=jsonHelper.encode(info)
androidTool.callFunc('showSurveyView',jsonStr)
end


function platformSDK_Android_yuenan:reqopenDiscord()
androidTool.callFunc('openDiscord')
end


function platformSDK_Android_yuenan:onShowSurveyView(json,jsonStr)
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
if isSuccess then
for id,state in pairs(info)do

end
end
end