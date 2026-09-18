






local _MODULENAME="xiangongpingdingModel"


def_table(_MODULENAME)
xiangongpingdingModel.name=_MODULENAME
xiangongpingdingModel.data={}


XIANGONG_TASK_TYPE=
{
eLock=0,
eReady=1,
eDoing=2,
eFinish=3,
eEnd=4,
}


local _pgimage={
[1]='image_xiangongpingding_pj5',
[2]='image_xiangongpingding_pj4',
[3]='image_xiangongpingding_pj3',
[4]='image_xiangongpingding_pj2',
[5]='image_xiangongpingding_pj1',
}


function xiangongpingdingModel:onAppStart()
self.maxQi=#cfg_xiangongpingdingtasklibconfig()
end


function xiangongpingdingModel:onEnterState(isReconnect)
self.data={}
self.data.pdInfo={}
xiangongpingdingModel:onInit({0,nil,nil,0,0,0,0,0})
end


function xiangongpingdingModel:onProtocolReq(isReconnect)

end


function xiangongpingdingModel:onLeaveState(isReconnect)
self.data={}
self.data.pdInfo={}
end


function xiangongpingdingModel:onInit(argtable)
local len=argtable[1]
local tasklist=argtable[2]
local endTime=argtable[3]
local pingJi=argtable[4]
local rwFlag=argtable[5]
local ljpingfen=argtable[6]
local rwJinDu=argtable[7]
local qiShu=argtable[8]

local data={}
if tasklist and#tasklist>1 then
table.sort(tasklist,function(a,b)
return cfgHelper.get2(cfg_xiangongpingdingtaskconfig_get,a,'sort')<
cfgHelper.get2(cfg_xiangongpingdingtaskconfig_get,b,'sort')
end)
end
data.tasklist=tasklist
data.endTime=endTime
data.pingJi=pingJi
data.rwFlag=rwFlag
data.ljpingfen=ljpingfen
data.state=XIANGONG_TASK_TYPE.eLock
data.rwJinDu=rwJinDu
data.qiShu=qiShu
self.data.pdInfo=data
xiangongpingdingModel:freshHisPrizeTag()
end

function xiangongpingdingModel:onInitRank(rankInfo)
self.data.rankInfo=rankInfo
end

function xiangongpingdingModel:onFreshProgress(rwJinDu)
self.data.pdInfo.rwJinDu=rwJinDu
xiangongpingdingModel:freshHisPrizeTag()
end

function xiangongpingdingModel:onRetPingDing(hisList)
self.data.hisList=hisList or{}
end

function xiangongpingdingModel:onRewards(rwFlag)
self.data.pdInfo.rwFlag=rwFlag
end

function xiangongpingdingModel:onTask(pingJi,ljpingfen,rank,rankNum)




local pdInfo=self.data.pdInfo
pdInfo.pingJi=pingJi
pdInfo.ljpingfen=ljpingfen

if self.data.rankInfo then
self.data.rankInfo.rank=rank
self.data.rankInfo.rankNum=rankNum
else
local rankInfo={}
rankInfo.rank=rank
rankInfo.rankNum=rankNum
self.data.rankInfo=rankInfo
end

xiangongpingdingModel:freshHisPrizeTag()
xiangongpingdingModel:freshCurTotalPingFen()
end

function xiangongpingdingModel:onStartTask(endTime)
self.data.pdInfo.endTime=endTime
end

function xiangongpingdingModel:clearHisList()
self.data.hisList=nil
end

function xiangongpingdingModel:freshHisPrizeTag()
local ljpingfen=xiangongpingdingModel:getLJPingFen()
local prizepingfen=xiangongpingdingModel:getPrizeJinDu()
local zpfReward=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'zpfReward')
for i,v in ipairs(zpfReward)do
local prizepf=v[1]
if ljpingfen>=prizepf then
if prizepingfen<prizepf and ljpingfen>prizepingfen then
self.data.pdInfo.hidPrizeTag=true
return
end
else
break
end
end
self.data.pdInfo.hidPrizeTag=false
end













function xiangongpingdingModel:getTaskList()
return self.data.pdInfo.tasklist
end

