local shanhaiLog
local fightLog
local prefightLog
local monsterLog
local resourceLog
local lingShanLog

local newRecord_fight
local newRecord_prefight
local newRecord_monster
local newRecord_resource
local newRecord_lingShan
local refreshtime

local recvtime

local JiJie_Data

local reddotchangeflag

local tipsflag
local judeflagtime
local recordLogLookup={}
local recordLogData
function zhengzhanshanhaiModel:clearData_moulue()
shanhaiLog=nil
fightLog=nil
prefightLog=nil
monsterLog=nil
resourceLog=nil
lingShanLog=nil
newRecord_fight=nil
newRecord_prefight=nil
newRecord_monster=nil
newRecord_resource=nil
newRecord_lingShan=nil
JiJie_Data=nil
refreshtime=nil
reddotchangeflag=false
tipsflag=false
judeflagtime=0
recordLogLookup={}
recordLogData=nil
end

function zhengzhanshanhaiModel:initData_moulue()
shanhaiLog={}
fightLog={}
prefightLog={}
monsterLog={}
resourceLog={}
lingShanLog={}
newRecord_fight={}
newRecord_prefight={}
newRecord_monster={}
newRecord_resource={}
newRecord_lingShan={}
JiJie_Data={}
refreshtime=nil
reddotchangeflag=false
tipsflag=false
judeflagtime=0
recordLogLookup={}
recordLogData=nil
end

function zhengzhanshanhaiModel:SetShanHaiLog(len,tb)

if len>0 then
shanhaiLog=tb
zhengzhanshanhaiModel:CheckXpcall()
zhengzhanshanhaiModel:Set_newflag()
zhengzhanshanhaiModel:log_paixu()
zhengzhanshanhaiModel:ChaiFenLog()














end
end

function zhengzhanshanhaiModel:loadRecord_Fight()
newRecord_fight=userActorSetting.get("zhengzhanshanhaiLog_fight",{})
end

function zhengzhanshanhaiModel:loadRecord_preFight()
newRecord_prefight=userActorSetting.get("zhengzhanshanhaiLog_prefight",{})
end

function zhengzhanshanhaiModel:loadRecord_Monster()
newRecord_monster=userActorSetting.get("zhengzhanshanhaiLog_monster",{})
end

function zhengzhanshanhaiModel:loadRecord_Resource()
newRecord_resource=userActorSetting.get("zhengzhanshanhaiLog_resource",{})
end

function zhengzhanshanhaiModel:loadRecord_lingShan()
newRecord_lingShan=userActorSetting.get("zhengzhanshanhaiLog_lingShan",{})
end


function zhengzhanshanhaiModel:saveRecord_Fight()
userActorSetting.set("zhengzhanshanhaiLog_fight",fightLog)
userActorSetting.flush()
end

function zhengzhanshanhaiModel:saveRecord_preFight()
userActorSetting.set("zhengzhanshanhaiLog_prefight",prefightLog)
userActorSetting.flush()
end

function zhengzhanshanhaiModel:saveRecord_Monster()
userActorSetting.set("zhengzhanshanhaiLog_monster",monsterLog)
userActorSetting.flush()
end

function zhengzhanshanhaiModel:saveRecord_Resource()
userActorSetting.set("zhengzhanshanhaiLog_resource",resourceLog)
userActorSetting.flush()
end

function zhengzhanshanhaiModel:saveRecord_lingShan()
userActorSetting.set("zhengzhanshanhaiLog_lingShan",lingShanLog)
userActorSetting.flush()
end


function zhengzhanshanhaiModel:log_paixu()
table.sort(shanhaiLog,function(a,b)
return a['sec']>b['sec']
end)
end


function zhengzhanshanhaiModel:CheckXpcall()














for i=1,#shanhaiLog do
xpcall(function()
string.format('%d,%d,%d,%s,%d,%d',shanhaiLog[i].guid,shanhaiLog[i].sec,
shanhaiLog[i].logtype,shanhaiLog[i].params,shanhaiLog[i].len,shanhaiLog[i].recv)
end,function(err)
table.remove(shanhaiLog,i)
i=i-1
end)
end




end

function zhengzhanshanhaiModel:Set_newflag()
if shanhaiLog and next(shanhaiLog)then
for k,v in ipairs(shanhaiLog)do
local group=zhengzhanshanhaiController:getZZSHCfg_log(v.logtype,"group")

v['isnew']=1

v['group']=group
end
end
end


function zhengzhanshanhaiModel:ChaiFenLog()

fightLog={}
prefightLog={}
monsterLog={}
resourceLog={}
lingShanLog={}

