






local _MODULENAME="xianJieCaravanEscortController"

gameState.addListener(def_table(_MODULENAME))
xianJieCaravanEscortController.name=_MODULENAME
xianJieCaravanEscortController.data={}

function xianJieCaravanEscortController:onAppStart()

xianJieCaravanEscortModel:onAppStart()



socketManager:register_receiver(35,243,xianJieCaravanEscortController.recv_35_243)
socketManager:register_receiver(35,244,xianJieCaravanEscortController.recv_35_244)
socketManager:register_receiver(35,245,xianJieCaravanEscortController.recv_35_245)
socketManager:register_receiver(35,246,xianJieCaravanEscortController.recv_35_246)
socketManager:register_receiver(35,247,xianJieCaravanEscortController.recv_35_247)
socketManager:register_receiver(35,248,xianJieCaravanEscortController.recv_35_248)
socketManager:register_receiver(35,249,xianJieCaravanEscortController.recv_35_249)
socketManager:register_receiver(35,250,xianJieCaravanEscortController.recv_35_250)






end


function xianJieCaravanEscortController:onEnterState(isReconnect)
xianJieCaravanEscortModel:onEnterState()
self.isAddingShowShip=nil
notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.onLeaveXianJie)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onXJCaravanEscortSelfShipFinish,self.onXJCaravanEscortSelfShipFinish)
notifySystem:listenNotify(notifyConfig.onXJCaravanEscortCanDispatchTimeEnd,self.onXJCaravanEscortCanDispatchTimeEnd)
notifySystem:listenNotify(notifyConfig.onXJCaravanEscortRobCountChange,self.onXJCaravanEscortRobCountChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
end


function xianJieCaravanEscortController:onProtocolReq()
xianJieCaravanEscortModel:onProtocolReq()
end


function xianJieCaravanEscortController:onLeaveState(isReconnect)
xianJieCaravanEscortModel:onLeaveState(isReconnect)
self:clearSelfShipPosEndTimer()

self.data={}
self.isAddingShowShip=nil
notifySystem:removelistener(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:removelistener(notifyConfig.leaveXianJie,self.onLeaveXianJie)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onXJCaravanEscortSelfShipFinish,self.onXJCaravanEscortSelfShipFinish)
notifySystem:removelistener(notifyConfig.onXJCaravanEscortCanDispatchTimeEnd,self.onXJCaravanEscortCanDispatchTimeEnd)
notifySystem:removelistener(notifyConfig.onXJCaravanEscortRobCountChange,self.onXJCaravanEscortRobCountChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onXianMengChange,self.onXianMengChange)
end


function xianJieCaravanEscortController:onLostConnection()
self:clearSelfShipPosEndTimer()
end


function xianJieCaravanEscortController:onReConnection(isInitPro)

end



function xianJieCaravanEscortController:reqGetSelfEscortData()
socketManager:send_35_243()
end


function xianJieCaravanEscortController:reqGetAllShipTeamData()
socketManager:send_35_244()
end


function xianJieCaravanEscortController:reqCaravanEscortShipDispatch(posIdx,dzList,jsonStr)
socketManager:send_35_245(posIdx,#dzList,dzList,jsonStr)
end


function xianJieCaravanEscortController:reqSelfEscortShipPosRefresh(posIdx,isItemRefresh)
local isItemRefreshFlag=isItemRefresh and 1 or 0
socketManager:send_35_247(posIdx,isItemRefreshFlag)
end


function xianJieCaravanEscortController:reqSelfEscortShipGetReward(posIdx)
socketManager:send_35_249(posIdx)
end


function xianJieCaravanEscortController:reqGetShipDetailData(shipGuid)
if not shipGuid then
return
end
socketManager:send_35_250(shipGuid)
end


function xianJieCaravanEscortController:reqChangeShipPath(shipGuid,jsonStr)
if not shipGuid then
return
end
socketManager:send_35_251(shipGuid,jsonStr)
end



function xianJieCaravanEscortController.recv_35_243(len,shipPosList,getTimes,robTimes)









xianJieCaravanEscortModel:setSelfEscortData(len,shipPosList,getTimes,robTimes)

if len<=0 and not shipPosList then

xianJieCaravanEscortController:reqSelfEscortShipPosRefresh(0)
end

xianJieCaravanEscortController:setSelfShipPosEndTimer()


reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)
end


function xianJieCaravanEscortController.recv_35_244(len,shipDataList)
xianJieCaravanEscortModel:setAllShipTeamData(len,shipDataList)

xianJieCaravanEscortController:checkCreateCaravanEscortTeam()

if xianJieCaravanEscortController.initJumpOpenFunc then
local func=xianJieCaravanEscortController.initJumpOpenFunc
xianJieCaravanEscortController.initJumpOpenFunc=nil
return func()
end
end


function xianJieCaravanEscortController.recv_35_245(pos,shipGuid,startSec,dzListLen,dzList)
xianJieCaravanEscortModel:clearEscortShipPosTempData(pos)
xianJieCaravanEscortModel:clearOtherEscortShipPosDzListSameDz(pos,dzList)
xianJieCaravanEscortModel:setSelfEscortShipPosData_dispatch(pos,shipGuid,startSec,dzListLen,dzList)
xianJieCaravanEscortModel:setSelfEscortData_addGetTimes(1)

UIManager.info("派遣成功")




UIManager:invokeUIMethod("UIXJCaravanEscort_shipMsgWin","onCloseBtn")

UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageByPageIdx",1)
UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageBtnReddot")


xianJieCaravanEscortController:setSelfShipPosEndTimer()


reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)
end


