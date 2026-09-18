injectAppConfig={}


function injectAppConfig.verifyAppConfigVersion(version)
if updateState.CDNInfo==nil then
UIManager.error('没有版本信息')
end
local cdnName=updateState.CDNInfo.assetbundleServerInfo
cdnName=string.gsub(cdnName,'^%d+/',FMT.fmt("{0}/",version))
cdnName=string.gsub(cdnName,'assetbundleServerInfo.bytes','CDN.json')
local key='test_updatelist_url'
local val=FMT.fmt("{0}/{1}",updateState.CDNInfo.CDNURL,cdnName)

local function CDNDownloaded(errorcode,content)
if errorcode then
UIManager.error(FMT.fmt('Error:【{0}】设置版本号失败',val))
return
end


local cfgContent
if webGLHelper:isRunWebGL()then
cfgContent=injectAppConfig.getAppConfigContentWebGL()
else
cfgContent=injectAppConfig.getAppConfigContent()
end
cfgContent=FMT.fmt("{0}\n{1}:{2}",cfgContent,key,val)
cfgContent=FMT.fmt("{0}\ntest_cdn_url:{1}",cfgContent,gameInfo:getParams('cdnURL'))
cfgContent=FMT.fmt("{0}\ntest_cdn_version:{1}",cfgContent,version)

fileHelper.writeFileEx("AppConfig.json",cfgContent)




UIManager.error(FMT.fmt('设置版本号:【{0}】成功',version))
end

CS.ResourceHelper.DownloadCDNData(val,nil,CDNDownloaded)
end

function injectAppConfig.verifyGameId(gameId)
CS.AppDataModel.SetAppConfigJsonStringValue('gameId',gameId)
end

function injectAppConfig.verifyAppConfig(str)
CS.AppDataModel.SetAppConfigJsonKeyArray(str)
end

function injectAppConfig.clearAppConfigTestURL()
local key='test_updatelist_url'
local val=CS.AppDataModel.AppConfig_GetString(key,'')
if val==nil or val==''then return end
local filename=FMT.fmt("{0}/AppConfig.json",CS.GamePath.writablePath)
local f=io.open(filename,'r')
local temp=''
for line in f:lines()do
if not string.findStr(line,key)then
if temp==''then
temp=line
else
temp=temp..'\n'..line
end
end
end
f:close()
fileHelper.writeFile(filename,temp)
end



function injectAppConfig.getAppConfigContent()
local content=[[
#	打印等级 1 普通,警告,错误，2,警告,错误, 3 错误， 3+ 不打印
log:1
#	打印文件名
logFile:log.txt
#	启用文件打印
log.enableFileLog:true
#	启用文件错误打印
log.enableErrFileLog:true
#	刷新时才会写日志文件，必须启用文件打印才有效（必须开enableErrFileLog才能刷新红点）
log.onlySaveLog:true
#	显示c#所有打印
enableLog:false
#	sdk相关lua打印
printSDK:true
#	收发协议打印
printProtcolData:true
#	java代码打印
printJavaLog:true
#  	php上报打印
printPoint:true
#	http请求打印
printHttp:true
#  	保存cdn日志
isLogCDNFile:false
#	打开gm窗口
showGM:true
# 	错误显示界面（c#界面）	1、显示 0 不显示（c#界面）
strict_mode:0
#	错误显示界面（lua界面)
uploadFileLog:false]]
return content
end


