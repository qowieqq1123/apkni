

platformSDK_PC_Efun_OuMei=simple_class(platformSDK_None)

local cjson=require'cjson'

local _WindowsHelper=CS.EfunPCHelper
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString


local enterInfo=
{
[pfLocalZoneType.EU]=
{
infoUrl="https://euzqzs-eu-logpy.efunsea.com/euzqzspc/api/getpfinfo",
logUploadURL_Release="https://euzqzs-eu-report.efunsea.com/report",
gameId=9151,
createOrderUrl="https://euzqzs-eu-logpy.efunsea.com/{0}/payment/createorder?"
},
[pfLocalZoneType.NA]=
{
infoUrl="https://euzqzs-us-logpy.efunsea.com/nazqzspc/api/getpfinfo",
logUploadURL_Release="https://euzqzs-us-report.efunsea.com/report",
gameId=9152,
createOrderUrl="https://euzqzs-us-logpy.efunsea.com/{0}/payment/createorder?"
},
}

function platformSDK_PC_Efun_OuMei:getEnterInfo()
return enterInfo
end


local EFUN_PC_PfName=
{
EFUN="EFUN",
STEAM="STEAM",
GOOGLE="GOOGLE",
}

local payhannel=
{
EFUN=0,
google=1,
STEAM=2,
}
local pcPfName=EFUN_PC_PfName.EFUN

local _GetResourceVersion=CS.AppDataModel.GetResourceVersion


local LoginData

local createOrderUrl="https://euzqzs-eu-logpy.efunsea.com/{0}/payment/createorder?"
function platformSDK_PC_Efun_OuMei:__init(...)
platformSDK.printSDK("platformSDK_PC_WeGame:__init11")
self.secCheckCBDict={}
pcPfName=_appConfig_GetString('EFUN_PC_PfName','EFUN')
local cb=function(funcName,jsonStr)
platformSDK.printSDK('callBackFunc：',funcName,jsonStr)
local json=cjson.decode(jsonStr);
local cbTarget=self[funcName];
if cbTarget~=nil then
cbTarget(self,json,jsonStr);
end
end
local version=_GetResourceVersion()

_WindowsHelper.SetCallbacks(cb);
version=fileHelper.replaceencodefun(version)
_WindowsHelper.Init(version)
end



function platformSDK_PC_Efun_OuMei:reqLogin()
if not pfwindowslController.initLocalZoneFinish then
platformSDK.printSDK('大区信息尚未初始化')
return
end
_WindowsHelper.ExecCmd("reqLogin","")
end




function platformSDK_PC_Efun_OuMei:reqVerificationLogin(sdkParams)
if not sdkParams then
platformSDK.printSDK(' 登錄校驗沒參數')
return
end
local data={}
data.userId=sdkParams.userId
data.event=sdkParams.event
data.expired=sdkParams.expired
data.accessToken=sdkParams.accessToken
data.sign=sdkParams.sign
data.timestamp=sdkParams.timestamp
local jsonStr=jsonHelper.encode(data)
platformSDK.printSDK(' reqVerificationLogin1：',jsonStr)
_WindowsHelper.ExecCmd("reqVerificationLogin",jsonStr)
end






function platformSDK_PC_Efun_OuMei:reqLogout()
_WindowsHelper.ExecCmd("reqLogout","")
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
loginState:logout()
end
platformSDK.printSDK('reqLogout1：')
end





function platformSDK_PC_Efun_OuMei:reqPay(id,count,params,subscribe)
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
info.json_currency=pfwindowslController:getPFMoneyType()
info.json_PChannel=payhannel.EFUN
if pcPfName==EFUN_PC_PfName.STEAM then
info.json_PChannel=payhannel.STEAM
elseif pcPfName==EFUN_PC_PfName.GOOGLE then
info.json_PChannel=payhannel.google
end
local function httpCallBack(message,err)
platformSDK.printSDK('請求remark返回:',message)
if err==""or not err then
local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
local content='請求remark失敗'
UIManager.info(content)
return
end
end
if json_table.data then
info.json_attach=json_table.data.remark or""
platformSDK.printSDK('remark的值:',info.json_attach)

local jsonStr=jsonHelper.encode(info)
_WindowsHelper.ExecCmd("Pay",jsonStr)
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
platformSDK.printSDK('請求remarkurlStr:',urlStr)
_httpGetRequest(urlStr,httpCallBack)
end



function platformSDK_PC_Efun_OuMei:eEfunTrackEvent(eventName)
local data=platformHelper:getPlayerInfo()
data.json_eventName=eventName
local jsonStr=jsonHelper.encode(data)
_WindowsHelper.ExecCmd("funTrackEvent",jsonStr)
end


