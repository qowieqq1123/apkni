local _roads={}
local _repair={}
local _collect={}
local _storage={}
local _heju={}

function xianmengModel:clearMountainData()
self:clearHeJuData()
zongmenModel.data.mountainData[mapIdType.xianmeng]=nil
end

function xianmengModel:fakeMountainData(mapId,sfItem)




local monijySF=self:create_MonijySF_By_MonijySF3(sfItem)
zongmenModel:setMountainDatas(monijySF)





























































end









function xianmengModel:setRepairCollect(datas)
_repair={}
if datas then
for i,v in ipairs(datas)do
_repair[v.posidx]={
build_id=v.buildid,
pos_idx=v.posidx,
collect_num=v.times,
daily=v.daily,
}
end
end
end

function xianmengModel:modifyRepairCollectNum(build_id,pos_idx,collect_num)
local repair=_repair[pos_idx]
if repair then
repair.build_id=build_id
repair.collect_num=collect_num
else
_repair[pos_idx]={
build_id=build_id,
pos_idx=pos_idx,
collect_num=collect_num,
daily=0,
}
end
end

function xianmengModel:clearAllRepairCollectDaily()
for i,v in pairs(_repair)do
v.daily=0
end
end

function xianmengModel:getRepairCollectReddot()
local xmLv=xianmengModel:getXMLevel()or-1
local repairList=cfgHelper.get(cfg_monijysfconfig_get,mapIdType.xianmeng,"repair_build_list")
for bdId,pos_idx in pairs(repairList)do
local bdData=zongmenModel:getBuildingDataByBdId(mapIdType.xianmeng,bdId)
if#bdData<=0 then
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local need=zongmenControl:getMinNeedLevel(bdCfg,mapIdType.xianmeng)
if need<=xmLv then
local gCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,bdId,0)
local collect=self:findRepairCollectByBdId(bdId)
local cur=collect and collect.daily or 0
local max=gCfg.daily
if cur<max then
return true
end
end
end
end
return false
end

function xianmengModel:setRepairCollectDaily(pos_idx,daily)
local repair=_repair[pos_idx]
if repair then
repair.daily=daily
end
end

function xianmengModel:addRepairCollectDaily(pos_idx,daily)
local repair=_repair[pos_idx]
if repair then
repair.daily=repair.daily+(daily or 1)
end
end

function xianmengModel:getRepairCollect(pos_idx)
return _repair[pos_idx]
end

function xianmengModel:findRepairCollectByBdId(bdId)
for i,v in pairs(_repair)do
if bdId==v.build_id then
return v
end
end
end

function xianmengModel:getAllRepairCollect()
return _repair
end

function xianmengModel:clearAllRepairCollect()
_repair={}
end

function xianmengModel:setNormalCollect(datas)
_collect={}
if datas then
for i,v in ipairs(list)do
_collect[v.buildguid]={
un_build_id=v.buildguid,
collect_num=v.times,
daily=v.daily
}
end
end
end

function xianmengModel:modifyNormalCollectNum(buildguid,collect_num)
local collect=_collect[buildguid]
if collect then
collect.collect_num=collect_num
else
_collect[buildguid]={
un_build_id=buildguid,
collect_num=collect_num,
daily=0,
}
end
end

function xianmengModel:addNormalCollectDaily(buildguid,daily)
local collect=_collect[buildguid]
if collect then
collect.daily=collect.daily+(daily or 1)
end
end

function xianmengModel:setNormalCollectDaily(buildguid,daily)
local collect=_collect[buildguid]
if collect then
collect.daily=daily
end
end

function xianmengModel:getNormalCollect(ubdId)
return _collect[ubdId]
end

function xianmengModel:setStorageData(datas,reset)
if reset then
_storage={}
end
if datas then
for i,v in ipairs(datas)do
_storage[v.param_1]={un_build_id=v.param_1,build_id=v.param_2,level=v.param_3}
end
end
end

function xianmengModel:addStorageData(ubdId,bdId,level)
_storage[ubdId]={un_build_id=ubdId,build_id=bdId,level=level}
end

function xianmengModel:delStorageData(ubdId)
_storage[ubdId]=nil
end

function xianmengModel:getStorageDatas()
return _storage
end

function xianmengModel:getStorageData(ubdId)
return _storage[ubdId]
end

function xianmengModel:addHeJu(actorId,ubdId)
_heju[ubdId]=actorId
end

function xianmengModel:delHeJu(ubdId)
_heju[ubdId]=nil
end

function xianmengModel:setHeJu(datas)
_heju={}
if datas then
for i,v in ipairs(datas)do
_heju[v.param_2]=v.param_1
end
end
end

function xianmengModel:getHeJuActor(ubdId)
return _heju[ubdId]
end

function xianmengModel:getAllHeJu()
return _heju
end

