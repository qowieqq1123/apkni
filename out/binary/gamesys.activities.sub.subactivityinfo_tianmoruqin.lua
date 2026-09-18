

























































































































local subActivityInfo_tianmoruqin={name='subActivityInfo_tianmoruqin'}

TianMoRuQinEventType={
eUnlockMonsterType=1,
eAddExtraMonster=2,
ePlayLitteGame=3,
eDirectAward=4,
}

TianMoRuQinQingBaoType={
eWorld=0,
eXianMeng=1,
eSelf=2,
}

TianMoRuQinEventFlagType={
NotOpen=0,
Doing=1,
Completed=2,
Rewarded=3,
}

TianMoRuQinEventFlagReddot={
[TianMoRuQinEventFlagType.NotOpen]=true,
[TianMoRuQinEventFlagType.Doing]=false,
[TianMoRuQinEventFlagType.Completed]=true,
[TianMoRuQinEventFlagType.Rewarded]=false,
}

TianMoRuQinMonsterCount=3

local _QBRefreshCD=10
local _timeOut={}

























function subActivityInfo_tianmoruqin:onInit()

end

function subActivityInfo_tianmoruqin:onStart()

self.worldPosGuids0={}
local library=self:getSubActConfig("mbWorldPos")
local temp={}
for i,v in ipairs(library)do
table.insert(temp,i)
end
for i=1,TianMoRuQinMonsterCount do
local r=math.random(1,#temp)
local index=table.remove(temp,r)
self.worldPosGuids0[i]=index
end







self.fightExMonster={}
self.qbRefreshLimit=nil
end

function subActivityInfo_tianmoruqin:onDelete()
if worldController:isInWorld()then
local world=worldModel.world
for i=1,TianMoRuQinMonsterCount do
local posIdx=self.worldPosGuids0[i]
local posInfo=self:getSubActConfig("mbWorldPos",posIdx)
if posInfo[1]==world then
self:hideWorldBei(i)
end
end

for eventIndex,exMonsters in pairs(self.exMonsters)do
self:hideWorldEventMonsters(eventIndex)
end
end

UIManager:invokeUIMethod("UISubAct_TianMoRuQin_MonsterDialog","onActivityEnd",self.act_id,self.sub_act_type,self.sub_act_id)
UIManager:invokeUIMethod("UISubAct_TianMoRuQin_RankDialog","onActivityEnd",self.act_id,self.sub_act_type,self.sub_act_id)
end

function subActivityInfo_tianmoruqin:onUpdate()
if not self:hasData()then return end
local nowTime=timeHelper.getServerShortTime()
local config=self:getSubActConfig()


table.clear(_timeOut)
for aimIdx,aimCfg in pairs(config.aim)do
local flag=self:getEventData(aimIdx)
if flag==nil then
local targetTime=self.start_time+aimCfg[1]
if nowTime>=targetTime then
table.insert(_timeOut,aimIdx)
end
end
end
if#_timeOut>0 then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
end


table.clear(_timeOut)
for monsterIndex,monsterInfo in pairs(self.data.monsters)do
if monsterInfo.since>0 and not monsterInfo.leaveRefresh then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterInfo.monster)
local deadLine=self:getMonsterDeadTimeEx(monsterInfo)
if nowTime>deadLine then
monsterInfo.leaveRefresh=true
table.insert(_timeOut,monsterIndex)
end
end
end
for index,monsterIndex in ipairs(_timeOut)do


self:refreshWorldBeiMonster(monsterIndex)
end
if#_timeOut>0 then

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
end


table.clear(_timeOut)
for eventIndex,exMonsterInfo in pairs(self.exMonsters)do
local duration=config.aim[eventIndex][4]
if duration then
local deadLine=exMonsterInfo.sec+duration
if nowTime>deadLine then
table.insert(_timeOut,eventIndex)
end
end
end

for index,eventIndex in ipairs(_timeOut)do


self:hideWorldEventMonsters(eventIndex)

self:cleanExMonsterData(eventIndex,true)
end


table.clear(_timeOut)
if self.qbWaitCD then
for guidStr,leaveTime in pairs(self.qbWaitCD)do
if nowTime>leaveTime then
table.insert(_timeOut,guidStr)
end
end
end
if#_timeOut>0 then
local reddot=false
for index,guidStr in ipairs(_timeOut)do

local temp=self:deleteRankData(guidStr)
reddot=reddot or temp
end
UIManager:invokeUIMethod("UISubAct_TianMoRuQin_QingBaoWin","on_249_135",self.act_id,self.sub_act_type,self.sub_act_id)
if reddot then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end
end
end

function subActivityInfo_tianmoruqin:checkReddot()
return self:checkMainReddot()or self:checkQingBaoReddot()or self:checkTuJianReddot()
end

