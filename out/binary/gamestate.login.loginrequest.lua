
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _askCnt=2














function loginControl:requestLastServerList()
if deviceHelper.isRunNoneOrEditor()or not loginModel.isLogin then
return false
end

local function httpCallBack(message,err)
platformSDK.printSDK('最近服务器返回数据:',message)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s or json_table.lastserver==nil then
local content='拉取最近服务器列表失败'
UIManager.info(content)
loginControl:doLoginoutTimeOut()
return
end



if type(json_table)=='number'then
local content=FMT.fmt('拉取最近服务器列表失败[{0}]',json_table)
UIManager.info(content)
loginControl:doLoginoutTimeOut()
return
end
end


if not verifyManager:isOpen()and(json_table.params==nil or json_table.params=='')then
UIManager.info('拉取最近服务器列表失败[参数为空]')
loginControl:doLoginoutTimeOut()
return
end

platformSDK.printSDK('拉取最近服务器列表成功')
loginControl:PC_HideHelperBtn()


loginModel:setPhpParam(json_table.params)


platformSDK:reqVerificationLogin(json_table.sdkParams)



local lastServerList=json_table.lastserver



local lastServers=lastServerList.last_server or{}
loginRoleControl.setServerIdList(lastServers)


local defaultServer=lastServerList.default_server or{}

local serverId=defaultServer.server_id or 0
if serverId==0 then
UIManager.info('没有找到默认服务器')
end

local curServerList={defaultServer}

local serverName=defaultServer.name or''

local serverStatus=defaultServer.server_status or 0


if loginModel.server_id==0 then
loginModel:selectSever(serverName,serverId,'',0,serverStatus)
end

loginModel:setLastServerList(loginControl:handSeverListData(curServerList))


notifySystem:postNotify(notifyConfig.serverListFresh)

if webGLHelper:isSkipLogin()then
webGLHelper:handleLogin()
end
else


platformSDK.printSDK('最近服务器列表解析失败')
UIManager.info('最近服务器列表解析失败')
end
end




if verifyManager:isOpen()then
httpCallBack(verifyData:getServerListData())
return
end


local url=gameInfo:getLastServerListURL()
if url==nil or url==''then
platformSDK.printSDK('最近服务器列表请求url沒有下发')
return false
end
local sdkStr=loginModel:getSDKParam()
local urlStr=FMT.fmt('{0}?{1}',url,sdkStr)

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('拉取最近服务器列表,完整url=%s',urlStr))

return true
end


function loginControl:requestZoneServerInfo()
if deviceHelper.isRunNoneOrEditor()or not loginModel.isLogin or verifyManager:isOpen()then
return false
end

local function httpCallBack(message,err)
platformSDK.printSDK('推荐大区列表返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
local content='拉取大区列表失败'
UIManager.info(content)
return
end
end
platformSDK.printSDK('拉取大区列表成功')


loginModel:setServerZoneInfo(json_table.server_zone_info)


UIManager:callWindowFunc('UILoginServerListWin','onfreshServerZone')



notifySystem:postNotify(notifyConfig.serverZoneFresh)

else


platformSDK.printSDK('大区列表解析失败')
UIManager.info('大区列表解析失败')
end
end



local url=gameInfo:getServerZoneURL()
if url==nil or url==''then
platformSDK.printSDK('大区列表请求url沒有下发')
return false
end
local urlStr=FMT.fmt('{0}?account={1}&chid={2}',url,loginModel.userid,loginModel:getChannelID())

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('拉取大区列表,url=%s',urlStr))

return true
end



function loginControl:requestZoneServerList(index,zone)
if deviceHelper.isRunNoneOrEditor()or not loginModel.isLogin or verifyManager:isOpen()then
return false
end

if zone==nil then
logErr('没有传递请求大区的id')
return
end

local function httpCallBack(message,err)
platformSDK.printSDK('推荐大区服务器列表返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
local content='拉取大区服务器列表失败'
UIManager.info(content)
return
end
end
platformSDK.printSDK('拉取大区服务器列表成功')




local serverList=json_table.serverlist
loginModel:setZoneServerList(index,loginControl:handSeverListData(serverList))


UIManager:callWindowFunc('UILoginServerListWin','onfreshPageServerList',index)

else


platformSDK.printSDK('大区服务器列表解析失败')
UIManager.info('拉取大区服务器列表解析失败')
end
end


local url=gameInfo:getServerListURL()
if url==nil or url==''then
platformSDK.printSDK('大区服务器列表请求url沒有下发')
return false
end
local urlStr=FMT.fmt('{0}?zone_id={1}&account={2}',url,zone,loginModel.userid)

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('拉取大区服务器列表,完整url=%s',urlStr))

