











local _MODULENAME="xianguanController"

gameState.addListener(def_table(_MODULENAME))
xianguanController.name=_MODULENAME
xianguanController.data={}

function xianguanController:onAppStart()

xianguanModel:onAppStart()

socketManager:register_receiver(35,71,self.recv_35_71)
socketManager:register_receiver(35,72,self.recv_35_72)
socketManager:register_receiver(35,74,self.recv_35_74)

xianguanController:onAppStart_TeQuan()
xianguanController:onAppStart_WenXuan()
xianguanController:onAppStart_WuXuan()
xianguanController:onAppStart_Log()
end


function xianguanController:onEnterState(isReconnect)
xianguanController:onEnterState_TeQuan()
xianguanController:onEnterState_WuXuan()
xianguanController:onEnterState_Log()
xianguanModel:onEnterState_TTMS()
xianguanModel:onEnterState_LookUp()

xianguanModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
end


function xianguanController:onProtocolReq()
xianguanModel:onProtocolReq()
xianguanConfig.initConfig()


end

function xianguanController:onProtocolReqKF()
xianguanModel:onProtocolReqKF()
xianguanModel:onProtocalReqKF_TeQuan()

xianguanModel:onProtocalReqKF_WuXuan()
xianguanModel:onProtocalReqKF_WenXuan()

if xianguanModel:getReceiveServerDataState()then
self:checkJingXuanResultMsg()
end

self:refresUpdateState()
end

function xianguanController:onProtocolReqLargeXJKF()

end


function xianguanController:onLeaveState(isReconnect)
xianguanController:onLeaveState_WenXuan()
xianguanController:onLeaveState_TeQuan()
xianguanController:onLeaveState_WuXuan()
xianguanController:onLeaveState_Log()
xianguanModel:onLeaveState_TTMS()
xianguanModel:onLeaveState_LookUp()

xianguanModel:onLeaveState(isReconnect)

self.data={}
self:stopUpdateHandle()
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onNewWeek5am,self.onNewWeek5am)
end


function xianguanController:onLostConnection()

end


function xianguanController:onReConnection(isInitPro)

end


function xianguanController.onNewDay()
xianguanController.resetSelefPrivilege(xianguanConfig.resetTimesType.eDay)


xianguanController:refresUpdateState()
end

function xianguanController.onNewWeek()
xianguanController.resetSelefPrivilege(xianguanConfig.resetTimesType.eWeek)

xianguanModel:clearAllJingXuanShareRecord()

xianguanController:onNewWeek_WuXuan()
end

function xianguanController.onNewDay5am()
xianguanController.resetSelefPrivilege(xianguanConfig.resetTimesType.eDayFive)
end

function xianguanController.onNewWeek5am()
xianguanController.resetSelefPrivilege(xianguanConfig.resetTimesType.eWeekFive)
end




function xianguanController.reqXianGuanInitData()
socketManager:send_35_71()
end

function xianguanController.reqXianGuanCampaign(jobId)
socketManager:send_35_72(jobId)
end

function xianguanController.reqUseXianGuanPrivilege(jobId,privilegeId)
socketManager:send_35_73(jobId,privilegeId)
end

function xianguanController.recv_35_71(xgDataLen,xgDataList,session)
xianguanModel:initData()
xianguanModel:setInitServerData(xgDataLen,xgDataList,session)


if initProControl:isDoneKF()then
xianguanController:checkJingXuanResultMsg()
end
end

function xianguanController.recv_35_72(jobId,leftTime)

local serverid=playerModel:getActorServerID()
local actorid=playerModel:getActorID()
local actorname=playerModel:getActorName()
local iconInfo=playerModel:getActorIconInfo()
local sex=playerModel:getActorSex()
local level=playerModel:getActorLevel()

xianguanModel:changeJobActorDataInfo(jobId,serverid,actorid,actorname,sex,level,iconInfo,leftTime)
end