function xianmengModel:hasSelfHeJu()
local id=playerModel:getActorID()
for i,v in pairs(_heju)do
if mathHelper.compareInt64(id,v)then
return true
end
end
return false
end

function xianmengModel:clearHeJuData()
_heju={}
end

function xianmengModel:isHeJuBuild(bdId)
local checkId=cfgHelper.get2(cfg_guildbaseconfig_get,1,"hejubuildid")
return bdId==checkId
end

function xianmengModel:create_MonijySF_By_MonijySF3(monijySF3)
local monijySF={}
monijySF.sf_id=monijySF3.sf_id
monijySF.sf_name="仙盟"
monijySF.sf_dizi_id=int64.zero
monijySF.opentime=timeHelper.getServerShortTime()
monijySF.begintime=timeHelper.getServerShortTime()
monijySF.unlockareacnt=0
monijySF.task_idx=0
monijySF.taskFlag=1
monijySF.open_sf_dizi_len=0
monijySF.opensfdiziList={}
monijySF.open_area_list_len=monijySF3.open_area_list_len

monijySF.areaList={}
for i,v in ipairs(monijySF3.areaList or{})do
local monijyAreaStruct=self:create_MonijyAreaStruct_By_MonijyAreaStruct3(v)
table.insert(monijySF.areaList,monijyAreaStruct)
end

monijySF.open_build_list_len=monijySF3.open_build_list_len

monijySF.buildList={}
for i,v in ipairs(monijySF3.buildList or{})do
local monijyBuildStruct=self:create_MonijyBuildStruct_By_MonijyBuildStruct3(v)
table.insert(monijySF.buildList,monijyBuildStruct)
end

monijySF.reducetimes=0
monijySF.repair_build_len=monijySF3.repair_build_list_len
monijySF.repairbuildList=monijySF3.repairbuildList
monijySF.road_len=monijySF3.road_list_len
monijySF.roadList=monijySF3.roadList
monijySF.randomItemLen=0
monijySF.randomList={}
return monijySF
end

function xianmengModel:create_MonijyAreaStruct_By_MonijyAreaStruct3(monijyAreaStruct3)
local monijyAreaStruct={}
monijyAreaStruct.area_id=monijyAreaStruct3.areaid
monijyAreaStruct.opentime=monijyAreaStruct3.finishtime
monijyAreaStruct.begintime=monijyAreaStruct3.finishtime
monijyAreaStruct.open_dizi_len=0
monijyAreaStruct.diziList={}
monijyAreaStruct.reducetimes=0
return monijyAreaStruct
end

function xianmengModel:create_MonijyBuildStruct_By_MonijyBuildStruct3(monijyBuildStruct3)
local monijyBuildStruct={}
monijyBuildStruct.un_build_id=monijyBuildStruct3.buildguid
monijyBuildStruct.build_id=monijyBuildStruct3.buildid
monijyBuildStruct.dizi_id=int64.zero
monijyBuildStruct.flag=monijyBuildStruct3.flag
monijyBuildStruct.funcflag=monijyBuildStruct3.funcflag
monijyBuildStruct.level=monijyBuildStruct3.level
monijyBuildStruct.opentime=0
monijyBuildStruct.begintime=monijyBuildStruct3.finishtime
monijyBuildStruct.appearanceid=monijyBuildStruct3.appearanceid
monijyBuildStruct.orientation=monijyBuildStruct3.orientation
monijyBuildStruct.model_id=monijyBuildStruct3.modelid
monijyBuildStruct.x=monijyBuildStruct3.x
monijyBuildStruct.y=monijyBuildStruct3.y
monijyBuildStruct.reducetime=0
monijyBuildStruct.dizi_list_len=0
monijyBuildStruct.diziList={}
monijyBuildStruct.caveGeZiLen=0
monijyBuildStruct.caveGeziList={}
monijyBuildStruct.ncreateopentime=0
monijyBuildStruct.ncreatetotaltimes=0
monijyBuildStruct.pcreateopentime=0
monijyBuildStruct.pcreatetotaltimes=0
monijyBuildStruct.pcreatedizi_id=int64.zero
monijyBuildStruct.plant_id=0
monijyBuildStruct.pcreatestopreason=0
monijyBuildStruct.pcreateaddpercent=0
monijyBuildStruct.pcreatetimepercent=0
monijyBuildStruct.pcreatereducetimes=0
monijyBuildStruct.spe_reward_len=0
monijyBuildStruct.speRewardList={}
monijyBuildStruct.pcreate_effect_len=0
monijyBuildStruct.pEffectList={}
monijyBuildStruct.name=""
monijyBuildStruct.rename_flag=0
monijyBuildStruct.hasExNum=0
monijyBuildStruct.len=0
monijyBuildStruct.rewardList={}
monijyBuildStruct.effect_len=0
monijyBuildStruct.effectLst={}
return monijyBuildStruct
end