function platformSDK_PC_Efun_OuMei:getEfunBindState()
local data=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(data)
_WindowsHelper.ExecCmd("checkEfunBind",jsonStr)
end




function platformSDK_PC_Efun_OuMei:getPhoneCaptcha(phoneNumber)
local data=platformHelper:getPlayerInfo()
data.json_phoneNumber=phoneNumber
local jsonStr=jsonHelper.encode(data)
_WindowsHelper.ExecCmd("PhoneCaptcha",jsonStr)
end


function platformSDK_PC_Efun_OuMei:reqPhoneBind(phoneNumber,captchaCode)
local data=platformHelper:getPlayerInfo()
data.json_phoneNumber=phoneNumber
data.json_captchaCode=captchaCode
local jsonStr=jsonHelper.encode(data)
_WindowsHelper.ExecCmd("reqPhoneBind",jsonStr)
end




function platformSDK_PC_Efun_OuMei:onEfunBindInfo(json,jsonStr)
local info=json.jsonStr
local isBindPhone=false
if info.code=="1"or info.code==1 then
isBindPhone=info.isBindPhone=="true"
end
platformSDK.printSDK('綁定資訊返回成功',isBindPhone)
pfwindowslController:setPhoneBindState(false,isBindPhone,false)
end



function platformSDK_PC_Efun_OuMei:onPhoneCaptchaCallBack(json,jsonStr)
local info=json.jsonStr
if info.code=="e1000"then
pfwindowslController:getPhoneCaptchaCallBack(true)
else
pfwindowslController:getPhoneCaptchaCallBack(false)
end
platformSDK.printSDK('請求驗證碼')
end



function platformSDK_PC_Efun_OuMei:onReqPhoneBindCallBack(json,jsonStr)
local info=json.jsonStr
platformSDK.printSDK('請求綁定手機返回',info.msg)
if info.code=="e1000"then
pfwindowslController:setBindPhone(true)
else
pfwindowslController:setBindPhone(false)
end
end



function platformSDK_PC_Efun_OuMei:reqReport(typo,info)
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local sex=playerModel:getActorSex()or'0'
playerInfo.json_sex=sex
playerInfo.json_vocname=1
local str=cjson.encode(playerInfo)
platformSDK.printSDK("platformSDK_PC_WeGame:reqReport",typo)
if typo==sdkReportEnum.eCreateRoleReport then
_WindowsHelper.ExecCmd("PortCreateCharacter",str)
elseif typo==sdkReportEnum.eLevelUpReport then
_WindowsHelper.ExecCmd("PortRoleUpLv",str)
elseif typo==sdkReportEnum.eLoginReport then
_WindowsHelper.ExecCmd("PortEnterGame",str)

elseif typo==sdkReportEnum.eExitGameReport then
_WindowsHelper.ExecCmd("PortExitGame",str)
end
local zmLV=zongmenModel:getLevel()or 1
if typo==sdkReportEnum.eEnterMainSceneReport and zmLV>=1 then
_WindowsHelper.ExecCmd("showOpenWebPage",str)
end
end


function platformSDK_PC_Efun_OuMei:reqFangChenMi()

end


function platformSDK_PC_Efun_OuMei:onPay(json,jsonStr)

local info=json.jsonStr
local result=info.result
local code=info.code

if code=="1000"then
UIManager.info("Recharge successful")
elseif code=="2000"then

else
UIManager.info(string.format("code:%s , message:%s",code,info.msg))
end
end


function platformSDK_PC_Efun_OuMei:LoginCallBack(json,jsonStr)
LoginData=json
self:LoginHandle(json,jsonStr)
end


function platformSDK_PC_Efun_OuMei:LoginHandle(json,jsonStr)
local info=json.jsonStr
local code=info.result
platformSDK.printSDK('登入:',code)
if code=="1000"or code==1000 then
local phpParams={}
info.username="無"
phpParams.token=info.token



if loginModel.isLogin then
loginModel:onfreshLoginInfo(info,phpParams,"")
platformSDK.printSDK('登入資訊__刷新 platformSDK_PC_Efun_OuMei')
else
loginModel:onLogin(info,phpParams,"")
platformSDK.printSDK('登入__成功 platformSDK_PC_Efun_OuMei',deviceHelper.getRuntimePlatformStr())

socketManager:closeDialogue()
end
elseif code=="9999"or code==9999 then
UIManager.info("取消登入")
platformSDK.printSDK('取消登入:',code)
else
UIManager.info(FMT.fmt("登錄異常：{0}",code))
platformSDK.printSDK('登入異常:',code)
end
end


