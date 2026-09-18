











sevenDayGoalModel={}




sevenDayGoalModel.data={}


LOCAL_CHECK_TASK_TYPE=
{
eZongmenLevel=1,
eFightValue=3,
eDiscipleCount=4,
eDiscipleCount_Jingjie=5,
eDiscipleCount_Lianti=6,
eBuildingCount_Level=8,
eGuBaoCount=21,
eSuoYaoTaCount=31,
eFriendCount=33,
eUnlockWorldBlock=52,
}

LOCAL_CHECK_FUN={
[LOCAL_CHECK_TASK_TYPE.eZongmenLevel]=function(param)

local zmLevel=zongmenModel:getLevel()
return zmLevel
end,
[LOCAL_CHECK_TASK_TYPE.eFightValue]=function(param)

local fightValue=playerModel:getActorFightValue()
return fightValue
end,
[LOCAL_CHECK_TASK_TYPE.eDiscipleCount]=function(param)

local discipleCount=UIDiscipleModel:checkDiscipleCount()
return discipleCount
end,
[LOCAL_CHECK_TASK_TYPE.eDiscipleCount_Jingjie]=function(param)

local need_jingjie=param[3]
local discipleCount=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
return discipleCount
end,
[LOCAL_CHECK_TASK_TYPE.eDiscipleCount_Lianti]=function(param)

local need_lianti=param[3]
local discipleCount=UISettingModel:getDiziCountByLiantiLv(need_lianti)
return discipleCount
end,
[LOCAL_CHECK_TASK_TYPE.eBuildingCount_Level]=function(param)

local bdId=param[3]
local needlevel=param[4]

local count=0
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do

local bdDatas=zongmenModel:getBuildingDataByBdId(v.id,bdId)
for _,bd in ipairs(bdDatas)do
if bd.level>=needlevel then
count=count+1
end
end
end
return count
end,
[LOCAL_CHECK_TASK_TYPE.eGuBaoCount]=function(param)

local gubaoCount=gubaoModel:getActiveNum()or 0
return gubaoCount
end,
[LOCAL_CHECK_TASK_TYPE.eFriendCount]=function(param)

local friend_localList=friendModel:getList(eFriendDataType.eLocal)
local friend_crossList=friendModel:getList(eFriendDataType.eCross)
local friendCount_local=friend_localList and#friend_localList or 0
local friendCount_cross=friend_crossList and#friend_crossList or 0
local friendCount=friendCount_local+friendCount_cross
return friendCount
end,
[LOCAL_CHECK_TASK_TYPE.eSuoYaoTaCount]=function(param)

local layer=shiLianTaModel:getClearLayer()
return layer
end,
[LOCAL_CHECK_TASK_TYPE.eUnlockWorldBlock]=function(param)

local worldId=param[3]
local blockId=param[4]
local num=0
if worldId and blockId then
local flag=worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)
if flag then
num=1
end
end
return num
end,
}


function sevenDayGoalModel:onAppStart()

end


function sevenDayGoalModel:onEnterState(isReconnect)

end


function sevenDayGoalModel:onLeaveState(isReconnect)

self.data={}
end




function sevenDayGoalModel:setSevenDayGoalData(taskListLen,taskList,jiFen,jinduPoint,startTime)
if taskListLen and taskListLen>0 then
for k,v in pairs(taskList)do
sevenDayGoalModel:setGoalDataByDay(v.day,v.taskListLen,v.taskList)
sevenDayGoalModel:setLibaoData(v.libaoListLen,v.libaoList)
end
end


self.data.jifen=jiFen

self.data.progressPoint=jinduPoint

self.data.startTime=timeHelper.convertShortStamp(timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(startTime)))

self:initTime()


self:setIsInitData(true)
end


function sevenDayGoalModel:setGoalDataByDay(day,dataLen,data)
if not self.data.goalData then
self.data.goalData={}
end
if dataLen and dataLen>0 then
if not self.data.goalData[day]then
self.data.goalData[day]={}
end

for k,v in pairs(data)do
sevenDayGoalModel:setGoalDataByDayAndTaskId(day,v.taskId,v)
end
end
end


function sevenDayGoalModel:setGoalDataByDayAndTaskId(day,taskId,data)
if not self.data.goalData then
return
end

