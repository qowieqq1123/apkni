









local xjEntityData_caravanEscortTeam={}


function xjEntityData_caravanEscortTeam:onInit()
self.len=nil
self.list=nil

self.isMyWaiPai=self.posIdx and self.posIdx~=0

self.teamSceneidx=xianjienSceneIndexType.eXianJie
local shipGuidStr=self.guidStr
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuidStr)
local baseShipData=shipData and shipData.xianzhouStruct
self.startTime=baseShipData and baseShipData.start_sec or 0
self.srcSceneIdx=shipData and shipData.scene_idx

if xianJieCaravanEscortModel:checkHasPathData(shipData)then
self.pathParam=jsonHelper.decode(shipData.param)
end
local duration=0
local shipId=baseShipData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
duration=shipCfg.need_time
end
self.endTime=self.startTime+duration

self.robbedTimes=baseShipData and baseShipData.robbed_times or 0
end

function xjEntityData_caravanEscortTeam:refreshData(d)
local shipGuidStr=self.guidStr
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuidStr)
if shipData then
if not self.pathParam and xianJieCaravanEscortModel:checkHasPathData(shipData)then
self.pathParam=jsonHelper.decode(shipData.param)
end
end

local baseShipData=shipData and shipData.xianzhouStruct
local robbedTimes=baseShipData and baseShipData.robbed_times or 0
if robbedTimes~=self.robbedTimes then
self.robbedTimes=robbedTimes

local onRefreshModelFunc=self:getBehaviorData('onRefreshModel')
if onRefreshModelFunc then
onRefreshModelFunc()
end
end


local onRefreshEnemyTypeFunc=self:getBehaviorData('onRefreshEnemyType')
if onRefreshEnemyTypeFunc then
onRefreshEnemyTypeFunc()
end
end

function xjEntityData_caravanEscortTeam:refreshEntityEnemyType()

local onRefreshEnemyTypeFunc=self:getBehaviorData('onRefreshEnemyType')
if onRefreshEnemyTypeFunc then
onRefreshEnemyTypeFunc()
end
end

function xjEntityData_caravanEscortTeam:markMyWaiPai()
self.isMyWaiPai=true
end

function xjEntityData_caravanEscortTeam:compareKey(guid)
return self.guidStr==tostring(guid)
end


function xjEntityData_caravanEscortTeam:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={guidStr=self.guidStr,startTime=self.startTime,srcSceneIdx=self.srcSceneIdx,endTime=self.endTime}
end
end

function xjEntityData_caravanEscortTeam:createBehavior(sceneidx,isStart)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local startSceneIdx=self.pathParam and self.pathParam.zmSceneIdx
local hasPath=self.pathParam~=nil
if not hasPath or(sceneidx~=self.teamSceneidx and(not startSceneIdx or sceneidx~=startSceneIdx))then
return
end
local typo='caravan_escort_goto'
self:initBehaviorData()
if self.behaviorID==nil then
local finishCB=function(tree)











self:clearBehaviorEx()
local shipGuidStr=self.guidStr
xianjieModel:removeCaravanEscortTeamEntityDataByShipGuid(shipGuidStr)
local req=xianJieCaravanEscortModel:removeXJShowShipData(shipGuidStr)
if req then
xianJieCaravanEscortController:checkAndAddNewXJShowShip()
end
end
self.behaviorID=xjBehaviorManager:createTree(typo,self.behaviorData,finishCB,isStart)
return true
end
end


function xjEntityData_caravanEscortTeam:playBattleResult()

end

function xjEntityData_caravanEscortTeam:handleSpeedUp()
local onSpeedUpFunc=self:getBehaviorData('onSpeedUp')
if onSpeedUpFunc then
onSpeedUpFunc()
end
end


function xjEntityData_caravanEscortTeam:initTeamHandle()

end


function xjEntityData_caravanEscortTeam:onDelete()

end


function xjEntityData_caravanEscortTeam:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end


local sceneidx,gridX_c,gridZ_c=self:getStartPos()

local isIgnoreArea=self.isIgnoreArea
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local defaultSpeed=baseCfg.defaultSpeed

local pathPosList={}

pathPosList[1]={
sceneidx=sceneidx,
gridX=gridX_c,
gridZ=gridZ_c,
}

local moveDis=0
local deltaTime=self.endTime-self.startTime
local defaultMaxMoveDis=deltaTime*defaultSpeed
local xyPathId=self.pathParam.xyPathId
local isFinishInsertPos=false

local addPosFunc=function(lastPosX,lastPosY,addPosX,addPosY,addSceneIdx)
local dis=mathHelper.distance(lastPosX,lastPosY,addPosX,addPosY)
moveDis=moveDis+dis
pathPosList[#pathPosList+1]={
sceneidx=addSceneIdx,
gridX=addPosX,
gridZ=addPosY,
}
end

