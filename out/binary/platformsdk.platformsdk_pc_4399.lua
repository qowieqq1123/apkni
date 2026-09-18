

platformSDK_PC_4399=simple_class(platformSDK_None)

local cjson=require'cjson'

local _WindowsHelper=CS.PC4399Helper


local id=0
local AddIndex_=function()
id=(id+1)%100000
return id
end

function platformSDK_PC_4399:__init(...)
platformSDK.printSDK("platformSDK_PC_WeGame:__init11")
self.secCheckCBDict={}
local cb=function(funcName,jsonStr)
platformSDK.printSDK('callBackFunc：',funcName,jsonStr)
if"onreMsgSecCheck"==funcName then
local cbTarget=self[funcName];
if cbTarget~=nil then
cbTarget(self,jsonStr,jsonStr);
end
else
local json=cjson.decode(jsonStr);
local cbTarget=self[funcName];
if cbTarget~=nil then
cbTarget(self,json,jsonStr);
end
end
end

_WindowsHelper.SetCallbacks(cb);
_WindowsHelper.Init("none")
end



function platformSDK_PC_4399:reqLogin()
_WindowsHelper.ExecCmd("reqLogin","")
end


function platformSDK_PC_4399:reqLogout()
_WindowsHelper.ExecCmd("reqLogout","")
end



function platformSDK_PC_4399:reqPay(id,count,params,subscribe)
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




function platformSDK_PC_4399:reqReport(typo,info)

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


function platformSDK_PC_4399:reqFangChenMi()

end


function platformSDK_PC_4399:onPay(json,jsonStr)

local info=json.jsonStr
local result=info.result
if result==true or result=="true"then

else

end
end


function platformSDK_PC_4399:LoginCallBack(json,jsonStr)
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


function platformSDK_PC_4399:LogoutCallBack(json,jsonStr)
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



function platformSDK_PC_4399:PurchasePaymentResult()

end


function platformSDK_PC_4399:OnApplicationQuit()
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


function platformSDK_PC_4399:reqApplicationQuit_PC()
_WindowsHelper.ExecCmd("setQuitState","quit")
platformHelper:exitGame()
end


function platformSDK_PC_4399:reqMsgSecCheck(scene,content,callback)
local curid=AddIndex_()
self.secCheckCBDict[curid]=callback
content=string.format("%s|%s|%s",curid,content,scene)
content=fileHelper.encodeURI(content)
_WindowsHelper.ExecCmd("MsgSecCheck",content)
platformSDK.printSDK('reqMsgSecCheck',content)
end



function platformSDK_PC_4399:onreMsgSecCheck(json,jsonStr)
platformSDK.printSDK('onreMsgSecCheck：',json,jsonStr)
local strArray=jsonStr
local has=false
platformSDK.printSDK('onreMsgSecCheck1',strArray)
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