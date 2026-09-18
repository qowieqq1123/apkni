









local subActivityInfo_guituxiuxing={name='guituxiuxing'}

function subActivityInfo_guituxiuxing:onInit()
self:listenNotify(notifyConfig.onDisposeClientCheckTaskTypeEvent,function(...)
self:onDisposeClientCheckTaskTypeEvent(...)
end)
end

function subActivityInfo_guituxiuxing:onStart()

end

function subActivityInfo_guituxiuxing:onDelete()
self:clearTaskListen()
end

function subActivityInfo_guituxiuxing:onDisposeClientCheckTaskTypeEvent(eventType)
if not self.data then

return
end


local needRefresh=false
if self.data.clientCheckListenList_type_lookup and next(self.data.clientCheckListenList_type_lookup)then
for tasktype,v in pairs(self.data.clientCheckListenList_type_lookup)do
if v and taskModel:checkClientCheckTaskEvent(tasktype,eventType)then
needRefresh=true
break
end
end
end

if needRefresh then

local win=UIManager:findActiveWindow('UISubAct_GuiTuXiuXingWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eGuiTuXiuXing)
end
end

function subActivityInfo_guituxiuxing:checkReddot()
if not self.data then

return false
end


local taskList=self:getSubActConfig('taskList')
local reddot=false
for i=1,#taskList do
if self:checkDayReddot(i)then
reddot=true
break
end
end


if not reddot then
local progressCfg=self:getSubActConfig('jdReward')
local nowJifen=self.data.nowJF or 0
local nowProgressPoint=self:getProgressPoint()
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


function subActivityInfo_guituxiuxing:checkDayReddot(day)
if not self.data then

return false
end


if self:checkDayLock(day)then

return false
end

local dayCfg,isZero=self:getDayCfgByDayIndex(day)
if not dayCfg then
if not isZero then
logErr(FMT.fmt("归途修行 第{0}天缺少相关配置 请检查配置表是否正确",day))
end
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
local isGot=self:checkGoalIsGot(day,taskId)
local isFinish=self:checkGoalIsFinish(day,taskId)
local isFinalDay=false
if not isFinalDay then
local need=self:getTaskNeedCountByTaskId(taskId)
if not need then
return false
end

local cur=self:getGoalProgress(day,taskId)
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
reddot=self:checkGoalTypeReddot(day,libaoCfg[1])
end

return reddot
end


function subActivityInfo_guituxiuxing:checkDayLock(day)

local todayIndex=self:getOpenDayIndex()
if todayIndex==0 then
local nowTime=timeHelper.getServerLongTime()
if nowTime==self.start_time_l then

todayIndex=1
end
end
local isLock=day>todayIndex

return isLock
end




function subActivityInfo_guituxiuxing:checkDayAllFinish(day,isIgnoreLibaoGT)
if not self.data then

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

local dayCfg,isZero=self:getDayCfgByDayIndex(day)
if dayCfg then
local goalTypeCfg=dayCfg.tasks
local libaoCfg=dayCfg.libao

for i=1,#goalTypeCfg do

local taskList=goalTypeCfg[i][2]
if taskList then
for j=1,#taskList do
local taskId=taskList[j]
local isGot=self:checkGoalIsGot(day,taskId)
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
local libaoConfig=cfgHelper.get1(cfg_guituxiuxinglibaoactivityconfig_get,libaoId)
local buyCount=self:getLibaoBuyNum(day,libaoId)
if libaoConfig.buyLimit and buyCount<libaoConfig.buyLimit then

return false,libaoGTIndex
end
end
self.data.finishDayList[day]=2
end

return true
end

return false
end


function subActivityInfo_guituxiuxing:checkGoalTypeReddot(day,goalType)
if not self.data then

return false
end

local reddot=false

local goalTypeCfg=cfgHelper.get1(cfg_guituxiuxingtagactivityconfig_get,goalType)
local isLibao=false
if goalTypeCfg.isLibao and goalTypeCfg.isLibao==1 then
isLibao=true
end

local dayCfg,isZero=self:getDayCfgByDayIndex(day)
if not dayCfg then
return false
end

if isLibao then

local libaoList=dayCfg.libao[2]
for i=1,#libaoList do
local libaoId=libaoList[i]
local libaoConfig=cfgHelper.get1(cfg_guituxiuxinglibaoactivityconfig_get,libaoId)

local isFree=false
if not libaoConfig.buy2 and not libaoConfig.buy1 then

isFree=true
end

if isFree then
local buyCount=self:getLibaoBuyNum(day,libaoId)
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
else

local goalTypeCfg=dayCfg.tasks
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
local isGot=self:checkGoalIsGot(day,taskId)
local isFinish=self:checkGoalIsFinish(day,taskId)
local isFinalDay=false

if not isFinalDay then
local need=self:getTaskNeedCountByTaskId(taskId)
if not need then
return false
end

local cur=self:getGoalProgress(day,taskId)
isFinish=cur>=need
end

if isFinish and not isGot then
reddot=true
break
end
end
end
end

return reddot
end


function subActivityInfo_guituxiuxing:getDayCfgByDayIndex(day)
local dayTaskLibIdList=self:getDayTaskLibIdList()or{}
local dayTaskId=dayTaskLibIdList[day]
if dayTaskId and dayTaskId~=0 then
local dayCfg=cfgHelper.get(cfg_guituxiuxinglibactivityconfig_get,dayTaskId)
return dayCfg
end

return nil,dayTaskId==0
end


function subActivityInfo_guituxiuxing:getDayTaskLibIdList()
if not self.data then

return
end
if self.data.dayTaskLibIdList then
return self.data.dayTaskLibIdList
end

local list={}
local taskList=self:getSubActConfig('taskList')
for dayIndex,libId in ipairs(taskList)do
list[dayIndex]=libId
end

self.data.dayTaskLibIdList=list
return self.data.dayTaskLibIdList
end


function subActivityInfo_guituxiuxing:getDayIndexList()
if not self.data then

return
end
if self.data.dayIndexList then
return self.data.dayIndexList
end

local list={}
local taskList=self:getSubActConfig('taskList')
local index=1
for day,libId in ipairs(taskList)do
if libId~=0 then
list[index]=day
index=index+1
end
end

self.data.dayIndexList=list
return self.data.dayIndexList
end


function subActivityInfo_guituxiuxing:getLibaoBuyNum(day,libaoId)
if not self.data or not self.data.libaoList then

return 0
end

if not self.data.libaoList[day]or not self.data.libaoList[day][libaoId]then

return 0
end

local libaoData=self.data.libaoList[day][libaoId]
local buyNum=libaoData.buyNum or 0

return buyNum
end


function subActivityInfo_guituxiuxing:getGoalProgress(day,taskId)

local taskCfg=cfgHelper.get(cfg_guituxiuxingtaskactivityconfig_get,taskId)
local progress=0
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then

local taskParam=taskCfg.params
if not self.data.clientCheckListenList then
self.data.clientCheckListenList={}
end

if not self.data.clientCheckListenList[day]then
self.data.clientCheckListenList[day]={}
end

if not self.data.clientCheckListenList[day][taskId]then

local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,day=day,taskId=taskId}
local taskAim=taskCfg.aimnum
local listenGuid=taskController:listenTaskCount(tasktype,taskParam,funcArgs,taskAim)
self.data.clientCheckListenList[day][taskId]={listenGuid=listenGuid,taskType=tasktype,taskParam=taskParam}

