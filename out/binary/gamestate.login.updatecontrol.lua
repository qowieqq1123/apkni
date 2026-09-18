updateControl={}
local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _DownloadCDNData=CS.ResourceHelper.DownloadCDNData
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest
local _apkURL='apk/zuiqiangzushi.apk'
local _logInfo=Debugger.Log
local _t_concat=table.concat
local _log=function(...)
local out={'[updateControl]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_logInfo(_t_concat(out,' '))
end
updateControl.check=false
function updateControl.checkUpdate(callback)

if verifyManager:isOpen()then
if callback then
callback()
end
return
end
pfCommonHelper.clickCreateRole()
updateControl.reqVersion(callback)
end

local showRebootDialouge=function()
local showdata=
{
type='UIDialougeHighest',
title="提示",
content='游戏有更新，需重新启动',
oktext='重新启动',
okcallback=function()
if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
platformSDK:reqApplicationQuit_PC()
else
platformSDK:reqRestart()
end
end,
allowclickBG='false',
showclosebtn=false,
checkOkCallBackRet=true,
}


if deviceHelper.isRunIOS()or deviceHelper.isRunEditor()then
showdata.content='\n游戏有更新，请祖师手动关闭游戏客户端并重新启动，给您带来的不便敬请谅解'
showdata.hideOkBtn=true
end
if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
showdata.oktext='确认'
showdata.content='\n游戏有更新，请祖师重新启动游戏，给您带来的不便敬请谅解'
end

local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function updateControl.showForceRestart()
showRebootDialouge()
end

function updateControl.reqVersion(callback)
if updateControl.check then return end
updateControl.check=true
if not appUtils.testPHP and deviceHelper.isRunEditor()then
updateControl.check=false
if callback then
callback()
end
return
end

local no_update=_AppConfig_GetBool('no_update',false)
if no_update then
if callback then
callback()
end
return
end

local cdnConfigUrl=_AppConfig_GetString("test_updatelist_url","")
if cdnConfigUrl~=nil and cdnConfigUrl~=''then
updateControl.checkUpdateCDN(cdnConfigUrl,callback)
return
end


local httpCallBack=function(message,err)
updateControl.check=false
_log('版本信息回调:',message,err)
if err==""or not err then
local json_table={}
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)
if s then

if json_table.code==0 then
local currentResVersion=_GetResourceVersion()
if json_table.data.cdnVersion>currentResVersion then
showRebootDialouge()
return
else
if callback~=nil then
callback()
end
end
else
logErr('入口信息解析失败:',message)
UIUpdateDialog.ShowDialogBox('提示','检查游戏版本异常，游戏无法进行',LuaApplication.QuitGame)
end

else
logErr('入口信息解析失败:',message)
UIUpdateDialog.ShowDialogBox('提示','检查游戏版本失败，游戏无法进行',LuaApplication.QuitGame)
end
else
logErr('请求版本信息失败:',message,err)
UIUpdateDialog.ShowDialogBox('提示','网络异常，是否重试',function()
updateControl.reqVersion(callback)
end,LuaApplication.QuitGame)
end
end


local cdnVersionURL=gameInfo:getParams('cdnVersionURL')
_log('请求版本信息:',cdnVersionURL)
_httpGetRequest(cdnVersionURL,httpCallBack)
end

function updateControl.checkUpdateCDN(cdnConfigUrl,callback)
local currentResVersion=_GetResourceVersion()
local function decodeCDN(info)
local groupVersion={}
local curVersion=-1
for i,v in pairs(info.groupVersion)do
local version=tonumber(v.version)
groupVersion[tonumber(i)]=version
if version>curVersion then curVersion=version end
end
_log('decodeCDN version',currentResVersion,curVersion)
if currentResVersion<curVersion then
showRebootDialouge()
return
end
_log('无新版本：',curVersion)
if callback then
callback()
end
end

local function CDNDownloaded(errorcode,content)
_log('CDNDownloaded：',errorcode,content)
updateControl.check=false

if errorcode then



UIUpdateDialog.ShowDialogBox('警告','当前网络异常，是否重试？',function()
updateControl.checkUpdate(callback)
end,nil,false)
return
end

local info
local s,e=pcall(function()
info=jsonHelper.decode(content)
end)
if not info then
UIUpdateDialog.ShowDialogBox('警告','当前网络异常，是否重试？',function()
updateControl.checkUpdate(callback)
end,nil,false)
return
end
decodeCDN(info)
end

_DownloadCDNData(cdnConfigUrl,nil,CDNDownloaded)
end