function xiangongpingdingModel:getTaskProgress(taskid)
local taskdata=taskModel:getTaskInfo(taskid)or
taskModel:getTask_timeOut(taskid)
local curnum=0
if taskdata then
local taskstateResult=taskModel:getTaskState(taskdata)
curnum=taskstateResult.curnum
end
return curnum
end

function xiangongpingdingModel:getTaskTotalProgress()
local tasklist=xiangongpingdingModel:getTaskList()
local pf=xiangongpingdingModel:getTotalPingFen()
local total_pf=0
for i=1,3 do
local taskid=tasklist[i]
if taskid then
local pf=cfgHelper.get2(cfg_xiangongpingdingtaskconfig_get,taskid,'pingfen')
total_pf=total_pf+pf
end
end
if pf==total_pf then return 100 end

return math.floor(pf/total_pf*100)
end









function xiangongpingdingModel:getPrizeFlag()
return self.data.pdInfo.rwFlag or 0
end

function xiangongpingdingModel:getTotalPingFen()
return self.data.pdInfo.pfTotal or 0
end

function xiangongpingdingModel:getPingJi()
return self.data.pdInfo.pingJi or 0
end

function xiangongpingdingModel:getEndTime()
return self.data.pdInfo.endTime or 0
end

function xiangongpingdingModel:getRankInfo()
return self.data.rankInfo
end

function xiangongpingdingModel:getHisList()
return self.data.hisList
end

function xiangongpingdingModel:getQiShu()
return self.data.pdInfo.qiShu or 0
end

function xiangongpingdingModel:getPrizeJinDu()
return self.data.pdInfo.rwJinDu or 0
end

function xiangongpingdingModel:getLJPingFen()
return self.data.pdInfo.ljpingfen or 0
end

function xiangongpingdingModel:getCurPingDingState()
return self.data.pdInfo.state or XIANGONG_TASK_TYPE.eLock
end

function xiangongpingdingModel:getMaxQi()
return self.maxQi
end

function xiangongpingdingModel:hasLjPrize()
return self.data.pdInfo.hidPrizeTag==true
end

function xiangongpingdingModel:isOpenSys()
return systemModel.isOpen(SYSTEM_DEFINE.eXGPD)
end

function xiangongpingdingModel:isEndPingDingTime()
local endTime=xiangongpingdingModel:getEndTime()
if endTime==nil or endTime==0 then return false end
local stamp=timeHelper.getServerShortTime()
return stamp>=endTime
end

function xiangongpingdingModel:freshCurPingDingState()
local state=xiangongpingdingModel:calculatePingDingState()
self.data.pdInfo.state=state

end

function xiangongpingdingModel:freshCurTotalPingFen()
xiangongpingdingModel:freshCurPingDingState()
local pingfen=xiangongpingdingModel:calculateCurTotalPingFen()
self.data.pdInfo.pfTotal=pingfen
xiangongpingdingController:printLog(FMT.fmt('刷新评分:{0}',pingfen))
end

function xiangongpingdingModel:calculateCurTotalPingFen()
local tasklist=xiangongpingdingModel:getTaskList()
if tasklist==nil then return 0 end
local state=xiangongpingdingModel:getCurPingDingState()
local isReady=state==XIANGONG_TASK_TYPE.eReady
local isLock=state==XIANGONG_TASK_TYPE.eLock
if isLock or isReady then return 0 end
local isFinish=state==XIANGONG_TASK_TYPE.eFinish
local total_pingfen=0
for i,taskid in ipairs(tasklist)do
local pf=cfgHelper.get2(cfg_xiangongpingdingtaskconfig_get,taskid,'pingfen')
local max=cfg_taskconfig_get(taskid).aimnum
local progress=xiangongpingdingModel:getTaskProgress(taskid)
if progress>max then progress=max end
local pingfen=math.floor(pf*progress/max)
xiangongpingdingController:printLog(FMT.fmt('计算任务评分！任务：{0}、评分：{1}、是否完成评定：{2}',taskid,pingfen,isFinish))
total_pingfen=total_pingfen+pingfen
end
xiangongpingdingController:printLog(FMT.fmt('计算总评分：{0}',total_pingfen))
return total_pingfen
end


