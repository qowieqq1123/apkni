xjResPointTypeReflectionData={
[XJ_ResPoint_TYPE.eMonster]=xjDataType.eResPoint_Monster,
[XJ_ResPoint_TYPE.eEvent]=xjDataType.eResPoint_Event,
[XJ_ResPoint_TYPE.eNPC]=xjDataType.eResPoint_NPC,
[XJ_ResPoint_TYPE.eMystery]=xjDataType.eResPoint_Mystery,
[XJ_ResPoint_TYPE.eCollectible]=xjDataType.eResPoint_Collectible,
[XJ_ResPoint_TYPE.eCtCollectible]=xjDataType.eResPoint_CanvertCollectible,
}

xjResPointSourceType={
ePlot=1,
eTask=2,
eExploration=3,
eXianBangTask=4,
eQiYu=5,
eMoJie=6,
}

local xjResPointShowAtOnce={
[xjResPointSourceType.ePlot]=true,
[xjResPointSourceType.eTask]=true,
[xjResPointSourceType.eExploration]=false,
[xjResPointSourceType.eXianBangTask]=true,
[xjResPointSourceType.eQiYu]=false,
[xjResPointSourceType.eMoJie]=true,
}

xjResPointMarchTeamType={
eData=0,
eNormal=1,
eRetract=2,
eCollectible=3,
}

xjResPointType2TeamType={
[xjResPointMarchTeamType.eNormal]=xjTeamHandleType.eResPointTeam,
[xjResPointMarchTeamType.eRetract]=xjTeamHandleType.eResPointReract,
[xjResPointMarchTeamType.eCollectible]=xjTeamHandleType.eResPointTeam,
}

xjResPointChangeEventType={
eAdd=1,
eUpdate=2,
eDelete=3,
}


local _xjResPointSourceHandle={
[xjResPointSourceType.ePlot]={
getHUDInfo=function(scrtype)
return false
end,
findAData=function(scrtype,sceneidx,cloudid,idx)
return xianjieModel:findAResPointBySource(scrtype,sceneidx,{cloudid=cloudid,idx=idx})
end,
findDatas=function(scrtype,sceneidx,cloudid,idx)
return xianjieModel:findResPointsBySource(scrtype,sceneidx,{cloudid=cloudid,idx=idx})
end,
},
[xjResPointSourceType.eTask]={
getHUDInfo=function(scrtype)
return false
end,
findAData=function(scrtype,sceneidx,taskid)
return xianjieModel:findAResPointBySource(scrtype,sceneidx,{taskid=taskid})
end,
findDatas=function(scrtype,sceneidx,taskid)
return xianjieModel:findResPointsBySource(scrtype,sceneidx,{taskid=taskid})
end,
},
[xjResPointSourceType.eExploration]={
getHUDInfo=function(scrtype)
return true
end,
findAData=function(scrtype,sceneidx)
return xianjieModel:findAResPointBySource(scrtype,sceneidx)
end,
findDatas=function(scrtype,sceneidx)
return xianjieModel:findResPointsBySource(scrtype,sceneidx)
end,
},
[xjResPointSourceType.eXianBangTask]={
getHUDInfo=function(scrtype)
return true
end,
findAData=function(scrtype,sceneidx,taskid)
return xianjieModel:findAResPointBySource(scrtype,sceneidx,{taskid=taskid})
end,
findDatas=function(scrtype,sceneidx,taskid)
return xianjieModel:findResPointsBySource(scrtype,sceneidx,{taskid=taskid})
end,
},
[xjResPointSourceType.eQiYu]={
getHUDInfo=function(scrtype)
return true
end,
findAData=function(scrtype,sceneidx)
return xianjieModel:findAResPointBySource(scrtype,sceneidx)
end,
findDatas=function(scrtype,sceneidx)
return xianjieModel:findResPointsBySource(scrtype,sceneidx)
end,
},
}


local _cdLookup={}
local _count=0
local _datas={}
local _classify={}
local _sources={}

local _cache={}

local _marchs={}
local _init=true

local _clientPosData=nil
local _clientPosKey="XJRPPointRecord"

function xianjieModel:getResPointInit()
return _init
end

function xianjieModel:setResPointInit()
_init=false
end

