local xianJieLog
local xianJieCDLog
local fightLog
local prefightLog
local monsterLog
local resourceLog
local arenaLog
local moGongLog
local mxslSingleLog

local newRecord_fight
local newRecord_prefight
local newRecord_monster
local newRecord_resource
local newRecord_arena
local newRecord_moGong
local newRecord_mxslSingle
local refreshtime

local recvtime

local JiJie_Data

local reddotchangeflag

local tipsflag
local judeflagtime
local recordLogLookup={}
local recordLogData
local searchLogLookup={}
local searchLogLookup2={}
local tqyuanjunlist={}

local cjson=require'cjson'

function xianjieModel:clearData_moulue()
xianJieLog=nil
xianJieCDLog=nil
fightLog=nil
prefightLog=nil
monsterLog=nil
resourceLog=nil
arenaLog=nil
moGongLog=nil
mxslSingleLog=nil
newRecord_fight=nil
newRecord_prefight=nil
newRecord_monster=nil
newRecord_resource=nil
newRecord_arena=nil
newRecord_moGong=nil
JiJie_Data=nil
refreshtime=nil
reddotchangeflag=false
tipsflag=false
judeflagtime=0
recordLogLookup={}
recordLogData=nil
searchLogLookup={}
searchLogLookup2={}
tqyuanjunlist={}
end

function xianjieModel:initData_moulue()
xianJieLog={}
xianJieCDLog={}
fightLog={}
prefightLog={}
monsterLog={}
resourceLog={}
arenaLog={}
moGongLog={}
mxslSingleLog={}
newRecord_fight={}
newRecord_prefight={}
newRecord_monster={}
newRecord_resource={}
newRecord_arena={}
newRecord_moGong={}
JiJie_Data={}
refreshtime=nil
reddotchangeflag=false
tipsflag=true
judeflagtime=0
recordLogLookup={}
recordLogData=nil
searchLogLookup={}
searchLogLookup2={}
tqyuanjunlist={}
end

function xianjieModel:SetXianJieLog(len,tb)
if len>0 then
xianJieLog={}

local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(tb)do
local cfg=cfgHelper.get1(cfg_fairylandlogconfig_get,v.logtype)
if cfg.duration==nil then
table.insert(xianJieLog,v)
elseif nowTime<(v.sec+cfg.duration)then
table.insert(xianJieLog,v)
xianJieCDLog[v.guid]=v.sec+cfg.duration
end
end

xianjieModel:CheckXpcall()
xianjieModel:Set_newflag()
xianjieModel:log_paixu()
xianjieModel:ChaiFenLog()
xianjieModel:Set_searchLookup()
end
end
function xianjieModel:loadRecord_Fight()
newRecord_fight=userActorSetting.get("xianJieLog_fight",{})
end
function xianjieModel:loadRecord_preFight()
newRecord_prefight=userActorSetting.get("xianJieLog_prefight",{})
end
function xianjieModel:loadRecord_Monster()
newRecord_monster=userActorSetting.get("xianJieLog_monster",{})
end
function xianjieModel:loadRecord_Resource()
newRecord_resource=userActorSetting.get("xianJieLog_resource",{})
end
function xianjieModel:loadRecord_Arena()
newRecord_arena=userActorSetting.get("xianJieLog_arena",{})
end
function xianjieModel:loadRecord_MoGong()
newRecord_moGong=userActorSetting.get("xianJieLog_moGong",{})
end
function xianjieModel:loadRecord_MXSLSingle()
newRecord_mxslSingle=userActorSetting.get("xianJieLog_mxslSingle",{})
end

function xianjieModel:saveRecord_Fight()
userActorSetting.set("xianJieLog_fight",fightLog)
userActorSetting.flush()
end

function xianjieModel:saveRecord_preFight()
userActorSetting.set("xianJieLog_prefight",prefightLog)
userActorSetting.flush()
end

function xianjieModel:saveRecord_Monster()
userActorSetting.set("xianJieLog_monster",monsterLog)
userActorSetting.flush()
end

function xianjieModel:saveRecord_Resource()
userActorSetting.set("xianJieLog_resource",resourceLog)
userActorSetting.flush()
end

function xianjieModel:saveRecord_Arena()
userActorSetting.set("xianJieLog_arena",arenaLog)
userActorSetting.flush()
end

function xianjieModel:saveRecord_MoGong()
userActorSetting.set("xianJieLog_moGong",moGongLog)
userActorSetting.flush()
end

function xianjieModel:saveRecord_MXSLSingle()
userActorSetting.set("xianJieLog_mxslSingle",mxslSingleLog)
userActorSetting.flush()
end


