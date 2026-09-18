









local subActivityInfo_yufutarget={name='subActivityInfo_yufutarget'}

function subActivityInfo_yufutarget:onInit()

self:listenNotify(notifyConfig.onDisposeClientCheckTaskTypeEvent,function(...)
self:onDisposeClientCheckTaskTypeEvent(...)
end)

end

function subActivityInfo_yufutarget:onStart()

end

function subActivityInfo_yufutarget:onDelete()
if self.data and self.data.client and next(self.data.client)then
for k,v in pairs(self.data.client)do
taskController:unlistenTaskCount(v[2],v[3],v[1])
end
end

end

function subActivityInfo_yufutarget:onDisposeClientCheckTaskTypeEvent(eventType)

if not self.data then

return
end


local needRefresh=false
if self.data.clientID then
for k,v in pairs(self.data.clientID)do
if v and taskModel:checkClientCheckTaskEvent(v[3],eventType)then
needRefresh=true
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eYuFuMuBiao)
break
end
end
end

end

function subActivityInfo_yufutarget:checkReddot()
if self:recordFinishTask()then
return true
end

if self:judeTaskReddot()then
return true
end


return false
end


function subActivityInfo_yufutarget:GetTask(taskid)
local cfg=cfg_yufumubiaoacttaskconfig_get(taskid)

if taskModel:checkClientCheckTask(cfg.tasktype)and not self.data.client[taskid]then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskid}

local listenGuid=taskController:listenTaskCount(cfg.tasktype,cfg.params,funcArgs,cfg.aimnum)
self.data.client[taskid]={listenGuid,cfg.tasktype,cfg.params}
end

if self.data.client[taskid]then
return taskController:getTaskCount(cfg.tasktype,cfg.params)
end
return false
end


function subActivityInfo_yufutarget:FindClientTask()
self.data.client={}
self.config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
self.data.clientID={}
self.data.curActClientTaskID={}
local cfg_taskList=self.config.taskList

for k,v in pairs(cfg_taskList)do
for k1,v1 in ipairs(v)do
self.data.curActClientTaskID[v1]=true
if self:GetTask(v1)then
local cfg=cfg_yufumubiaoacttaskconfig_get(v1)
local num=self:GetTask(v1)
if num>cfg.aimnum then
num=cfg.aimnum
end
self.data.clientID[v1]={num,cfg.aimnum,cfg.tasktype}
end
end
end
end


function subActivityInfo_yufutarget:recordFinishTask()
self:FindClientTask()

self.data.recordFinishTask={}
self.data.recordFinishTaskGroup={}
if self.data.tasklist and next(self.data.tasklist)then
for k,v in ipairs(self.data.tasklist)do
if v.finishFlag==1 or v.rwFlag==1 then
self.data.recordFinishTask[#self.data.recordFinishTask+1]=v.taskId
end
end
end

for k,v in pairs(self.data.clientID)do
if v[1]>=v[2]then
local flag=true
for k1,v1 in ipairs(self.data.recordFinishTask)do
if v1==k then
flag=false
end
end
if flag then
self.data.recordFinishTask[#self.data.recordFinishTask+1]=k
end
end
end



self.config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local taskList=self.config.taskList

for k,v in pairs(taskList)do
local flag=true

for k1,v1 in ipairs(v)do
local singleflag=false
for k2,v2 in ipairs(self.data.recordFinishTask)do
if v1==v2 then
singleflag=true
break
end
end

if not singleflag then
flag=false
end
end
if flag then

self.data.recordFinishTaskGroup[#self.data.recordFinishTaskGroup+1]=k
end
end
if next(self.data.recordFinishTaskGroup)then

if not self.data.zjrwTagList then
return false
end
if next(self.data.zjrwTagList)then

if#self.data.recordFinishTaskGroup>#self.data.zjrwTagList then
return true
end
else
return true
end
end
return false
end

function subActivityInfo_yufutarget:judeTaskReddot()
if self.data.tasklist and next(self.data.tasklist)then
for k,v in ipairs(self.data.tasklist)do
if self.data.curActClientTaskID[v.taskId]then
if v.finishFlag==1 then
if v.rwFlag==0 then

return true
end
end
end
end
end

for k,v in pairs(self.data.clientID)do
if v[1]>=v[2]then

local flag=true
for k1,v1 in ipairs(self.data.tasklist)do
if k==v1.taskId then
flag=false
if v1.rwFlag==0 then
return true
end
end
end
if flag then
return true
end
end
end


end

return subActivityInfo_yufutarget