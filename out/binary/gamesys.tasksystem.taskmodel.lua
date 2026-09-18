







taskModel={}


taskModel.taskAcceptState=0
taskModel.taskDoingState=1
taskModel.taskRewardState=2
taskModel.taskFinishState=3

taskModel.lineMain=1

local taskList={}
local taskHasLineLookup
local taskFinishLineLookup
local taskInitLineLookup
local taskListIDLookup
local taskLineCoolDownLookup
local taskConditionTypeLookup
local taskTimeOutLookup
table_insert=table.insert
table_remove=table.remove
local _dailyTaskData={}

function taskModel:insertTask(taskdata)
local taskid=taskdata.taskid
local taskline=taskdata.taskline

taskModel:removeTask(taskline)


if taskdata.conditionsLookup==nil then
local conditionsLookup={}
if taskdata.cfg.conditions then
for i,v in ipairs(taskdata.cfg.conditions)do
conditionsLookup[v[1]]=true
end
end
taskdata.conditionsLookup=conditionsLookup
end
table_insert(taskList,taskdata)
taskListIDLookup[taskid]=taskdata
taskHasLineLookup[taskdata.taskline]=true
end

function taskModel:removeTask(taskline)
local found,foundIdx=taskModel:getTaskByLine(taskline)
if found then
local taskid=found.taskid
taskFinishLineLookup[found.taskline]=taskid
table_remove(taskList,foundIdx)
taskListIDLookup[taskid]=nil
return true
end
return false
end

function taskModel:removeTaskDirect(taskid)
local found,foundIdx=taskModel:getTask(taskid)
if found then
table_remove(taskList,foundIdx)
taskListIDLookup[taskid]=nil
return true
end
return false
end

function taskModel:getTaskInfo(taskid)
if taskListIDLookup then
return taskListIDLookup[taskid]
end
end

function taskModel:getTask(taskid)
for i,v in ipairs(taskList)do
if v.taskid==taskid then
return v,i
end
end
return nil,nil
end

function taskModel:getTaskByLine(taskline)
for i,v in ipairs(taskList)do
if v.taskline==taskline then
return v,i
end
end
return nil,nil
end

function taskModel:getLineFinishTaskID(taskline)
local finiID=taskFinishLineLookup[taskline]
return finiID
end

function taskModel:hasTask(taskid)
return taskListIDLookup[taskid]~=nil
end

function taskModel:checkTaskFinish(taskid)
if not taskController:checkInit()then
logErr(FMT.fmt('在任务初始化完成前，请勿调用，任务id--{0}',taskid))
return false
end
local flag=false
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg then
local taskline=taskcfg.tasklineid
local finiID=taskFinishLineLookup[taskline]
local checkType=1
local lineTask=taskModel:getTaskByLine(taskline)
if lineTask then
if finiID==nil or lineTask.taskid>finiID then
finiID=lineTask.taskid
checkType=2
end
end

if finiID~=nil then
if checkType==1 then
flag=taskid<=finiID
else
flag=taskid<finiID
end
end
end
return flag
end

function taskModel:initLookup()
local sPT=gameUtilityModel.getServerPlatform()
taskInitLineLookup={}
local initcfgs=cfg_taskinitconfig()
for k,v in pairs(initcfgs)do
if v.pflist==nil or v.pflist[sPT]==nil then
local opentime=v.opentime
if opentime then
local min=timeHelper.dataToTimeStam(opentime[1])
local max=timeHelper.dataToTimeStam(opentime[2])
local otime=timeHelper.getServerOpenLongTime()
if otime>=min and otime<=max then
taskInitLineLookup[v.taskline]=v
end
else
taskInitLineLookup[v.taskline]=v
end
end
end
taskConditionTypeLookup={}
local cfgs=cfg_taskconfig()
for i,taskcfg in pairs(cfgs)do
if taskcfg.id~=nil then
if taskcfg.conditions then
for i2,v in ipairs(taskcfg.conditions)do
local typo=v[1]
if taskConditionTypeLookup[typo]==nil then taskConditionTypeLookup[typo]={}end
taskConditionTypeLookup[typo][taskcfg.id]=true
end
end
end
end
end

function taskModel:getLineFirstID(taskline)
local data=taskInitLineLookup[taskline]
if data then
return data.id
end
return nil
end