if not self.data.goalData[day]then
self.data.goalData[day]={}
end

local goalConfig=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
if not goalConfig then

return
end
local taskType=goalConfig.param[1]
local checkFun=LOCAL_CHECK_FUN[taskType]
if taskType==LOCAL_CHECK_TASK_TYPE.eUnlockWorldBlock then
local worldId=goalConfig.param[3]
local blockId=goalConfig.param[4]
if not worldId or not blockId then
checkFun=nil
end
end

if checkFun==nil then

self.data.goalData[day][taskId]=data
else

local finishNum=0
if self.data.goalData[day][taskId]and self.data.goalData[day][taskId].finishNum then
finishNum=self.data.goalData[day][taskId].finishNum
end
local specialData={
taskId=data.taskId,
finishNum=finishNum,
finishFlag=data.finishFlag,
rewardFlag=data.rewardFlag,
}
self.data.goalData[day][taskId]=specialData
end


end


function sevenDayGoalModel:getGoalDataByDayAndTaskId(day,taskId)
if self.data.goalData[day]and self.data.goalData[day][taskId]then
return self.data.goalData[day][taskId]
end

return nil
end


function sevenDayGoalModel:setLibaoData(dataLen,data)
if not self.data.libaoData then
self.data.libaoData={}
end
if dataLen and dataLen>0 then
for k,v in pairs(data)do
sevenDayGoalModel:setLibaoDataByLibaoId(v.libaoId,v)
end
end
end


function sevenDayGoalModel:setLibaoDataByLibaoId(libaoId,data)

self.data.libaoData[libaoId]=data
end


function sevenDayGoalModel:getLibaoDataByLibaoId(libaoId)
if self.data.libaoData and self.data.libaoData[libaoId]then
return self.data.libaoData[libaoId]
end

return nil
end


function sevenDayGoalModel:setJifen(jifen)
self.data.jifen=jifen
end


function sevenDayGoalModel:getJifen()
return self.data.jifen or 0
end


function sevenDayGoalModel:setProgressPoint(progressPoint)
self.data.progressPoint=progressPoint
end


function sevenDayGoalModel:getProgressPoint()
return self.data.progressPoint
end


function sevenDayGoalModel:setTaskFinishNumByDayAndTaskId(day,taskId,finishNum)
if self.data.goalData[day]and self.data.goalData[day][taskId]then
self.data.goalData[day][taskId].finishNum=finishNum
end
end


function sevenDayGoalModel:initTime()
local dayCfg=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1)
local dayCount=dayCfg.days

local endDayCount=dayCfg.showDays
self.data.endTime=self.data.startTime+endDayCount*86400


self.data.dayTime={}
for i=1,dayCount do
self.data.dayTime[i]=self.data.startTime+(i-1)*86400
sevenDayGoalModel:checkDayLock(i)
end


self.data.finalTime=self.data.startTime+dayCount*86400
end


function sevenDayGoalModel:checkDayLock(day)

if not self.data.isInitData then

return true
end

local nowTime=gameUtilityModel.getServerShortTime()
local endTime=self.data.dayTime[day]
local tmpTime=endTime-nowTime
local isLock=tmpTime>0

if isLock then

if not self.data.nextOpenDay or day<self.data.nextOpenDay then
self.data.nextOpenDay=day
end
else

if self.data.nextOpenDay and day>=self.data.nextOpenDay then

self.data.nextOpenDay=self.data.nextOpenDay+1
local dayCount=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1).days
if self.data.nextOpenDay>dayCount then

self.data.nextOpenDay=nil
end
end
end

return isLock
end


function sevenDayGoalModel:getNextOpenDay()
if self.data.nextOpenDay then
return self.data.nextOpenDay
end
return nil
end


function sevenDayGoalModel:getStartTime()
if self.data.startTime then
return self.data.startTime
end
return nil
end


function sevenDayGoalModel:getDayTime(day)
if self.data.dayTime then
return self.data.dayTime[day]
end
return nil
end


function sevenDayGoalModel:getEndTime()
if self.data.endTime then
return self.data.endTime
end
return nil
end


function sevenDayGoalModel:getFinalTime()
if self.data.finalTime then
return self.data.finalTime
end
return nil
end


