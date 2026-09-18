

platformSDK_iOS_EFun=simple_class(platformSDK_iOS)

local _httpGetRequest=CS.ResourceHelper.HttpGetRequest
local createOrderUrl="https://twzqzs-logpy.movergames.com/{0}/payment/createorder?"

function platformSDK_iOS_EFun:__init(...)
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
self:addCallFunc('eShowaccountbindwin','showaccountbindwin','onShowaccountbindwinCallback')
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
end


function platformSDK_iOS_EFun:reqLogin()
platformSDK.printSDK('調用登錄',self.isReqLogin)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end


self.isReqLogin=stamp
self:callSDKFunc(iOSSDKCallType.eLogin,'')
end


function platformSDK_iOS_EFun:reqLogout(callback)
self:callSDKFunc(iOSSDKCallType.eLogout,'')
end


function platformSDK_iOS_EFun:reqVerificationLogin(sdkParams)

if not sdkParams then
platformSDK.printSDK(' 登录校验没参数')
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
platformSDK.printSDK(' 登录校验')
end

local reportTypeToSendType={
[sdkReportEnum.eCreateRoleReport]='1',
[sdkReportEnum.eEnterMainSceneReport]='2',
[sdkReportEnum.eLogoutReport]='3',
[sdkReportEnum.eLevelUpReport]='4',
}


function platformSDK_iOS_EFun:reqReport(typo,info)
if typo==sdkReportEnum.eCreateRoleReport or
typo==sdkReportEnum.eEnterMainSceneReport or
typo==sdkReportEnum.eLogoutReport or
typo==sdkReportEnum.eLevelUpReport then
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
if typo==sdkReportEnum.eEnterMainSceneReport then
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
if data.role_level=='4'and typo==sdkReportEnum.eLevelUpReport then
self:reqTriggerAtt("finishguide")
end
end
if typo==sdkReportEnum.eEnterMainSceneReport then
self:reqWebView()
end
end


function platformSDK_iOS_EFun:eEfunTrackEvent(eventName)
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


function platformSDK_iOS_EFun:reqPerformancerAnalysis(eventName)
local data={}
data.eventName=eventName
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePerformancerAnalysis,info)
end


function platformSDK_iOS_EFun:reqPay(id,count,params,subscribe)
local playerInfo=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
local data={}
data.product_id=self:getProductIdEx(id)
if not data.product_id or data.product_id==''then
platformSDK.printSDK('没有产品id:',id)
return
end
data.product_price=cfg.rmb
data.currencyCode=pfwindowslController:getPFMoneyType()
data.roleLevel=playerInfo.json_level
data.remark=""
local function httpCallBack(message,err)
platformSDK.printSDK('请求remark返回:',message)
if err==""or not err then
local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
local content='请求remark失败'
UIManager.info(content)
return
end
end
if json_table.data then
data.remark=json_table.data.remark or""
platformSDK.printSDK('remark的值:',data.remark)
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePay,info)
end
end
end
createOrderUrl=FMT.fmt(createOrderUrl,loginModel:getPfname())
local userid=tostring(loginModel.userid)
local actorId=tostring(playerModel:getActorID()or'')
local enterGameState=gameState.isEnter()
local level=enterGameState and zongmenModel:getLevel()or 1
local sid=tostring(loginModel.be_server_id or 0)
local attachParams=params and params~=''and base64.enc(string.encodeURI(params))or''
local urlStr=FMT.fmt('{0}account={1}&actorId={2}&actorLevel={3}&sid={4}&payIndex={5}&param={6}&productId={7}',createOrderUrl,userid,actorId,level,sid,id,attachParams,data.product_id)
platformSDK.printSDK('请求remarkurlStr:',urlStr)
_httpGetRequest(urlStr,httpCallBack)

end


function platformSDK_iOS_EFun:reqPlayAD(adid,attach,callback)







end



function platformSDK_iOS_EFun:reqLookUpProduct()
local data={}
data.productIDList={}
local productId=self:getProductIdEx(1)
data.productIDList[1]=productId
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eLookUpProduct,info)
end




function platformSDK_iOS_EFun:reqShareImage(path,shareType,platform)
platformSDK.printSDK('req_shareImage platformSDK_iOS_EFun',path,shareType,platform)
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
platformSDK.printSDK('req_shareImage platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:getEfunBindState()
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eCheckiphonebindstate,jsonStr)
platformSDK.printSDK('getEfunBindState platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:getPhoneCaptcha(phoneNumber)
local data={}
data.phoneNumber=phoneNumber
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eIphonebind_getcode,jsonStr)
platformSDK.printSDK('getPhoneCaptcha platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:reqPhoneBind(phoneNumber,captchaCode)
local data={}
data.phoneNumber=phoneNumber
data.phoneAuth=captchaCode
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eIphonebind_forcode,jsonStr)
platformSDK.printSDK('reqPhoneBind platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:showEfunOpenScan()
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eOpenscan,jsonStr)
platformSDK.printSDK('showEfunOpenScan platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:reqTriggerAtt(triggerName)
local data={}
data.triggerName=triggerName
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eTriggerATT,jsonStr)
platformSDK.printSDK('reqTriggerAtt platformSDK_iOS_EFun',triggerName)
end


