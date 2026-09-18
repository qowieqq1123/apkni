loginRequestUpdate={}

local _data={}
local _timer={}
local _notify={}

REQUEST_TYPE=
{
eRequestServer=1,
eRequestCross=2,
}

local _requestFunc=
{
[REQUEST_TYPE.eRequestServer]=
{
add=function(...)
return loginRequestUpdate:addRequestServerData(...)
end,
request=function(...)
loginRequestUpdate:requestServer(...)
end,
},
[REQUEST_TYPE.eRequestCross]=
{
add=function(...)
return loginRequestUpdate:addRequestCrossData(...)
end,
request=function(...)
loginRequestUpdate:requestCross(...)
end,
}
}




function loginRequestUpdate:registerRequest(requestType,func)
if _notify[requestType]==nil then _notify[requestType]={}end
_notify[requestType][func]=true
end

function loginRequestUpdate:unregisterRequest(requestType,func)
if _notify[requestType]==nil then _notify[requestType]={}end
_notify[requestType][func]=nil
end

function loginRequestUpdate:addRequest(requestType,...)
local cfg=_requestFunc[requestType]
if cfg then
local ret=cfg.add(...)
if ret then
self:addTimer(requestType)
elseif ret==nil then
loggerUtil.logErrFMT('请求类型{0}必须返回结果',requestType)
end
else
loggerUtil.logErrFMT('没有配置请求类型：{0}',requestType)
end
end

function loginRequestUpdate:postRequest(requestType,ret)
if _notify[requestType]==nil then return end
for func,_ in pairs(_notify[requestType])do
func(ret)
end
end

function loginRequestUpdate:request(requestType)
local cfg=_requestFunc[requestType]
local data=_data[requestType]
_data[requestType]=nil
cfg.request(data,function(ret,retType)
if not ret and retType<0 then
loggerUtil.logErrFMT('不能请求类型{0}，请检查代码！',requestType)
return
end
loginRequestUpdate:postRequest(requestType,ret)
loginRequestUpdate:stopTimer(requestType)
end)
end

function loginRequestUpdate:addTimer(requestType)
if _timer[requestType]then return end

_timer[requestType]=timer.new()
_timer[requestType]:start(1,function()
loginRequestUpdate:request(requestType)
end,1)
end

function loginRequestUpdate:stopTimer(requestType)
if not _timer[requestType]then return end
_timer[requestType]:cancel()
_timer[requestType]=nil
end

function loginRequestUpdate:stopAllTimer()
for _,v in pairs(_timer)do
v:cancel()
end
_timer={}
end

function loginRequestUpdate:clearData()
self:stopAllTimer()
_data={}
end


function loginRequestUpdate:addRequestServerData(serverid)
local requestType=REQUEST_TYPE.eRequestServer
if _data[requestType]==nil then _data[requestType]={}end
local data=_data[requestType]
if data[serverid]then return false end
if loginModel:getCrossServerInfoByServer(serverid)then return false end
data[serverid]=true
return true
end

function loginRequestUpdate:requestServer(data,callback)
if data==nil then return end
local serveridList={}
for serverid,_ in pairs(data)do
serveridList[#serveridList+1]=serverid
end
if#serveridList>0 then
loginModel:requestServerInfoList(serveridList,callback)
end
end

function loginRequestUpdate:addRequestCrossData(cross_sid)
local requestType=REQUEST_TYPE.eRequestCross
if _data[requestType]==nil then _data[requestType]={}end
local data=_data[requestType]
if data[cross_sid]then return false end
if loginModel:getCrossServerInfo(cross_sid)then return false end
data[cross_sid]=true
return true
end

function loginRequestUpdate:requestCross(data,callback)
if data==nil then return end
local cross_sidList={}
for cross_sid,_ in pairs(data)do
cross_sidList[#cross_sidList+1]=cross_sid
end
if#cross_sidList>0 then
loginModel:requestServerNames(cross_sidList,callback)
end
end