function sevenDayGoalModel:checkFinalTime()
local isFinal=false
local nowTime=gameUtilityModel.getServerShortTime()
local finalTime=self.data.finalTime
if finalTime then
local tmpTime=finalTime-nowTime
isFinal=tmpTime<=0
end

return isFinal
end


function sevenDayGoalModel:checkIsEnd()
if self.data.startTime then

local nowTime=gameUtilityModel.getServerShortTime()
local endDayCount=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1).showDays
local addTime=endDayCount*86400
local endTime=self.data.startTime+addTime
local tmpTime=endTime-nowTime
if tmpTime>0 then
return false
else
return true
end
else

return nil
end
end


function sevenDayGoalModel:checkGoalIsFinish(day,taskId)
local isFinish=false
if self.data.goalData[day]and self.data.goalData[day][taskId]then
if self.data.goalData[day][taskId].finishFlag==1 then
isFinish=true
else
local finishNum=sevenDayGoalModel:getGoalProgress(day,taskId)
local need=sevenDayGoalModel:getTaskNeedCountByTaskId(taskId)
if not need then
need=1
end
if finishNum>=need then
sevenDayGoalModel:setGoalFinish(day,taskId,finishNum,need)
isFinish=true
end
end
end

return isFinish
end


function sevenDayGoalModel:setGoalFinish(day,taskId,finishNum,needNum)
if not self.data.goalData[day]then
self.data.goalData[day]={}
end

if not self.data.goalData[day][taskId]then
self.data.goalData[day][taskId]={
taskId=taskId,
finishNum=finishNum,
finishFlag=0,
rewardFlag=0,
}
end
local flag=finishNum>=needNum and 1 or 0
self.data.goalData[day][taskId].finishFlag=flag
end


function sevenDayGoalModel:checkGoalIsGot(day,taskId)
local isGot=false
if self.data.goalData[day]and self.data.goalData[day][taskId]then
if self.data.goalData[day][taskId].rewardFlag==1 then
isGot=true
end
end

return isGot
end


function sevenDayGoalModel:getLibaoBuyNum(libaoId)
local buyNum=0
if self.data.libaoData and self.data.libaoData[libaoId]then
if self.data.libaoData[libaoId].buyNum then
buyNum=self.data.libaoData[libaoId].buyNum
end
end

return buyNum
end


function sevenDayGoalModel:getGoalProgress(day,taskId,isRecv)
local finishCount=0


if not self.data.isInitData then
return finishCount
end

if self.data.goalData[day]and self.data.goalData[day][taskId]then
if self.data.goalData[day][taskId].finishNum then
finishCount=self.data.goalData[day][taskId].finishNum
end
end



local goalConfig=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
local taskType=goalConfig.param[1]
local checkFinishCount=nil
local localCheckFun=LOCAL_CHECK_FUN[taskType]
if taskType==LOCAL_CHECK_TASK_TYPE.eUnlockWorldBlock then
local worldId=goalConfig.param[3]
local blockId=goalConfig.param[4]
if not worldId or not blockId then
localCheckFun=nil
end
end

if localCheckFun~=nil then
checkFinishCount=localCheckFun(goalConfig.param)
end

if checkFinishCount and checkFinishCount~=finishCount then

finishCount=checkFinishCount

self:setTaskFinishNumByDayAndTaskId(day,taskId,finishCount)

local needCount=goalConfig.param[2]
local finishFlag=sevenDayGoalModel:checkGoalIsFinish(day,taskId)
local checkFinishByLocal=checkFinishCount>=needCount
if finishFlag~=checkFinishByLocal then

sevenDayGoalModel:setGoalFinish(day,taskId,checkFinishCount,needCount)

local win=UIManager:findActiveWindow('UISevenDayGoalWin')
if win then
win:refreshNowGoalPage(day)
end

end
end

return finishCount
end

function sevenDayGoalModel:getDayCfgByDayIndex(dayIndex)
if not self.data.dayCfg then
self.data.dayCfg={}
end

if self.data.dayCfg[dayIndex]then
return self.data.dayCfg[dayIndex]
end

