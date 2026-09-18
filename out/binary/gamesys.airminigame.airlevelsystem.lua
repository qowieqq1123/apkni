airLevelSystem={}


function airLevelSystem:onAppStart()

end

function airLevelSystem:onEnterState(isReconnect)
if isReconnect then

if self.curBgmId and self.outBgmId then
AudioManager.playBgMusic(self.outBgmId)
end
end
self.curBgmId=nil
self.outBgmId=nil
end


function airLevelSystem:onLeaveState(isReconnect)
airLevelSystem:leaveAirGame()
end

function airLevelSystem:onProtocolReq(isReconnect)

end

function airLevelSystem:enterAirGame()
self:clearData()
end

function airLevelSystem:leaveAirGame()
self:clearData()
end

function airLevelSystem:onUpdate()
if self.isStart then
if self.countTimeStamp and airActorSystem:getActor()then
local pauseTime=airLevelSystem:getPauseTime()
if math.floor(self.countTimeStamp+pauseTime)<airController:getRealServerTime_short()then
local isPause=airController:isPauseGame()
if not isPause then

airLevelSystem:setResultFlag(1)
airLevelSystem:onFinishLevel()
end
else
if self:canSpwan()then
airLevelSystem:spwanMonsters()
end
airMonsterSystem:spwanNeutral()
end
end
elseif self.isfinish then
airLevelSystem:onFinishLevel()
end
end

function airLevelSystem:start(id,idx)
if self.isStart then
UIManager.error('正在进行中')
return
end
local fubenCfg=cfg_airfubenconfig_get(id)
if not self.outBgmId then
self.outBgmId=AudioManager.getCurrentBgm()
end

local bgmId=fubenCfg.bgmId
if bgmId and bgmId~=self.curBgmId then
AudioManager.playBgMusic(bgmId)
self.curBgmId=bgmId
end

local sceneList=fubenCfg.sceneList
local level=sceneList[idx]
local levelCfg=level and cfg_airlevelconfig_get(level)or nil
local isFinishAndVictory=false
if not levelCfg and idx>#sceneList then

isFinishAndVictory=true
end

self.curLevelIdx=idx
self.curLevel=level
self.fbid=id
airController:resetRunningTime()
if not isFinishAndVictory then
airLevelSystem:initLevelData(levelCfg)
end


local processData=airModel:getActorProcessData()
processData.fbId=self.fbid
processData.curLevelIdx=self.curLevelIdx
airModel:setActorProcessData(processData)

if isFinishAndVictory then

airLevelSystem:setResultFlag(1)
self:clearData(true)
airController:setIsOnlyRefreshWinFlag(nil)
airController:setIsNeedRefreshDataFlag(nil)
airController:setRefreshDataType(nil)
airController:setRefreshIndex(nil)
airController:setIsShowFinishAnimWinFlag(nil)
UIManager:callWindowFunc('UIAirMiniGameMainWin','endLevel')
airLevelSystem:onRoundSettlement(nil,false)
return
end

airLevelSystem:onLevelStart()
end

function airLevelSystem:startNextLevel()
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local nextIdx=curLevelIdx+1
airLevelSystem:clearFbIdAndLevel()
airEntitySystem:clearAllEntity(true)

local processData=airModel:getActorProcessData()
processData.isInSettlement=nil

processData.gotBoxList=nil
processData.gotBoxCount=nil
airModel:setActorProcessData(processData)
airModel:clearDropBoxList()

airLevelSystem:start(fbId,nextIdx)
end


function airLevelSystem:continueStart()
local processData=airModel:getActorProcessData()

local fbId=processData.fbId
local curLevelIdx=processData.curLevelIdx


local isInSettlement=processData.isInSettlement
if not isInSettlement then
if not airActorSystem:hasActor()then
airActorSystem:createActor()
end

airLevelSystem:start(fbId,curLevelIdx)
airBuffSystem:onLevelStart()
return
else

local fubenCfg=cfg_airfubenconfig_get(fbId)
local sceneList=fubenCfg.sceneList
local level=sceneList[curLevelIdx]

