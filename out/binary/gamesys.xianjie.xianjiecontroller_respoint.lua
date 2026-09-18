local temp_37_61=nil
local _onClickHandle={
[XJ_ResPoint_TYPE.eMonster]=function(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
local winParams={
guid=rpGuid,
lookAtPos=rpData:getWorldPos(),
}
xianjieController:openWin('UIXianJie_RPMonsterWin',winParams)
end,
[XJ_ResPoint_TYPE.eEvent]=function(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
local rpCfg=rpData:getCfg()
local func=function()
local param={MysteryEventSendType.eXianJieResPoint,rpGuid}
MysteryEventSystem.event_start(SYSTEM_DEFINE.eFairyLandResource,rpCfg.event,{},param)
end
if rpCfg.story then

gameplotController:showPlotBoard({groupid=rpCfg.story,callback=func})
else
func()
end
end,
[XJ_ResPoint_TYPE.eNPC]=function(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
local rpCfg=rpData:getCfg()
local hasCost=rpCfg.cost and#rpCfg.cost>0
local callback=function(selectIdx)
if not hasCost or selectIdx==1 then
xianjieController:reqXianJieResPointHandle(rpGuid)
end
end
local tasklist=nil
if hasCost then
tasklist={taskItem=rpCfg.cost,finishselect=true,isfinishtask=true,isFullOpen=true,isfinishItem=true}
end
worldStoryController:showStoryTree(rpCfg.story,callback,nil,nil,tasklist)
end,
[XJ_ResPoint_TYPE.eMystery]=function(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
local rpCfg=rpData:getCfg()
local winParams={
id=rpCfg.mystery,
lookAtPos=rpData:getWorldPos(),
}
xianjieController:openWin("UIMysteryEnterWin",winParams)
end,
[XJ_ResPoint_TYPE.eCollectible]=function(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
if xianjieController:checkRPXiangBangPoint(rpData)then

local winParams={
guid=rpGuid,
lookAtPos=rpData:getWorldPos(),
}
xianjieController:openWin('UIXianJie_RPXBCollectWin',winParams)
else
xianjieController:reqXianJieResPointHandle(rpGuid)
end
end,
[XJ_ResPoint_TYPE.eCtCollectible]=function(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
local winParams={
guid=rpGuid,
lookAtPos=rpData:getWorldPos(),
}
xianjieController:openWin('UIXianJie_RPCtCollectWin',winParams)
end,
}

function xianjieController:onAppStart_ResPoint()
socketManager:register_receiver(37,61,self.recv_37_61)
socketManager:register_receiver(37,62,self.recv_37_62)
socketManager:register_receiver(37,63,self.recv_37_63)
socketManager:register_receiver(37,64,self.recv_37_64)
socketManager:register_receiver(37,65,self.recv_37_65)
socketManager:register_receiver(37,98,self.recv_37_98)
end

function xianjieController:onEnterState_ResPoint()
xianjieModel:loadResPointPosRecord()
end

function xianjieController:onLeaveState_ResPoint()
temp_37_61=nil
xianjieModel:clearAllResPointData()
xianjieModel:clearAllResPointMarch()
xianjieModel:clearResPointInit()
xianjieModel:clearResPointPosRecord()
xianjieModel:clearResPointCache()
end

function xianjieController:onProtocolReq_ResPoint()

local _marchs=xianjieModel:getAllResPointMarch()
local removes={}
for key,march in pairs(_marchs)do
local dDataType=march:getMarchData("dDataType")
if dDataType==xjResPointMarchTeamType.eData then
local rpData=xianjieModel:getResPointData(march.guid)
if rpData==nil then
table.insert(removes,{march.guid,""})
end
else
local teamHandle=march:getTeamHandle()
local state=teamHandle:getTeamState()
local flag=march:getMarchData("dHandleFlag")
if state==xjMarchTeamStateType.eNone and flag==1 then
table.insert(removes,{march.guid,""})
end
end
end
xianjieController:reqXianJieResPointMarchSaveList(removes)
xianjieModel:checkResPointPosRecordValid()
end

function xianjieController:onProtocolReqKF_ResPoint()
if temp_37_61 then
self.recv_37_61(temp_37_61[1],temp_37_61[2],temp_37_61[3],temp_37_61[4])
temp_37_61=nil
end
end

function xianjieController:onNormalUpdate_ResPoint(delay)
local datas=xianjieModel:getResPointCDLookup()
for key,flag in pairs(datas)do
local data=xianjieModel:getResPointDataImp(key)
self:onNormalUpdate_ResPointImp(data)
end
end

function xianjieController:onNormalUpdate_ResPointImp(data)
if not data.updataError and data.pcallUpdateExcuteFunc then
xpcall(data.pcallUpdateExcuteFunc,data.pcallUpdateCatchError)
end
end

function xianjieController:onEnterMap_ResPoint()

xianjieModel:reInitResPointCacheData()
xianjieModel:createAllResPointEnities(true)
xianjieModel:excuteAllResPointMarchBehaviour()
end

function xianjieController:onExitMap_ResPoint()
xianjieModel:removeAllResPointEnities()
xianjieModel:clearAllResPointMarchBehaviour()
end


function xianjieController:reqXianJieResPointHandle(guid,marchJson)
socketManager:send_37_63(guid,marchJson or"")
end

function xianjieController:send_37_98(guid,choice_id)
socketManager:send_37_98(guid,choice_id)
end


function xianjieController:reqXianJieResPointMarchSaveList(list)
if list and#list>0 then
socketManager:send_37_65(#list,list)
end
end

function xianjieController:reqXianJieResPointMarchSave(guid,json)
self:reqXianJieResPointMarchSaveList({{guid,json}})
end


function xianjieController.recv_37_61(dLen,datas,mLen,marchs)
if initProControl.isDoneKF()then
xianjieModel:clearAllResPointData()
xianjieModel:clearAllResPointMarch()

for i=1,dLen do
local data=datas[i]
local rpGuid=data.guid
local rpData={
rpGuid=data.guid,
rpType=data.resourcetype,
rpId=data.resourceid,
endTime=data.end_time,
source=data.srcData,
posIdx=data.pos_idx,
}
xianjieModel:refreshResPointData(rpGuid,rpData,true)
end

for i=1,mLen do
local march=marchs[i]
local rpGuid=march.guid
local json=march.client_data
xianjieModel:refreshResPointMarch(rpGuid,json,true)
end

if xianjieModel:isInitScene()then
xianjieController:onEnterMap_ResPoint()
end
else
temp_37_61={dLen,datas,mLen,marchs}
end
end


function xianjieController.recv_37_62(len,datas)
for i=1,len do
local data=datas[i]
local rpGuid=data.guid
local rpData={
rpGuid=data.guid,
rpType=data.resourcetype,
rpId=data.resourceid,
endTime=data.end_time,
source=data.srcData,
posIdx=data.pos_idx
}
xianjieModel:refreshResPointData(rpGuid,rpData)
end
end


function xianjieController.recv_37_63(guid,res,json,len,reawards)
if res==1 then
local rpData=xianjieModel:getResPointData(guid)
if len>0 then
local drops={}
for i=1,len do
local drop=reawards[i]
table.insert(drops,{drop.param_1,drop.param_2})
end
rpData.drops=drops
end
if rpData.rpType==XJ_ResPoint_TYPE.eCollectible then
if xianjieController:checkRPXiangBangPoint(rpData)then

UIManager.info("采集完成")
local rpMarch=xianjieModel:getResPointMarch(guid)
if rpMarch then
if rpMarch.behaviorID then
local isReqData=rpMarch:getBehaviorData('isReqData')
if isReqData then
rpMarch:setBehaviorData('isReqData',nil)
rpMarch:setBehaviorData('isGotoOver',true)
xjBehaviorManager:triggerUpdate(rpMarch.behaviorID)
end
end
end
end
rpData:removeEntity(true)
end
xianjieModel:refreshResPointData(guid,nil,false)
end
end


function xianjieController.recv_37_64(len,guids)
for i=1,len do
local guid=guids[i]
xianjieModel:refreshResPointData(guid,nil,false)
end
end

function xianjieController.recv_37_65(len,marchs)
for i=1,len do
local march=marchs[i]
local rpGuid=march.guid
local json=march.client_data
xianjieModel:refreshResPointMarch(rpGuid,json,false)
end
end


function xianjieController.recv_37_98(guid,choice_id,res)
local rpData=xianjieModel:getResPointData(guid)
if rpData.rpType==XJ_ResPoint_TYPE.eCtCollectible then
rpData:removeEntity(false)
end
xianjieModel:refreshResPointData(guid,nil,false)
end

function xianjieController:doResPointMarchRetract(rpMarch)
local teamHandle=rpMarch:getTeamHandle()
local oTeamHanleID=rpMarch.teamHandleID
local movePath=teamHandle:getMyMovePath(false)
local bTime=teamHandle:getBeginTime()
local moveTagList=teamHandle:getMoveTagList(movePath,bTime)
local moveTagIndex=xianjieController:getMoveTagListIndex(moveTagList)
local sceneidx,cpos,lerp_time,spos,epos,speed,isLast=xianjieController:getMoveTagLerpMovePos(moveTagList,moveTagIndex,true)
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(cpos.x,cpos.z,sceneidx)
local nowTime=gameUtilityModel.getServerShortTime2()
local dzList=rpMarch:getMarchData('dDiscipleList')
local zmData=xianjieModel:getMyZongMenData()
local movePath=xianjieController:getMovePath(sceneidx,gridX,gridZ,zmData.sceneidx,zmData.gridX,zmData.gridZ)
local duration=xianjieController:getMovePathWayTime(movePath,speed)
local retractData={
['dDataType']=xjResPointMarchTeamType.eRetract,
['dSpeedList']={{param_1=nowTime,param_2=speed},},
['dSinceInfo']={sceneidx,gridX,gridZ,1,1},
['dTargetInfo']={zmData.sceneidx,zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight,0},
['dHandleFlag']=0,
['dDiscipleList']=dzList,
['dCostDuration']={duration},
['dFightMap']=0,
}
rpMarch:refreshData(retractData)
xianjieController:reqXianJieResPointMarchSave(rpMarch.guid,rpMarch.marchJson)

rpMarch:clearBehaviorEx()
rpMarch:clearTeamHandle()
rpMarch:initTeamHandle()
rpMarch:createBehavior(sceneidx,true)

if oTeamHanleID~=rpMarch.teamHandleID then
teamHandle=rpMarch:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,oTeamHanleID)
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end

local rpData=xianjieModel:getResPointData(rpMarch.guid)
xianjieController:checkRPCtPoint(rpData)
end

function xianjieController:doResPointMarchCreate(rpData,selectList,dDataType)
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,tostring(v[2]))
end
local rpCfg=rpData:getCfg()
local nowTime=gameUtilityModel.getServerShortTime()
local speed=rpData.defaultSpeed
local zmData=xianjieModel:getMyZongMenData()
local wayTime=rpData:getBaseWayTime(speed)
local battleTime=rpCfg.battleTime or xianjieModel:getPlotBattleTime()
local dataType=dDataType or xjResPointMarchTeamType.eNormal
local mapId=nil
if rpData.rpType==XJ_ResPoint_TYPE.eMonster then
mapId=cfgHelper.get2(cfg_monstergroup_get,rpCfg.monster_id,"mapId")
end
local data={
['dDataType']=dataType,
['dSpeedList']={{param_1=nowTime,param_2=speed},},
['dSinceInfo']={zmData.sceneidx,zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight},
['dTargetInfo']={rpData.sceneidx,rpData.gridX,rpData.gridZ,rpData.gridWidth,rpData.gridHeight,rpData.endTime},
['dHandleFlag']=0,
['dDiscipleList']=dzlist,
['dCostDuration']={wayTime,battleTime,wayTime},
['dFightMap']=mapId,
}
local json=jsonHelper.encode(data)
xianjieController:reqXianJieResPointMarchSave(rpData.rpGuid,json)
end

function xianjieController:doResPointMarchDelete(rpGuid)
xianjieController:reqXianJieResPointMarchSave(rpGuid,"")
end

function xianjieController:markResPointMysteryJson(mystery,selectList)
local mysteryRPDatas=xianjieModel:getResPointDatasByType(XJ_ResPoint_TYPE.eMystery)
local rpData=xianjieModel:findResPointDataByMysteryID(mystery)
if rpData==nil then return end

local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,tostring(v[2]))
end
local data={
['dDataType']=xjResPointMarchTeamType.eData,
['dDiscipleList']=dzlist,
}
local json=jsonHelper.encode(data)
xianjieController:reqXianJieResPointMarchSave(rpData.rpGuid,json)
end

function xianjieController:clearResPointMysteryJson(mystery)
local rpData=xianjieModel:findResPointDataByMysteryID(mystery)
if rpData==nil then return end
xianjieController:doResPointMarchDelete(rpData.rpGuid)
end

function xianjieController:onClickResPoint(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
if rpData then
_onClickHandle[rpData.rpType](rpGuid)
end
end

function xianjieController:deleteAllMarchErrorSoureInfo()
local zmPos=xianjieModel:getZongMenOutPos()
local marchs=xianjieModel:getAllResPointMarch()
for key,march in pairs(marchs)do
local teamHandle=march:getTeamHandle()
local dSinceInfo=march:getMarchData("dSinceInfo")
local sceneidx=dSinceInfo[1]
local x=dSinceInfo[2]
local z=dSinceInfo[3]
if sceneidx~=zmPos[1]or x~=zmPos[2]or z~=zmPos[3]then
if teamHandle.teamType==xjTeamHandleType.eResPointReract then
xianjieController:doResPointMarchDelete(march.guid)
elseif teamHandle.teamType==xjTeamHandleType.eResPointTeam then
local state=teamHandle:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
xianjieController:doResPointMarchDelete(march.guid)
end
end
end
end
end


function xianjieController:checkRPXiangBangPoint(rpData)
if rpData then
if rpData.source.srctype==xjResPointSourceType.eXianBangTask then
return true
end
end
return false
end


function xianjieController:testprintResPoint(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
if rpData then
UIManager.info(FMT.fmt("{0}、{1},{2}",rpGuid,rpData.gridX,rpData.gridZ))

else

end
end

function xianjieController:testprintResPointdata(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
if rpData then
UIManager.info(FMT.fmt("{0}、{1},{2}",rpGuid,rpData.gridX,rpData.gridZ))

else

end
end

function xianjieController:testprintResPointxb(srctype)
local list=xianjieModel:getResPointDatasBySource(srctype)
local sceneidx
local lists={}
for index,data in ipairs(list)do
if sceneidx==nil or data.sceneidx==sceneidx then
table.insert(lists,data)
end
end

end


function xianjieController:checkRPCtPoint(rpData)
if rpData.source and rpData.source.srctype==xjResPointSourceType.eXianBangTask then
local taskid=rpData.source.taskid
if taskid then
xianjiexianbangController:send_37_85(taskid,0)
end
end
end