local originalDayGoalCfg=cfgHelper.get(cfg_sevendaytargettasklistconfig_get,dayIndex)
local originalDayGoalCfg_task=originalDayGoalCfg.tasks
local originalDayGoalCfg_libao=originalDayGoalCfg.libao
local dayGoalCfg={}
local originalDayGoalCfg_lookup={}
local originalDayGoalTypeIndex_lookup={}
for i,cfg in ipairs(originalDayGoalCfg_task)do
local goalTypeId=cfg[1]
originalDayGoalTypeIndex_lookup[goalTypeId]=i
dayGoalCfg[i]={goalTypeId,{}}
local taskList=cfg[2]
for _,taskId in ipairs(taskList)do
local taskCfg=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
local isHide=taskCfg.hide==1
if not isHide then
originalDayGoalCfg_lookup[taskId]=true
table.insert(dayGoalCfg[i][2],taskId)
end
end
end

if self.data.goalData and self.data.goalData[dayIndex]then
local goalData=self.data.goalData[dayIndex]
for taskId,v in pairs(goalData)do
local taskCfg=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
local isHide=taskCfg.hide==1
if not isHide and not originalDayGoalCfg_lookup[taskId]then

local goalTypeId=taskCfg and taskCfg.tagId or nil
if goalTypeId then
local goalTypeIndex=originalDayGoalTypeIndex_lookup[goalTypeId]
if goalTypeIndex and dayGoalCfg[goalTypeIndex]then
table.insert(dayGoalCfg[goalTypeIndex][2],taskId)
end
end
end
end
end

local dayCfg={}
dayCfg.tasks=dayGoalCfg
dayCfg.libao=originalDayGoalCfg_libao
if self.data.isInitData then
self.data.dayCfg[dayIndex]=dayCfg
end
return dayCfg
end


function sevenDayGoalModel:getProgressCfgIndex()
if self.data.selectProgressCfgIndex then
return self.data.selectProgressCfgIndex
end

local allProgressCfg=cfg_sevendaytargetjinduconfig()
local selectCfgIndex
self.data.selectProgressCfgIndex=nil
local openStamp=timeHelper.getServerOpenLongTime()
for i,v in ipairs(allProgressCfg)do
local kfTimeParam=v.kfTime
local minTime=timeHelper.dataToTimeStam(kfTimeParam[1])
local maxTime
if kfTimeParam[2]then
if kfTimeParam[2]~="0"then
maxTime=timeHelper.dataToTimeStam(kfTimeParam[2])
end
end
if openStamp>=minTime and(not maxTime or openStamp<=maxTime)then
selectCfgIndex=v.id
break
end
end

self.data.selectProgressCfgIndex=selectCfgIndex
return selectCfgIndex
end


function sevenDayGoalModel:getProgressRewardCfg()
local progressCfgIndex=sevenDayGoalModel:getProgressCfgIndex()
local progressCfg=cfgHelper.get(cfg_sevendaytargetjinduconfig_get,progressCfgIndex)
return progressCfg.reward
end



function sevenDayGoalModel:checkEnterReddot(isRecv)

if not self.data.isInitData then
return false
end


sevenDayGoalModel:clearSevenDayGoalReddotIndex()


local allCfg=cfg_sevendaytargettasklistconfig()
local reddot=false
for i=1,#allCfg do
if sevenDayGoalModel:checkDayReddot(i,isRecv)then
reddot=true
break
end
end


if not reddot then
local progressCfg=sevenDayGoalModel:getProgressRewardCfg()
local nowJifen=sevenDayGoalModel:getJifen()
local nowProgressPoint=sevenDayGoalModel:getProgressPoint()
for i=2,#progressCfg do

local progressPoint=i
local needJifen=progressCfg[i][1]

local canGet=nowJifen>=needJifen
local isGot=nowProgressPoint>=progressPoint

if canGet and not isGot then
reddot=true
break
end

end
end

return reddot
end


function sevenDayGoalModel:checkDayReddot(day,isRecv)

if not self.data.isInitData then
return false
end


if sevenDayGoalModel:checkDayLock(day)then

return false
end

local dayCfg=sevenDayGoalModel:getDayCfgByDayIndex(day)
if not dayCfg then
logErr(FMT.fmt("第{0}天缺少相关配置 请检查配置表是否正确",day))
return false
end
local goalTypeCfg=dayCfg.tasks
local libaoCfg=dayCfg.libao
local reddot=false
for i=1,#goalTypeCfg do