function platformSDK_iOS_EFun:reqPingLun()
if verifyManager:isOpen()then
return
end
local data={}
local jsonStr=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eYuanShenTC,jsonStr)
platformSDK.printSDK('reqPingLun platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:reqWebView()
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
platformSDK.printSDK('reqWebView platformSDK_iOS_EFun')
end


function platformSDK_iOS_EFun:onLoginCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
self:reqLookUpProduct()
local data=jsonHelper.decode(result)
local phpParams={}
data.username="無"
phpParams.token=data.sessionToken


if loginModel.isLogin then
loginModel:onfreshLoginInfo(data,phpParams,"")
platformSDK.printSDK('登入資訊__刷新 LoginCallBack platformSDK_iOS_EFun')
else
loginModel:onLogin(data,phpParams,"")
platformSDK.printSDK('登入__成功 LoginCallBack platformSDK_iOS_EFun')
end
loginControl:requestVerifyLastServerList()
self:checkLoginTime()
else
platformSDK.printSDK('登入__失敗',result)
end
end

function platformSDK_iOS_EFun:onLogoutCallback(id,ftype,success,result)
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

function platformSDK_iOS_EFun:onPayCallback(id,ftype,success,result)

end

function platformSDK_iOS_EFun:onPlayADCallback(id,ftype,success,result)

end


function platformSDK_iOS_EFun:onLookUpProductCallback(id,ftype,success,result)
if success then
local data=jsonHelper.decode(result)
local productId=self:getProductIdEx(1)
if data and data[productId]then
local info=data[productId]
local LocalRegionName=info.currencyCode
pfwindowslController:setHWLocalRegionName(LocalRegionName)
platformSDK.printSDK('地区返回成功',LocalRegionName)
else
platformSDK.printSDK('地区返回成功 result 没有数据 ',productId)
end

end
end



function platformSDK_iOS_EFun:onCheckiphonebindstateCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
local isBindAccount=success
local isBindPhone=success
local isBindThirdPlatform=success
pfwindowslController:setPhoneBindState(isBindAccount,isBindPhone,isBindThirdPlatform)
platformSDK.printSDK('查看绑定信息状态返回',isBindAccount,isBindPhone,isBindThirdPlatform)
end


function platformSDK_iOS_EFun:onIphonebind_getcodeCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
platformSDK.printSDK('手机绑定验证码返回',success,data)
if data.code=="e1000"then
pfwindowslController:getPhoneCaptchaCallBack(true)
else
pfwindowslController:getPhoneCaptchaCallBack(false)
end
platformSDK.printSDK('onIphonebind_getcodeCallback',success,data.code,data.message)
end


function platformSDK_iOS_EFun:onIphonebind_forcodeCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
platformSDK.printSDK('手机验证码绑定返回',success,data)
if data.code=="e1000"then
pfwindowslController:setBindThirdPlatform(true)
else
pfwindowslController:setBindThirdPlatform(false)
end
end


function platformSDK_iOS_EFun:onOpenscanCallback(id,ftype,success,result)
platformSDK.printSDK('手机进行扫码')
end



function platformSDK_iOS_EFun:getProductIdEx(id)
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

function platformSDK_iOS_EFun:onYuanShenTCCallback(id,ftype,success,result)
platformSDK.printSDK('原生评论弹窗 返回')
timeEventController.delayDo(1,function()
userActorSetting.set("haoPingYouLi",haoPingYouLiTypeEnum.eClickURL)
userActorSetting.flush()
UIManager:invokeUIMethod("UIHaoPingYouLiWin","refreshBtnState")
UIManager:invokeUIMethod("UIHaoPingYouLiPopupWin","refreshBtnState")
pfwindowslController:receiveHaoPingReward()
end)
end

function platformSDK_iOS_EFun:checkLoginTime()
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


function platformSDK_iOS_EFun:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
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



function platformSDK_iOS_EFun.onreMsgSecCheck(args)
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
UIManager.error('消息發送失敗')
platformSDK.printSDK("onreMsgSecCheck2：",info.message)
end
end


function platformSDK_iOS_EFun:reqOpenURL(url)
LuaApplication.GetApplication().OpenURL(url)
end
