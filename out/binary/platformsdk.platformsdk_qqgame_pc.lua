







platformSDK_qqGame_PC=simple_class(platformSDK_None)

local cjson=require'cjson'

local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _ExecuteReflection=CS.QQHelper.ExecuteReflection;
local _ExecCmd=CS.QQHelper.ExecCmd;
local _HttpGetRequest=CS.ResourceHelper.HttpGetRequest;
local _HttpPostJsonRequest=CS.ResourceHelper.HttpJsonPostRequest;
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt;
local _SetCallbacks=CS.QQHelper.SetCallbacks;
local stringf=string.format


local ExecCmdFuncName={
OpenUrl="OpenUrl",
OpenHallWeb="OpenHallWeb",
}

local ExecuteReflectionFuncName={
OpenID="OpenID",
OpenKey="OpenKey",
pfKey="pfKey"
}


local hallWeb="qqgameprotocol:///openembedwebdialog Caption= Width=690 Height=590 New=1 Url="

local midashiqqgameAppURL="https://qqgame.qq.com/midaspay/?param=%s"
local qqgameVipURL="https://gamevip.qq.com/?ADTAG=VIP.WEB.BWZX"
local appID=102382319
local appKey="bBj4E9pgJhx1uYx7"
local gameid=12617
local newgameID="newgame1703"
local openID=nil
local openKey=nil
local pfkey=nil

local releasephpPayUrl='https://logpyzqzs.xw66.top/qqdtzs/payment/createorder?'

local privacyMsgUrl="https://logpyzqzs.xw66.top/qqdtzs/api/uicFilter?openid=%s&open_key=%s&content=%s&source=%s"

local ExtendTimeUrl="https://logpyzqzs.xw66.top/qqdtzs/api/extendOpenKey?openid=%s&open_key=%s"

local reportUrl="https://logpyzqzs.xw66.top/qqdtzs/api/reportData?actionid=%s&actorId=%s&account=%s&actorLevel=%s&userOnlineTime=%s&appid=%s&app_id=%s"

local test=0

local qqgameReportURL="https://tglogsz.datamore.qq.com/webgame/report/"
local qqgameReportKeySign="webgame@2019J5v6ByRT"
local NormalRootURL="http://yjzxlogpy.xw66.top/qqgame/api"

local seq_id=0

local retry_times=0
local TIME_DELAY=1
local delay_timer=nil
local requestData={}
local retryData={}
local req_php_logintoken_Timer
local sanbox=0
platformSDK_qqGame_PC.CustomFuncs={}



local openUrl=function(url)
_ExecCmd(ExecCmdFuncName.OpenUrl,url)
end



local openWebHallByParam=function(param)
local url=stringf(midashiqqgameAppURL,param)
platformSDK.printSDK(stringf('openWebHallByParam:%s',url))
if test==1 then
local tempurl="start \"\" \"qqgameprotocol:///openembedwebdialog Caption= Width=690 Height=590 New=1 Url="
os.execute(tempurl..url)
return
elseif test==2 then
_ExecCmd(ExecCmdFuncName.OpenHallWeb,hallWeb..url)
return
end
_ExecCmd(ExecCmdFuncName.OpenUrl,hallWeb..url)
end

local SDKQYCallBackFuncs=
{
['ProcessExit']={callBackFunc='ProcessExitCallBack'},
['OnApplicationQuit']={callBackFunc='OnApplicationQuitCallBack'},
}



function platformSDK_qqGame_PC:__init(...)
local cb=function(funcName,jsonStr)
local json=cjson.decode(jsonStr);
local cbTarget=SDKQYCallBackFuncs[funcName];
if cbTarget~=nil then
self[cbTarget.callBackFunc](self,json,jsonStr);
end
end

_SetCallbacks(cb);
test=_AppConfig_GetInt('test',test)


qqgameReportURL=_AppConfig_GetString('qqgameReportURL',qqgameReportURL)
qqgameReportKeySign=_AppConfig_GetString('qqgameReportKeySign',qqgameReportKeySign)


platformSDK_qqGame_PC.CustomFuncs['StartBeat']={callBackFunc='StartBeat'}
local CheckCallback=function()
if loginModel.userid and loginModel.server_id then
_HttpGetRequest(stringf(ExtendTimeUrl,openID,openKey))
end
end
if not req_php_logintoken_Timer then
req_php_logintoken_Timer=timer.new()
req_php_logintoken_Timer:start(3600,CheckCallback)
end
end





function platformSDK_qqGame_PC:reqLogin()
platformSDK.printSDK("platformSDK_qqGame_PC:req_login")
openID=_ExecuteReflection(ExecuteReflectionFuncName.OpenID,"")
openKey=_ExecuteReflection(ExecuteReflectionFuncName.OpenKey,"")
pfkey=_ExecuteReflection(ExecuteReflectionFuncName.pfKey,"")
local params={};
params.open_key=openKey;
params.openid=openID;
params.username=openID;
params.uid=openID;

