loginSeverType=
{
eRole=1,
eLast=2,
eTuijian=3,
eZone=4,
eTheme=5,
}

loginServerStatus=
{
eNew=1,
eNomal=2,
ePause=3,
}

function loginModel:resetLoginInfo()

self.loginSDKInfo={}
self.loginSDKParams={}



self.phpLoginParam=''
self.phpLoginInfo={}
self.phpParamData={}


self.lastServerList=nil
self.roleServerList=nil
self.tuijianServerList=nil
self.zoneServerInfo=nil
self.zoneServerList={}
self.tuijianServerCacheList=nil
self.tuijianServerCacheFlag=nil
end







function loginModel:setLoginInfo(info)
self.phpLoginInfo=info
userGlobalSetting.set('login_ip',info.login_ip)
userGlobalSetting.set('nickname',info.nickname)
userGlobalSetting.set('roleCount',info.roleCount)

loginModel:setUserId(tostring(info.user or''))
loginModel:setUserPassword(tostring(info.pwd)or'')
loginModel:setCurServer_id(tonumber(info.srvid or 0))
loginModel.server_ip=tostring(info.srvaddr or 0)
loginModel.server_port=tonumber(info.srvport or 0)

loginModel:setBeforeServer_id(tonumber(info.serverid or 0))
loginModel.sever_statue=tonumber(info.server_status or 0)
end

function loginModel:setCurServer_id(server_id)
loggerUtil.logFMT('setCurServer_id:{0}',server_id)
loginModel.server_id=server_id
end

function loginModel:setBeforeServer_id(server_id)
loggerUtil.logFMT('setBeforeServer_id:{0}',server_id)
loginModel.be_server_id=server_id
end

function loginModel:getLoginInfo()
return self.phpLoginInfo
end


function loginModel:setPhpParam(param)
self.phpLoginParam=param

if param~=nil then
self.phpParamData={}
for key,value in string.gmatch(param,"([^&]+)=([^&]+)")do
self.phpParamData[key]=value

if key=='time'then
local stamp=Time.realtimeSinceStartup
loginModel:setSinceStamp(stamp)
end
end
end
end

function loginModel:getPhpParam()
return self.phpLoginParam
end


function loginModel:getServerCurTimestamp()
return tonumber(self.phpParamData['time'])
end


function loginModel:getServerRealCurTimestamp()
if not deviceHelper.isRunNoneOrEditor()then
return tonumber(self.phpParamData['time'])+Time.realtimeSinceStartup-loginModel:getSinceStamp()
end
end

function loginModel:setSinceStamp(stamp)
self.sinceStamp=stamp
end

function loginModel:getSinceStamp()
return self.sinceStamp or 0
end



function loginModel:setLastServerList(serverlist)
self.lastServerList=serverlist
end

function loginModel:getLastServerList()
return self.lastServerList
end


function loginModel:setRoleServerList(serverlist)
self.roleServerList=serverlist
end

function loginModel:getRoleServerList()
return self.roleServerList
end


function loginModel:setTuiJianServerList(serverlist)
self.tuijianServerList=serverlist
loginModel:setTuiJianServerCacheList(serverlist)
end

function loginModel:getTuiJianServerList()
return self.tuijianServerList
end


function loginModel:setTuiJianServerCacheList(serverlist)
if not self.tuijianServerCacheFlag then return end
loginModel:setTuiJianServerCacheFlag(false)
if self.tuijianServerCacheList==nil or#self.tuijianServerCacheList==0 then
self.tuijianServerCacheList=table.deepCopy(serverlist)
end
end

function loginModel:getTuiJianServerCacheList()
return self.tuijianServerCacheList
end

function loginModel:setTuiJianServerCacheFlag(flag)
self.tuijianServerCacheFlag=flag
end

function loginModel:getTuiJianServerCacheFlag()
return self.tuijianServerCacheFlag
end


function loginModel:setZoneServerList(page,list)
self.zoneServerList[page]=list
end

function loginModel:getZoneServerList(page)
return self.zoneServerList[page]or{}
end


function loginModel:hasServerZoneInfo()
return self.zoneServerInfo~=nil
end

function loginModel:applyZoneCache(clear)
loginModel:loadZoneCache(clear)
self.zoneServerInfo=self.zoneInfoCache
end


function loginModel:setServerZoneInfo(info)
self.zoneServerInfo=info
loginModel:flushZoneCache(info)
end

function loginModel:getServerZoneInfo()
return self.zoneServerInfo
end

function loginModel:getServerZoneLen()
return#(self.zoneServerInfo or{})
end


function loginModel:getServerZoneInfoDataByServerID(serverid)
local list=self.zoneServerInfo or{}
for i,v in ipairs(list)do
if tonumber(v.start_id)<=serverid and serverid<=tonumber(v.end_id)then
return v
end
end
end

function loginModel:isMySameServerZoneByServerID(serverid)
local myServer=loginModel.server_id
local serverZone=loginModel:getServerZoneInfoDataByServerID(myServer)
if serverZone then
return tonumber(serverZone.start_id)<=serverid and serverid<=tonumber(serverZone.end_id)
end
return false
end

function loginModel:getThemeSeverInfo()
local pfid=loginModel:getPfid()
local list={}
local configTheme=cfg_themeservernameconfig()
local stamp=os.time()
local sStamp=loginModel:getServerRealCurTimestamp()

for i,v in ipairs(configTheme)do
local date=v.time
if(v.showcfgname and v.showcfgname[pfid])then
local begindate=v.begintime
local datebeginStamp=timeHelper.timeServer(begindate[1],begindate[2],begindate[3],begindate[4],begindate[5],begindate[6])
local dateStamp=timeHelper.timeServer(date[1],date[2],date[3],date[4],date[5],date[6])
if sStamp then
if dateStamp>=sStamp and datebeginStamp<=sStamp then
table.insert(list,v)
end
else
if dateStamp>=stamp and datebeginStamp<=stamp then
table.insert(list,v)
end
end
end
end
return list
end

function loginModel:testThemeSeverTime(hour,min,sec)
local configTheme=cfg_themeservernameconfig()
for i,v in ipairs(configTheme)do
v.time[4]=hour
v.time[5]=min
v.time[6]=sec
end
end



function loginModel:setLoginSDKInfo(info)
assert(next(info)~=nil)
self.loginSDKInfo=info
assert(info.username,'账号username不能为空')
loginModel:setUserName(info.username)
end

function loginModel:isLoginSDKInfoNull()
return self.loginSDKInfo==nil
end



function loginModel:getLoginSDKInfo()
return self.loginSDKInfo
end


function loginModel:getAccount()
if not self.isLogin then return''end
local sdkInfo=loginModel.loginSDKInfo or{}
return sdkInfo.username
end


function loginModel:setSDKParam(info)
self.loginSDKParams=info
end

function loginModel:getSDKParam()
return string.unicodeURL(self.loginSDKParams,true)
end
