

local _zoneCacheKey='zoneCache'
local _zoneCacheTimeKey='zoneCacheTime'
local _requestList={}


function loginModel:loadZoneCache(clear)
self.zoneInfoCache=userGlobalSetting.get(_zoneCacheKey,nil)
if self.zoneInfoCache==nil then return end
local laststamp=userGlobalSetting.get(_zoneCacheTimeKey,0)
local stamp=os.time()
if clear==true or#self.zoneInfoCache==0 or stamp>(laststamp+86400)then
self.zoneInfoCache=nil
userGlobalSetting.record(_zoneCacheKey,nil)
userGlobalSetting.record(_zoneCacheTimeKey,nil)
end
end

function loginModel:flushZoneCache(info)
self.zoneInfoCache=info
userGlobalSetting.record(_zoneCacheKey,info)
userGlobalSetting.record(_zoneCacheTimeKey,os.time())
end



function loginModel:getServerName(serverid,default)
if serverid==nil then return end
if deviceHelper.isRunNoneOrEditor()and not appUtils.testPHP then
return default or string.format('%d服',serverid)
end

if serverid==0 then return default or"未知区服"end

local info=loginModel:getCrossServerInfoByServer(serverid)
if info then return info.name end

loginRequestUpdate:addRequest(REQUEST_TYPE.eRequestServer,serverid)

platformSDK.printSDK(string.format('没找到服务器名称:%d',serverid))


return default or string.format('s%d',serverid),false
end

function loginModel:getServerNameEx(serverid,default)
local _sName,_sCheck=self:getServerName(serverid)
return _sCheck~=false and _sName or default
end


function loginModel:getZoneName(serverid,default)
if serverid==nil then return end
if deviceHelper.isRunNoneOrEditor()and not appUtils.testPHP then
return default or'默认区服'
end

local info=loginModel:getCrossServerInfoByServer(serverid)
if info then return info.zone_name end

loginRequestUpdate:addRequest(REQUEST_TYPE.eRequestServer,serverid)

platformSDK.printSDK(string.format('没找到大区名称:%d',serverid))

return default or string.format('z%d',serverid),false
end

function loginModel:getMyServerName()
local name=self:getServerName(self.server_id)
return name
end

function loginModel:isMyServer(server_id)
return self.server_id==server_id
end

function loginModel:onRecvAllServerList(cross_sid,len,array)
local oldcross=self.cross_sid
self.cross_sid=cross_sid
self.crossServerlists=array


end

function loginModel:addAllServerData(data)
if self.crossServerInfo==nil then self.crossServerInfo={}end
if self.crossServerLookup==nil then self.crossServerLookup={}end

for cross_sidStr,info in pairs(data)do
local cross_sid=tonumber(cross_sidStr)
self.crossServerInfo[cross_sid]={}
self.crossServerInfo[cross_sid].zone_name=info[1]and info[1].zone_name or nil
for _,v in ipairs(info)do
local sid=tonumber(v.sid)
v.sid=sid
self.crossServerInfo[cross_sid][sid]=v
self.crossServerLookup[sid]=cross_sid
end
end
end

function loginModel:addServerData(data)
if self.crossServerInfo==nil then self.crossServerInfo={}end
if self.crossServerLookup==nil then self.crossServerLookup={}end

for _,info in pairs(data)do
if info.cross_sid~=''then
local cross_sid=tonumber(info.cross_sid)
local sid=tonumber(info.sid)
if sid~=nil then
if self.crossServerInfo[cross_sid]==nil then
self.crossServerInfo[cross_sid]={}
self.crossServerInfo[cross_sid].zone_name=info.zone_name
end
info.sid=sid
self.crossServerInfo[cross_sid][sid]=info
self.crossServerLookup[sid]=cross_sid
end
end
end
end


function loginModel:gm_FakeAddAllServerData()
local data={
["55035"]={
{
["sid"]="91",
["name"]="内网公共1服",
["zone_name"]="第一大区"
},
{
["sid"]="94",
["name"]="内网公共1服",
["zone_name"]="第一大区"
}
}
}
loginModel:addAllServerData(data)
end

function loginModel:hasCrossServerData(cross_sid)
return loginModel:getCrossServerInfo(cross_sid)~=nil
end

function loginModel:hasServerData(sid)
return loginModel:getCrossSid(sid)~=nil
end

function loginModel:getCrossSid(sid)
return self.crossServerLookup and self.crossServerLookup[sid]or nil
end

function loginModel:getCrossServerInfo(cross_sid)
return self.crossServerInfo and self.crossServerInfo[cross_sid]or nil
end

function loginModel:getCrossZoneName(cross_sid,default)
if deviceHelper.isRunNoneOrEditor()and not appUtils.testPHP then
return default or FMT.fmt('{0}区',cross_sid)
end
local crossServerInfo=loginModel:getCrossServerInfo(cross_sid)
if crossServerInfo then return crossServerInfo.zone_name end

loginRequestUpdate:addRequest(REQUEST_TYPE.eRequestCross,cross_sid)

platformSDK.printSDK(string.format('跨服id 没找到大区名称:%d',cross_sid))

return default or FMT.fmt('{0}区',cross_sid)
end

function loginModel:getCrossServerInfoByServer(sid)
local cross_sid=loginModel:getCrossSid(sid)
if cross_sid then
local lookup=loginModel:getCrossServerInfo(cross_sid)
return lookup[sid]
end
end

function loginModel:getServerList()
return self.crossServerlists
end

function loginModel:getCrossServerId()
return self.cross_sid
end


function loginModel:onRecvAllBigCrossActList(len,actlist)
self.bigCrossActList={}
if len>0 then
for i,v in ipairs(actlist)do
self.bigCrossActList[v]=true
end
end
end

function loginModel:checkBigCrossActOpen(actType)
if self.bigCrossActList then
return self.bigCrossActList[actType]
end
return false
end



