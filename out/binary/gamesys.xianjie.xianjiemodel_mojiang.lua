









local _datas={}





local _reverse={}







local _sortList={}







local _records={}










local _ranks={}





local _finishFlag=nil
local _fightPlot=nil
local _deadPlot=nil

eMoJiangRecordType={
scmjrtDamage=1,
scmjrtRecover=2,
}

function xianjieModel:setMoJiangDatas(seasonType,stageIndex,dataList,isInit)
local oDatas=self:getMoJiangDatas(seasonType,stageIndex)
local keeps={}
if oDatas then
for build_id,data in pairs(oDatas)do
keeps[build_id]=false
end
end

if dataList then
for index,data in ipairs(dataList)do
local build_id=data.cbid
local config=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojiang",build_id)
local dead=data.killed==1
local rangeData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
local bestGuild=nil
if dead then
bestGuild={
guildId=data.guildid,
guildIcon=data.guildicon,
guildName=data.guildname,
}
end
local bestPlayer=nil
if dead then
bestPlayer={
actorId=data.actorid,
actorServer=data.serverid,
actorName=data.actorname,
iconInfo=data.iconInfo,
}
end
local entityData={
entitytype=xjServerEnityType.eClientBuild,
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
damage=mathHelper.int64_to_number(data.damage),
damageFlag=data.damageidx,
fightTimes=data.times,
dailyFlag=data.rewardtimes,
hp=data.hp,
killTime=data.killed==1 and data.killsec or 0,
bestGuild=bestGuild,
bestPlayer=bestPlayer,
fighted=data.challenge,
bufflistlen=data.bufflistlen,
buffList=data.buffList,
}
xianjieModel:setMoJiangData(seasonType,stageIndex,build_id,entityData,rangeData,isInit)
keeps[build_id]=true
end



























end

for build_id,check in pairs(keeps)do
if not check then
self:setMoJiangData(seasonType,stageIndex,build_id,nil,nil,isInit)
end
end
end

function xianjieModel:setMoJiangData(seasonType,stageIndex,build_id,entityData,rangeData,onlyData)
local temp1=_datas[seasonType]
if temp1==nil then
temp1={}
_datas[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end

local temp=temp2[build_id]

if entityData then

if temp then
temp.entity:refreshData(entityData)
temp.range:refreshData(rangeData)
if not onlyData then
temp.entity:refreshEntity()
temp.range:refreshEntity()
end

else
local d={}
d.entity=xianjieController:createXJClass(xjDataType.eMoJiang,entityData)
d.range=xianjieController:createXJClass(xjDataType.eMoJiangRange,rangeData)
temp2[build_id]=d

if not onlyData then
d.entity:createEntity(true)
d.range:createEntity(true)
end

if _reverse[build_id]==nil then
_reverse[build_id]={}
end
table.insert(_reverse[build_id],{seasonType,stageIndex})
end

else
if temp then
xianjieController:removeXJClass(temp.entity)
xianjieController:removeXJClass(temp.range)
temp.entity=nil
temp.range=nil
temp2[build_id]=nil

local find=nil
for i,v in ipairs(_reverse[build_id])do
if v[1]==seasonType and v[2]==stageIndex then
find=i
break
end
end
if find then
table.remove(_reverse[build_id],find)
end
end
end
end

function xianjieModel:getMoJiangData(seasonType,stageIndex,build_id)
local datas=self:getMoJiangDatas(seasonType,stageIndex)
return datas and datas[build_id]or nil
end

function xianjieModel:getMoJiangDatas(seasonType,stageIndex)
return _datas[seasonType]and _datas[seasonType][stageIndex]or nil
end

function xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local data=self:getMoJiangData(seasonType,stageIndex,build_id)
return data and data.entity or nil
end

function xianjieModel:getMoJiangRange(seasonType,stageIndex,build_id)
local data=self:getMoJiangData(seasonType,stageIndex,build_id)
return data and data.range or nil
end

function xianjieModel:clearMoJiangDatas(seasonType,stageIndex)
local datas=self:getMoJiangDatas(seasonType,stageIndex)
if datas then
for build_id,data in ipairs(datas)do
xianjieModel:setMoJiangData(seasonType,stageIndex,build_id,nil,nil,false)
end
end
end

function xianjieModel:getMoJiangSeasonStages(build_id)
return _reverse[build_id]or defaultT
end

function xianjieModel:clearData_mojiang()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
xianjieController:removeXJClass(data.entity)
xianjieController:removeXJClass(data.range)
end
end
end
table.clear(_datas)
table.clear(_reverse)
table.clear(_sortList)
table.clear(_ranks)
_finishFlag=nil
_fightPlot=nil
_deadPlot=nil
end

function xianjieModel:initData_mojiang()
_finishFlag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJiang,"finishFlag",{})
_fightPlot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJiang,"fightPlot",{})
_deadPlot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJiang,"deadPlot",{})
end