function xiangongpingdingModel:calculatePingDingState()
local endTime=xiangongpingdingModel:getEndTime()
if not xiangongpingdingModel:isOpenSys()or endTime==nil then
return XIANGONG_TASK_TYPE.eLock
end
if endTime<=0 then
return XIANGONG_TASK_TYPE.eReady
else
local stamp=timeHelper.getServerShortTime()
local longStamp=timeHelper.convertLongStamp(stamp)
local endLongStamp=timeHelper.convertLongStamp(endTime)
local y,m,d,H,M,S=timeHelper.getServerStampData(endLongStamp)
local left=H*3600+M*60+S
local nextStamp=timeHelper.getServerZeroStamp(endLongStamp)

if left<=18000 then
nextStamp=nextStamp+18000
else
nextStamp=nextStamp+104400
end
if longStamp>=nextStamp then
return XIANGONG_TASK_TYPE.eEnd
elseif stamp>=endTime or
xiangongpingdingModel:isFinishAllTask()then
return XIANGONG_TASK_TYPE.eFinish
end
return XIANGONG_TASK_TYPE.eDoing
end
end

function xiangongpingdingModel:checkReqPingJi()
return self.data.pdInfo.pingJi<=0
end


function xiangongpingdingModel:isPingDingChanged()
local state=xiangongpingdingModel:getCurPingDingState()
if state==XIANGONG_TASK_TYPE.eReady then return true end
if state==XIANGONG_TASK_TYPE.eFinish and not xiangongpingdingModel:isPrize()then
return true
end
return false
end

function xiangongpingdingModel:isFinishTaskById(taskid)
if not xiangongpingdingModel:isOpenSys()or xiangongpingdingModel:getTaskList()==nil then
return false
end
local task=taskModel:getTaskInfo(taskid)or
taskModel:getTask_timeOut(taskid)
local state=task and taskModel:getTaskState_transfromstate(task)>=taskModel.taskRewardState or false
return state
end

function xiangongpingdingModel:isFinishAllTask()
local tasklist=xiangongpingdingModel:getTaskList()
if not xiangongpingdingModel:isOpenSys()or tasklist==nil then
return false
end
for i,taskid in ipairs(tasklist)do
if not xiangongpingdingModel:isFinishTaskById(taskid)then return false end
end
return true
end

function xiangongpingdingModel:isDoing()
return xiangongpingdingModel:getCurPingDingState()==XIANGONG_TASK_TYPE.eDoing
end

function xiangongpingdingModel:isReady()
return xiangongpingdingModel:getCurPingDingState()==XIANGONG_TASK_TYPE.eReady
end

function xiangongpingdingModel:isFinish()
return xiangongpingdingModel:getCurPingDingState()==XIANGONG_TASK_TYPE.eFinish
end

function xiangongpingdingModel:isEnd()
return xiangongpingdingModel:getCurPingDingState()==XIANGONG_TASK_TYPE.eEnd
end


function xiangongpingdingModel:calculateDoing()
return xiangongpingdingModel:calculatePingDingState()==XIANGONG_TASK_TYPE.eDoing
end


function xiangongpingdingModel:calculateFinish()
return xiangongpingdingModel:calculatePingDingState()==XIANGONG_TASK_TYPE.eFinish
end


function xiangongpingdingModel:calculateReady()
return xiangongpingdingModel:calculatePingDingState()==XIANGONG_TASK_TYPE.eReady
end

function xiangongpingdingModel:isPrize()
local flag=xiangongpingdingModel:getPrizeFlag()
return flag==1
end


function xiangongpingdingModel:isCanPrize()
if not initProControl.isDone()then
return false
end

if not xiangongpingdingModel:isFinish()then
return false
end

if xiangongpingdingModel:isPrize()then
return false
end

return true
end


function xiangongpingdingModel:hasAnyPrize()
if not initProControl.isDone()then
return false
end

return xiangongpingdingModel:isCanPrize()or
xiangongpingdingModel:hasLjPrize()
end

function xiangongpingdingModel:getPJImage(pingJi)
return _pgimage[pingJi]
end