return true
end


function loginControl:requestRoleServerList()
if deviceHelper.isRunNoneOrEditor()or not loginModel.isLogin or verifyManager:isOpen()then
return false
end
if not loginRoleControl.needRequest()then
return false
end
local serverIdlist=loginRoleControl.getServerIdList()
if serverIdlist==nil or#serverIdlist<=0 then
platformSDK.printSDK('玩家没有创建角色')
return false
end

local function httpCallBack(message,err)
platformSDK.printSDK('角色列表返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s or json_table==nil or type(json_table)=='number'then
local content='拉取角色列表失败'
UIManager.info(content)
return
end
end
platformSDK.printSDK('拉取角色列表成功')



local templist={}
for i,v in ipairs(serverIdlist)do
local serverInfo=json_table[tostring(v)]
templist[#templist+1]=serverInfo
end
loginRoleControl.setServerList(templist)


UIManager:callWindowFunc('UILoginServerListWin','onfreshRoleServerList')

else


platformSDK.printSDK('角色列表解析失败')
UIManager.info('拉取角色列表解析失败')
end
end


local url=gameInfo:getParams('roleListURL')
if url==nil or url==''then
platformSDK.printSDK('角色列表请求url沒有下发')
return false
end
local serverStr=''
for i,v in ipairs(serverIdlist)do
serverStr=i==1 and v or FMT.fmt('{0},{1}',serverStr,v)
end
local urlStr=FMT.fmt('{0}?account={1}&sids={2}',url,loginModel.userid,serverStr)

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('拉取角色列表完整url=%s',urlStr))

return true
end


function loginControl:requestLogin(callback)
if not CommonController.CheckLoginClick()then
return
end
if not appUtils.testPHP and deviceHelper.isRunNoneOrEditor()then
if callback then
callback(false)
end
return
end


if not appUtils.testPHP and not loginModel.isLogin then
platformSDK:reqLogin()
if callback then
callback(false)
end
return
end

local serverId=loginModel.be_server_id or loginModel.server_id
if serverId==nil or serverId==0 then
UIManager.info('请选择服务器')
if callback then
callback(false)
end
return
end

if loginControl:isBuildConnect()or socketManager.connecting or loginControl.loginRequest then
UIManager.info("正在连接服务器")
return
end

if not verifyManager:isOpen()then
local params=loginModel:getPhpParam()
if params==nil or params==''then
loggerUtil.debugErrFMT('请求参数为空，再次请求最近服务器列表')
loginControl:requestLastServerList()
if callback then
callback(false)
end
return
end
end

loginControl.loginRequest=true
local cb=function(flag)
loginControl.loginRequest=false
if callback then
callback(flag)
end
end

local function httpCallBack(message,err)
platformSDK.printSDK('请求php登录返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else

if type(message)=='number'then
UIManager.info('请求登录失败')
cb(false)
return
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)


if not s then
UIManager.info('请求登录失败')
cb(false)
return
end



if type(json_table)=='number'then
UIManager.info(FMT.fmt('请求登录失败[{0}]',json_table))
cb(false)
return
end
end
end




local white=tonumber(json_table.isWhiteList or-1)==1
super.set(white)



local serverStatus=tonumber(json_table.server_status)or loginServerStatus.eNormal
if serverStatus==loginServerStatus.ePause then
UIManager.info('服务器正在维护')
if UIManager:isActive('UILogin')then
if not autoLoginHelper:isAutoLogin()then
UIManager:showWindow('UIGongGaoWin')
end
else
loginControl:doLoginOutByDisconnect()
end
cb(false)
return
end


local isBan=tonumber(json_table.isBan or 0)==1
if isBan then
loginControl:doLoginoutTimeOut()
UIManager.info('亲爱的玩家，您的账号已被封禁，请联系客服处理')
cb(false)
return
end


local limit=json_table.login_limit
if limit then
local msg=json_table.msg
if limit==4 then
loginControl:askSwitchCurServer(serverId,cb,true,msg)
else
loginControl:doLoginoutTimeOut()
UIManager.info(msg)
cb(false)
end
return
end



_askCnt=0



if(webGLHelper:isRunWebGL()or webGLHelper:checkNetProtocolType(1))and not verifyManager:isOpen()then
local wss_host=json_table.wss_host
local wss_port=json_table.wss_port
if wss_host and wss_host~=''and wss_port and wss_port~=''then
json_table.srvaddr=wss_host
json_table.srvport=wss_port
else

end
end


local ip=json_table.srvaddr
local serverPort=json_table.srvport
local isNew=json_table.isnew
local srvtime=tonumber(json_table.srvtime)or-1


loginModel:setLoginInfo(json_table)


platformSDK.printSDK('开始连接服务器 ip=%s,serverPort=%s',ip,serverPort)
loginControl:connect_server(ip,tonumber(serverPort))


local newflag=tonumber(isNew)or-1
if newflag==1 then
loginControl:report_use_info_eregister()
end
cb(true)

loginModel.newflag=newflag
else

platformSDK.printSDK('php登陆失败')
cb(false)
end
end




if verifyManager:isOpen()then
loginControl.loginRequest=false
httpCallBack(verifyManager:getLoginData())
return
end


local url=gameInfo:getLoginURL()
if url==nil or url==''then
platformSDK.printSDK('登陆服务器请求url沒有下发')
cb(false)
return false
end
local param=loginModel:getPhpParam()
local urlStr=FMT.fmt("{0}?serverId={1}{2}",url,serverId,param)

if api_Available_HttpGetRequestEx()then
CS.ResourceHelper.HttpGetRequestEx(urlStr,15,httpCallBack)
else
_httpGetRequest(urlStr,httpCallBack)
end

platformSDK.printSDK(string.format('请求php登录:%s',urlStr))
end


function loginControl:requestTuiJianServer(serverId,callback)
if not appUtils.testPHP and(deviceHelper.isRunNoneOrEditor()or
not loginModel.isLogin or
verifyManager:isOpen())then
if callback~=nil then
callback(false)
end
return false
end
local sid=serverId or loginModel.server_id
local function httpCallBack(message,err)
platformSDK.printSDK(FMT.fmt("推荐服务器列表 message:{0} ！error: {1}",message,tostring(err)))
if err==""or not err then

local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)
if not s then
platformSDK.printSDK('解析推荐服务器列表失败')
if callback~=nil then
callback(false)
end
return
end
end
if json_table and json_table.code==0 then
local switchFlag=loginModel:getTuiJianServerCacheFlag()
loginModel:setTuiJianServerList(loginControl:handSeverListData(json_table.data))
if switchFlag and serverId then
loginControl:switchCurServer(sid,callback)
end
UIManager:callWindowFunc('UILoginServerListWin','onfreshTuiJianServerList')
platformSDK.printSDK('解析推荐服务器列表成功')
else
if callback~=nil then
callback(false)
end
platformSDK.printSDK('解析推荐服务器名称列表失败')
end
else

