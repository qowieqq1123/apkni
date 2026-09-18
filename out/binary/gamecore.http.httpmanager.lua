






httpManager={}

local _httpGetRequest=CS.ResourceHelper.HttpGetRequest
local _httpPostRequest=CS.ResourceHelper.HttpPostRequest
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _debugger_Log=Debugger.Log
local _t_concat=table.concat

function httpManager.getRequest(url,callback)
if deviceHelper.isRunNoneOrEditor()then return end
local function httpCallBack(message,err)
if err==""or not err then
local json_table={}
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)
if not s then
callback(false,message)
else
callback(true,message,json_table)
end
else
callback(nil,message)
end
end
httpManager.Log(string.format('getHttp请求：url=%s',url))
_httpGetRequest(url,httpCallBack)
end

function httpManager.postRequest(url,postDataArray,callback)
if deviceHelper.isRunNoneOrEditor()then return end
local function httpCallBack(message,err)
if err==""or not err then
local json_table={}
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)
if not s then
callback(false,message)
else
callback(true,message,json_table)
end
else
callback(nil,message)
end
end
httpManager.Log(string.format('postHttp请求：url=%s',url))
_httpPostRequest(url,postDataArray,httpCallBack)
end

function httpManager.Log(...)
local printHttp=_AppConfig_GetBool('printHttp',false)
if deviceHelper.isRunNoneOrEditor()or not printHttp then
return
end
local out={'[php测试数据：]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_debugger_Log(_t_concat(out,' '))
end
