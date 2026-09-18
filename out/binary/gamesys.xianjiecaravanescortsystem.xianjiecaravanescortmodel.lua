






local _MODULENAME="xianJieCaravanEscortModel"


def_table(_MODULENAME)
xianJieCaravanEscortModel.name=_MODULENAME
xianJieCaravanEscortModel.data={}

local _shipModelIdList={
[1]={
[0]=6321,
[1]=6322,
[2]=6323,
},
[2]={
[0]=6324,
[1]=6325,
[2]=6326,
},
[3]={
[0]=6327,
[1]=6328,
[2]=6329,
},
[4]={
[0]=6330,
[1]=6331,
[2]=6332,
},
[5]={
[0]=6333,
[1]=6334,
[2]=6335,
},
}


function xianJieCaravanEscortModel:onAppStart()

end


function xianJieCaravanEscortModel:onEnterState(isReconnect)

end


function xianJieCaravanEscortModel:onProtocolReq()

end


function xianJieCaravanEscortModel:onLeaveState(isReconnect)

self.data={}
end




function xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMiaoXingShangLv)then
return true
end
return false
end


function xianJieCaravanEscortModel:checkIsXJCaravanEscortActOpened()
if limitActivitiesModel:getActMark_done(LIMIT_ACT_TYPE.eMiaoXingShangLv)then
return true
end
return false
end


function xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanOpen()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eMiaoXingShangLv)then
return true
end
return false
end


function xianJieCaravanEscortModel:setXJCaravanEscortActCanDispatchEndTime()
self.data.canDispatchEndTime=nil
local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if isActDoing then
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMiaoXingShangLv)
if actInfo then
local actEndTime=actInfo.end_time
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local finalTime=baseCfg.forbidden_times
self.data.canDispatchEndTime=actEndTime-finalTime
end
end
end

function xianJieCaravanEscortModel:getXJCaravanEscortActCanDispatchEndTime()
return self.data.canDispatchEndTime
end


function xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanDispatch()
if not self.data.canDispatchEndTime then
return false
end

local nowTime=timeHelper.getServerShortTime()
if nowTime<self.data.canDispatchEndTime then
return true
end

return false
end


function xianJieCaravanEscortModel:checkCanXJCaravanEscortWinJump()
local actID=LIMIT_ACT_TYPE.eMiaoXingShangLv
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo==nil then
if limitActivitiesModel:isClientAct(actID)then
UIManager.error('活动未开始')
end
return false
end

if not limitActivitiesController:checkJump(actInfo,actID)then
return false
end

if MysteryModel:is_in_mystery()then
UIManager.error("秘境内无法跳转")
return false
end

if fightModel:haveBattleShow()then
UIManager.error("战斗中无法跳转")
return false
end

return true
end


function xianJieCaravanEscortModel:setSelfEscortData(len,shipPosList,getTimes,robTimes)
self.data.selfEscortData={}
self.data.selfEscortDataLookup={}
self.data.selfEscortDiscipleLookup={}
if len>0 then

local shipPosDataList={}
local clearPosList={}
for i,v in ipairs(shipPosList)do
local pos=v.pos
shipPosDataList[pos]=v

local baseData=v.xianzhouStruct
if baseData.start_sec and baseData.start_sec>0 then

clearPosList[#clearPosList]=pos
end
local shipGuid=baseData.xianzhou_guid
if shipGuid and not mathHelper.compareInt64(shipGuid,Int64_0)then
local shipGuidStr=tostring(shipGuid)
self.data.selfEscortDataLookup[shipGuidStr]=pos
end

local dzListLen=baseData.disciple_list_len
if dzListLen>0 then
local dzList=baseData.disciple_list
for i,dzGuid in pairs(dzList)do
if dzGuid and not mathHelper.compareInt64(dzGuid,Int64_0)then
local dzGuidStr=tostring(dzGuid)
self.data.selfEscortDiscipleLookup[dzGuidStr]=pos
end
end
end
end
self.data.selfEscortData.shipPosDataList=shipPosDataList
xianJieCaravanEscortModel:clearEscortShipPosListTempData(clearPosList)
end











self.data.selfEscortData.getTimes=getTimes
self.data.selfEscortData.robTimes=robTimes
end

function xianJieCaravanEscortModel:getSelfEscortData()
return self.data.selfEscortData
end

function xianJieCaravanEscortModel:setSelfEscortData_getTimes(getTimes)
if self.data.selfEscortData then
self.data.selfEscortData.getTimes=getTimes
end
end

function xianJieCaravanEscortModel:setSelfEscortData_addGetTimes(addNum)
if not self.data.selfEscortData then
return
end
if not self.data.selfEscortData.getTimes then
self.data.selfEscortData.getTimes=0
end
self.data.selfEscortData.getTimes=self.data.selfEscortData.getTimes+addNum
end

function xianJieCaravanEscortModel:getSelfEscortData_getTimes()
if self.data.selfEscortData then
return self.data.selfEscortData.getTimes or 0
end
return 0
end

function xianJieCaravanEscortModel:setSelfEscortData_robTimes(robTimes)
if self.data.selfEscortData then
local originalRobTime=self.data.selfEscortData.robTimes
self.data.selfEscortData.robTimes=robTimes
if originalRobTime~=robTimes then
notifySystem:postNotify(notifyConfig.onXJCaravanEscortRobCountChange)
end
end
end

function xianJieCaravanEscortModel:getSelfEscortData_robTimes()
if self.data.selfEscortData then
return self.data.selfEscortData.robTimes or 0
end
return 0
end

function xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(posIndex)
if self.data.selfEscortData and self.data.selfEscortData.shipPosDataList then
return self.data.selfEscortData.shipPosDataList[posIndex]
end
return nil
end

function xianJieCaravanEscortModel:getAllSelfEscortShipPosDataList()
if self.data.selfEscortData then
return self.data.selfEscortData.shipPosDataList
end
return nil
end

function xianJieCaravanEscortModel:setSelfEscortShipPosData_refresh(posIndex,shipId,roundTimes,refreshTimes,rewardsLen,rewards)
if not self.data.selfEscortData or not self.data.selfEscortData.shipPosDataList then
return
end

local data=self.data.selfEscortData.shipPosDataList[posIndex]
if data then
if data.xianzhouStruct then
data.xianzhouStruct.xianzhou_id=shipId
data.xianzhouStruct.reward_list_len=rewardsLen
data.xianzhouStruct.reward_list=rewards
end
data.round_times=roundTimes
data.total_times=refreshTimes
end
end

function xianJieCaravanEscortModel:setSelfEscortShipPosData_dispatch(posIndex,shipGuid,startSec,dzListLen,dzList)
if not self.data.selfEscortData or not self.data.selfEscortData.shipPosDataList then
return
end

local data=self.data.selfEscortData.shipPosDataList[posIndex]
if data and data.xianzhouStruct then
data.xianzhouStruct.xianzhou_guid=shipGuid
data.xianzhouStruct.disciple_list_len=dzListLen
data.xianzhouStruct.disciple_list=dzList

data.xianzhouStruct.start_sec=startSec

local shipGuidStr=tostring(shipGuid)
self.data.selfEscortDataLookup[shipGuidStr]=data.pos

if dzListLen>0 then
if not self.data.selfEscortDiscipleLookup then
self.data.selfEscortDiscipleLookup={}
end

for i,dzGuid in pairs(dzList)do
if dzGuid and not mathHelper.compareInt64(dzGuid,Int64_0)then
local dzGuidStr=tostring(dzGuid)
self.data.selfEscortDiscipleLookup[dzGuidStr]=posIndex
end
end
end
end
end

function xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)
if self.data.selfEscortData and self.data.selfEscortData.shipPosDataList then