local addXYPathFunc=function()
local xyPathCfg=cfgHelper.get(cfg_miaoxingshanglvxianyupathconfig_get,sceneidx,xyPathId)
local pathList=xyPathCfg.pathList
local xyPosIdxList=self.pathParam.xyPosIdxList
local startWayIdx=xyPosIdxList[1]
local startPosIdx=xyPosIdxList[2]
local posIdx=startPosIdx
for wIdx=startWayIdx,#pathList do
local posList=pathList[wIdx]
local posCount=#posList
for pIdx=posIdx,posCount do
local pos=posList[pIdx]
local lastPosData=pathPosList[#pathPosList]

addPosFunc(lastPosData.gridX,lastPosData.gridZ,pos[1],pos[2],sceneidx)

if pIdx==1 then

if moveDis>=defaultMaxMoveDis then
isFinishInsertPos=true
return
end
end
end
posIdx=1
end


local endPosX,endPosY=xianJieCaravanEscortController:getXYEndPos(sceneidx)
local lastPosData=pathPosList[#pathPosList]

addPosFunc(lastPosData.gridX,lastPosData.gridZ,endPosX,endPosY,sceneidx)
if moveDis>=defaultMaxMoveDis then
isFinishInsertPos=true
end
end

local hasXYPath=xyPathId and xyPathId~=0 or false
if hasXYPath then
addXYPathFunc()
end

local loopPathId=self.pathParam.loopPathId
if not isFinishInsertPos then
local loopSceneIdx=xianjienSceneIndexType.eXianJie
if hasXYPath then

local loopStartPosX,loopStartPosY=xianJieCaravanEscortController:getXJStartPos(sceneidx)
pathPosList[#pathPosList+1]={
sceneidx=loopSceneIdx,
gridX=loopStartPosX,
gridZ=loopStartPosY,
}
end
if loopPathId and loopPathId~=0 then
local loopPathCfg=cfgHelper.get(cfg_miaoxingshanglvlooppathconfig_get,loopPathId)
local pathList=loopPathCfg.pathList
local loopPosIdxList=self.pathParam.loopPosIdxList
local startWayIdx=loopPosIdxList[1]
local startPosIdx=loopPosIdxList[2]
local wayIdx=startWayIdx
local posIdx=startPosIdx
local wayCount=#pathList
local safeLoopCount=1500
local loopNum=0
while not isFinishInsertPos and loopNum<=safeLoopCount do
local posList=pathList[wayIdx]
local posCount=#posList
for pIdx=posIdx,posCount do
local pos=posList[pIdx]
local lastPosData=pathPosList[#pathPosList]

addPosFunc(lastPosData.gridX,lastPosData.gridZ,pos[1],pos[2],loopSceneIdx)
if pIdx==1 then

if moveDis>=defaultMaxMoveDis then
isFinishInsertPos=true
break
end
elseif pIdx==posCount then
posIdx=1
end
end
wayIdx=wayIdx+1
if wayIdx>wayCount then
wayIdx=1
end
loopNum=loopNum+1
end


if loopNum>=safeLoopCount then
logErr(FMT.fmt("喵行商旅初始化船只路径超出最大循环次数 请检查前端逻辑与对应路径配置 guid={0} param={1}",self.guidStr,serializeHelper.serialize(self.pathParam)))
end
end
end

self.movePathPosList=pathPosList
movePath=xianjieController:getMovePath3(pathPosList)
self.movePath=movePath
return movePath
end


function xjEntityData_caravanEscortTeam:getStartPos()
local zmSceneIdx=self.pathParam.zmSceneIdx
local zmPos=self.pathParam.zmPos

local gridWidth,gridHeight
gridWidth=0
gridHeight=0
local posX=zmPos[1]
local posY=zmPos[2]

return zmSceneIdx,posX,posY,gridWidth,gridHeight
end

function xjEntityData_caravanEscortTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
local isIgnoreArea=self.isIgnoreArea
return xianjieController:getMoveTagList(movePath,bTime,speedlist,isIgnoreArea)
end

function xjEntityData_caravanEscortTeam:getSpeedList()
if self.speedlist then
return self.speedlist
end


local deltaTime=self.endTime-self.startTime
local isIgnoreArea=self.isIgnoreArea
local movePath=self:getMyMovePath()
local movePathNum=#movePath
local allDistance=0
for i=1,movePathNum-1 do
local posData1=movePath[i]
local posData2=movePath[i+1]

if posData1.sceneidx==posData2.sceneidx and(isIgnoreArea or posData1.areaID==posData2.areaID)then

local distance=mathHelper.distance(posData1.gridX,posData1.gridZ,posData2.gridX,posData2.gridZ)
allDistance=allDistance+distance
end
end
local speed=allDistance/deltaTime
self.speedlist={{param_1=self.startTime,param_2=speed}}
return self.speedlist
end

function xjEntityData_caravanEscortTeam:getTeamPos()
if not self.moveTagList then
if not self.movePath then
self.movePath=self:getMyMovePath()
end
self.moveTagList=self:getMoveTagList(self.movePath,self.startTime)
end

local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local atkSize,atkOffset
local sceneidx,cpos=xianjieController:getMoveTagLerpMovePos(self.moveTagList,moveTagIndex,true,atkSize,atkOffset)
return sceneidx,cpos
end


return xjEntityData_caravanEscortTeam