function taskModel:clearData()
taskList={}
taskFinishLineLookup=nil
taskInitLineLookup=nil
taskHasLineLookup=nil
taskListIDLookup=nil
_dailyTaskData={}
taskLineCoolDownLookup=nil
taskConditionTypeLookup=nil
taskTimeOutLookup=nil
end

function taskModel:checkTaskTimeOut(taskdata,isInit)
if taskTimeOutLookup==nil then return end
if taskdata==nil then return end
if taskdata.timesec>0 then
local lerp=taskdata.timesec-gameUtilityModel.getServerShortTime()
if lerp<=0 then
local taskid=taskdata.taskid
if not isInit then

taskModel:getTaskState(taskdata)
end
taskTimeOutLookup[taskid]=taskdata
return true
end
end
return false
end

function taskModel:getTask_timeOut(taskid)
if taskTimeOutLookup==nil then return end
return taskTimeOutLookup[taskid]
end

function taskModel:initTaskList(list)
taskList={}
taskHasLineLookup={}
taskFinishLineLookup={}
taskListIDLookup={}
taskTimeOutLookup={}
if list then
for i,v in ipairs(list)do
local taskid=v.taskid
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg then
if v.taskstate~=taskModel.taskFinishState then

if v.taskprogress>=taskcfg.aimnum and v.taskstate==taskModel.taskDoingState then
v.taskstate=taskModel.taskRewardState
end
local taskdata={}
taskdata.cfg=taskcfg
taskdata.taskid=taskid
taskdata.taskstate=v.taskstate
taskdata.taskline=taskcfg.tasklineid
taskdata.taskprogress=v.taskprogress
taskdata.timesec=v.timesec or 0

if not taskModel:checkTaskTimeOut(taskdata,true)then
taskModel:insertTask(taskdata)
end
else
taskFinishLineLookup[taskcfg.tasklineid]=taskid
end
taskHasLineLookup[taskcfg.tasklineid]=true
end
end
end
end

function taskModel:getTaskConfig(taskid)
return cfgHelper.get1(cfg_taskconfig_get,taskid)
end

function taskModel:filterNewTaskLine()
if taskHasLineLookup==nil then return{}end
local list={}
for taskline,cfg in pairs(taskInitLineLookup)do
if taskHasLineLookup[taskline]==nil and not systemZongMenModel:getTaskBelongImp(taskline)then
table_insert(list,taskline)
end
end
return list
end

function taskModel:filterCurTaskLine()
local list={}
for i,taskdata in ipairs(taskList)do
list[taskdata.taskline]=taskdata
end
return list
end


function taskModel:refreshNewLineTask(isInit)
local ret={}
local filterline=taskModel:filterNewTaskLine()
if#filterline>0 then
for i,taskline in ipairs(filterline)do
local taskid=taskInitLineLookup[taskline].id
local add=taskModel:addNewTask(taskid)
if add then
table_insert(ret,taskid)

if not isInit then
if taskModel:fitAcceptCondition(taskid)then

local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.auto_accept_after then
taskController:doAcceptTask(taskid)
end
end
else
if taskModel:fitAcceptCondition(taskid)then

local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.auto_accept_after and not taskcfg.auto_jump and taskcfg.acceptTalk==nil and taskcfg.acceptPlot==nil then
taskController:doAcceptTask(taskid)
end
end
end
end
end
end
return ret
end


function taskModel:refreshNewNextTask(isInit)
local ret={}
local filterline=taskModel:filterCurTaskLine()
for taskline,taskid in pairs(taskFinishLineLookup or{})do
if filterline[taskline]==nil then
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg then

local nextid=taskcfg.nextid
if nextid~=nil and nextid~=0 then
local add=taskModel:addNewTask(nextid)
if add then
table_insert(ret,nextid)

if not isInit then
if taskModel:fitAcceptCondition(nextid)then

local taskcfg_=taskModel:getTaskConfig(nextid)
if taskcfg_ and taskcfg_.auto_accept_after then
taskController:doAcceptTask(nextid)
end
end
else
if taskModel:fitAcceptCondition(nextid)then

local taskcfg_=taskModel:getTaskConfig(nextid)
if taskcfg_ and taskcfg_.auto_accept_after and not taskcfg_.auto_jump and taskcfg_.acceptTalk==nil and taskcfg_.acceptPlot==nil then
taskController:doAcceptTask(nextid)
end
end
end
end
end
end
end
end
return ret
end