local shipGuidStr=tostring(shipGuid)
if self.data.selfEscortDataLookup[shipGuidStr]then
local pos=self.data.selfEscortDataLookup[shipGuidStr]
if pos and self.data.selfEscortData.shipPosDataList[pos]then
local data=self.data.selfEscortData.shipPosDataList[pos]
return data
end
end
end
return nil
end




















function xianJieCaravanEscortModel:checkSelfEscortShipPosHasReward()
if not self.data.selfEscortData or not self.data.selfEscortData.shipPosDataList then
return false
end

local nowTime=timeHelper.getServerShortTime()
local dataList=self.data.selfEscortData.shipPosDataList
for posIdx,posData in pairs(dataList)do
local posBaseData=posData.xianzhouStruct
local startTime=posBaseData.start_sec or 0
if startTime and startTime>0 then
local shipId=posBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local endTime
if startTime and startTime>0 then
endTime=startTime+duration
if nowTime>=endTime then
return true
end
end
end
end
end

return false
end


function xianJieCaravanEscortModel:checkSelfEscortShipPosHasNotGoShip()

local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if isActDoing then

local isInDispatchTime=xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanDispatch()
if isInDispatchTime then

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxDailyTimes=baseCfg.daily_times
local curGetTimes=xianJieCaravanEscortModel:getSelfEscortData_getTimes()or 0
if curGetTimes<maxDailyTimes then
local shipPosList=xianJieCaravanEscortModel:getAllSelfEscortShipPosDataList()
if shipPosList then
for posIdx,posData in pairs(shipPosList)do
local posBaseData=posData.xianzhouStruct
local startTime=posBaseData.start_sec or 0
if not startTime or startTime<=0 then
return true
end
end
end
end
end
end

return false
end

function xianJieCaravanEscortModel:checkHasRemainingRobCount()
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxRobNum=baseCfg and baseCfg.rob_times or 0
local robTimes=xianJieCaravanEscortModel:getSelfEscortData_robTimes()
local remainingCount=maxRobNum-robTimes
return remainingCount>0
end



function xianJieCaravanEscortModel:setAllShipTeamData(len,shipDataList)
local shipTeamDataLookup={}
local shipTeamDataKeyList={}
local shipTeamDataKey2IndexList={}


local otherXmShipLookup={}
local otherXmShipKeyList={}
local otherXmShipKey2IndexList={}


local otherXianYuShipLookup={}
local otherXianYuShipKeyList={}
local otherXianYuShipKey2IndexList={}

local needResetPathShipGuidList={}

if len>0 then
local selfHasXM=xianmengModel:hasXM()
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local selfXYSceneIdx=xianjieModel:getXianYuSceneIndex()
for i,v in ipairs(shipDataList)do
local isSelfXm=false
local initiatorActorId=v.actor_id
local isSelfInitiator=playerModel:checkActorId(initiatorActorId)


local xmData=v.guildInfo
local xmGuid=xmData.param_1
if selfXMGuid and mathHelper.compareInt64(xmGuid,selfXMGuid)then
isSelfXm=true
end
local baseData=v.xianzhouStruct
local guid=baseData.xianzhou_guid
local shipGuidStr=tostring(guid)

if not isSelfXm and not isSelfInitiator then
otherXmShipLookup[shipGuidStr]=v
local index=#otherXmShipKeyList+1
otherXmShipKeyList[index]=shipGuidStr
otherXmShipKey2IndexList[shipGuidStr]=index
end

