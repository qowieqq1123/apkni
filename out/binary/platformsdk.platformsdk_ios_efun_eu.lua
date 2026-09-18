

platformSDK_iOS_EFun_Eu=simple_class(platformSDK_iOS)

local _httpGetRequest=CS.ResourceHelper.HttpGetRequest

local enterInfo=
{
[pfLocalZoneType.EU]=
{
infoUrl="https://euzqzs-eu-logpy.efunsea.com/euzqzsios/api/getpfinfo",
logUploadURL_Release="https://euzqzs-eu-report.efunsea.com/report",
gameId=9049,
createOrderUrl="https://euzqzs-eu-logpy.efunsea.com/{0}/payment/createorder?"
},
[pfLocalZoneType.NA]=
{
infoUrl="https://euzqzs-us-logpy.efunsea.com/uszqzsios/api/getpfinfo",
logUploadURL_Release="https://euzqzs-us-report.efunsea.com/report",
gameId=9051,
createOrderUrl="https://euzqzs-us-logpy.efunsea.com/{0}/payment/createorder?"
},
}

function platformSDK_iOS_EFun_Eu:getEnterInfo()
return enterInfo
end

function platformSDK_iOS_EFun_Eu:__init(...)

self.secCheckCBDict={}
self:addCallFunc('eLoginCheck','login_check','onLoginCheckCallback')
self:addCallFunc('eTrackEvent','trackevent','onTrackEventCallback')
self:addCallFunc('ePerformancerAnalysis','performanceranalysis','onPerformancerAnalysisCallback')
self:addCallFunc('eCheckATTState','checkATTstate','onCheckATTStateCallback')
self:addCallFunc('eTriggerATT','triggerATT','onTriggerATTCallback')
self:addCallFunc('eLookUpProduct','lookupproduct','onLookUpProductCallback')
self:addCallFunc('eCheckZhuCeState','checkzhucestate','onCheckZhuCeStateCallback')
self:addCallFunc('eZhuCeReward','zhucereward','onZhuCeRewardCallback')
self:addCallFunc('eCuXiaoIPA','cuxiaoIPA','onCuXiaoIPACallback')
self:addCallFunc('eWebView','webview','onWebViewCallback')
self:addCallFunc('eUrlWebView','urlwebview','onUrlwebviewCallback')
self:addCallFunc('eYuanShenTC','yuanshenTC','onYuanShenTCCallback')
self:addCallFunc('eCheckiphonebindstate','checkiphonebindstate','onCheckiphonebindstateCallback')
self:addCallFunc('eIphonebind_sdkwin','iphonebind_sdkwin','onIphonebind_sdkwinCallback')
self:addCallFunc('eIphonebind_getcode','iphonebind_getcode','onIphonebind_getcodeCallback')
self:addCallFunc('eIphonebind_forcode','iphonebind_forcode','onIphonebind_forcodeCallback')
self:addCallFunc('eCheckemailbindstate','checkemailbindstate','onCheckemailbindstateCallback')
self:addCallFunc('eEmailbind_sdkwin','emailbind_sdkwin','onEmailbind_sdkwinCallback')
self:addCallFunc('eEmailbind_getcode','emailbind_getcode','onEmailbind_getcodeCallback')
self:addCallFunc('eEmailbind_forcode','emailbind_forcode','onEmailbind_forcodeCallback')
self:addCallFunc('eCheckaccountbindstate','checkaccountbindstate','onCheckaccountbindstateCallback')
self:addCallFunc('eShowaccountbindwin','showaccountbindwin','OnEfunBindAccount')
self:addCallFunc('eFblinkshare','fblinkshare','onFblinkshareCallback')
self:addCallFunc('eFbimageshare','fbimageshare','onFbimageshareCallback')
self:addCallFunc('eLinelinkshare','linelinkshare','onLinelinkshareCallback')
self:addCallFunc('eLineimageshare','lineimageshare','onLineimageshareCallback')
self:addCallFunc('eWhatsapplinkshare','whatsapplinkshare','onWhatsapplinkshareCallback')
self:addCallFunc('eWhatsappimageshare','whatsappimageshare','onWhatsappimageshareCallback')
self:addCallFunc('eInstagramimageshare','instagramimageshare','onInstagramimageshareCallback')
self:addCallFunc('eDiscordlinkshare','discordlinkshare','onDiscordlinkshareCallback')
self:addCallFunc('eDiscordimageshare','discordimageshare','onDiscordimageshareCallback')
self:addCallFunc('eDiscordtextshare','discordtextshare','onDiscordtextshareCallback')
self:addCallFunc('eDiscordaudioshare','discordaudioshare','onDiscordaudioshareCallback')
self:addCallFunc('eShowplatform','showplatform','onShowplatformCallback')
self:addCallFunc('eCtrl_show_hide_platformbtn','ctrl_show_hide_platformbtn','onCtrl_show_hide_platformbtnCallback')
self:addCallFunc('eShowplatformtaegetwin','showplatformtaegetwin','onShowplatformtaegetwinCallback')
self:addCallFunc('eOpenscan','openscan','onOpenscanCallback')
self:addCallFunc('eOpenactivitypur','openactivitypur','onOpenactivitypurCallback')
self:addCallFunc('eSetPush','settingpush','onSetPushCallback')
self:addCallFunc('eChangeAccount','changeAccount','onChangeAccountCallback')
self:InitCreateOrderUrl()
end

