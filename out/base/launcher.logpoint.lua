local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _Upload=CS.ResourceHelper.HttpGetRequest;
local _hasRole=nil


logPoint={}
local _log=Debugger.Log
local _t_concat=table.concat
function logPoint.printPoint(...)
local printPoint=_AppConfig_GetBool('printPoint',false)
if not printPoint then
return
end
local out={'[logPoint:]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_log(_t_concat(out,' '))
end
local cjson=require"cjson"


logPoint.logType={


['appStart']='as',

['comeinGame']='eg',

['comeinGame_checkVersion']='eg_cv',

['comeinGame_downloadUpdate']='eg_du',

['comeinGame_down20']='eg_dn_20',

['comeinGame_down40']='eg_dn_40',

['comeinGame_down60']='eg_dn_60',

['comeinGame_down80']='eg_dn_80',

['comeinGame_down100']='eg_dn_100',

['comeinGame_reStart']='eg_rs',

['comeinGame_updateComplete']='eg_uc',

['initComplete']='sc',

['comeinGame_showUpdateTips']='eg_sut',

['sdkLoginComplete']='slc',

['reqLoginGame_clickGongGao']='rlg_cgg',

['reqLoginGame_clickChoiceServer']='rlg_ccs',

['reqLoginGame_clickentergame']='rlg_ceg',

['reqLoginGame']='rlg',

['createRole_clickCreatRole']='crc',

['enterGameSuccess']='ess',

['clickFirstTask']='cst',







['reqLoginGame_clickBack']='crc_cb',

['loadScene']='lgs',

['createRole_creatRoleSuccess']='crc_crs',

['createRole_clickRoleName']='crc_crn',

['shake1']='sk1',

['shake2']='sk2',

['downloadAPK']='dla',

['reqLoginGame_clickKeFu']='rlg_ckf',

['reqLoginGame_clickZhangHao']='rlg_czh',
}

logPoint.platform=nil;

function logPoint.getPlatformName()
if logPoint.platform==nil then
logPoint.platform=deviceHelper.getRuntimePlatformStr()
end
return logPoint.platform;
end


logPoint.uploadURL=nil;
function logPoint.GetUploadURL()
if logPoint.uploadURL==nil then
logPoint.uploadURL=_AppConfig_GetString('logUploadURL_Release','')
end
return logPoint.uploadURL
end


function logPoint.GetLogStr(logType,exts)


















local pfid=gameInfo:getPfid()or 0
local sid='';
local account='';
local kingdom=logType;
exts=tostring(exts or'')
local ip=deviceHelper.getUserAddress()or'';
local instime=tostring(os.time())
local channelID=gameInfo:getChannelID()or 0
local imei=string.format('*%s',tostring(deviceHelper.getIMEI())or'')
local model=deviceHelper.getSystemModel()or''
local systemnum=deviceHelper.getSystemVersion()or''
local phonefac=deviceHelper.getDeviceBrand()or''

local temp={
pfid=gameInfo:getPfid()or 0,
sid='',
account='',
kingdom=logType,
device_type=exts or'',
ip=deviceHelper.getUserAddress()or'',
instime=tostring(os.time()),
channel=gameInfo:getChannelID()or 0,
imei=imei,
model=deviceHelper.getSystemModel()or'',
systemnum=deviceHelper.getSystemVersion()or'',
phonefac=deviceHelper.getDeviceBrand()or'',
}

local logStr="counter=load"
for k,v in pairs(temp)do
logStr=string.format('%s&%s=%s',logStr,k,v)
end



return logStr,tostring(ip),tostring(instime),string.format('%s|%s|%s|%s|%s|%s',pfid,channelID,sid,account,imei,phonefac)

end


function logPoint.UploadLog(logType)

platformLogPoint.otherPFLogPoint(logType)

local isCreateRole=logType==logPoint.logType.createRole_clickCreatRole

local hasRole=logPoint.hasRole()
if hasRole and not isCreateRole then
logPoint.printPoint(string.format('打点 %s ！已有角色不上报！',tostring(logType)))
return
end

if deviceHelper.isRunNoneOrEditor()then
logPoint.printPoint(string.format('打点 %s ！NoneOrEditor不上报！',tostring(logType)))
return
end

local logStr=logPoint.GetLogStr(logType)
if logStr==''then
logPoint.printPoint(string.format('打点 %s ！logStr == null不上报！',tostring(logType)))
return
end

local lpURL=logPoint.GetUploadURL()
if lpURL==''then
logPoint.printPoint(string.format('打点 %s ！没有打点地址不上报！',tostring(logType)))
return
end

local url=string.format("%s?%s",lpURL,logStr)
logPoint.printPoint('打点上报:'..url)
_Upload(url,function(content,err)
logPoint.printPoint(string.format('打点结果：%s',tostring(content)))
end)
end

function logPoint.getExts(logType)
if logType==logPoint.logType.appStart then
return string.format('%s*%s',deviceHelper.getNetworkCode(),tostring(deviceHelper.getNetworkType()))
end
end


logPoint.isLogPHP=nil
function logPoint.isLog()
if logPoint.isLogPHP==nil then
logPoint.isLogPHP=_AppConfig_GetBool('printPoint',true);
end
return logPoint.isLogPHP;
end


function logPoint.UploadLogAppStart()
local opencount=deviceHelper.getOpenAppCount()
if opencount==1 then
platformLogPoint.otherPFLogPoint(logPoint.logType.appStart)

end
end


local _config=nil


function logPoint.Init()


_config=jsonHelper.readFile('device.json')or{}
end

function logPoint.SetValue(key,value)
if not _config then
logPoint.Init()
end
_config[key]=value
end

function logPoint.GetValue(key,defaultValue)
if not _config then
logPoint.Init()
end
return _config[key]or defaultValue
end

function logPoint.Remove(key)
if _config then
_config[key]=nil
end
end

function logPoint.Flush()

jsonHelper.writeFile('device.json',_config)
end

function logPoint.record(key,value)
logPoint.SetValue(key,value)
logPoint.Flush()
end

function logPoint.checkHasRole(force)
if _hasRole==nil or force==true then
_hasRole=logPoint.GetValue('hasRole',false)
end
end

function logPoint.hasRole()
return _hasRole
end



