local hasPath=xianJieCaravanEscortModel:checkHasPathData(v)
if not hasPath and isSelfInitiator then
needResetPathShipGuidList[#needResetPathShipGuidList+1]=guid
end

local sceneIdx=v.scene_idx
local isSelfXianYu=selfXYSceneIdx and sceneIdx==selfXYSceneIdx or false
if not isSelfXianYu then
otherXianYuShipLookup[shipGuidStr]=v
local index=#otherXianYuShipKeyList+1
otherXianYuShipKeyList[index]=shipGuidStr
otherXianYuShipKey2IndexList[shipGuidStr]=index
end

shipTeamDataLookup[shipGuidStr]=v
local index=#shipTeamDataKeyList+1
shipTeamDataKeyList[index]=shipGuidStr
shipTeamDataKey2IndexList[shipGuidStr]=index
end
end
self.data.shipTeamDataLookup=shipTeamDataLookup
self.data.shipTeamDataKeyList=shipTeamDataKeyList
self.data.shipTeamDataKey2IndexList=shipTeamDataKey2IndexList


self.data.shipTeamDataLookup_otherXm=otherXmShipLookup
self.data.shipTeamDataKeyList_otherXm=otherXmShipKeyList
self.data.shipTeamDataKey2IndexList_otherXm=otherXmShipKey2IndexList

self.data.shipTeamDataLookup_otherXianYu=otherXianYuShipLookup
self.data.shipTeamDataKeyList_otherXianYu=otherXianYuShipKeyList
self.data.shipTeamDataKey2IndexList_otherXianYu=otherXianYuShipKey2IndexList

if next(needResetPathShipGuidList)then
for _,guid in ipairs(needResetPathShipGuidList)do
xianJieCaravanEscortController:resetCaravanEscortTeamPathParamByShipGuid(guid)
end
end
end


function xianJieCaravanEscortModel:checkHasPathData(shipData)
local pathDataStr=shipData and shipData.param or nil
if pathDataStr~=nil and pathDataStr~=""then
local pathParam=jsonHelper.decode(pathDataStr)
if pathParam and next(pathParam)then
return true
end
end
return false
end

function xianJieCaravanEscortModel:refreshShipTeamData(shipData,shipGuid)
if not shipGuid then
shipGuid=shipData and shipData.xianzhouStruct and shipData.xianzhouStruct.xianzhou_guid
end
local hasPath_now=xianJieCaravanEscortModel:checkHasPathData(shipData)
local setDataType,hasPath_original=xianJieCaravanEscortModel:setShipTeamData(shipData,shipGuid)
if setDataType==2 then
local isSelfTeam=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)~=nil
if isSelfTeam then
xianJieCaravanEscortController:addCaravanEscortTeamByShipGuid(shipGuid)
end
elseif setDataType==1 then

local guidStr=tostring(shipGuid)
local sceneidx=shipData.scene_idx
local data={guidStr=guidStr,sceneidx=sceneidx}
xianjieModel:refreshCaravanEscortTeamData(data)

if not hasPath_now and not self.data.test_ignoreResetPathMode then

local initiatorActorId=shipData.actor_id
local isSelfInitiator=playerModel:checkActorId(initiatorActorId)
if isSelfInitiator then

xianJieCaravanEscortController:resetCaravanEscortTeamPathParamByShipGuid(shipGuid)
end

elseif not hasPath_original then

xianJieCaravanEscortController:refreshCaravanEscortTeamPath(shipGuid)
end
elseif setDataType==3 then

xianJieCaravanEscortModel:clearShipTeamDetailData(shipGuid)
end
end

function xianJieCaravanEscortModel:setShipTeamData(shipData,shipGuid)
local shipBaseData=shipData and shipData.xianzhouStruct or nil
local guid=shipBaseData and shipBaseData.xianzhou_guid or shipGuid
if not guid then
return
end

local shipGuidStr=tostring(guid)
local setDataType=1

local addFunc=function(keyList,key2IndexList,shipGuidStr)
if not key2IndexList[shipGuidStr]then
local index=#keyList+1
keyList[index]=shipGuidStr
key2IndexList[shipGuidStr]=index
end
end