function subActivityInfo_tianmoruqin:initData(monsterList,aimList,maxBloodList,serverKill,moneySec,bookFlag,level,posList)
local monsters={}
local events={}
local exMonsters={}
local exMonsterLookup={}
local maxBloods={}
local monsterLookup={}
local bookFlags={}
local posLookup={}
local config=self:getSubActConfig()

if maxBloodList then
for i,v in ipairs(maxBloodList)do
maxBloods[v.param_1]=v.param_2
end
end
self.maxBloods=maxBloods

if monsterList then
for i,v in ipairs(monsterList)do
local monsterData={
index=v.mbidx,
guid=v.mongroupguid,
monster=v.mongroupid,
damage=v.totaldamage,
since=v.sec,
shareFlag=v.flag,
fighted=v.times,
}
monsters[v.mbidx]=monsterData
monsterLookup[tostring(v.mongroupguid)]=v.mbidx
end
end
if posList then
for i,v in ipairs(posList)do
posLookup[v.param_1]=v.param_2
end
end
local oEvents=self.data and self.data.events or{}
self.data={
monsters=monsters,
monsterLookup=monsterLookup,
events=events,
serverKill=serverKill,
moneySec=moneySec,
level=level,
posRefresh=posLookup,
}

for mbidx,monsterData in pairs(self.data.monsters)do
self:addRankData(monsterData,TianMoRuQinQingBaoType.eSelf)
end

self.exMonsters={}
self.exMonsterLookup={}
if aimList then
for i,v in ipairs(aimList)do
self:updateEvent(v,oEvents[v.aimidx])
end
end

for i,v in ipairs(config.book)do
local temp=bit.rshift(bookFlag,2*(i-1))
local flag=bit.band(temp,3)
bookFlags[i]=flag
end
self.bookFlags=bookFlags

self.inited=true
end