function platformSDK_iOS_EFun_Eu:InitCreateOrderUrl()
platformSDK.printSDK('platformSDK_iOS_EFun_Eu InitCreateOrderUrl')
end


function platformSDK_iOS_EFun_Eu:reqLogin()
platformSDK.printSDK('reqLogin: ',pfwindowslController.initLocalZoneFinish)
if not pfwindowslController.initLocalZoneFinish then
platformSDK.printSDK('大区信息尚未初始化')
return
end
if self.onSwtichLoginData then

platformSDK.printSDK('Call LoginonSwtichLoginData',self.onSwtichLoginData[1],self.onSwtichLoginData[2],self.onSwtichLoginData[3],self.onSwtichLoginData[4])

self:onLoginCallback(self.onSwtichLoginData[1],self.onSwtichLoginData[2],self.onSwtichLoginData[3],self.onSwtichLoginData[4])
self.onSwtichLoginData=nil
return
end
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end


self.isReqLogin=stamp
self:callSDKFunc(iOSSDKCallType.eLogin,'')
end


function platformSDK_iOS_EFun_Eu:reqLogout(callback)

self:reqChangeAccount()

end


function platformSDK_iOS_EFun_Eu:reqVerificationLogin(sdkParams)

if not sdkParams then
platformSDK.printSDK(' Login verification missing parameters')
return
end
loginModel:setUserId(tostring(sdkParams.userId))
local data={}
data.userId=sdkParams.userId
data.event=sdkParams.event
data.accessToken=sdkParams.accessToken
data.sign=sdkParams.sign
data.timestamp=sdkParams.timestamp
pfwindowsModel:setSdkLoginData(data)
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eLoginCheck,info)
platformSDK.printSDK(' Login Verification')
end

local reportTypeToSendType={
[sdkReportEnum.eCreateRoleReport]='1',
[sdkReportEnum.eEnterMainSceneReport]='2',
[sdkReportEnum.eLogoutReport]='3',
[sdkReportEnum.eLevelUpReport]='4',
}


