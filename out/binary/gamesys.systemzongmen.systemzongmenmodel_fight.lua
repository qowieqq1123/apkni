




local _fightFlagLookup={}

local _fightFlagLookupCount=0

















local _fightRecordList={}













local _waitResultList={}















local _waitNotifyResult={}













local _defenseInfos={}













local _attackInfos={}


local _getFightFlagEndTimer={
[systemZongMenFightFlagType.eBeAttacked]=function(sinceTime)
local duration=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"battleTime")
return sinceTime+duration
end,
[systemZongMenFightFlagType.eAttacking]=function(sinceTime)
local duration=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"teamMoveTime",2)
return sinceTime+duration
end,
[systemZongMenFightFlagType.eSurrender]=function(sinceTime)
local day=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"dealTime")
local longStamp=timeHelper.convertLongStamp(sinceTime)

local temp=sinceTime%86400
local interval=temp>3600*5 and 1 or 0
local sinceZero=timeHelper.getServerZeroStamp(longStamp)
return timeHelper.convertShortStamp(sinceZero+(day+interval)*86400+3600*5)
end,
[systemZongMenFightFlagType.eExpel]=function(sinceTime)
local day=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"destroy_stand_time")
local longStamp=timeHelper.convertLongStamp(sinceTime)

local temp=sinceTime%86400
local interval=temp>3600*5 and 1 or 0
local sinceZero=timeHelper.getServerZeroStamp(longStamp)
return timeHelper.convertShortStamp(sinceZero+(day+interval)*86400+3600*5)
end,
[systemZongMenFightFlagType.eVassal]=function(sinceTime)
local day=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"fyTime")
local longStamp=timeHelper.convertLongStamp(sinceTime)

local temp=sinceTime%86400
local interval=temp>3600*5 and 1 or 0
local sinceZero=timeHelper.getServerZeroStamp(longStamp)
return timeHelper.convertShortStamp(sinceZero+(day+interval)*86400+3600*5)
end,
}

local _checkFightFlagOutgoerShow={
[systemZongMenFightFlagType.eNone]=true,
[systemZongMenFightFlagType.eVassal]=true,
}









local _battleFightingFlagType={
[systemZongMenFightFlagType.eBeAttacked]=true,
[systemZongMenFightFlagType.eAttacking]=true,
}

local _fightFlagHUDHandle={
[systemZongMenFightFlagType.eBeAttacked]={
spine=2089,
over="等待状态结束",
},
[systemZongMenFightFlagType.eSurrender]={
image={globalABLookup.dashijie_component,"image_touxiang_2"},
over="等待状态结束",
color='ADE452',
},
[systemZongMenFightFlagType.eVassal]={
image={globalABLookup.dashijie_component,"image_jzqipao_2"},
over="等待状态结束",
color='ADE452',
},
[systemZongMenFightFlagType.eExpel]={
over="等待消失",
color='0adc0a',
postStr="消失"
}
}


function systemZongMenModel:isFightingAboutFlag(flag)
return _battleFightingFlagType[flag]
end

function systemZongMenModel:getFightFlagHUDHandle(flag)
return _fightFlagHUDHandle[flag]
end
















function systemZongMenModel:checkFightFlagOutgoerShowEx(serial)
local infoData=self:getInfoData(serial)
if infoData then
return self:checkFightFlagOutgoerShow(infoData.flag)
end
end


function systemZongMenModel:checkFightFlagOutgoerShow(flagType)
return _checkFightFlagOutgoerShow[flagType]or false
end



function systemZongMenModel:clearFightFlagLookup()
table.clear(_fightFlagLookup)
_fightFlagLookupCount=0
end


function systemZongMenModel:addFightFlagLookup(serial)
local infoData=self:getInfoData(serial)
self:checkAddFightFlagLookup(infoData)
end


function systemZongMenModel:checkAddFightFlagLookup(infoData)
if infoData.flag~=systemZongMenFightFlagType.eNone then
local flag=infoData.flag
if _fightFlagLookup[flag]==nil then
_fightFlagLookup[flag]={}
end
table.insert(_fightFlagLookup[flag],infoData.serial)
_fightFlagLookupCount=_fightFlagLookupCount+1
end
end