function subActivityInfo_tianmoruqin:updateEvent(eventInfo,oldFlag)
local eventIndex=eventInfo.aimidx
local flag=TianMoRuQinEventFlagType.Rewarded
if eventInfo.aimtype==TianMoRuQinEventType.eAddExtraMonster then
local list={}
if eventInfo.len>0 then
local config=self:getSubActConfig()
local worldPosGuids={}
if config.monsterWorldPos[eventIndex]then
for j,w in ipairs(config.monsterWorldPos[eventIndex])do
table.insert(worldPosGuids,j)
end
end
for i,v in ipairs(eventInfo.list)do
if#worldPosGuids<=0 then
loggerUtil.logErrFMT("天魔入侵 目标事件怪物位置不足：{0}，{1}, {2}",self.act_id,self.sub_act_id,eventIndex)
end
local r=math.random(1,#worldPosGuids)
local posIdx=table.remove(worldPosGuids,r)
local guid=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getAutoIncrementGuid")
table.insert(list,{id=v,sec=eventInfo.sec,posIdx=posIdx or 1,guid=guid,event=eventIndex})
self.exMonsterLookup[guid]=eventIndex
end
flag=oldFlag~=TianMoRuQinEventFlagType.Doing and TianMoRuQinEventFlagType.NotOpen or TianMoRuQinEventFlagType.Doing
else
local aimParams=self:getSubActConfig("aim",eventIndex,3)
if aimParams[3]and eventInfo.recv==0 then
flag=TianMoRuQinEventFlagType.Completed
end
end
self.exMonsters[eventIndex]={list=list,sec=eventInfo.sec}
end
self.data.events[eventIndex]=flag
end

function subActivityInfo_tianmoruqin:checkEventReddot(eventIndex)
local flag=self.data.events[eventIndex]
return flag==nil or TianMoRuQinEventFlagReddot[flag]
end

function subActivityInfo_tianmoruqin:updateMonster(monsterInfo)
local data=self.data
local old=data.monsters[monsterInfo.mbidx]
local change=true
if old then
change=old.guid~=monsterInfo.mongroupguid or old.since~=monsterInfo.sec
if change then
local oRank=self:getRankData(old.guid)
if oRank then
self:deleteRankData(tostring(old.guid))
end
self.qbRefreshLimit=nil
end
end
local monsterData={
index=monsterInfo.mbidx,
guid=monsterInfo.mongroupguid,
monster=monsterInfo.mongroupid,
damage=monsterInfo.totaldamage,
since=monsterInfo.sec,
shareFlag=monsterInfo.flag,
fighted=monsterInfo.times,
}
data.monsters[monsterInfo.mbidx]=monsterData
data.monsterLookup[tostring(monsterInfo.mongroupguid)]=monsterInfo.mbidx

self:addRankData(monsterData,TianMoRuQinQingBaoType.eSelf)
return change
end

function subActivityInfo_tianmoruqin:updateMonsterDamage(monsterGuid,monsterId,totalDamage)
local monsterIdx=self:findMonsterIndex(monsterGuid)
if monsterIdx then
local monsterData=self:getMonsterData(monsterIdx)
monsterData.monster=monsterId
monsterData.damage=totalDamage
end
return monsterIdx
end

function subActivityInfo_tianmoruqin:shareMonster(monsterGuid,source)
local data=self.data
local index=data.monsterLookup[tostring(monsterGuid)]
local monster=data.monsters[index]

for i=TianMoRuQinQingBaoType.eWorld,TianMoRuQinQingBaoType.eXianMeng do
if not mathHelper.getBitValue(monster.shareFlag,i)and mathHelper.getBitValue(source,i)then
self:addRankData(monster,i)
end
end

monster.shareFlag=source
end

function subActivityInfo_tianmoruqin:setServerKill(num)
self.data.serverKill=num
end

function subActivityInfo_tianmoruqin:setMoneySec(sec)
self.data.moneySec=sec
end

function subActivityInfo_tianmoruqin:getEventData(index)
return self.data.events[index]
end

function subActivityInfo_tianmoruqin:setEventData(index,flag)
self.data.events[index]=flag
end

function subActivityInfo_tianmoruqin:getMonsterData(index)
return self.data.monsters[index]
end

function subActivityInfo_tianmoruqin:findMonsterIndex(monsterGuid)
return self.data.monsterLookup[tostring(monsterGuid)]
end

function subActivityInfo_tianmoruqin:getActLevel()
return self.data.level
end

function subActivityInfo_tianmoruqin:getPosRefreshTime(index)
return self.data.posRefresh[index]
end

function subActivityInfo_tianmoruqin:getPosRefresh()
return self.data.posRefresh
end

function subActivityInfo_tianmoruqin:resetPosRefreshTime(index)
local monsterData=self:getMonsterData(index)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
self.data.posRefresh[index]=timeHelper.getServerShortTime()+self:getSubActConfig("monster",monType,3)
end

function subActivityInfo_tianmoruqin:clearPosRefreshTime(index)
self.data.posRefresh[index]=nil
end

function subActivityInfo_tianmoruqin:isMonsterLive(index)
local data=self:getMonsterData(index)
return self:isMonsterLiveEx(data)
end

function subActivityInfo_tianmoruqin:isMonsterLiveEx(data)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local maxBlood=tonumber(tostring(self:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
return damageBlood<maxBlood
end

function subActivityInfo_tianmoruqin:getMonsterDeadTime(index)
local data=self:getMonsterData(index)
return self:getMonsterDeadTimeEx(data)
end

function subActivityInfo_tianmoruqin:getMonsterDeadTimeEx(data)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local isLive=self:isMonsterLiveEx(data)
local deadLine=data.since+self:getSubActConfig("monster",monType,3)
if not isLive then
local refreshTime=self:getPosRefreshTime(data.index)
return refreshTime or deadLine

end
return deadLine
end

function subActivityInfo_tianmoruqin:getExMonsterData(eventIndex)
return self.exMonsters[eventIndex]
end

function subActivityInfo_tianmoruqin:getExMonster(monsterGuid)
local eventIndex=self.exMonsterLookup[monsterGuid]
local exMonsterData=self:getExMonsterData(eventIndex)
for i,v in ipairs(exMonsterData.list)do
if v.guid==monsterGuid then
return v,i,eventIndex
end
end
end

function subActivityInfo_tianmoruqin:getExMonsterEx(eventIndex,monsterIndex)
local exMonsters=self:getExMonsterData(eventIndex)
if exMonsters then
return exMonsters.list[monsterIndex]
end
end

function subActivityInfo_tianmoruqin:removeExMonsterEx(eventIndex,monsterIndex)
local exMonsters=self:getExMonsterData(eventIndex)
if exMonsters and#exMonsters.list>=monsterIndex then
local exMonster=table.remove(exMonsters.list,monsterIndex)
self.exMonsterLookup[exMonster.guid]=nil
if#exMonsters.list<=0 then
self.exMonsters[eventIndex]=nil
local flag=self.data.events[eventIndex]
if flag==nil or flag==TianMoRuQinEventFlagType.Doing then
local aimParams=self:getSubActConfig("aim",eventIndex,3)
self.data.events[eventIndex]=aimParams[3]and TianMoRuQinEventFlagType.Completed or TianMoRuQinEventFlagType.Rewarded
end
end
return exMonster.guid
end
end

function subActivityInfo_tianmoruqin:cleanExMonsterData(eventIndex,finish)
local exMonsters=self:getExMonsterData(eventIndex)
if exMonsters then
for monsterIdx,exMonster in ipairs(exMonsters.list)do
self.exMonsterLookup[exMonster.guid]=nil
end
self.exMonsters[eventIndex]=nil
if finish then
local flag=self.data.events[eventIndex]
if flag==nil or flag==TianMoRuQinEventFlagType.Doing then
local aimParams=self:getSubActConfig("aim",eventIndex,3)
self.data.events[eventIndex]=aimParams[3]and TianMoRuQinEventFlagType.Completed or TianMoRuQinEventFlagType.Rewarded
end
end
end
end

function subActivityInfo_tianmoruqin:getMaxBloods(monsterType)
return self.maxBloods[monsterType]
end

function subActivityInfo_tianmoruqin:initRankData(qbList)
local config=self:getSubActConfig()
local nowTime=timeHelper.getServerShortTime()
local newQB=false
local qbExist={}
qbList=qbList or{}
self.qbData={}
self.qbChannels={}
self.qbWaitCD={}
self.qbCache={}
self.qbCacheTime={}
for i,v in pairs(TianMoRuQinQingBaoType)do
self.qbChannels[v]={}
self.qbCache[v]={}
self.qbCacheTime[v]={}
end
for i,v in ipairs(qbList)do
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,v.mongroupid)
local monType=monsterCfg.monType
local monsterInfo=config.monster[monType]
local leaveTime=v.sec>0 and(v.sec+monsterInfo[3])or 0
if leaveTime<=0 or leaveTime>nowTime then
local maxBlood=self:getMaxBloods(monType)
local damageNum=tonumber(tostring(v.totaldamage))
local maxBloodNum=tonumber(tostring(maxBlood))
if damageNum<maxBloodNum or v.times>0 then
local guidStr=tostring(v.mongroupguid)
local sort=0
if damageNum>=maxBloodNum then
sort=1
elseif v.num>=monsterInfo[2]then
sort=-1
end
local data={
key=guidStr,
guid=v.mongroupguid,
monster=v.mongroupid,
people=v.num,
peopleMax=monsterInfo[2],
hp=maxBloodNum-damageNum,
maxHp=maxBloodNum,
leaveTime=leaveTime,
flag=v.times>0,
sort=sort,
fighted=v.times,
monType=monType,
}
self.qbData[guidStr]=data

local selfIdx=self:findMonsterIndex(v.mongroupguid)
local channels=v.flag







if v.times>0 or selfIdx~=nil then
if damageNum>=maxBloodNum then
self.qbWaitCD[guidStr]=leaveTime
channels=mathHelper.setbit(0,TianMoRuQinQingBaoType.eSelf)
else
channels=mathHelper.setbit(channels,TianMoRuQinQingBaoType.eSelf)
end
end

for i,v in pairs(TianMoRuQinQingBaoType)do
if mathHelper.getBitValue(channels,v)then
self.qbChannels[v][guidStr]=leaveTime
end
end

qbExist[guidStr]=true
if not mathHelper.getBitValue(channels,TianMoRuQinQingBaoType.eSelf)then
newQB=newQB or self.qbExist==nil or self.qbExist[guidStr]==nil
end
end
end
end
self.qbExist=qbExist
return newQB
end

function subActivityInfo_tianmoruqin:getRankData(guid)
local guidStr=tostring(guid)
return self:getRankDataImp(guidStr)
end

function subActivityInfo_tianmoruqin:getRankDataImp(guidStr)
if self.qbData then
return self.qbData[guidStr]
end
end

function subActivityInfo_tianmoruqin:getRankCache(tab,filter)
if not self.qbCache then return{}end
local cache=self.qbCache[tab][filter]
local cacheTime=self.qbCacheTime[tab][filter]
local nowTime=timeHelper.getServerShortTime()

if not cache or not cacheTime or cacheTime<=nowTime then
cache={}
cacheTime=nil
local reddot=false
for guidStr,leaveTime in pairs(self.qbChannels[tab])do
if leaveTime<=0 or nowTime<leaveTime then
local data=self:getRankDataImp(guidStr)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
if not mathHelper.getBitValue(filter,monType)then
table.insert(cache,guidStr)
cacheTime=cacheTime and math.min(cacheTime,leaveTime)or leaveTime
end
else
local check=self:deleteRankData(guidStr)
reddot=reddot or check
end
end
table.sort(cache,function(a,b)
local aData=self:getRankDataImp(a)
local bData=self:getRankDataImp(b)
if aData.sort~=bData.sort then
return aData.sort>bData.sort
else
local aHP=math.floor(aData.hp/aData.maxHp*100)
local bHP=math.floor(bData.hp/bData.maxHp*100)
if aHP~=bHP then
return aHP<bHP
else
return aData.monType>bData.monType
end
end
end)
self.qbCache[tab][filter]=cache
self.qbCacheTime[tab][filter]=cacheTime

if reddot then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end

return cache,cacheTime
end

return cache,cacheTime
end

function subActivityInfo_tianmoruqin:deleteRankData(guidStr)
if self.qbData then
for i,v in pairs(TianMoRuQinQingBaoType)do
if self.qbChannels[v][guidStr]then
for filter,cacheList in pairs(self.qbCache[v])do
table.removeValue(cacheList,guidStr)
end
self.qbChannels[v][guidStr]=nil
end
end

local reddot=self.qbWaitCD[guidStr]~=nil
self.qbWaitCD[guidStr]=nil
self.qbData[guidStr]=nil
self.qbExist[guidStr]=nil
return reddot
end
return false
end

function subActivityInfo_tianmoruqin:updateRankDamage(guid,damage)
local data=self:getRankData(guid)
if data then
local damageNum=tonumber(tostring(damage))
if not data.flag then
data.people=data.people+1
end
data.hp=data.maxHp-damageNum
data.flag=true
data.fighted=data.fighted+1
local sort=0
if data.maxHp<=damageNum then
sort=1
elseif data.people>=data.peopleMax then
sort=-1
end

local guidStr=tostring(guid)
self.qbChannels[TianMoRuQinQingBaoType.eSelf][guidStr]=data.leaveTime





























for i,v in pairs(TianMoRuQinQingBaoType)do
if self.qbChannels[v][guidStr]then
table.clear(self.qbCache[v])
table.clear(self.qbCacheTime[v])
end
end
if data.hp<=0 then
self.qbChannels[TianMoRuQinQingBaoType.eWorld][guidStr]=nil
self.qbChannels[TianMoRuQinQingBaoType.eXianMeng][guidStr]=nil
end

data.sort=sort
return true
end
return false
end

function subActivityInfo_tianmoruqin:resetRankdData()
self.qbData={}
self.qbChannels={}
self.qbWaitCD={}
self.qbExist={}
self.qbCache={}
self.qbCacheTime={}
for i,v in pairs(TianMoRuQinQingBaoType)do
self.qbChannels[v]={}
self.qbCache[v]={}
self.qbCacheTime[v]={}
end
end

function subActivityInfo_tianmoruqin:addRankData(monsterData,tab)
if monsterData.since<=0 then return false end

if not self.qbData then
self:resetRankdData()
end

local config=self:getSubActConfig()
local guidStr=tostring(monsterData.guid)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
local monsterInfo=config.monster[monType]
local maxBlood=self:getMaxBloods(monType)
local maxBloodNum=tonumber(tostring(maxBlood))
local damageNum=tonumber(tostring(monsterData.damage))
local leaveTime=self:getMonsterDeadTimeEx(monsterData)
local nowTime=timeHelper.getServerShortTime()
if(damageNum<maxBloodNum or monsterData.fighted>0)and(leaveTime<=0 or leaveTime>nowTime)then
local sort=0
if damageNum>=maxBloodNum then
sort=1
elseif 1>=monsterInfo[2]then
sort=-1
end
local data={
key=guidStr,
guid=monsterData.guid,
monster=monsterData.monster,
people=1,
peopleMax=monsterInfo[2],
hp=maxBloodNum-damageNum,
maxHp=maxBloodNum,
leaveTime=leaveTime,
flag=monsterData.fighted>0,
sort=sort,
fighted=monsterData.fighted,
monType=monType,
}
self.qbData[guidStr]=data
self.qbChannels[tab][guidStr]=leaveTime
table.clear(self.qbCache[tab])
table.clear(self.qbCacheTime[tab])
if maxBloodNum<=damageNum and monsterData.fighted>0 then
self.qbWaitCD[guidStr]=leaveTime
end
return true
end
return false
end

function subActivityInfo_tianmoruqin:checkQingBaoReddot()
if self.qbWaitCD then
return next(self.qbWaitCD)~=nil
end
return false
end

function subActivityInfo_tianmoruqin:checkQingBaoXin()
return self.qbNew or false
end

function subActivityInfo_tianmoruqin:markQingBaoXin()
self.qbNew=true
end

function subActivityInfo_tianmoruqin:clearQingBaoXin()
self.qbNew=false
end

function subActivityInfo_tianmoruqin:checkQingBaoChannelReddot(tab)
if self.qbWaitCD then
for guidStr,leaveTime in pairs(self.qbChannels[tab])do
if self.qbWaitCD[guidStr]then
return true
end
end
end
return false
end

function subActivityInfo_tianmoruqin:setQingBaoRefreshLimit()
self.qbRefreshLimit=timeHelper.getServerShortTime()+_QBRefreshCD
end

function subActivityInfo_tianmoruqin:getQingBaoRefreshLeast()
if self.qbRefreshLimit then
return self.qbRefreshLimit-timeHelper.getServerShortTime()
end
return-1
end

function subActivityInfo_tianmoruqin:checkShareChannel(monType,oFlag)
local flag=0

local setting=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getShareSettings")
if setting.autoShare then
local channels=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getShareChannels")

if mathHelper.getBitValue(setting.types or 0,monType)then
for index,channel in ipairs(channels)do
if mathHelper.getBitValue(setting.channels or 0,channel)then
local channelCfg=cfgHelper.get1(cfg_chatchannnelconfig_get,channel)
if channelCfg.sysid then

if systemModel.isOpen(channelCfg.sysid)then
if channelCfg.sysid==SYSTEM_DEFINE.eXianMeng then

if xianmengModel:hasXM()then
if not mathHelper.getBitValue(oFlag,index-1)then
flag=mathHelper.setbit(flag,index-1)
end
end
else
if not mathHelper.getBitValue(oFlag,index-1)then
flag=mathHelper.setbit(flag,index-1)
end
end
end
else

if not mathHelper.getBitValue(oFlag,index-1)then
flag=mathHelper.setbit(flag,index-1)
end
end
end
end
end
end
return flag
end

function subActivityInfo_tianmoruqin:onEnterWorld()
if not self:hasData()then return end

local config=self:getSubActConfig()
local world=worldModel.world
local nowTime=timeHelper.getServerShortTime()

for index=1,TianMoRuQinMonsterCount do
local posIdx=self.worldPosGuids0[index]
local posInfo=config.mbWorldPos[posIdx]

if posInfo[1]==world then
local position=worldPositionConfig:getPosition(posInfo[1],{posInfo[2],posInfo[3]})

local unitKey0=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,0})
local luaData0={eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,0}
local modelSetting0=worldModel:getModelSettings(config.mbWorldModel,eWorldUnitTpye.TIANMORUQIN_BEI)
local hudSettings0=worldModel:getHUDSetting(config.mbWorldHUD,eWorldUnitTpye.TIANMORUQIN_BEI)
worldController:pushUnit(unitKey0,position,luaData0,modelSetting0,hudSettings0,nil,true)