for k,v in ipairs(shanhaiLog)do
local type_cfg=zhengzhanshanhaiController:getZZSHCfg_log(v.logtype,"type")
if type_cfg==1 then
monsterLog[#monsterLog+1]=v
elseif type_cfg==2 then
resourceLog[#resourceLog+1]=v
elseif type_cfg==3 then
prefightLog[#prefightLog+1]=v
elseif type_cfg==4 then
fightLog[#fightLog+1]=v
elseif type_cfg==5 then
lingShanLog[#lingShanLog+1]=v
end
end
zhengzhanshanhaiModel:loadRecord_Fight()
zhengzhanshanhaiModel:loadRecord_preFight()
zhengzhanshanhaiModel:loadRecord_Monster()
zhengzhanshanhaiModel:loadRecord_Resource()
zhengzhanshanhaiModel:loadRecord_lingShan()



if newRecord_fight and next(newRecord_fight)then

for k,v in pairs(newRecord_fight)do
for k1,v1 in ipairs(fightLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end

if newRecord_prefight and next(newRecord_prefight)then

for k,v in pairs(newRecord_prefight)do
for k1,v1 in ipairs(prefightLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end

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

if newRecord_lingShan and next(newRecord_lingShan)then
for k,v in pairs(newRecord_lingShan)do
for k1,v1 in ipairs(lingShanLog)do
if v.guid==v1.guid then
v1.isnew=0
end
end
end
end

end

function zhengzhanshanhaiModel:Get_logtb()
return shanhaiLog
end


function zhengzhanshanhaiModel:Get_singlelog(id)
return shanhaiLog[id]
end

function zhengzhanshanhaiModel:Get_fighttb()
return fightLog
end

function zhengzhanshanhaiModel:Get_singleFighttb(id)
return fightLog[id]
end

function zhengzhanshanhaiModel:Get_prefighttb()
return prefightLog
end

function zhengzhanshanhaiModel:Get_singlePreFighttb(id)
return prefightLog[id]
end

function zhengzhanshanhaiModel:Get_monstertb()
return monsterLog
end

function zhengzhanshanhaiModel:Get_singleMonstertb(id)
return monsterLog[id]
end

function zhengzhanshanhaiModel:Get_resourcetb()
return resourceLog
end

function zhengzhanshanhaiModel:Get_singleResourcetb(id)
return resourceLog[id]
end

function zhengzhanshanhaiModel:Get_lingShantb()
return lingShanLog
end

function zhengzhanshanhaiModel:Get_singlelingShantb(id)
return lingShanLog[id]
end


function zhengzhanshanhaiModel:Get_ShanHaiLogCfg(id)
return zhengzhanshanhaiController:getZZSHCfg_log(id)
end


function zhengzhanshanhaiModel:Find_allLogReward()
local guid_tb={}

if next(monsterLog)then
for k,v in ipairs(monsterLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end

if next(resourceLog)then
for k,v in ipairs(resourceLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end

return guid_tb
end


function zhengzhanshanhaiModel:Find_MonsterReward()
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

function zhengzhanshanhaiModel:get_monsterReddot()
local guid_tb=zhengzhanshanhaiModel:Find_MonsterReward()
if next(guid_tb)then
return true
end
return false
end




function zhengzhanshanhaiModel:Find_Monsterguid()
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



function zhengzhanshanhaiModel:Find_ResourceReward()
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

function zhengzhanshanhaiModel:get_ResourceReddot()
local guid_tb=zhengzhanshanhaiModel:Find_ResourceReward()
if next(guid_tb)then
return true
end
return false
end


function zhengzhanshanhaiModel:Find_Resourceguid()
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



function zhengzhanshanhaiModel:Find_LingShanReward()
local guid_tb={}
if next(lingShanLog)then
for k,v in ipairs(lingShanLog)do
if v.len>0 and v.recv==0 then
table.insert(guid_tb,v.guid)
end
end
end

return guid_tb
end

function zhengzhanshanhaiModel:get_LingShanReddot()
local guid_tb=zhengzhanshanhaiModel:Find_LingShanReward()
if next(guid_tb)then
return true
end
return false
end


function zhengzhanshanhaiModel:Find_LingShanguid()
local LingShanguid_tb={}
if next(lingShanLog)then
for k,v in ipairs(lingShanLog)do
if v.len==0 or v.recv==1 then
table.insert(LingShanguid_tb,v.guid)
end
end
end
return LingShanguid_tb
end



function zhengzhanshanhaiModel:Delete_log(len,delete_logtb)
if len>0 then

for k1,v1 in ipairs(delete_logtb)do

for i=1,#shanhaiLog do
if shanhaiLog[i].guid==v1 then
table.remove(shanhaiLog,i)
i=i-1
break
end


end
end

zhengzhanshanhaiModel:ChaiFenLog()
end


end


function zhengzhanshanhaiModel:Set_yetrecv(loglen,log_tb)
if loglen>0 then
for i=1,#shanhaiLog do

for k1,v1 in ipairs(log_tb)do


if shanhaiLog[i].guid==v1 then

shanhaiLog[i].recv=1

end
end
end


end

zhengzhanshanhaiModel:ChaiFenLog()
end


function zhengzhanshanhaiModel:Get_lognum()
local g_tb={}
if next(shanhaiLog)then
for k,v in ipairs(shanhaiLog)do
if not g_tb[v.group]then
g_tb[v.group]=1
else
g_tb[v.group]=g_tb[v.group]+1
end
end
end

return g_tb
end


function zhengzhanshanhaiModel:Get_groupLogNum(groupid)
local g_tb=0
if next(shanhaiLog)then
for k,v in ipairs(shanhaiLog)do
if v.group==groupid then
g_tb=g_tb+1
end
end
end
return g_tb
end

function zhengzhanshanhaiModel:Get_groupLogMaxNum()
local maxNum=100
return maxNum
end


function zhengzhanshanhaiModel:Jude_isShowTips()
local log_numtb=zhengzhanshanhaiModel:Get_lognum()
local num=zhengzhanshanhaiController:getZZSHCfg_log("const_def").log_tips
if log_numtb and log_numtb[1]and log_numtb[1]>=num then
return true
elseif log_numtb and log_numtb[2]and log_numtb[2]>=num then
return true
end
return false
end


function zhengzhanshanhaiModel:Jude_isShowMaxTips()
local log_numtb=zhengzhanshanhaiModel:Get_lognum()
local num=zhengzhanshanhaiModel:Get_groupLogMaxNum()
if log_numtb and log_numtb[1]and log_numtb[1]>=num then
return true
elseif log_numtb and log_numtb[2]and log_numtb[2]>=num then
return true
end
return false
end




function zhengzhanshanhaiModel:SetJiJie_Data(guid,len,log_tb)
if len>0 then
JiJie_Data=log_tb
end

end

function zhengzhanshanhaiModel:GetJiJie_Data()

return JiJie_Data
end


function zhengzhanshanhaiModel:jude_haveReward()

local flag1=zhengzhanshanhaiModel:get_monsterReddot()
local flag2=zhengzhanshanhaiModel:get_ResourceReddot()
local flag3=zhengzhanshanhaiModel:get_LingShanReddot()
if flag1 or flag2 or flag3 then
return true
else

zhengzhanshanhaiModel:Record_refreshtime(timeHelper.getServerShortTime())
return false
end
end


function zhengzhanshanhaiModel:Set_181_timedata(timesec)
recvtime=timesec

zhengzhanshanhaiModel:First_reddotchangeflag()
end

function zhengzhanshanhaiModel:Get_timedata()
return recvtime
end

function zhengzhanshanhaiModel:Set_241_timedata(timesec)
recvtime=timesec
end


function zhengzhanshanhaiModel:Record_refreshtime(recordsec)

userActorSetting.set("zhengzhanshanhaiLog_refresh_time",recordsec)
userActorSetting.flush()
end

function zhengzhanshanhaiModel:loadRecord_refreshtime()
refreshtime=userActorSetting.get("zhengzhanshanhaiLog_refresh_time",nil)
return refreshtime
end



function zhengzhanshanhaiModel:set_sendtime(recordsec)
judeflagtime=recordsec

end

function zhengzhanshanhaiModel:get_sendtime()
return judeflagtime
end


function zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()

local timedata=zhengzhanshanhaiModel:Get_timedata()

if not timedata or(timedata and timedata==0)then
return false
end
local record_time=zhengzhanshanhaiModel:loadRecord_refreshtime()

if not record_time and timedata>0 then
return true
end

return record_time<timedata
end



function zhengzhanshanhaiModel:First_reddotchangeflag()
local flag=zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
reddotchangeflag=flag
end


function zhengzhanshanhaiModel:Set_reddotchangeflag(flag)
reddotchangeflag=flag
end

function zhengzhanshanhaiModel:Get_reddotchangeflag()
return reddotchangeflag
end


function zhengzhanshanhaiModel:Get_logtips()
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
table.sort(needtipslog,function(a,b)
return a.sec>b.sec
end)
return needtipslog
end

function zhengzhanshanhaiModel:Get_tipsflag()
return tipsflag
end
function zhengzhanshanhaiModel:Set_tipsflag(flag)
tipsflag=flag
end


function zhengzhanshanhaiModel:jude_isSend()


local timedata=zhengzhanshanhaiModel:Get_timedata()

if not timedata or(timedata and timedata==0)then
return false
end
local record_time=zhengzhanshanhaiModel:get_sendtime()

if not record_time and timedata>0 then
return true
end

return record_time<timedata
end


function zhengzhanshanhaiModel:Get_recordLogLookup(recordguid)
return recordLogLookup[recordguid]
end
function zhengzhanshanhaiModel:Set_recordLogLookup(recordguid,log)
recordLogLookup[recordguid]=log
end


function zhengzhanshanhaiModel:Get_recordLogData()
return recordLogData
end
function zhengzhanshanhaiModel:Set_recordLogData(logData)
recordLogData=logData
end

function zhengzhanshanhaiModel:Check_fightLogNewFlag()
for k1,v1 in ipairs(fightLog)do
if v1.isnew==1 then
return true
end
end
return false
end

function zhengzhanshanhaiModel:Update_fightLogNewFlag()
for k1,v1 in ipairs(fightLog)do
v1.isnew=0
end
end

function zhengzhanshanhaiModel:Check_prefightLogNewFlag()
for k1,v1 in ipairs(prefightLog)do
if v1.isnew==1 then
return true
end
end
return false
end

function zhengzhanshanhaiModel:Update_prefightLogNewFlag()
for k1,v1 in ipairs(prefightLog)do
v1.isnew=0
end
end
