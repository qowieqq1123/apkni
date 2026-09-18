
local _xianYuGateListLookup=nil

function xianjieModel:initAllMoJieGateDatas()
_xianYuGateListLookup=nil
xianjieModel:clearData_allMoJieGate()
self.allMoJieGateDatas={}
self.allMoJieGateCreateEntFlag={}
self.selfXmOwnGateId=nil
self.gateAtkBuffLv=nil
self.hasFinishAtkGate=nil
end

function xianjieModel:clearData_allMoJieGate()
if self.allMoJieGateDatas and next(self.allMoJieGateDatas)then
for i,data in pairs(self.allMoJieGateDatas)do
xianjieController:removeXJClass(data)
end
self.allMoJieGateDatas=nil
end
self.selfXmOwnGateId=nil
self.hasFinishAtkGate=nil
end

function xianjieModel:onEnterMap_mojieGate()
if not self.allMoJieGateDatas then
return
end
for gateId,entityData in pairs(self.allMoJieGateDatas)do
entityData:createEntity(true)
end
end

function xianjieModel:onExitMap_mojieGate()
if not self.allMoJieGateDatas then
return
end

for gateId,entityData in pairs(self.allMoJieGateDatas)do
entityData:removeEntity()
end
end

function xianjieModel:setMoJieGateDatas(seasonId,stageId,stageType,stageIndex,dataList,isInit)
local oDatas=self:getMoJieGateDatas()
local keeps={}
if oDatas then
for gateId,data in pairs(oDatas)do
keeps[gateId]=false
end
end

if dataList then
for index,data in ipairs(dataList)do
local gateId=data.guankou_id
local entityData={
seasonId=seasonId,
stageId=stageId,
stageType=stageType,
stageIndex=stageIndex,
gateId=gateId,
hp=data.hp,
atkTime=data.attack_sec or 0,
fixTime=data.fix_sec or 0,
xmInfo=data.own_guild_info,
askSetting=data.ask_setting,
askListLen=data.ask_list_len,
askList=data.ask_list,
whiteListLen=data.whitelist_len,
whiteList=data.whitelist,
rankListLen=data.rank_len,
rankList=data.rank,
}

xianjieModel:setMoJieGateData(gateId,entityData,isInit)
keeps[gateId]=true
end
else
local allCfg=cfg_devildomscenegateconfig()
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local maxHpValue=gateBaseCfg and gateBaseCfg.guankou_hp or 10000
for gateId,config in pairs(allCfg)do
local entityData={
seasonId=seasonId,
stageId=stageId,
stageType=stageType,
stageIndex=stageIndex,
hp=maxHpValue,
atkTime=0,
fixTime=0,
askSetting=0,
askListLen=0,
whiteListLen=0,
rankListLen=0,
}
xianjieModel:setMoJieGateData(gateId,entityData,isInit)
keeps[gateId]=true
end
end

for gateId,check in pairs(keeps)do
if not check then
self:setMoJieGateData(gateId,nil,isInit)
end
end
end

function xianjieModel:setMoJieGateData(gateId,entityData,onlyData)
if not self.allMoJieGateDatas then
return
end

local temp=self.allMoJieGateDatas[gateId]

if entityData then


local whiteList_lookup={}
if entityData.whiteListLen>0 then
for _,xmData in ipairs(entityData.whiteList)do
local xmGuid=xmData.param_1
local xmGuidStr=tostring(xmGuid)
whiteList_lookup[xmGuidStr]=true
end
end
entityData.whiteList_lookup=whiteList_lookup

local rankList_lookup={}
if entityData.rankListLen>0 then
for rankNum,data in ipairs(entityData.rankList)do
local xmData=data.guild_info
local xmGuid=xmData.param_1
local xmGuidStr=tostring(xmGuid)
rankList_lookup[xmGuidStr]=data
end
end
entityData.rankList_lookup=rankList_lookup

if temp then
temp:refreshData(entityData)
temp:refreshEntity()
else


local data=xianjieController:createXJClass(xjDataType.eMoJieGate,{data=entityData,gateId=gateId})
self.allMoJieGateDatas[gateId]=data
if not onlyData then
data:createEntity(true)
end
end
else

if temp then
xianjieController:removeXJClass(temp)
self.allMoJieGateDatas[gateId]=nil
end
end
end


function xianjieModel:setMoJieGateData_passType(gateId,passType)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
if gateData then
gateData.askSetting=passType
end
end














