function xianjieModel:clearResPointInit()
_init=true
end

function xianjieModel:clearResPointCache()
table.clear(_cache)
end

function xianjieModel:getResPointCache()
return _cache
end

function xianjieModel:getXJResPointClassifyCfg(rpType,...)
local config_name=cfgHelper.get2(cfg_fairylandresourceconfig_get,rpType,"config_name")
local cfgGet=cfgHelper.getCofingGetFunction(config_name)
return cfgHelper.get(cfgGet,...)
end

function xianjieModel:createResPointXJData(data)
local dataType=xjResPointTypeReflectionData[data.rpType]
return xianjieController:createXJClass(dataType,data)
end

function xianjieModel:refreshResPointData(guid,v,isInit)
if v then
local data=self:getResPointData(guid)



if data then

data:refreshData(v)
data:refreshEntity()
xianjieModel:setResPointCDLookup(data)
notifySystem:postNotify(notifyConfig.onXianJieResPointDataChange,xjResPointChangeEventType.eUpdate,guid,isInit,data)
else

if self:canResPointDataInit(v)then
local data=self:addResPointData(v)
if not isInit and xjResPointShowAtOnce[data.source.srctype]then
data:createEntity(true)
end
notifySystem:postNotify(notifyConfig.onXianJieResPointDataChange,xjResPointChangeEventType.eAdd,guid,isInit,data)
else
self:setResPointDataIntoCache(guid,v)
end
end
else

local data=self:deleteResPointData(guid)
self:deleteResPointPosRecord(guid)

local march=self:getResPointMarch(guid)
if march then
local dDataType=march:getMarchData("dDataType")
if dDataType==xjResPointMarchTeamType.eData then
xianjieController:reqXianJieResPointMarchSave(data.rpGuid,"")
end
end

notifySystem:postNotify(notifyConfig.onXianJieResPointDataChange,xjResPointChangeEventType.eDelete,guid,isInit,data)
end

local rpData=xianjieModel:getResPointData(guid)
if rpData and not isInit then
rpData:refreshEntity()
end
end







function xianjieModel:canResPointDataInit(data)
if self:getResPointPosRecord(data.rpGuid)then
return true
end
local posCfg=cfgHelper.get1(cfg_xianjiepositionconfig_get,data.posIdx)
if posCfg then
if posCfg.sceneidx<=0 then
return true
elseif self.serverData then
return true
end
elseif xianjieModel:getZongMenOutPos()~=nil then
return true
end
return false
end

function xianjieModel:setResPointDataIntoCache(guid,v)
local key=tostring(guid)
_cache[key]=v
end

function xianjieModel:reInitResPointCacheData()
local list={}
for key,v in pairs(_cache)do
if xianjieModel:canResPointDataInit(v)then
local guid=v.rpGuid
self:refreshResPointData(guid,v,true)
table.insert(list,key)
end
end
for i,v in ipairs(list)do
_cache[v]=nil
end
end

function xianjieModel:addResPointData(data)
local key=tostring(data.rpGuid)
data.key=key
self:initResPointPosition(data)
local _data=self:createResPointXJData(data)
_datas[key]=_data
_count=_count+1
self:setResPointCDLookup(_data)

local classify=_classify[data.rpType]
if classify==nil then
classify={}
_classify[data.rpType]=classify
end
table.insert(classify,key)

local sources=_sources[data.source.srctype]
if sources==nil then
sources={}
_sources[data.source.srctype]=sources
end
table.insert(sources,key)

return _data
end

function xianjieModel:deleteResPointData(rpGuid)
local key=tostring(rpGuid)
local data=_datas[key]

if data then
local rpType=data.rpType
local srctype=data.source.srctype

xianjieController:removeXJClass(data)

local classify=_classify[rpType]
if classify then
table.removeValue(classify,key)
end

local sources=_sources[srctype]
if sources then
table.removeValue(sources,key)
end

_datas[key]=nil
_cdLookup[key]=nil
_count=_count-1

return data
end
end

function xianjieModel:getResPointData(rpGuid)
local key=tostring(rpGuid)
return self:getResPointDataImp(key)
end

function xianjieModel:getResPointDataImp(key)
return _datas[key]
end

function xianjieModel:getResPointDataEx(key)
return _datas[key]
end

