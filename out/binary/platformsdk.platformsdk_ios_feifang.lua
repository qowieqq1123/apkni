

platformSDK_iOS_FeiFang=simple_class(platformSDK_iOS)

function platformSDK_iOS_FeiFang:__init(...)
self:addCallFunc('eInitSDK','initSDK','onInitSDKCallback')
self:addCallFunc('eEvent','event','onEventCallback')
self:addCallFunc('eFbshare','fbshare','onFbshareCallback')
self:addCallFunc('eDianZan','DianZan','onDianZanCallback')
self:addCallFunc('eWenJuan','WenJuan','onWenJuanCallback')
self:addCallFunc('ePingFen','PingFen','onPingFenCallback')
self:addCallFunc('eDelAccount','DelAccount','onDelAccountCallback')
self:addCallFunc('eProductsLocal','ProductsLocal','onProductsLocalCallback')
self:addCallFunc('eUserCenter','UserCenter','onUserCenterCallback')
self:addCallFunc('eCustomerService','CustomerService','onCustomerServiceCallback')
self:addCallFunc('eFanView','FanView','onFanViewCallback')
self:addCallFunc('eGameLanguage','GameLanguage','onGameLanguageCallback')
self:addCallFunc('eTimeZone','TimeZone','onTimeZoneCallback')
self:addCallFunc('eIPAddress','IPAddress','onIPAddressCallback')
self:addCallFunc('eTranslate','Translate','onTranslateCallback')
self:addCallFunc('eOpenWeb','OpenWeb','onOpenWebCallback')
self:addCallFunc('eLoadRewardAd','LoadRewardAd','onLoadRewardAdCallback')
self:addCallFunc('eJoinDiscord','JoinDiscord','onJoinDiscordCallback')
self:addCallFunc('eAlertPublicity','AlertPublicity','onAlertPublicityCallback')
self:addCallFunc('eBindAccount','BindAccount','onBindAccountCallback')
end


function platformSDK_iOS_FeiFang:reqLogin()
platformSDK.printSDK('reqLogin  ',self.isReqLogin)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end


self.isReqLogin=stamp
self:callSDKFunc(iOSSDKCallType.eLogin,'')
end


function platformSDK_iOS_FeiFang:reqLogout(callback)
self:callSDKFunc(iOSSDKCallType.eLogout,'')
end
local reportTypeToSendType={
[sdkReportEnum.eEnterServerReport]='1',
[sdkReportEnum.eCreateRoleReport]='2',
[sdkReportEnum.eEnterMainSceneReport]='3',
[sdkReportEnum.eLevelUpReport]='4',
[sdkReportEnum.eExitGameReport]='5',
}


function platformSDK_iOS_FeiFang:reqReport(typo,info)
if reportTypeToSendType[typo]then
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local data={}
data.rtype=reportTypeToSendType[typo]
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.role_level=playerInfo.json_level
data.server_id=playerInfo.json_sid
data.server_name=playerInfo.json_sname
if typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
data.ybNum=moneyModel.getMoney(eMoneyType.mtXianYu)
else
data.ybNum=''
end
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eReport,info)
end
end

function platformSDK_iOS_FeiFang:reqEvent(eventName,key,value)
local data={}
data.eventName=eventName
data.key=key
data.value=value
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eEvent,info)
end


function platformSDK_iOS_FeiFang:reqPay(id,count,params,subscribe)

local product_id=self:getProductIdEx(id)
if not product_id or product_id==''then
platformSDK.printSDK('no product id:  ',id)
return
end

local info=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
local attach=platformHelper.getPayAttach(id,params)
local data={}
data.ORDER_ID=string.format('%s_%s_%s_%s',product_id,info.json_sid,info.json_roleid,tostring(os.time()))
data.PRODUCT_ID=product_id
data.ROLE_ID=info.json_roleid
data.ROLE_NAME=info.json_rolename
data.ROLE_LEVEL=info.json_level
data.SERVER_ID=info.json_sid
data.SERVER_NAME=info.json_sname
data.REMAIN_COIN=info.json_yb
data.EXTRA_INFO=attach
data.PRODUCT_NAME=cfg.name
data.PRODUCT_TYPE=cfg.recharge_type==1 and"coin"or'package'
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePay,info)