local monsterData=self:getMonsterData(index)

local unitKey1=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,1})
local luaData1={eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,1}
local modelSetting1=nil
if monsterData and monsterData.monster>0 then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
local leastTime=nil
if monsterData.since>0 then
local deadLine=self:getMonsterDeadTimeEx(monsterData)
leastTime=deadLine-nowTime
end
if not leastTime or leastTime>0 then
local maxBlood=tonumber(tostring(self:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(monsterData.damage))
local isLive=damageBlood<maxBlood
if isLive then
modelSetting1=worldModel:getModelSettings(config.monsterWorldModel[monsterData.monster],eWorldUnitTpye.TIANMORUQIN_BEI)
end
end
end
worldController:pushUnit(unitKey1,position,luaData1,modelSetting1,nil,nil,true)
end
end

for eventIndex,exMonsters in pairs(self.exMonsters)do
for index,exMonster in ipairs(exMonsters.list)do
local monsterId=exMonster.id
local posIdx=exMonster.posIdx
local guid=exMonster.guid
local posInfo=config.monsterWorldPos[exMonster.event][posIdx]

if posInfo[1]==world then
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_MONSTER,self.act_id,self.sub_act_id,guid})
local position=worldPositionConfig:getPosition(world,{posInfo[2],posInfo[3]})
local luaData={eWorldUnitTpye.TIANMORUQIN_MONSTER,self.act_id,self.sub_act_id,guid}
local modelSetting=worldModel:getModelSettings(config.monsterWorldModel[monsterId],eWorldUnitTpye.TIANMORUQIN_MONSTER)
local hudSettings=worldModel:getHUDSetting(config.monsterWorldHUD,eWorldUnitTpye.TIANMORUQIN_MONSTER)