if not self.data.clientCheckListenList_type_lookup then
self.data.clientCheckListenList_type_lookup={}
end
self.data.clientCheckListenList_type_lookup[tasktype]=true
end
progress=taskController:getTaskCount(tasktype,taskParam)or 0
else

if self.data and self.data.taskList and self.data.taskList[day]and self.data.taskList[day][taskId]then
local taskData=self.data.taskList[day][taskId]
progress=taskData.finishNum or 0
end
end
end

return progress
end


function subActivityInfo_guituxiuxing:checkGoalIsFinish(day,taskId)

local taskCfg=cfgHelper.get(cfg_guituxiuxingtaskactivityconfig_get,taskId)
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then

local progress=self:getGoalProgress(day,taskId)
local taskAim=taskCfg.aimnum
return progress>=taskAim
else

if self.data and self.data.taskList and self.data.taskList[day]and self.data.taskList[day][taskId]then
local taskData=self.data.taskList[day][taskId]
local finishFlag=taskData.finishFlag
return finishFlag==1
end
end
end
return false
end


function subActivityInfo_guituxiuxing:checkGoalIsGot(day,taskId)
if self.data.taskList and self.data.taskList[day]and self.data.taskList[day][taskId]then
local taskData=self.data.taskList[day][taskId]
local rwFlag=taskData.rwFlag
return rwFlag==1
end
return false
end


