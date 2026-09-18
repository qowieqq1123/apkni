







loginLocal={}

function loginLocal.set_server_list()
if deviceHelper.isRunSDK()then
return
end
local last_server_ip=userGlobalSetting.get('last_server_ip',nil)
local last_server_ip_1=userGlobalSetting.get('last_server_ip_1',nil)
local last_server_ip_2=userGlobalSetting.get('last_server_ip_2',nil)
if last_server_ip==nil and last_server_ip_1==nil and last_server_ip_2==nil then
last_server_ip=userGlobalSetting.get('server_ip',nil)
end
if last_server_ip==''then
last_server_ip=nil
end
if last_server_ip_1==''then
last_server_ip_1=nil
end
if last_server_ip_2==''then
last_server_ip_2=nil
end

loginModel:setLastServerList({loginConfig:transformData(last_server_ip),loginConfig:transformData(last_server_ip_1),loginConfig:transformData(last_server_ip_2)})
local tabConfigs={}
for name,data in pairs(loginConfig.defaultLocalServerList)do
tabConfigs[#tabConfigs+1]=data.tab
loginModel:setZoneServerList(#tabConfigs,data.servers)
end
loginLocal.tabConfigs=tabConfigs
loginModel.server_ip_string=last_server_ip or loginConfig.defaultLocalServerListStr[1].server_ip_string
loginModel.username=userGlobalSetting.get('username','')

notifySystem:postNotifyDelay(notifyConfig.serverListFresh)

end

function loginLocal.init_role_list()
if deviceHelper.isRunSDK()then
return
end
local rolelist=userGlobalSetting.get('rolelist',nil)
local useRoleList={}
if rolelist then
for i,v in ipairs(rolelist)do
if type(v)=='table'and(v.typo~=nil and v.typo==1)then
useRoleList[#useRoleList+1]=v
end
end
end
loginModel:setRoleServerList(useRoleList)
end

function loginLocal.fresh_role_list()
if deviceHelper.isRunSDK()then
return
end
local userid=loginModel.userid
local level=playerModel:getActorLevel()
local name=playerModel:getActorName()
local sid=playerModel:getActorServerID()

local str=loginModel.server_ip_string







local info=
{
userid=userid,
sid=sid,
show_sid=sid,
actorLevel=level,
name=name,
status=0,
actorIcon=65537,
server_ip_string=str,
typo=1,
}
local rolelist=userGlobalSetting.get('rolelist',{})

local has=false
local newRoleList={}
for i,v in ipairs(rolelist)do
if not(v.name==name or(v.typo~=nil and v.typo~=1))then
newRoleList[#newRoleList+1]=v
end
end

local len=#newRoleList
if len>27 then
table.remove(newRoleList,#newRoleList)
end
table.insert(newRoleList,1,info)

userGlobalSetting.record('rolelist',newRoleList)
userGlobalSetting.flush()
end


function loginLocal.connect_server()
if deviceHelper.isRunSDK()then
return
end
local cur_serveStr=userGlobalSetting.get('server_ip',loginModel.server_ip_string)
if cur_serveStr==''or cur_serveStr==nil then
return false
end
local severname,sid,ip,port,status=string.match(cur_serveStr or'',loginModel.matchStr)
loginModel:selectSever(severname,sid,ip,port,status)
loginControl:connect_server(ip,port)
local username=userGlobalSetting.get('username',loginModel.username)
end

function loginLocal:set_last_ip(last_server_ip)
if deviceHelper.isRunSDK()then
return
end
local server_ip=userGlobalSetting.get('last_server_ip',nil)
local server_ip_1=userGlobalSetting.get('last_server_ip_1',nil)
local server_ip_2=userGlobalSetting.get('last_server_ip_2',nil)
if last_server_ip==server_ip then
userGlobalSetting.set('last_server_ip_2',server_ip_2)
userGlobalSetting.set('last_server_ip_1',server_ip_1)
userGlobalSetting.set('last_server_ip',last_server_ip)
elseif last_server_ip==server_ip_1 then
userGlobalSetting.set('last_server_ip_2',server_ip_2)
userGlobalSetting.set('last_server_ip_1',server_ip)
userGlobalSetting.set('last_server_ip',last_server_ip)
elseif last_server_ip==server_ip_2 then
userGlobalSetting.set('last_server_ip_2',server_ip_1)
userGlobalSetting.set('last_server_ip_1',server_ip)
userGlobalSetting.set('last_server_ip',last_server_ip)
else
userGlobalSetting.set('last_server_ip_2',server_ip_1)
userGlobalSetting.set('last_server_ip_1',server_ip)
userGlobalSetting.set('last_server_ip',last_server_ip)
end
userGlobalSetting.flush()
local t_last_server_ip=userGlobalSetting.get('last_server_ip',nil)
local t_last_server_ip_1=userGlobalSetting.get('last_server_ip_1',nil)
local t_last_server_ip_2=userGlobalSetting.get('last_server_ip_2',nil)
loginModel:setLastServerList({t_last_server_ip,t_last_server_ip_1,t_last_server_ip_2})
loginModel:setTuiJianServerList({loginConfig:transformData(t_last_server_ip),
loginConfig:transformData(t_last_server_ip_1),
loginConfig:transformData(t_last_server_ip_2)})
end

local storeLen=100
local localAccount
local accountFileName='localAccount.json'
local writablePath=CS.GamePath.writablePath
local cjson=require'cjson'
local filePath
function loginLocal.readAccountFile()
if localAccount==nil then
local dirPath=string.gsub(writablePath,'\\','/')
dirPath=string.gsub(dirPath,'/LocalFile','')..'/JsonData/'
filePath=dirPath..accountFileName
local f=io.open(filePath,'r')
if f then
local content=f:read('*all')
if content and content~=''then
localAccount=cjson.decode(content)
else
localAccount={}
end
f:close()
else
local f=io.open(filePath,'w+')
if f then
f:write('')
f:close()
end
localAccount={}
end
local lastidx=#localAccount
if lastidx>storeLen then
local div=lastidx-storeLen
for i=1,div do
table.remove(localAccount,1)
end
end
end
end

function loginLocal.flushAccount()
local f=io.open(filePath,'w+')
if f then
f:write(cjson.encode(localAccount))
f:close()
end
end


function loginLocal.storeAccount(serverid,account)
loginLocal.readAccountFile()
if localAccount==nil then return end
local time=os.time()
local timeStr=os.date('%Y年%m月%d日 %H:%M:%S',time)
localAccount[#localAccount+1]={timeStr,account}
loginLocal.flushAccount()
end