worldController:pushUnit(unitKey,position,luaData,modelSetting,hudSettings,nil,true)
end
end
end
end

function subActivityInfo_tianmoruqin:hideWorldBei(index)
local unitKey0=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,0})
worldController:popUnit(unitKey0)
local unitKey1=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,1})
worldController:popUnit(unitKey1)
end

function subActivityInfo_tianmoruqin:refreshWorldBeiMonster(index)
if not worldController:isInWorld()then return end
local unitKey0=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,0})
local unitKey1=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,1})
if not worldController:haveUnit(unitKey1)then return end

local monsterData=self:getMonsterData(index)
local modelSetting1=nil
if monsterData.monster>0 then
local config=self:getSubActConfig()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
local leastTime=nil
if monsterData.since>0 then
local nowTime=timeHelper.getServerShortTime()
local deadLine=self:getMonsterDeadTimeEx(monsterData)
leastTime=deadLine-nowTime
end
if leastTime and leastTime>0 then
local maxBlood=tonumber(tostring(self:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(monsterData.damage))
local isLive=damageBlood<maxBlood
if isLive then
modelSetting1=worldModel:getModelSettings(config.monsterWorldModel[monsterData.monster],eWorldUnitTpye.TIANMORUQIN_BEI)
end
end
end
worldController:changeUnitModel(unitKey1,modelSetting1)
worldHUDModel:UpdateHUDByKey(unitKey0)
end

function subActivityInfo_tianmoruqin:refreshWorldBeiHUD(index)
if not worldController:isInWorld()then return end
local unitKey0=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_BEI,self.act_id,self.sub_act_id,index,0})
worldHUDModel:UpdateHUDByKey(unitKey0)
end

