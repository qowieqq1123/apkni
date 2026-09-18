
local subActivityInfo_daobingge={name='daobingge'}

function subActivityInfo_daobingge:onInit()
self._on_new_day=function(...)
self:on_new_day(...)
end
notifySystem:listenNotify(notifyConfig.onNewDay,self._on_new_day)
end

function subActivityInfo_daobingge:onStart()

end

function subActivityInfo_daobingge:onDelete()
notifySystem:removelistener(notifyConfig.onNewDay,self._on_new_day)
end

function subActivityInfo_daobingge:checkReddot()
return self:hasDayTaskReddot()or
self:hasTaskReddot()or
self:hasAnyPrize()

end

local _tasktype=
{
eDayTask=1,
eTask=2,
}

function subActivityInfo_daobingge:getPrizelv()
local data=self.data
if data==nil then return 0,0 end
return data.commonLv,data.luxuryLv
end


function subActivityInfo_daobingge:getRechargeList()
local data=self.data
if data==nil then return end
return data.rechargeList or{}
end


function subActivityInfo_daobingge:isRecharge()
local data=self.data
if data==nil then return false end
local rechargeList=data.rechargeList
if rechargeList then return#rechargeList>0 end
return false
end


function subActivityInfo_daobingge:isRechargeBest()
local data=self.data
if data==nil then return false end
local subCfg=self:getSubActConfig()
local recharge_rewards=subCfg.recharge_rewards
local bestInfo=recharge_rewards[#recharge_rewards]
local id=bestInfo[1]
local isRechargeId=self:isRechargeId(id)
if not isRechargeId then
for i=1,2 do
local bestInfo=recharge_rewards[i]
local id=bestInfo[1]
local isRechargeId=self:isRechargeId(id)
if not isRechargeId then return false end
end
end
return true
end

function subActivityInfo_daobingge:getDayTaskList()
local data=self.data
if data==nil then return false end
return data.dayTaskList or{}
end

function subActivityInfo_daobingge:getTaskList()
local data=self.data
if data==nil then return false end
return data.taskList or{}
end

function subActivityInfo_daobingge:getDayTaskData(taskline,idx)
local data=self.data
if data==nil then return end
local taskList=data.dayTaskList or{}
for i,v in ipairs(taskList)do
if v.task_type==taskline and v.task_idx==idx then
return v
end
end
end

function subActivityInfo_daobingge:getTaskData(taskline,idx)
local data=self.data
if data==nil then return end
local taskList=data.taskList or{}
for i,v in ipairs(taskList)do
if v.task_type==taskline and v.task_idx==idx then
return v
end
end
end


function subActivityInfo_daobingge:isRechargeId(id)
local data=self.data
if data==nil then return false end
local rechargeList=data.rechargeList or{}
for i,v in ipairs(rechargeList)do
if v==id then return true end
end
return false
end

function subActivityInfo_daobingge:hasDayTaskReddot()
local data=self.data
if data==nil then return false end
local dayTaskList=data.dayTaskList or{}
for i,v in ipairs(dayTaskList)do
if self:canPrize(_tasktype.eDayTask,v)then return true end
end
return false
end

function subActivityInfo_daobingge:hasTaskReddot()
local data=self.data
if data==nil then return false end
local taskList=data.taskList or{}
for i,v in ipairs(taskList)do
if self:canPrize(_tasktype.eTask,v)then return true end
end
return false
end

function subActivityInfo_daobingge:canPrize(tasktype,task)
local subCfg=self:getSubActConfig()
local taskline=task.task_type
local idx=task.task_idx
local num=task.task_progress
local flag=task.task_flag
local cfg=self:getOneTaskCfg(tasktype,taskline,idx)
if cfg==nil then return false end
local maxnum=cfg[2][1]
if num>=maxnum and flag==0 then return true end
end

function subActivityInfo_daobingge:canPrizeByCfg(tasktype,taskline,idx,taskCfg)
local subCfg=self:getSubActConfig()
local task=self:getTaskData(taskline,idx)
if tasktype==_tasktype.eDayTask then
task=self:getDayTaskData(taskline,idx)
end
task=task or{}
local num=task.task_progress or 0
local flag=task.task_flag or 0
local maxnum=taskCfg[2][1]
if num>=maxnum and flag==0 then return true end
return false
end

function subActivityInfo_daobingge:isPrize(task)
return task and task.task_flag==1 or false
end

function subActivityInfo_daobingge:hasAnyPrize()
local data=self.data
if data==nil then return false end
local lv=self.data.lv
local prizelv,prizeluxuryLv=self:getPrizelv()
if prizelv<lv then return true end
if not self:isRecharge()then return false end
if prizeluxuryLv<lv then return true end
local subCfg=self:getSubActConfig()
local lv_info=subCfg.lv_info
if lv_info==nil then return false end
local maxLevel=lv_info[1]
if lv>=maxLevel then
local moneyType=subCfg.money_type
local has=moneyModel.getMoney(moneyType)
local cost_num=subCfg.cost_num
if has>=cost_num then return true end
end
return false
end

function subActivityInfo_daobingge:getCanPrizeList()
local subCfg=self:getSubActConfig()
local lv_rewards=subCfg.lv_rewards
local maxlv=#lv_rewards
local data=self.data
local lv=data.lv
local commonLv=data.commonLv
local luxuryLv=data.luxuryLv
local isRecharge=self:isRecharge()

local temp={}
local targetlv=math.min(lv,maxlv)

for i=commonLv+1,targetlv do
temp=attrListHelper.concatList(temp,lv_rewards[i][1])
end

if isRecharge then
for i=luxuryLv+1,targetlv do
temp=attrListHelper.concatList(temp,lv_rewards[i][2])
end
end

local sortTag={}
for i,v in ipairs(temp)do
local itemid=v[1]
local itemsCfg=itemsConfig.getConfig(itemid)
local color=itemsCfg.color
sortTag[itemid]=color*10000-itemid/10000
end

table.sort(temp,function(a,b)
return sortTag[a[1]]>sortTag[b[1]]
end)

return temp
end


function subActivityInfo_daobingge:getBuyPrizeByRecharge(isRecharge,lv,targetlv)
local subCfg=self:getSubActConfig()
local lv_rewards=subCfg.lv_rewards
local temp={}
lv=lv or 1
targetlv=targetlv or#lv_rewards
for i=lv,targetlv do
temp=attrListHelper.concatList(temp,lv_rewards[i][1])
end

if isRecharge then
targetlv=targetlv or#lv_rewards
for i=lv,targetlv do
temp=attrListHelper.concatList(temp,lv_rewards[i][2])
end
end

local sortTag={}
for i,v in ipairs(temp)do
local itemid=v[1]
local itemsCfg=itemsConfig.getConfig(itemid)
local color=itemsCfg.color
sortTag[itemid]=color*10000-itemid/10000
end

table.sort(temp,function(a,b)
return sortTag[a[1]]>sortTag[b[1]]
end)

return temp
end

function subActivityInfo_daobingge:getBuyPrize(lv,targetlv)
local subCfg=self:getSubActConfig()
local lv_rewards=subCfg.lv_rewards
local temp={}
lv=lv or 1
targetlv=targetlv or#lv_rewards
for i=lv,targetlv do
temp=attrListHelper.concatList(temp,lv_rewards[i][2])
end

local sortTag={}
for i,v in ipairs(temp)do
local itemid=v[1]
local itemsCfg=itemsConfig.getConfig(itemid)
local color=itemsCfg.color
sortTag[itemid]=color*10000-itemid/10000
end

table.sort(temp,function(a,b)
return sortTag[a[1]]>sortTag[b[1]]
end)

return temp
end

function subActivityInfo_daobingge:setRecordDaoBingItemid(itemid)
local data=self.data
if data==nil then return end
local act=self.sub_act_type
local actId=self.sub_act_id
if act==nil or actId==nil then return end
userActorSetting.flushVal(FMT.fmt('dbs_{0}_{1}',act,actId),itemid)
end

function subActivityInfo_daobingge:getRecordDaoBingItemid()
local data=self.data
if data==nil then return end
local act=self.sub_act_type
local actId=self.sub_act_id
if act==nil or actId==nil then return end
return userActorSetting.get(FMT.fmt('dbs_{0}_{1}',act,actId),nil)
end

function subActivityInfo_daobingge:getTaskCfg()
local subCfg=self:getSubActConfig()
local task=subCfg.task
local list={}
for taskline,v in pairs(task)do
for i,vv in pairs(v)do
if self:showTask(_tasktype.eTask,taskline,i,vv)then
list[#list+1]={i,vv,taskline}
end
end
end
return list
end

function subActivityInfo_daobingge:getDayTaskCfg()
local subCfg=self:getSubActConfig()
local day_task=subCfg.day_task
local list={}
for taskline,v in pairs(day_task)do
for i,vv in ipairs(v)do
if self:showTask(_tasktype.eDayTask,taskline,i,vv)then
list[#list+1]={i,vv,taskline}
end
end
end
return list
end



function subActivityInfo_daobingge:getLeftTaskTime(tasktype,taskline,idx,taskCfg)
local day=self:getOpenDayIndex()
local openday=taskCfg[3]
local endday=taskCfg[4]
if day>=openday then
if endday==0 then return-1 end
if self:canPrizeByCfg(tasktype,taskline,idx,taskCfg)then return-1 end
local day=endday-day
if day>=0 then
local endStamp=timeHelper.getTodayZeroStamp()+(day+1)*24*3600
local left=endStamp-timeHelper.getServerLongTime()
if left>0 then return left end
end
return 0
end
return-2
end

function subActivityInfo_daobingge:showTask(tasktype,taskline,idx,taskCfg)
local day=self:getOpenDayIndex()
local openday=taskCfg[3]
local endday=taskCfg[4]
if day>=openday then
if endday==0 then return true end
if self:canPrizeByCfg(tasktype,taskline,idx,taskCfg)then return true end
local day=endday-day
if day>=0 then
local endStamp=timeHelper.getTodayZeroStamp()+(day+1)*24*3600
local left=endStamp-timeHelper.getServerLongTime()
if left>0 then return true end
end
end
return false
end

function subActivityInfo_daobingge:getOneTaskCfg(taskType,taskline,idx)
local subCfg=self:getSubActConfig()
local taskCfg=subCfg.task
if taskType==_tasktype.eDayTask then
taskCfg=subCfg.day_task
end
local cfg
if taskCfg[taskline]then
cfg=taskCfg[taskline][idx]
end
if cfg==nil then
loggerUtil.logErrFMT('没找到道兵阁任务配置！taskType：{0} taskline：{1} idx：{2}',taskType,taskline,idx)
end
return cfg
end

function subActivityInfo_daobingge:on_new_day()
local data=self.data
if data==nil then return end
data.dayTaskList=nil
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','freshCurTaskInfo')
end

return subActivityInfo_daobingge