if loginModel.isLogin then
if params.username~=loginModel.username then
loginControl:loginout()
logErr(string.format('账号异常登陆回调刷新 账号不匹配 旧账号：%s  刷新账号：%s',loginModel.username,params.username))
return
end
loginModel:onfreshLoginInfo(params,params,openID)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_Android_XingJia')
else
loginModel:onLogin(params,params,openID)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_Android_XingJia')

socketManager:closeDialogue()
end
end

function platformSDK_qqGame_PC:getopenid()
return openID or""
end

function platformSDK_qqGame_PC:getopenkey()
return openKey or""
end


function platformSDK_qqGame_PC:req_logout(finishCallback)
platformSDK.printSDK("platformSDK_qqGame_PC:req_logout")
loginModel.isLogin=false;

end


function platformSDK_qqGame_PC:reqPay(id,count,params,subscribe)
platformSDK.printSDK("platformSDK_qqGame_PC:req_pay",id)



local function http_callback(message,err)
platformSDK.printSDK('请求创建订单返回:',message,err)
if err==""or not err then
local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=cjson.decode(message)
end)

if not s then

local content='网络波动,请稍后重试'
UIManager.info(content)
return
end
end
local ret=json_table.ret
if ret==0 then
local param=
{
action="buy",
goodstokenurl=json_table.url_params,
appid=appID,
openid=openID,
openkey=openKey,
sandbox=sanbox,
}
local tempparam=string.qqEncodeURI(cjson.encode(param))
openWebHallByParam(tempparam)
else
UIManager:uiWarningMessage(stringf("订单错误：%s",ret))
end
end
end
local info=platformHelper:getPlayerInfo()
local cfg=cfg_rechargeconfig_get(id)
local data={}
data.openid=openID
data.open_key=openKey
data.pfkey=pfkey
data.sid=info.json_sid
data.actor_id=info.json_roleid
data.pay_index=id
data.price=cfg.rmb*100
data.item_name=cfg.name
data.desc=cfg.name
data.pf="qqgame"
data.level=info.json_level
data.param=params and params~=''and base64.enc(string.encodeURI(params))or''
local param=releasephpPayUrl..string.unicodeURL(data,true)
platformSDK.printSDK('请求创建订单:',param)
_HttpGetRequest(param,http_callback)



end



function platformSDK_qqGame_PC:reqReport(typo,info)
local actorid=playerModel:getActorID()or 0
local enterGameState=gameState.isEnter()
local zmlevel=enterGameState and zongmenModel:getLevel()or 1
platformSDK.printSDK("platformSDK_PC_WeGame:reqReport",typo)
local actionid=0
if typo==sdkReportEnum.eLoginReport then
actionid=1
elseif typo==sdkReportEnum.eregister then

actionid=2
elseif typo==sdkReportEnum.eCreateRoleReport then

actionid=12
elseif typo==sdkReportEnum.eLevelUpReport then

elseif typo==sdkReportEnum.eExitGameReport then
actionid=9
end

if actionid==0 then
return
end
local function httpCallBack(message,err)
local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)
end
self:reqReportCB(json_table,err)
end
_HttpGetRequest(stringf(reportUrl,actionid,actorid,openID,zmlevel,0,appID,appID),httpCallBack)
platformSDK.printSDK('reqReportid',actionid)



end

function platformSDK_qqGame_PC:reqReportCB(json_table,err)
platformSDK.printSDK('reqReportCB')
end

function platformSDK_qqGame_PC:executeCmd(funcName,jsonStr)

if funcName=="guanzhu"then
openUrl(hallWeb..qqgameVipURL)
elseif funcName=="buy_vip"then
local param=
{
action="openVip",
appid=appID,
openid=openID,
openkey=openKey,
}
local tempparam=string.encodeURI(cjson.encode(param))
openWebHallByParam(tempparam)
end
end


function platformSDK_qqGame_PC:StartBeat()

end



function platformSDK_qqGame_PC.reportCB(content,err)
if err then
platformSDK.printSDK("report_sdk_data,cd,err,",content,err)
return
end
local json=cjson.decode(content)
local seq_id=tonumber(json.title.seq_id)
if json.data.code==408 or
json.data.code==1004 then
local retry_times=tonumber(json.title.retry_times)
if retry_times<10 then
platformSDK_qqGame_PC.setRetryTimes(seq_id)
return
end
end
retryData[seq_id]=nil
requestData[seq_id]=nil
platformSDK.printSDK("report_sdk_data,cd,",content,err)
end

function platformSDK_qqGame_PC.cooldown(Id)
if next(retryData)then
for k,v in pairs(retryData)do
v.timer=v.timer-TIME_DELAY
if(v.timer<=0)then
platformSDK_qqGame_PC.request(v.seq_id,platformSDK_qqGame_PC.reportCB)
retryData[v.seq_id]=nil
end
end
else
if delay_timer then
delay_timer:cancel()
delay_timer=nil
end
end
end

function platformSDK_qqGame_PC.setRetryTimes(seq_id)
local jsonData=requestData[seq_id]
if not jsonData then
return
end
local retry_times=jsonData.title.retry_times+1
jsonData.title.retry_times=tostring(retry_times)

