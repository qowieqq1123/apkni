









local subActivityInfo_zushishouji={name='zushishouji'}

function subActivityInfo_zushishouji:onInit()
self:listenNotify(notifyConfig.onDisposeClientCheckTaskTypeEvent,function(...)
self:onDisposeClientCheckTaskTypeEvent(...)
end)
end

function subActivityInfo_zushishouji:onStart()

end

function subActivityInfo_zushishouji:onDelete()
self:clearTaskListen()
end


function subActivityInfo_zushishouji:onNewDay()
if self.data then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
UIManager:invokeUIMethod('UISubAct_XYZPWin','rec_newday',self.act_id,self.sub_act_type,self.sub_act_id)

local flag=self:checkAllTaskGet()
if not flag then
activitiesController:refreshActEnter(self.act_id,true)
end
end
end

function subActivityInfo_zushishouji:onDisposeClientCheckTaskTypeEvent(eventType)
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
self:initFreshTaskList()
self:reqFreshTaskList()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eZuShiShouJi)
end
end


function subActivityInfo_zushishouji:checkAllTaskGet()
if self.data then

local finishTime=self.data.finishTime
if finishTime and finishTime>0 then

if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(finishTime))then
return false
end
end




















end
return true
end


function subActivityInfo_zushishouji:checkReddot()
if self.data then
local flag=self:RewardsReddot()or self:AllZTReddot()
self:SetCheckListenList()
return flag
end
return false
end

function subActivityInfo_zushishouji:getZTTaskData(ztid)
if self.data and self.data.ztTaskList then
return self.data.ztTaskList[ztid]
end
return false
end

function subActivityInfo_zushishouji:getZTLiBaoData(ztid)
if self.data and self.data.ztLiBaoList then
return self.data.ztLiBaoList[ztid]
end
return false
end