local taskList=goalTypeCfg[i][2]
if taskList then
for j=1,#taskList do
local taskId=taskList[j]
local isGot=sevenDayGoalModel:checkGoalIsGot(day,taskId)
local isFinish=sevenDayGoalModel:checkGoalIsFinish(day,taskId)
local isFinalDay=sevenDayGoalModel:checkFinalTime()
if not isFinalDay then
local need=sevenDayGoalModel:getTaskNeedCountByTaskId(taskId)
if not need then
return false
end

local cur=sevenDayGoalModel:getGoalProgress(day,taskId,isRecv)
isFinish=cur>=need
end


if isFinish and not isGot then
reddot=true
if not self.data.reddotGoalTypeIndex then
self.data.reddotGoalTypeIndex=i
end
break
end
end
end

if reddot then
break
end
end


if not reddot and libaoCfg and next(libaoCfg)then
reddot=sevenDayGoalModel:checkGoalTypeReddot(day,libaoCfg[1])
end

if reddot and not self.data.reddotDayIndex then

self.data.reddotDayIndex=day
end

return reddot
end


function sevenDayGoalModel:checkGoalTypeReddot(day,goalType,isRecv)

if not self.data.isInitData then
return false
end

local reddot=false

local goalTypeCfg=cfgHelper.get1(cfg_sevendaytargetpageconfig_get,goalType)
local isLibao=false
if goalTypeCfg.isLibao and goalTypeCfg.isLibao==1 then
isLibao=true
end

if isLibao then

local libaoList=sevenDayGoalModel:getDayCfgByDayIndex(day).libao[2]
for i=1,#libaoList do
local libaoId=libaoList[i]
local libaoConfig=cfgHelper.get1(cfg_sevendaytargetlibaoconfig_get,libaoId)

local isFree=false
if not libaoConfig.buy2 and not libaoConfig.buy1 then

isFree=true
end

if isFree then
local buyCount=sevenDayGoalModel:getLibaoBuyNum(libaoId)
local isSellOut=false
if libaoConfig.buyLimit then
if buyCount>=libaoConfig.buyLimit then
isSellOut=true
end
end

if not isSellOut then

reddot=true
break
end
end
end
if reddot then
if not self.data.reddotGoalTypeIndex then
local taskCfg=sevenDayGoalModel:getDayCfgByDayIndex(day).tasks
local goalTypeIndex=#taskCfg+1
self.data.reddotGoalTypeIndex=goalTypeIndex
end
end
else

local goalTypeCfg=sevenDayGoalModel:getDayCfgByDayIndex(day).tasks
local taskList=nil
local goalTypeIndex=nil
for i=1,#goalTypeCfg do
if goalTypeCfg[i][1]==goalType then
taskList=goalTypeCfg[i][2]
goalTypeIndex=i
break
end
end

if taskList then
for i=1,#taskList do
local taskId=taskList[i]
local isGot=sevenDayGoalModel:checkGoalIsGot(day,taskId)
local isFinish=sevenDayGoalModel:checkGoalIsFinish(day,taskId)
local isFinalDay=sevenDayGoalModel:checkFinalTime()

if not isFinalDay then
local need=sevenDayGoalModel:getTaskNeedCountByTaskId(taskId)
if not need then
return false
end

local cur=sevenDayGoalModel:getGoalProgress(day,taskId,isRecv)
isFinish=cur>=need
end

if isFinish and not isGot then
reddot=true
break
end
end
end

if reddot then
if not self.data.reddotGoalTypeIndex and goalTypeIndex then
self.data.reddotGoalTypeIndex=goalTypeIndex
end
end
end



return reddot
end



function sevenDayGoalModel:checkCloseEnterBeforeEndDay()
local isClose=true

local nowProgressPoint=sevenDayGoalModel:getProgressPoint()
local progressCfg=sevenDayGoalModel:getProgressRewardCfg()
local maxProgressPointCount=#progressCfg
if nowProgressPoint<maxProgressPointCount then

isClose=false
end

if isClose then

