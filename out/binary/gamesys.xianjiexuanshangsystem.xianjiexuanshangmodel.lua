






local _MODULENAME="XianjieXuanShangModel"


def_table(_MODULENAME)
XianjieXuanShangModel.name=_MODULENAME
XianjieXuanShangModel.data={}

function XianjieXuanShangModel:onAppStart()

end


function XianjieXuanShangModel:onEnterState(isReconnect)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
self.cdDatas={}
self:initXJTaskData()
end


function XianjieXuanShangModel:onProtocolReq()

end


function XianjieXuanShangModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)

self.data={}
self.cdDatas=nil
end


function XianjieXuanShangModel.onNewDay5am()
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
if XianjieXuanShangModel.data then
XianjieXuanShangModel.data.freeNumUse=0
XianjieXuanShangModel.data.feeNumUse=0
UIManager:invokeUIMethod("UIXianjieXuanShangWin","freshSYnum")
end
end
end


function XianjieXuanShangModel:initXJTaskData()
self.data.xjzmTeZhi={}
self.data.TaskDatas={}
self.data.oldlist={}
for i=1,3 do
self.data.TaskDatas[i]=false
end
end

function XianjieXuanShangModel:getXJTaskData(arry1,arry2,arry3,arry4,arry5,arry6)
self.data.TaskDatas={}
self.data.oldlist={}
if arry1>0 and arry2 then
for k,v in ipairs(arry2)do
if v.taskIndex then
self.data.TaskDatas[v.taskIndex]=v
self:addCDData(self.data.TaskDatas[v.taskIndex])
end
end
end
self.data.freeNumUse=arry3 or 0
self.data.feeNumUse=arry4 or 0
if arry5>0 and arry6 then
self.data.oldlist=arry6
end
end

function XianjieXuanShangModel:getXJTaskDataAccess(_taskId,_zmGuid,_endTime,freeNumUse,feeNumUse,_taskIndex,_startTime)

if self.data.TaskDatas then
for k,v in pairs(self.data.TaskDatas)do
if v then
if v.taskId==_taskId or v.zmGuid==_zmGuid then
self.data.TaskDatas[v.taskIndex]=false
self:removeCDData(v.taskId)
end
end
end
end
local temp=
{
taskId=_taskId,
zmGuid=_zmGuid,
endTime=_endTime,
rwFlag=0,
taskIndex=_taskIndex,
startTime=_startTime,
}
self.data.TaskDatas[_taskIndex]=temp
self.data.freeNumUse=freeNumUse or 0
self.data.feeNumUse=feeNumUse or 0
self:addCDData(self.data.TaskDatas[_taskIndex])
end

function XianjieXuanShangModel:getXJTaskDataFinish(_taskId,_endTime)
if self.data.TaskDatas then
for k,v in pairs(self.data.TaskDatas)do
if v and v.taskId==_taskId then
self.data.TaskDatas[v.taskIndex].endTime=gameUtilityModel.getServerShortTime()

self:quickFinishTask(self.data.TaskDatas[v.taskIndex])
end
end
end
end

function XianjieXuanShangModel:getXJTaskDataReward(len,list)
if len>0 and list then
for i,_taskId in ipairs(list)do
for k,v in pairs(self.data.TaskDatas)do
if v and v.taskId==_taskId then
if self.data.oldlist then
local temp=
{
param_1=v.taskId,
param_2=v.startTime
}


end
self.data.TaskDatas[v.taskIndex].rwFlag=1
self:removeCDData(v.taskId)
end
end
end
end
end

function XianjieXuanShangModel:getXJTaskDataChangeTask(len,arry,freeNumUse,feeNumUse)
if len>0 and arry then
for k,v in ipairs(arry)do
if v.taskIndex then
self.data.TaskDatas[v.taskIndex]=v
self:addCDData(self.data.TaskDatas[v.taskIndex])
end
end
end
self.data.freeNumUse=freeNumUse or 0
self.data.feeNumUse=feeNumUse or 0
end

function XianjieXuanShangModel:getXJTaskDataAbandon(_taskId,freeNumUse,feeNumUse)
if self.data.TaskDatas then
for k,v in pairs(self.data.TaskDatas)do
if v and v.taskId==_taskId then
self.data.TaskDatas[v.taskIndex]=false
self:removeCDData(v.taskId)
end
end
end
self.data.freeNumUse=freeNumUse
self.data.feeNumUse=feeNumUse

end

function XianjieXuanShangModel:getXJZongMenTeZhi(isNew,len,arry)
if not self.data.xjzmTeZhi then
self.data.xjzmTeZhi={}
end
if len>0 and arry then
for k,v in ipairs(arry)do
if v.zmGuid then
local zmguidstr=tostring(v.zmGuid)
self.data.xjzmTeZhi[zmguidstr]=v
end
end
end
end



function XianjieXuanShangModel:getTaskAllData()
return self.data.TaskDatas
end

function XianjieXuanShangModel:getTaskDataSinglebyIndex(index)
if self.data.TaskDatas[index]then
return self.data.TaskDatas[index]
end
return false
end