function xianJieCaravanEscortController.recv_35_246(shipGuid,robTimes)

end


function xianJieCaravanEscortController.recv_35_247(args)
local pos=args[1]
local shipId=args[2]
local reward_list_len=args[3]
local reward_list=args[4]
local roundTimes=args[5]
local refreshTimes=args[6]
xianJieCaravanEscortModel:setSelfEscortShipPosData_refresh(pos,shipId,roundTimes,refreshTimes,reward_list_len,reward_list)




UIManager:invokeUIMethod("UIXJCaravanEscort_shipMsgWin","refreshByPosIdx",pos,nil,true)

UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageByPageIdx",1)
end


function xianJieCaravanEscortController.recv_35_248(shipData,removeShipGuid)
local shipGuid
if removeShipGuid and not mathHelper.compareInt64(removeShipGuid,Int64_0)then
shipGuid=removeShipGuid
shipData=nil
else
shipGuid=shipData and shipData.xianzhouStruct and shipData.xianzhouStruct.xianzhou_guid
end
xianJieCaravanEscortModel:refreshShipTeamData(shipData,shipGuid)

UIManager:invokeUIMethod("UIXJCaravanEscort_shipMsgWin","refreshByShipGuid",shipGuid,true)


local isSelfTeam=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)~=nil
if isSelfTeam then

UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageByPageIdx",1)
UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageBtnReddot")
end
end


function xianJieCaravanEscortController.recv_35_249(pos)

xianJieCaravanEscortModel:clearEscortDzByPosIdx(pos)



UIManager:invokeUIMethod("UIXJCaravanEscort_shipMsgWin","onCloseBtn")


UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageByPageIdx",1)
UIManager:invokeUIMethod("UIXJCaravanEscort_mainWin","refreshPageBtnReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eXJCaravanEscortChange)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)



end


function xianJieCaravanEscortController.recv_35_250(shipGuid,dzListLen,dzList)
xianJieCaravanEscortModel:setShipTeamDetailData(shipGuid,dzListLen,dzList)


UIManager:invokeUIMethod("UIXJCaravanEscort_shipMsgWin","refreshByShipGuid",shipGuid)
end



function xianJieCaravanEscortController:checkCreateCaravanEscortBuild(isInit)



local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()


if isActDoing then

xianJieCaravanEscortController:createCaravanEscortHubBuild(isInit)
else

xianjieModel:removeCaravanEscortHubEntities()
end
end

function xianJieCaravanEscortController:createCaravanEscortEnterBuild(isInitMap)
local ret=xianjieModel:createCaravanEscortEnterData()
xianjieModel:createCaravanEscortEnterEntities()
if isInitMap then


end
end

function xianJieCaravanEscortController:createCaravanEscortHubBuild(isInitMap)

local hubList=xianJieCaravanEscortModel:getCaravanEscortHubList()
if hubList then
local createNum=0
for i,v in ipairs(hubList)do
local sceneIdx=v.sceneIdx
local posX=v.pos[1]
local posY=v.pos[2]
local hubType=v.hubType
local ret=xianjieModel:createCaravanEscortHubData(sceneIdx,posX,posY,hubType)
createNum=createNum+1
end

if createNum>1 then
xianjieModel:createCaravanEscortHubEntities()
end
elseif isInitMap then

end
end


function xianJieCaravanEscortController:checkCreateCaravanEscortTeam(isInit)

local isOpenedAct=xianJieCaravanEscortModel:checkIsXJCaravanEscortActOpened()
local isOpen=xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanOpen()
if isOpenedAct and isOpen then
xianJieCaravanEscortController:createCaravanEscortTeam(isInit)
end
end

function xianJieCaravanEscortController:createCaravanEscortTeam(isInitMap)



if isInitMap then

xianJieCaravanEscortController:reqGetAllShipTeamData()
return
end

local teamList=xianJieCaravanEscortModel:getXJShowShipList()
if teamList then
local createNum=0
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(teamList)do
local endTime=v.endTime
local isExpire=nowTime>=endTime
if not isExpire then
local ret=xianjieModel:createCaravanEscortTeamData(v)
createNum=createNum+1
end
end

if createNum>0 then
xianjieModel:createCaravanEscortTeamListBehavior(nil,true)
end
end
end

function xianJieCaravanEscortController:addCaravanEscortTeamByShipGuid(shipGuid)
local guidStr=tostring(shipGuid)
local req,teamData=xianJieCaravanEscortModel:addXJShowShipData(shipGuid)


local sceneType=xianjieModel:getScenceType()and true or nil
if sceneType then
local sceneIdx=xianjieModel:getSceneIndex()
local isInXianYu=xianjienSceneIndexType:isXianYu(sceneIdx)
local isInXianJie=xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)
if(isInXianYu or isInXianJie)and req then
local endTime=teamData.endTime
local nowTime=timeHelper.getServerShortTime()
local isExpire=nowTime>=endTime
if not isExpire then
xianjieModel:createCaravanEscortTeamData(teamData)
xianjieModel:createCaravanEscortTeamBehavior(guidStr,nil,true)
end
end
end
end


function xianJieCaravanEscortController:resetCaravanEscortTeamList()

local isNeedChangeEntity=false
local sceneType=xianjieModel:getScenceType()and true or nil
if sceneType then
local sceneIdx=xianjieModel:getSceneIndex()
local isInXianYu=xianjienSceneIndexType:isXianYu(sceneIdx)
local isInXianJie=xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)
isNeedChangeEntity=isInXianYu or isInXianJie
end

local originalShowShipList=xianJieCaravanEscortModel:getXJShowShipList()
local originalShowShipLookup=xianJieCaravanEscortModel:getXJShowShipListLookup()or{}

local newShowShipList=xianJieCaravanEscortModel:getXJShowShipList(true)
local newShowShipLookup=xianJieCaravanEscortModel:getXJShowShipListLookup()or{}

local nowTime=timeHelper.getServerShortTime()
local checkIsExpireFunc=function(data)
local endTime=data.endTime
local isExpire=nowTime>=endTime
return isExpire
end


for i,v in ipairs(newShowShipList)do
local guidStr=v.guidStr
if not originalShowShipLookup[guidStr]then

local isExpire=checkIsExpireFunc(v)
if not isExpire and isNeedChangeEntity then
xianjieModel:createCaravanEscortTeamData(v)
xianjieModel:createCaravanEscortTeamBehavior(guidStr,nil,true)
end
end
end


for i,v in ipairs(originalShowShipList)do
local guidStr=v.guidStr
if not newShowShipLookup[guidStr]then

if isNeedChangeEntity then
xianjieModel:removeCaravanEscortTeamBehaviorByShipGuid(guidStr)
xianjieModel:removeCaravanEscortTeamEntityDataByShipGuid(guidStr)
end
local req=xianJieCaravanEscortModel:removeXJShowShipData(guidStr)
end
end
end


function xianJieCaravanEscortController:resetCaravanEscortTeamPathParamByShipGuid(shipGuid)

local pathData=xianJieCaravanEscortController:getShipPathData()
local jsonStr=jsonHelper.encode(pathData)