UIManager.error('')
if callback~=nil then
callback(false)
end
platformSDK.printSDK('获取推荐服务器列表失败')
end
end

local url=gameInfo:getParams('recommendServerListURL')
if url==nil or url==''then
platformSDK.printSDK('获取推荐服务器列表url沒有下发')
if callback~=nil then
callback(false)
end
return false
end
local urlStr=FMT.fmt('{0}?account={1}',url,loginModel.userid)
_httpGetRequest(urlStr,httpCallBack)
platformSDK.printSDK(string.format('获取推荐服务器列表!url=%s',urlStr))
return true
end


function loginModel:requestServerNames(cross_sids,callback)
if not appUtils.testPHP and(not loginModel.isLogin or verifyManager:isOpen())then
loginControl:invokeCallBack(callback,false,-1)
return false
end

local temp={}
for _,v in ipairs(cross_sids)do
if not loginModel:hasCrossServerData(v)then
temp[#temp+1]=v
end
end
if#temp<=0 then
loginControl:invokeCallBack(callback,true)
return
end

local function httpCallBack(message,err)
platformSDK.printSDK('请求服务器名称列表返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
loginControl:invokeCallBack(callback,false,1)
platformSDK.printSDK(string.format('解析服务器名称列表失败:%s',message))
return
end
end
if json_table and json_table.code==0 then
loginModel:addAllServerData(json_table.data)
loginControl:invokeCallBack(callback,true)
platformSDK.printSDK('解析服务器名称列表成功')
else
loginControl:invokeCallBack(callback,false,1)
platformSDK.printSDK('解析服务器名称列表失败')
end
else
loginControl:invokeCallBack(callback,false,1)
platformSDK.printSDK('请求服务器名称列表解析失败')
end
end


local urlStr=gameInfo:getParams('crossServerListURL')
if appUtils.testPHP then
urlStr='http://10.10.1.52:89/cysh/api/crossServerList'
end
if urlStr==nil or urlStr==''then
loginControl:invokeCallBack(callback,false,2)
platformSDK.printSDK('请求服务器名称列表url沒有下发')
return false
end
local serverStr=''
for i,v in ipairs(temp)do
serverStr=i==1 and v or FMT.fmt('{0},{1}',serverStr,v)
end
urlStr=FMT.fmt('{0}?cross_sids={1}',urlStr,serverStr)

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('请求服务器名称列表,url=%s',urlStr))

return true
end


function loginModel:requestServerInfoList(serveridList,callback)
if not appUtils.testPHP and(not loginModel.isLogin or verifyManager:isOpen())then
loginControl:invokeCallBack(callback,false,-1)
return false
end

local function httpCallBack(message,err)
platformSDK.printSDK('请求服务器信息列表返回数据:',message,err)

if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
loginControl:invokeCallBack(callback,false,1)
platformSDK.printSDK(string.format('解析服务器信息列表失败:%s',message))
return
end
end
if json_table and json_table.code==0 then
loginModel:addServerData(json_table.data)
loginControl:invokeCallBack(callback,true)
platformSDK.printSDK('解析服务器信息列表成功')
else
loginControl:invokeCallBack(callback,false,1)
platformSDK.printSDK('解析服务器信息列表失败')
end
else
loginControl:invokeCallBack(callback,false,1)
platformSDK.printSDK('请求服务器名称信息解析失败')
end
end


local urlStr=gameInfo:getParams('serverInfoURL')

if appUtils.testPHP then
urlStr='http://10.10.1.49:89/cysh/api/serverInfo'
end

if urlStr==nil or urlStr==''then
platformSDK.printSDK('请求服务器信息url沒有下发')
loginControl:invokeCallBack(callback,false,2)
return false
end

local serverStr=''
for i,v in ipairs(serveridList)do
serverStr=i==1 and v or FMT.fmt('{0},{1}',serverStr,v)
end
urlStr=FMT.fmt('{0}?sids={1}',urlStr,serverStr)
_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('请求服务器信息列表,url=%s',urlStr))