function xianguanController.recv_35_74(args)
local jobId=args[1]
local serverid=args[2]
local actorid=args[3]
local actorname=args[4]
local sex=args[5]
local level=args[6]
local iconInfo=args[7]
local leftTime=args[8]

xianguanModel:changeJobActorDataInfo(jobId,serverid,actorid,actorname,sex,level,iconInfo,leftTime)
end





function xianguanController.getGroupCurNum(groupId)
local jobGroupList=xianguanModel:getJobGroupList(groupId)
local num=0
for index,jobInfo in pairs(jobGroupList)do
if jobInfo.actorid then
if not mathHelper.compareInt64(jobInfo.actorid,Int64_0)then
num=num+1
end
end
end

return num
end

function xianguanController.getGroupReddot(groupId)












return false
end

function xianguanController.getStageReddot(groupId,stageId)
local isUnlock=cfgHelper.get2(cfg_xianguangroupconfig_get,groupId,'isUnlock')
if isUnlock then
if not xianguanController.checkSelfInJob(groupId)then
local jobList=xianguanConfig.getJobListConfig(groupId)
for index,jobCfg in ipairs(jobList)do
if jobCfg.stage==stageId then
if xianguanController.checkIsCanJob(groupId,jobCfg.id)then
return true
end
end
end
end
end

return false
end




function xianguanController.getJobPlayerInfo(groupId,jobId)
local jobInfo=xianguanModel:getGroupJobInfo(groupId,jobId)
return jobInfo
end

function xianguanController.checkSelfInJob(groupId)
local selfJobInfo=xianguanModel:getSelfGroupJobInfo(groupId)
return selfJobInfo and selfJobInfo.actorid~=nil
end

function xianguanController:checkSelfHasJob()
local selfJobInfoList=xianguanModel:getSelfGroupJobInfoList()
return next(selfJobInfoList)~=nil
end

function xianguanController.getSelfPrivilegeUseReddot()

local activeTeQuanList=xianguanModel:getTeQuanDataList_key()
for key,data in pairs(activeTeQuanList)do
local noCheckReddot=xianguanConfig.getTeQuanCfg(data.tqid,'noCheckReddot')
if not noCheckReddot then
local isCanUse=xianguanHelper.checkTeQuanUseCondition(data.xgid,data.tqid,false)
local exReddot=xianguanController:getTequanExReddot(data)

if isCanUse and exReddot then
return true
end
end
end

return false
end

function xianguanController.getSelfJobInfoList()
local temp={}
local selfList=xianguanModel:getSelfGroupJobInfoList()