function taskModel:refreshNewNextTask_coolDown()
local filterline=taskModel:filterCurTaskLine()
for taskline,taskid in pairs(taskFinishLineLookup)do
local taskdata=filterline[taskline]
if taskdata==nil then
if taskModel:checkTaskHasCondition(taskid,taskConditionType.eTaskLineCooldowm)then
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg then

local nextid=taskcfg.nextid
if nextid~=nil and nextid~=0 then
local add=taskModel:addNewTask(nextid)
if add then
if taskModel:fitAcceptCondition(nextid)then

local taskcfg_=taskModel:getTaskConfig(nextid)
if taskcfg_ and taskcfg_.auto_accept_after then
taskController:doAcceptTask(nextid)
end
end
end
end
end
end
else
if taskdata.taskstate==taskModel.taskAcceptState then
local taskid_=taskdata.taskid
if taskModel:checkTaskHasCondition(taskid_,taskConditionType.eTaskLineCooldowm)then
local taskcfg=taskdata.cfg
if taskcfg.auto_accept_after then
if taskModel:fitAcceptCondition(taskid_)then
taskController:doAcceptTask(taskid_)
end
end
end
end
end
end
end


function taskModel:addNewTask(taskid)
local ret=false
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg and not taskModel:hasTask(taskid)then
local add=taskModel:fitShowConditon(taskid)
if add then
local taskdata={}
taskdata.cfg=taskcfg
taskdata.taskid=taskid
taskdata.taskline=taskcfg.tasklineid
taskdata.taskstate=taskModel.taskAcceptState
taskdata.taskprogress=0
taskdata.timesec=0
taskModel:insertTask(taskdata)
ret=true

local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
notifySystem:postNotify(notifyConfig.onTaskChange,taskid,t_taskstate)
end
end
return ret
end


function taskModel:acceptTask(taskid,timesec)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg==nil then return end

local taskdata=taskModel:getTask(taskid)
if taskdata==nil then
taskdata={}
taskdata.cfg=taskcfg
taskdata.taskid=taskid
taskdata.taskline=taskcfg.tasklineid
taskdata.taskstate=taskModel.taskAcceptState
taskdata.taskprogress=0
taskdata.timesec=timesec or 0
taskModel:insertTask(taskdata)

notifySystem:postNotify(notifyConfig.onTaskChange,taskid,taskdata.taskstate)
end


taskModel:judeNeedTrace(taskid,taskdata.taskline)

taskdata.taskstate=taskModel.taskDoingState
notifySystem:postNotify(notifyConfig.onTaskChange,taskid,taskdata.taskstate)

local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate~=taskdata.taskstate then
notifySystem:postNotify(notifyConfig.onTaskChange,taskid,t_taskstate)
end

if not taskModel:isMultiAcceptTask(taskid)then
if taskcfg.auto_jump then
taskController:doJump(taskid)
end
end

taskModel:SavetaskModel_newtask(taskdata.taskline,true,taskdata.taskid)

taskModel:newtaskweakGuide(taskdata.taskid)
taskModel:GetTaskjuqing(taskid)
end


