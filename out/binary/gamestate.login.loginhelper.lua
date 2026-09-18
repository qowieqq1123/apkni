loginHelper={}
local _GetIMEI=CS.GameInterface.GetIMEI

function loginHelper.convertServerID(serverID)
local sid=tonumber(serverID)

return sid
end

function loginHelper.getActorID()
return playerModel:getActorID()or UICreateRoleModel:getRoleId()
end

function loginHelper.getActorName()
return playerModel:getActorName()or UICreateRoleModel:getRoleName()
end

function loginHelper.getActorLv()
return playerModel:getActorLevel()or UICreateRoleModel:getRoleLv()
end


function loginHelper.overrideLogPointLogStr()
logPoint.GetLogStr=function(logType,exts)














local info=loginModel.phpLoginInfo or{}
local channelID=loginModel:getChannelID()
local pfid=tostring(loginModel:getPfid()or'')
local sid=tostring(info.srvid or'')
local account=info.user or loginModel.userid or''
local kingdom=logType
local actorname=loginHelper.getActorName()or''
local actorlevel=tostring(loginHelper.getActorLv()or'')
local sdkIMEI=appUtils.getSDKIMEI()
exts=tostring(exts or'')
local ip=info.login_ip or deviceHelper.getUserAddress()or''
local isnew=tostring(info.isnew or 0)
local instime=tostring(os.time())
local imei=string.format('%s*%s',sdkIMEI,tostring(deviceHelper.getIMEI())or'')
local model=deviceHelper.getSystemModel()or''
local systemnum=deviceHelper.getSystemVersion()or''
local phonefac=deviceHelper.getDeviceBrand()or''
local wifi_name=loginModel.wifi_name or''

local temp={
channel=loginModel:getChannelID(),
pfid=tostring(loginModel:getPfid()or''),
sid=tostring(info.srvid or''),
account=info.user or loginModel.userid or'',
kingdom=logType,
device_type=exts,
ip=info.login_ip or deviceHelper.getUserAddress()or'',
isnew=tostring(info.isnew or 0),
instime=tostring(os.time()),
imei=imei,
model=deviceHelper.getSystemModel()or'',
systemnum=deviceHelper.getSystemVersion()or'',
phonefac=deviceHelper.getDeviceBrand()or'',
}


if webGLHelper:isRunMiniGame()then
local devInfo=webGLHelper:getDeviceInfo()
local sysInfo=webGLHelper:getSystemInfoSync()
if devInfo and sysInfo then
temp.model=FMT.fmt('{0}_{1}_{2}_{3}',sysInfo.model,devInfo.memorySize,devInfo.cpuType,devInfo.benchmarkLevel)
temp.systemnum=FMT.fmt('{0}_{1}',sysInfo.system,sysInfo.version)
temp.phonefac=FMT.fmt('{0}_{1}',sysInfo.platform,sysInfo.brand)
end
end

local logStr="counter=load"
for k,v in pairs(temp)do
logStr=string.format("%s&%s=%s",logStr,k,v)
end



return logStr,tostring(ip),tostring(instime),string.format('%s|%s|%s|%s|%s|%s|%s',pfid,channelID,sid,account,isnew,wifi_name,model)
end
end

logPoint.logExtType=
{

['openVideo']='ovi',

['startVideo1']='svi1',

['startVideo2']='svi2',

['startVideo3']='svi3',

['reqSDKLogin']='eg_slc',

['SDKInitFail']='eg_ifl',

['SDKInitSuccess']='eg_suc',

['SDKLoginFail']='slc_fl',

['SDKInitNoRet']='slc_nr',

['connectSocketFail']='cs_fl',

['connectServerFail']='css_fl',
}