self.curLevelIdx=curLevelIdx
self.curLevel=level
self.fbid=fbId

airActorSystem:createActor()
self:clearData(true)
UIManager:callWindowFunc('UIAirMiniGameMainWin','endLevel')

local checkStep=processData.checkStep
local resultFlag=processData.resultFlag
airLevelSystem:setResultFlag(resultFlag)

airController:setIsOnlyRefreshWinFlag(nil)
processData.isNeedKeepSettlementData=true
airModel:setActorProcessData(processData)
airLevelSystem:onRoundSettlement(checkStep,false)
end
end

function airLevelSystem:checkHasNextLevel()
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local fubenCfg=cfg_airfubenconfig_get(fbId)
local sceneList=fubenCfg.sceneList
local nextIdx=curLevelIdx+1
local level=sceneList[nextIdx]
if level then
return true
end
return false
end

function airLevelSystem:initLevelData(levelCfg)
self.levelCfg=levelCfg
local stamp=airController:getRealServerTime_short()
local hasTime=levelCfg.levelTime~=nil
if hasTime then
self.countTimeStamp=levelCfg.levelTime+stamp-self:getPauseTime()
else
self.countTimeStamp=nil
end

self.spwanTime=levelCfg.spwanFrequency
self.startTime=stamp
self.waitStartTime=levelCfg.waitStart
self.waitEndTime=levelCfg.waitNext
self.spwanTimeStamp=self.waitStartTime+stamp
self.round=0
self.tRound=hasTime and math.ceil(levelCfg.levelTime/self.spwanTime)or 1

self.entities={}
self.entitiesCount=0
self.monsterIdex=0
self.isfinish=nil
self.resultFlag=nil

self.isStart=true
if airActorSystem:createActor()then
airActorSystem:resetRolePosition()
end
self.speSpwan=airMonsterSystem:creatorSpeMonsterData(levelCfg,self.spwanTime)

airEntitySystem:onLevelStart()
airMonsterSystem:onLevelStart(self.fbid,self.curLevelIdx)
end

function airLevelSystem:onLevelStart()
airLevelSystem:onRefreshWin()
end

function airLevelSystem:onFinishLevel()
airBuffSystem:onLevelEnd()
airMonsterSystem:onLevelEnd()
airDropSystem:onLevelEnd()
local processData=airModel:getActorProcessData()
processData.checkStep=nil
processData.isInSettlement=true
local resultFlag=airLevelSystem:getResultFlag()
processData.resultFlag=resultFlag
airModel:setActorProcessData(processData)
airModel:setSettlementRewardList(nil)
airModel:setStatisticData_setOverLastLevelWeaponDmg()
airController:setIsShowFinishAnimWinFlag(true)
self:clearData(true)
processData=airModel:getActorProcessData()
local list,boxCount=airModel:getFbLevelGetBoxCountList()
processData.gotBoxList=list
processData.gotBoxCount=boxCount
airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(true)
UIManager:callWindowFunc('UIAirMiniGameMainWin','endLevel')
end


function airLevelSystem:onStopNowLevel(isIgnoreActor)
if self.isStart then
airBuffSystem:onLevelEnd()
airMonsterSystem:onLevelEnd()
self:clearData(isIgnoreActor)
UIManager:callWindowFunc('UIAirMiniGameMainWin','endLevel')
end
end


function airLevelSystem:onClearNowLevel()
if self.curBgmId and self.outBgmId then
AudioManager.playBgMusic(self.outBgmId)
end
self.curBgmId=nil
self.outBgmId=nil

airBuffSystem:onLevelEnd()
airMonsterSystem:onLevelEnd()
self:clearData()
UIManager:callWindowFunc('UIAirMiniGameMainWin','endLevel')
end