function systemZongMenModel:isExistFightFlag(flagType)
if flagType~=nil and flagType~=systemZongMenFightFlagType.eNone then
local list=_fightFlagLookup[flagType]
if list then
return#list>0
else
return false
end
else
return _fightFlagLookupCount>0
end
end


function systemZongMenModel:isExistFightFlags(flagTypes)
if flagTypes and#flagTypes>0 then
for index,flagType in ipairs(flagTypes)do
local list=_fightFlagLookup[flagType]
if list and#list>0 then
return true
end
end
return false
else
return _fightFlagLookupCount>0
end
end


function systemZongMenModel:deleteFightFlagLookup(serial,flagType)
if flagType then
local lookup=_fightFlagLookup[flagType]
if lookup and table.removeValue(lookup,serial)then
_fightFlagLookupCount=_fightFlagLookupCount-1
end
else
for _flagType,lookup in pairs(_fightFlagLookup)do
if table.removeValue(lookup,serial)then
_fightFlagLookupCount=_fightFlagLookupCount-1
return
end
end
end
end


function systemZongMenModel:getFightFlagLookup(flagType)
return _fightFlagLookup[flagType]
end


function systemZongMenModel:getAllFightFlagLookup()
return _fightFlagLookup
end


function systemZongMenModel:getAllFightFlagLookupCount()
return _fightFlagLookupCount
end


function systemZongMenModel:getFightFlagEndTime(infoData)
local func=_getFightFlagEndTimer[infoData.flag]
if func then
return func(infoData.start_time)
end
return 0
end


function systemZongMenModel:setDefenseInfo(serial,hdValue,team)
local infoData=self:getInfoData(serial)
if infoData then
local value=hdValue
if hdValue<0 then
local config=cfgHelper.get1(cfg_syssectconfig_get,infoData.id)
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local params=config.dazhenLv or baseCfg.dzParams
local allSmCfg=cfg_shanmendazhenconfig()
local level=math.floor(infoData.level*params[1]+params[2])
local smCfg=allSmCfg[Mathf.Clamp(level,0,#allSmCfg)]
value=smCfg.shield
end
_defenseInfos[infoData.serial_str]={
serial_str=infoData.serial_str,
serial=serial,
value=value,
team=team or{},
}
end
end


function systemZongMenModel:getDefenseInfo(serial)
return _defenseInfos[tostring(serial)]
end


function systemZongMenModel:checkDefenseInfo(serial)
return self:getDefenseInfo(serial)~=nil
end


function systemZongMenModel:clearDefenseInfo()
table.clear(_defenseInfos)
end


function systemZongMenModel:deleteDefenseInfo(serial)
_defenseInfos[tostring(serial)]=nil
end



function systemZongMenModel:initBattleWaitResult(xtzmAttackInfo_List,discipleShow_List)
self:clearBattleWaitResult()
local list=xtzmAttackInfo_List or{}
for i,v in ipairs(list)do
local serial=v.xtzm_serial
for j=1,v.team_num do
local teamData=v.teamList[j]
local teamIndex=teamData.param_1
local timeStamp=teamData.param_2
self:addBattleWaitResult(serial,teamIndex,timeStamp)
end
end

list=discipleShow_List or{}
local lookup=self:getFightFlagLookup(systemZongMenFightFlagType.eAttacking)
if lookup and#lookup>0 then
local serial=lookup[1]
local infoData=self:getInfoData(serial)
self:setAttackInfo(serial,#list,list,infoData.end_time)
self:addBattleWaitResult(serial,0,infoData.end_time,infoData.start_time)
end


end


function systemZongMenModel:addBattleWaitResult(serial,teamIndex,timeStamp,sinceStamp)
if sinceStamp==nil then
local config=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"teamMoveTime")
sinceStamp=timeStamp-(teamIndex>0 and config[1]or config[2])
end
local temp={
serial_str=tostring(serial),
serial=serial,
teamIndex=teamIndex,
sinceStamp=sinceStamp,
gameStamp=timeStamp,
waitSend=teamIndex>0 and timeStamp>timeHelper.getServerShortTime(),
}
table.insert(_waitResultList,temp)
end


function systemZongMenModel:findBattleWaitResultEx(serial,teamIndex)
return self:findBattleWaitResult(tostring(serial),teamIndex)
end


function systemZongMenModel:findBattleWaitResult(serial_str,teamIndex)
for i,v in ipairs(_waitResultList)do
if v.serial_str==serial_str and v.teamIndex==teamIndex then
return v,i
end
end
end

function systemZongMenModel:isExistBattleWaitResult(serial)
local serial_str=tostring(serial)
for i,v in ipairs(_waitResultList)do
if v.serial_str==serial_str then
return true
end
end
return false
end


function systemZongMenModel:deleteBattleWaitResult(serial,teamIndex)
local temp,index=self:findBattleWaitResultEx(serial,teamIndex)

if index then
table.remove(_waitResultList,index)
end
return temp
end


function systemZongMenModel:clearBattleWaitResult()
table.clear(_waitResultList)
end


function systemZongMenModel:getAllBattleWaitResult()
return _waitResultList
end


function systemZongMenModel:haveBattleWaitResultNeedSend()
for i,v in ipairs(_waitResultList)do
if v.waitSend then
return true
end
end
return false
end


function systemZongMenModel:countBattleWaitResult(serial)
local count=0
for i,v in ipairs(_waitResultList)do
if v.serial_str==tostring(serial)then
count=count+1
end
end
return count
end


function systemZongMenModel:findBattleWaitResultBySerial(serial)
local list={}
for i,v in ipairs(_waitResultList)do
if v.serial_str==tostring(serial)then
table.insert(list,v)
end
end
return list
end



function systemZongMenModel:loadFightRecordList()
_fightRecordList=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eSystemZongMenFightRecord,{})
end


function systemZongMenModel:saveFightReportList()
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eSystemZongMenFightRecord,_fightRecordList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSystemZongMenFightRecord)
end


