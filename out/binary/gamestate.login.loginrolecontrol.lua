loginRoleControl={}

local _serversList={}
local _serversIdList=nil
local _requestTag=true
local _div=600
local _stamp=0




















local handSeverListData=function(severList)
local list={}
for i,v in ipairs(severList)do
local sever_name=v.name
local sever_sid=v.server_id or 0
local server_status=v.server_status or 0
local actors=v.actors
if actors and#actors>0 then
for i,v in ipairs(actors)do
local actor=v
if actor.actorname then
local str=string.format('{%s}{%d}{%s}{%d}{%d}',tostring(sever_name),tonumber(sever_sid),'',0,server_status)
local curSeverData=
{
name=sever_name,
sid=tonumber(sever_sid),
show_sid=loginHelper.convertServerID(tonumber(sever_sid)),
status=tonumber(server_status),
actorName=actor.actorname,
actorIcon=tonumber(actor.icon or 0),
actorLevel=tonumber(actor.level or 1),
server_ip_string=str,
zhuxiaotime=actor.zhuxiaotime or 0
}

list[#list+1]=curSeverData
end
end
end
end
return list
end

function loginRoleControl.setServerIdList(servers)
local temp={}
for i,v in ipairs(servers)do
temp[#temp+1]=v.server_id
end
_requestTag=table.isDiff(_serversIdList,temp)
if _requestTag then
_stamp=os.time()
_serversIdList=table.deepCopy(temp)
end
temp=nil
end

function loginRoleControl.clearServerIdList()
_serversIdList=nil
end

function loginRoleControl.getServerIdList()
return _serversIdList
end

function loginRoleControl.needRequest()
local stamp=os.time()
if stamp>=(_stamp+_div)then
_requestTag=true
end
if not _requestTag and loginModel:getRoleServerList()==nil then
_requestTag=true
end
return _requestTag or false
end

function loginRoleControl.setServerList(listArray)

local serversList=handSeverListData(listArray)
loginModel:setRoleServerList(serversList)
end



