function airLevelSystem:clearData(isIgnoreActor)
self.isfinish=nil
airEntitySystem:clearAllEntity(isIgnoreActor)
self.entities=nil
self.countTimeStamp=nil
self.pauseStamp_start=nil
self.pauseStamp_end=nil
self.pauseTime=nil
self.isStart=false
self.spwanTime=nil
self.startTime=nil
self.waitStartTime=nil
self.waitEndTime=nil
self.spwanTimeStamp=nil
self.round=nil
self.tRound=nil
self.spwanPointInfoList=nil
self.speSpwan=nil
self.levelCfg=nil


self.entitiesCount=nil
self.monsterIdex=nil
end

function airLevelSystem:getCurLevelIdx()
return self.curLevelIdx or 1
end

function airLevelSystem:canSpwan()
if self.spwanTimeStamp+airLevelSystem:getPauseTime()>airController:getRealServerTime_short()then return false end
if self.round>=self.tRound then return false end
return true
end

function airLevelSystem:spwanMonsters()
local levelCfg=self.levelCfg
local spwanPointInterval=levelCfg.spwanPointInterval
local spwanPointCount=levelCfg.spwanPointCount
local spwanCount=levelCfg.spwanCount
local spwanArgs=levelCfg.spwanArgs
local entitiesCount=self.entitiesCount
local maxCount=levelCfg.totalAliveCount
local left=maxCount-entitiesCount
if left<=0 then

return
end
local totalSpwanCount=math.min(spwanCount,left)
local totalSpwanCount_1=totalSpwanCount
local spwanFrequency=levelCfg.spwanFrequency
self.spwanTimeStamp=spwanFrequency+airController:getRealServerTime_short()-airLevelSystem:getPauseTime()

local round=self.round+1
self.round=round