function systemZongMenModel:addBattleResultReport(waitResultData,result,reports,items)
local infoData=self:getInfoData(waitResultData.serial)
if infoData then
local itemList={}
for i,v in ipairs(items)do
table.insert(itemList,{v.itemid,v.num})
end
table.sort(itemList,function(a,b)
local colorA=itemsConfig.getItemColor(a[1])or 0
local colorB=itemsConfig.getItemColor(b[1])or 0
return colorA>colorB
end)
local data={
serial_str=infoData.serial_str,
serial=infoData.serial,
teamIndex=waitResultData.teamIndex,
gameStamp=waitResultData.timeStamp,
timeStamp=timeHelper.getServerShortTime(),
result=result,
name=self:getNameStr(infoData.id,infoData.nameIdx),
report=reports,
newFlag=true,
items=itemList,
}
table.insert(_fightRecordList,1,data)
if#_fightRecordList>100 then
table.remove(_fightRecordList)
end

self:saveFightReportList()
return true
end
return false
end


function systemZongMenModel:addFinishWarReport(serial,result)
local infoData=self:getInfoData(serial)
if infoData then
local nowTime=timeHelper.getServerShortTime()
local data={
serial_str=infoData.serial_str,
serial=infoData.serial,
teamIndex=-1,
gameStamp=infoData.end_time>0 and infoData.end_time or nowTime,
timeStamp=nowTime,
result=result,
name=self:getNameStr(infoData.id,infoData.nameIdx),
report=nil,
newFlag=true,
items=nil,
}
table.insert(_fightRecordList,1,data)
if#_fightRecordList>100 then
table.remove(_fightRecordList)
end
self:saveFightReportList()
return true
end
return false
end


function systemZongMenModel:clearValidReportNewFlag()
local nowTime=timeHelper.getServerShortTime()
local dirty=false
for i,v in ipairs(_fightRecordList)do
if v.newFlag then
if self:checkWaitNotifyStamp(v.serial,nowTime)then
v.newFlag=false
dirty=true
end
end
end
if dirty then
self:saveFightReportList()
end
end


function systemZongMenModel:clearValidFightReport()
local nowTime=timeHelper.getServerShortTime()
local removes={}
for i,v in ipairs(_fightRecordList)do
if self:checkWaitNotifyStamp(v.serial,nowTime)then
table.insert(removes,i)
end
end
if#removes then
for i=#removes,1,-1 do
table.remove(_fightRecordList,removes[i])
end
self:saveFightReportList()
end
end