function platformSDK_iOS_EFun_Eu:reqReport(typo,info)
if typo==sdkReportEnum.eCreateRoleReport or
typo==sdkReportEnum.eEnterMainSceneReport or
typo==sdkReportEnum.eLogoutReport or
typo==sdkReportEnum.eLevelUpReport or sdkReportEnum.eLoginReport then
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local data={}
data.rtype=reportTypeToSendType[typo]
data.server_id=playerInfo.json_sid
data.server_name=playerInfo.json_sname
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.party=playerInfo.json_xianmengname
data.party_id='0'
data.vip=playerInfo.json_viplevel
data.role_level=playerInfo.json_level
data.rebirth_time='0'
data.level_up_time=playerInfo.json_time
data.create_role_time=playerInfo.json_createtime
data.user_id=tostring(loginModel.userid)
data.user_name=loginModel.username
if typo==sdkReportEnum.eEnterMainSceneReport or sdkReportEnum.eLoginReport then
data.ordinate="0.5"
data.remark=""
data.keepRightCode="0"
end
if typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
data.ingrained_balance=moneyModel.getMoney(eMoneyType.mtXianYu)
else
data.ingrained_balance=''
end
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eReport,info)
end
if typo==sdkReportEnum.eEnterMainSceneReport then
self:reqWebView()
end
end


function platformSDK_iOS_EFun_Eu:eEfunTrackEvent(eventName)
local playerInfo=platformHelper:getPlayerInfo()

if pfCommonHelper.efunTrackEventName.finishguide==eventName then
local data={}
data.rtype='5'
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.server_id=playerInfo.json_sid
data.role_level=playerInfo.json_level
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eReport,info)
end

local data={}
data.eventName=eventName
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.server_id=playerInfo.json_sid
data.role_level=playerInfo.json_level
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eTrackEvent,info)
end


function platformSDK_iOS_EFun_Eu:reqPerformancerAnalysis(eventName)
local data={}
data.eventName=eventName
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePerformancerAnalysis,info)
end


function platformSDK_iOS_EFun_Eu:reqPay(id,count,params,subscribe)
local playerInfo=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
local data={}
data.product_id=self:getProductIdEx(id)
if not data.product_id or data.product_id==''then
platformSDK.printSDK('No product ID: ',id)
return
end
data.product_price=cfg.rmb
data.currencyCode=pfwindowslController:getPFMoneyType()
data.roleLevel=playerInfo.json_level
data.remark=""
local function httpCallBack(message,err)
platformSDK.printSDK('Request for remark returned: ',message)
if err==""or not err then
local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
local content='Request for remark failed'
UIManager.info(content)
return
end
end
if json_table.data then
data.remark=json_table.data.remark or""
platformSDK.printSDK('remark value: ',data.remark)
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePay,info)
end
end
end
local curLocalZone=pfwindowslController:getLocalZone()
local tempcreateOrderUrl=enterInfo[curLocalZone].createOrderUrl

local createOrderUrl=FMT.fmt(tempcreateOrderUrl,loginModel:getPfname())
local userid=tostring(loginModel.userid)
local actorId=tostring(playerModel:getActorID()or'')
local enterGameState=gameState.isEnter()
local level=enterGameState and zongmenModel:getLevel()or 1
local sid=tostring(loginModel.be_server_id or 0)
local attachParams=params and params~=''and base64.enc(string.encodeURI(params))or''
local urlStr=FMT.fmt('{0}account={1}&actorId={2}&actorLevel={3}&sid={4}&payIndex={5}&param={6}&productId={7}',createOrderUrl,userid,actorId,level,sid,id,attachParams,data.product_id)
platformSDK.printSDK('Requesting remarkurlStr: ',urlStr)
_httpGetRequest(urlStr,httpCallBack)

end


function platformSDK_iOS_EFun_Eu:reqPlayAD(adid,attach,callback)







end



function platformSDK_iOS_EFun_Eu:reqLookUpProduct()
local data={}
data.productIDList={}
local productId=self:getProductIdEx(1)
data.productIDList[1]=productId
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eLookUpProduct,info)
end