function injectAppConfig.getAppConfigContentWebGL()
if api_Available_WriteLogContentToFile()then
local content=[[
#	打印等级 1 普通,警告,错误，2,警告,错误, 3 错误， 3+ 不打印
log:1
#	打印文件名
logFile:log.txt
#	启用文件打印
log.enableFileLog:true
#	启用文件错误打印
log.enableErrFileLog:true
#	刷新时才会写日志文件，必须启用文件打印才有效（必须开enableErrFileLog才能刷新红点）
log.onlySaveLog:true
#	显示c#所有打印
enableLog:false
#	sdk相关lua打印
printSDK:true
#	收发协议打印
printProtcolData:false
#	java代码打印
printJavaLog:false
#  	php上报打印
printPoint:false
#	http请求打印
printHttp:false
#  	保存cdn日志
isLogCDNFile:false
#	打开gm窗口
showGM:true
# 	错误显示界面（c#界面）	1、显示 0 不显示（c#界面）
strict_mode:0
#	错误显示界面（lua界面)
uploadFileLog:true]]
return content
else
local content=[[
#	打印等级 1 普通,警告,错误，2,警告,错误, 3 错误， 3+ 不打印
log:1
#	打印文件名
logFile:log.txt
#	启用文件打印
log.enableFileLog:false
#	启用文件错误打印
log.enableErrFileLog:true
#	显示c#所有打印
enableLog:false
#	sdk相关lua打印
printSDK:true
#	收发协议打印
printProtcolData:false
#	java代码打印
printJavaLog:false
#  	php上报打印
printPoint:false
#	http请求打印
printHttp:false
#  	保存cdn日志
isLogCDNFile:false
#	打开gm窗口
showGM:true
# 	错误显示界面（c#界面）	1、显示 0 不显示（c#界面）
strict_mode:0
#	错误显示界面（lua界面)
uploadFileLog:true]]
return content
end
end


function injectAppConfig.getAppConfigContentEX()
local content=[[
#	打印等级 1 普通,警告,错误，2,警告,错误, 3 错误， 3+ 不打印
log:1
#	打印文件名
logFile:log.txt
#	启用文件打印
log.enableFileLog:true
#	启用文件错误打印
log.enableErrFileLog:true
#	刷新时才会写日志文件，必须启用文件打印才有效（必须开enableErrFileLog才能刷新红点）
log.onlySaveLog:true
#	显示c#所有打印
enableLog:false
#	sdk相关lua打印
printSDK:true
#	收发协议打印
printProtcolData:true
#	java代码打印
printJavaLog:true
#  	php上报打印
printPoint:true
#	http请求打印
printHttp:true
#  	保存cdn日志
isLogCDNFile:false
#	打开gm窗口
showGM:false
# 	错误显示界面（c#界面）	1、显示 0 不显示（c#界面）
strict_mode:0
#	错误显示界面（lua界面)
uploadFileLog:false]]
return content
end


function injectAppConfig.createLogAppConfig(check)
local filename=FMT.fmt("{0}/AppConfig.json",CS.GamePath.writablePath)
if check then
local f=io.open(filename,'r')
if f then

return
end
end
local content=injectAppConfig.getAppConfigContent()
local f=io.open(filename,'w')
f:write(content)
f:close()
end


function injectAppConfig.createLogAppConfigEx(check)
local filename=FMT.fmt("{0}/AppConfig.json",CS.GamePath.writablePath)
if check then
local f=io.open(filename,'r')
if f then
return
end
end
local content=injectAppConfig.getAppConfigContentEX()
local f=io.open(filename,'w')
f:write(content)
f:close()
end

function injectAppConfig.createEmptyConfig()
local filename=FMT.fmt("{0}/AppConfig.json",CS.GamePath.writablePath)
local content="#	一个占位文件"
local f=io.open(filename,'w')
f:write(content)
f:close()
end

if deviceHelper.isRunWebGL()then
injectAppConfig.createLogAppConfig=function(check,version)
local fileName=fileHelper.getFullPath('AppConfig.json')
if check then
if fileHelper.isFileExists(fileName)then
return
end
end
local content
if version==1 then
content=injectAppConfig.getAppConfigContent()
else
content=injectAppConfig.getAppConfigContentWebGL()
end
fileHelper.writeFile(fileName,content)


if webGLHelper:isRunWeiXin()then
webGLHelper:setEnableDebug(true)
end


if webGLHelper:isRunWebGLOnly()then
CS.WebGLSDKHelper.SyncDB()
end
end
end


function injectAppConfig.SetAppConfigEnableFileLog(value)
CS.AppDataModel.SetAppConfigJsonStringValue("log.enableFileLog",value)
end