local m_retryData=retryData[seq_id]or{}
m_retryData.seq_id=seq_id
m_retryData.timer=retry_times*2
retryData[seq_id]=m_retryData

if not delay_timer then
delay_timer=timer.new()
delay_timer:start(TIME_DELAY,platformSDK_qqGame_PC.cooldown)
end
end

function platformSDK_qqGame_PC.request(seq_id,cb)
local jsonData=requestData[seq_id]
if not jsonData then
return
end
local postData=cjson.encode(jsonData)
local requestHeader=platformSDK_qqGame_PC.signRequestHeader(postData)
platformSDK.printSDK("request,",qqgameReportURL,postData)
_HttpPostJsonRequest(qqgameReportURL,requestHeader,postData,cb)
end


function platformSDK_qqGame_PC.getRequestBody(jsonStr,actionid)
seq_id=seq_id+1
local app_name=_AppConfig_GetString('APPName',"最强祖师")
local timestamp=timeHelper.getServerShortTime()

local jsonData={}
local title={}
jsonData.title=title
title.app_id=tostring(appID)
title.app_name=tostring(app_name)
title.timestamp=tostring(timestamp)
title.seq_id=tostring(seq_id)
title.retry_times="0"

local dtEventTime=timestamp
local iversion=_AppConfig_GetInt("version",1)








local userip=deviceHelper.getUserAddress();
local svrip=loginModel.server_ip or""
local iworldid=loginModel.server_id

local opuid=""
local level=1

if jsonStr.json_roleid then
opuid=jsonStr.json_roleid
end

if not opuid and loginModel.userid then
opuid=loginModel.userid
end
if playerModel:getActorID()then
opuid=playerModel:getActorID()or opuid
level=playerModel:getLevel();
end

local str1=stringf("dtEventTime=%s&iversion=%s&appid=%s&userip=%s&svrip=%s",
dtEventTime,
iversion,
appID,
userip,
svrip
)
local str2=stringf("&action_time=%s&domain=10&optype=3&actionid=%s",
timestamp,
actionid
)
local str3=stringf("&iworldid=%s&opuid=%s&opopenid=%s&level=%s",
iworldid,
opuid,
openID,
level
)
local str4=stringf("&touid=0&toopenid=0&source=qqgame_index")


local data={}
jsonData.data=data
local temp={}
temp.log_name="log_common"
temp.log_fields=str1..str2..str3..str4



data[#data+1]=temp
requestData[seq_id]=jsonData
return seq_id
end

function platformSDK_qqGame_PC.signRequestHeader(postData)
local requestHeader={
"Content-Type",
"application/json",
"signature",
CS.LuaHelper.GetMD5UTF8(postData..qqgameReportKeySign),
"version",
"1.0",}
return requestHeader
end

function platformSDK_qqGame_PC:OnApplicationQuit()
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="确定退出游戏",
oktext='确认',
canceltext='取消',
okcallback=function(...)
_ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


local sdkchannel=
{
other=1,
Msg=2,
title=3,
comment=4,
signature=5,
search=6,
}


local channelIdMapping=
{
[CHAT_CHANNNEL.eNone]=sdkchannel.other,
[CHAT_CHANNNEL.eSystem]=sdkchannel.title,
[CHAT_CHANNNEL.eJianwen]=sdkchannel.Msg,
[CHAT_CHANNNEL.eWorld]=sdkchannel.Msg,
[CHAT_CHANNNEL.eKuafu]=sdkchannel.Msg,
[CHAT_CHANNNEL.eXianmeng]=sdkchannel.Msg,
[CHAT_CHANNNEL.ePrivate]=sdkchannel.Msg,
[CHAT_CHANNNEL.eBattleField]=sdkchannel.Msg,

}


function platformSDK_qqGame_PC:reqMsgSecCheck(scene,content,callback)
local PJcontent=content
local channelId=channelIdMapping[chatModel.channelId]or sdkchannel.Msg
local function httpCallBack(message,err)
local json_table=jsonHelper.decode(message)
self:onreMsgSecCheck(json_table,err,callback)
end
_HttpGetRequest(stringf(privacyMsgUrl,openID,openKey,PJcontent,channelId),httpCallBack)
platformSDK.printSDK('reqMsgSecCheck1',PJcontent)
end



function platformSDK_qqGame_PC:onreMsgSecCheck(json_table,err,callback)
platformSDK.printSDK('onreMsgSecCheck：',json_table,err)
platformSDK.printSDK("reqmaskfontCB,cd,ret,",tonumber(json_table.ret))
if tonumber(json_table.ret)==0 then
platformSDK.printSDK("reqmaskfontCB,cd,err2,",json_table.text_result_list_[1])
if json_table.text_result_list_ and json_table.text_result_list_[1]then
local text=json_table.text_result_list_[1]
callback(text.result_text_)
platformSDK.printSDK('reqMsgSecCheck返回',text.result_text_)
end
end
end