platformHelper={}

local _exitDialogue=nil
local _isClickExit=false
local _attachBase='{0}-{1}-{2}-{3}-{4}'
sdkReportEnum=
{
eLoginReport=1,
eEnterServerReport=2,
eCreateRoleReport=3,
eLevelUpReport=4,
eLogoutReport=5,
eEnterMainSceneReport=6,
eOpenServerListReport=7,
eExitGameReport=8,
eTutorialFinish=9,
eregister=10,
}

sdkReportStr=
{
[sdkReportEnum.eLoginReport]='uploadEnterGame',
[sdkReportEnum.eEnterServerReport]='uploadEnterServer',
[sdkReportEnum.eCreateRoleReport]='uploadCreateRole',
[sdkReportEnum.eLevelUpReport]='uploadUpLevel',
[sdkReportEnum.eLogoutReport]='uploadLogout',
[sdkReportEnum.eEnterMainSceneReport]='uploadEnterScene',
[sdkReportEnum.eOpenServerListReport]='uploadOpenServer',
[sdkReportEnum.eExitGameReport]='uploadExitGame',
}




function platformHelper:onKeyDownClick(keycode)
if keycode=='Escape'then
platformHelper:onEscape()
end
end

function platformHelper:onEscape()
if not _isClickExit then
_isClickExit=true
platformHelper:showQuitGameWindow()
else
_isClickExit=false
if _exitDialogue then
_exitDialogue:hide()
end
end
end

function platformHelper:exitGame()
LuaApplication.QuitGame()
end

function platformHelper:showQuitGameWindow()
local s=pcall(function()
if not _exitDialogue then
local enterFunc=function(...)
local finishCallback=function(...)
platformHelper:exitGame()
end
if not platformSDK:reqQuit(finishCallback)then

_isClickExit=true
finishCallback()
end
end
local cancelFun=function(...)
_isClickExit=false
end
local show_data=
{
type='UIDialouge',
title='提示',
content='确定退出游戏吗？',
oktext='确认',
canceltext='取消',
cancelcallback=cancelFun,
okcallback=enterFunc,
closecallback=cancelFun,
}
_exitDialogue=UIDialogManager.newDialog(show_data)
end
_exitDialogue:show()
end)
if not s then
_isClickExit=false
end
end


function platformHelper:exec(func_name,...)
if deviceHelper.isRunAndroid()then
return androidTool.callFunc(func_name,...)
elseif deviceHelper.isRunIOS()then

end
end

function platformHelper:getPlayerInfo()
local enterGameState=gameState.isEnter()
local zmlevel=enterGameState and zongmenModel:getLevel()or 1
local zmname=enterGameState and UISettingModel:getZMName()or''
local actorname=playerModel:getActorName()or''
local actorid=playerModel:getActorID()or''
local serverid=loginModel.be_server_id or 0
local serverName=loginModel.sever_name or''
local xmId=xianmengModel:myXMGuildID()or''
local xmName=xianmengModel:getXMName()or''
local sex=playerModel:getActorSex()or''
local uid=loginModel.userid or''
local username=loginModel.username or''

local shortCreateTime=gameUtilityModel.getPlayerCreateTime()
local createtime=0
if shortCreateTime>0 then
createtime=timeHelper.convertLongStamp(shortCreateTime)
end

local uit={}
uit.json_uid=string.format("%s",uid)
uit.json_createtime=string.format("%s",createtime)
uit.json_time=string.format("%s",timeHelper.getServerLongTime())
uit.json_level=string.format("%s",zmlevel)
uit.json_rolename=string.format("%s",actorname)
uit.json_roleid=string.format("%s",actorid)
uit.json_sid=string.format("%s",serverid)
uit.json_sname=string.format("%s",serverName)
uit.json_xianmengname=string.format("%s",xmName)
uit.json_xianmengId=string.format("%s",xmId)
uit.json_yb=moneyModel.getMoney(eMoneyType.mtLingYu)
uit.json_xianmenglv='0'
uit.json_viplevel='0'
uit.json_fight='0'
uit.json_sex='无'
uit.json_recharge=string.format("%s",rechargeModel:getTotalRecharge())
uit.json_username=username
return uit
end

function platformHelper.concat(info,json)
if info==nil then
return json
end
for k,v in pairs(json)do
if info[k]==nil then
info[k]=v
end
end
return info
end

function platformHelper.getTradeId(id)
local serverid=loginModel.be_server_id or 0
local actorid=playerModel:getActorID()or''
local userId=loginModel.userId
return FMT.fmt('{0}Tt{1}Tt{2}Tt{3}Tt{4}',id,tostring(serverid),tostring(actorid),
tostring(userId),tostring(os.time()))
end


function platformHelper.convertCreateInfo(createInfo)
if createInfo==nil then createInfo={}end
local uit={}

local createtime=createInfo.createtime and
timeHelper.convertLongStamp(createInfo.createtime)or 0

uit.json_createtime=string.format("%s",createtime)
uit.json_time=string.format("%s",timeHelper.getServerLongTime())
uit.json_level=string.format("%s",createInfo.level or 1)
uit.json_rolename=string.format("%s",createInfo.name or'')
uit.json_roleid=string.format("%s",createInfo.id or'')
uit.json_sid=string.format("%s",loginModel.be_server_id or 0)
uit.json_sname=string.format("%s",loginModel.sever_name or'')
uit.json_xianmengname=''
uit.json_viplevel="0"
if uit.json_rolename==''then uit.json_rolename='默认'end
return uit
end

function platformHelper.convertIpv6(server_ip)



return server_ip
end


function platformHelper.copyTextToClipboard(str)
if api_Available_GetClipboardData()and(webGLHelper:isRunMiniGame()or webGLHelper:isRunMGNative())then
_WXInterface.SetClipboardData(str,nil,nil)
return true
end
if deviceHelper.isRunAndroid()then
androidTool.callFunc('CopyTextToClipboard',str)
return true
end

if api_Available_SetSystemCopyBuffer()then
CS.GameInterface.SetSystemCopyBuffer(str)
return true
end
return false
end


function platformHelper.getClipboardText()
if deviceHelper.isRunAndroid()then
return androidTool.callFunc('GetClipboardText','')
end

if api_Available_SetSystemCopyBuffer()then
return CS.GameInterface.GetSystemCopyBuffer()
end
return''
end

function platformHelper.getAttachBase(id)
local enterGameState=gameState.isEnter()
local sid=tostring(loginModel.be_server_id or 0)
local userid=tostring(loginModel.userid)
local actorId=tostring(playerModel:getActorID()or'')
local level=enterGameState and zongmenModel:getLevel()or 1
return FMT.fmt(_attachBase,sid,userid,actorId,level,id)
end

function platformHelper.getPayAttach(id,params)
local baseAttach=platformHelper.getAttachBase(id)
local attachParams=params and params~=''and
FMT.fmt('-{0}',base64.enc(string.encodeURI(params)))or''
local attach=FMT.fmt('{0}{1}',baseAttach,attachParams)
return attach
end