end


function platformSDK_iOS_FeiFang:reqfbshare()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eFbshare,info)
end


function platformSDK_iOS_FeiFang:reqDianzan()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eDianZan,info)
end



function platformSDK_iOS_FeiFang:reqWenJuan(pid)
local data={}
data.pid=pid
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eWenJuan,info)
end

function platformSDK_iOS_FeiFang:reqGooglePlay()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.ePingFen,info)
end

function platformSDK_iOS_FeiFang:reqDelAccount()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eDelAccount,info)
end

function platformSDK_iOS_FeiFang:reqProductsLocal()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eProductsLocal,info)
end

function platformSDK_iOS_FeiFang:reqUserCenter()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eUserCenter,info)
end

function platformSDK_iOS_FeiFang:reqCustomerService()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eCustomerService,info)
end

function platformSDK_iOS_FeiFang:reqFanView()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eFanView,info)
end


function platformSDK_iOS_FeiFang:reqOpenURL(url)
LuaApplication.GetApplication().OpenURL(url)
end














function platformSDK_iOS_FeiFang:reqGameLanguage(language)
local data={}
data.language=language
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eGameLanguage,info)
end

function platformSDK_iOS_FeiFang:reqTimeZone()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eTimeZone,info)
end

function platformSDK_iOS_FeiFang:reqIPAddress()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eIPAddress,info)
end





function platformSDK_iOS_FeiFang:reqTranslate(sourceText,lang,callbackkey)
local data={}
data.sourceText=sourceText
data.lang=lang
data.callbackkey=callbackkey
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eTranslate,info)
end




function platformSDK_iOS_FeiFang:reqOpenWeb(url,inApp)
local data={}
data.url=url
data.type=inApp and'1'or'0'
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eOpenWeb,info)
end


function platformSDK_iOS_FeiFang:reqLoadRewardAd()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eLoadRewardAd,info)
end

function platformSDK_iOS_FeiFang:reqJoinDiscord()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eJoinDiscord,info)
end


function platformSDK_iOS_FeiFang:reqAlertPublicity()
local info=jsonHelper.encode({})
self:callSDKFunc(iOSSDKCallType.eAlertPublicity,info)
end



function platformSDK_iOS_FeiFang:reqBindAccount(type)
local data={}
data.type=type
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eBindAccount,info)
end



function platformSDK_iOS_FeiFang:onInitSDKCallback(id,ftype,success,result)
platformSDK.printSDK('onInitSDKCallback',id,ftype,success,result)
end

function platformSDK_iOS_FeiFang:onLoginCallback(id,ftype,success,result)
platformSDK.printSDK('onLoginCallback ',id,ftype,success,result)
self.isReqLogin=nil
if success then
local info=jsonHelper.decode(result)
local phpParams={}
info.username="Vô"
phpParams.uid=info.uid
phpParams.token=info.token



if loginModel.isLogin then
loginModel:onfreshLoginInfo(info,phpParams,info.uid)

else
loginModel:onLogin(info,phpParams,info.uid)




end
else
logPoint.UploadLog(logPoint.logExtType.SDKLoginFail)
end
end

function platformSDK_iOS_FeiFang:onLogoutCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
loginState:logout()
end
end
end

function platformSDK_iOS_FeiFang:onPayCallback(id,ftype,success,result)
platformSDK.printSDK('onPayCallback',id,ftype,success,result)
end


function platformSDK_iOS_FeiFang:onFbshareCallback(id,ftype,success,result)
platformSDK.printSDK('onFbshareCallback',id,ftype,success,result)
end

function platformSDK_iOS_FeiFang:onDianZanCallback(id,ftype,success,result)
platformSDK.printSDK('onDianZanCallback',id,ftype,success,result)
end




function platformSDK_iOS_FeiFang:getProductIdEx(id)
local cfg=cfg_rechargeconfig_get(id)
local pid
if cfg then
if type(cfg.product_ios_id)=='table'then
local GameVersion=pfwindowslController:getGameVersion()
pid=cfg.product_ios_id[GameVersion]
else
pid=cfg.product_ios_id
end
end
return pid
end