function subActivityInfo_tianmoruqin:hideWorldEventMonster(guid)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_MONSTER,self.act_id,self.sub_act_id,guid})
worldController:popUnit(unitKey)
end

function subActivityInfo_tianmoruqin:hideWorldEventMonsters(eventIndex)
local exMonsters=self:getExMonsterData(eventIndex)
if exMonsters then
for i,v in ipairs(exMonsters.list)do
self:hideWorldEventMonster(v.guid)
end
end
end

function subActivityInfo_tianmoruqin:jumpEventMonster(eventIndex,index)
local exMonster=self:getExMonsterEx(eventIndex,index or 1)
if exMonster then
local posIdx=exMonster.posIdx
local config=self:getSubActConfig()
local posInfo=config.monsterWorldPos[eventIndex][posIdx]
local world=posInfo[1]
local position=worldPositionConfig:getPosition(world,{posInfo[2],posInfo[3]})
if worldModel:isSameWorld(world)then
worldController:lookAtPosition(position)
else
local args={lookAt=position}
worldController:enterWorld(world,args)
end
end
end

function subActivityInfo_tianmoruqin:pushMonsterJump(monsterGuid,jumpTab,jumpParam)
if not self.monsterJumpArgs then
self.monsterJumpArgs={}
end
local key=tostring(monsterGuid)