function xianjieModel:haveResPointData(rpGuid)
local data=self:getResPointData(rpGuid)
return data~=nil
end

function xianjieModel:getAllResPointData()
return _datas
end

function xianjieModel:getResPointDatasByType(rpType)
local list={}
local classify=_classify[rpType]
if classify then
for i,v in ipairs(classify)do
local data=_datas[v]
if data then
table.insert(list,data)
end
end
end
return list
end

function xianjieModel:createAllResPointEnities(needRefreshAOI)
for key,data in pairs(_datas)do
data:createEntity(needRefreshAOI)
end
end

function xianjieModel:removeAllResPointEnities()
for key,data in pairs(_datas)do
data:removeEntity()
end
end

function xianjieModel:clearAllResPointData()
local temp=_datas
_datas={}
_cdLookup={}
_count=0
_classify={}
_sources={}

for key,data in pairs(temp)do
xianjieController:removeXJClass(data)
end
end

function xianjieModel:initResPointPosition(data)
local posCfg=cfgHelper.get1(cfg_xianjiepositionconfig_get,data.posIdx)
if posCfg then
data.gridX=posCfg.pos[1]
data.gridZ=posCfg.pos[2]
data.sceneidx=posCfg.sceneidx>0 and xianjieModel:getXianYuSceneIndex()or posCfg.sceneidx
if posCfg.sceneidx==100 then
data.sceneidx=posCfg.sceneidx
end
else

local record=self:getResPointPosRecord(data.rpGuid)
if record then
data.gridX=record.x
data.gridZ=record.z
data.sceneidx=record.scene
else
self:initResPointPositionNearByZongMen(data)
end
end
end

function xianjieModel:initResPointPositionNearByZongMen(data)
local zmPos=xianjieModel:getZongMenOutPos()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local cfg=self:getXJResPointClassifyCfg(data.rpType,data.rpId)