local spwanCountInfo={}
local spwanList={}
local monsterKind=#spwanArgs
for i=1,monsterKind do
local spwanArgsInfo=spwanArgs[i]
local monsterId=spwanArgsInfo[1]
local max=spwanArgsInfo[2]
local count=math.min(math.random(1,max),totalSpwanCount)
totalSpwanCount=totalSpwanCount-count
if count>0 then
spwanCountInfo[monsterId]=count
spwanList[#spwanList+1]=monsterId
end
if totalSpwanCount<=0 then
break
end
end

local num=0
while(totalSpwanCount>0 and num<50)do
for i=1,monsterKind do
local spwanArgsInfo=spwanArgs[i]
local max=spwanArgsInfo[2]
local monsterId=spwanArgsInfo[1]
local old=spwanCountInfo[monsterId]or 0
if old<max then
spwanCountInfo[monsterId]=old+1
totalSpwanCount=totalSpwanCount-1
end
num=num+1
end
end


local speSpwanList={}
if self.speSpwan[round]then
for _,monsterId in ipairs(self.speSpwan[round])do
speSpwanList[#speSpwanList+1]=monsterId
end
end


local pointCount=math.random(spwanPointCount[1],spwanPointCount[2])
local points={}
for i=1,pointCount do
local x,z=airLevelSystem:randomPoint(spwanPointInterval)
points[#points+1]={x,z}
end
local perCount=math.floor(totalSpwanCount_1/pointCount)
local spwanPointInfoList={}
local leftCount=totalSpwanCount_1-perCount*pointCount
local idx=1
for i=1,pointCount do
local count=perCount
if leftCount>0 then count=count+1 end
local spwanInfo={}
if count>0 then
for j=1,count do
local monsterId=spwanList[idx]
if monsterId==nil then
break
end
local left=spwanCountInfo[monsterId]-1
if left<=0 then
idx=idx+1
end
spwanCountInfo[monsterId]=left
spwanInfo[monsterId]=(spwanInfo[monsterId]or 0)+1
end
end
if next(spwanInfo)==nil then
break
end
spwanPointInfoList[#spwanPointInfoList+1]={
pos=points[i],
spwanInfo=spwanInfo,
}
end

local idx=1
local max=#speSpwanList
local per=math.floor(max/pointCount)
local left=max-per*pointCount
local isAllocate=false
for i=pointCount,1,-1 do
local info=spwanPointInfoList[i]
if info then
local spwanInfo={}
for j=1,per do
local monsterId=speSpwanList[idx]
if monsterId==nil then
isAllocate=true
break
end
spwanInfo[monsterId]=1
idx=idx+1
end
if left>0 then
local monsterId=speSpwanList[idx]
spwanInfo[monsterId]=1
left=left-1
idx=idx+1
end
info.speSpwanInfo=spwanInfo
end
if isAllocate then
break
end
end
self.spwanPointInfoList=spwanPointInfoList

airLevelSystem:createMonsterEntity()
end

function airLevelSystem:setFinishTag()
self.isfinish=true
end

function airLevelSystem:setStartFlag(flag)
self.isStart=flag
end


function airLevelSystem:isLevelDoing()
return self.isStart==true
end

function airLevelSystem:setPauseStamp_start()
self.pauseStamp_start=Time.realtimeSinceStartup
end

function airLevelSystem:setPauseStamp_end()
self.pauseStamp_end=Time.realtimeSinceStartup
end

function airLevelSystem:setPauseTime()
if not self.pauseTime then
self.pauseTime=0
end

local deltaTime=0
if self.pauseStamp_end and self.pauseStamp_start then
deltaTime=self.pauseStamp_end-self.pauseStamp_start
end

self.pauseTime=self.pauseTime+deltaTime
end

function airLevelSystem:getPauseTime()

local startTime=airController:getStartRunningTime()
local runningTime=airController:getRunningDuration()
local nowTime=Time.realtimeSinceStartup
local pauseTime=nowTime-startTime-runningTime
if pauseTime>0 then
local test=0
end

return pauseTime
end

function airLevelSystem:randomPoint(spwanPointInterval)
local min=spwanPointInterval[1]
local max=spwanPointInterval[2]
local posX,posZ=airActorSystem:getActorPosition2D()
local angleCount=0

while(true)do
local angle=math.random(angleCount,360)*Mathf.Deg2Rad
local radius=math.random(min,max)
local x=posX+radius*Mathf.Cos(angle)
local z=posZ+radius*Mathf.Sin(angle)
if airMapSystem:isInMap(x,z)then
return x,z
end
angleCount=angleCount+1
if angleCount>360 then
break
end
end


while(true)do
local angle=math.random(angleCount,360)*Mathf.Deg2Rad
local radius=math.random(min,max)
local x=posX+radius*Mathf.Cos(angle)
local z=posZ+radius*Mathf.Sin(angle)
if airMapSystem:isInMap(x,z)then
return x,z
end
angleCount=angleCount-1
if angleCount<0 then
break
end
end

return posX,posZ
end

function airLevelSystem:createMonsterEntity()
local levelCfg=self.levelCfg
for _,v in ipairs(self.spwanPointInfoList)do
local pos=v.pos
local x=pos[1]
local z=pos[2]
local spwanInfo=v.spwanInfo
local speSpwanInfo=v.speSpwanInfo

for monsterId,count in pairs(spwanInfo)do
airLevelSystem:createMonster(monsterId,x,z,count)
end

for monsterId,count in pairs(speSpwanInfo)do
airLevelSystem:createMonster(monsterId,x,z,count)
end
end
end

function airLevelSystem:createMonster(monsterId,x,z,count)
self.monsterIdex=self.monsterIdex+1
airMonsterSystem:createMonster(monsterId,x,z,count)
end

function airLevelSystem:onDeleteMonster(ent)
if self.entities and self.entities[ent.handle]then
self.entities[ent.handle]=nil
self.entitiesCount=self.entitiesCount-1
end
end

function airLevelSystem:addMonster(ent)
if self.entities and self.entities[ent.handle]==nil then
self.entities[ent.handle]=ent
self.entitiesCount=self.entitiesCount+1
end
end

function airLevelSystem:onRefreshWin()

local max=airLevelSystem:getMaxLevel()
local args=
{
maxLevel=max,
levelCfg=self.levelCfg,
curLevelIdx=self.curLevelIdx,
}
UIManager:callWindowFunc('UIAirMiniGameMainWin','startLevel',args)
end



function airLevelSystem:getFbIdAndCurLevel()
local fbid=self.fbid
local curLevel=self.curLevel
local curLevelIdx=self.curLevelIdx
return fbid,curLevel,curLevelIdx
end

function airLevelSystem:getMaxLevel()
local id=self.fbid
local fubenCfg=cfg_airfubenconfig_get(id)
local sceneList=fubenCfg.sceneList
return#sceneList
end


function airLevelSystem:clearFbIdAndLevel()
self.curLevelIdx=nil
self.curLevel=nil
self.fbid=nil
end


function airLevelSystem:getResultFlag()
return self.resultFlag or 0
end


function airLevelSystem:setResultFlag(flag)
self.resultFlag=flag
end


function airLevelSystem:onRoundSettlement(checkStep,isFiristFinish)
if isFiristFinish==nil then isFiristFinish=true end
local resultFlag=airLevelSystem:getResultFlag()
local isVictory=resultFlag==1
if not isVictory then

checkStep=3
airLevelSystem:setActorProcessDataCheckStep(checkStep)

return airController:reqFbSettlement(resultFlag)
end


if not checkStep then
local hasNextLevel=airLevelSystem:checkHasNextLevel()
if hasNextLevel then

checkStep=0

self:checkMoneyGain()
else

checkStep=3
end

if isFiristFinish then
airBuffSystem:onUpEquipOrAttrs()
end
airController:levelFinishPrint()
end

if checkStep<1 then
local processData=airModel:getActorProcessData()

local boxCount=processData.gotBoxCount
local hasReward=boxCount>0
if hasReward then
airLevelSystem:setActorProcessDataCheckStep(checkStep)

return airController:reqRefreshSettlementData(1)
else
checkStep=1
end
end

if checkStep<2 then

local hasLevelUp=airActorSystem:checkActorCanLevelUp()
if hasLevelUp then

airLevelSystem:setActorProcessDataCheckStep(checkStep)

return airController:reqRefreshSettlementData(2)
else
checkStep=2
end
end

if checkStep<3 then

airLevelSystem:setActorProcessDataCheckStep(checkStep)

return airController:reqRefreshSettlementData(3)
end

if checkStep>=3 and checkStep<4 then

airLevelSystem:setActorProcessDataCheckStep(checkStep)


return airController:reqFbSettlement(resultFlag)
end
end

function airLevelSystem:setActorProcessDataCheckStep(checkStep)
local processData=airModel:getActorProcessData()
processData.checkStep=checkStep
airModel:setActorProcessData(processData)
end


function airLevelSystem:checkMoneyGain()
local attrType=aiAttributeType.eGain
local attrVal=airActorSystem:getActorAttrValByAttrId(attrType)
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local roundNum=curLevelIdx
local addMoneyVal
local gainMoneyCoef=cfgHelper.get(cfg_aircommonconfig_get,1,"gainMoneyCoef")or 0
if roundNum<=20 then

addMoneyVal=math.ceil(attrVal+attrVal*gainMoneyCoef*roundNum)
else

addMoneyVal=math.ceil(attrVal+attrVal*0.2)
end
airModel:addMoney(addMoneyVal)
end


function airLevelSystem:test_endNowLevel()
self.isfinish=nil
airEntitySystem:clearAllEntity()
self.entities=nil
self.countTimeStamp=nil
self.pauseStamp_start=nil
self.pauseStamp_end=nil
self.pauseTime=nil
self.isStart=false
self.spwanTime=nil
self.startTime=nil
self.waitStartTime=nil
self.waitEndTime=nil
self.spwanTimeStamp=nil
self.round=nil
self.tRound=nil
self.spwanPointInfoList=nil
self.speSpwan=nil
self.levelCfg=nil


self.entitiesCount=nil
self.droplist=nil
self.monsterIdex=nil
UIManager:callWindowFunc('UIAirMiniGameMainWin','endLevel')
end


function airLevelSystem:test_changeTimeToEnd()
self.countTimeStamp=airController:getRealServerTime_short()
end