xianJieCaravanEscortController:reqChangeShipPath(shipGuid,jsonStr)
end

function xianJieCaravanEscortController:refreshCaravanEscortTeamPath(shipGuid)
local guidStr=tostring(shipGuid)

local sceneType=xianjieModel:getScenceType()and true or nil
if sceneType then
local sceneIdx=xianjieModel:getSceneIndex()
local isInXianYu=xianjienSceneIndexType:isXianYu(sceneIdx)
local isInXianJie=xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)
if(isInXianYu or isInXianJie)then
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
local shipBaseData=shipData and shipData.xianzhouStruct
local endTime
local isExpire=false
if shipBaseData then
local nowTime=timeHelper.getServerShortTime()
local shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
endTime=startTime+duration
isExpire=startTime>0 and nowTime>=endTime or false
end
end

if not isExpire then
xianjieModel:createCaravanEscortTeamBehavior(guidStr,nil,true)
end
end
end
end

function xianJieCaravanEscortController:clearCaravanEscortTeam()
xianjieModel:clearData_allCaravanEscortTeam()
end

function xianJieCaravanEscortController:checkAndAddNewXJShowShip()
if self.isAddingShowShip then
return
end
self.isAddingShowShip=true
local ret,addCount=xianJieCaravanEscortModel:checkAndAddXJShowShipData()
if ret then

local sceneIdx=xianjieModel:getSceneIndex()
local isInXianYu=xianjienSceneIndexType:isXianYu(sceneIdx)
local isInXianJie=xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)
if isInXianYu or isInXianJie then


xianJieCaravanEscortController:createCaravanEscortTeam()
end
end
self.isAddingShowShip=nil
end


function xianJieCaravanEscortController:setSelfShipPosEndTimer()
self:clearSelfShipPosEndTimer()

local shipPosDataList=xianJieCaravanEscortModel:getAllSelfEscortShipPosDataList()
if shipPosDataList then
local minEndTime
local minPosIdx
local minGuid
for posIdx,posData in pairs(shipPosDataList)do
local posBaseData=posData.xianzhouStruct
local startTime=posBaseData.start_sec or 0
if startTime and startTime>0 then
local shipId=posBaseData.xianzhou_id
local shipGuid=posBaseData.xianzhou_guid
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local endTime
if startTime and startTime>0 then
endTime=startTime+duration
if not minEndTime or endTime<minEndTime then
minEndTime=endTime
minPosIdx=posIdx
minGuid=shipGuid
end
end
end
end
end

if minEndTime then
local nowTime=timeHelper.getServerShortTime()
local deltaTime=minEndTime-nowTime
if deltaTime>0 then
self.shipEndTimer=timeEventController.delayDo(deltaTime,function()
xianJieCaravanEscortController:clearSelfShipPosEndTimer()
local nowTime=timeHelper.getServerShortTime()
if nowTime>=minEndTime then

notifySystem:postNotify(notifyConfig.onXJCaravanEscortSelfShipFinish,minPosIdx,minGuid)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)

return xianJieCaravanEscortController:setSelfShipPosEndTimer()
end
end)
end
end
end
end

function xianJieCaravanEscortController:clearSelfShipPosEndTimer()
if self.shipEndTimer then
self.shipEndTimer:cancel()
self.shipEndTimer=nil
end
end


function xianJieCaravanEscortController:refreshCaravanEscortEnterEntity()
local entityData=xianjieModel:getCaravanEscortEnterData()
if entityData then
entityData:refreshEntity()
end
end


function xianJieCaravanEscortController:refreshCEShipEntityEnemyTypeByGuidStrList(guidStrList)
if not guidStrList then
return
end

for i,guidStr in ipairs(guidStrList)do
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(guidStr)
if entityData then
entityData:refreshEntityEnemyType()
end
end
end
function xianJieCaravanEscortController:refreshCEShipEntityEnemyTypeByGuidStr(guidStr)
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(guidStr)
if entityData then
entityData:refreshEntityEnemyType()
end
end

function xianJieCaravanEscortController:getShipPathData()
local pathData={}


local zmData=xianjieModel:getMyZongMenData()
if zmData then
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)

