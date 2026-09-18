






local _MODULENAME="houtaiController"
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest
gameState.addListener(def_table(_MODULENAME))
houtaiController.name=_MODULENAME
houtaiController.data={}

function houtaiController:onAppStart()

houtaiModel:onAppStart()


socketManager:register_receiver(254,78,houtaiController.recv_254_78)







end


function houtaiController:onEnterState(isReconnect)
houtaiModel:onEnterState()
end


function houtaiController:onProtocolReq()
houtaiModel:onProtocolReq()
end


function houtaiController:onLeaveState(isReconnect)
houtaiModel:onLeaveState(isReconnect)

self.data={}
end


function houtaiController:onLostConnection()

end


function houtaiController:onReConnection(isInitPro)

end





function houtaiController.recv_254_78(jsonStr)
houtaiModel:setServerData(jsonStr)
end




function houtaiController:requestOptions(callBack)
if not appUtils.testPHP and(deviceHelper.isRunNoneOrEditor()or
not loginModel.isLogin or
verifyManager:isOpen())then
if callBack~=nil then
callBack(false)
end
return false
end
local httpCallBack
httpCallBack=function(jsonStr,err)



platformSDK.printSDK('请求php返回开关数据:',jsonStr,err)
local success=false
if err==""or not err then
local json_table

local s,e=pcall(function()
json_table=jsonHelper.decode(jsonStr)
end)
if json_table and json_table.code==0 then
houtaiModel:setPHPData(json_table.data)
success=true
else
platformSDK.printSDK('php开关解析错误',jsonStr)
end
else
if self.tryCount==nil then
self.tryCount=1
local url=gameInfo:getParams('gameConfigURL')
platformSDK.printSDK('php开关重试',jsonStr)
_httpGetRequest(url,httpCallBack)
end
end

if callBack~=nil then
callBack(success)
end
end


local url=gameInfo:getParams('gameConfigURL')
_httpGetRequest(url,httpCallBack)
platformSDK.printSDK(string.format('请求php登录返回开关:%s',url))
end

function houtaiController:requestOptions2(callBack)
if not appUtils.testPHP and(deviceHelper.isRunNoneOrEditor()or
not loginModel.isLogin or
verifyManager:isOpen())then
if callBack~=nil then
callBack(false)
end
return false
end

local httpCallBack2=function(jsonStr,err)



platformSDK.printSDK('请求php返回开关数据(按区服):',jsonStr,err)
local success=false
if err==""or not err then
local json_table
local s,e=pcall(function()
json_table=jsonHelper.decode(jsonStr)
end)
if json_table and json_table.code==0 then
houtaiModel:setPHPData2(json_table.data)
success=true
else
platformSDK.printSDK('php开关(按区服)解析错误',jsonStr)
end
else
if self.tryCount2==nil then
self.tryCount2=1
local url_=gameInfo:getParams('gameConfigServerURL')
local sid=playerModel:getActorServerID()
url2=url2..'?sid='..sid
platformSDK.printSDK('php开关(按区服)重试',jsonStr)
_httpGetRequest(url_,httpCallBack2)
end
end

if callBack~=nil then
callBack(success)
end
end
local url2=gameInfo:getParams('gameConfigServerURL')
if url2~=nil then
local sid=playerModel:getActorServerID()
url2=url2..'?sid='..sid

_httpGetRequest(url2,httpCallBack2)
platformSDK.printSDK(string.format('请求php登录返回开关(按区服):%s',url2))
else

end
end


function houtaiController:requestOptions_Pre(callBack)
if webGLHelper:is_MiniGame()then
local httpCallBack
httpCallBack=function(jsonStr,err)



platformSDK.printSDK('请求php返回开关数据_pre:',jsonStr,err)
local success=false
if err==""or not err then
local json_table

local s,e=pcall(function()
json_table=jsonHelper.decode(jsonStr)
end)
if json_table and json_table.code==0 then
houtaiModel:setPHPData(json_table.data)
success=true
else
platformSDK.printSDK('php开关解析错误_pre',jsonStr)
end
else
if self.tryCount==nil then
self.tryCount=1
local url=gameInfo:getParams('gameConfigURL')
platformSDK.printSDK('php开关重试_pre',jsonStr)
_httpGetRequest(url,httpCallBack)
end
end

if callBack~=nil then
callBack(success)
end
end


local url=gameInfo:getParams('gameConfigURL')
_httpGetRequest(url,httpCallBack)
platformSDK.printSDK(string.format('请求php登录返回开关_pre:%s',url))
end
end
