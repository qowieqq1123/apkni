

platformSDK_UWP=simple_class(platformSDK_None)

local cjson=require'cjson'

local _WindowsHelper=CS.UWPHelper

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

local IsRatingReview=false

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

function platformSDK_UWP:__init(...)
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



function platformSDK_UWP:reqLogin()
_WindowsHelper.ExecCmd("reqLogin","")
end


function platformSDK_UWP:reqLogout()

end


function platformSDK_UWP:reqCloseGame()
_WindowsHelper.ExecCmd("PlayAD","")
end



function platformSDK_UWP:reqIsRatingReview()
_WindowsHelper.ExecCmd("IsRatingReview","")
end


function platformSDK_UWP:reqShowRatingReview()
_WindowsHelper.ExecCmd("ShowRatingReview","")
end


function platformSDK_UWP:reqPay(id,count,params,subscribe)
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
UIManager:showWindow('UIUWPRechargeBlockWin')
end




function platformSDK_UWP:reqReport(typo,info)

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


function platformSDK_UWP:reqFangChenMi()

end


function platformSDK_UWP:onPay(json,jsonStr)

local result=json.result
platformSDK.printSDK('LoginCallBack platformSDK_Android_XingJia,onPay=%s',tostring(jsonStr))
if result==true or result=="true"then
else
end
UIManager:closeWindow("UIUWPRechargeBlockWin")
end

function platformSDK_UWP:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack platformSDK_Android_XingJia,loginparam=%s',tostring(jsonStr))
self.isReqLogin=nil
local info=json
local phpParams={}
phpParams.uid=info.UID
phpParams.sign=info.Token




if loginModel.isLogin then
if info.username~=loginModel.username then
loginControl:loginout()
logErr(string.format('账号异常登陆回调刷新 账号不匹配 旧账号：%s  刷新账号：%s',loginModel.username,info.username))
return
end
loginModel:onfreshLoginInfo(info,phpParams,info.UID)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_Android_XingJia')
else
loginModel:onLogin(info,phpParams,info.UID)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_Android_XingJia')

socketManager:closeDialogue()
end
self:reqIsRatingReview()
end


function platformSDK_UWP:onIsRatingReview(json,jsonStr)
local result=json.result
platformSDK.printSDK('onIsRatingReview platformSDK_Android_XingJia,onPay=%s',tostring(jsonStr))
if result=="true"or result==true then
pfwindowslController:setShowRatingReview(false)
else
pfwindowslController:setShowRatingReview(true)
end
pfwindowslController:checkEnterUwpHaoPing()
end


function platformSDK_UWP:onShowRatingReview(json,jsonStr)
local result=json.result
platformSDK.printSDK('onShowRatingReview platformSDK_Android_XingJia,onPay=%s',tostring(jsonStr))
if result=="true"or result==true then
pfwindowslController:setShowRatingReview(false)
else
pfwindowslController:setShowRatingReview(true)
end

pfwindowslController:checkEnterUwpHaoPing()
end


function platformSDK_UWP:LogoutCallBack(json,jsonStr)
platformSDK.printSDK('LogoutCallBack：',json,jsonStr)
local info=json.jsonStr
local result=info.result
if result=="true"or result==true then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
loginState:logout()
end
end
end



function platformSDK_UWP:PurchasePaymentResult()

end


function platformSDK_UWP:OnApplicationQuit()
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="确定退出游戏",
oktext='确认',
canceltext='取消',
okcallback=function(...)
loginControl:reportExitGame()
_WindowsHelper.ExecCmd("setQuitState","quit")
_WindowsHelper.ExecCmd("PlayAD","")
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function platformSDK_UWP:reqApplicationQuit_PC()
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end


function platformSDK_UWP:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
callback(content)
self:Chitchat(content)
end


function platformSDK_UWP:Chitchat(content)
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
else
info.channelId=sdkchannel.other
end
local str=cjson.encode(info)
_WindowsHelper.ExecCmd("Chitchat",str)
end


function platformSDK_UWP:gongHuiReport(game_event)
local guildInfoItem=xianmengModel:getXMDetialData()
local info={}
info.game_event=game_event
info.serverName=loginModel.sever_name or''
info.promotion_id=""
info.versioncode=""
info.guild_name=guildInfoItem.guildname
info.guild_level=guildInfoItem.guildlevel
info.guild_motd=guildInfoItem.guildnotice
info.guild_id=guildInfoItem.guildid
info.guild_owner_name=guildInfoItem.leadername
local str=cjson.encode(info)
_WindowsHelper.ExecCmd("gongHuiReport",str)
end