function subActivityInfo_zushishouji:reqReceiveReward(ztid)
local jstr=jsonHelper.encode({1,ztid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
end

function subActivityInfo_zushishouji:reqReceiveFreeLiBao(ztid)
local jstr=jsonHelper.encode({2,ztid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
end

function subActivityInfo_zushishouji:reqBuyLiBao(ztid,libaoid,num)
local jstr=jsonHelper.encode({5,ztid,libaoid,num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
end

function subActivityInfo_zushishouji:reqReceiveJinDu()
local jstr=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
end

function subActivityInfo_zushishouji:reqFreshTaskData(ztid,tasklist)
local jstr=jsonHelper.encode({4,ztid,tasklist})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
end


function subActivityInfo_zushishouji:AllZTReddot()
local ztlist=self:getSubActConfig("ztlist")
for k,ztid in ipairs(ztlist)do
local singleReddot=self:SingleZTReddot(ztid)
if singleReddot then
return true
end
end
end

function subActivityInfo_zushishouji:SingleZTReddot(ztid)
local ztcfg=cfg_zushishoujitagconfig_get(ztid)
local dayLimit=ztcfg.dayLimit
local todayIndex=self:getOpenDayIndex()
if todayIndex==0 then
local nowTime=timeHelper.getServerLongTime()
if nowTime==self.start_time_l then
todayIndex=1
end
end
if todayIndex>=dayLimit then
return self:TaskReddot(ztid)or self:LiBaoReddot(ztid)
end
return false
end

function subActivityInfo_zushishouji:TaskReddot(ztid)
local severData=self:getZTTaskData(ztid)
local config_task=self:getSubActConfig("taskList")
local taskList=config_task[ztid]
for k,taskid in ipairs(taskList)do
local sever_rwFlag=0
local _sever_finishNum=0
if severData then
local taskdata=severData[taskid]
if taskdata then
sever_rwFlag=taskdata.rwFlag or 0
_sever_finishNum=taskdata.finishNum or 0
end
end
if sever_rwFlag==0 then
local sever_finishNum=self:getGoalProgress(ztid,taskid)
if _sever_finishNum>sever_finishNum then
sever_finishNum=_sever_finishNum
end
local cfg=cfg_zushishoujitaskconfig_get(taskid)
local aimnum=cfg.aimnum
if sever_finishNum>=aimnum then
return true
end
end













end
return false
end

function subActivityInfo_zushishouji:LiBaoReddot(ztid)
local reddot=false
local giftAllData=self:getZTLiBaoData(ztid)
local cfglibaoList=self:getSubActConfig("libaoList")
local libaoList=cfglibaoList[ztid]
for i,libaoid in ipairs(libaoList)do
local cfg=cfg_zushishoujilibaoconfig_get(libaoid)
if not cfg.rechargeId and not cfg.itemBuy then
reddot=true

if giftAllData and giftAllData[libaoid]then
local buyLimit=cfg.buyMax
local buyCount=giftAllData[libaoid].param_2 or 0
if buyCount>=buyLimit then
reddot=false
end
end
end
end
return reddot
end

function subActivityInfo_zushishouji:RewardsReddot()
if self.data then
local target=self:getSubActConfig("jdList")
local total=self.data.TfinishNum
local flag=self.data.jdrwMax
for i,d in ipairs(target)do
local num=d[1]
local fix=total>=num

local rewardFlag=flag>=num
if fix and not rewardFlag then
return true
end
end
end
end

function subActivityInfo_zushishouji:checkGoalIsFinish(ztid,taskId)

local taskCfg=cfgHelper.get(cfg_guituxiuxingtaskactivityconfig_get,taskId)
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then

local progress=self:getGoalProgress(ztid,taskId)
local taskAim=taskCfg.aimnum
return progress>=taskAim
else

local severData=self:getZTTaskData(ztid)
if severData then
local taskdata=severData[taskId]
local finishFlag=taskdata.rwFlag
return finishFlag==1
end
end
end
return false
end


function subActivityInfo_zushishouji:SetCheckListenList()

local ztlist=self:getSubActConfig("ztlist")
for k,ztid in ipairs(ztlist)do
local ztcfg=cfg_zushishoujitagconfig_get(ztid)
local dayLimit=ztcfg.dayLimit
local todayIndex=self:getOpenDayIndex()
if todayIndex==0 then
local nowTime=timeHelper.getServerLongTime()
if nowTime==self.start_time_l then
todayIndex=1
end
end
if todayIndex>=dayLimit then
local severData=self:getZTTaskData(ztid)
local config_task=self:getSubActConfig("taskList")
local taskList=config_task[ztid]
for k,taskId in ipairs(taskList)do
local sever_finishFlag=0
if severData and severData[taskId]then
sever_finishFlag=severData[taskId].finishFlag or 0
end
if sever_finishFlag==0 then
local taskCfg=cfgHelper.get(cfg_zushishoujitaskconfig_get,taskId)
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then
local taskParam=taskCfg.params
if not self.data.clientCheckListenList then
self.data.clientCheckListenList={}
end
if not self.data.clientCheckListenList[taskId]then

local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskId}
local taskAim=taskCfg.aimnum
local listenGuid=taskController:listenTaskCount(tasktype,taskParam,funcArgs,taskAim)
self.data.clientCheckListenList[taskId]={listenGuid=listenGuid,taskType=tasktype,taskParam=taskParam}
if not self.data.clientCheckListenList_type_lookup then
self.data.clientCheckListenList_type_lookup={}
end
self.data.clientCheckListenList_type_lookup[tasktype]=true

end
end
end
end
end
end
end
end

function subActivityInfo_zushishouji:getGoalProgress(ztid,taskId)

local taskCfg=cfgHelper.get(cfg_zushishoujitaskconfig_get,taskId)
local progress=0
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then

local taskParam=taskCfg.params
if not self.data.clientCheckListenList then
self.data.clientCheckListenList={}
end
if not self.data.clientCheckListenList[taskId]then

local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskId}
local taskAim=taskCfg.aimnum
local listenGuid=taskController:listenTaskCount(tasktype,taskParam,funcArgs,taskAim)
self.data.clientCheckListenList[taskId]={listenGuid=listenGuid,taskType=tasktype,taskParam=taskParam}

if not self.data.clientCheckListenList_type_lookup then
self.data.clientCheckListenList_type_lookup={}
end
self.data.clientCheckListenList_type_lookup[tasktype]=true
end
progress=taskController:getTaskCount(tasktype,taskParam)or 0
else

local severData=self:getZTTaskData(ztid)
if severData then
local taskdata=severData[taskId]
if taskdata then
progress=taskdata.finishNum or 0
end
end
end
end
return progress
end
function subActivityInfo_zushishouji:clearTaskListen()
if not self.data then
return
end
if not self.data.clientCheckListenList then
return
end
for _,taskData in pairs(self.data.clientCheckListenList)do
if taskData and next(taskData)then
taskController:unlistenTaskCount(taskData.taskType,taskData.taskParams,taskData.listenGuid)
end
end
end


function subActivityInfo_zushishouji:initFreshTaskList()
if not self.data then
return
end
self.data.clientTask={}
local ztlist=self:getSubActConfig("ztlist")
for k,ztid in ipairs(ztlist)do
local ztcfg=cfg_zushishoujitagconfig_get(ztid)
local dayLimit=ztcfg.dayLimit
local todayIndex=self:getOpenDayIndex()
if todayIndex==0 then
local nowTime=timeHelper.getServerLongTime()
if nowTime==self.start_time_l then
todayIndex=1
end
end
if todayIndex>=dayLimit then
self.data.clientTask[ztid]={}
local _severData=self:getZTTaskData(ztid)
local config_task=self:getSubActConfig("taskList")
local taskList=config_task[ztid]
for k,taskId in ipairs(taskList)do
local iscan=false
local severData=_severData and _severData[taskId]
if severData then
if severData.finishFlag and severData.finishFlag==0 then
iscan=true
end
else
iscan=true
end

if iscan then
local taskCfg=cfgHelper.get(cfg_zushishoujitaskconfig_get,taskId)
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then

local taskParam=taskCfg.params
local progress=taskController:getTaskCount(tasktype,taskParam)or 0
local taskAim=taskCfg.aimnum

if progress>=taskAim then
table.insert(self.data.clientTask[ztid],taskId)
end
end
end
end
end
end
end
end

function subActivityInfo_zushishouji:initFreshTaskList2()
if not self.data then
return
end
self.data.clientTask={}
local ztlist=self:getSubActConfig("ztlist")
for k,ztid in ipairs(ztlist)do
local ztcfg=cfg_zushishoujitagconfig_get(ztid)
local dayLimit=ztcfg.dayLimit
local todayIndex=self:getOpenDayIndex()
if todayIndex==0 then
local nowTime=timeHelper.getServerLongTime()
if nowTime==self.start_time_l then
todayIndex=1
end
end
if todayIndex>=dayLimit then
self.data.clientTask[ztid]={}
local _severData=self:getZTTaskData(ztid)
local config_task=self:getSubActConfig("taskList")
local taskList=config_task[ztid]
for k,taskId in ipairs(taskList)do
local iscan=false
local severData=_severData and _severData[taskId]
if severData then
if severData.finishFlag and severData.finishFlag==0 then
iscan=true
end
else
iscan=true
end

if iscan then
local taskCfg=cfgHelper.get(cfg_zushishoujitaskconfig_get,taskId)
if taskCfg then
local tasktype=taskCfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck then
table.insert(self.data.clientTask[ztid],taskId)
end
end
end
end
end
end
end

function subActivityInfo_zushishouji:reqFreshTaskList()

if not self.data then
return
end
local data=self.data.clientTask
if data and next(data)then
for ztid,tasklist in pairs(data)do
if tasklist and next(tasklist)then

self:reqFreshTaskData(ztid,tasklist)
end
end
end
end

function subActivityInfo_zushishouji:printtask()
local data=self.data.clientTask
return data
end


return subActivityInfo_zushishouji