function taskModel:autoGetReward(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg==nil then return end

if taskcfg.auto_get_reward==1 then
taskController:doGetTaskReward(taskid)
elseif taskcfg.auto_get_reward==2 then
taskController:setAutoGetRewardMark(taskid)
end
end


function taskModel:autoGetRewarEx(taskid)
local taskdata=taskModel:getTask(taskid)
if taskdata==nil then return end

local taskcfg=taskdata.cfg
local taskstate=taskModel:getTaskState_transfromstate(taskdata)
if taskstate==taskModel.taskRewardState then
if taskcfg.auto_get_reward==2 then
taskController:doGetTaskReward(taskid)
end
end
end


function taskModel:finishTask(taskdata,nextidx)
local taskid=taskdata.taskid
local taskline=taskdata.taskline

taskModel:removeTask(taskline)
notifySystem:postNotify(notifyConfig.onTaskChange,taskid,taskModel.taskFinishState)

local nextid=nil
local taskcfg=taskModel:getTaskConfig(taskid)
local ismulti=taskModel:isMultiSelectTask(taskid)
if ismulti then

if taskcfg.nextids and taskcfg.nextids[nextidx]then
nextid=taskcfg.nextids[nextidx]
end
else

nextid=taskcfg.nextid
if nextid~=nil and nextid~=0 and not taskModel:fitShowConditon(nextid)then
nextid=nil
end
end

if nextid~=nil and nextid~=0 then
local n_taskcfg=taskModel:getTaskConfig(nextid)
if n_taskcfg then
local n_taskdata={}
n_taskdata.cfg=n_taskcfg
n_taskdata.taskid=nextid
n_taskdata.taskline=n_taskcfg.tasklineid
n_taskdata.taskstate=taskModel.taskAcceptState
n_taskdata.taskprogress=0
n_taskdata.timesec=0
taskModel:insertTask(n_taskdata)

local n_taskstate=taskModel:getTaskState_transfromstate(n_taskdata)
notifySystem:postNotify(notifyConfig.onTaskChange,nextid,n_taskstate)

if taskModel:fitAcceptCondition(nextid)then

if ismulti or n_taskcfg.auto_accept_after then
taskController:doAcceptTask(nextid)
end
end
end
end
end

function taskModel:getTaskRewardList(taskid,rewardIndex)
local list={}
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg then
if taskcfg.taskReward then

list=taskcfg.taskReward
elseif taskcfg.taskRewards then

if rewardIndex~=nil then
if taskcfg.taskRewards[rewardIndex]~=nil then
list=taskcfg.taskRewards[rewardIndex]
end
else
local temp={}
for i,v in ipairs(taskcfg.taskRewards)do
for i1,v1 in ipairs(v)do
temp[v1[1]]=true
end
end
for k,v in pairs(temp)do
table_insert(list,{k,0})
end
end
end
end
return list
end

function taskModel:getTaskList()
return taskList
end


function taskModel:getTaskList_show()
local list={}



for i,v in ipairs(taskList)do
local fit=false
if v.cfg.showInMenu~=false then
local taskstate=taskModel:getTaskState_transfromstate(v)
local npcId=xjFactionNPCModel:findNPCByTask(v.taskid)
if npcId then
if taskstate==taskModel.taskDoingState or taskstate==taskModel.taskRewardState then
fit=true
end
else
local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
if taskstate==taskModel.taskDoingState or taskstate==taskModel.taskRewardState then
fit=true
elseif taskstate==taskModel.taskAcceptState then
if taskModel:fitShowConditon(v.taskid)and systemZM_ID==nil then
if v.cfg.accept_npc==nil then
fit=true
end
end
end
end
end
end
if fit then
table_insert(list,v)
end
end
return list
end

function taskModel:getTaskList_show2()
local list={}



for i,taskdata in ipairs(taskList)do
local fit=false
local taskstate=taskModel:getTaskState_transfromstate(taskdata)
local taskcfg=taskdata.cfg

local npcId=xjFactionNPCModel:findNPCByTask(taskdata.taskid)
if npcId and taskcfg.showInMenu~=false then
if taskstate==taskModel.taskDoingState or taskstate==taskModel.taskRewardState then
fit=true
end
else
local systemZM_ID=systemZongMenModel:getTaskBelong(taskdata.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
if taskcfg.showInMenu~=false then
if taskdata.taskline==taskModel.lineMain then
fit=true
elseif taskstate==taskModel.taskDoingState or taskstate==taskModel.taskRewardState then
fit=true
elseif taskstate==taskModel.taskAcceptState then
if taskModel:fitShowConditon(taskdata.taskid)and systemZM_ID==nil then
if taskcfg.accept_npc==nil then
fit=true
end
end
end
end
end
end

if fit then
local sorts={}
taskdata.sorts=sorts
sorts[1]=taskdata.taskline==taskModel.lineMain and 1 or 0
sorts[2]=taskstate==taskModel.taskRewardState and 1 or 0
sorts[3]=taskModel:isZhuiZongTask(taskdata.taskline)and 1 or 0
sorts[4]=taskdata.newTaskIndex or 0
sorts[5]=taskcfg.sort_weight or 0
sorts[6]=taskdata.taskid
table_insert(list,taskdata)
end
end
if#list>1 then
mathHelper.sortWeightList(list,nil,nil,nil,6,eSortOrder.eUp)
end
for i,taskdata in ipairs(taskList)do
taskdata.sorts=nil
end
return list
end

function taskModel:getTaskList_recommend()
local list={}

for i,v in ipairs(taskList)do
if v.cfg.showInMenu~=false then
if taskModel:isRecommendTask(v.cfg)and taskModel:fitShowConditon(v.taskid)then
table_insert(list,v)
end
end
end

if#list>1 then
for i,v in ipairs(taskList)do





local islock=taskModel:fitAcceptCondition(v.taskid)
local w_lock=islock and 0 or 1
local weight=v.cfg.fast_weight+100000*w_lock
v.fast_weight_temp=weight
end
table.sort(list,function(a,b)
return a.fast_weight_temp>b.fast_weight_temp
end)
for i,v in ipairs(taskList)do
v.fast_weight_temp=nil
end
end
return list
end


function taskModel:getTaskList_npc()
local list={}

for i,v in ipairs(taskList)do
local fit=false
if v.cfg.showInMenu~=false then
local taskstateResult=taskModel:getTaskState(v)
local taskstate=taskstateResult.state
if taskstate==taskModel.taskAcceptState then
if taskModel:fitShowConditon(v.taskid)then
if v.cfg.accept_npc~=nil then
fit=true
end
end
end
end
if fit then
table_insert(list,v)
end
end
return list
end


function taskModel:getTaskList_test()
local list={}

for i,v in ipairs(taskList)do
local fit=false
if v.cfg.showInMenu~=false then
local taskstateResult=taskModel:getTaskState(v)
local taskstate=taskstateResult.state
if taskstate==taskModel.taskAcceptState then
fit=true
end
end
if fit then
table_insert(list,v)
end
end
return list
end

function taskModel:getHasRewardTaskNum()
local num=0
for i,v in ipairs(taskList)do
if v.cfg.showInMenu~=false then
local t_taskstate=taskModel:getTaskState_transfromstate(v)
if t_taskstate==taskModel.taskRewardState then
num=num+1
end
end
end
return num
end


function taskModel:isMultiSelectTask(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
return taskcfg.nextids~=nil
end

function taskModel:isMultiAcceptTask(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
return taskcfg.nextids~=nil and taskcfg.tasksSelectType==2
end

function taskModel:isMultiCommitTask(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
return taskcfg.nextids~=nil and taskcfg.tasksSelectType==1
end

function taskModel:isRecommendTask(taskcfg)
return taskcfg.fast_weight~=nil
end

function taskModel.getLineTitleColorStr(taskline,str)
if taskline==taskModel.lineMain then
return FMT.fmt('<color=#f1ce78>{0}</color>',str)
else
return FMT.fmt('<color=#a1ec58>{0}</color>',str)
end
end

function taskModel.checkTaskCanJump(taskcfg)
return taskcfg.weakGuideThinking~=nil or taskcfg.weakGuide~=nil or taskcfg.jump~=nil or xianzhanModel:isXianZhanTask(taskcfg.id)
end


function taskModel:initTaskLineCoolDown(list)
taskLineCoolDownLookup={}
if list~=nil then
for i,v in ipairs(list)do
taskLineCoolDownLookup[v.param_1]=v.param_2
end
end
end

function taskModel:setTaskLineCoolDown(taskline)
taskLineCoolDownLookup[taskline]=gameUtilityModel.getServerShortTime()
end

function taskModel:getTaskLineCoolDown(taskline)
if taskline~=nil then
return taskLineCoolDownLookup[taskline]
end
end

function taskModel:checkTaskHasCondition(taskid,conditionType)
if taskConditionTypeLookup and taskConditionTypeLookup[conditionType]then
return taskConditionTypeLookup[conditionType][taskid]==true
end
return false
end




function taskModel:initDailyTaskData(flag,array,rewardIdx)
array=array or{}
_dailyTaskData.data=array
if#array>0 then
for i,v in ipairs(array)do

local config=cfgHelper.get1(cfg_everydaytaskconfig_get,v.id)
v.cfg=config
local target=config.require
v.need=target[2]
v.isFinish=function(self_)
return self_.finishNum>=self_.need
end
v.setWeight=function(self_)
local weight=1000-self_.cfg.sortid
if self_:isFinish()then
if self_.rewardStatus==0 then
weight=weight+10000
else
weight=weight-10000
end
end
self_.weight=weight
end
v:setWeight()
end
end
_dailyTaskData.dailyTargetFlag=flag
_dailyTaskData.dailyTargetRewardIdx=rewardIdx
end


function taskModel:getDailyTaskData()
if _dailyTaskData==nil then return end
return _dailyTaskData.data
end


function taskModel:getDailyTaskTargetRewardIdx()
return _dailyTaskData.dailyTargetRewardIdx or 1
end


function taskModel:setDailyTaskTargetGotFlag()
_dailyTaskData.dailyTargetFlag=1
end


function taskModel:setDailyTaskGotFlag(taskId)
local data=taskModel:getDailyTaskData()
if data==nil then return end
for i,v in ipairs(data)do
if v.id==taskId then
v.rewardStatus=1
v:setWeight()
break
end
end
end

function taskModel:setDailyTaskGotFlagEx(taskIds)
local data=taskModel:getDailyTaskData()
if data==nil then return end
for i,v in ipairs(data)do
if taskIds[v.id]~=nil then
v.rewardStatus=1
v:setWeight()
end
end
end


function taskModel:getDailyTaskDataById(taskId)
local data=taskModel:getDailyTaskData()
if data==nil then return nil end
if data then
for i,v in ipairs(data)do
if v.id==taskId then
return v
end
end
end
end

function taskModel:getDailyTaskReward(taskId)
local rewards=taskModel:GetDayTaskReward(taskId)
local rw=nil
local zmlv=zongmenModel:getLevel()
for i,v in ipairs(rewards)do
if zmlv>=v[1]and zmlv<=v[2]then
rw=v[3]
break
end
end
if rw==nil then
rw=rewards[#rewards][3]
end
return rw
end


function taskModel:checkDailyTaskTargetisGot()
return _dailyTaskData.dailyTargetFlag==1
end


function taskModel:checkDailyTaskIsGotById(taskData)
if taskData and taskData.rewardStatus==1 then
return true
end
return false
end


function taskModel:getDailyTaskFinishNumById(taskData)
if taskData then
return taskData.finishNum
end
return 0
end


function taskModel:getDailyTaskTargetNum()
local num=0
local data=taskModel:getDailyTaskData()
if data then
for i,v in ipairs(data)do
if v.rewardStatus==1 then
num=num+1
end
end
end
return num
end

function taskModel:getDailyTaskNum()
local num=0
local data=taskModel:getDailyTaskData()
if data then
return#data
end
return num
end


function taskModel:getSortDailyTaskData()
local data=taskModel:getDailyTaskData()
local res={}

if data then
for i,v in ipairs(data)do
table.insert(res,v)
end
end

if#res>1 then
table.sort(res,function(a,b)
return a.weight>b.weight
end)
end
return res
end


function taskModel:checkDailyTaskReddot()

local data=taskModel:getDailyTaskData()
if data and#data>0 then
for i,v in ipairs(data)do
local cur=v.finishNum
local need=v.need
if v.rewardStatus==0 and cur>=need then
return true
end
end
end

local curFinishNum=taskModel:getDailyTaskTargetNum()
local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
local needNum=cfgHelper.get2(cfg_everydaytasktargetconfig_get,rewardIdx,'condition')
local isCan=curFinishNum>=needNum
local isGot=taskModel:checkDailyTaskTargetisGot()
if not isGot and isCan then
return true
end
return false
end


function taskModel:getDiscipleAwakeTask()
local lines=cfgHelper.get2(cfg_discipleawakebaseconfig_get,1,"tasklines")
for i,v in ipairs(lines)do
local task,idx=self:getTaskByLine(v)
if task then
return task
end
end
end

function taskModel:getTaskWaitDuration(taskid)
local cfg=self:getTaskConfig(taskid)
for i,v in ipairs(cfg.conditions)do
if v[1]==taskConditionType.eTaskLineCooldowm then
return v[3]
end
end
end


function taskModel:GetCanFinishTask()
local canFinish={}
for i,v in ipairs(taskList)do
local fit=false
local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate==taskModel.taskRewardState then
table.insert(canFinish,v.taskid)
end
end
end
return canFinish
end


function taskModel:GetDayTaskTargetReward(rewardIdx)
local rewardCfgList=cfgHelper.get2(cfg_everydaytasktargetconfig_get,rewardIdx,'reward')

local gversion=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()
local list={}
if gversion and rewardCfgList and rewardCfgList[gversion]then
local temp=rewardCfgList[gversion]
if temp then
list=temp[pfId]or temp[-1]
end
else
local temp=rewardCfgList[1]
if temp then
list=temp[pfId]or temp[-1]
end
end
return list or{}
end


function taskModel:GetDayTaskReward(taskId)
local rewardCfgList=cfgHelper.get2(cfg_everydaytaskconfig_get,taskId,'reward')

local gversion=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()
local list={}
if gversion and rewardCfgList and rewardCfgList[gversion]then
local temp=rewardCfgList[gversion]
if temp then
list=temp[pfId]or temp[-1]
end
else
local temp=rewardCfgList[1]
if temp then
list=temp[pfId]or temp[-1]
end
end
return list or{}
end