self.monsterJumpArgs[key]={monsterGuid,jumpTab,jumpParam}

end

function subActivityInfo_tianmoruqin:popMonsterJump(monsterGuid)
if self.monsterJumpArgs then
local key=tostring(monsterGuid)
local args=self.monsterJumpArgs[key]
self.monsterJumpArgs[key]=nil
return args
end
end

function subActivityInfo_tianmoruqin:pushFightMonsterJump(monsterGuid,jumpTab,jumpParam)
if not self.fightMonsterJumpArgs then
self.fightMonsterJumpArgs={}
end
local key=tostring(monsterGuid)
self.fightMonsterJumpArgs[key]={monsterGuid,jumpTab,jumpParam}

end

function subActivityInfo_tianmoruqin:popFightMonsterJump(monsterGuid)
if self.fightMonsterJumpArgs then
local key=tostring(monsterGuid)
local args=self.fightMonsterJumpArgs[key]
self.fightMonsterJumpArgs[key]=nil
return args
end
end

function subActivityInfo_tianmoruqin:checkMainReddot()
if self:hasData()then
local nowTime=timeHelper.getServerShortTime()
local config=self:getSubActConfig()
for aimIdx,aimCfg in ipairs(config.aim)do
local aimFlag=self:getEventData(aimIdx)
if aimFlag==nil and nowTime>=(self.start_time+aimCfg[1])then
return true
elseif aimFlag and TianMoRuQinEventFlagReddot[aimFlag]then
return true
end
end

for monsterIndex=1,TianMoRuQinMonsterCount do
local monsterData=self.data.monsters[monsterIndex]
if monsterData==nil then
return true
end
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
local maxBlood=self:getMaxBloods(monType)
local maxBloodNum=tonumber(tostring(maxBlood))
local damageNum=tonumber(tostring(monsterData.damage))
local leaveTime=self:getMonsterDeadTimeEx(monsterData)
if monsterData.since>0 and nowTime>leaveTime then
return true
elseif damageNum>=maxBloodNum and monsterData.fighted>0 and monsterData.since>0 and nowTime<=leaveTime then
return true
end
end


end
return false
end







function subActivityInfo_tianmoruqin:checkTuJianReddot()
if self:hasData()then
for i,v in ipairs(self.bookFlags)do
if v==1 then
return true
end
end
end
return false
end

function subActivityInfo_tianmoruqin:getBookFlag(monsterIdx)
return self.bookFlags[monsterIdx]
end

function subActivityInfo_tianmoruqin:setBookFlag(monsterIdx,bit)
local flag=self.bookFlags[monsterIdx]
flag=mathHelper.setbit(flag,bit)
self.bookFlags[monsterIdx]=flag
end

function subActivityInfo_tianmoruqin:getBookMonstersReddot(mosnters)
for i,v in ipairs(mosnters)do
local flag=self:getBookFlag(v)
if mathHelper.getBitValue(flag,0)and not mathHelper.getBitValue(flag,1)then
return true
end
end
return false
end

function subActivityInfo_tianmoruqin:updateBookKill(monsterId,damage)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local monType=monsterCfg.monType
local maxBlood=self:getMaxBloods(monType)
local maxBloodNum=tonumber(tostring(maxBlood))
local damageNum=tonumber(tostring(damage))
if damageNum<maxBloodNum then return end

local config=self:getSubActConfig("book")
for i,v in ipairs(config)do
if v[1]==monsterId then
local flag=self:getBookFlag(i)
if not mathHelper.getBitValue(flag,0)then
self:setBookFlag(i,0)
return i
end
break
end
end
end

