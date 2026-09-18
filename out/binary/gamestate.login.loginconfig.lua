







loginConfig={}
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString

if deviceHelper.isRunEditor()then
loginConfig.defaultLocalServerListStr=
{
























































































































}
else
loginConfig.defaultLocalServerListStr=
{

{'主干','{trunk测试服}{290001}{175.178.92.230}{9003}{0}'},
{'主干','{trunk测试服}{290001}{zqzss0.xw66.top}{11503}{0}'},
{'发布','{release测试服}{290003}{175.178.92.230}{9006}{0}'},

{'苹果','{IOS提审服}{290081}{49.51.50.44}{9008}{0}'},
{'苹果','{IOSTF服}{290086}{175.178.92.230}{9011}{0}'},

{'微信','{wechat测试服}{290002}{zqzss0.xw66.top}{11004}{0}'},
{'微信','{微信验收服WSS}{290004}{zqzss0.xw66.top}{11026}{0}'},
{'微信','{微信验收服TCP}{290004}{175.178.92.230}{9026}{0}'},
{'微信','{微信提审服WSS}{290005}{zqzss0.xw66.top}{11002}{0}'},

{'抖音','{微信提审服WSS}{290010}{zqzss0.xw66.top}{11032}{0}'},
{'抖音','{微信提审服TCP}{290010}{175.178.92.230}{9032}{0}'},

{'华为','{华为提审服WSS}{290012}{zqzss0.xw66.top}{11047}{0}'},
{'华为','{华为提审服TCP}{290012}{175.178.92.230}{9047}{0}'},



{'外网','{外网版署服}{259903}{193.112.121.67}{9035}{0}'},








{'外网','{外部看专看1服}{290071}{175.178.92.230}{9013}{0}'},
{'外网','{外部看专看2服}{290072}{175.178.92.230}{9008}{0}'},

{'外网','{先遣验收服}{290016}{175.178.92.230}{9007}{0}'},

{'外网','{公测验收服}{290018}{175.178.92.230}{9023}{0}'},
{'外网','{PC测试服}{290019}{175.178.92.230}{9022}{0}'},

{'外网','{鸿蒙测试服}{290008}{175.178.92.230}{9014}{0}'},
}
end



















local customServer=CS.AppDataModel.AppConfig_GetString("customServer",nil)
if customServer~=nil then
loginConfig.defaultLocalServerListStr={}
loginConfig.defaultLocalServerListStr[#loginConfig.defaultLocalServerListStr+1]={'推荐',customServer}
end

loginConfig.matchStr='%{(%Z*)%}%{(%Z*)%}%{(%Z*)%}%{(%Z*)%}%{(%Z*)%}'
loginConfig.defaultLocalServerList={}

function loginConfig:transformData(server_ip_string_org,formatMode)
if server_ip_string_org==nil then
return nil
end

local sever_name,sever_sid,sever_ip,sever_port,sever_status=string.match(server_ip_string_org,formatMode or loginConfig.matchStr)
local curSeverData=
{
name=sever_name or'',
sid=sever_sid or 0,
show_sid=sever_sid or 0,
ip=sever_ip or'',
port=sever_port or 0,
status=sever_status or 0,
merge_sid=0,
server_ip_string=server_ip_string_org,

}
return curSeverData
end

local zoneMap={}
for i,v in pairs(loginConfig.defaultLocalServerListStr)do
local zone=v[1]
local data=loginConfig:transformData(v[2],loginConfig.matchStr)
data.name=data.name..'['..data.sid..']'
local ZoneSever=zoneMap[zone]
if ZoneSever==nil then
ZoneSever={}
ZoneSever.tab={name=zone}
ZoneSever.servers={}
zoneMap[zone]=ZoneSever
loginConfig.defaultLocalServerList[#loginConfig.defaultLocalServerList+1]=ZoneSever
end
ZoneSever.servers[#ZoneSever.servers+1]=data
end

local customServer=_AppConfig_GetString("customServer",nil)
if customServer~=nil then
loginConfig.defaultLocalServerList={}
local data=loginConfig:transformData(customServer,loginConfig.matchStr)
data.name=data.name..'['..data.sid..']'
ZoneSever={}

ZoneSever.tab={name='推荐'}
ZoneSever.servers={}
ZoneSever.servers[#ZoneSever.servers+1]=data
loginConfig.defaultLocalServerList['推荐']=ZoneSever
end


function loginConfig.getStatusType(status)
local statusType=0
if status==0 or status=='0'then
statusType=0
elseif status==1 or status=='1'then
statusType=1
elseif status==2 or status=='2'then
statusType=2
elseif status==3 or status=='3'then
statusType=3
end
return statusType
end