local removeFunc=function(keyList,key2IndexList,shipGuidStr)
if key2IndexList[shipGuidStr]then
local index=key2IndexList[shipGuidStr]
local lastKey=keyList[#keyList]
keyList[index]=lastKey
key2IndexList[lastKey]=index
keyList[#keyList]=nil
key2IndexList[shipGuidStr]=nil
end
end

local hasPath_original=false
if self.data.shipTeamDataLookup then
local keyList=self.data.shipTeamDataKeyList
local key2IndexList=self.data.shipTeamDataKey2IndexList
if self.data.shipTeamDataLookup[shipGuidStr]then

local originalShipData=self.data.shipTeamDataLookup[shipGuidStr]
hasPath_original=xianJieCaravanEscortModel:checkHasPathData(originalShipData)
self.data.shipTeamDataLookup[shipGuidStr]=shipData
if shipData==nil then

removeFunc(keyList,key2IndexList,shipGuidStr)
setDataType=3
end
else

self.data.shipTeamDataLookup[shipGuidStr]=shipData
addFunc(keyList,key2IndexList,shipGuidStr)
setDataType=2
end
end


local selfHasXM=xianmengModel:hasXM()
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local selfXYSceneIdx=xianjieModel:getXianYuSceneIndex()
local isSelfXm=false
local initiatorActorId=shipData and shipData.actor_id
local isSelfInitiator=playerModel:checkActorId(initiatorActorId)
local xmData=shipData and shipData.guildInfo
local xmGuid=xmData and xmData.param_1
if selfXMGuid and xmGuid and mathHelper.compareInt64(xmGuid,selfXMGuid)then
isSelfXm=true
end

local sceneIdx=shipData and shipData.scene_idx
local isSelfXianYu=selfXYSceneIdx and sceneIdx==selfXYSceneIdx or false


if self.data.shipTeamDataLookup_otherXm then
local keyList=self.data.shipTeamDataKeyList_otherXm
local key2IndexList=self.data.shipTeamDataKey2IndexList_otherXm
local isNeedRefreshEnemyType=false
if self.data.shipTeamDataLookup_otherXm[shipGuidStr]then
if not isSelfXm and not isSelfInitiator then

self.data.shipTeamDataLookup_otherXm[shipGuidStr]=shipData
if shipData==nil then

removeFunc(keyList,key2IndexList,shipGuidStr)
end
else

removeFunc(keyList,key2IndexList,shipGuidStr)
isNeedRefreshEnemyType=true
end
else
if not isSelfXm and not isSelfInitiator then

self.data.shipTeamDataLookup_otherXm[shipGuidStr]=shipData
addFunc(keyList,key2IndexList,shipGuidStr)
isNeedRefreshEnemyType=true
end
end

if isNeedRefreshEnemyType then
xianJieCaravanEscortController:refreshCEShipEntityEnemyTypeByGuidStr(shipGuidStr)
end
end

if self.data.shipTeamDataLookup_otherXianYu then
local keyList=self.data.shipTeamDataKeyList_otherXianYu
local key2IndexList=self.data.shipTeamDataKey2IndexList_otherXianYu
if self.data.shipTeamDataLookup_otherXianYu[shipGuidStr]then

self.data.shipTeamDataLookup_otherXianYu[shipGuidStr]=shipData
if shipData==nil then

removeFunc(keyList,key2IndexList,shipGuidStr)
end
else
if not isSelfXianYu then

self.data.shipTeamDataLookup_otherXianYu[shipGuidStr]=shipData
addFunc(keyList,key2IndexList,shipGuidStr)
end
end
end

return setDataType
end

function xianJieCaravanEscortModel:removeOtherXmShipTeamData(shipGuid)
local shipGuidStr=tostring(shipGuid)
if self.data.shipTeamDataLookup_otherXm then
local keyList=self.data.shipTeamDataKeyList_otherXm
local key2IndexList=self.data.shipTeamDataKey2IndexList_otherXm
if self.data.shipTeamDataLookup_otherXm[shipGuidStr]then

self.data.shipTeamDataLookup_otherXm[shipGuidStr]=nil

if key2IndexList[shipGuidStr]then
local index=key2IndexList[shipGuidStr]
local lastKey=keyList[#keyList]
keyList[index]=lastKey
key2IndexList[lastKey]=index
keyList[#keyList]=nil
key2IndexList[shipGuidStr]=nil
end
end
end
end


function xianJieCaravanEscortModel:checkAndResetOtherXmShipTeamData()
local shipTeamDataLookup=self.data.shipTeamDataLookup
local shipTeamDataKeyList=self.data.shipTeamDataKeyList
local shipTeamDataKey2IndexList=self.data.shipTeamDataKey2IndexList

if not shipTeamDataKeyList then

return
end


local otherXmShipLookup={}
local otherXmShipKeyList={}
local otherXmShipKey2IndexList={}
local changeGuidStrList={}
local originalOtherXmShipLookup=self.data.shipTeamDataLookup_otherXm

if#shipTeamDataKeyList>0 then
local selfHasXM=xianmengModel:hasXM()
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
for i,shipGuidStr in ipairs(shipTeamDataKeyList)do
local isSelfXm=false
local shipData=shipTeamDataLookup[shipGuidStr]
if shipData then
local initiatorActorId=shipData.actor_id
local isSelfInitiator=playerModel:checkActorId(initiatorActorId)
local xmData=shipData.guildInfo
local xmGuid=xmData.param_1
if selfXMGuid and mathHelper.compareInt64(xmGuid,selfXMGuid)then
isSelfXm=true
end

if not isSelfXm and not isSelfInitiator then
otherXmShipLookup[shipGuidStr]=shipData
local index=#otherXmShipKeyList+1
otherXmShipKeyList[index]=shipGuidStr
otherXmShipKey2IndexList[shipGuidStr]=index

if not originalOtherXmShipLookup[shipGuidStr]then

changeGuidStrList[#changeGuidStrList+1]=shipGuidStr
end
else
if originalOtherXmShipLookup[shipGuidStr]then

changeGuidStrList[#changeGuidStrList+1]=shipGuidStr
end
end
end
end
end

self.data.shipTeamDataLookup_otherXm=otherXmShipLookup
self.data.shipTeamDataKeyList_otherXm=otherXmShipKeyList
self.data.shipTeamDataKey2IndexList_otherXm=otherXmShipKey2IndexList

return changeGuidStrList
end


function xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guid)
local shipGuidStr=tostring(guid)
if self.data.shipTeamDataLookup and self.data.shipTeamDataLookup[shipGuidStr]then
return self.data.shipTeamDataLookup[shipGuidStr]
end

return nil
end


function xianJieCaravanEscortModel:getShipTeamDataGuidList(isOtherXm,isOtherXianYu)
local keyList,key2IndexList
if isOtherXm and not isOtherXianYu then
keyList=self.data.shipTeamDataKeyList_otherXm
key2IndexList=self.data.shipTeamDataKey2IndexList_otherXm
elseif isOtherXm and isOtherXianYu then
keyList=self.data.shipTeamDataKeyList_otherXianYu
key2IndexList=self.data.shipTeamDataKey2IndexList_otherXianYu
else
keyList=self.data.shipTeamDataKeyList
key2IndexList=self.data.shipTeamDataKey2IndexList
end

return keyList,key2IndexList
end


function xianJieCaravanEscortModel:getPlunderShipRandomKeyList(isOtherXianYu,isReset)
if isOtherXianYu then
if not isReset and self.data.plunderShipRandomList_otherXianYu then
return self.data.plunderShipRandomList_otherXianYu
end
else
if not isReset and self.data.plunderShipRandomList then
return self.data.plunderShipRandomList
end
end

local randomKeyList={}
local shipKeyList,key2IndexList=self:getShipTeamDataGuidList(true,isOtherXianYu)
local maxCount=shipKeyList and#shipKeyList or 0

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local randomCount=baseCfg.randomPlunderShipCount
if maxCount<randomCount then
randomCount=maxCount
end

local nowTime=timeHelper.getServerShortTime()
local checkCanRobFunc=function(guidStr)
if not guidStr then
return false
end

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
if shipData then
local isExpire=false
local isOverRobCount=false
local shipBaseData=shipData.xianzhouStruct
local robbedTimes=shipBaseData.robbed_times or 0
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxRobbedNum=baseCfg and baseCfg.be_robbed_times or 0
isOverRobCount=robbedTimes>=maxRobbedNum

local shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
isExpire=startTime>0 and nowTime>=(startTime+duration)or false
end

local isCanRob=not isExpire and not isOverRobCount
return isCanRob
end
end

if maxCount>1 then
for i=1,maxCount do
local randomIdx=math.random(i,maxCount)
local guidStr=shipKeyList[randomIdx]
local originalGuidStr=shipKeyList[i]
shipKeyList[i]=guidStr
key2IndexList[guidStr]=i
shipKeyList[randomIdx]=originalGuidStr
key2IndexList[originalGuidStr]=randomIdx
local isCanRob=checkCanRobFunc(guidStr)
if isCanRob then
randomKeyList[#randomKeyList+1]=guidStr
if#randomKeyList>=randomCount then
break
end
end
end
else
local guidStr=shipKeyList and shipKeyList[1]or nil
local isCanRob=checkCanRobFunc(guidStr)
if isCanRob then
randomKeyList[1]=guidStr
end
end

if isOtherXianYu then
self.data.plunderShipRandomList_otherXianYu=randomKeyList
else
self.data.plunderShipRandomList=randomKeyList
end

return randomKeyList

end


function xianJieCaravanEscortModel:getXJShowShipList(isReset)
if not isReset and self.data.xjShowShipList then
return self.data.xjShowShipList
end

local showShipList={}
local showShipKeyLookup={}
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local randomCount=baseCfg.randomShowShipCount
local shipKeyList,key2IndexList=xianJieCaravanEscortModel:getShipTeamDataGuidList()
local maxCount=shipKeyList and#shipKeyList or 0
if maxCount<randomCount then
randomCount=maxCount
end

local nowTime=timeHelper.getServerShortTime()
local checkCanShowFunc=function(guidStr)
if not guidStr then
return false
end

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
if shipData then
local isExpire=false
local shipBaseData=shipData.xianzhouStruct
local endTime

local shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
endTime=startTime+duration
isExpire=startTime>0 and nowTime>=endTime or false
end

local isCanShow=not isExpire
return isCanShow,endTime
end

return false
end

if maxCount>1 then

local mustShowShipList=xianJieCaravanEscortModel:getMustShowShipList()
for i,v in ipairs(mustShowShipList)do
local guidStr=v.guidStr
local posIdx=v.posIdx
local sceneidx=v.sceneidx
if not showShipKeyLookup[guidStr]then
local isCanShow,endTime=checkCanShowFunc(guidStr)
if isCanShow then
local index=#showShipList+1
showShipList[index]={guidStr=guidStr,sceneidx=sceneidx,posIdx=posIdx,endTime=endTime}
showShipKeyLookup[guidStr]=index
end
end
end

if#showShipList<randomCount then

for i=1,maxCount do
local randomIdx=math.random(i,maxCount)
local guidStr=shipKeyList[randomIdx]
local originalGuidStr=shipKeyList[i]
shipKeyList[i]=guidStr
key2IndexList[guidStr]=i
shipKeyList[randomIdx]=originalGuidStr
key2IndexList[originalGuidStr]=randomIdx
if not showShipKeyLookup[guidStr]then
local isCanShow,endTime=checkCanShowFunc(guidStr)
if isCanShow then
local index=#showShipList+1
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local sceneidx=shipData and shipData.scene_idx
showShipList[index]={guidStr=guidStr,sceneidx=sceneidx,endTime=endTime}
showShipKeyLookup[guidStr]=index
if#showShipList>=randomCount then
break
end
end
end
end
end
else
local guidStr=shipKeyList and shipKeyList[1]or nil
if not showShipKeyLookup[guidStr]then
local isCanShow,endTime=checkCanShowFunc(guidStr)
if isCanShow then
local index=1
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(guidStr)
local posIdx=posData and posData.pos or nil
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local sceneidx=shipData and shipData.scene_idx
showShipList[index]={guidStr=guidStr,sceneidx=sceneidx,posIdx=posIdx,endTime=endTime}
showShipKeyLookup[guidStr]=index
end
end
end

self.data.xjShowShipList=showShipList
self.data.xjShowShipLookup=showShipKeyLookup

return showShipList
end

function xianJieCaravanEscortModel:getXJShowShipListLookup()
if self.data.xjShowShipLookup then
return self.data.xjShowShipLookup
end
end

function xianJieCaravanEscortModel:getMustShowShipList()
local shipList={}
local shipLookup={}


local selfEscortData=xianJieCaravanEscortModel:getSelfEscortData()
local shipPosDataList=selfEscortData and selfEscortData.shipPosDataList or nil
if shipPosDataList then
local selfXySceneIdx=xianjieModel:getXianYuSceneIndex()
for posIdx,posData in pairs(shipPosDataList)do
local baseData=posData.xianzhouStruct
local guid=baseData.xianzhou_guid
if guid and not mathHelper.compareInt64(guid,Int64_0)then
local guidStr=tostring(guid)
if not shipLookup[guidStr]then
local index=#shipList+1
shipList[index]={guidStr=guidStr,sceneidx=selfXySceneIdx,posIdx=posIdx}
end
end
end
end


local plunderShipKeyList_notSameXM=xianJieCaravanEscortModel:getPlunderShipRandomKeyList()
if plunderShipKeyList_notSameXM then
for i,guidStr in ipairs(plunderShipKeyList_notSameXM)do
if not shipLookup[guidStr]then
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local sceneidx=shipData and shipData.scene_idx
local index=#shipList+1
shipList[index]={guidStr=guidStr,sceneidx=sceneidx}
end
end
end
local plunderShipKeyList_notSameXY=xianJieCaravanEscortModel:getPlunderShipRandomKeyList(true)
if plunderShipKeyList_notSameXY then
for i,guidStr in ipairs(plunderShipKeyList_notSameXY)do
if not shipLookup[guidStr]then
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local sceneidx=shipData and shipData.scene_idx
local index=#shipList+1
shipList[index]={guidStr=guidStr,sceneidx=sceneidx}
end
end
end

return shipList
end

function xianJieCaravanEscortModel:addXJShowShipData(shipGuid)
if not self.data.xjShowShipList then

xianJieCaravanEscortModel:getXJShowShipList()
end

local guidStr=tostring(shipGuid)
if self.data.xjShowShipLookup[guidStr]then

return false
end

local nowTime=timeHelper.getServerShortTime()
local checkCanShowFunc=function(guidStr)
if not guidStr then
return false
end

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
if shipData then
local isExpire=false
local shipBaseData=shipData.xianzhouStruct
local endTime

local shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
endTime=startTime+duration
isExpire=startTime>0 and nowTime>=endTime or false
end

local isCanShow=not isExpire
return isCanShow,endTime
end

return false
end
local isCanShow,endTime=checkCanShowFunc(guidStr)
if isCanShow then
local showShipList=self.data.xjShowShipList
local showShipKeyLookup=self.data.xjShowShipLookup
local index=#showShipList+1
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local sceneidx=shipData and shipData.scene_idx
showShipList[index]={guidStr=guidStr,sceneidx=sceneidx,endTime=endTime}
showShipKeyLookup[guidStr]=index

return true,showShipList[index]
end

return false
end

function xianJieCaravanEscortModel:removeXJShowShipData(shipGuid)
if not self.data.xjShowShipList then
return false
end

local guidStr=tostring(shipGuid)
if not self.data.xjShowShipLookup[guidStr]then

return false
end

local removeIdx=self.data.xjShowShipLookup[guidStr]
local finalIdx=#self.data.xjShowShipList
local finalGuidStr=self.data.xjShowShipList[finalIdx].guidStr

self.data.xjShowShipList[removeIdx]=self.data.xjShowShipList[finalIdx]
self.data.xjShowShipLookup[finalGuidStr]=removeIdx
self.data.xjShowShipList[finalIdx]=nil
self.data.xjShowShipLookup[guidStr]=nil



return true
end


function xianJieCaravanEscortModel:checkAndAddXJShowShipData()
if not self.data.xjShowShipList then

xianJieCaravanEscortModel:getXJShowShipList()
end

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local randomCount=baseCfg.randomShowShipCount
local shipKeyList,key2IndexList=xianJieCaravanEscortModel:getShipTeamDataGuidList()
local maxCount=shipKeyList and#shipKeyList or 0
if maxCount<randomCount then
randomCount=maxCount
end

local nowShowShipCount=#self.data.xjShowShipList


local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local showShipCacheCount=baseCfg.showShipCacheCount
if nowShowShipCount>=randomCount or randomCount-nowShowShipCount<showShipCacheCount then

return false
end

local showShipList=self.data.xjShowShipList
local showShipKeyLookup=self.data.xjShowShipLookup

local nowTime=timeHelper.getServerShortTime()
local checkCanShowFunc=function(guidStr)
if not guidStr then
return false
end

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
if shipData then
local isExpire=false
local shipBaseData=shipData.xianzhouStruct
local endTime

local shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
endTime=startTime+duration
isExpire=startTime>0 and nowTime>=endTime or false
end

local isCanShow=not isExpire
return isCanShow,endTime
end
end

local addCount=0
for i=1,maxCount do
local randomIdx=math.random(i,maxCount)

local guidStr=shipKeyList[randomIdx]
local originalGuidStr=shipKeyList[i]
shipKeyList[i]=guidStr
key2IndexList[guidStr]=i
shipKeyList[randomIdx]=originalGuidStr
key2IndexList[originalGuidStr]=randomIdx

if not showShipKeyLookup[guidStr]then
local isCanShow,endTime=checkCanShowFunc(guidStr)
if isCanShow then
local index=#showShipList+1
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local sceneidx=shipData and shipData.scene_idx
showShipList[index]={guidStr=guidStr,sceneidx=sceneidx,endTime=endTime}
showShipKeyLookup[guidStr]=index
addCount=addCount+1
if#showShipList>=randomCount then
break
end
end
end
end

self.data.xjShowShipList=showShipList
self.data.xjShowShipLookup=showShipKeyLookup

return addCount>0,addCount
end


function xianJieCaravanEscortModel:getEscortShipTargetPos()
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local pos=baseCfg.targetPos

return pos
end


function xianJieCaravanEscortModel:getShipTeamModelId(color,robbedTimes)
local modelIdList=_shipModelIdList[color]
if robbedTimes<0 then
robbedTimes=0
elseif robbedTimes>2 then
robbedTimes=2
end


local modelId=modelIdList[robbedTimes]or modelIdList[0]









return modelId
end


function xianJieCaravanEscortModel:getCaravanEscortHubList()
if self.data and self.data.hubList then
return self.data.hubList
end

local hubList={}
local hubLookup={}

local loopPathSceneIdx=xianjienSceneIndexType.eXianJie
hubLookup[loopPathSceneIdx]={}
local loopPathCfgList=cfg_miaoxingshanglvlooppathconfig()
for id,cfg in ipairs(loopPathCfgList)do
local wayList=cfg.pathList
local hubTypeCfgList=cfg.hubTypeList
for i,posList in ipairs(wayList)do
local hubPos=posList[1]
local posX=hubPos[1]
local posY=hubPos[2]
local hubType=hubTypeCfgList[i]or 1

if not hubLookup[loopPathSceneIdx][posX]then
hubLookup[loopPathSceneIdx][posX]={}
end

if not hubLookup[loopPathSceneIdx][posX][posY]then
hubLookup[loopPathSceneIdx][posX][posY]=true
hubList[#hubList+1]={
sceneIdx=loopPathSceneIdx,
pos={posX,posY},
hubType=hubType,
}
end
end
end


local xyPathCfgList=cfg_miaoxingshanglvxianyupathconfig()
for sceneIdx,pathCfgList in ipairs(xyPathCfgList)do
hubLookup[sceneIdx]={}
for pathId,cfg in ipairs(pathCfgList)do
local wayList=cfg.pathList
local hubTypeCfgList=cfg.hubTypeList
for i,posList in ipairs(wayList)do
local hubPos=posList[1]
local posX=hubPos[1]
local posY=hubPos[2]
local hubType=hubTypeCfgList[i]or 1

if not hubLookup[sceneIdx][posX]then
hubLookup[sceneIdx][posX]={}
end

if not hubLookup[sceneIdx][posX][posY]then
hubLookup[sceneIdx][posX][posY]=true
hubList[#hubList+1]={
sceneIdx=sceneIdx,
pos={posX,posY},
hubType=hubType,
}
end
end
end
end
self.data.hubList=hubList
return hubList
end



function xianJieCaravanEscortModel:setEscortShipPosDzList(posIdx,dzList)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
local dzGuidStrList={}
for i,guid in ipairs(dzList)do
local guidStr=tostring(guid)
dzGuidStrList[i]=guidStr
end
local posIdxStr=tostring(posIdx)

if not tempData.escortShipPosDzList then
tempData.escortShipPosDzList={}
end
tempData.escortShipPosDzList[posIdxStr]=dzGuidStrList
userActorSetting.set('xjCaravanEscortTempData',tempData)
userActorSetting.flush()
end


function xianJieCaravanEscortModel:getEscortShipPosDzList(posIdx)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
local posIdxStr=tostring(posIdx)
if tempData.escortShipPosDzList then
return tempData.escortShipPosDzList[posIdxStr]
end
return nil
end


function xianJieCaravanEscortModel:checkOtherEscortShipPosDzListHasSameDz(posIdx,dzGuidList)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
if tempData.escortShipPosDzList then
local dzGuidStrLookup={}
for i,guid in pairs(dzGuidList)do
if not mathHelper.compareInt64(guid,Int64_0)then
local guidStr=tostring(guid)
dzGuidStrLookup[guidStr]=true
end
end

local shipPosDzList=tempData.escortShipPosDzList
for posIdxStr,shipDzGuidStrList in pairs(shipPosDzList)do
local shipPosIdx=tonumber(posIdxStr)
if shipPosIdx~=posIdx then
for i,guidStr in pairs(shipDzGuidStrList)do
if dzGuidStrLookup[guidStr]then
return true
end
end
end
end
end

return false
end


function xianJieCaravanEscortModel:clearOtherEscortShipPosDzListSameDz(posIdx,dzGuidList)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
if tempData.escortShipPosDzList then
local dzGuidStrLookup={}
for i,guid in pairs(dzGuidList)do
if not mathHelper.compareInt64(guid,Int64_0)then
local guidStr=tostring(guid)
dzGuidStrLookup[guidStr]=true
end
end

local shipPosDzList=tempData.escortShipPosDzList
for posIdxStr,shipDzGuidStrList in pairs(shipPosDzList)do
local shipPosIdx=tonumber(posIdxStr)
if shipPosIdx~=posIdx then

local teamDzCount=0
for i,guidStr in ipairs(shipDzGuidStrList)do
if dzGuidStrLookup[guidStr]then
shipDzGuidStrList[i]="0"

end
if shipDzGuidStrList[i]and shipDzGuidStrList[i]~="0"then
teamDzCount=teamDzCount+1
end
end

if teamDzCount<=0 then
shipPosDzList[posIdxStr]=nil
end
end
end
end
end


function xianJieCaravanEscortModel:setShipTeamDetailData(guid,dzListLen,dzList)
if not self.data.shipTeamDetailDataList then
self.data.shipTeamDetailDataList={}
end

if dzListLen>0 then
local guidStr=tostring(guid)
self.data.shipTeamDetailDataList[guidStr]={
guid=guid,
dzListLen=dzListLen,
dzList=dzList,


}
end
end


function xianJieCaravanEscortModel:getShipTeamDetailDataByGuid(guid)
local guidStr=tostring(guid)
if self.data.shipTeamDetailDataList then
return self.data.shipTeamDetailDataList[guidStr]
end

return nil
end


function xianJieCaravanEscortModel:clearShipTeamDetailData(guid)
if not self.data.shipTeamDetailDataList then
self.data.shipTeamDetailDataList={}
end

local guidStr=tostring(guid)
self.data.shipTeamDetailDataList[guidStr]=nil
end


function xianJieCaravanEscortModel:checkEscortShipPosIsUnlock(posIdx)
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local defaultPosNum=baseCfg.pos_num

local unlockCount=defaultPosNum

return posIdx<=unlockCount
end

function xianJieCaravanEscortModel:setShipPosSelectRewardTypeIdx(posIdx,rewardTypeIdx)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
if not tempData.selectPosRewardTypeList then
tempData.selectPosRewardTypeList={}
end
local posIdxStr=tostring(posIdx)
tempData.selectPosRewardTypeList[posIdxStr]=rewardTypeIdx
userActorSetting.set('xjCaravanEscortTempData',tempData)
userActorSetting.flush()
end

function xianJieCaravanEscortModel:getShipPosSelectRewardTypeIdx(posIdx)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
local posIdxStr=tostring(posIdx)
if tempData.selectPosRewardTypeList then
return tempData.selectPosRewardTypeList[posIdxStr]
end
return nil
end


function xianJieCaravanEscortModel:clearEscortShipPosTempData(posIdx)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
local posIdxStr=tostring(posIdx)
if tempData.escortShipPosDzList and tempData.escortShipPosDzList[posIdxStr]then
tempData.escortShipPosDzList[posIdxStr]=nil
end
if tempData.escortShipPosDzList and tempData.escortShipPosDzList[posIdxStr]then
tempData.escortShipPosDzList[posIdxStr]=nil
end
userActorSetting.set('xjCaravanEscortTempData',tempData)
userActorSetting.flush()
end


function xianJieCaravanEscortModel:clearEscortShipPosListTempData(posIdxList)
local tempData=userActorSetting.get("xjCaravanEscortTempData",{})
for _,posIdx in ipairs(posIdxList)do
local posIdxStr=tostring(posIdx)
if tempData.escortShipPosDzList and tempData.escortShipPosDzList[posIdxStr]then
tempData.escortShipPosDzList[posIdxStr]=nil
end
if tempData.escortShipPosDzList and tempData.escortShipPosDzList[posIdxStr]then
tempData.escortShipPosDzList[posIdxStr]=nil
end
end

userActorSetting.set('xjCaravanEscortTempData',tempData)
userActorSetting.flush()
end



function xianJieCaravanEscortModel:initBattleDZ(d,posIdx)
d.posIdx=posIdx
d.checkState=function(guid,isWarning)

local stateType=xianJieCaravanEscortModel:checkDZState(guid,posIdx,isWarning)
return stateType==nil
end
d.getStateIcon=function(guid)










return nil,nil
end
d.checkMask=function(guid)
local stateType=xianJieCaravanEscortModel:checkDZState(guid,posIdx)
if stateType then
return true
end
return false
end
d.isUseXJStateBg=true
d.getStateStrFunc=function(guid)
return"护送中"
end
end

function xianJieCaravanEscortModel:checkDZSortFunc(guid,posIdx)
local stateType=xianJieCaravanEscortModel:checkDZState(guid,posIdx)
if stateType then
return false
end
return true
end

function xianJieCaravanEscortModel:checkDZState(disguid,posIdx,isWarning)
local stateType,stateStr=xianJieCaravanEscortModel:getDZState(disguid,posIdx,isWarning)
if stateType~=nil then
if isWarning then
local str=FMT.fmt('该弟子正在{0}，无法派遣',stateStr)
UIManager.error(str)
end
end
return stateType
end

function xianJieCaravanEscortModel:getDZState(disguid,posIdx,showDesc)
local disguid_str=tostring(disguid)
local stateType,stateStr

local dzPosIdx=xianJieCaravanEscortModel:getEscortDzPosIdxByDzGuid(disguid)
if dzPosIdx and(not posIdx or dzPosIdx~=posIdx)then
stateType=1
stateStr="其他已派遣的护送队伍中"
end

return stateType,stateStr
end

function xianJieCaravanEscortModel:checkDZIsInPaiQian(disguid)
local stateType=xianJieCaravanEscortModel:checkDZState(disguid)
if stateType then
return true
end
return false
end

function xianJieCaravanEscortModel:clearEscortDzByPosIdx(posIdx)
if not self.data.selfEscortDiscipleLookup then
return
end

local lookup=self.data.selfEscortDiscipleLookup
for dzStr,shipPosIdx in pairs(lookup)do
if shipPosIdx==posIdx then
lookup[dzStr]=nil
end
end
end

function xianJieCaravanEscortModel:getEscortDzPosIdxByDzGuid(dzGuid)
if not dzGuid or not self.data.selfEscortDiscipleLookup then
return
end
local dzGuidStr=tostring(dzGuid)
return self.data.selfEscortDiscipleLookup[dzGuidStr]
end

function xianJieCaravanEscortModel:setCaravanEscortPlunderIsHideXianYu(isHideSelfXianYuShip)
local isHide=userActorSetting.get("xjCaravanEscortPlunderIsHideXianYu",false)
if isHide==isHideSelfXianYuShip then
return
end

userActorSetting.set('xjCaravanEscortPlunderIsHideXianYu',isHideSelfXianYuShip)
userActorSetting.flush()
end


function xianJieCaravanEscortModel:getCaravanEscortPlunderIsHideXianYu()
local isHide=userActorSetting.get("xjCaravanEscortPlunderIsHideXianYu",false)
return isHide
end

function xianJieCaravanEscortModel:checkCaravanEscortEnterReddot()

local hasRobCount=xianJieCaravanEscortModel:checkHasRemainingRobCount()
if hasRobCount then
return true
end


local hasReward=xianJieCaravanEscortModel:checkSelfEscortShipPosHasReward()
if hasReward then
return true
end


local hasNotGoShip=xianJieCaravanEscortModel:checkSelfEscortShipPosHasNotGoShip()
if hasNotGoShip then
return true
end

return false
end


function xianJieCaravanEscortModel:checkCaravanEscortHasNotGoShipReddot()
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eMiaoXingShangLv)
if not isOpen then
return false
end

local isDoingAct=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isDoingAct then
return false
end

local hasNotGoShip=xianJieCaravanEscortModel:checkSelfEscortShipPosHasNotGoShip()
if hasNotGoShip then
return true
end

return false
end


function xianJieCaravanEscortModel:checkCaravanEscortHasRewardReddot()
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eMiaoXingShangLv)
if not isOpen then
return false
end

local isDoingAct=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isDoingAct then
return false
end

local hasReward=xianJieCaravanEscortModel:checkSelfEscortShipPosHasReward()
if hasReward then
return true
end

return false
end

function xianJieCaravanEscortModel:setCaravanEscortRefreshPlunderShipCdTime()
local nowTime=timeHelper.getServerShortTime()
self.data.refreshPlunderShipCdTime=nowTime
end

function xianJieCaravanEscortModel:getCaravanEscortRefreshPlunderShipCdTime()
if self.data and self.data.refreshPlunderShipCdTime then
return self.data.refreshPlunderShipCdTime
end
return 0
end

function xianJieCaravanEscortModel:getSelfEscortShipLogList(shipGuid,startTime,shipId)
local shipGuidStr=tostring(shipGuid)
local duration=0
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
duration=shipCfg.need_time
end
local endTime=startTime+duration


local logList={}
local mxslSingletb=xianjieModel:Get_mxslSingletb()
for i,datatb in ipairs(mxslSingletb)do
local jsonStr=datatb.params
local logTime=tonumber(datatb.sec)
local tbstr=jsonHelper.decode(jsonStr)
local logShipGuid=tbstr[3]
local logShipGuidStr=logShipGuid and tostring(logShipGuid)or nil
if logShipGuidStr and logShipGuidStr==shipGuidStr then

if logTime>=startTime and logTime<=endTime then
logList[#logList+1]=datatb
end
end
end

return logList
end


function xianJieCaravanEscortModel:testFunc_setIgnoreResetPathMode(flag)
self.data.test_ignoreResetPathMode=flag
end