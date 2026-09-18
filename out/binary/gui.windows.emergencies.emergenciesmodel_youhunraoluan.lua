local _ghostData={}
local _ghostCount=0
local _unLockAreaList={}
local _rangeAreaList={}
local _areaPosList={}
local _ghostSundriesId=nil
local _firstSelectPosList={}

function emergenciesModel:setGhostData(id,datas)
self:cleanGhostData()
for i,v in ipairs(datas)do
_ghostData[i]=v.param_1==0
end

local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,id)
_ghostCount=cfg.event_conf.ghost[1]
_ghostSundriesId=cfg.event_conf.sundriesId

end

function emergenciesModel:addGhostData(idx)
if _ghostData[idx]==nil then
_ghostData[idx]=true
return true
end
return false
end

function emergenciesModel:getGhostData(index)
return _ghostData[index]
end

function emergenciesModel:getAllGhostData()
return _ghostData
end

function emergenciesModel:cleanGhostData()
_ghostData={}
_ghostCount=0
end

function emergenciesModel:isDead_Ghost(index)
local data=self:getGhostData(index)
if data~=nil then

return not data
end

return false
end

function emergenciesModel:setGhostDead(index)
if _ghostData[index]then
_ghostData[index]=false
end
end

function emergenciesModel:clickGhost(index)
local data=self:getGhostData(index)
if data~=nil and data then
data=false
end
end

function emergenciesModel:countGhostDead()
local count=0
for i=1,_ghostCount do

if self:isDead_Ghost(i)then
count=count+1
end
end
return count
end

function emergenciesModel:countGhostSurvive()
local count=0
for i=1,_ghostCount do

if not self:isDead_Ghost(i)then
count=count+1
end
end
return count
end


function emergenciesModel:initGhostCreateAreaList()

_unLockAreaList={}
_rangeAreaList={}
_areaPosList={}
local cfg=cfg_monijyareaconfig()
for i=1,#cfg do
local areaId=cfg[i].id
if cfg[i].sf_id==1 and zongmenModel:isAreaUnlock(areaId)then
_unLockAreaList[#_unLockAreaList+1]=areaId
_rangeAreaList[#_rangeAreaList+1]=areaId
self:initAreaPosList(areaId)
end
end
end


function emergenciesModel:initAreaPosList(areaId)
if not _ghostSundriesId then
logErr("没有读取到鬼魂对应的随机物id 请检查前端代码此事件的初始化方法执行顺序")
return
end
local cfgId=sundriseCreateControl:getPlaceConfig(_ghostSundriesId)
local list=_MapManager.GetMapAreaPosByConfig(mapIdType.zhufeng,areaId,cfgId)
_areaPosList[areaId]=list or{}
end


function emergenciesModel:initGhostFirstSelectPosList()
if not _ghostSundriesId then
logErr("没有读取到鬼魂对应的随机物id 请检查前端代码此事件的初始化方法执行顺序")
return
end
local cfgId=sundriseCreateControl:getPlaceConfig(_ghostSundriesId)

local checkPosIndex_lookup={}
_firstSelectPosList={}

local buildingDatas=zongmenModel:getAllBuildingData(mapIdType.zhufeng)
local bdDataList={}
for k,v in pairs(buildingDatas)do
local ftype=zongmenModel:getBDFlagType(v.flag)
if ftype==bdFlagType.normal then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eDuoRen or cfg.build_type==SLG_SYSTEM_TYPE.eDanRen then
table.insert(bdDataList,v)
end
end
end

if bdDataList and next(bdDataList)then
for i,bdData in ipairs(bdDataList)do
local guid=bdData.entityId
local spreadRange=cfgHelper.get2(cfg_tufaeventbasicconfig_get,1,'ghostRangeCount')or 2
local posList=_MapManager.GetPlaceObjectNearbySpace(guid,spreadRange,cfgId)
if posList and posList.Count>0 then
for i=1,posList.Count do
local pos=posList[i-1]
local posArr=_MapManager.Vector3IntToArray(pos)
local posX=posArr[1]
local posY=posArr[2]
local posZ=posArr[3]
local posStr=FMT.fmt("{0}_{1}_{2}",posX,posY,posZ)
if not checkPosIndex_lookup[posStr]then
local areaId=_MapManager.GetAreaID(mapIdType.zhufeng,pos)
if areaId and zongmenModel:isAreaUnlock(areaId)then
checkPosIndex_lookup[posStr]=true
local posData={
pos=pos,
areaId=areaId,
}
table.insert(_firstSelectPosList,posData)
end
end
end
end
end
end
end


function emergenciesModel:getGhostCreatePos()
local areaId=nil


if _firstSelectPosList and next(_firstSelectPosList)then

local randomIndex=math.random(1,#_firstSelectPosList)
local posData=_firstSelectPosList[randomIndex]
areaId=posData.areaId
if areaId and next(_rangeAreaList)then
for i,v in ipairs(_rangeAreaList)do
if v==areaId then
table.remove(_rangeAreaList,i)
break
end
end
end
local pos=posData.pos
return pos
end

if next(_rangeAreaList)then

local randomIndex=math.random(1,#_rangeAreaList)
areaId=table.remove(_rangeAreaList,randomIndex)
else

local randomIndex=math.random(1,#_unLockAreaList)
areaId=_unLockAreaList[randomIndex]
end

if not _areaPosList[areaId]or _areaPosList[areaId].Count<=0 then
self:initAreaPosList(areaId)
end

local randomPosIndex=math.random(1,_areaPosList[areaId].Count)
return _areaPosList[areaId][randomPosIndex-1]
end

