

platformSDK_PC_FeiHuo=simple_class(platformSDK_None)

local cjson=require'cjson'

local _WindowsHelper=CS.FeiHuoPCHelper

local id=0
local AddIndex_=function()
id=(id+1)%100000
return id
end

local sdkchannel=
{
other=0,
system=1,
world=2,
Private=3,
Xianmeng=4,
Kuafu=5,
eattleField=6,
zhandui=7,
}


local channelIdMapping=
{
[CHAT_CHANNNEL.eNone]=sdkchannel.other,
[CHAT_CHANNNEL.eSystem]=sdkchannel.system,
[CHAT_CHANNNEL.eJianwen]=sdkchannel.eJianwen,
[CHAT_CHANNNEL.eWorld]=sdkchannel.world,
[CHAT_CHANNNEL.eKuafu]=sdkchannel.Kuafu,
[CHAT_CHANNNEL.eXianmeng]=sdkchannel.Xianmeng,
[CHAT_CHANNNEL.ePrivate]=sdkchannel.Private,
[CHAT_CHANNNEL.eBattleField]=sdkchannel.eattleField,
}

function platformSDK_PC_FeiHuo:__init(...)
platformSDK.printSDK("platformSDK_PC_WeGame:__init11")
self.secCheckCBDict={}
local cb=function(funcName,jsonStr)
platformSDK.printSDK('callBackFunc：',funcName,jsonStr)
local json=cjson.decode(jsonStr);
local cbTarget=self[funcName];
if cbTarget~=nil then
cbTarget(self,json,jsonStr);
end
end

_WindowsHelper.SetCallbacks(cb);
_WindowsHelper.Init("none")
end



function platformSDK_PC_FeiHuo:reqLogin()
_WindowsHelper.ExecCmd("reqLogin","")
end


function platformSDK_PC_FeiHuo:reqLogout()
_WindowsHelper.ExecCmd("reqLogout","")
end



function platformSDK_PC_FeiHuo:reqPay(id,count,params,subscribe)
platformSDK.printSDK('UIXianGouBuyDialogWin5',id,count,params,subscribe)
local info=platformHelper:getPlayerInfo()
local attach=platformHelper.getPayAttach(id,params)
local cfg=cfg_rechargeconfig_get(id)
info.json_tradeId=platformHelper.getTradeId(id)
info.json_rmb=cfg.rmb*100
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
info.json_count=count
info.json_attach=attach
info.json_test=0
info.json_url=''
info.subscribe=subscribe or false


info.data=''
info.adid='0'
info.lang='zh'
info.product_type="0"

local str=cjson.encode(info)
platformSDK.printSDK("platformSDK_PC_WeGame:reqPay",str)
_WindowsHelper.ExecCmd("Pay",str)
end




function platformSDK_PC_FeiHuo:reqReport(typo,info)

local playerinfo=platformHelper:getPlayerInfo()
info=platformHelper.concat(info,playerinfo)

info.versioncode='1'
info.promotion_id='0'
info.json_time=""
info.adid='0'
local str=cjson.encode(info)
platformSDK.printSDK("platformSDK_PC_WeGame:reqReport",typo)
if typo==sdkReportEnum.eCreateRoleReport then
_WindowsHelper.ExecCmd("PortCreateCharacter",str)
elseif typo==sdkReportEnum.eLevelUpReport then
_WindowsHelper.ExecCmd("PortRoleUpLv",str)
elseif typo==sdkReportEnum.eEnterMainSceneReport then
_WindowsHelper.ExecCmd("PortEnterGame",str)
elseif typo==sdkReportEnum.eExitGameReport then
_WindowsHelper.ExecCmd("PortExitGame",str)
end
end


function platformSDK_PC_FeiHuo:reqFangChenMi()

end


function platformSDK_PC_FeiHuo:onPay(json,jsonStr)

local info=json.jsonStr
local result=info.result
if result==true or result=="true"then

else

end
end


function platformSDK_PC_FeiHuo:LoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack：',json,jsonStr)
local info=json.jsonStr
local phpParams={}
phpParams.uid=info.uid
phpParams.sign=info.sign