function platformSDK_PC_Efun_OuMei:LogoutCallBack(json,jsonStr)
local info=json.jsonStr
local result=info.result
if result==true or result=="true"then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
loginState:logout()
end
end
end



function platformSDK_PC_Efun_OuMei:PurchasePaymentResult()

end


function platformSDK_PC_Efun_OuMei:OnApplicationQuit()
local showdata=
{
type='UIDialouge',
title='溫馨提示',
content="確定退出遊戲",
oktext='確認',
canceltext='取消',
okcallback=function(...)
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
loginControl:reportExitGame()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function platformSDK_PC_Efun_OuMei:reqApplicationQuit_PC()
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end


function platformSDK_PC_Efun_OuMei:reqVerificationLogin(sdkParams)
if not sdkParams then
platformSDK.printSDK(' 登錄校驗沒參數')
return
end
platformSDK.printSDK(' 登錄校驗沒參數11：',tostring(sdkParams.userId))
loginModel:setUserId(tostring(sdkParams.userId))
local data={}
data.userId=sdkParams.userId
data.event=sdkParams.event
data.expired=sdkParams.expired
data.accessToken=sdkParams.accessToken
data.sign=sdkParams.sign
data.timestamp=sdkParams.timestamp
pfwindowsModel:setSdkLoginData(data)
local jsonStr=jsonHelper.encode(data)
_WindowsHelper.ExecCmd("reqVerificationLogin",jsonStr)

if pcPfName==EFUN_PC_PfName.GOOGLE then

if self:reqEfunCheckGoogleOAuth()then
UIManager:showWindow('UIGoogleOneWin',{winState=1})

return
end
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


function platformSDK_PC_Efun_OuMei:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
if not this then
this=self
end
local curid=AddIndex_()
self.secCheckCBDict[curid]=callback
local PJcontent=string.format("%s|%s|%s",curid,content,scene)
local info=platformHelper:getPlayerInfo()

local type=tostring(chatModel.channelId)or"100"
local sign=gamecode..type..info.json_roleid..PJcontent..info.json_sid

if to_PrivatePlayerData then
info.to_roleid=tostring(to_PrivatePlayerData.actorId)
info.to_rolename=tostring(to_PrivatePlayerData.actorName)
sign=gamecode..type..info.json_roleid..info.to_roleid..PJcontent..info.json_sid
end

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



function platformSDK_PC_Efun_OuMei.onreMsgSecCheck(args)
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
UIManager.error('消息發送失敗')
platformSDK.printSDK("onreMsgSecCheck2：",info.message)
end
end




function platformSDK_PC_Efun_OuMei:reqEfunCheckGoogleOAuth()
return _WindowsHelper._EfunCheckGoogleOAuth()
end



function platformSDK_PC_Efun_OuMei:reqEfunGoogleOAuthBegin()
_WindowsHelper._EfunGoogleOAuthBegin()
end


function platformSDK_PC_Efun_OuMei:reqEfunGoogleReOAuthBegin()
_WindowsHelper._EfunGoogleReOAuthBegin()
end



function platformSDK_PC_Efun_OuMei:reqGoogleOAuthCompleteState()
_WindowsHelper._EfunGetGoogleOAuthCompleteState()
end


function platformSDK_PC_Efun_OuMei:onGoogleOAuthCompleteStateCB(json,jsonStr)
local info=json.jsonStr
local code=info.code
platformSDK.printSDK('查詢是否已授權返回:',code)

UIManager:closeWindow('UIGoogleOneWin')
if code=="1"then
UIManager.info('授權成功')
else

UIManager:showWindow('UIGooglePayWin',{winState=2,Msg=info.msg,Code=code,GoogleOAuth=true})
end
end


function platformSDK_PC_Efun_OuMei:EfunGoogleVerifyOrder()
_WindowsHelper._EfunGoogleVerifyOrder()
end


function platformSDK_PC_Efun_OuMei:onEfunGoogleVerifyOrderCB(json,jsonStr)
local info=json.jsonStr
local code=info.code
platformSDK.printSDK('驗單返回:',code)
if code=="1000"then

UIManager:closeWindow('UIGooglePayWin')
else
UIManager:showWindow('UIGooglePayWin',{winState=2,Msg=info.msg,Code=code})
end
end





function platformSDK_PC_Efun_OuMei:reqCustomerService()
local typeStr=HWandroidReqType.eShowCustomServer
local playerInfo=platformHelper:getPlayerInfo()
local jsonStr=jsonHelper.encode(playerInfo)
_WindowsHelper.ExecCmd(typeStr,jsonStr)
end