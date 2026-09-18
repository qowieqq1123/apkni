









local _datas={}






local _reverse={}











local _ranks={}

local _finishFlag=nil
local _AutoFixNum=0

function xianjieModel:setZhenTaiDatas(seasonType,stageIndex,dataList,isInit)
local keeps={}

if dataList then
for index,data in ipairs(dataList)do
local build_id=data.zhentai_id
local client_build_id=seasonModel:getStageConfigEx(seasonType,stageIndex,"client_build_list",build_id)
local rangeData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
client_build_id=client_build_id,
}
local entityData={
entitytype=xjServerEnityType.eClientBuild,
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
client_build_id=client_build_id,
finish_cnt=data.finish_cnt or 0,
buff_begin_times=data.buff_begin_times or 0,
fix_finish_rw=data.fix_finish_rw or 0,
}
xianjieModel:setZhenTaiData(seasonType,stageIndex,build_id,entityData,rangeData,isInit)
keeps[build_id]=true
end
end
if isInit then
local client_build_list=seasonModel:getStageConfigEx(seasonType,stageIndex,"client_build_list")
for build_id,client_build_id in ipairs(client_build_list)do
if not keeps[build_id]then
local rangeData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
client_build_id=client_build_id,
}
local entityData={
entitytype=xjServerEnityType.eClientBuild,
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
client_build_id=client_build_id,
finish_cnt=0,
buff_begin_times=0,
fix_finish_rw=0,
}
xianjieModel:setZhenTaiData(seasonType,stageIndex,build_id,entityData,rangeData,isInit)
end
end
end
end

function xianjieModel:setZhenTaiData(seasonType,stageIndex,build_id,entityData,rangeData,onlyData)
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
d.entity=xianjieController:createXJClass(xjDataType.eZhenTai,entityData)
d.range=xianjieController:createXJClass(xjDataType.eZhenTaiRange,rangeData)
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

function xianjieModel:getZhenTaiData(seasonType,stageIndex,build_id)
local datas=self:getZhenTaiDatas(seasonType,stageIndex)
return datas and datas[build_id]or nil
end

function xianjieModel:getZhenTaiDatas(seasonType,stageIndex)
return _datas[seasonType]and _datas[seasonType][stageIndex]or nil
end

function xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)
local data=self:getZhenTaiData(seasonType,stageIndex,build_id)
return data and data.entity or nil
end

function xianjieModel:getZhenTaiRange(seasonType,stageIndex,build_id)
local data=self:getZhenTaiData(seasonType,stageIndex,build_id)
return data and data.range or nil
end

function xianjieModel:setZhenTaiBuffBeginTime(seasonType,stageIndex,worship_build_id)
local datas=self:getZhenTaiDatas(seasonType,stageIndex)
if datas then
for build_id,data in ipairs(datas)do
local entity=data.entity
if entity then
if worship_build_id==build_id then
entity.buff_begin_times=timeHelper.getServerShortTime()
else
entity.buff_begin_times=0
end
end
end
end
end

function xianjieModel:clearZhenTaiDatas(seasonType,stageIndex)
local datas=self:getZhenTaiDatas(seasonType,stageIndex)
if datas then
for build_id,data in ipairs(datas)do
xianjieModel:setZhenTaiData(seasonType,stageIndex,build_id,nil,false)
end
end
end

function xianjieModel:getZhenTaiSeasonStages(build_id)
return _reverse[build_id]or defaultT
end

function xianjieModel:clearData_zhentai()
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
table.clear(_ranks)
_finishFlag=nil
_AutoFixNum=0
end

function xianjieModel:initData_zhentai()
_finishFlag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZhenTai,"finishFlag",{})
_AutoFixNum=0
end

function xianjieModel:onEnterMap_zhentai()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
data.entity:createEntity(true)
data.range:createEntity(true)
end
end
end
end

function xianjieModel:onExitMap_zhentai()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,temp2 in pairs(temp1)do
for buildID,data in pairs(temp2)do
data.entity:removeEntity()
data.range:removeEntity()
end
end
end
end

function xianjieModel:setZhenTaiRank(seasonType,stageIndex,build_id,rankType,rankList,rankNum,rankScore)
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
dataList[v.rank_idx]=v
end
end
temp3[rankType]={dataList,rankNum,rankScore}
end

function xianjieModel:getZhenTaiRank(seasonType,stageIndex,build_id,rankType)
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

function xianjieModel:clearZhenTaiRanks(seasonType,stageIndex)
local temp1=_ranks[seasonType]
if temp1 and temp1[stageIndex]then
table.clear(temp1[stageIndex])
end
end

function xianjieModel:isShowZhenTaiMenuGroup()
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMJZT)
if stage then
return true
end
return false
end

function xianjieModel:checkZhenTaiFinishFlag(seasonType,stageIndex,beginTime)
local temp=_finishFlag[tostring(seasonType)]
if temp then
return temp[tostring(stageIndex)]==beginTime
end
return false
end

function xianjieModel:setZhenTaiFinishFlag(seasonType,stageIndex)
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage then
local temp=_finishFlag[tostring(seasonType)]
if temp==nil then
temp={}
_finishFlag[tostring(seasonType)]=temp
end
temp[tostring(stageIndex)]=stage.beginTime

userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhenTai,"finishFlag",_finishFlag)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhenTai)
end
end

function xianjieModel:isZhenTaiBuild(build_id)
local buildIdList={
[xjClientBuildType.flcbMoJieZhenTai1]=true,
[xjClientBuildType.flcbMoJieZhenTai2]=true,
[xjClientBuildType.flcbMoJieZhenTai3]=true,
[xjClientBuildType.flcbMoJieZhenTai4]=true,
}
if buildIdList[build_id]then
return true
end
return false
end

function xianjieModel:isZhenTaiBuild_int64(int64Guid)
local build_id=mathHelper.int64_to_number(int64Guid)
return self:isZhenTaiBuild(build_id)
end

function xianjieModel:findZhenTaiEntityByBuild(build_id)
local infos=xianjieModel:getZhenTaiSeasonStages(build_id)
if next(infos)then
local first=infos[1]
return self:getZhenTaiEntity(first[1],first[2],build_id)
end
end

function xianjieModel:findZhenTaiEntityByBuild64(int64BuildID)
local build_id=mathHelper.int64_to_number(int64BuildID)
return self:findZhenTaiEntityByBuild(build_id)
end

function xianjieModel:refreshAllZhenTaiEntity()
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

function xianjieModel:getZhenTaiNode(seasonType,stageIndex,build_id)
local node=1
local stageCfg=seasonModel:getStageConfigEx(seasonType,stageIndex)
local entityData=xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)
local finish_cnt=entityData.finish_cnt or 0
local fix_node=stageCfg.fix_node[build_id]or defaultT
for idx,node_cnt in ipairs(fix_node)do
if finish_cnt>=node_cnt then
node=idx
else
break
end
end
return node
end

function xianjieModel:setZhenTaiAutoFixNum(num)
_AutoFixNum=num
end

function xianjieModel:getZhenTaiAutoFixNum()
return _AutoFixNum
end