function xianjieModel:getMoJieGateData(gateId)
if not self.allMoJieGateDatas then
return nil
end
return self.allMoJieGateDatas[gateId]
end

function xianjieModel:getMoJieGateDataByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)
local gateId=xianjieModel:getMoJieGateIdByBuild(guidNum)
if gateId then
return xianjieModel:getMoJieGateData(gateId)
end
return nil
end

function xianjieModel:getMoJieGateDatas()
return self.allMoJieGateDatas
end





function xianjieModel:getMoJieGateAtkState(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local state=0
if gateData then
local stageId=gateData and gateData.stageId or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local cdTime_atkTime=gateBaseCfg.attack_time
local cdTime_fixTime=gateBaseCfg.fix_time
local nowTime=timeHelper.getServerShortTime()

if gateData.atkTime>0 then
local endTime=gateData.fixTime
if nowTime<=endTime then
state=1
return state
end
end

if gateData.fixTime>0 and nowTime>=gateData.fixTime then
local endTime=gateData.fixTime+cdTime_fixTime
if nowTime<=endTime then
state=2
return state
end
end
end

return state
end


function xianjieModel:checkMoJieGateIsCanPassByXMGuid(gateId,xmGuid)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
if gateData then
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS


local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local allPassChapterId=gateBaseCfg.can_pass_stage
if allPassChapterId then
local isStart=seasonController:checkSeasonStageBegined(season_id,allPassChapterId)
if isStart then
return true
end
end


local xmData=gateData and gateData.xmInfo or nil
local ownXmGuid=xmData and xmData.param_1 or nil
local hasOwn=ownXmGuid and not mathHelper.compareInt64(ownXmGuid,Int64_0)
if not hasOwn then

return false
end

if gateData.whiteList_lookup then
local xmGuidStr=tostring(xmGuid)
if gateData.whiteList_lookup[xmGuidStr]then
return true
end
end
end
return false
end


function xianjieModel:checkMoJieGateIsSelfXMCanPass(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil

if gateData then
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS


local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local allPassChapterId=gateBaseCfg.can_pass_stage
if allPassChapterId then
local isStart=seasonController:checkSeasonStageBegined(season_id,allPassChapterId)
if isStart then
return true
end
end
end

local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if not hasXM then
return false
end

local selfHasXM=xianmengModel:hasXM()
local isSelfXm=selfHasXM and hasXM and xianmengModel:isMyXM(xmGuid)
if isSelfXm then
return true
end

local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
if selfXMGuid then
return xianjieModel:checkMoJieGateIsCanPassByXMGuid(gateId,selfXMGuid)
end

return false
end


function xianjieModel:getMoJieGateSelfXMCanPassAnyGateId()
local selfHasXM=xianmengModel:hasXM()
if not selfHasXM then

return nil
end


local selfXMOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
if selfXMOwnGateId then
return selfXMOwnGateId
end


local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local selfXyGateList=xianjieModel:getMoJieGateIdListWithSelfXianYu()
if selfXyGateList then
for _,gateId in ipairs(selfXyGateList)do
local isCanPass=xianjieModel:checkMoJieGateIsCanPassByXMGuid(gateId,selfXMGuid)
if isCanPass then
return gateId
end
end
end

return nil
end



function xianjieModel:getMinHpMoJieGateIdWithSelfXMAttacking()
local minHpGateId
local minHp
local selfHasXM=xianmengModel:hasXM()
if selfHasXM then
local selfXMGuid=xianmengModel:getMyXMGuildID()
local selfXyGateList=xianjieModel:getMoJieGateIdListWithSelfXianYu()
if selfXyGateList then
local xmGuidStr=tostring(selfXMGuid)
for _,gateId in ipairs(selfXyGateList)do
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil

local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if not hasXM then

if gateData.rankList_lookup and gateData.rankList_lookup[xmGuidStr]then

if not minHp or gateData.hp<minHp then
minHp=gateData.hp
minHpGateId=gateId
end
end
end
end
if minHpGateId==nil then
for _,gateID in ipairs(selfXyGateList)do
local bxm=xianjieModel:getMoJieGateOwnXmGuid(gateID)
if bxm==nil then
minHpGateId=gateID
break
end
end
end
end
end

return minHpGateId
end


function xianjieModel:getMoJieGateIdListWithSelfXianYu()
local selfXySceneId=xianjieModel:getXianYuSceneIndex()
return xianjieModel:getMoJieGateIdListWithXianYuSceneId(selfXySceneId)
end


function xianjieModel:getMoJieGateIdListWithXianYuSceneId(xySceneId)
if _xianYuGateListLookup then
return _xianYuGateListLookup[xySceneId]
end

local lookup={}
local allCfg=cfg_devildomscenegateconfig()
for gateId,config in ipairs(allCfg)do
local sceneId=config.area
if not lookup[sceneId]then
lookup[sceneId]={}
end

local count=#lookup[sceneId]
lookup[sceneId][count+1]=gateId
end
_xianYuGateListLookup=lookup
return _xianYuGateListLookup[xySceneId]
end


function xianjieModel:getMoJieGateFinishAttackCount()
local finishAttackCount=0
local gateDataList=self:getMoJieGateDatas()
if gateDataList then
for gateId,gateEntityData in pairs(gateDataList)do
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasOwnXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasOwnXM then
finishAttackCount=finishAttackCount+1
end
end
end

return finishAttackCount
end


function xianjieModel:checkMoJieGateHasFinishAttackGate()
if self.hasFinishAtkGate then
return true
end

local gateDataList=self:getMoJieGateDatas()
if gateDataList then
for gateId,gateEntityData in pairs(gateDataList)do
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasOwnXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasOwnXM then
self.hasFinishAtkGate=true
return true
end
end
end

return false
end


function xianjieModel:getMoJieGateOwnXmGuid(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasXM then
return xmGuid
end

return nil
end


function xianjieModel:getMoJieGateAtkTime(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
if gateData then
return gateData.atkTime
end

return nil
end


function xianjieModel:getMoJieGateFixTime(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
if gateData then
return gateData.fixTime
end

return nil
end




function xianjieModel:getMoJieGateStateTime(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
local atkState=xianjieModel:getMoJieGateAtkState(gateId)
local cdTime=0
local startTime=0
local endTime=0
if not hasXM and gateData and(atkState==1 or atkState==2)then
local stageId=gateData and gateData.stageId or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
if atkState==1 then

startTime=gateData.atkTime
endTime=gateData.fixTime
cdTime=endTime-startTime
elseif atkState==2 then
cdTime=gateBaseCfg.fix_time
startTime=gateData.fixTime
endTime=startTime+cdTime
end
end

return cdTime,startTime,endTime
end


function xianjieModel:getMoJieGateRankTopOneXmGuid(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local rankList=gateData and gateData.rankList or nil
if rankList then
local topRank=rankList[1]
local xmData=topRank.guild_info
local xmGuid=xmData.param_1
local xmIcon=xmData.param_2
local xmName=xmData.param_3
return xmGuid,xmIcon,xmName
end

return nil
end


function xianjieModel:getMoJieGateSelfXianYuOwnGateXmLookup()
local lookup={}

local gateDataList=self:getMoJieGateDatas()
if gateDataList then
for gateId,gateEntityData in pairs(gateDataList)do
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasXM then
local xmGuidStr=tostring(xmGuid)
lookup[xmGuidStr]=gateId
end
end
end
return lookup
end


function xianjieModel:getMoJieGateSelfXmOwnGateId()
if self.selfXmOwnGateId then
return self.selfXmOwnGateId
end

local selfHasXm=xianmengModel:hasXM()
if not selfHasXm then
return nil
end
local selfXyGateList=xianjieModel:getMoJieGateIdListWithSelfXianYu()
if selfXyGateList then
for _,gateId in ipairs(selfXyGateList)do
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil

local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasXM then

local isSelfXM=xianmengModel:isMyXM(xmGuid)
if isSelfXM then
self.selfXmOwnGateId=gateId
break
end
end
end
end

return self.selfXmOwnGateId
end


function xianjieModel:clearMoJieGateSelfXmOwnGateId()
local originialGateId=self.selfXmOwnGateId
self.selfXmOwnGateId=nil

xianjieModel:clearMoJieGateReadAskMark_allXm(originialGateId)

return originialGateId
end


function xianjieModel:setMoJieGateReadAskMark(gateId)
local markList=userActorSetting.get("mojieGate_readAskMark",nil)
if not markList then
markList={}
end
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
if gateData and gateData.askList then
local gateIdStr=tostring(gateId)
markList[gateIdStr]={}
local gateAskMarkList=markList[gateIdStr]
local askList=gateData.askList

for _,xmData in ipairs(askList)do
local xmGuid=xmData.param_1
local xmGuidStr=tostring(xmGuid)
gateAskMarkList[xmGuidStr]=true
end
end
userActorSetting.set('mojieGate_readAskMark',markList)
userActorSetting.flush()
end


function xianjieModel:checkMoJieGateHasNotReadAskByGateId(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
if gateData and gateData.askList then
local askList=gateData.askList
local markList=userActorSetting.get("mojieGate_readAskMark",nil)
if not markList then
markList={}
end
local gateIdStr=tostring(gateId)
local gateAskMarkList=markList[gateIdStr]
for _,xmData in ipairs(askList)do
local xmGuid=xmData.param_1
local xmGuidStr=tostring(xmGuid)
if not gateAskMarkList or not gateAskMarkList[xmGuidStr]then
return true
end
end
end

return false
end


function xianjieModel:checkMoJieGateNotReadAskCountByGateId(gateId)
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local count=0
if gateData and gateData.askList then
local askList=gateData.askList
local markList=userActorSetting.get("mojieGate_readAskMark",nil)
if not markList then
markList={}
end
local gateIdStr=tostring(gateId)
local gateAskMarkList=markList[gateIdStr]
for _,xmData in ipairs(askList)do
local xmGuid=xmData.param_1
local xmGuidStr=tostring(xmGuid)
if not gateAskMarkList or not gateAskMarkList[xmGuidStr]then
count=count+1
end
end
end

return count
end


function xianjieModel:clearMoJieGateReadAskMark_allXm(gateId)
if not gateId then
return
end

local markList=userActorSetting.get("mojieGate_readAskMark",nil)
if not markList then
markList={}
end
local gateIdStr=tostring(gateId)
markList[gateIdStr]=nil
userActorSetting.set('mojieGate_readAskMark',markList)
userActorSetting.flush()
end


function xianjieModel:clearMoJieGateReadAskMark_singleXm(gateId,xmGuid)
local markList=userActorSetting.get("mojieGate_readAskMark",nil)
if not markList then
markList={}
end
local gateIdStr=tostring(gateId)
if markList[gateIdStr]then
local xmGuidStr=tostring(xmGuid)
markList[gateIdStr][xmGuidStr]=nil
end

userActorSetting.set('mojieGate_readAskMark',markList)
userActorSetting.flush()
end

function xianjieModel:checkClientBdIsMoJieGateByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)
local gateId=xianjieModel:getMoJieGateIdByBuild(guidNum)
if gateId then
return true
end
return false
end

function xianjieModel:getMoJieGateIdByBuild(build_id)
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
if buildCfg and buildCfg.clientParam then
local gateId=buildCfg.clientParam.gateId
return gateId
end

return nil
end


function xianjieModel:isMoJieGateAtk(guid)
if xianjieModel:checkClientBdIsMoJieGateByGuid(guid)then
return true
end
return false
end


function xianjieModel:getMoJieGateMaxHp(stageId,stageType)
stageId=stageId or 1
stageType=stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
return gateBaseCfg.guankou_hp
end


function xianjieModel:checkMoJieGateAtkBuff(stageId,stageType,seasonId)
stageId=stageId or 1
stageType=stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local buffCfg=gateBaseCfg and gateBaseCfg.attack_buff or nil
if buffCfg then
local stageIdx=buffCfg[1]
local dayCount=buffCfg[2]
local maxLevel=buffCfg[4]
local isStageEnded=seasonController:checkSeasonStageEnded(seasonId,stageIdx)
if isStageEnded then
local stage=seasonModel:getStage(seasonId,stageIdx)
if stage then

local beginTime=stage.beginTime or 0
if beginTime>0 then


local beginTime_zero=timeHelper.getServerZeroShortStamp(beginTime)

local afterTime=5*3600+dayCount*86400
local buffStartTime=beginTime_zero+afterTime
local nowTime=timeHelper.getServerShortTime()
if nowTime>=buffStartTime then
local deltaTime=nowTime-buffStartTime
local buffLv
if deltaTime==0 then
buffLv=1
else
local lvUpTime=86400
buffLv=math.floor(deltaTime/lvUpTime)+1
end

buffLv=buffLv<=maxLevel and buffLv or maxLevel
self.gateAtkBuffLv=buffLv
end
end
end
end
end
end

function xianjieModel:getMoJieGateAtkBuff()
if not self.gateAtkBuffLv and self.moJieGateStageInfo then
local stageId=self.moJieGateStageInfo.stageId
local stageType=self.moJieGateStageInfo.stageType
local seasonId=self.moJieGateStageInfo.seasonId
xianjieModel:checkMoJieGateAtkBuff(stageId,stageType,seasonId)
end

return self.gateAtkBuffLv
end

function xianjieModel:test_printMoJieGateAtkBuffStartTime()
local stageId=self.moJieGateStageInfo.stageId
local stageType=self.moJieGateStageInfo.stageType
local seasonId=self.moJieGateStageInfo.seasonId
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local buffCfg=gateBaseCfg and gateBaseCfg.attack_buff or nil
if buffCfg then
local stageIdx=buffCfg[1]
local dayCount=buffCfg[2]
local maxLevel=buffCfg[4]
local stage=seasonModel:getStage(seasonId,stageIdx)
if stage then
local beginTime=stage.beginTime or 0
local buffStartTime=0
local buffLv=0
if beginTime>0 then

local beginTime_zero=timeHelper.getServerZeroShortStamp(beginTime)
local afterTime=5*3600+dayCount*86400
buffStartTime=beginTime_zero+afterTime
local nowTime=timeHelper.getServerShortTime()
if nowTime>=buffStartTime then
local deltaTime=nowTime-buffStartTime
if deltaTime==0 then
buffLv=1
else
local lvUpTime=86400
buffLv=math.floor(deltaTime/lvUpTime)+1
end
end
end


end

end
end

function xianjieModel:setMoJieGateStageInfo(stageId,stageType,seasonId,stageIdx)
if not self.moJieGateStageInfo then
self.moJieGateStageInfo={}
end

self.moJieGateStageInfo.stageId=stageId
self.moJieGateStageInfo.stageType=stageType
self.moJieGateStageInfo.seasonId=seasonId
self.moJieGateStageInfo.stageIdx=stageIdx
end


function xianjieModel:checkMoJieGateHasTeam(gateId)

local teamDataList=xianjieModel:getOnlyWaiPaiTeamData()
local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
if gateCfg then
local gateBuildId=gateCfg.build_id
for _,v in ipairs(teamDataList)do
local teamData=v.teamData
local occupytype=v.occupytype
if occupytype==xjWaiPiaBaseType.eMarckTeam then

local guid=teamData.infoguid
if guid then
local sceneidx=teamData.tarsceneidx
local entityType=xianjieModel:getEntityTypeByGuid(guid,sceneidx)
if entityType and entityType==xjServerEnityType.eClientBuild then
local targetGateBuildId=mathHelper.int64_to_number(guid)
if targetGateBuildId==gateBuildId then

local actorId=teamData.actorid
if actorId and playerModel:checkActorId(actorId)then
return true,teamData.teamHandleID
end
end
end
end
end
end
end

return false
end

function xianjieModel:checkIsShowGateApplyBtn()
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
return false
end

local showGateApplyBtn=false
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
if selfXmOwnGateId then
local gateEntityData=xianjieModel:getMoJieGateData(selfXmOwnGateId)
local gateData=gateEntityData and gateEntityData.data or nil


local isAllPass=false
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local allPassChapterId=gateBaseCfg.can_pass_stage
if allPassChapterId then
local isStart=seasonController:checkSeasonStageBegined(season_id,allPassChapterId)
if isStart then
isAllPass=true
end
end

if not isAllPass then
local hasPrivilege=xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptGuanKouYaoSai)
if hasPrivilege then
showGateApplyBtn=true
end
end
end

return showGateApplyBtn
end

function xianjieModel:checkClientBuildIsGateByPos(x,y)
if not self.gateBuildPosList_lookup then
self.gateBuildPosList_lookup={}
local allClientBuildCfg=cfg_fairylandclientbuildconfig()
for id,cfg in pairs(allClientBuildCfg)do
if cfg.clientParam and cfg.clientParam.gateId then
local posX=cfg.x
local posY=cfg.y
local gateId=cfg.clientParam.gateId
if not self.gateBuildPosList_lookup[posX]then
self.gateBuildPosList_lookup[posX]={}
end
self.gateBuildPosList_lookup[posX][posY]={buildId=id,gateId=gateId}
end
end
end

if self.gateBuildPosList_lookup[x]and self.gateBuildPosList_lookup[x][y]then
local param=self.gateBuildPosList_lookup[x][y]
local buildId=param.buildId
local gateId=param.gateId
return true,buildId,gateId
end

return false
end
