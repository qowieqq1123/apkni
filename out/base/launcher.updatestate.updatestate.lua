
require'tolua.launcher.ui.UIUpdateDialog'
require'tolua.launcher.ui.UIUpdateWindow'
require'tolua.launcher.updateState.cdnLogHelper'

local _logInfo=Debugger.Log
local _t_concat=table.concat
local _log=function(...)
local out={'[updateState]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_logInfo(_t_concat(out,' '))
end

updateState={name='updateState'}




local _msg_handle=CS.MessageInterface
local _msg_type=GlobalEventType
local _AppDataModel=CS.AppDataModel

local _timerHelper=CS.TimerHelper
local _StartTimer=_timerHelper.StartTimer
local _StopTimer=_timerHelper.StopTimer
local _GamePath=CS.GamePath
local _writablePath=CS.GamePath.writablePath

local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool


local _HttpGet=CS.ResourceHelper.HttpGetRequest
local _GetVersionJsonByKey=CS.AppDataModel.GetVersionJsonByKey
local _SetVersionJsonByKey=CS.AppDataModel.SetVersionJsonByKey
local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _SetResourceVersion=CS.AppDataModel.SetResourceVersion
local _UpdateManager_InitGroupList=CS.ResourceHelper.UpdateManager_InitGroupList
local _DownloadGroup=CS.ResourceHelper.DownloadGroup
local _DownloadCDNData=CS.ResourceHelper.DownloadCDNData
local _SetDownloadGroup=CS.ResourceHelper.SetDownloadGroup
local _StartDownloadGroup=CS.ResourceHelper.StartDownloadGroup
local _StopDownloadGroup=CS.ResourceHelper.StopDownloadGroup

local _DownloadFileListManifest=CS.ResourceHelper.DownloadFileListManifest
local _SetCDNBaseURL=CS.ResourceHelper.SetCDNBaseURL
local _CheckVersionDownloadBaseLua=CS.ResourceHelper.CheckVersionDownloadBaseLua
local _ReloadBinary=CS.ResourceHelper.ReLoadBinaryBundle
local _ReloadConfig=CS.ResourceHelper.ReLoadConfigBundle
local _GetNetworkReachability=CS.ResourceHelper.GetNetworkReachability
local _UpdateScript_LoadGameObjectFromBundle=CS.ResourceHelper.UpdateScript_LoadGameObjectFromBundle

local _StartDownLoadPackage=CS.ResourceHelper.UpdateManager_StartDownLoadPackage
local _StopDownLoadPackage=CS.ResourceHelper.UpdateManager_StopDownLoadPackage

local currentResVersion=0
local cdnConfigUrl=''
local serverVersion=0
local BASE_GROUP=0
local BASE_GROUP_KEY='g'..tostring(BASE_GROUP)
local VERSION_CONFIG_GROUP_FMT='g%d'
local INSTALL_FLAG_KEY='INSTALL_FLAG'
local install_flag=0
local cjson=require'cjson'
local sformat=string.format
local needUpdateSize=0
local groupListSize={}

local CDN_URL_CACHE="CDN_URL_CACHE"
local LOCAL_DEVICE_PATH='device.json'
local localDeviceCfg=nil

local writablePath=CS.GamePath.writablePath
local _updownloadProgress={}


local function readjsonfile(path)
path=writablePath..'/'..path
local file=io.open(path,"r")
if file then
local content=file:read("*all")
if content==nil or content==""then
return nil
end
local ret=cjson.decode(content)
io.close(file)
return ret
end
return nil
end

if deviceHelper.isRunWebGL()then
readjsonfile=function(path)
path=_WXInterface.USER_DATA_PATH..'/'..path
if not fileHelper.isFileExists(path)then
return nil
end
local content=_WXInterface.ReadFileSync(path)
if not content or content==''then
return nil
end


local r1,r2=pcall(cjson.decode,content)
if r1 then
return r2
else
return nil
end
end
end

local function writejsonfile(path,content,mode)
mode=mode or"w+b"
path=writablePath..'/'..path
local file=io.open(path,mode)
if file then
cjson.encode_sparse_array(true)
if file:write(cjson.encode(content))==nil then
return false
end
io.close(file)
return true
else
return false
end
end

if deviceHelper.isRunWebGL()then
writejsonfile=function(path,content,mode)
path=_WXInterface.USER_DATA_PATH..'/'..path
cjson.encode_sparse_array(true)
local jstr=cjson.encode(content)
_WXInterface.WriteFileSync(path,jstr)
return true
end
end


local function _GetSvnResourceVersion()

return _GetVersionJsonByKey(BASE_GROUP_KEY,0)
end

function updateState:getGroupVersion(groupid)
return _GetVersionJsonByKey(sformat(VERSION_CONFIG_GROUP_FMT,groupid),0)
end

function updateState:setGroupVersion(groupid,ver)
return _SetVersionJsonByKey(sformat(VERSION_CONFIG_GROUP_FMT,groupid),ver)
end

local _GetAPILevel=CS.AppDataModel.API_LEVEL_NUM
function updateState.GetAPILevel()
return _GetAPILevel
end

function updateState:enter()

updateUtils.Init()

updateState:start()
end

function updateState:start()

if not localDeviceCfg then
local ok,cfg=pcall(readjsonfile,LOCAL_DEVICE_PATH)
if ok and cfg then
localDeviceCfg=cfg
else
logErr("read local device config error")
localDeviceCfg={}
writejsonfile(LOCAL_DEVICE_PATH,localDeviceCfg)
end
end
local cdnurl=localDeviceCfg[CDN_URL_CACHE]
if cdnurl then
local cdn=_AppConfig_GetString("test_updatelist_url","")
if cdn~=''then
cdnurl=updateState:getCDN(cdn)
end
_SetCDNBaseURL(cdnurl)
end

local callback=function()
updateState:update()
end
updateState:openUpdateWindow(callback)
end

function updateState:openUpdateWindow(callback)
if updateState.updateWindow then
if callback then
callback()
end
else
updateState.setDependencies()
local function onUpdateWindowLoaded(window)
updateState.updateWindow=window
CS.ResourceHelper.UpdateScript_CloseUILoading()
CS.ResourceHelper.UpdateScript_BindUILoading(window.winid)
if callback then
callback()
end
end
UIUpdateWindow.CreateWindow(onUpdateWindowLoaded)
end
end














function updateState:leave()

end


local function _retry()
updateState:update(true)
end


local function _retryDialog(errorcode,title,tip)
_log('cdn network err:',errorcode)
logPoint.UploadLog(logPoint.logType.comeinGame_reStart)
_StopDownloadGroup(true)
UIUpdateDialog.ShowDialogBox(title or'网络异常',tip or'网络连接错误,请检查网络',_retry,nil)
end

local function _onFileListDownloaded(errorcode,version)
if version<0 then

_retryDialog(errorcode,"提示","检查版本更新失败，请重试")
return
end
updateState.IsNeedReboot=_CheckVersionDownloadBaseLua(currentResVersion)
updateState:updateDataList()
end


local function _decodeCDN(info)
local curVersion=-1
for i,v in pairs(info.groupVersion)do
local version=tonumber(v.version)
table.insert(groupListSize,tonumber(i))
table.insert(groupListSize,tonumber(v.version))
table.insert(groupListSize,tonumber(v.count))
table.insert(groupListSize,tonumber(v.size))
if version>curVersion then curVersion=version end
end


local testUrl=_AppConfig_GetString("test_updatelist_url","")
if testUrl==''and not deviceHelper.isRunNoneOrEditor()then

local cndURL=gameInfo:getParams('cdnURL')
if cndURL~=nil then
info.CDNURL=cndURL
end
end

local baseURL=info.CDNURL
_log('cdnURL',baseURL)
updateState.baseURL=baseURL

local resourceListURL=info.CDNURL..info.assetbundleServerInfo
_UpdateManager_InitGroupList(groupListSize)
updateState.CDNInfo=info
_log("INSTALL_FLAG",install_flag,resourceListURL,curVersion)
serverVersion=curVersion
_SetCDNBaseURL(baseURL)

if not localDeviceCfg then
local ok,cfg=pcall(readjsonfile,LOCAL_DEVICE_PATH)
if ok and cfg then
localDeviceCfg=cfg
else
logErr("read local device config error")
localDeviceCfg={}
end
end
localDeviceCfg[CDN_URL_CACHE]=baseURL
writejsonfile(LOCAL_DEVICE_PATH,localDeviceCfg)


if currentResVersion>=serverVersion then
local serverInfoFileName=string.match(info.assetbundleServerInfo,"[^/]+$")or""
local buildTarget=info.buildTarget or""
local serverFullPath=buildTarget.."/"..serverInfoFileName
if fileHelper.isFileExists(fileHelper.getFullPath(serverFullPath))then
updateState:finish()
if currentResVersion>serverVersion then
_log('localResVersion :',currentResVersion,serverVersion)
end
_log('skip update')
return
end
end

local resourceListCRC=info.assetbundleServerInfoCRC
_DownloadFileListManifest(resourceListURL,resourceListCRC,_onFileListDownloaded)
logPoint.UploadLog(logPoint.logType.comeinGame_downloadUpdate)
end


local function _CDNDownloaded(errorcode,content)
_log('CDN doload err:',errorcode,content)
if errorcode then
cdnLogHelper:log(errorcode)
_retryDialog(errorcode)
return
end
cdnLogHelper:log(content)
local info
local s,e=pcall(function()
info=cjson.decode(content)
end)
if not info then
logPoint.UploadLog(logPoint.logType.comeinGame_reStart)
UIUpdateDialog.ShowDialogBox('警告','读取版本内容失败，是否重试',_retry,nil,false)
return
end
updateState.CDNInfo=info
_decodeCDN(info)
end


function updateState:download_cdn_json()

currentResVersion=_GetResourceVersion()
_log('updateState.currentResVersion',currentResVersion)
_log('updateState.cdnConfigUrl',cdnConfigUrl)


if cdnConfigUrl==''then
_log('skip update cdnConfigUrl == nil')
updateState:finish()
return
end

updateState.updateWindow:set_LogText2('资源版本号:'..currentResVersion)
updateState.updateWindow:set_DialogText('获取更新信息')
_DownloadCDNData(cdnConfigUrl,nil,_CDNDownloaded)
end



function updateState:startPackageUpdate()
if deviceHelper.isRunNoneOrEditor()then return false end
if deviceHelper.isRunWebGL()or deviceHelper.isRunIOS()then
return false
end
local testVersion=_AppConfig_GetInt('testAPPVersion',0)

local version=CS.AppDataModel.API_LEVEL_NUM or 0

local newVersion=tonumber(gameInfo:getAPPVersion()or 0)

if testVersion~=0 then
newVersion=testVersion
end

if newVersion<=version then
_log('skip doload new package cdn:',newVersion,version)
return false
end
_log('start doload new package cdn:',newVersion,version)
updateState:downloadPackageJson()
return true
end


local function _retryDownloadPackageCDN()
updateState:downloadPackageJson()
end


local function _retryPackageDialog(errorcode,title,tip)
_log('package network err:',errorcode)
_StopDownLoadPackage()
UIUpdateDialog.ShowDialogBox(title or'网络异常',tip or'网络连接错误,请检查网络',_retryDownloadPackageCDN,nil)
end


local _packageCDNDownloaded=function(errorcode,content)
_log('package CDN err:',errorcode,content)
if errorcode then
UIUpdateDialog.ShowDialogBox('警告','网络连接失败或下载错误，是否重试？',_retryDownloadPackageCDN,nil,false)
return
end
local info
local s,e=pcall(function()
info=cjson.decode(content)
end)
updateState.packageCDNContenct=nil
updateState.packageCDNInfo=nil
if not info then
UIUpdateDialog.ShowDialogBox('警告','读取下载内容失败，是否重试？',_retryDownloadPackageCDN,nil,false)
return
end

updateState.packageCDNContenct=content
updateState.packageCDNInfo=info

updateState:downPackage()
end

function updateState:getPackageURL()
local packageCDN=_AppConfig_GetString('TestAPPCDN','')
local url
if packageCDN~=''then
url=packageCDN
else
url=gameInfo:getAPPEntryURL()
end
return url
end

function updateState:downloadPackageJson()

local url=updateState:getPackageURL()
updateState.packageCDN=url

_DownloadCDNData(url,nil,_packageCDNDownloaded)
return true
end

local _installApk=function()
local appPath=updateState.appPath
androidTool.callStaticFunc('InstallApk',appPath)
end

local _packageDownloaded=function(errortype,content,path)
_log('package doload ret:',errortype,content,path)
if content~=''then
UIUpdateDialog.ShowDialogBox('警告','下载失败是否重试？',_retryDownloadPackageCDN,nil,false)
return
end

updateState.appPath=path
UIUpdateDialog.ShowDialogBox('警告','新包已下载完毕,马上开始安装',_installApk,nil,false)
end

local _packageDownloadProgress=function(progress)
updateState.updateWindow:set_ProgressValueTxt(string.format("%0.2f",progress*100)..'%')
updateState.updateWindow:set_DialogText('下载中')
updateState.updateWindow:set_CSGUIProgressBarAni(progress*100,100)
if progress>=1 then
updateState.updateWindow:set_DialogText('下载完成')
end
end

function updateState:downPackage()
local content=updateState.packageCDNContenct
local info=updateState.packageCDNInfo
local version=info.version
updateState:openUpdateWindow()
_StartDownLoadPackage(version,content,_packageDownloaded,_packageDownloadProgress)
end



function updateState:update(reTry)
local cb=function()
if not reTry then
logPoint.UploadLog(logPoint.logType.comeinGame)
end

updateState.StartInvoke()
updateState:checkUpdateMode()
end

gameInfo:initAndCheckVerify(cb)
end



function updateState.StartInvoke()
if deviceHelper.isRunNoneOrEditor()then
return
end

local updateInvokeStr=gameInfo:getUpdateInvoke()
if updateInvokeStr then
local s,e=pcall(function()
loadstring(decrypt(updateInvokeStr))()
end)
if not s then
logErr(e)
end
end
local verifyHideLoader=_AppConfig_GetBool("verifyHideLoader",false)
if verifyHideLoader then
if not updateState.filterServer then
updateState.updateWindow:setUpdateGroupState(true)
end
end
end


function updateState:checkUpdateMode()
if not updateState:startPackageUpdate()then
updateState:startUpdate()
end
end


function updateState:startUpdate()
logPoint.UploadLog(logPoint.logType.comeinGame_checkVersion)
_log('updateState:startUpdate')


local no_update=_AppConfig_GetBool('no_update',false)
if no_update then
_log('skip update no_update')
updateState:finish()
return
end

install_flag=_GetVersionJsonByKey(INSTALL_FLAG_KEY,0)



cdnConfigUrl=_AppConfig_GetString("test_updatelist_url","")
_log('cdnConfigUrl get ',cdnConfigUrl)
if cdnConfigUrl==nil or cdnConfigUrl==''then
if updateState.filterServer then
cdnConfigUrl=verifyData:getCDNJsonPath()
_log('verifyData:getCDNJsonPath ',cdnConfigUrl)
else
local entry_url=gameInfo:getEntryURL()
if entry_url==nil or entry_url==""then
logPoint.UploadLog(logPoint.logType.comeinGame_reStart)
UIUpdateDialog.ShowDialogBox('警告','读取入口信息失败，是否重试',_retry,nil,false)
return
end
_log('gameInfo:getEntryURL',entry_url)
cdnConfigUrl=entry_url
end
end
updateState:download_cdn_json()
end


function updateState:updateDataList()
updateState.updateWindow:set_DialogText('')
updateState.updateWindow:set_DialogText3('')






local progressFunc=function(downloadCount,maxCount,fileName,fileSize,speed)
local fval=downloadCount/maxCount
local tmp=needUpdateSize

local totalSize=needUpdateSize/1024/1024
local hasDown=string.format("%0.2f",fval*totalSize)
local total=string.format("%0.2f",totalSize)
local sKB=string.format("%0.2f",speed/1024)
local txtDownProcess='正在下载    '..hasDown..'M/'..total..'M('..sKB..'KB/S)'

updateState.updateWindow:set_CSGUIProgressBarAni(fval*100,100)
updateState.updateWindow:set_DialogText2(txtDownProcess)
if fval>=1 then
if not _updownloadProgress[100]then
_updownloadProgress[100]=true
logPoint.UploadLog(logPoint.logType.comeinGame_down100)
end
elseif fval>=0.8 then
if not _updownloadProgress[80]then
_updownloadProgress[80]=true
logPoint.UploadLog(logPoint.logType.comeinGame_down80)
end
elseif fval>=0.6 then
if not _updownloadProgress[60]then
_updownloadProgress[60]=true
logPoint.UploadLog(logPoint.logType.comeinGame_down60)
end
elseif fval>=0.4 then
if not _updownloadProgress[40]then
_updownloadProgress[40]=true
logPoint.UploadLog(logPoint.logType.comeinGame_down40)
end
elseif fval>=0.2 then
if not _updownloadProgress[20]then
_updownloadProgress[20]=true
logPoint.UploadLog(logPoint.logType.comeinGame_down20)
end
end
end


local downloadAllInGroup=function(errorcode,groupid,resSvnVersion)
updateState.updateWindow:SetVisableDialogText2(false)
if errorcode==nil then
_SetResourceVersion(serverVersion)
updateState.updateWindow:set_DialogText2('下载完成')

updateState:finish()
else

_retryDialog(errorcode)
end
end


local startDownload=function()
updateState.updateWindow:SetVisableDialogText2(true)
updateState.updateWindow:set_CSGUIProgressBarAni(0,100)
_StartDownloadGroup(5)
end


needUpdateSize=_SetDownloadGroup(BASE_GROUP,true,progressFunc,downloadAllInGroup,0)

if needUpdateSize==0 then
_SetResourceVersion(serverVersion)
updateState:finish()

elseif needUpdateSize<0 then
_retryDialog('未知错误')
else
startDownload()
end
end


function updateState:requireCommon()
if strict_if_strict then
strict_if_strict(false)
end
require"lua.common.__init"
if strict_if_strict then
strict_if_strict(true)
end
end

function updateState:finish()
logPoint.UploadLog(logPoint.logType.comeinGame_updateComplete)

if install_flag~=0 then
_SetVersionJsonByKey(INSTALL_FLAG_KEY,0)
end
local _reallyfinish=function()


local callback=function()

require('lua.gameState.loadState')
updateState:requireCommon()



_msg_handle.SendMessageDelay(_msg_type.APPLICATION_EVT_LUA_UPDATE_FINISH)
LuaApplication.changeState(loadState)
end
local fcount=0
_ReloadBinary(function()
fcount=fcount+1
if fcount>=2 then
callback()
end
end)
_ReloadConfig(function()
fcount=fcount+1
if fcount>=2 then
callback()
end
end)
end
if updateState.IsNeedReboot then
UIUpdateDialog.ShowDialogBox('提示','更新完毕,本次更新建议重启游戏',function()
updateState:doRestart()
end,_reallyfinish)
else
_reallyfinish()
end
end

function updateState.setLoadingProgress(txt,fval)
updateState.updateWindow:set_DialogText(txt)
updateState.updateWindow:set_CSGUIProgressBarAni(fval*100,100)
end

function updateState.closeLoading()
if updateState.updateWindow==nil then return end
updateState.updateWindow:close()
updateState.updateWindow=nil
end

function updateState:getCDN(jsonCDN)
local TEMP=string.gsub(jsonCDN,'%d+/CDN.json','')
return string.gsub(TEMP,'CDN.json','')
end




function updateState:doRestart()
local jsonStr=string.format("{\"delay\":%d}",0)
if deviceHelper.isRunIOS()then

elseif deviceHelper.isRunAndroid()then
androidTool.callFunc('DoRestart',jsonStr)
elseif deviceHelper.isRunMiniGame and deviceHelper.isRunMiniGame()then
_WXInterface.RestartMiniProgram(nil,nil,nil)
end
end
