
lingShouAIManager=gameState.addListener({})


local _s_move_check_id=5
local _s_path_check_id=6


local _b_move_check_id=8
local _b_path_check_id=5

local needInitEmptyPosBuildingEventLookup={
[buildingEvent.buildStart]=true,
[buildingEvent.moveBuilding]=true,
[buildingEvent.removeBuilding]=true,
[buildingEvent.storageBuilding]=true,
[buildingEvent.placeBuilding]=true,
}

function lingShouAIManager:onAppStart()

end

function lingShouAIManager:onEnterState(isReconnect)
if isReconnect then
return
end
self.lingShouSceneData={}
self.EIDToGUID={}
self.lsNextVisitTimeList={}
self.shouLanLsNextFreeTimeList={}
self.shouLanLsFreeCountList={}
self.waitAddLookup={}
self.waitRemoveLookup={}
self.lsdAreaEmptyPosList={}

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function lingShouAIManager:onLeaveState(isReconnect)
if isReconnect then
return
end

self.lingShouSceneData=nil
self.EIDToGUID=nil
self.lsNextVisitTimeList=nil
self.shouLanLsNextFreeTimeList=nil
self.shouLanLsFreeCountList=nil
self.waitAddLookup=nil
self.waitRemoveLookup=nil
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function lingShouAIManager.on_home_event(etype)
if etype==homeEvent.eEnterHome then
lingShouAIManager:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
lingShouAIManager:onLeaveHome()
end
end

function lingShouAIManager:onEnterHome()
self.pickUpTarget=-1
self.pickUpTarget_bdEID=-1

timeEventController.addNormalTimerHandler(1,'lingShouAIManager',self)
end

function lingShouAIManager:onLeaveHome()
self:removeAllSceneLingShou()

self.lingShouSceneData={}
self.EIDToGUID={}
self.lsNextVisitTimeList={}
self.shouLanLsNextFreeTimeList={}
self.shouLanLsFreeCountList={}
self.waitAddLookup={}
self.waitRemoveLookup={}

timeEventController.removeNormalTimerHandler(1,'lingShouAIManager')
end

function lingShouAIManager.on_building_event(etype,sfId,ubdId,arg1,arg2,arg3,arg4)
if sfId~=mapIdType.lingshoudao then return end
if needInitEmptyPosBuildingEventLookup[etype]then
lingShouAIManager:clearLSDAreaEmptyPosList()
end
end

function lingShouAIManager:onNormalUpdate(delay)
local time=gameUtilityModel.getServerShortTime()
end

function lingShouAIManager:init()

self.birthPoints=self:getBirthPointList()
self:addAllLingShouToScene(true)
feedingSystem:addAllMonsterData()
UIShouLanControl:addAllMenberToShouLan()
UIShouLanControl:refreshAllShouLanDecorate()








end

function lingShouAIManager:handleAddLingShou(data)
if mountainControl:isLoaded(mapIdType.lingshoudao)then
self:addALingShouToScene(data.guid,data.cfg.model)

end
end

function lingShouAIManager:handleRemoveLingShou(lsGuid)
if mountainControl:isLoaded(mapIdType.lingshoudao)then
self:removeALingShouSceneFormScene(lsGuid)

end
end

function lingShouAIManager:getBirthPointList()
local birthPoints=self.mapBirthPointDatas
if birthPoints then
return birthPoints
end
local aicfg=cfgHelper.get1(cfg_lingshouaiconfig_get,1)
birthPoints={}
local mapId=mapIdType.lingshoudao
for i,v in ipairs(aicfg.birthPoint)do
local pos=_MapManager.ToVector3Int(v[1],v[2],0)
local areaId=_MapManager.GetAreaID(mapId,pos)
if zongmenModel:isAreaUnlock(areaId)then
table.insert(birthPoints,v)
end
end

self.mapBirthPointDatas=birthPoints
return birthPoints
end

function lingShouAIManager:getSceneShowLingShouList(isReset)
if not isReset and self.sceneShowLsList and next(self.sceneShowLsList)then
return self.sceneShowLsList
end