function platformSDK_iOS_EFun_Eu:reqShareImage(path,shareType,platform)
platformSDK.printSDK('req_shareImage platformSDK_iOS_EFun_Eu',path,shareType,platform)
if path==nil then return end
local ud={}
ud.shareImagepath=path
ud.shareType=shareType
ud.platform=platform
local callType
if platform=="line"then
callType=iOSSDKCallType.eLineimageshare
elseif platform=="fb"then
callType=iOSSDKCallType.eFbimageshare
elseif platform=="Discord"then
callType=iOSSDKCallType.eDiscordimageshare
end
if not callType then
platformSDK.printSDK('req_shareImage not callType')
return
end
local jsonStr=jsonHelper.encode(ud)
jsonStr=string.gsub(jsonStr,"\\/","/")
self:callSDKFunc(callType,jsonStr)
platformSDK.printSDK('req_shareImage platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:getEfunBindState()
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eCheckiphonebindstate,jsonStr)
platformSDK.printSDK('getEfunBindState platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:getPhoneCaptcha(phoneNumber)
local data={}
data.phoneNumber=phoneNumber
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eIphonebind_getcode,jsonStr)
platformSDK.printSDK('getPhoneCaptcha platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:reqPhoneBind(phoneNumber,captchaCode)
local data={}
data.phoneNumber=phoneNumber
data.phoneAuth=captchaCode
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eIphonebind_forcode,jsonStr)
platformSDK.printSDK('reqPhoneBind platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:showEfunOpenScan()
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eOpenscan,jsonStr)
platformSDK.printSDK('showEfunOpenScan platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:reqTriggerAtt(triggerName)
local data={}
data.triggerName=triggerName
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eTriggerATT,jsonStr)
platformSDK.printSDK('reqTriggerAtt platformSDK_iOS_EFun_Eu',triggerName)
end


function platformSDK_iOS_EFun_Eu:reqPingLun()
if verifyManager:isOpen()then
return
end
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eYuanShenTC,jsonStr)
platformSDK.printSDK('reqPingLun platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:reqWebView()
if verifyManager:isOpen()then
return
end
local data={}
local playerInfo=platformHelper:getPlayerInfo()
data.roleLevel=playerInfo.json_level
data.vipLevel=playerInfo.json_viplevel
data.loadUrl="nil"
data.level="level"
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eWebView,jsonStr)
platformSDK.printSDK('reqWebView platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:reqChangeAccount()

local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eChangeAccount,jsonStr)
platformSDK.printSDK('reqChangeAccount platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:reqCustomerService()
local data={}
data.type=2
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eShowplatformtaegetwin,jsonStr)
platformSDK.printSDK('reqCustomerService platformSDK_iOS_EFun_Eu')
end


function platformSDK_iOS_EFun_Eu:reqBindAccount()
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eShowaccountbindwin,jsonStr)
platformSDK.printSDK('reqBindAccount platformSDK_iOS_EFun_Eu')
end



function platformSDK_iOS_EFun_Eu:onLoginCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then

pfwindowslController:setHWLocalRegionName("USD")
local data=jsonHelper.decode(result)
local phpParams={}
data.username="None"
phpParams.token=data.sessionToken


platformSDK.printSDK('登入資訊__刷新 LoginCallBack platformSDK_iOS_EFun_Eux',data.loginType)
pfwindowslController.setMacPlayer(data.loginType)
if loginModel.isLogin then
loginModel:onfreshLoginInfo(data,phpParams,"")
platformSDK.printSDK('登入資訊__刷新 LoginCallBack platformSDK_iOS_EFun_Eu')
else
loginModel:onLogin(data,phpParams,"")
platformSDK.printSDK('登入__成功 LoginCallBack platformSDK_iOS_EFun_Eu')
end
loginControl:requestVerifyLastServerList()
self:checkLoginTime()
else
platformSDK.printSDK('Login__Failed',result)
end
end


function platformSDK_iOS_EFun_Eu:onChangeAccountCallback(id,ftype,success,result)
if success then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if not win then
loginState:logout()
end
self.onSwtichLoginData={id,ftype,success,result}

else
platformSDK.printSDK('切换账号失敗',result)
end
end

function platformSDK_iOS_EFun_Eu:onLogoutCallback(id,ftype,success,result)
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

function platformSDK_iOS_EFun_Eu:onPayCallback(id,ftype,success,result)
if success then
if verifyManager:isHideBindAccount()then
return
end
if pfwindowslController.getMacPlayer()then
pfwindowslController:reqAccountBind_OuMei()
end
end
end