function systemZongMenModel:getValidFightReport()
local nowTime=timeHelper.getServerShortTime()
local list={}
for i,v in ipairs(_fightRecordList)do
if self:checkWaitNotifyStamp(v.serial,nowTime)then
table.insert(list,v)
end
end
return list
end


function systemZongMenModel:checkValidNewFightReport()
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(_fightRecordList)do
if v.newFlag and self:checkWaitNotifyStamp(v.serial,nowTime)then
return true
end
end
return false
end


function systemZongMenModel:getWaitNotifyResult(serial)
local key=tostring(serial)
return self:getWaitNotifyResultImp(key)
end

function systemZongMenModel:getWaitNotifyResultImp(serial_str)
return _waitNotifyResult[serial_str]
end


function systemZongMenModel:checkWaitNotifyResult(serial)
local data=self:getWaitNotifyResult(serial)
return data~=nil
end


function systemZongMenModel:checkWaitNotifyStamp(serial,timeStamp)
local data=self:getWaitNotifyResult(serial)
if data then
return timeStamp>(data.timeStamp+cfgHelper.get2(cfg_syssectbaseconfig_get,1,"reportDuration"))
end
return true
end


function systemZongMenModel:setWaitNotifyResult(serial,teamIndex,result,reports,discipleguid,rewards)
local key=tostring(serial)
_waitNotifyResult[key]={
key=key,
serial=serial,
teamIndex=teamIndex,
timeStamp=timeHelper.getServerShortTime(),
result=result,
reports=reports,
discipleguid=discipleguid,
rewards=rewards,
}
end


function systemZongMenModel:removeWaitNotifyResult(serial)
local key=tostring(serial)
return self:removeWaitNotifyResultImp(key)
end

function systemZongMenModel:removeWaitNotifyResultImp(serial_str)
local oldVal=_waitNotifyResult[serial_str]
_waitNotifyResult[serial_str]=nil
return oldVal
end


function systemZongMenModel:getAllWaitNotifyResult()
return _waitNotifyResult
end


function systemZongMenModel:haveWaitNotifyResult()
return next(_waitNotifyResult)~=nil
end

function systemZongMenModel:clearWaitNotifyResult()
table.clear(_waitNotifyResult)
end


function systemZongMenModel:findDefenseWaitNotifyResult()
for i,v in pairs(_waitNotifyResult)do
if v.teamIndex==0 then
return v
end
end
end



function systemZongMenModel:setAttackInfo(serial,teamLen,teamList,endTime)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local nowTime=timeHelper.getServerShortTime()
endTime=endTime or _getFightFlagEndTimer[systemZongMenFightFlagType.eAttacking](nowTime)
local showStamp=endTime-cfgHelper.get2(cfg_syssectbaseconfig_get,1,"showLXDuration")
_attackInfos[infoData.serial_str]={
serial_str=infoData.serial_str,
serial=serial,
teamLen=teamLen,
teamList=teamList or{},
showStamp=showStamp,
passShow=nowTime>=showStamp,
}
end
end


function systemZongMenModel:getAttackInfo(serial)
return _attackInfos[tostring(serial)]
end


function systemZongMenModel:clearAttackInfo()
table.clear(_attackInfos)
end


function systemZongMenModel:checkAttackInfo(serial)
local info=self:getAttackInfo(serial)
return info~=nil
end


function systemZongMenModel:getAllAttackInfo()
return _attackInfos
end

function systemZongMenModel:deleteAttackInfo(serial)
_attackInfos[tostring(serial)]=nil
end

function systemZongMenModel:getAnyAttackInfo()
local serial_str=next(_attackInfos)
return _attackInfos[serial_str]
end

function systemZongMenModel:existAnyAttackInfo()
return next(_attackInfos)~=nil
end

function systemZongMenModel:checkAttackWaitShow()
for serial_str,info in pairs(_attackInfos)do
if not info.passShow then
return true
end
end
return false
end

function systemZongMenModel:printFightFlagInfo(serial)
local infoData=self:getInfoData(serial)

end