local zmSceneIdx=zmData.sceneidx
local zmGridX=gridX_c
local zmGridZ=gridZ_c
pathData.zmSceneIdx=zmSceneIdx
pathData.zmPos={zmGridX,zmGridZ}

local isXianYu=xianjienSceneIndexType:isXianYu(zmSceneIdx)
local xjCheckStartPos
if isXianYu then
local xyPathId,xyPosIdxList=xianJieCaravanEscortController:getShipXianYuPathAndStartPosIdx(zmSceneIdx,zmGridX,zmGridZ)
local posX,posY=xianJieCaravanEscortController:getXJStartPos(zmSceneIdx)
xjCheckStartPos={posX,posY}
pathData.xyPathId=xyPathId
pathData.xyPosIdxList=xyPosIdxList
else
pathData.xyPathId=0
xjCheckStartPos={zmGridX,zmGridZ}
end

local sceneIdx=xianjienSceneIndexType.eXianJie
local loopPathId,loopPosIdxList=xianJieCaravanEscortController:getShipLoopPathAndStartPosIdx(sceneIdx,xjCheckStartPos[1],xjCheckStartPos[2])
pathData.loopPathId=loopPathId
pathData.loopPosIdxList=loopPosIdxList
end

return pathData
end

function xianJieCaravanEscortController:getShipXianYuPathAndStartPosIdx(xySceneIdx,zmPosX,zmPosY)
local xyPathCfgList=cfgHelper.get(cfg_miaoxingshanglvxianyupathconfig_get,xySceneIdx)
local minPathId
local posIdxList
if xyPathCfgList and next(xyPathCfgList)then
local minPathDis
local pathDisLookup={}
for pathId,pathCfg in pairs(xyPathCfgList)do
local pathList=pathCfg.pathList
for wayIdx,posList in ipairs(pathList)do
for posIdx,v in ipairs(posList)do
local posX=v[1]
local posY=v[2]
local dis=mathHelper.distance(zmPosX,zmPosY,posX,posY)
if not minPathDis or dis<=minPathDis then
if dis~=minPathDis then
minPathDis=dis
end
if not pathDisLookup[dis]then
pathDisLookup[dis]={}
end
local list=pathDisLookup[dis]
list[#list+1]={
pathId=pathId,
wayIdx=wayIdx,
posIdx=posIdx,
}
end
end
end
end

local dataList=pathDisLookup[minPathDis]
local dataCount=#dataList
local selectData
if dataCount<=1 then
selectData=dataList[1]
else
local randomIdx=math.random(1,dataCount)
selectData=dataList[randomIdx]
end

minPathId=selectData.pathId
posIdxList={selectData.wayIdx,selectData.posIdx}
end
return minPathId,posIdxList
end


function xianJieCaravanEscortController:getShipLoopPathAndStartPosIdx(checkPosX,checkPosY)
local pathCfgList=cfg_miaoxingshanglvlooppathconfig()
local minPathId
local posIdxList
if pathCfgList and next(pathCfgList)then
local minPathDis
local pathDisLookup={}
for pathId,pathCfg in pairs(pathCfgList)do
local pathList=pathCfg.pathList
for wayIdx,posList in ipairs(pathList)do
for posIdx,v in ipairs(posList)do
local posX=v[1]
local posY=v[2]
local dis=mathHelper.distance(checkPosX,checkPosY,posX,posY)
if not minPathDis or dis<=minPathDis then
if dis~=minPathDis then
minPathDis=dis
end
if not pathDisLookup[dis]then
pathDisLookup[dis]={}
end
local list=pathDisLookup[dis]
list[#list+1]={
pathId=pathId,
wayIdx=wayIdx,
posIdx=posIdx,
}
end
end
end
end

local dataList=pathDisLookup[minPathDis]
local dataCount=#dataList
local selectData
if dataCount<=1 then
selectData=dataList[1]
else
local randomIdx=math.random(1,dataCount)
selectData=dataList[randomIdx]
end

minPathId=selectData.pathId
posIdxList={selectData.wayIdx,selectData.posIdx}
end
return minPathId,posIdxList
end

function xianJieCaravanEscortController:getXJStartPos(xySceneIdx)
local cfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,xySceneIdx)
local tagPos=cfg.tagPos

