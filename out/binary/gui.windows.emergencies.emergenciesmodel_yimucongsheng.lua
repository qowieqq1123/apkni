local _clData={}
local _clClick=0
local _clCount=0
local _creeperData={}

function emergenciesModel:setEventHandData_YiMuCongSheng(eventId,time,cfg,eventData)
if cfg.event_type==emergenciesType.eYiMuCongSheng then

local check=true
if eventData then
local count=cfg.event_conf.plant[3]
local click=cfg.event_conf.plant[2]

for i=1,count do
local v=eventData[i]
if v==nil or v.param_1<click then
check=false
break
end
end
else
check=false
end
if not check then
local endTime=time+cfg.event_conf.reduce_sec
self:setCreeperTime(cfg,endTime)
end
end
end

function emergenciesModel:refreshEvent_YiMuCongSheng()
local eventId=self:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
if eventCfg.event_type==emergenciesType.eYiMuCongSheng then
local endTime=self:getEndTime()
self:setCreeperTime(eventCfg,endTime)
end
end

function emergenciesModel:setCreeperTime(cfg,endTime)
_creeperData={}
for idx,bdType in ipairs(cfg.event_conf.twine_builds)do
local bdList=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,bdType)
for i,bdData in ipairs(bdList)do
self:addCreeper(bdData.un_build_id,endTime)
end
end
end

function emergenciesModel:addCreeper(ubdId,endTime)
if not _creeperData[ubdId]then
_creeperData[ubdId]=endTime
end
end

function emergenciesModel:isCreeper(ubdId)
local endTime=_creeperData[ubdId]
if endTime then

return endTime>=timeHelper.getServerShortTime()
end
return false
end

function emergenciesModel:clearAllCreeper()
_creeperData={}
end

function emergenciesModel:clearCreeper(ubdId)
_creeperData[ubdId]=nil
end

function emergenciesModel:getCreeper(ubdId)
return _creeperData[ubdId]
end

function emergenciesModel:getAllCreeper()
return _creeperData
end

function emergenciesModel:checkBuildingCreeper(bdId)
local nowTime=timeHelper.getServerShortTime()
local check={}
for ubdId,deadLine in pairs(_creeperData)do
if deadLine>=nowTime then
local bdData=zongmenModel:getBuildingData(ubdId)
table.insert(check,bdData.build_id)
break
end
end
return table.containsValue(check,bdId)
end

function emergenciesModel:setCaoLingData(id,datas)
self:cleanCaoLingData()
for i,v in ipairs(datas)do
_clData[i]=v.param_1
end

local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,id)
_clClick=cfg.event_conf.plant[2]
_clCount=cfg.event_conf.plant[3]

end

function emergenciesModel:addCaoLingData(idx)
if _clData[idx]==nil then
_clData[idx]=0
return true
end
return false
end

function emergenciesModel:getCaoLingData(index)
return _clData[index]
end

function emergenciesModel:getAllCaoLingData()
return _clData
end

function emergenciesModel:cleanCaoLingData()

_clData={}
_clClick=0
_clCount=0
end

function emergenciesModel:isDead_CaoLing(index)
local data=self:getCaoLingData(index)
if data then
return data>=_clClick
end
return false
end

function emergenciesModel:clickCaoLing(index)
local data=self:getCaoLingData(index)
if data then
_clData[index]=_clData[index]+1
end
end

function emergenciesModel:getLeastClick(index)
local data=self:getCaoLingData(index)
if data then
return _clClick-data
end
end

function emergenciesModel:countCaoLingDead()
local count=0
for i=1,_clCount do

if self:isDead_CaoLing(i)then
count=count+1
end
end
return count
end


function emergenciesModel:getCaoLingCreatePos()
local eventId=emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local sundriesModel=eventCfg.event_conf.plant[4]
local cfgId=sundriseCreateControl:getPlaceConfig(sundriesModel)

local buildingDatas=zongmenModel:getAllBuildingData(mapIdType.zhufeng)
local bdDataList={}
for k,v in pairs(buildingDatas)do
local ftype=zongmenModel:getBDFlagType(v.flag)
if ftype==bdFlagType.normal then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eYaoPu or cfg.build_type==SLG_SYSTEM_TYPE.eLinChang then
table.insert(bdDataList,v)
end
end
end

if bdDataList and next(bdDataList)then
local randomBdIndex=math.random(1,#bdDataList)
local selectBdData=bdDataList[randomBdIndex]
local guid=selectBdData.entityId
local spreadRange=cfgHelper.get2(cfg_tufaeventbasicconfig_get,1,'caoLingRangeCount')or 2
local posList=_MapManager.GetPlaceObjectNearbySpace(guid,spreadRange,cfgId)
if posList and posList.Count>0 then
local randomPosIndex=0
if posList.Count>2 then
randomPosIndex=math.random(0,posList.Count-1)
local pos=posList[randomPosIndex]
return pos
end
end
end

local list=_MapManager.GetMapAreaPosByConfig(mapIdType.zhufeng,-2,cfgId)
local pos=_MapManager.ToVector3Int(0,0,0)
if list.Count>0 then
local r=math.random(1,list.Count)
pos=list[r-1]
end
return pos
end