function xianjieModel:log_paixu()
table.sort(xianJieLog,function(a,b)
return a['sec']>b['sec']
end)
end

function xianjieModel:CheckXpcall()














for i=1,#xianJieLog do
xpcall(function()
string.format('%d,%d,%d,%s,%d,%d',xianJieLog[i].guid,xianJieLog[i].sec,
xianJieLog[i].logtype,xianJieLog[i].params,xianJieLog[i].len,xianJieLog[i].recv)
end,function(err)
local v=xianJieLog[i]
xianJieCDLog[v.guid]=nil
table.remove(xianJieLog,i)
i=i-1
end)
end
end

function xianjieModel:Set_newflag()
if xianJieLog and next(xianJieLog)then
for k,v in ipairs(xianJieLog)do
local group=cfgHelper.get2(cfg_fairylandlogconfig_get,v.logtype,"group")
v['isnew']=1
v['group']=group
end
end
end

function xianjieModel:ChaiFenLog()

fightLog={}
prefightLog={}
monsterLog={}
resourceLog={}
arenaLog={}
moGongLog={}
mxslSingleLog={}
for k,v in ipairs(xianJieLog)do
local type_cfg=cfgHelper.get2(cfg_fairylandlogconfig_get,v.logtype,"type")
if type_cfg==1 then
monsterLog[#monsterLog+1]=v
elseif type_cfg==2 then
resourceLog[#resourceLog+1]=v
elseif type_cfg==3 then

arenaLog[#arenaLog+1]=v
elseif type_cfg==4 then
moGongLog[#moGongLog+1]=v
elseif type_cfg==5 then
mxslSingleLog[#mxslSingleLog+1]=v
end
end


self:loadRecord_Monster()
self:loadRecord_Resource()
self:loadRecord_Arena()
self:loadRecord_MoGong()
self:loadRecord_MXSLSingle()








if newRecord_monster and next(newRecord_monster)then
for k,v in pairs(newRecord_monster)do
for k1,v1 in ipairs(monsterLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end
if newRecord_resource and next(newRecord_resource)then
for k,v in pairs(newRecord_resource)do
for k1,v1 in ipairs(resourceLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end
if newRecord_arena and next(newRecord_arena)then
for k,v in pairs(newRecord_arena)do
for k1,v1 in ipairs(arenaLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end
if newRecord_moGong and next(newRecord_moGong)then
for k,v in pairs(newRecord_moGong)do
for k1,v1 in ipairs(moGongLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end
if newRecord_mxslSingle and next(newRecord_mxslSingle)then
for k,v in pairs(newRecord_mxslSingle)do
for k1,v1 in ipairs(mxslSingleLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end
end


function xianjieModel:Set_searchLookup()
searchLogLookup={}
searchLogLookup2={}
for k,v in ipairs(xianJieLog)do
if v.logtype==1 or v.logtype==32 then
local logtb=cjson.decode(v.params)
if logtb and logtb[3]~=nil then
local actorid=tostring(logtb[3])
local stationguid=tostring(logtb[4]or 0)
xianjieModel:Set_searchLogLookup(actorid,stationguid,v)
end
elseif v.logtype==104 then
local logtb=cjson.decode(v.params)
if logtb and logtb[2]~=nil then
local guildidStr=logtb[2]
xianjieModel:Set_searchLogLookup2(guildidStr,v)
end
end
end
end


function xianjieModel:Get_logtb()
return xianJieLog
end

function xianjieModel:Get_singlelog(id)
return xianJieLog[id]
end

function xianjieModel:Get_singlelogByGuid(guid)
for k,v in ipairs(xianJieLog)do
if v.guid==guid then
return v
end
end
return nil
end


function xianjieModel:Get_fighttb()
return fightLog
end
function xianjieModel:Get_singleFighttb(id)
return fightLog[id]
end

function xianjieModel:Get_prefighttb()
return prefightLog
end
function xianjieModel:Get_singlePreFighttb(id)
return prefightLog[id]
end


function xianjieModel:Get_monstertb()
return monsterLog
end
function xianjieModel:Get_singleMonstertb(id)
return monsterLog[id]
end

function xianjieModel:Get_resourcetb()
return resourceLog
end
function xianjieModel:Get_singleResourcetb(id)
return resourceLog[id]
end

function xianjieModel:Get_arenatb()
return arenaLog
end
function xianjieModel:Get_singleArenatb(id)
return arenaLog[id]
end

function xianjieModel:Get_moGongtb()
return moGongLog
end
function xianjieModel:Get_singleMoGongtb(id)
return moGongLog[id]
end

function xianjieModel:Get_mxslSingletb()
return mxslSingleLog
end
function xianjieModel:Get_singleMXSLSingletb(id)
return mxslSingleLog[id]
end


function xianjieModel:Get_ShanHaiLogCfg(id)
cfgHelper.get1(cfg_fairylandlogconfig_get,id)
end


function xianjieModel:Find_MonsterReward()
local guid_tb={}
if next(monsterLog)then
for k,v in ipairs(monsterLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end
return guid_tb
end

function xianjieModel:get_monsterReddot()
local guid_tb=self:Find_MonsterReward()
if next(guid_tb)then
return true
end
return false
end

function xianjieModel:get_SearchReddot()
return false
end

function xianjieModel:Find_Monsterguid()
local monsterguid_tb={}
if next(monsterLog)then
for k,v in ipairs(monsterLog)do
if v.len==0 or v.recv==1 then
table.insert(monsterguid_tb,v.guid)
end
end
end
return monsterguid_tb
end

function xianjieModel:Find_ResourceReward()
local guid_tb={}
if next(resourceLog)then
for k,v in ipairs(resourceLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end
return guid_tb
end

function xianjieModel:get_ResourceReddot()
local guid_tb=xianjieModel:Find_ResourceReward()
if next(guid_tb)then
return true
end
return false
end

function xianjieModel:Find_Resourceguid()
local Resourceguid_tb={}
if next(resourceLog)then
for k,v in ipairs(resourceLog)do
if v.len==0 or v.recv==1 then
table.insert(Resourceguid_tb,v.guid)
end
end
end
return Resourceguid_tb
end

function xianjieModel:Find_ArenaReward()
local guid_tb={}
if next(arenaLog)then
for k,v in ipairs(arenaLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end
return guid_tb
end

function xianjieModel:get_ArenaReddot()
local guid_tb=xianjieModel:Find_ArenaReward()
if next(guid_tb)then
return true
end
return false
end

function xianjieModel:Find_Arenaguid()
local areanguid_tb={}
if next(arenaLog)then
for k,v in ipairs(arenaLog)do
if v.len==0 or v.recv==1 then
table.insert(areanguid_tb,v.guid)
end
end
end
return areanguid_tb
end

function xianjieModel:Find_MongGongReward()
local guid_tb={}
if next(moGongLog)then
for k,v in ipairs(moGongLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end
return guid_tb
end

function xianjieModel:get_MongGongReddot()
local guid_tb=xianjieModel:Find_MongGongReward()
if next(guid_tb)then
return true
end
return false
end

function xianjieModel:Find_MongGongGuid()
local guid_tb={}
if next(moGongLog)then
for k,v in ipairs(moGongLog)do
if v.len==0 or v.recv==1 then
table.insert(guid_tb,v.guid)
end
end
end
return guid_tb
end

function xianjieModel:Find_MXSLSingleReward()
local guid_tb={}
if next(mxslSingleLog)then
for k,v in ipairs(mxslSingleLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end
return guid_tb
end

function xianjieModel:get_MXSLSingleReddot()
local guid_tb=xianjieModel:Find_MXSLSingleReward()
if next(guid_tb)then
return true
end
return false
end

function xianjieModel:Find_MXSLSingleGuid()
local mxslSingleGuid_tb={}
if next(mxslSingleLog)then
for k,v in ipairs(mxslSingleLog)do
if v.len==0 or v.recv==1 then
table.insert(mxslSingleGuid_tb,v.guid)
end
end
end
return mxslSingleGuid_tb
end

function xianjieModel:Delete_log(len,delete_logtb)
if len>0 then

for k1,v1 in ipairs(delete_logtb)do
for i=1,#xianJieLog do
local v=xianJieLog[i]
if v.guid==v1 then
table.remove(xianJieLog,i)
xianJieCDLog[v.guid]=nil
i=i-1
break
end
end
end

xianjieModel:ChaiFenLog()
xianjieModel:Set_searchLookup()
end
end

function xianjieModel:Set_yetrecv(loglen,log_tb)
if loglen>0 then
for i=1,#xianJieLog do
for k1,v1 in ipairs(log_tb)do
if xianJieLog[i].guid==v1 then
xianJieLog[i].recv=1
end
end
end
end
self:ChaiFenLog()
end

function xianjieModel:Get_lognum()
local g_tb={}
if next(xianJieLog)then
for k,v in ipairs(xianJieLog)do
if not g_tb[v.group]then
g_tb[v.group]=1
else
g_tb[v.group]=g_tb[v.group]+1
end
end
end
return g_tb
end

function xianjieModel:Get_groupLogNum(groupid)
local g_tb=0
if next(xianJieLog)then
for k,v in ipairs(xianJieLog)do
if v.group==groupid then
g_tb=g_tb+1
end
end
end
return g_tb
end

function xianjieModel:Jude_isShowTips()
local log_numtb=xianjieModel:Get_lognum()
local num=cfg_fairylandlogconfig().const_def.log_tips
if log_numtb and log_numtb[1]and log_numtb[1]>=num then
return true
elseif log_numtb and log_numtb[2]and log_numtb[2]>=num then
return true
elseif log_numtb and log_numtb[4]and log_numtb[4]>=num then
return true
end
return false
end

function xianjieModel:Jude_isShowMaxTips()
local log_numtb=xianjieModel:Get_lognum()
local num=50
if log_numtb and log_numtb[1]and log_numtb[1]>=num then
return true
elseif log_numtb and log_numtb[2]and log_numtb[2]>=num then
return true
elseif log_numtb and log_numtb[4]and log_numtb[4]>=num then
return true
end
return false
end

function xianjieModel:SetJiJie_Data(guid,len,log_tb)
if len>0 then
if not JiJie_Data then
JiJie_Data={}
end
JiJie_Data[guid]=log_tb
end
end
function xianjieModel:clearJiJie_Data()
JiJie_Data={}
end
function xianjieModel:GetJiJie_Databy(guid)
return JiJie_Data[guid]
end

function xianjieModel:isNewRiZhi()
local data1=xianjieModel:Get_monstertb()
if data1 then
for k,v in ipairs(data1)do
if v and v.isnew==1 then
return true
end
end
end
local data2=xianjieModel:Get_resourcetb()
if data2 then
for k,v in ipairs(data2)do
if v and v.isnew==1 then
return true
end
end
end
local data3=xianjieModel:Get_arenatb()
if data3 then
for k,v in ipairs(data3)do
if v and v.isnew==1 then
return true
end
end
end
local data4=xianjieModel:Get_moGongtb()
if data4 then
for k,v in ipairs(data4)do
if v and v.isnew==1 then
return true
end
end
end
return false
end

function xianjieModel:isNewRiZhi_MXSL()
local data1=xianjieModel:Get_mxslSingletb()
if data1 then
for k,v in ipairs(data1)do
if v and v.isnew==1 then
return true
end
end
end
end



function xianjieModel:jude_haveReward()
local flag1=self:get_monsterReddot()
local flag2=self:get_ResourceReddot()
local flag3=self:get_ArenaReddot()
local flag4=self:get_MongGongReddot()
if flag1 or flag2 or flag3 or flag4 then
return true
else
self:Record_refreshtime(timeHelper.getServerShortTime())
return false
end
end

function xianjieModel:jude_xianjielog_reddot()
local timedata=self:Get_timedata()
if not timedata or(timedata and timedata==0)then
return false
end
local record_time=self:loadRecord_refreshtime()
if not record_time and timedata>0 then
return true
end
return record_time<timedata
end

function xianjieModel:Set_181_timedata(timesec)
recvtime=timesec
xianjieModel:First_reddotchangeflag()
end

function xianjieModel:First_reddotchangeflag()
local flag=xianjieModel:jude_xianjielog_reddot()
reddotchangeflag=flag
end

function xianjieModel:Set_reddotchangeflag(flag)
reddotchangeflag=flag
end
function xianjieModel:Get_reddotchangeflag()
return reddotchangeflag
end

function xianjieModel:Set_timedata(timesec)
recvtime=timesec
end
function xianjieModel:Get_timedata()
return recvtime
end


function xianjieModel:Record_refreshtime(recordsec)
userActorSetting.set("xianJieLog_refresh_time",recordsec)
userActorSetting.flush()
end

function xianjieModel:loadRecord_refreshtime()
refreshtime=userActorSetting.get("xianJieLog_refresh_time",nil)
return refreshtime
end

function xianjieModel:set_sendtime(recordsec)
judeflagtime=recordsec
end
function xianjieModel:get_sendtime()
return judeflagtime
end


function xianjieModel:Get_logtips()
local needtipslog={}
for k,v in ipairs(monsterLog)do
if v.isnew==1 and v.len>0 then
needtipslog[#needtipslog+1]=v
end
end

for k,v in ipairs(resourceLog)do
if v.isnew==1 and v.len>0 then
needtipslog[#needtipslog+1]=v
end
end

for k,v in ipairs(arenaLog)do
if v.isnew==1 and v.len>0 then
needtipslog[#needtipslog+1]=v
end
end
for k,v in ipairs(moGongLog)do
if v.isnew==1 and v.len>0 then
needtipslog[#needtipslog+1]=v
end
end
table.sort(needtipslog,function(a,b)
return a.sec>b.sec
end)
return needtipslog
end

function xianjieModel:Get_tipsflag()
return tipsflag
end
function xianjieModel:Set_tipsflag(flag)
tipsflag=flag
end


function xianjieModel:jude_isSend()

local timedata=self:Get_timedata()
if not timedata or(timedata and timedata==0)then
return false
end
local record_time=xianjieModel:get_sendtime()
if not record_time and timedata>0 then
return true
end
return record_time<timedata
end


function xianjieModel:Get_recordLogLookup(recordguid)
return recordLogLookup[recordguid]
end
function xianjieModel:Set_recordLogLookup(recordguid,log)
recordLogLookup[recordguid]=log
end


function xianjieModel:Get_searchLogLookup(actorid,stationguid)
local actorid_str=tostring(actorid)
local stationguid_str=tostring(stationguid)
if not searchLogLookup[actorid_str]then
return nil
end
return searchLogLookup[actorid_str][stationguid_str]
end
function xianjieModel:Set_searchLogLookup(actorid,stationguid,log)
local actorid_str=tostring(actorid)
local stationguid_str=tostring(stationguid)
if not searchLogLookup[actorid_str]then
searchLogLookup[actorid_str]={}
end
local oldLog=searchLogLookup[actorid_str][stationguid_str]
if oldLog then
if log.sec>oldLog.sec then
searchLogLookup[actorid_str][stationguid_str]=log
end
else
searchLogLookup[actorid_str][stationguid_str]=log
end
end

function xianjieModel:Get_searchLogLookup2(guildid)
local guildid_str=tostring(guildid)
return searchLogLookup2[guildid_str]
end
function xianjieModel:Set_searchLogLookup2(guildid,log)
local guildid_str=tostring(guildid)
local oldLog=searchLogLookup2[guildid_str]
if oldLog then
if log.sec>oldLog.sec then
searchLogLookup2[guildid_str]=log
end
else
searchLogLookup2[guildid_str]=log
end
end


function xianjieModel:Get_recordLogData()
return recordLogData
end
function xianjieModel:Set_recordLogData(logData)
recordLogData=logData
end

function xianjieModel:Check_fightLogNewFlag()
for k1,v1 in ipairs(fightLog)do
if v1.isnew==1 then
return true
end
end
return false
end

function xianjieModel:Update_fightLogNewFlag()
for k1,v1 in ipairs(fightLog)do
v1.isnew=0
end
end

function xianjieModel:Check_prefightLogNewFlag()
for k1,v1 in ipairs(prefightLog)do
if v1.isnew==1 then
return true
end
end
return false
end

function xianjieModel:Update_prefightLogNewFlag()
for k1,v1 in ipairs(prefightLog)do
v1.isnew=0
end
end

function xianjieModel:Check_arenaLogNewFlag()
local data=xianjieModel:Get_arenatb()
if data then
for k,v in ipairs(data)do
if v and v.isnew==1 then
return true
end
end
end

return false
end

function xianjieModel:Check_moGongLogNewFlag()
local data=xianjieModel:Get_moGongtb()
if data then
for k,v in ipairs(data)do
if v and v.isnew==1 then
return true
end
end
end

return false
end

function xianjieModel:Check_mxslSingleLogNewFlag()
local data=xianjieModel:Get_mxslSingletb()
if data then
for k,v in ipairs(data)do
if v and v.isnew==1 then
return true
end
end
end

return false
end

function xianjieModel:checkFuncRewardRecvMonsterLog(funcType,recv)
local max=UIPrisonModel:getEmptyRoomNum(2)
local count=0
for i,v in ipairs(monsterLog)do
if v.recv==recv and v.len>0 then
for j,w in ipairs(v.list)do
local itemid=w.param_1
local itemnum=w.param_2
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.type==funcType then
count=count+itemnum
if count>=max then
return true
end
end
end
end
end
return false
end


function xianjieModel:SetTQyuanjun_Data(guid,len,assistlist)
tqyuanjunlist={}
if len>0 then
tqyuanjunlist=assistlist
end
end
function xianjieModel:getTQyuanjun_Data()
return tqyuanjunlist or{}
end

function xianjieModel:checkCDLogAutoDelete()
if next(xianJieCDLog)~=nil then
local nowTime=timeHelper.getServerShortTime()
local list=nil
for guid,time in pairs(xianJieCDLog)do
if nowTime>=time then
list=list or{}
table.insert(list,guid)
end
end
if list then
xianjieController.recv_35_39(#list,list)
end
end
end