function XianjieXuanShangModel:getTaskDataSinglebyTaskid(taskid)
for k,v in pairs(self.data.TaskDatas)do
if v and v.taskId==taskid then
return v
end
end
return false
end

function XianjieXuanShangModel:getfreeNumUse()
return self.data.freeNumUse or 0
end

function XianjieXuanShangModel:getfeeNumUse()
return self.data.feeNumUse or 0
end

function XianjieXuanShangModel:getTaskIdbyIdx(index)
if self.data.TaskDatas[index]then
return self.data.TaskDatas[index].taskId or 0
end
return 0
end

function XianjieXuanShangModel:getZMtezhiDatabyGuid(zmid)




local cfg_tzList=cfg_syssectconfig_get(zmid).tzList
if cfg_tzList then
return cfg_tzList
end
return false
end


function XianjieXuanShangModel:addCDData(data)
if data.endTime>0 then
local cdd={}
local curTime=gameUtilityModel.getServerShortTime()
local cfg=cfgHelper.get1(cfg_xianjiexuanshangtaskconfig_get,data.taskId)
local ntime=cfg.time*60
cdd.beginTime=data.endTime-ntime
cdd.ntime=ntime
cdd.dtime=curTime-cdd.beginTime
cdd.cd=cdd.ntime-cdd.dtime
cdd.complete=cdd.dtime>=cdd.ntime
self.cdDatas[data.taskId]=cdd
end
end

function XianjieXuanShangModel:removeCDData(taskId)
self.cdDatas[taskId]=nil
end

function XianjieXuanShangModel:quickFinishTask(data)
if data then
local cddata=self:getCDData(data.taskId)
if cddata then
cddata.complete=true
end
end
end
function XianjieXuanShangModel:getCDData(taskId)
return self.cdDatas[taskId]
end
function XianjieXuanShangModel:getCDDatas()
return self.cdDatas
end
function XianjieXuanShangModel:isDispatching(taskId)
local data=self:getTaskDataSinglebyTaskid(taskId)
if data then
local task=data.taskList[taskId]
return task.endTime>0
end
return false
end

function XianjieXuanShangModel:hasTaskFinish()
local curTime=gameUtilityModel.getServerShortTime()
local list=self.data.TaskDatas
for k,v in pairs(list)do
if v and v.endTime>0 and curTime>=v.endTime and v.rwFlag==0 then
return true
end
end
return false
end

function XianjieXuanShangModel:cangetTask()
local num=0
for k,v in pairs(self.data.TaskDatas)do
if v and v.rwFlag==0 then
num=num+1
end
end
if num<3 then
return true
end
return false
end


function XianjieXuanShangModel:checkPassStart(_taskid)
if self.data.TaskDatas then
for k,v in pairs(self.data.TaskDatas)do
if v and v.taskId==_taskid then
local startTime=v.startTime
if startTime then
local xjxstBackTime=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'xjxstBackTime')
local nowstamp=timeHelper.getServerLongTime()
if xjxstBackTime then
local cd=timeHelper.convertLongStamp(startTime)+xjxstBackTime
return nowstamp>cd
end
end
end
end
end
return true
end


function XianjieXuanShangModel:checkDoneToday(_taskid)
if self.data.TaskDatas then

for k,v in pairs(self.data.TaskDatas)do
if v and v.taskId==_taskid then
local startTime=v.startTime



if self:getFiveTime(startTime,_taskid)then
return true
end
end
end
end
for k,v in ipairs(self.data.oldlist)do
for k,v in ipairs(self.data.oldlist)do
if v and v.param_1==_taskid then
local endtime=v.param_2



if self:getFiveTime(endtime,_taskid)then
return true
end
end
end
end
return false
end

function XianjieXuanShangModel:getFiveTime(endtime,_taskid)
endtime=timeHelper.convertLongStamp(endtime)

if timeHelper.isTodayStamp(endtime)then
local zerotime=timeHelper.getTodayZeroStamp()
local nowltime=gameUtilityModel.getServerLongTime()
local fivetime=zerotime+18000

if nowltime<=fivetime then
if endtime<fivetime then
return true
end
else
if endtime>=fivetime then
return true
end
end



else
local nowltime=timeHelper.getServerLongTime()
local zerotime=timeHelper.getTodayZeroStamp()
local fivetime=zerotime+18000




if nowltime<=fivetime then
if endtime+86400>fivetime then
return true
end
end
end
return false
end



function XianjieXuanShangModel:getXJXStaskidbyGuid(zmGuid)
if systemModel.isOpen(SYSTEM_DEFINE.eXianJieXuanShangTai)then
for k,v in pairs(self.data.TaskDatas)do
if v and v.zmGuid and v.zmGuid==zmGuid and v.rwFlag==0 then
return v.taskId
end
end
end
return false
end

function XianjieXuanShangModel:clearXJXStaskidbyGuid(zmGuid)
if systemModel.isOpen(SYSTEM_DEFINE.eXianJieXuanShangTai)then

for k,v in pairs(self.data.TaskDatas)do
if v and v.zmGuid and v.zmGuid==zmGuid and v.taskId then
self.data.TaskDatas[v.taskIndex]=false
self:removeCDData(v.taskId)
end
end
end
end

function XianjieXuanShangModel:testttttttttt()

end