return true
end



function loginControl:handSeverListData(severList)
local list={}
for i,v in ipairs(severList)do
local sever_name=v.name
local sever_sid=v.server_id or 0
local sever_ip=v.ip or''
local sever_port=v.port or 0
local merge_server_id=v.mergeid or 0
local server_status=v.server_status or 0
local online=v.online or 0
local str=string.format('{%s}{%d}{%s}{%d}{%d}',tostring(sever_name),sever_sid,tostring(sever_ip),sever_port,server_status)
local curSeverData=
{
name=sever_name,
sid=tonumber(sever_sid),
show_sid=loginHelper.convertServerID(tonumber(sever_sid)),
ip=sever_ip,
port=tonumber(sever_port),
status=tonumber(server_status),
merge_sid=tonumber(merge_server_id),
online=tonumber(online),
server_ip_string=str,
}
list[#list+1]=curSeverData
end
return list
end


function loginControl:askSwitchCurServer(serverId,switchCallBack,showSelectDialog,msg)
if not appUtils.testPHP and(not loginModel.isLogin or verifyManager:isOpen())then
if switchCallBack~=nil then
switchCallBack(false)
end
return false
end

_askCnt=_askCnt-1
if _askCnt>=0 then
local func=function()
local serverlist=loginModel:getTuiJianServerCacheList()
if serverlist and#serverlist>0 then
loginControl:switchCurServer(serverId,switchCallBack)
else

local flag=loginModel:getTuiJianServerCacheFlag()
loginModel:setTuiJianServerCacheFlag(true)
if flag==nil then
local serverlist=loginModel:getTuiJianServerList()
if serverlist and#serverlist>0 then
loginModel:setTuiJianServerCacheList(serverlist)
loginControl:switchCurServer(serverId,switchCallBack)
return
end
end
loginControl:requestTuiJianServer(serverId,switchCallBack)
end
end
if showSelectDialog then
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='当前服务器爆满，是否切换成其他服务器',
oktext='确定',
canceltext='返回登录',
allowclickBG='false',
okcallback=func,
cancelcallback=function(...)
UICreateRoleController.autoSwitchServer=false
UICreateRoleController:backToLogin()
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
func()
end
else
if switchCallBack~=nil then
switchCallBack(false)
end
UIManager.info(msg)
end
end









function loginControl:switchCurServer(serverId,switchCallBack)
if not appUtils.testPHP and(not loginModel.isLogin or verifyManager:isOpen())then return false end
local serverlist=loginModel:getTuiJianServerList()
if serverlist and#serverlist>0 then
math.randomseed(os.time())
local index=math.random(1,#serverlist)
local info=serverlist[index]
local num=0
while info and info.sid==serverId and num<1000 do
index=math.random(1,#serverlist)
info=serverlist[index]
num=num+1
end



if info==nil then
info=serverlist[1]
table.remove(serverlist,1)
_askCnt=0
else
table.remove(serverlist,index)
end

if info.sid==serverId then
if switchCallBack then
switchCallBack(false)
end
return
end
socketManager:Disconnect()


loginModel:selectSever(info.name,info.sid,'',0,info.status)


local callback=function()
loginControl:requestLogin(function(flag)
if switchCallBack~=nil then
switchCallBack(flag)
end
end)
end
updateControl.checkUpdate(callback)
end
end
























































































function loginControl:PC_HideHelperBtn()
if pfCommonHelper:isRunPC()then
local enableDebug=CS.AppDataModel.AppConfig_GetBool('log.enableFileLog',false)
if not enableDebug then

if api_Available_setEnableFileLog()then
CS.GameInterface.setEnableFileLog(false)
end
UIManager:invokeUIMethod('UILogin','PC_HideHelperBtn')
end
end
end


function loginModel:requestAllServerNames(crossIdList)

















































end



function loginControl:requestVerifyLastServerList()
if not verifyManager:isOpen()or not verifyManager:isNeedRequestPHP()or deviceHelper.isRunNoneOrEditor()then
return false
end

local function httpCallBack(message,err)
platformSDK.printSDK('requestVerifyLastServerList 最近伺服器返回資料:',message)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)


if type(json_table)=='number'then
platformSDK.printSDK('requestVerifyLastServerList 拉取最近伺服器列表失敗',json_table)
return
end
end
loginModel:setUserId(tostring(json_table.sdkParams.userId))

platformSDK:reqVerificationLogin(json_table.sdkParams)
else


platformSDK.printSDK('requestVerifyLastServerList 最近伺服器列表解析失敗')
end
end




local url=gameInfo:getLastServerListURL()
if url==nil or url==''then
platformSDK.printSDK('requestVerifyLastServerList 最近伺服器列表請求url沒有下發')
return false
end
local sdkStr=loginModel:getSDKParam()
local urlStr=FMT.fmt('{0}?{1}',url,sdkStr)

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('requestVerifyLastServerList 拉取最近伺服器列表,完整url=%s',urlStr))

return true
end



function loginControl:requestTransferActURL()
platformSDK.printSDK('请求转段活动请求url下发')
if verifyManager:isOpen()or deviceHelper.isRunNoneOrEditor()then
return false
end
local function httpCallBack(message,err)
loggerUtil.log(FMT.fmt("client transferActURL 2:{0} {1}",message,tostring(err)))
if err==""or not err then

local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)
if not s then
local content='从php获取转段活动失败'
UIManager.info(content)
return
end
end
ChangeActController:setTransferActdata(json_table.data)
else
platformSDK.printSDK('获取转段活动失败')
end
end



local url=gameInfo:getParams('transferActURL')
if deviceHelper.isRunNoneOrEditor()then
url='http://10.10.1.49:89/sqzs/api/getTransferAct'
end
if url==nil or url==''then
platformSDK.printSDK('获取转段活动请求url沒有下发')
return false
end
local account=loginModel.userid or 0
local sid=loginModel.server_id or 0
local urlStr=FMT.fmt("{0}?account={1}&sid={2}",url,account,sid)


_httpGetRequest(urlStr,httpCallBack)
platformSDK.printSDK(string.format('获取转段活动,完整url=%s',url))
return true
end

function loginControl:invokeCallBack(callback,...)
if callback then
callback(...)
end
end