function xianjieModel:onEnterMap_mojiang()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
data.entity:createEntity(true)
data.range:createEntity(true)
end
end
end
end

function xianjieModel:onExitMap_mojiang()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
data.entity:removeEntity()
data.range:removeEntity()
end
end
end
end

function xianjieModel:getMoJiangSortList(seasonType,stageIndex)
local temp1=_sortList[seasonType]
if temp1==nil then
temp1={}
_sortList[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
local configs=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojiang")
for id,config in pairs(configs)do
table.insert(temp2,{id=id,open=config.open})
end
table.sort(temp2,function(a,b)
if a.open~=b.open then
return a.open<b.open
else
return a.id>b.id
end
end)
temp1[stageIndex]=temp2
end
return temp2
end

function xianjieModel:setMoJiangRank(seasonType,stageIndex,build_id,rankType,rankList,rankNum,rankScore)
local temp1=_ranks[seasonType]
if temp1==nil then
temp1={}
_ranks[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end
local temp3=temp2[build_id]
if temp3==nil then
temp3={}
temp2[build_id]=temp3
end
local dataList={}
if rankList then
for i,v in ipairs(rankList)do
dataList[v.rank]=v
end
end
temp3[rankType]={dataList,rankNum,rankScore}
end

function xianjieModel:getMoJiangRank(seasonType,stageIndex,build_id,rankType)
local temp1=_ranks[seasonType]
if temp1==nil then
temp1={}
_ranks[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end
local temp3=temp2[build_id]
if temp3==nil then
temp3={}
temp2[build_id]=temp3
end
return temp3[rankType]
end

function xianjieModel:clearMoJiangRanks(seasonType,stageIndex)
local temp1=_ranks[seasonType]
if temp1 and temp1[stageIndex]then
table.clear(temp1[stageIndex])
end
end

function xianjieModel:setMoJiangRecord(seasonType,stageIndex,build_id,recordList)
local temp1=_records[seasonType]
if temp1==nil then
temp1={}
_records[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end
temp2[build_id]=recordList
end

function xianjieModel:getMoJiangRecord(seasonType,stageIndex,build_id)
local temp1=_records[seasonType]
if temp1==nil then
temp1={}
_records[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end
return temp2[build_id]
end

function xianjieModel:clearMoJiangRecords(seasonType,stageIndex)
local temp1=_records[seasonType]
if temp1 and temp1[stageIndex]then
table.clear(temp1[stageIndex])
end
end

function xianjieModel:checkMoJiangFinishFlag(seasonType,stageIndex,beginTime)
local temp=_finishFlag[tostring(seasonType)]
if temp then
return temp[tostring(stageIndex)]==beginTime
end
return false
end

function xianjieModel:setMoJiangFinishFlag(seasonType,stageIndex)
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage then
local temp=_finishFlag[tostring(seasonType)]
if temp==nil then
temp={}
_finishFlag[tostring(seasonType)]=temp
end
temp[tostring(stageIndex)]=stage.beginTime

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJiang,"finishFlag",_finishFlag)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJiang)
end
end

function xianjieModel:isMoJiangBuild(build_id)
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
return buildCfg and buildCfg.param~=nil and buildCfg.param.is_mojiang==true
end

function xianjieModel:isMoJiangBuild_int64(int64Guid)
local build_id=mathHelper.int64_to_number(int64Guid)
return self:isMoJiangBuild(build_id)
end

function xianjieModel:findMoJiangEntityByBuild(build_id)
local infos=xianjieModel:getMoJiangSeasonStages(build_id)
if next(infos)then
local first=infos[1]
return self:getMoJiangEntity(first[1],first[2],build_id)
end
end

function xianjieModel:findMoJiangEntityByBuild64(int64BuildID)
local build_id=mathHelper.int64_to_number(int64BuildID)
return self:findMoJiangEntityByBuild(build_id)
end

function xianjieModel:refreshAllMoJiangEntity()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
if data.entity then
data.entity:refreshEntity()
end
end
end
end
end

function xianjieModel:refreshAllMoJiangStage()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
if data.entity then
data.entity:refreshStage()
end
end
end
end
end

function xianjieModel:refreshMoJiangDefaultData(_seasonType,_fog)
for seasonType,handle in pairs(seasonModel.data)do
if _seasonType==nil or seasonType==_seasonType then
local stages=handle:getStages()
local fog=_fog or xianjieController:getSeaonCurFogId(seasonType)
for stageIdx,stage in ipairs(stages)do
self:checkMoJiangDefaultData(seasonType,stageIdx,stage,fog)
end
end
end
end

function xianjieModel:checkMoJiangDefaultData(seasonType,stageIndex,stage,fog)
stage=stage or seasonModel:getStage(seasonType,stageIndex)
if stage.type~=seasonStageType.eMJHD then return end
fog=fog or xianjieController:getSeaonCurFogId(seasonType)
local config=stage:getConfig()
local datas=xianjieModel:getMoJiangDatas(seasonType,stageIndex)

if(datas==nil or next(datas)==nil)and config.fogShow~=nil and fog>=config.fogShow then
for build_id,config in pairs(config.mojiang)do
local rangeData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
local entityData={
entitytype=xjServerEnityType.eClientBuild,
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
damage=0,
damageFlag=0,
fightCD=0,
hp=10000,
killTime=0,
bestGuild=nil,
bestPlayer=nil,
fightTimes=0,
fighted=0,
dailyFlag=0,
bufflistlen=0,
buffList={},
}

xianjieModel:setMoJiangData(seasonType,stageIndex,build_id,entityData,rangeData,false)
end
end
end

function xianjieModel:onNewDay_mojiang()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
if data.entity then
data.entity.fightTimes=0
data.entity:refreshStage()
data.entity:refreshEntity()
end
end
end
end
end

function xianjieModel:checkMoJiangFightPlot(seasonType,stageIndex,build_id)
local key=FMT.fmt("fightPlot_{0}_{1}_{2}",seasonType,stageIndex,build_id)
return _fightPlot[key]==true
end

function xianjieModel:setMoJiangFightPlot(seasonType,stageIndex,build_id)
local key=FMT.fmt("fightPlot_{0}_{1}_{2}",seasonType,stageIndex,build_id)
_fightPlot[key]=true

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJiang,"fightPlot",_fightPlot)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJiang)
end

function xianjieModel:checkMoJiangDeadPlot(seasonType,stageIndex,build_id)
local key=FMT.fmt("deadPlot_{0}_{1}_{2}",seasonType,stageIndex,build_id)
return _deadPlot[key]==true
end

function xianjieModel:setMoJiangDeadPlot(seasonType,stageIndex,build_id)
local key=FMT.fmt("deadPlot_{0}_{1}_{2}",seasonType,stageIndex,build_id)
_deadPlot[key]=true

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJiang,"deadPlot",_deadPlot)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJiang)
end
