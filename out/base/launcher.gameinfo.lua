gameInfo={}
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _logInfo=Debugger.Log
local _t_concat=table.concat
local _cjson=require'cjson'

local _log=function(...)
local printSDK=_AppConfig_GetBool('printSDK',false)
local testPHP=_AppConfig_GetBool('testPHP',false)
if not testPHP and(deviceHelper.isRunEditor()or not printSDK)then return end

local out={'[gameInfo]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_logInfo(_t_concat(out,' '))
end


local __infoURLs=nil


local _getURL=function()

if __infoURLs==nil then
__infoURLs={}
__infoURLs[#__infoURLs+1]=_AppConfig_GetString('infoURL','')

local url=_AppConfig_GetString('infoURL1','')
if url~=''then
__infoURLs[#__infoURLs+1]=url
end

url=_AppConfig_GetString('infoURL2','')
if url~=''then
__infoURLs[#__infoURLs+1]=url
end


if deviceHelper.isRunNoneOrEditor()then
__infoURLs={}
__infoURLs[1]=_AppConfig_GetString('infoURLNeiWang','http://10.10.1.49:89/cysh/api/getpfinfo')
end
end

return __infoURLs
end

function gameInfo:unicodeURL(jsonStr)
local st={}
for k,v in pairs(jsonStr)do
st[#st+1]='&'
st[#st+1]=tostring(k)
st[#st+1]='='
st[#st+1]=tostring(v)
end
local str=_t_concat(st,"")
return str
end



function gameInfo:checkFileCacheMode(mode)
if deviceHelper.getAPILevel()>290 then
local fcm=_WXInterface.GetFileCacheMode()
return fcm==mode
end
return false
end


function gameInfo:getPackageCDNURL()
if not self.packageCDNURL then
local dataStr=CS.WebGLSDKHelper.CallSDKFuncSync('get_base_info','')
local data=jsonHelper.decode(dataStr)
self.packageCDNURL=data.packageCDNURL
end
return self.packageCDNURL
end


function gameInfo:setAutoFileCacheURL()
if gameInfo:checkFileCacheMode(1)then
local cdnURL=gameInfo:getParams('cdnURL')
if cdnURL and not string.find(cdnURL,'GameAssets')then
cdnURL=cdnURL..'GameAssets/'
self.phpCfg['cdnURL']=cdnURL
_log('自动缓存模式替换cdn路径',cdnURL)
end
end
end


function gameInfo:setPhpCfg(cfg)
self.phpCfg=cfg
self.isInit=true
self.needFreshEntryURL=false
gameInfo:setAutoFileCacheURL()
end

function gameInfo:getChannelID()
if self.isInit then
return self.phpCfg.chid
end
logErr('没有初始化php配置')
end

function gameInfo:getPfid()
if self.isInit then
return self.phpCfg.pfid
end
logErr('没有初始化php配置')
end

function gameInfo:getPfname()
if self.isInit then
return self.phpCfg.pfname
end
logErr('没有初始化php配置')
end

function gameInfo:getEntryURL()



local cdnURL=gameInfo:getParams('cdnURL')
if cdnURL~=nil then
local cdnVersion=gameInfo:getParams('cdnVersion')

if gameInfo:checkFileCacheMode(1)then
local resVersion=CS.AppDataModel.GetResourceVersion()
if resVersion>cdnVersion then
cdnVersion=resVersion
end
end

local limitAPI=gameInfo:getLimitAPIVersion()
if limitAPI then
local api=deviceHelper.getAPILevel()
if api<=limitAPI then
local limitVersion=gameInfo:getLimitRESVersion()
if limitVersion then
cdnVersion=limitVersion
_log('启用资源版本限制：',api,limitAPI,cdnVersion,limitVersion)
end
end
end
return cdnURL..cdnVersion..'/CDN.json'
else
return gameInfo:getParams('entryURL')
end
end

function gameInfo:getServerZoneURL()
return gameInfo:getParams('serverZoneURL')
end

function gameInfo:getLastServerListURL()
return gameInfo:getParams('lastServerListURL')
end

function gameInfo:getServerListURL()
return gameInfo:getParams('serverListURL')
end

function gameInfo:getLoginURL()
return gameInfo:getParams('loginURL')
end

function gameInfo:getGongGaoURL()
return gameInfo:getParams('noticeURL')
end

function gameInfo:getGongGaoTypeURL()
return gameInfo:getParams('noticeNumURL')
end

function gameInfo:getGMLoginURL()
return gameInfo:getParams('gmloginURL')
end

function gameInfo:getRoleListURL()
return gameInfo:getParams('roleListURL')
end

function gameInfo:getAPPVersion()
return gameInfo:getParams('APPVersion')
end

function gameInfo:getAPPEntryURL()
return gameInfo:getParams('APPEntryURL')
end

function gameInfo:getQestionnaireURL()
return gameInfo:getParams('questionnaireURL')
end

function gameInfo:getUpdateInvoke()
return gameInfo:getParams('updateInvoke')
end

function gameInfo:getLimitAPIVersion()
return gameInfo:getParams('limitAPIVersion')
end

function gameInfo:getLimitRESVersion()
return gameInfo:getParams('limitRESVersion')
end


function gameInfo:getParams(name)
if self.isInit then
return self.phpCfg[name]
end
logErr('没有初始化php配置')
end


function gameInfo:getGameId()
return _AppConfig_GetString('gameId','')
end

function gameInfo:setEntryURLTag(flag)
self.needFreshEntryURL=flag
end

function gameInfo:initAndCheckVerify(cb)
local verifyid=_AppConfig_GetString('verifyid','')
local url=_AppConfig_GetString('https_url','')
if verifyid==''or url==''then
updateState.filterServer=false
gameInfo:init(cb)
return
end

local vcb
vcb=function(message,err)
if err==nil or err==''then

local values={}

for value in string.gmatch(tostring(message),"[^,]+")do
table.insert(values,value:match("^%s*(.-)%s*$"))
end

local found=false
for _,value in ipairs(values)do
if value==verifyid then
found=true
break
end
end

if found then
updateState.filterServer=true
require'tolua.launcher.updateState.verifyData'
local scb=function()
self:setPhpCfg(verifyData:getPFInfo())
if cb then
cb()
end
end

if deviceHelper.isRunWebGL()or deviceHelper.isRunAndroid()then
verifyData:loadDataFromServer(scb)
else
verifyData:loadData()
scb()
end
else
updateState.filterServer=false
gameInfo:init(cb)
end
else
UIUpdateDialog.ShowDialogBox('警告','网络连接异常，请重试',function()_httpGetRequest(url,vcb)end,nil,false)
end
end
_httpGetRequest(url,vcb)
end

function gameInfo:init(cb)
local testPHP=_AppConfig_GetBool('testPHP',false)

local needReq=(not self.isInit or self.needFreshEntryURL==true)and
(not deviceHelper.isRunNoneOrEditor()or testPHP)

if not needReq then
_log('入口信息已初始化，回调直接执行:')
if cb then
cb()
end
return
end


local callback=nil
callback=function(message,err)
_log('入口信息回调:',message,err)
if err==""or not err then
local json_table={}
local s,e=pcall(function()
json_table=_cjson.decode(message)
end)
if s then
self:setPhpCfg(json_table)
if cb then
cb()
end
else
_log('入口信息解析失败:',message)
UIUpdateDialog.ShowDialogBox('提示','入口解析失败，游戏无法进行',LuaApplication.QuitGame)
end
else
local urls=_getURL()
if self.reqIndex<=#urls then
self:reqInfo(callback)
else
self.reqIndex=1
_log('入口信息请求失败:',message,err)
UIUpdateDialog.ShowDialogBox('提示','网络异常，是否重新连接？',function()
gameInfo:init(cb)
end,LuaApplication.QuitGame)
end

end
end

self.reqIndex=1
self:reqInfo(callback)
end


function gameInfo:reqInfo(cb)
local urls=_getURL()
local url=urls[self.reqIndex]
self.reqIndex=self.reqIndex+1
local gameId=gameInfo:getGameId()
local tag=deviceHelper.getRuntimePlatformTag()
local testPHP=_AppConfig_GetBool('testPHP',false)
if testPHP and deviceHelper.isRunNoneOrEditor()then gameId=6324 end
local urlStr=url..'?channelid='..gameId..'&os='..tag
_log('请求入口信息:',urlStr)





_httpGetRequest(urlStr,cb)

end