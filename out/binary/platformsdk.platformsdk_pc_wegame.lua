

platformSDK_PC_WeGame=simple_class(platformSDK_None)

local cjson=require'cjson'

local _WindowsHelper=CS.WindowsHelper

local id=0
local AddIndex_=function()
id=(id+1)%100000
return id
end

local debugStr="--rail_debug_mode"

function platformSDK_PC_WeGame:__init(...)
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
_WindowsHelper.Init(debugStr)
end



function platformSDK_PC_WeGame:reqLogin()
_WindowsHelper.ExecCmd("reqLogin","")
end


function platformSDK_PC_WeGame:reqPay(id,count,params,subscribe)
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


function platformSDK_PC_WeGame:reqReport(typo,info)

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
end
end


function platformSDK_PC_WeGame:reqFangChenMi()

end



function platformSDK_PC_WeGame:LoginCallBack(json,jsonStr)
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


function platformSDK_PC_WeGame:reqMsgSecCheck(scene,content,callback)
local curid=AddIndex_()
self.secCheckCBDict[curid]=callback
content=string.format("%s|%s|%s",curid,content,scene)
_WindowsHelper.ExecCmd("MsgSecCheck",content)
platformSDK.printSDK('reqMsgSecCheck',content)
end



function platformSDK_PC_WeGame:onreMsgSecCheck(json,jsonStr)
platformSDK.printSDK('onreMsgSecCheck：',json,jsonStr)
local info=json.jsonStr
local has=info.has_dirty_words
local strArray=info.output_words
platformSDK.printSDK('onreMsgSecCheck1',has,strArray)
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
platformSDK.printSDK('reqMsgSecCheck返回',content,has)
end


function platformSDK_PC_WeGame:onFangChenMi(json,jsonStr)
platformSDK.printSDK('onFangChenMi：',json,jsonStr)
if json.actions then
platformSDK.printSDK('onFangChenMi1：',json.actions,jsonStr)
platformSDK.printSDK('onFangChenMi2：',#json.actions)
if#json.actions>1 then
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="根据国家防沉迷通知的相关要求和腾讯最新强化的防沉迷策略，由于您是未成年人，仅能在周五、周六、周日及法定节假日20时至21时进入游戏。",
oktext='确认',
canceltext='取消',
okcallback=function(...)
platformHelper:exitGame()
end,
cancelcallback=function(...)
platformHelper:exitGame()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="根据国家防沉迷通知的相关要求和腾讯最新强化的防沉迷策略，由于您是未成年人，仅能在周五、周六、周日及法定节假日20时至21时进入游戏。",
oktext='确认',
canceltext='取消',
okcallback=function(...)
end,
cancelcallback=function(...)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end
end



function platformSDK_PC_WeGame:systemStateChanged(json,jsonStr)
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="当前账号已离线，请您重新登录。",
oktext='确认',
canceltext='取消',
okcallback=function(...)
platformHelper:exitGame()
end,
cancelcallback=function(...)
platformHelper:exitGame()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function platformSDK_PC_WeGame:PurchasePaymentResult()

end


function platformSDK_PC_WeGame:OnApplicationQuit()
local showdata=
{
type='UIDialouge',
title='温馨提示',
content="确定退出游戏",
oktext='确认',
canceltext='取消',
okcallback=function(...)
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function platformSDK_PC_WeGame:reqApplicationQuit_PC()
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end