local list=xianjieModel:findPointByDistance(sceneidx,gridX_c,gridZ_c,nil,cfg.size[1],cfg.size[2])
local count=#list
if count>0 then
local point=count>1 and list[math.random(1,#list)]or list[1]
data.gridX=point[1]
data.gridZ=point[2]
data.sceneidx=sceneidx
else
if xianjieController:checkGridInMap(gridX+5,gridZ,sceneidx)then
data.gridX=gridX+5
data.gridZ=gridZ
data.sceneidx=sceneidx
else
data.gridX=gridX-5
data.gridZ=gridZ
data.sceneidx=sceneidx
end
end
self:addResPointPosRecord(data.rpGuid,data.sceneidx,data.gridX,data.gridZ)
end

function xianjieModel:excuteResPointResourceHandle(srctype,funcName,...)
local handle=_xjResPointSourceHandle[srctype]
if handle and handle[funcName]then
return handle[funcName](srctype,...)
end
end

function xianjieModel:findResPointDataByMysteryID(mystery)
local mysteryRPDatas=self:getResPointDatasByType(XJ_ResPoint_TYPE.eMystery)
for i,v in ipairs(mysteryRPDatas)do
local cfg=v:getCfg()
if cfg.mystery==mystery then
return v
end
end
end

function xianjieModel:findResPointDataCountByPosIdx(posIdx)
local count=0
for key,data in pairs(_datas)do
if data.posIdx==posIdx then
count=count+1
end
end
return count
end

function xianjieModel:findResPointsByXianBangTask(taskid)
return self:excuteResPointResourceHandle(xjResPointSourceType.eXianBangTask,"findDatas",nil,taskid)
end

function xianjieModel:getResPointDatasBySource(srctype)
local list={}
local sources=_sources[srctype]
if sources then
for i,v in ipairs(sources)do
local data=_datas[v]
if data then
table.insert(list,data)
end
end
end
return list
end

function xianjieModel:findAResPointBySource(srctype,sceneidx,sParams)
local list=self:getResPointDatasBySource(srctype)
for index,data in ipairs(list)do

if sceneidx==nil or data.sceneidx==sceneidx then
local check=true
if sParams then
for key,value in pairs(sParams)do
if data.source[key]~=value then
check=false
break
end
end
end
if check then
return data
end
end
end
end

function xianjieModel:findResPointsBySource(srctype,sceneidx,sParams)
local list=self:getResPointDatasBySource(srctype)
local temp={}
for index,data in ipairs(list)do

if sceneidx==nil or data.sceneidx==sceneidx then
local check=true
if sParams then
for key,value in pairs(sParams)do
if data.source[key]~=value then
check=false
break
end
end
end
if check then
table.insert(temp,data)
end
end
end
return temp
end

function xianjieModel:findResPointCacheDatasBySource(srcArgs)
local list={}
for k,d in pairs(_cache)do
for key,value in pairs(srcArgs)do
if d.source[key]==value then
table.insert(list,d)
end
end
end
return list
end

function xianjieModel:setResPointCDLookup(rpData)
local flag=0
if rpData.endTime>0 then
flag=mathHelper.setbit(flag,0)
end
if rpData.deadTime then
flag=mathHelper.setbit(flag,1)
end
if flag>0 then
_cdLookup[rpData.key]=flag

if rpData.pcallUpdateExcuteFunc==nil then
rpData.pcallUpdateExcuteFunc=function()
local nowTime=gameUtilityModel.getServerShortTime()
if rpData.endTime>0 and nowTime>rpData.endTime then
local state=xianjieModel:getResPointMarchTeamState(rpData.rpGuid)
if state==nil or state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
xianjieModel:refreshResPointData(rpData.rpGuid,nil,false)
return
end
end
if rpData.deadTime and nowTime>rpData.deadTime then
rpData:removeEntity(true)
xianjieModel:refreshResPointData(rpData.rpGuid,nil,false)
end
end
end

if rpData.pcallUpdateCatchError==nil then
rpData.pcallUpdateCatchError=function()
rpData.updataError=true
loggerUtil.logErrFMT('xjHUD onUpdate err!{0}',err)
end
end
else
_cdLookup[rpData.key]=nil
end
end

function xianjieModel:getResPointCDLookup()
return _cdLookup
end

function xianjieModel:resetResPointMarch()
table.clear(_marchs)
end

function xianjieModel:refreshResPointMarch(guid,marchJson,isInit)
if marchJson and marchJson~=""then
local march=self:getResPointMarch(guid)
if march then
march:refreshJson(marchJson)
notifySystem:postNotify(notifyConfig.onXianJieResPointMarchChange,xjResPointChangeEventType.eUpdate,guid,isInit)

local teamHandle=march:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eChanged,teamHandle)
else
march=self:addResPointMarchJson(guid,marchJson)
march:initTeamHandle()
if not isInit then
march:createBehavior(nil,true)
end
notifySystem:postNotify(notifyConfig.onXianJieResPointMarchChange,xjResPointChangeEventType.eAdd,guid,isInit)

local teamHandle=march:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end
else
local march=self:getResPointMarch(guid)
local teamHandleID=march.teamHandleID

self:deleteResPointMarch(guid)
notifySystem:postNotify(notifyConfig.onXianJieResPointMarchChange,xjResPointChangeEventType.eDelete,guid,isInit)

notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID)
end

local rpData=xianjieModel:getResPointData(guid)
if rpData and not isInit then
rpData:refreshEntity()
end
end

function xianjieModel:addResPointMarchJson(guid,json)
local guidStr=tostring(guid)
local args={
guid=guid,
guid_str=guidStr,
marchJson=json,
}
local xjData=xianjieController:createXJClass(xjDataType.eResPoint_MarchTeam,args)
_marchs[guidStr]=xjData

local rpData=self:getResPointData(guid)
if rpData then
rpData.feign=false
end

return xjData
end

function xianjieModel:deleteResPointMarch(guid)
local key=tostring(guid)
local data=_marchs[key]

if data then
xianjieController:removeXJClass(data)
_marchs[key]=nil
end
end

function xianjieModel:getResPointMarch(guid)
local key=tostring(guid)
return _marchs[key]
end

function xianjieModel:getResPointMarchEx(key)
return _marchs[key]
end

function xianjieModel:haveResPointMarch(guid)
local data=self:getResPointMarch(guid)
return data~=nil
end

function xianjieModel:getAllResPointMarch()
return _marchs
end

function xianjieModel:clearAllResPointMarch()
local temp=_marchs
_marchs={}
for key,data in pairs(temp)do
xianjieController:removeXJClass(data)
end
end