if loginModel.isLogin then
if info.username~=loginModel.username then
loginControl:loginout()
logErr(string.format('账号异常登陆回调刷新 账号不匹配 旧账号：%s  刷新账号：%s',loginModel.username,info.username))
return
end
loginModel:onfreshLoginInfo(info,phpParams,info.uid)
platformSDK.printSDK('登陆信息__刷新 platformSDK_PC_WeGame')
else
loginModel:onLogin(info,phpParams,info.uid)
platformSDK.printSDK('登陆__成功 platformSDK_PC_WeGame',deviceHelper.getRuntimePlatformStr())
platformSDK.printSDK('登陆__成功 platformSDK_PC_WeGamea',deviceHelper.isRunNonePlatform())


socketManager:closeDialogue()
end
end


function platformSDK_PC_FeiHuo:LogoutCallBack(json,jsonStr)
platformSDK.printSDK('LogoutCallBack：',json,jsonStr)
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



function platformSDK_PC_FeiHuo:PurchasePaymentResult()

end


function platformSDK_PC_FeiHuo:OnApplicationQuit()
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="确定退出游戏",
oktext='确认',
canceltext='取消',
okcallback=function(...)
_WindowsHelper.ExecCmd("setQuitState","quit")
loginControl:reportExitGame()
self.timer=timer.new()
local function CallBack()
platformHelper:exitGame()
if self.timer then
self.timer:cancel()
self.timer=nil
end
end
self.timer:start(0.5,CallBack,1)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function platformSDK_PC_FeiHuo:reqApplicationQuit_PC()
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end


function platformSDK_PC_FeiHuo:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
local curid=AddIndex_()
self.secCheckCBDict[curid]=callback
local PJcontent=string.format("%s|%s|%s",curid,content,scene)

local info=platformHelper:getPlayerInfo()

info.versioncode='1'
info.promotion_id='0'
info.json_time=""
info.adid='0'

info.MsgSecCheck_type="1"
info.MsgSecCheck=PJcontent

info.json_attach=""


info.username="0"
info.to_uid="0"
info.to_username="0"
info.to_roleid="0"
info.to_rolename="0"
if to_PrivatePlayerData then
info.to_roleid=tostring(to_PrivatePlayerData.actorId)
info.to_rolename=tostring(to_PrivatePlayerData.actorName)
end
info.channelId="0"
if chatModel.channelId and channelIdMapping[chatModel.channelId]then
info.channelId=channelIdMapping[chatModel.channelId]
else
info.channelId=sdkchannel.other
end
info.guild_id="0"
if chatModel.channelId==CHAT_CHANNNEL.eXianmeng then
info.guild_id=tostring(xianmengModel:myXMGuildID())or"0"
end

local str=cjson.encode(info)
_WindowsHelper.ExecCmd("MsgSecCheck",str)
platformSDK.printSDK('reqMsgSecCheck',PJcontent)
if scene==2 then
self:Chitchat(content)
end
end



function platformSDK_PC_FeiHuo:onreMsgSecCheck(json,jsonStr)
platformSDK.printSDK('onreMsgSecCheck：',json,jsonStr)
local info=json.jsonStr
local strArray=info.output_words
strArray=string.split(strArray,'|')
local curid=strArray[1]
local content=strArray[2]
local scene=strArray[3]
local callback=self.secCheckCBDict[tonumber(curid)]
platformSDK.printSDK('onreMsgSecCheck2',curid,content,scene)
if callback then
if scene==1 or scene=="1"then
callback(content)
else
callback(content)
end
platformSDK.printSDK('onreMsgSecCheck3')
end
platformSDK.printSDK('reqMsgSecCheck返回',content)
end


function platformSDK_PC_FeiHuo:Chitchat(content)
local playerinfo=platformHelper:getPlayerInfo()
local info
info=platformHelper.concat(info,playerinfo)

info.versioncode='1'
info.promotion_id='0'
info.json_time=""
info.adid='0'
info.content=content
info.channelId=chatModel.channelId or 0
if chatModel.channelId and channelIdMapping[chatModel.channelId]then
info.channelId=channelIdMapping[chatModel.channelId]
end
local str=cjson.encode(info)
_WindowsHelper.ExecCmd("Chitchat",str)
end