local gridWidth=0
local gridHeight=0
local tarx=tagPos[1]
local tary=tagPos[2]

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(tarx,tary,gridWidth,gridHeight)
return gridX_c,gridZ_c
end

function xianJieCaravanEscortController:getXYEndPos(xySceneIdx)
local cfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,xySceneIdx)
local resPos=cfg.resPos

local gridWidth=0
local gridHeight=0
local tarx=resPos[1]
local tary=resPos[2]

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(tarx,tary,gridWidth,gridHeight)
return gridX_c,gridZ_c
end


function xianJieCaravanEscortController:setJumpOpenFunc(func)
xianJieCaravanEscortController.initJumpOpenFunc=func
end




function xianJieCaravanEscortController:testFunc_createTeamEntity()
local marchguid,isBack,beginTime
local d={marchguid,isBack,beginTime}
xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eMarchTeam,d,true)

end


function xianJieCaravanEscortController:testFunc_printSelfShipPathByPosIdx(posIdx)
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(posIdx)
local posBaseData=posData.xianzhouStruct
local shipGuid=posBaseData.xianzhou_guid
if shipGuid and not mathHelper.compareInt64(shipGuid,Int64_0)then
return xianJieCaravanEscortController:testFunc_printShipPathByShipGuid(shipGuid)
else
logErr(FMT.fmt("喵行商旅打印 当前坑位{0}中没有派出船只数据，无法打印路径坐标",posIdx))
end
end


function xianJieCaravanEscortController:testFunc_printShipPathByShipGuid(shipGuid)
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local ent
if entityData then
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
ent=xianjieController:getEntity(clickEntKey)
end
end

if ent then
local posList=ent:getMovePathPosList()
local pathParam=entityData.pathParam

else
logErr(FMT.fmt("喵行商旅打印 找不到船只guid={0}对应的实体",tostring(shipGuid)))
end
end

function xianJieCaravanEscortController:testFunc_changePathData(shipGuid)
local list={}
local jsonStr=jsonHelper.encode(list)
xianJieCaravanEscortController:reqChangeShipPath(shipGuid,jsonStr)
end

function xianJieCaravanEscortController.onEnterXianJie(sceneType)



local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()


if isActDoing then



xianJieCaravanEscortController:createCaravanEscortHubBuild(true)

xianJieCaravanEscortController:createCaravanEscortTeam(true)
end
end

function xianJieCaravanEscortController.onLeaveXianJie(sceneType)
if sceneType==xianjienSceneType.eXianJie then


end
end


function xianJieCaravanEscortController.onLimitActStateChange(actID,actState)
local flag=actID==LIMIT_ACT_TYPE.eMiaoXingShangLv
if not flag then
return
end

if actState==limitActivitiesModel.actDoingState or actState==limitActivitiesModel.actFinishState then
if actState==limitActivitiesModel.actDoingState then

xianJieCaravanEscortModel:setSelfEscortData_getTimes(0)

xianJieCaravanEscortModel:setSelfEscortData_robTimes(0)

xianJieCaravanEscortModel:setXJCaravanEscortActCanDispatchEndTime()


xianJieCaravanEscortController:reqGetSelfEscortData()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eXJCaravanEscortChange)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)


xianJieCaravanEscortController:checkCreateCaravanEscortBuild()
end
end

function xianJieCaravanEscortController.onLimitActOpen(actID,flag)
local actFlag=actID==LIMIT_ACT_TYPE.eMiaoXingShangLv
if actFlag and flag then
xianJieCaravanEscortController:checkCreateCaravanEscortBuild(true)
end
end

function xianJieCaravanEscortController.onXJCaravanEscortSelfShipFinish(posIdx,shipGuid)


end

function xianJieCaravanEscortController.onXJCaravanEscortCanDispatchTimeEnd()

end

function xianJieCaravanEscortController.onXJCaravanEscortRobCountChange()
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)
end

function xianJieCaravanEscortController.onNewDay5am()







reddotControl.on_change_catch_type(CATCH_TYPE.eXJCaravanEscortChange)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)
end

function xianJieCaravanEscortController.onXianMengChange()

local changeGuidStrList=xianJieCaravanEscortModel:checkAndResetOtherXmShipTeamData()
xianJieCaravanEscortController:refreshCEShipEntityEnemyTypeByGuidStrList(changeGuidStrList)
end
