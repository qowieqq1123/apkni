









local xjEntity_caravanEscortTeam={}


function xjEntity_caravanEscortTeam:onInit()
self.canSelect=true
local data=self.data
self.guidStr=data[1]
self.startSceneIdx=data[2]
self.beginTime=data[3]
self.endTime=data[4]
self:initData()

self.ent_name="护送队伍"
end

function xjEntity_caravanEscortTeam:initData()
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(self.guidStr)
local actorId=shipData and shipData.actor_id or nil
local enemyType=actorId and xianjieModel:checkEnemyType2(actorId,self.startSceneIdx)or xjEnemyType.eStranger
self.enemyType=enemyType

if xianJieCaravanEscortModel:checkHasPathData(shipData)then
self.pathParam=jsonHelper.decode(shipData.param)
end

self.movePathPosList=nil
self.movePath=self:getMyMovePath()
self.posList,self.linePosList=xianjieController:getMovePathToPosList(self.movePath,nil,nil)
self.moveTagList=self:getMoveTagList(self.movePath,self.beginTime)

self:checkTeamModelId()
end

function xjEntity_caravanEscortTeam:getMyMovePath()
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
local deltaTime=self.endTime-self.beginTime
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

function xjEntity_caravanEscortTeam:getMovePathPosList()
return self.movePathPosList
end

function xjEntity_caravanEscortTeam:getTargetPos()




local gridWidth,gridHeight


gridWidth=0
gridHeight=0

local gridWidth_s=gridWidth
local gridHeight_s=gridHeight

local targetPos=xianJieCaravanEscortModel:getEscortShipTargetPos()
local tarx=targetPos[1]
local tary=targetPos[2]
local sceneidx=xianjienSceneIndexType.eXianJie

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(tarx,tary,gridWidth_s,gridHeight_s)
return sceneidx,gridX_c,gridZ_c,gridWidth,gridHeight
end

function xjEntity_caravanEscortTeam:getStartPos()
local zmSceneIdx=self.pathParam.zmSceneIdx
local zmPos=self.pathParam.zmPos

local gridWidth,gridHeight
gridWidth=0
gridHeight=0
local posX=zmPos[1]
local posY=zmPos[2]

return zmSceneIdx,posX,posY,gridWidth,gridHeight
end

function xjEntity_caravanEscortTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
local isIgnoreArea=self.isIgnoreArea
return xianjieController:getMoveTagList(movePath,bTime,speedlist,isIgnoreArea)
end

function xjEntity_caravanEscortTeam:getSpeedList()
if self.speedlist then
return self.speedlist
end


local deltaTime=self.endTime-self.beginTime
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
self.speedlist={{param_1=self.beginTime,param_2=speed}}
return self.speedlist
end

function xjEntity_caravanEscortTeam:checkTeamModelId()

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(self.guidStr)
local shipBaseData=shipData and shipData.xianzhouStruct or nil
local robbedTimes=shipBaseData and shipBaseData.robbed_times or 0
local shipId=shipBaseData and shipBaseData.xianzhou_id or 1
local color=shipId
self.teamModelId=xianJieCaravanEscortModel:getShipTeamModelId(color,robbedTimes)
end
function xjEntity_caravanEscortTeam:onRefreshModel()
self:checkTeamModelId()
return self:refreshModel()
end

function xjEntity_caravanEscortTeam:onRefreshEnemyType()
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(self.guidStr)
local actorId=shipData and shipData.actor_id or nil
local enemyType=actorId and xianjieModel:checkEnemyType2(actorId,self.startSceneIdx)or xjEnemyType.eStranger
self.enemyType=enemyType
end
return xjEntity_caravanEscortTeam