function xianjieModel:getResPointMarchTeamType(dataType)
return xjResPointType2TeamType[dataType]
end

function xianjieModel:excuteAllResPointMarchBehaviour()
for key,march in pairs(_marchs)do
march:createBehavior(nil,true)
end
end

function xianjieModel:clearAllResPointMarchBehaviour()
for key,march in pairs(_marchs)do
march:clearBehaviorEx()
end
end

function xianjieModel:getDZState_RPMarch(disguid_str,showDesc)
for key,data in pairs(_marchs)do
local discipleList=data:getMarchData("dDiscipleList")
for index,str in ipairs(discipleList)do
if str==disguid_str then
local desc
if showDesc then
desc='讨伐中'
end
return 2,desc
end
end
end
end

function xianjieModel:getAllResPointWaiPaiTeamHandle()
local list={}
local marchs=self:getAllResPointMarch()
for key,march in pairs(marchs)do
local type=march:getMarchData("dDataType")
if type~=xjResPointMarchTeamType.eData then
table.insert(list,march:getTeamHandle())
end
end
return list
end

function xianjieModel:checkMarchSoureCorrect(march)
local dSinceInfo=march:getMarchData("dSinceInfo")
local sceneidx=dSinceInfo[1]
local x=dSinceInfo[2]
local z=dSinceInfo[3]
local zmPos=xianjienSceneIndexType:isMoJie(sceneidx)and xianjieModel:getZongMenOutPos_mojie()or xianjieModel:getZongMenOutPos()

if zmPos~=nil and(sceneidx~=zmPos[1]or x~=zmPos[2]or z~=zmPos[3])then
dSinceInfo[1]=zmPos[1]
dSinceInfo[2]=zmPos[2]
dSinceInfo[3]=zmPos[3]
march:setMarchData("dSinceInfo",dSinceInfo)

local teamHandle=march:getTeamHandle()
teamHandle:clearMovePath()
local movePath=teamHandle:getMyMovePath(false)

local costDuration=march:getMarchData('dCostDuration')
local speedList=march:getMarchData('dSpeedList')
local speed=speedList[1].param_2
local wayTime=xianjieController:getMovePathWayTime(movePath,speed)
local battleTime=costDuration[2]
local nowTime=gameUtilityModel.getServerShortTime()
speedList[1].param_1=math.floor(nowTime-wayTime-battleTime)
costDuration[1]=wayTime
costDuration[3]=wayTime
march:setMarchData("dCostDuration",costDuration)
march:setMarchData("dSpeedList",speedList)

return true
end
return false
end

function xianjieModel:getResPointMarchTeamHandle(guid)
local march=self:getResPointMarch(guid)
if march then
return march:getTeamHandle()
end
end

function xianjieModel:getResPointMarchTeamState(guid)
local march=self:getResPointMarch(guid)
if march then
local teamHandle=march:getTeamHandle()
if teamHandle then
return teamHandle:getTeamState()
end
end
end


function xianjieModel:loadResPointPosRecord()
_clientPosData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianjiePoints,_clientPosKey,{})
end

function xianjieModel:clearResPointPosRecord()
_clientPosData=nil
end

function xianjieModel:checkResPointPosRecordValid()
for key,record in pairs(_clientPosData)do
local rpData=self:getResPointData(record.guid)
if rpData==nil then
_clientPosData[key]=nil
end
end
self:saveResPointPosRecord(true)
end

function xianjieModel:saveResPointPosRecord(atOnce)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianjiePoints,_clientPosKey,_clientPosData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianjiePoints,not atOnce)
end

function xianjieModel:getResPointPosRecord(rpGuid)
local key=tostring(rpGuid)
return _clientPosData[key]
end

function xianjieModel:addResPointPosRecord(rpGuid,sceneidx,gridX,gridZ)
local key=tostring(rpGuid)
_clientPosData[key]={guid=rpGuid,scene=sceneidx,x=gridX,z=gridZ}
self:saveResPointPosRecord()
end

function xianjieModel:deleteResPointPosRecord(rpGuid)
local key=tostring(rpGuid)
_clientPosData[key]=nil
self:saveResPointPosRecord()
end