function platformSDK_iOS_EFun_Eu:onPlayADCallback(id,ftype,success,result)

end


function platformSDK_iOS_EFun_Eu:onLookUpProductCallback(id,ftype,success,result)
if success then
local data=jsonHelper.decode(result)
local productId=self:getProductIdEx(1)
if data and data[productId]then
local info=data[productId]
local LocalRegionName=info.currencyCode
pfwindowslController:setHWLocalRegionName(LocalRegionName)
platformSDK.printSDK('Region Return Successful',LocalRegionName)
else
platformSDK.printSDK('Region Return Successful: No Data in Result ',productId)
end

end
end



function platformSDK_iOS_EFun_Eu:onCheckiphonebindstateCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
local isBindAccount=success
local isBindPhone=success
local isBindThirdPlatform=success
pfwindowslController:setPhoneBindState(isBindAccount,isBindPhone,isBindThirdPlatform)
platformSDK.printSDK('Check Binding Info Status Return',isBindAccount,isBindPhone,isBindThirdPlatform)
end


function platformSDK_iOS_EFun_Eu:onIphonebind_getcodeCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
platformSDK.printSDK('Mobile-binding verification code returned',success,data)
if data.code=="e1000"then
pfwindowslController:getPhoneCaptchaCallBack(true)
else
pfwindowslController:getPhoneCaptchaCallBack(false)
end
platformSDK.printSDK('onIphonebind_getcodeCallback',success,data.code,data.message)
end


function platformSDK_iOS_EFun_Eu:onIphonebind_forcodeCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
platformSDK.printSDK('Mobile-binding verification code returned',success,data)
if data.code=="e1000"then
pfwindowslController:setBindPhone(true)
else
pfwindowslController:setBindPhone(false)
end
end


function platformSDK_iOS_EFun_Eu:onOpenscanCallback(id,ftype,success,result)
platformSDK.printSDK('Scan QR code with mobile phone')
end



function platformSDK_iOS_EFun_Eu:getProductIdEx(id)
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

function platformSDK_iOS_EFun_Eu:onYuanShenTCCallback(id,ftype,success,result)
platformSDK.printSDK('Original Comment Popup - Return')







end

function platformSDK_iOS_EFun_Eu:OnEfunBindAccount(id,ftype,success,result)
platformSDK.printSDK('OnEfunBindAccount',success)
if success then
pfwindowslController:setBindAccount_OM(true)
else
pfwindowslController:setBindAccount_OM(false)
end
end



function platformSDK_iOS_EFun_Eu:checkLoginTime()
local timeStamp=userGlobalSetting.get("eFunLoginTime",0)
local curTimeStamp=os.time()
local curtime=os.date('!*t',curTimeStamp)
local time=os.date('!*t',timeStamp)
platformSDK.printSDK('checkLoginTime111',curtime.year,curtime.month,curtime.day,time.year,time.month,time.day)
if curtime.year~=time.year or
curtime.month~=time.month or
curtime.day~=time.day
then
platformSDK.printSDK('checkLoginTime2222',curTimeStamp)
userGlobalSetting.set("eFunLoginTime",curTimeStamp)
userGlobalSetting.flush()
platformSDK.printSDK('checkLoginTime3333')
if timeStamp~=0 then
platformSDK.printSDK('checkLoginTime44444')
self:reqTriggerAtt("next_day_login")
end
end
end


local this
local url="https://mgr-tms.movergames.com/gm/game/chat/transformSensitiveWords"
local gamecode="twzqzs"
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


function platformSDK_iOS_EFun_Eu:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
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
local type=tostring(chatModel.channelId)or"100"
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
platformSDK.printSDK("reqMsgSecChecksign1：,",CS.LuaHelper.GetMD5UTF8(sign))
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



function platformSDK_iOS_EFun_Eu.onreMsgSecCheck(args)
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


function platformSDK_iOS_EFun_Eu:reqOpenURL(url)
LuaApplication.GetApplication().OpenURL(url)
end