function subActivityInfo_tianmoruqin:jumpAfterFight(monsterGuid,jumpType,jumpParam,isLive)
if isLive then

if jumpType>0 then
if activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)==jumpType then
jumpManager:jump(jumpParam)
else
local extraParams=jumpParam.args.extraParams

jumpManager:jump(jumpParam)
end

elseif jumpType<0 then
if not worldController:isInWorld()or not worldModel:isSameWorld(-jumpType)then
return
end
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterDetail",self.act_id,self.sub_act_id,monsterGuid,jumpType)

else
local tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
local jumpParam={
id=JUMP_TYPE.eActivity,
args={
subType=self.sub_act_type,
subid=self.sub_act_id,
extraParams={tab_idx=tab_idx,channel=TianMoRuQinQingBaoType.eSelf,guid=monsterGuid},
}
}
jumpManager:jump(jumpParam)
end
else

if jumpType>0 then
local extraParams=jumpParam.args.extraParams
if activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)==jumpType then
extraParams["index"]=nil
jumpManager:jump(jumpParam)
else

extraParams["guid"]=nil
jumpManager:jump(jumpParam)
end

elseif jumpType<0 then




else
local tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
local jumpParam={
id=JUMP_TYPE.eActivity,
args={
subType=self.sub_act_type,
subid=self.sub_act_id,
extraParams={tab_idx=tab_idx,channel=TianMoRuQinQingBaoType.eSelf},
}
}
jumpManager:jump(jumpParam)
end
end
end

function subActivityInfo_tianmoruqin:showMoneyBuyPanel(costItem)
local maxCnt=moneyBuyModel:getMax(costItem)
local nowCnt=moneyBuyModel:getCount(costItem)
local max=maxCnt-nowCnt
if max<=0 then
return UIManager.info("今日购买次数已用尽")
end
local moneyCfg=cfgHelper.get1(cfg_moneyconfig_get,costItem)
local costList={}
local configList=moneyCfg.buy[2]
local count=#configList
local sumLookup={}
for i=nowCnt+1,maxCnt do
local temp=configList[i>count and count or i]
for j,w in ipairs(temp)do
local itemdId=w[1]
local itemNum=w[2]
sumLookup[itemdId]=(sumLookup[itemdId]or 0)+itemNum
end
temp={}
for j,w in pairs(sumLookup)do
table.insert(temp,{j,w})
end
table.sort(temp,function(a,b)
return a[1]<b[1]
end)
costList[i-nowCnt]=temp
end

local refresh=function(value)
local costStr=nil
for i,v in ipairs(costList[value])do
local splite=costStr and"、"or""
local costId=v[1]
local costNum=v[2]
local costIconName=iconHelper.getIconName(costId)
local costIconStr=chatEmotHelper.getIconEmotMesg(costIconName,40)
local haveNum=itemsModel.getCount(costId)
local costColor=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
if haveNum>=costNum then
costColor=FONT_COLOR_VAL[FONT_COLOR.eGreenColor]
end
if pfwindowslController:checkIsGameVersion_yuenan()then
costStr=FMT.fmt('{0}{1}{2}  <color={4}>{3}</color>',costStr or"",splite,costIconStr,costNum,costColor)
else
costStr=FMT.fmt('{0}{1}{2}<color={4}>{3}</color>',costStr or"",splite,costIconStr,costNum,costColor)
end
end

local getId=costItem
local getNum=value*moneyCfg.buy[1]
local getName=itemsConfig.getItemName(getId)
local getColor=FONT_COLOR_VAL[itemsConfig.getItemColor(getId)]

local contentStr=FMT.fmt("是否花费{0}购买<color={3}>{1}*{2}</color>",costStr,getName,getNum,getColor)
return contentStr
end
local dayNum=moneyCfg.buy[3]
local saveNum=moneyCfg.buy[4]
local tipContent=FMT.fmt("祖师每天可买{0}次，上一天的剩余购买次数\n可储存到次日，储存上限最多为{1}次",dayNum,dayNum+saveNum)
local moneyTypes={}
for i,v in pairs(sumLookup)do
table.insert(moneyTypes,{i})
end
local show_data={
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,
max=max,
tips=FMT.fmt("（今日剩余次数：{0}）",max),
oktext='购买',
canceltext='取消',
tipContent=tipContent,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local _costList=costList[num]
if#_costList>1 then
loggerUtil.logErrFMT("无法处理多种消耗的货币购买")
return
end
if _costList then
local _cost=_costList[1]
local func=function()
socketManager:send_254_44(costItem,num)
end
moneySystem:useMoney(_cost[1],_cost[2],func,WARNING_TYPE.eWarning)
else
loggerUtil.logErrFMT("天魔入侵购买货币报错 数量:{0},{1},{2}",num,nowCnt,maxCnt)
end
end,
moneytypes=moneyTypes,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

return subActivityInfo_tianmoruqin