function subActivityInfo_guituxiuxing:getTaskNeedCountByTaskId(taskId)
local taskAim=1
local taskCfg=cfgHelper.get(cfg_guituxiuxingtaskactivityconfig_get,taskId)
if taskCfg and taskCfg.aimnum then
taskAim=taskCfg.aimnum
end
return taskAim
end


function subActivityInfo_guituxiuxing:getGoalDataByDayAndTaskId(day,taskId)
if self.data and self.data.taskList and self.data.taskList[day]then
local taskData=self.data.taskList[day][taskId]
return taskData
end
return nil
end


function subActivityInfo_guituxiuxing:getProgressPoint()
local maxGotJF=self.data and self.data.maxGotJF or 0
local jdReward=self:getSubActConfig('jdReward')
local progressPoint=0
for i,v in ipairs(jdReward)do
local needJF=v[1]
if maxGotJF>=needJF then
progressPoint=i
else
break
end
end
return progressPoint
end


function subActivityInfo_guituxiuxing:getNextOpenDay()
local todayIndex=self:getOpenDayIndex()
local taskList=self:getSubActConfig('taskList')
local dayCount=taskList and#taskList or 7
if todayIndex<dayCount then
local nextDay=todayIndex+1
return nextDay
end
return nil
end


function subActivityInfo_guituxiuxing:getDayTime(day)
local startTime_Long=self.start_time_l
local startZeroTime=timeHelper.convertShortStamp(timeHelper.getServerZeroStamp(startTime_Long))
local dayTime=startZeroTime+(day-1)*86400
return dayTime
end


function subActivityInfo_guituxiuxing:reqGetAllGoalReward()
local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_guituxiuxing:reqGetProgressReward()
local json_str=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_guituxiuxing:reqBuyLibao(day,libaoId,buyCount)
buyCount=buyCount or 1
local json_str=jsonHelper.encode({3,day,libaoId,buyCount})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_guituxiuxing:getDayAndGoalIndex()
return{dayIndex=self.data.saveDayIndex,goalTypeIndex=self.data.saveGoalTypeIndex}
end


function subActivityInfo_guituxiuxing:setDayAndGoalIndex(day,goalType)
self.data.saveDayIndex=day
self.data.saveGoalTypeIndex=goalType
end


function subActivityInfo_guituxiuxing:clearDayAndGoalIndex()
self.data.saveDayIndex=nil
self.data.saveGoalTypeIndex=nil
end

function subActivityInfo_guituxiuxing:clearTaskListen()
if not self.data then
return
end
if not self.data.clientCheckListenList then
return
end
for _,dayList in pairs(self.data.clientCheckListenList)do
if dayList and next(dayList)then
for _,taskData in pairs(dayList)do
taskController:unlistenTaskCount(taskData.taskType,taskData.taskParams,taskData.listenGuid)
end
end
end
end

return subActivityInfo_guituxiuxing