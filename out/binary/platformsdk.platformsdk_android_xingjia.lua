platformSDK_Android_XingJia=simple_class(platformSDK_Android)
local cjson=require'cjson'
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _writablePath=CS.GamePath.writablePath



function platformSDK_Android_XingJia:reqInit()
local typeStr=androidReqType.eInit
androidTool.callFunc(typeStr)
end


function platformSDK_Android_XingJia:reqLogin(callback)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
local typeStr=androidReqType.eLogin
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end


function platformSDK_Android_XingJia:reqSwitchLogin()
local typeStr=androidReqType.eSwitchLogin
androidTool.callFunc(typeStr)
end


function platformSDK_Android_XingJia:reqLogout(callback)
local typeStr=androidReqType.eLogout
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end


function platformSDK_Android_XingJia:reqQuit(callback,args)
local typeStr=androidReqType.eReqExit
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr,args)
end


function platformSDK_Android_XingJia:reqReport(typo,info)
local typeStr=androidReqType.eReport
local playerInfo=platformHelper:getPlayerInfo()
info=platformHelper.concat(info,playerInfo)
info.json_type=sdkReportStr[typo]
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_XingJia:reqPay(id,count,params,subscribe)
local typeStr=androidReqType.ePay

local info=platformHelper:getPlayerInfo()
local attach=platformHelper.getPayAttach(id,params)

local cfg=cfg_rechargeconfig_get(id)
info.json_tradeId=platformHelper.getTradeId(id)
info.json_rmb=cfg.rmb
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
info.json_count=count
info.json_attach=attach
info.json_test=0
info.json_url=''
info.subscribe=subscribe or false

local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_XingJia:reqPlayAD(adid,attach,callback)
local typeStr=androidReqType.ePlayAD
local info=platformHelper:getPlayerInfo()
info.json_adid=adid
info.json_ext=attach
local jsonStr=jsonHelper.encode(info)
self:addArgsFunc(typeStr,attach,callback)
androidTool.callFunc(typeStr,jsonStr)
end

function platformSDK_Android_XingJia:reqReviews()
local pfid=loginModel:getPfid()
local cfg=cfg_pinglunurlconfig_get(pfid,false)
if cfg then
if deviceHelper.getAPILevel()<54 then

pfwindowslController:OpenURL_By_UIWebViewWin(cfg.url)
else
local typeStr=androidReqType.eOpenTapTap
androidTool.callFunc(typeStr)
end
end
end




function platformSDK_Android_XingJia:reqShareImage(path,shareType,platform)
if path==nil then return end
local ud={}
ud.path=path
ud.shareType=shareType
ud.platform=platform
local jsonStr=jsonHelper.encode(ud)
jsonStr=string.gsub(jsonStr,"\\/","/")
local typeStr=androidReqType.eShareImage
androidTool.callFunc(typeStr,jsonStr)
platformSDK.printSDK('req_shareImage platformSDK_Android_XingJia')
end

function platformSDK_Android_XingJia:reqSubscriptionStatus(id)
platformSDK.printSDK('reqSubscriptionStatus platformSDK_Android_XingJia')
local typeStr=androidReqType.eSubscriptionStatus
local info=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_Android_XingJia:reqCustomServerListener()
local typeStr=androidReqType.eCustomServerListener
androidTool.callFunc(typeStr,'')
end

function platformSDK_Android_XingJia:reqOpenCustomServer()
local typeStr=androidReqType.eShowCustomServer
local playerInfo=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end

function platformSDK_Android_XingJia:reqOpenForumPage()
local typeStr=androidReqType.eOpenForumPage
local ud={}
ud.sceneId=''
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(typeStr,jsonStr)
end

function platformSDK_Android_XingJia:reqCloseForumPage()
local typeStr=androidReqType.eCloseForumPage
local ud={}
ud.content=''
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(typeStr,jsonStr)
end


local _uploadChatPF=
{
[8679]=true
}
function platformSDK_Android_XingJia:uploadChatMsg(msgInfoEx)
local pfid=loginModel:getPfid()
if _uploadChatPF[pfid]then

local uploadType=chatConfig.getUploadMesgType(msgInfoEx)
if uploadType==nil then return false end

local info=platformHelper:getPlayerInfo()

info.json_recharge=string.format("%s",rechargeModel:getTotalRecharge()*100)
info.json_mesg=msgInfoEx.mesg
info.json_uploadType=uploadType
info.json_holderId=msgInfoEx.holderId or'0'
info.json_holderName='0'
info.json_sendguid=msgInfoEx.sendguid or'0'
info.json_sendStamp=msgInfoEx.stamp
info.json_ip=loginModel.phpLoginInfo and loginModel.phpLoginInfo.login_ip or''
info.json_holderRecharge='0'
info.json_holderUsename='0'
info.json_holderUid='0'
info.json_ext='0'

local typeStr=androidReqType.eUploadChatMsg
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
return true
end
return false
end