local maxShowCount=self:getLsCreateLimit()
local datas=lingshouModel:getLingShouDatas()
local lsCount=lingshouModel:getLSCount()
local showList={}
if lsCount<=maxShowCount then
showList=datas
else
local sortList={}
for guid_str,v in pairs(datas)do
local lsId=v.id
local color=v.cfg.color
local lsData={
guid_str=guid_str,

lsId=lsId,
color=color,
}
sortList[#sortList+1]=lsData
end
if#sortList>1 then
table.sort(sortList,function(a,b)
if a.color==b.color then
return a.lsId<b.lsId
else
return a.color>b.color
end
end)
end
for i=1,maxShowCount do
local sortData=sortList[i]
if sortData then
local guid_str=sortData.guid_str


showList[guid_str]=sortData
end
end
end
self.sceneShowLsList=showList
return self.sceneShowLsList
end

function lingShouAIManager:getLsCreateLimit()
local key
if webGLHelper:isWebGLOptimization()then
key='create_limit_webgl'
else
key='create_limit'
end
local limit=cfgHelper.get2(cfg_lingshouaiconfig_get,1,key)
return limit
end

function lingShouAIManager:getLsTimeOutLimit()
local time=cfgHelper.get2(cfg_lingshouaiconfig_get,1,"move_time_out")
return time
end

function lingShouAIManager:addAllLingShouToScene(isInit)
local datas=lingShouAIManager:getSceneShowLingShouList(isInit)
for guid_str,v in pairs(datas)do
local model=lingshouModel:getLingShouModel(guid_str)
if model then
self:addALingShouToScene(guid_str,model)
end
end
end

function lingShouAIManager:addALingShouToScene(ls_guid,model)
local ls_guid_str=tostring(ls_guid)
local pos=self:getABirthPoint()
local guid,bt=self:createALingShou(ls_guid_str,model,pos)
bt:setSharedVar('moveCheckId',_s_move_check_id)
bt:setSharedVar('pathCheckId',_s_path_check_id)
local data={lsGuidStr=ls_guid_str,stId=guid,bt=bt}
local lsData=lingshouModel:getLingShouData2(ls_guid_str)
local lsId=lsData and lsData.id
local lsRace=lsData and lsData.cfg and lsData.cfg.race
data.lsId=lsId
data.lsRace=lsRace
self.lingShouSceneData[ls_guid_str]=data
self.EIDToGUID[guid]=ls_guid_str
end

function lingShouAIManager:addALingShouSceneData(ls_guid)
local ls_guid_str=tostring(ls_guid)
local data={lsGuidStr=ls_guid_str}
self.lingShouSceneData[ls_guid_str]=data
end

function lingShouAIManager:removeAllSceneLingShou()
for k,v in pairs(self.lingShouSceneData)do
self:removeASceneLingShou(v)
end
end

function lingShouAIManager:removeASceneLingShou(lsSceneData)
behaviorManager:removeBehaviorTree(lsSceneData.bt)
_MapManager.RemoveTilemapObject(lsSceneData.stId)
end

function lingShouAIManager:removeALingShouSceneFormScene(ls_guid)
local ls_guid_str=tostring(ls_guid)
local data=self.lingShouSceneData[ls_guid_str]
if data then
self:removeASceneLingShou(data)
self.EIDToGUID[data.stId]=nil
end
self.lingShouSceneData[ls_guid_str]=nil
end

function lingShouAIManager:removeALingShouSceneData(ls_guid)
local ls_guid_str=tostring(ls_guid)
self.lingShouSceneData[ls_guid_str]=nil
end

function lingShouAIManager:getABirthPoint()
local bp=self.birthPoints[math.random(1,#self.birthPoints)]
local spos=_MapManager.ToVector3Int(bp[1],bp[2],0)
local pos=_MapManager.RandomANearbyPosition(mapIdType.lingshoudao,spos,bp[3],-1)
return pos
end

function lingShouAIManager:createALingShou(ls_guid_str,model,pos)
local scale=isometricMapSystem:getModelScale(model)
local isCanFly=false
local guid=isometricMapSystem:createLingShouRoleEntity(objectType.eLingShou,mapIdType.lingshoudao,1116,model,nil,
SortingLayers.ITBuilding,scale,pos,nil,true,isCanFly)

local timeOutLimit=self:getLsTimeOutLimit()
local initData={
stId=guid,
show_hud=false,
cmdId=-1,
timeOutLimit=timeOutLimit,
moveCheckId=_s_move_check_id,
pathCheckId=_s_path_check_id,
}
local bt=behaviorManager:addBehaviorTree('ai_ls_scene_common',{stId=guid},true,initData)
return guid,bt
end

function lingShouAIManager:setSceneLingShouBt(stId)
local timeOutLimit=self:getLsTimeOutLimit()
local initData={
stId=stId,
show_hud=false,
cmdId=-1,
timeOutLimit=timeOutLimit,
moveCheckId=_s_move_check_id,
pathCheckId=_s_path_check_id,
}
local bt=behaviorManager:addBehaviorTree('ai_ls_scene_common',{stId=stId},true,initData)
return stId,bt
end

function lingShouAIManager:createAFollowLingShou(ls_guid_str,model,pos,mapId,discipleGuid,waitTime)
local scale=isometricMapSystem:getModelScale(model)
local isCanFly=false
local guid=isometricMapSystem:createLingShouRoleEntity(objectType.eLingShou,mapId,1116,model,nil,
SortingLayers.ITBuilding,scale,pos,nil,true,isCanFly)
local dzGuidStr=tostring(discipleGuid)
local lsAIWalkCfg=cfgHelper.get(cfg_lsaiidlewalkconfig_get,3)
local speakRate=lsAIWalkCfg.speakrate
local mov_min_time=lsAIWalkCfg.minTime
local mov_max_time=lsAIWalkCfg.maxTime
local moverate=lsAIWalkCfg.moverate
local spk_min_time=lsAIWalkCfg.spk_min_time
local spk_max_time=lsAIWalkCfg.spk_max_time
local range=lsAIWalkCfg.range
local cpos=pos
local initData={
stId=guid,
dzId=discipleGuid,
dzGuidStr=dzGuidStr,
show_hud=false,
speakRate=speakRate,
mov_min_time=mov_min_time,
mov_max_time=mov_max_time,
moverate=moverate,
spk_min_time=spk_min_time,
spk_max_time=spk_max_time,
range=range,
cpos=cpos,
waitTime=waitTime,
}

_MapManager.SetColor(guid,Color.New(1,1,1,0))
local bt=behaviorManager:addBehaviorTree('ai_ls_follow',{stId=guid},true,initData)
return guid,bt
end

function lingShouAIManager:getLingShouSceneData(lsGuid)
local lsGuidStr=tostring(lsGuid)
return self.lingShouSceneData[lsGuidStr]
end

function lingShouAIManager:getLingShouSceneDataByEID(eId)
local mId=self.EIDToGUID[eId]
return self.lingShouSceneData[mId]
end

function lingShouAIManager:addToBuilding(bdData,lsGuid)
local eId=bdData.entityId
local lsdata=self:getLingShouSceneData(lsGuid)
if not lsdata then
return
end
local mapId=_MapManager.GetObjectMapID(eId)
local pos=_MapManager.GetTilemapObjectPosition(lsdata.stId)
local lsGuidStr=lsdata.lsGuidStr
local waitAdd=self.waitAddLookup[lsGuidStr]or false
if not waitAdd or not _MapManager.IsCanMove(mapId,pos,8)or not feedingSystem:isInBuildingArea(bdData,pos)then
local tpos=_MapManager.GetAPosCanPutDownInLayoutBuilding(eId,8)
_MapManager.SetPosition(lsdata.stId,tpos)
end
local bt=lsdata.bt
_MapManager.SetSortingLayer(lsdata.stId,SortingLayers.ITGrid2)
bt:broke()
bt:setSharedVar('moveCheckId',_b_move_check_id)
bt:setSharedVar('pathCheckId',_b_path_check_id)
bt:setSharedVar('cmdId',-1)
bt:reset()
_MapManager.AddMemberToLayoutBuilding(eId,lsdata.stId)
lsdata.home=eId
lsdata.home_ubdId=bdData.un_build_id

local buildId=bdData.build_id
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
local ptype=bdCfg and bdCfg.win_type or nil
lsdata.isInShouLan=ptype==sysWinType.eShouLan


lsdata.isInShouLanFree=false
self.shouLanLsFreeCountList[lsGuidStr]=nil
self.shouLanLsNextFreeTimeList[lsGuidStr]=nil

feedingSystem:lsSceneDataAddToBuilding(bdData,lsGuid,lsdata)

self.waitAddLookup[lsGuidStr]=nil
end


function lingShouAIManager:addEntityToBuilding(bdData,lsGuid,tpos)
local eId=bdData.entityId
local lsdata=self:getLingShouSceneData(lsGuid)
if not lsdata then
return
end
local mapId=_MapManager.GetObjectMapID(eId)
local pos=_MapManager.GetTilemapObjectPosition(lsdata.stId)
local lsGuidStr=lsdata.lsGuidStr
local waitAdd=self.waitAddLookup[lsGuidStr]or false
if not waitAdd or not _MapManager.IsCanMove(mapId,pos,8)or not feedingSystem:isInBuildingArea(bdData,pos)then
tpos=tpos or _MapManager.GetAPosCanPutDownInLayoutBuilding(eId,8)
_MapManager.SetPosition(lsdata.stId,tpos)
end
local bt=lsdata.bt
_MapManager.SetSortingLayer(lsdata.stId,SortingLayers.ITGrid2)
bt:setSharedVar('moveCheckId',_b_move_check_id)
bt:setSharedVar('pathCheckId',_b_path_check_id)
bt:setSharedVar('cmdId',-1)

_MapManager.AddMemberToLayoutBuilding(eId,lsdata.stId)

self.waitAddLookup[lsGuidStr]=nil
end


function lingShouAIManager:removeFormBuilding(eId,lsGuid)
local lsdata=self:getLingShouSceneData(lsGuid)
if not lsdata then
return
end
local mapId=_MapManager.GetObjectMapID(eId)
local pos=_MapManager.GetTilemapObjectPosition(lsdata.stId)
local lsGuidStr=lsdata.lsGuidStr
local waitRemove=self.waitRemoveLookup[lsGuidStr]or false
if not waitRemove or not _MapManager.IsCanMove(mapId,pos)then
self:moveToBuildingNearbySpace(eId,lsdata.stId)
end
local bt=lsdata.bt
_MapManager.SetSortingLayer(lsdata.stId,SortingLayers.ITBuilding)
bt:broke()
bt:setSharedVar('moveCheckId',_s_move_check_id)
bt:setSharedVar('pathCheckId',_s_path_check_id)
bt:setSharedVar('cmdId',-1)
bt:reset()
_MapManager.RemoveMemberFormLayoutBuilding(eId,lsdata.stId)
lsdata.home=nil
lsdata.home_ubdId=nil
lsdata.isInShouLan=nil
feedingSystem:lsSceneDataRemoveFormBuilding(eId,lsGuid)

self.waitRemoveLookup[lsGuidStr]=nil
end


function lingShouAIManager:removeEntityFormBuilding(eId,lsGuid)
local lsdata=self:getLingShouSceneData(lsGuid)
if not lsdata then
return
end
local mapId=_MapManager.GetObjectMapID(eId)
local pos=_MapManager.GetTilemapObjectPosition(lsdata.stId)
local lsGuidStr=lsdata.lsGuidStr
local waitRemove=self.waitRemoveLookup[lsGuidStr]or false
if not waitRemove or not _MapManager.IsCanMove(mapId,pos)then

local ubdId=lsdata.home_ubdId
if ubdId then
local bdData=zongmenModel:getBuildingData(ubdId)
local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
_MapManager.SetPosition(lsdata.stId,tpos)
else
self:moveToBuildingNearbySpace(eId,lsdata.stId)
end
end
local bt=lsdata.bt
_MapManager.SetSortingLayer(lsdata.stId,SortingLayers.ITBuilding)
bt:setSharedVar('moveCheckId',_s_move_check_id)
bt:setSharedVar('pathCheckId',_s_path_check_id)
bt:setSharedVar('cmdId',-1)
_MapManager.RemoveMemberFormLayoutBuilding(eId,lsdata.stId)

self.waitRemoveLookup[lsGuidStr]=nil
end

function lingShouAIManager:setSceneLsWaitRemoveFlag(lsGuidStr,flag)
self.waitRemoveLookup[lsGuidStr]=flag
end

function lingShouAIManager:getSceneLingShouBtNextCMDId(stId)
local cmdId=0
local lsSceneData=lingShouAIManager:getLingShouSceneDataByEID(stId)
if lsSceneData then

local nowTime=timeHelper.getServerShortTime()
local lsGuidStr=lsSceneData.lsGuidStr
local isShouLanFreeLs=lsSceneData.isInShouLanFree or false
local lsAIBaseCfg=cfgHelper.get(cfg_lingshouaiconfig_get,1)
if lsSceneData.home and not isShouLanFreeLs then

local isShouLanLs=lsSceneData.isInShouLan
if isShouLanLs then

local nextFreeTime=self.shouLanLsNextFreeTimeList[lsGuidStr]
if not nextFreeTime then

local freeCdCfg=lsAIBaseCfg.slFreeCd
local cdTime=math.random(freeCdCfg[1],freeCdCfg[2])
nextFreeTime=nowTime+cdTime
self.shouLanLsNextFreeTimeList[lsGuidStr]=nextFreeTime
end

if nowTime>=nextFreeTime then

local freeWeight=lsAIBaseCfg.slFreeRate
local random=math.random(0,1)
if random<=freeWeight then

cmdId=4
end
end
end
else

local nextCanVisitTime=self.lsNextVisitTimeList[lsGuidStr]or 0
if nowTime>=nextCanVisitTime then
if isShouLanFreeLs then

cmdId=1
else

local visitWeight=lsAIBaseCfg.freeLsVisitRate
local random=math.random(0,1)
if random<=visitWeight then
local halfWeight=visitWeight/2
if random<=halfWeight then

cmdId=5
else

cmdId=1
end
end
end
end
end
end

return cmdId
end

function lingShouAIManager:setSceneLingShouBtNextCMD(stId)
local cmdId=self:getSceneLingShouBtNextCMDId(stId)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
local bt=lsSceneData.bt

if cmdId==0 then
local isShouLanLs=lsSceneData.isInShouLan
local aiWalkId=1
if isShouLanLs then
aiWalkId=2
end
local lsAIWalkCfg=cfgHelper.get(cfg_lsaiidlewalkconfig_get,aiWalkId)
local minTime=lsAIWalkCfg.minTime
local maxTime=lsAIWalkCfg.maxTime
local speakrate=lsAIWalkCfg.speakrate
local spk_min_time=lsAIWalkCfg.spk_min_time
local spk_max_time=lsAIWalkCfg.spk_max_time
local moveRange=lsAIWalkCfg.moveRange
local moverate=lsAIWalkCfg.moverate

bt:setSharedVar('minTime',minTime)
bt:setSharedVar('maxTime',maxTime)
bt:setSharedVar('speakrate',speakrate)
bt:setSharedVar('spk_min_time',spk_min_time)
bt:setSharedVar('spk_max_time',spk_max_time)
bt:setSharedVar('moveRange',moveRange)
bt:setSharedVar('moverate',moverate)
end
bt:setSharedVar('cmdId',cmdId)
end

function lingShouAIManager:getSceneLingShouVisitPosList(ignorePosId)
local mapId=mapIdType.lingshoudao
local cfgs=cfg_lsaifangwendidianconfig()
local rlist={}
for i,v in ipairs(cfgs)do
if v.id~=ignorePosId then
local spos=_MapManager.ToVector3Int(v.pos[1],v.pos[2],0)
local isCanMove=_MapManager.IsCanMove(mapId,spos,5)
if isCanMove then
table.insert(rlist,v)
end
end
end
return rlist
end

function lingShouAIManager:setSceneLingShouVisitPos(stId,posId)
local lastPosId=posId or nil
local clist=self:getSceneLingShouVisitPosList(lastPosId)
local cfg=clist[math.random(1,#clist)]
if not cfg then
return
end
local spos=_MapManager.ToVector3Int(cfg.pos[1],cfg.pos[2],0)

local mapId=mapIdType.lingshoudao





local newPosId=cfg.id
local tpos=_MapManager.RandomANearbyPosition(mapId,spos,cfg.radius)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
local bt=lsSceneData.bt
local speakRate=cfg.speakrate
bt:setSharedVar('targetPos',tpos)
bt:setSharedVar('speakrate',speakRate)
bt:setSharedVar('mapId',mapId)
bt:setSharedVar('posId',newPosId)
end


function lingShouAIManager:getSceneLingShouSpeak(stId,cmdId,args1)
local speakLib
local speakStr=""
local lsSceneData=self:getLingShouSceneDataByEID(stId)
local lsRace=lsSceneData.lsRace
local lsAIBaseCfg=cfgHelper.get(cfg_lingshouaispeaklibconfig_get,lsRace)
if lsSceneData then
local bt=lsSceneData.bt
if cmdId==0 then


local isShouLanFreeLs=lsSceneData.isInShouLanFree or false
local isShouLanLs=lsSceneData.isInShouLan
if isShouLanLs and not isShouLanFreeLs then

speakLib=lsAIBaseCfg.slIdleSpeakLib
else

speakLib=lsAIBaseCfg.idleSpeakLib
end

elseif cmdId==1 then

local posId=args1

local libCfg=lsAIBaseCfg.visitPosSpeakLib
if libCfg then
if libCfg[posId]then
speakLib=libCfg[posId]
else

speakLib=libCfg[-1]
end
end





elseif cmdId==5 then

speakLib=lsAIBaseCfg.idleSpeakLib
end

if speakLib then
local count=#speakLib
if count>1 then
local random=math.random(1,#speakLib)
speakStr=speakLib[random]
else
speakStr=speakLib[1]
end
else
logErr(FMT.fmt("找不到对应灵兽说话库配置, cmdId={0}, args1={1}",cmdId,args1))
end

bt:setSharedVar('speakStr',speakStr)
end

end

function lingShouAIManager:onSceneLingShouFinishVisit(stId,isSetNextCmd)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
if lsSceneData then
local lsGuidStr=lsSceneData.lsGuidStr
local cdRange=cfgHelper.get2(cfg_lingshouaiconfig_get,1,"freeLsVisitCd")
local cdTime=math.random(cdRange[1],cdRange[2])
local nowTime=timeHelper.getServerShortTime()
local nextCanVisitTime=nowTime+cdTime
self.lsNextVisitTimeList[lsGuidStr]=nextCanVisitTime
local isShouLanFreeLs=lsSceneData.isInShouLanFree or false
if isShouLanFreeLs then
local remainingCount=self.shouLanLsFreeCountList[lsGuidStr]or 0
remainingCount=remainingCount-1
if remainingCount>0 then
self.shouLanLsFreeCountList[lsGuidStr]=remainingCount
else

self.shouLanLsFreeCountList[lsGuidStr]=nil
if isSetNextCmd then

self:setLsEntityMoveToBuildCMD(stId)
return
end
end
end

if isSetNextCmd then
self:setSceneLingShouBtNextCMD(stId)
end
end
end

function lingShouAIManager:onSceneLsFinishMoveToBd(stId,posId,isSetNextCmd)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
if lsSceneData then
local lsGuidStr=lsSceneData.lsGuidStr
local ubdId=lsSceneData.home_ubdId
if ubdId then
local bdData=zongmenModel:getBuildingData(ubdId)
local insideDoorPos=isometricMapSystem:getDoorWayPos_ShouLanInside(bdData)
self:addEntityToBuilding(bdData,lsGuidStr,insideDoorPos)

lsSceneData.isInShouLanFree=false
end

if isSetNextCmd then
self:setSceneLingShouBtNextCMD(stId)
end
end
end

function lingShouAIManager:onSceneLsStartLeaveBd(stId)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
if lsSceneData then
local lsGuidStr=lsSceneData.lsGuidStr
local bdEntityId=lsSceneData.home
self:removeEntityFormBuilding(bdEntityId,lsGuidStr)
lsSceneData.isInShouLanFree=true

local countRange=cfgHelper.get2(cfg_lingshouaiconfig_get,1,"slLsVisitCount")
local randomCount=math.random(countRange[1],countRange[2])
self.shouLanLsFreeCountList[lsGuidStr]=randomCount
self.shouLanLsNextFreeTimeList[lsGuidStr]=nil

local cmdId=1
local bt=lsSceneData.bt
bt:setSharedVar('cmdId',cmdId)
end
end

function lingShouAIManager:moveToBuildingNearbySpace(bstId,mstId)
local plist
if _s_move_check_id then
plist=_MapManager.GetPlaceObjectNearbySpace(bstId,1,_s_move_check_id)
else
plist=_MapManager.GetPlaceObjectNearbySpace(bstId,1)
end

if plist then
local tpos=plist[math.random(0,plist.Count-1)]
_MapManager.SetPosition(mstId,tpos)
else
local tpos=_MapManager.GetTilemapObjectPosition(bstId)
_MapManager.SetPosition(mstId,tpos)
end
end

function lingShouAIManager:setLsEntityMoveToBuildCMD(stId)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
if lsSceneData then
local cmdId=2
local bt=lsSceneData.bt
local lsGuidStr=lsSceneData.lsGuidStr
local bdEntityId=lsSceneData.home
if bdEntityId then


local mapId=_MapManager.GetObjectMapID(bdEntityId)


local speakRate=0.5

bt:setSharedVar('speakrate',speakRate)
bt:setSharedVar('mapId',mapId)

bt:setSharedVar('cmdId',cmdId)
else

cmdId=-1
bt:setSharedVar('cmdId',cmdId)
end

end
end

function lingShouAIManager:setLsEntityBuildDoorPos(stId)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
if lsSceneData then
local bt=lsSceneData.bt
local lsGuidStr=lsSceneData.lsGuidStr
local bdEntityId=lsSceneData.home
local ubdId=lsSceneData.home_ubdId
local bdData=zongmenModel:getBuildingData(ubdId)
local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
local insideDoorPos=isometricMapSystem:getDoorWayPos_ShouLanInside(bdData)
bt:setSharedVar('outsideDoorPos',tpos)
bt:setSharedVar('insideDoorPos',insideDoorPos)
bt:setSharedVar('doorPos',dpos)
end
end

function lingShouAIManager:clearLSDAreaEmptyPosList()
self.lsdAreaEmptyPosList={}
end

function lingShouAIManager:initLSDAreaEmptyPosList(areaId)
local cfgId=5
local list=_MapManager.GetMapAreaPosByConfig(mapIdType.lingshoudao,areaId,cfgId,2)
self.lsdAreaEmptyPosList[areaId]=list or{}
end


function lingShouAIManager:getLSDAreaEmptyPosListArray(areaId)
if not self.lsdAreaEmptyPosList[areaId]then
self:initLSDAreaEmptyPosList(areaId)
end

local v3IntList=self.lsdAreaEmptyPosList[areaId]
local list={}
local posCount=v3IntList.Count
for i=1,posCount do
local pos=v3IntList[i-1]
local posArray=_MapManager.Vector3IntToArray(pos)
list[#list+1]=posArray
end
return list
end

function lingShouAIManager:randomAEmptyPosByAreaId(areaId,nowPos)
if not self.lsdAreaEmptyPosList[areaId]then
self:initLSDAreaEmptyPosList(areaId)
end


local checkIsSamePosFunc=function(tpos)
local isSamePos=_MapManager.IsPositionEqual(nowPos,tpos)
return isSamePos
end

local posList=self.lsdAreaEmptyPosList[areaId]
local posCount=posList.Count
if posCount>1 then
local maxRandomCount=20
for i=1,maxRandomCount do
local randomIdx=math.random(1,posCount)
local pos=posList[randomIdx-1]
local isSamePos=checkIsSamePosFunc(pos)
if not isSamePos then
return pos
end
end
elseif posCount==1 then
local pos=posList[0]
local isSamePos=checkIsSamePosFunc(pos)
if not isSamePos then
return pos
end
end

return nil
end

function lingShouAIManager:setSceneLingShouVisitRandomEmptyPos(stId)
local mapId=mapIdType.lingshoudao
local nowPos=_MapManager.GetTilemapObjectPosition(stId)
local areaId=_MapManager.GetAreaIDByObject(stId)
local tpos=self:randomAEmptyPosByAreaId(areaId,nowPos)
if not tpos then
tpos=_MapManager.RandomANearbyPosition(mapId,nowPos,5)
end

local lsAIWalkCfg=cfgHelper.get(cfg_lsaiidlewalkconfig_get,1)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
local bt=lsSceneData.bt
local speakRate=lsAIWalkCfg.speakrate
bt:setSharedVar('targetPos',tpos)
bt:setSharedVar('speakrate',speakRate)
bt:setSharedVar('mapId',mapId)
end

function lingShouAIManager:onLongTapStart(screenPoint,guid)
if isometricMapSystem:getLayoutMode()==layoutMode.eDefault then
local objType=_MapManager.GetObjectType(guid)
if objType==objectType.eLingShou then
self.pickUpTarget=guid
local data=self:getLingShouSceneDataByEID(guid)
local isInShouLan=data.isInShouLan or false
local isInShouLanFree=data.isInShouLanFree or false
local isInSLBuild=isInShouLan and not isInShouLanFree
if not isInSLBuild then
self.pickUpTargetSortLayout=SortingLayers.ITBuilding
_MapManager.SetSortingLayer(guid,SortingLayers.ITGrid2)
end
data.bt:broke()

self:setLingShouCatchShow(guid,true)

local pos=isometricMapSystem:screenToMapPos(screenPoint)
self.pickUpPos=pos
self.rcMPos=_MapManager.GetTilemapObjectPosition(data.stId)
isometricMapSystem:enterFeedingLayoutMode({lsdata=data})
isometricMapSystem:setOtherDragFlag(true)
end
end
end

function lingShouAIManager:onLongTapEnd(screenPoint)

end

function lingShouAIManager:onTouchDown(screenPoint)
if self.pickUpTarget>0 then
local pos=isometricMapSystem:screenToMapPos(screenPoint)
if not _MapManager.IsPositionEqual(pos,self.pickUpPos)then
self.pickUpPos=pos
_MapManager.SetPositionAndCentered(self.pickUpTarget,pos)

local mapId=zongmenModel:getMountainId()
local bdEID=_MapManager.GetCoverObjectByPos(mapId,self.pickUpPos)
if bdEID then
if bdEID~=self.pickUpTarget_bdEID and self.pickUpTarget_bdEID~=-1 then
local lastTargetBdEID=self.pickUpTarget_bdEID

_MapManager.SetColor(lastTargetBdEID,Color.New(1,1,1,1))

self.pickUpTarget_bdEID=-1
end

if bdEID~=-1 then
local bdData=zongmenModel:findBuildingByEntityId(bdEID)
if bdData then
local buildId=bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
local bdWinType=cfg and cfg.win_type or nil
if bdWinType==sysWinType.eShouLan then
self.pickUpTarget_bdEID=bdEID

_MapManager.SetColor(bdEID,Color.New(1,1,1,0.7))
end
end
end
end
end
end
end

function lingShouAIManager:onTouchUp(screenPoint,guid)
if self.pickUpTarget>0 then
if self.pickUpTargetSortLayout then
_MapManager.SetSortingLayer(self.pickUpTarget,self.pickUpTargetSortLayout)
self.pickUpTargetSortLayout=nil
end
local data=self:getLingShouSceneDataByEID(self.pickUpTarget)
local mapId=zongmenModel:getMountainId()
local bdEID=_MapManager.GetCoverObjectByPos(mapId,self.pickUpPos)



local initData={
data=data,
mapId=mapId,
bdEID=bdEID,
waitReq=false,
reason=0,
home=data.home,
}

behaviorManager:addBehaviorTree('bt_move_lingshou',nil,true,initData,true)


if self.pickUpTarget_bdEID~=-1 then
local lastTargetBdEID=self.pickUpTarget_bdEID

_MapManager.SetColor(lastTargetBdEID,Color.New(1,1,1,1))
self.pickUpTarget_bdEID=-1
end
end
end

function lingShouAIManager:setLingShouCatchShow(lsGuid,isCatch)
local data=self:getLingShouSceneDataByEID(lsGuid)
if not data or not data.stId then
return
end
local stId=data.stId
if isCatch then

_MapManager.SetColor(stId,Color.New(1,1,1,0.5))


self.catchLsEffect=_MapManager.PlayEffectOnActor(stId,10686,'root',Vector3.zero,Vector3.one)
else

_MapManager.SetColor(stId,Color.New(1,1,1,1))
if self.catchLsEffect then

_MapManager.RemoveEffectOnActor(stId,self.catchLsEffect)
self.catchLsEffect=nil
end
end
end

function lingShouAIManager:mls_check_remove(bt,data)
local bdData=zongmenModel:findBuildingByEntityId(data.home)
bt:setSharedVar('waiting',true)
local lsGuidStr=data.lsGuidStr
feedingSystem:checkAndRemoveLingShou(bdData.un_build_id,data.lsGuidStr,function(isOK)
lingShouAIManager:setSceneLsWaitRemoveFlag(lsGuidStr,true)
bt:setSharedVar('waiting',false)
bt:setSharedVar('canRemove',isOK)
end)
end

function lingShouAIManager:mls_handle_remove(bt,slId,data,bdEID,mapId)

bt:setSharedVar('waitReq',true)
end

function lingShouAIManager:mls_can_not_remove(bt,data)
_MapManager.SetPosition(data.stId,self.rcMPos)
data.bt:reset()
bt:setSharedVar('canAdd',false)
end

function lingShouAIManager:mls_req_add(bt,bdEID,data)
local bdData=zongmenModel:findBuildingByEntityId(bdEID)
local reason=feedingSystem:checkPutIn(bdData.un_build_id,data.lsGuidStr)
if reason==0 then
UIShouLanControl:reqAddToShouLan(bdData.un_build_id,1,{int64.new(data.lsGuidStr)})

self.waitAddLookup[data.lsGuidStr]=true
bt:setSharedVar('waitReq',true)
end
bt:setSharedVar('reason',reason)
end

function lingShouAIManager:mls_can_not_add(bdEID,mapId,data,needMove)
if needMove then
if bdEID==data.home then
local lsSceneData=self:getLingShouSceneDataByEID(data.stId)
local lsGuidStr=lsSceneData.lsGuidStr
local isShouLanFreeLs=lsSceneData and lsSceneData.isInShouLanFree or false
if isShouLanFreeLs then

local bt=lsSceneData.bt
bt:setSharedVar('moveCheckId',_b_move_check_id)
bt:setSharedVar('pathCheckId',_b_path_check_id)
_MapManager.AddMemberToLayoutBuilding(bdEID,data.stId)


lsSceneData.isInShouLanFree=false
self.shouLanLsFreeCountList[lsGuidStr]=nil
self.shouLanLsNextFreeTimeList[lsGuidStr]=nil
local cmdId=-1
bt:setSharedVar('cmdId',cmdId)
end
end
local pos=_MapManager.GetTilemapObjectPosition(data.stId)
local moveCheckId=data.bt:getSharedVar('moveCheckId')
local isCanMove
if moveCheckId then
isCanMove=_MapManager.IsCanMove(mapId,pos,moveCheckId)
else
isCanMove=_MapManager.IsCanMove(mapId,pos)
end
if not isCanMove then
_MapManager.SetPosition(data.stId,self.rcMPos)
end
else

if bdEID>0 then

self:moveToBuildingNearbySpace(bdEID,data.stId)
else

_MapManager.SetPosition(data.stId,self.rcMPos)
end
end

if not data.bt:isEnding()then
data.bt:broke()
end
data.bt:reset()
end

function lingShouAIManager:mls_check_canMoveIn(bt,data,bdEID,mapId,hasHome)
local bdData=zongmenModel:findBuildingByEntityId(bdEID)
local isShouLanBd=false
if bdData then
local buildId=bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
local bdWinType=cfg and cfg.win_type or nil
if bdWinType==sysWinType.eShouLan then
isShouLanBd=true
end
end
if isShouLanBd then
local reason=feedingSystem:checkPutIn(bdData.un_build_id,data.lsGuidStr)
if reason==0 then

if hasHome then
bt:setSharedVar('needRemove',true)
end
bt:setSharedVar('canAdd',true)
bt:setSharedVar('needMove',true)

local dataBt=data.bt
local cmdId=-1
dataBt:setSharedVar('cmdId',cmdId)
dataBt:broke()

elseif reason==1 then

UIManager.error('请先选择入驻弟子')
elseif reason==2 then

UIManager.error('兽栏已无法容纳该灵兽')
end
else
local pos=_MapManager.GetTilemapObjectPosition(data.stId)
local moveCheckId=data.bt:getSharedVar('moveCheckId')
local isCanMove
if moveCheckId then
isCanMove=_MapManager.IsCanMove(mapId,pos,moveCheckId)
else
isCanMove=_MapManager.IsCanMove(mapId,pos)
end

if isCanMove then

if hasHome then
return self:mls_check_isNeedMoveOut(bt,data,bdEID,mapId)
else
bt:setSharedVar('needMove',true)
end
end
end
end

function lingShouAIManager:mls_check_isNeedMoveOut(bt,data,bdEID,mapId)

local lsSceneData=self:getLingShouSceneDataByEID(data.stId)
local lsGuidStr=lsSceneData.lsGuidStr
local isShouLanFreeLs=lsSceneData and lsSceneData.isInShouLanFree or false
if isShouLanFreeLs then

bt:setSharedVar('needMove',true)
else

bt:setSharedVar('needRemove',true)
end
end

function lingShouAIManager:mls_end()
local stId=self.pickUpTarget
self.pickUpTarget=-1
self.pickUpPos=nil
self.rcMPos=nil
UILayoutControl:closeUI()
isometricMapSystem:setOtherDragFlag(false)

self:setLingShouCatchShow(stId,false)





end


function lingShouAIManager:handleLingShouAvoid(guid)
local posInfo=_MapManager.GetObjectPosInfo(guid)
local lsArr=self:findLingShowInRange(posInfo[1],posInfo[2],posInfo[1]+posInfo[4]-1,posInfo[2]+posInfo[5]-1)
if#lsArr>0 then
local posList=_MapManager.GetPlaceObjectNearbySpace(guid,3)
if posList.Count>0 then
local cfg=cfgHelper.get1(cfg_lsavoidaiconfig_get,1)
for i,v in ipairs(lsArr)do
local pos=_MapManager.GetTheNearestPosInList(v,posList)
local initData={
stId=v,
targetPos=pos,
speed=cfg.speed,
anim=cfg.anim,
speak_time_1=cfg.speak_time_1,
speak_skin_1=cfg.speak_skin_1,
speak_1=cfg.speak_1[math.random(1,#cfg.speak_1)],
speak_time_2=cfg.speak_time_2,
speak_skin_2=cfg.speak_skin_2,
speak_2=cfg.speak_2[math.random(1,#cfg.speak_2)],
}
local lsdata=self:getLingShouSceneDataByEID(v)
lsdata.bt:broke()
behaviorManager:addBehaviorTree('ai_ls_avoid',{stId=v},true,initData,true)
end
end
end
end

function lingShouAIManager:endLingShouAvoid(stId)
local lsdata=self:getLingShouSceneDataByEID(stId)
local bt=lsdata.bt
if not bt:isEnding()then
bt:broke()
end
local cmdId=-1
bt:setSharedVar('cmdId',cmdId)
bt:reset()
end

function lingShouAIManager:findLingShowInRange(x1,y1,x2,y2)
local pos1=_MapManager.ToVector3Int(x1,y1,0)
local pos2=_MapManager.ToVector3Int(x2,y2,0)
local idArr=_MapManager.GetObjectInRange(pos1,pos2,objectType.eLingShou)
local list={}
for i,v in ipairs(idArr)do
local lsdata=self:getLingShouSceneDataByEID(v)
if not lsdata.home then
table.insert(list,v)
end
end
return list
end

function lingShouAIManager:getPickUpTargetLsSceneData()
local stId=self.pickUpTarget
if stId then
local lsdata=self:getLingShouSceneDataByEID(stId)
return lsdata
end
end




function lingShouAIManager:testFunc_checkPosIdCanPass(posId)
local cfg=cfgHelper.get(cfg_aifangwendidianconfig_get,posId)
if not cfg then
return
end
local spos=_MapManager.ToVector3Int(cfg.pos[1],cfg.pos[2],0)
local mapId=cfg.mapId
local isCanMove=_MapManager.IsCanMove(mapId,spos,5)
local str=isCanMove and"可通行"or"不可通行"
UIManager.info(str)
end

function lingShouAIManager:testFunc_getEntityCanVisitPos(stId)
local lsSceneData=self:getLingShouSceneDataByEID(stId)
local bt=lsSceneData.bt
local posId=bt:getSharedVar('posId')
local cmd=bt:getSharedVar('cmdId')
local targetPos=bt:getSharedVar('targetPos')
local clist=self:getSceneLingShouVisitPosList(posId)
local cfg=clist[math.random(1,#clist)]
if not cfg then
return
end
end

function lingShouAIManager:testFunc_checkPosCanMove(bPosTable,ePosTable,cfgId)
local mapId=mapIdType.lingshoudao
cfgId=cfgId or _s_move_check_id
local bpos=_MapManager.ToVector3Int(bPosTable[1],bPosTable[2],0)
local epos=_MapManager.ToVector3Int(ePosTable[1],ePosTable[2],0)

local isCanMove=_MapManager.IsCanMoveTo(mapId,bpos,epos,cfgId)
local str=isCanMove and"可通行"or"不可通行"
UIManager.info(str)
end