for index,jobInfo in pairs(selfList)do
temp[#temp+1]=jobInfo
end

table.sort(temp,function(jobInfo1,jobInfo2)
local jobLevel1=xianguanConfig.getJobConfig(jobInfo1.jobId,'jobLevel')
local jobLevel2=xianguanConfig.getJobConfig(jobInfo2.jobId,'jobLevel')

if jobLevel1==jobLevel2 then
return jobInfo1.groupId<jobInfo2.groupId
else
return jobLevel1<jobLevel2
end
end)

return temp
end

function xianguanController.getPrivilegeDayNumInfo()

local totalTimes=0
local usedTimes=0

local activeTeQuanList=xianguanModel:getTeQuanDataList_key()
for key,data in pairs(activeTeQuanList)do
local maxTimes=xianguanConfig.getTeQuanCfg(data.tqid,"times")or 0
totalTimes=totalTimes+maxTimes
usedTimes=usedTimes+data.times
end

return totalTimes-usedTimes,totalTimes
end

function xianguanController.checkIsCanJob(groupId,jobId)
local isEnmpty=xianguanController.checkJobIsEmptyActor(groupId,jobId)

if not isEnmpty then
return false
end

return xianguanController.checkSatisfyCondition(groupId,jobId)
end

function xianguanController.checkSatisfyCondition(groupId,jobId)

if xianguanModel:getFirstStart()then
return xianguanController.checkJobCompaignType(groupId,jobId)
end

if not xianguanController.checkJobCompaignType(groupId,jobId)then
return false
end

return xianguanConfig.checkCanJob(groupId,jobId)
end

function xianguanController.checkJobIsEmptyActor(groupId,jobId)

if groupId~=nil and jobId~=nil then
local jobInfo=xianguanModel:getGroupJobInfo(groupId,jobId)

return jobInfo.actorid==nil
end
end

function xianguanController.getSelfTotalPrivilegeList()
local selfJobList=xianguanModel:getSelfGroupJobInfoList()

local tempList={}
for jIndex,jobInfo in ipairs(selfJobList)do
if jobInfo.tqList then
tempList=table.concatTable(tempList,jobInfo.tqList)
end
end

return tempList
end

function xianguanController.getSelfTotalVoluntaryPrivilegeList()
local selfJobList=xianguanModel:getSelfGroupJobInfoList()

local tempList={}
for jIndex,jobInfo in ipairs(selfJobList)do
if#jobInfo.voluntaryTqList>0 then
tempList=table.concatTable(tempList,jobInfo.voluntaryTqList)
end
end

return tempList
end

function xianguanController.getBestJobChatFlag()
local selfJobList=xianguanModel:getSelfGroupJobInfoList()

local chatFlag
if#selfJobList>0 then
local oldJobSortWight=0
local jobSortWight=0
for index,jonInfo in ipairs(selfJobList)do
jobSortWight=xianguanConfig.getJobSortWidget(jonInfo.groupId,jonInfo.jobId)
if jobSortWight>oldJobSortWight then
chatFlag=xianguanConfig.getJobConfig(jonInfo.jobId,'chatFlagId')
end
end
end

return chatFlag
end

function xianguanController.getBestShowJob()
local selfJobList=xianguanModel:getSelfGroupJobInfoList()



local bestJobInfo
if next(selfJobList)~=nil then
local oldJobSortWight=0
local jobSortWight=0
for group,jonInfo in pairs(selfJobList)do
jobSortWight=xianguanConfig.getJobSortWidget(jonInfo.groupId,jonInfo.jobId)
if jobSortWight>oldJobSortWight then
bestJobInfo=jonInfo
end
end
end

return bestJobInfo
end

function xianguanController.getXianGuanWages()
local tqlookup=xianguanModel:getSelfTeQuanLookUp()



local tempList={}
for tqid,jobList in pairs(tqlookup)do
local tequanCfg=xianguanConfig.getTeQuanCfg(tqid)

if tequanCfg.type==XIANGUAN_PRIVILEGE_EFFECT_TYPE_ENUM.eXianFeng then
for eIndex,itemInfo in ipairs(tequanCfg.effectArgs)do
local itemId=itemInfo[1]
local itemCount=itemInfo[2]
if tempList[itemId]then
tempList[itemId]=tempList[itemId]+itemCount
else
tempList[itemId]=itemCount
end
end
end
end

if#tempList>0 then

local itemList={}
for itemId,itemCount in pairs(tempList)do
itemList[#itemList+1]={itemId,itemCount}
end

table.sort(itemList,function(a,b)
return a[1]>b[1]
end)

return itemList
else
return tempList
end
end

function xianguanController.checkHasVoluintaryPrivilege()
local slist=xianguanModel:getTeQuanDataList_key()or{}

return next(slist)~=nil
end

function xianguanController.checkJobCompaignType(groupId,jobId)
local compaignType=xianguanConfig.getJobConfig(groupId,jobId,'campaignType')

if compaignType==1 then
return true
elseif compaignType==2 then
return true
elseif compaignType==3 then
return false
end
end

function xianguanController:checkNeedUpdate()
return xianguanModel:checkWuXuanWeek()or xianguanModel:checkWenXuanWeek()or xianguanController:isInMatchStage_enter_WuXuan_BW()or xianguanController:isInMatchStage_enter_WenXuan_BW()
end

function xianguanController:refresUpdateState()
local check=self:checkNeedUpdate()
if check then
self:startUpdateHandle()
else
self:stopUpdateHandle()
end
end

function xianguanController:startUpdateHandle()
if not self.updateing and initProControl:isDoneKF()then
self.updateing=true
self.updateTime=timeHelper.getServerShortTime()
timeEventController.addNormalTimerHandler(1,self.name,self)
end
end

function xianguanController:stopUpdateHandle()
if self.updateing then
self.updateing=false
self.updateTime=nil
timeEventController.removeNormalTimerHandler(1,self.name)
end
end

function xianguanController:onNormalUpdate()
self:onNormalUpdate_WenXuan(self.updateTime)
self:onNormalUpdate_WuXuan(self.updateTime)

self:onNormalUpdate_WenXuan_BW(self.updateTime)
self:onNormalUpdate_WuXuan_BW(self.updateTime)

self.updateTime=timeHelper.getServerShortTime()
self:refresUpdateState()
end




function xianguanController:checkSelfHasThisJob(jobId)
local selfJobInfoList=xianguanModel:getSelfJobList()
return selfJobInfoList[jobId]~=nil
end



function xianguanController:checkSelfHasThisTeQuan(tqId)
local tqJobList=xianguanModel:getSelfTeQuanOfJobList(tqId)
return tqJobList and#tqJobList>0
end



function xianguanController:getSelfHasJobByType(xgType)
return xianguanModel:getDataBykey(XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_XgType,xgType)
end



function xianguanController:checkSelfHasJobByType(xgType)
local jobInfo=xianguanController:getSelfHasJobByType(xgType)
return jobInfo~=nil,jobInfo and jobInfo.jobId
end




function xianguanController:getActorHasJobByType(actorId,xgType)
return xianguanModel:getDataBykey(XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorID_XgType,actorId,xgType)
end




function xianguanController:checkActorHasJobByType(actorId,xgType)
local jobInfo=xianguanController:getActorHasJobByType(actorId,xgType)
return jobInfo~=nil,jobInfo and jobInfo.jobId
end




function xianguanController:getSelfHasTeQuanByType(tqId,xgType)
return xianguanModel:getDataBykey(XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_TqID_XgType,tqId,xgType)
end




function xianguanController:checkSelfHasTeQuanByType(tqId,xgType)
if not xianguanHelper.checkTeQuanPlatformLimit(tqId)then return false end

local jobInfo=xianguanController:getSelfHasTeQuanByType(tqId,xgType)
if jobInfo then
local tqInfo=xianguanModel:getDataBykey(XIANGUAN_INFO_KEY_ENUM.eTQInfo_self_TqID_XgID,tqId,jobInfo.jobId)
return tqInfo~=nil
end
return false
end



function xianguanController:checkSelfHasTeQuanByGroup(group)
local tqList=xianguanModel:getTeQuanDataList_group(group)
return tqList and#tqList>0
end

function xianguanController:checkJobHasActor(jobId)
local jobInfo=xianguanModel:getJobInfoByJobId(jobId)
if jobInfo==nil or jobInfo.actorid==nil or mathHelper.compareInt64(jobInfo.actorid,Int64_0)then
return false
end
return true
end


function xianguanController.getReddot()
local groupCfgList=cfg_xianguangroupconfig()

if xianguanController.getSelfPrivilegeUseReddot()then
return true
end

for index,groupCfg in ipairs(groupCfgList)do
if xianguanController.getGroupReddot(groupCfg.id)then
return true
end
end

if xianguanModel:getWuXuanReddot()then
return true
end

if xianguanModel:getWenXuanReddot()then
return true
end

return false
end


function xianguanController.testInitServerData()
local initServerData={}


local selfTemp={
xianguan_type=1,
xianguan_id=1,
server_id=playerModel:getActorServerID(),
actor_id=playerModel:getActorID(),
actorname=playerModel:getActorName(),
icon=playerModel:getActorIconInfo(),
tq_list_len=1,
tq_list={{param_1=4,param_2=0}}
}

initServerData[#initServerData+1]=selfTemp


xianguanController.recv_35_71(1,initServerData)
end