function platformSDK_Android_XingJia:reqOpenCommunity(sceneId)
local typeStr=androidReqType.eOpenCommunity
local ud={}
ud.sceneId=sceneId
local jsonStr=jsonHelper.encode(ud)
androidTool.callFunc(typeStr,jsonStr)
end








function platformSDK_Android_XingJia:onInitCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isInit=isSuccess
if not isSuccess then
self.isReqLogin=nil
logPoint.UploadLog(logPoint.logExtType.SDKInitFail)
else
logPoint.UploadLog(logPoint.logExtType.SDKInitSuccess)
end
end


function platformSDK_Android_XingJia:onReqLoginCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
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
platformSDK.printSDK('onReqLoginCallBack platformSDK_Android_XingJia,reqlogin success')
else

if initFailed then
self.isInit=false
logPoint.UploadLog(logPoint.logExtType.SDKInitFail,initCode)
self:reqInit()
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_XingJia,reqlogin failed !beacuse init failed:%s',tostring(initCode)))
elseif not initSuccess then
self.isInit=false
logPoint.UploadLog(logPoint.logExtType.SDKInitNoRet,initCode)
platformSDK.printSDK(string.format('onReqLoginCallBack platformSDK_Android_XingJia,reqlogin failed !beacuse init no ret:%s',tostring(initCode)))
else
self.isInit=true
platformSDK.printSDK('onReqLoginCallBack platformSDK_Android_XingJia,reqlogin failed !unknown why!')
end
end
end







function platformSDK_Android_XingJia:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isReqLogin=nil
if isSuccess then
local info=cjson.decode(params)

local phpParams={}
phpParams.uid=info.uid
phpParams.sign=info.token




if loginModel.isLogin then
if info.username~=loginModel.username then
loginControl:loginout()
logErr(string.format('账号异常登陆回调刷新 账号不匹配 旧账号：%s  刷新账号：%s',loginModel.username,info.username))
return
end
loginModel:onfreshLoginInfo(info,phpParams,info.uid)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_Android_XingJia')
else
loginModel:onLogin(info,phpParams,info.uid)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_Android_XingJia')

socketManager:closeDialogue()
self:callFunc(androidReqType.eLogin)
end
else
logPoint.UploadLog(logPoint.logExtType.SDKLoginFail)
end
self:clearFunc(androidReqType.eLogin)
end


function platformSDK_Android_XingJia:onSwtichLoginCallBack(json,jsonStr)
platformSDK.printSDK('SwtichLoginCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
self.isReqLogin=nil
if isSuccess then
loginModel.isLogin=false
local win=UIManager:findActiveWindow("UILogin")
if win then

else
if not self:callFunc(androidReqType.eLogout,true)then
loginState:logout()
end
end
end
self:clearFunc(androidReqType.eLogin)
self:clearFunc(androidReqType.eLogout)
end


function platformSDK_Android_XingJia:onLogoutCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isReqLogin=nil
if isSuccess then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
if not self:callFunc(androidReqType.eLogout)then
loginState:logout()
end
end
end
self:clearFunc(androidReqType.eLogout)
platformSDK.printSDK('LogoutCallBack platformSDK_Android_XingJia,param=%s,isShowLoginWindow=%s',tostring(jsonStr))
end


function platformSDK_Android_XingJia:onPayCallBack(json,jsonStr)
platformSDK.printSDK(string.format('PayCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then

platformSDK.printSDK('支付成功')
notifySystem:postNotify(notifyConfig.payRet,true)
else
platformSDK.printSDK('支付失败 返回信息=%s',tostring(jsonStr))
notifySystem:postNotify(notifyConfig.payRet,false)
shushuReportHelper.Report_byEventName(shushuReportEventName.zqzs_pay_fail)
end
end


function platformSDK_Android_XingJia:onReportCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
platformSDK.printSDK('reportCallBack platformSDK_Android_XingJia 成功')
else
platformSDK.printSDK(string.format('reportCallBack platformSDK_Android_XingJia 失败：%s',jsonStr))
end
end


function platformSDK_Android_XingJia:onExitCallBack(json,jsonStr)
platformSDK.printSDK(string.format('ExitCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
local info=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(androidReqType.eExit,jsonStr)
end



function platformSDK_Android_XingJia:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('OnKeyDown_NativeClick platformSDK_Android_XingJia,num',json.JsonStr)
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

function platformSDK_Android_XingJia:onRealNameCallBack(json,jsonStr)

end

function platformSDK_Android_XingJia:onShareImageCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onShareImageCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
platformSDK.printSDK('ShareImage开始分享')
else
platformSDK.printSDK(string.format('ShareImage 分享失败=%s',tostring(jsonStr)))
end
end

function platformSDK_Android_XingJia:onSubscriptionStatusCallBack(json,jsonStr)
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

function platformSDK_Android_XingJia:onCustomServerReddotCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onCustomServerReddotCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr)))
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


function platformSDK_Android_XingJia:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack platformSDK_Android_XingJia,param=%s',tostring(jsonStr))
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

