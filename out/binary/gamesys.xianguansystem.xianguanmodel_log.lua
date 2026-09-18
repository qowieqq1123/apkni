





function xianguanModel:onEnterState_Log(isReconnect)
self.data.tqLogListLen=0
self.data.tqLogList={}

self.data.tqLogList_Buff={}
self.data.tqLogList_Fight={}
self.data.tqLogList_New={}

self:readLogShowSec()
end

function xianguanModel:onLeaveState_Log(isReconnect)
end

function xianguanModel:setServerLogList(len,logList)
self.data.tqLogListLen=len
self.data.tqloglist=logList or{}

if len>0 then
table.sort(self.data.tqloglist,function(a,b)
return a.sec<b.sec
end)

self:updateNewFlag()
self:sortLogList(logList)
end
end

function xianguanModel:addServerLogList(len,logList)
self.data.tqLogListLen=self.data.tqLogListLen+len

self.data.tqloglist=table.concatTable(self.data.tqloglist,logList)

table.sort(self.data.tqloglist,function(a,b)
return a.sec>b.sec
end)

self:updateNewFlag()
self:sortLogList(logList)
end

function xianguanModel:updateNewFlag()
if self.data.tqLogListLen<=0 then return end

table.clear(self.data.tqLogList_New)

local list=self.data.tqLogList_New

for index,data in ipairs(self.data.tqloglist)do
data.isNew=data.sec>self.data.logShowSec
if data.isNew then
list[#list+1]=data
end
end
end

function xianguanModel:sortLogList(logList)
if not(logList and#logList>0)then
return
end

local buffList=self.data.tqLogList_Buff
local fightList=self.data.tqLogList_Fight

for index,data in ipairs(logList)do
local tab=xianguanConfig.getTeQuanCfg(data.tqid,'tab')
if tab then
if tab==1 then
table_insert(buffList,1,data)
elseif tab==2 then
table_insert(fightList,1,data)
end
end
end
end


function xianguanModel:getLogList()
return self.data.tqloglist
end

function xianguanModel:getLogList_Buff()
return self.data.tqLogList_Buff
end

function xianguanModel:getLogList_Fight()
return self.data.tqLogList_Fight
end

function xianguanModel:getLogList_New()
return self.data.tqLogList_New
end



local _log_Show_Sec_Key="XianGuan_Log_Show_Sec"
function xianguanModel:writeLogShowSec(sec)
self.data.logShowSec=sec
userActorSetting.set(_log_Show_Sec_Key,self.data.logShowSec)
userActorSetting.flush()
end

function xianguanModel:readLogShowSec()
self.data.logShowSec=userActorSetting.get(_log_Show_Sec_Key,0)
end






local _logDescFmtFuncs={
[XIANGUAN_PRIVILEGE_ENUM.eXingZhanDouShu]=
{
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1,arg2

local buffType=jsonData[1]
local buffId=jsonData[2]
if buffType==1 then
local guildstateconfig=cfg_guildstateconfig_get(buffId)
arg1=guildstateconfig.name
arg2=homeBuffModel:getBuffDescByStateId(buffId)
arg2=string.replace(arg2,"\n","，")
elseif buffType==2 then
local buffCfg=cfgHelper.get1(cfg_fairylandbuffconfig_get,buffId)
arg1=buffCfg.name
arg2=buffCfg.desc
end

return string.format(fmt,arg1,arg2)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1,arg2

local buffType=jsonData[1]
local buffId=jsonData[2]
if buffType==1 then
local guildstateconfig=cfg_guildstateconfig_get(buffId)
arg1=guildstateconfig.name
arg2=homeBuffModel:getBuffDescByStateId(buffId)
arg2=string.replace(arg2,"\n","，")
elseif buffType==2 then
local buffCfg=cfgHelper.get1(cfg_fairylandbuffconfig_get,buffId)
arg1=buffCfg.name
arg2=buffCfg.desc
end

return string.format(fmt,arg1,arg2)
end
},
[XIANGUAN_PRIVILEGE_ENUM.eXunYouWanJie]=
{
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local type=jsonData[1]
local cfg=cfgHelper.get1(cfg_xianguanxianxutypeconfig_get,type)
local arg1=cfg.namestr
return string.format(fmt,arg1)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local type=jsonData[1]
local cfg=cfgHelper.get1(cfg_xianguanxianxutypeconfig_get,type)
local arg1=cfg.namestr
return string.format(fmt,arg1)
end
},
[XIANGUAN_PRIVILEGE_ENUM.eTianLuoDiWang]={
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1=jsonData[4]
return string.format(fmt,arg1)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1=jsonData[4]
return string.format(fmt,arg1)
end
},
[XIANGUAN_PRIVILEGE_ENUM.ePoJieZhuTian]={
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1=jsonData[4]
return string.format(fmt,arg1)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1=jsonData[4]
return string.format(fmt,arg1)
end
},
[XIANGUAN_PRIVILEGE_ENUM.ePoJieZhuTian2]={
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1=jsonData[4]
return string.format(fmt,arg1)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local arg1=jsonData[4]
return string.format(fmt,arg1)
end
},

[XIANGUAN_PRIVILEGE_ENUM.eTqType_20]={
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local result=jsonData[1]or 1
fmt=xianguanConfig.getTeQuanCfg(data.tqid,"sketchyLog")
if fmt==nil then return""end
fmt=string.replaceSpace(fmt[result])
fmt=string.gsub(fmt,"#ca631d","#fd8950")

local arg1=jsonData[2]
return string.format(fmt,arg1)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
if jsonData==nil then return fmt end

local result=jsonData[1]or 1
fmt=xianguanConfig.getTeQuanCfg(data.tqid,"sketchyLog")
if fmt==nil then return""end
fmt=string.replaceSpace(fmt[result])
fmt=string.gsub(fmt,"ca631d","fd8950")

local arg1=jsonData[2]
return string.format(fmt,arg1)
end
},

[XIANGUAN_PRIVILEGE_ENUM.eTqType_18]={
fmtDetailLogFunc=function(fmt,data)
return fmt
end,
fmtSketcyLogFunc=function(fmt,data)
return fmt
end
},

[XIANGUAN_PRIVILEGE_ENUM.eTqType_17]={
fmtDetailLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
local arg1=jsonData[4]
return string.format(fmt,arg1)
end,
fmtSketcyLogFunc=function(fmt,data)
local jsonData=jsonHelper.decode(data.params)
local arg1=jsonData[4]
return string.format(fmt,arg1)
end
},
}

function xianguanModel:getDetailLogDesc(data)
local func=_logDescFmtFuncs[data.tqid]

local fmt=xianguanConfig.getTeQuanCfg(data.tqid,"log")
if fmt==nil then return""end
fmt=string.replaceSpace(fmt[1])

if func~=nil and func.fmtDetailLogFunc then
fmt=func.fmtDetailLogFunc(fmt,data)
end

fmt=string.gsub(fmt,'aae252','549327')
return fmt
end

function xianguanModel:getsketchyLogDesc(data)
local func=_logDescFmtFuncs[data.tqid]

local fmt=xianguanConfig.getTeQuanCfg(data.tqid,"sketchyLog")
if fmt==nil then return""end
fmt=string.replaceSpace(fmt[1])
fmt=string.gsub(fmt,"ca631d","fd8950")
if func~=nil and func.fmtSketcyLogFunc then
return func.fmtSketcyLogFunc(fmt,data)
else
return fmt
end
end