local allCfg=cfg_sevendaytargettasklistconfig()
for i=1,#allCfg do
local day=i
local isFinish=self:checkDayAllFinish(day)
if not isFinish then

isClose=false
break
end
end
end

return isClose
end


function sevenDayGoalModel:getSevenDayGoalIndex()
return{dayIndex=self.data.saveDayIndex,goalTypeIndex=self.data.saveGoalTypeIndex}
end


function sevenDayGoalModel:setSevenDayGoalIndex(day,goalType)
self.data.saveDayIndex=day
self.data.saveGoalTypeIndex=goalType
end

function sevenDayGoalModel:clearSevenDayGoalIndex()
self.data.saveDayIndex=nil
self.data.saveGoalTypeIndex=nil
end


function sevenDayGoalModel:getSevenDayGoalReddotIndex()
local index={reddotDayIndex=self.data.reddotDayIndex,reddotGoalTypeIndex=self.data.reddotGoalTypeIndex}


self:clearSevenDayGoalReddotIndex()
return index
end


function sevenDayGoalModel:clearSevenDayGoalReddotIndex()
self.data.reddotDayIndex=nil
self.data.reddotGoalTypeIndex=nil
end


function sevenDayGoalModel:set_CheooseBoxValue(boxCheck)
self.data.boxCheck=boxCheck
end


function sevenDayGoalModel:get_CheooseBoxValue()
return self.data.boxCheck
end


function sevenDayGoalModel:setIsInitData(flag)
self.data.isInitData=flag
end


function sevenDayGoalModel:getInitData()
return self.data.isInitData
end


function sevenDayGoalModel:checkFinishDayAndNotFinishIndex()

if not self.data.isInitData then
return
end

local allCfg=cfg_sevendaytargettasklistconfig()
for i=1,#allCfg do
local day=i
local isFinish,notFinishGtIndex=self:checkDayAllFinish(day,true)
if not isFinish and notFinishGtIndex then

return day,notFinishGtIndex
end
end
end



function sevenDayGoalModel:checkDayAllFinish(day,isIgnoreLibaoGT)

if not self.data.isInitData then
return false
end

if not self.data.finishDayList then
self.data.finishDayList={}
end

if self.data.finishDayList[day]then
if self.data.finishDayList[day]==2 then
return true
elseif self.data.finishDayList[day]==1 then
if isIgnoreLibaoGT then
return true
end
end
end

if sevenDayGoalModel:checkDayLock(day)then

return false
end

local dayCfg=sevenDayGoalModel:getDayCfgByDayIndex(day)
local goalTypeCfg=dayCfg.tasks
local libaoCfg=dayCfg.libao

for i=1,#goalTypeCfg do

local taskList=goalTypeCfg[i][2]
if taskList then
for j=1,#taskList do
local taskId=taskList[j]
local isGot=sevenDayGoalModel:checkGoalIsGot(day,taskId)
if not isGot then

return false,i
end
end
end
end
self.data.finishDayList[day]=1

if not isIgnoreLibaoGT and libaoCfg and next(libaoCfg)then

local libaoGTIndex=#goalTypeCfg+1
local libaoList=libaoCfg[2]
for i=1,#libaoList do
local libaoId=libaoList[i]
local libaoConfig=cfgHelper.get1(cfg_sevendaytargetlibaoconfig_get,libaoId)
local buyCount=sevenDayGoalModel:getLibaoBuyNum(libaoId)
if libaoConfig.buyLimit and buyCount<libaoConfig.buyLimit then

return false,libaoGTIndex
end
end
self.data.finishDayList[day]=2
end

return true
end


function sevenDayGoalModel:clearFinishDayList()
self.data.finishDayList={}
end

function sevenDayGoalModel:getTaskNeedCountByTaskId(taskId)
local taskCfg=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
local need=0
local taskType=taskCfg.param[1]

if taskType==9 or taskType==19 or taskType==23 then
need=taskCfg.param[3]
elseif taskType==37 or taskType==38 or taskType==40 or taskType==43 or taskType==52 then
need=1
else
need=taskCfg.param[2]
end

if not need then
logErr(FMT.fmt("无法获取到七日目标任务id:{0} 的所需次数 请检查配置是否正确",taskId))
return nil
end

return need
end


