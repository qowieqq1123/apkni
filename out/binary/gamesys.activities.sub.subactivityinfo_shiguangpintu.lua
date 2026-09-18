









local subActivityInfo_shiguangpintu={name='subActivityInfo_shiguangpintu'}

local _tempRow={}
local _tempCol={}
local _taskStateSortWeight={
[taskModel.taskDoingState]=1,
[taskModel.taskRewardState]=0,
[taskModel.taskFinishState]=2,
}

function subActivityInfo_shiguangpintu:onInit()
self._listenerTaskProgress=function(...)
self:refreshTaskProgress(...)
end
taskController:registerTaskCount(self._listenerTaskProgress)
end

function subActivityInfo_shiguangpintu:onStart()
local nums=self:getSubActConfig("row_col_num")
self._rowNum=nums[1]
self._colNum=nums[2]
self._gridNum=self._rowNum*self._colNum


end

function subActivityInfo_shiguangpintu:onDelete()
self:clearTask()
if self._listenerTaskProgress then
taskController:unregisterTaskCount(self._listenerTaskProgress)
end
self.data=nil
end

function subActivityInfo_shiguangpintu:checkReddot()
if not self:hasData()then return false end

for taskId,taskData in pairs(self.data.task)do
if taskData.task_state==taskModel.taskRewardState then
return true
end
end

local config=self:getSubActConfig()
local moneyNum=itemsModel.getCount(config.money)
table.clear(_tempRow)
table.clear(_tempCol)
local complete=true
for row=1,self._rowNum do
for col=1,self._colNum do
local index=self:covertRowCol2Grid(row,col)
local value=self.data.grid[index]
_tempRow[row]=value and _tempRow[row]~=false
_tempCol[col]=value and _tempCol[col]~=false
if not value then
if moneyModel.checkEnoughMoneyX(config.puzzle_conf[index][1])then
return true
end
complete=false
end
end
end

if complete and not self.data.complete then
return true
end

for i,v in ipairs(_tempRow)do
if v and not self.data.row[i]then
return true
end
end

for i,v in ipairs(_tempCol)do
if v and not self.data.col[i]then
return true
end
end

return false
end

function subActivityInfo_shiguangpintu:clearTask()
if self.data then
for taskId,taskData in pairs(self.data.task)do
if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
end
end
end
end

function subActivityInfo_shiguangpintu:initData(taskList,puzzleList,rowList,colList,allFlag)
self:clearTask()
if not self.data then
self.data={}
self.data.task={}
self.data.grid={}
self.data.col={}
self.data.row={}
end

for i=1,self._gridNum do
self.data.grid[i]=puzzleList[i]==1
end
for i=1,self._rowNum do
self.data.row[i]=rowList[i]==1
end
for i=1,self._colNum do
self.data.col[i]=colList[i]==1
end
self.data.complete=allFlag==1

self:initTask(taskList)
end

function subActivityInfo_shiguangpintu:initTask(tasks)
local config=self:getSubActConfig()
if tasks then
for i,v in ipairs(tasks)do
local taskId=i
local taskCfg=config.task_list[taskId]
local taskType=taskCfg[1][1]
local taskParam=taskCfg[1][3][1]
local taskTarget=taskCfg[1][2]
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil
local listenGuid=nil
local taskProgress=-1
local taskState=taskModel.taskDoingState
if v.param_1==1 then
taskState=taskModel.taskFinishState
elseif v.param_2>=taskTarget then
taskState=taskModel.taskRewardState
end
if taskState~=taskModel.taskFinishState then
listenGuid=nil
if check then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskId}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)

taskProgress=taskController:getTaskCount(taskType,taskParam)
if not needSave then
taskState=taskProgress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState
end
end
end
self.data.task[taskId]={
task_id=taskId,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=v.param_2,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
}
end
end

self.data.sortList={}
self.data.sortWeight={}
for taskId,taskCfg in pairs(config.task_list)do
local taskType=taskCfg[1][1]
local taskParam=taskCfg[1][3][1]
local taskTarget=taskCfg[1][2]
local check=taskModel:checkClientCheckTask(taskType)
local needSave=check and mathHelper.getBitValue(check,2)or nil

if not self.data.task[taskId]then
local listenGuid=nil
if check then
local funcArgs={actId=self.act_id,subType=self.sub_act_type,subId=self.sub_act_id,taskId=taskId}
local taskAim=needSave and taskTarget or nil
listenGuid=taskController:listenTaskCount(taskType,taskParam,funcArgs,taskAim)
end
local taskProgress=taskController:getTaskCount(taskType,taskParam)or-1
local taskState=taskModel.taskDoingState
if check and not needSave then
taskState=taskProgress>=taskTarget and taskModel.taskRewardState or taskModel.taskDoingState
end
self.data.task[taskId]={
task_id=taskId,
task_type=taskType,
task_params=taskParam,
count_flag=check,
client_progress=taskProgress,
server_progress=-1,
task_state=taskState,
task_target=taskTarget,
progress_listen=listenGuid,
}
end

local taskData=self.data.task[taskId]
if check and needSave then
if taskData.client_progress>=taskData.task_target and taskData.server_progress<taskData.task_target then
taskController:pushTempStorage(taskData.task_type,taskData.task_params,taskData.client_progress)
end
end

table.insert(self.data.sortList,taskId)
self.data.sortWeight[taskId]=self:getTaskSortWeight(taskId)
end

self.data.sorted=false

end

function subActivityInfo_shiguangpintu:setTaskProgress(list)
if not self:hasData()then return end
if list==nil then return end

local taskConfig=self:getSubActConfig("task_list")
local taskIds={}
local enoughs={}
for i,v in ipairs(list)do
local taskId=v.param_1
local taskProgress=v.param_2
local progressMax=taskConfig[taskId][1][2]
local taskData=self.data.task[taskId]
taskData.server_progress=taskProgress
if taskData.task_state~=taskModel.taskFinishState then
local check=taskProgress>=progressMax
local oldState=taskData.task_state
taskData.task_state=check and taskModel.taskRewardState or taskModel.taskDoingState
if oldState~=taskData.task_state then
self.data.sortWeight[taskId]=self:getTaskSortWeight(taskId)
table.insert(enoughs,taskId)
end
end
if taskData.progress_listen and taskData.task_state~=taskModel.taskDoingState then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
taskData.progress_listen=nil
end
table.insert(taskIds,taskId)
end
if#enoughs>0 then
self.data.sorted=false
self:invokePanelMethod("refreshTaskList")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
else
self:invokePanelMethod("refreshTaskItems",taskIds)
end
end

function subActivityInfo_shiguangpintu:refreshTaskProgress(list)
if not self:hasData()then return end
if list==nil then return end

local taskIds={}
local enoughs={}
for i,v in ipairs(list)do
local otherArgs=v.otherArgs
if self:compare(otherArgs.actId,otherArgs.subType,otherArgs.subId)then
local taskId=otherArgs.taskId
local taskData=self.data.task[taskId]
if taskData and taskData.task_state~=taskModel.taskFinishState and v.current~=taskData.client_progress then
local current=v.current
local previous=taskData.client_progress
taskData.client_progress=current
if taskData.count_flag and not mathHelper.getBitValue(taskData.count_flag,2)then
local oState=taskData.task_state
local nState=current>=taskData.task_target and taskModel.taskRewardState or taskModel.taskDoingState
taskData.task_state=nState
if oState~=nState then
self.data.sortWeight[taskId]=self:getTaskSortWeight(taskId)
table.insert(enoughs,taskId)
end
table.insert(taskIds,taskId)
end
end
end
end
if#enoughs>0 then
self.data.sorted=false
self:invokePanelMethod("refreshTaskList")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
else
self:invokePanelMethod("refreshTaskItems",taskIds)
end
end

function subActivityInfo_shiguangpintu:setTaskFinish(list)
if not self:hasData()then return end
if list==nil then return end

for index,taskId in pairs(list)do
local taskData=self.data.task[taskId]
taskData.task_state=taskModel.taskFinishState

if taskData.progress_listen then
taskController:unlistenTaskCount(taskData.task_type,taskData.task_params,taskData.progress_listen)
taskData.progress_listen=nil
end

self.data.sortWeight[taskId]=self:getTaskSortWeight(taskId)
end
self.data.sorted=false

self:invokePanelMethod("refreshTaskList")
end

function subActivityInfo_shiguangpintu:getTaskSortList()
if self:hasData()then
if not self.data.sorted then
self.data.sorted=true
if#self.data.sortList>1 then
table.sort(self.data.sortList,function(a,b)
return self.data.sortWeight[a]<self.data.sortWeight[b]
end)
end
end
return self.data.sortList
end
end

function subActivityInfo_shiguangpintu:getTaskData(taskId)
if self:hasData()then
return self.data.task[taskId]
end
end

function subActivityInfo_shiguangpintu:getTaskSortWeight(taskId)
local taskData=self.data.task[taskId]
local temp=_taskStateSortWeight[taskData.task_state]
return temp*10000+taskId
end

function subActivityInfo_shiguangpintu:covertRowCol2Grid(row,col)
return(row-1)*self._colNum+col
end

function subActivityInfo_shiguangpintu:covertGrid2RowCol(index)
local row=math.ceil(index/self._colNum)
local col=index-(row-1)*self._rowNum
return row,col
end

function subActivityInfo_shiguangpintu:getGridFlag(row,col)
if self:hasData()then
local index=self:covertRowCol2Grid(row,col)
return self.data.grid[index]
end
end

function subActivityInfo_shiguangpintu:getGridFlagEx(index)
if self:hasData()then
return self.data.grid[index]
end
end

function subActivityInfo_shiguangpintu:setGridFlag(row,col,flag)
if self:hasData()then
local index=self:covertRowCol2Grid(row,col)
self.data.grid[index]=flag
end
end

function subActivityInfo_shiguangpintu:setGridFlagEx(index,flag)
if self:hasData()then
self.data.grid[index]=flag
end
end

function subActivityInfo_shiguangpintu:getColFlag(col)
if self:hasData()then
return self.data.col[col]
end
end

function subActivityInfo_shiguangpintu:setColFlag(col,flag)
if self:hasData()then
self.data.col[col]=flag
end
end

function subActivityInfo_shiguangpintu:checkColEnough(col)
if self:hasData()then
for row=1,self._rowNum do
local index=self:covertRowCol2Grid(row,col)
if not self.data.grid[index]then
return false
end
end
return true
end
end

function subActivityInfo_shiguangpintu:getRowFlag(row)
if self:hasData()then
return self.data.row[row]
end
end

function subActivityInfo_shiguangpintu:setRowFlag(row,flag)
if self:hasData()then
self.data.row[row]=flag
end
end

function subActivityInfo_shiguangpintu:checkRowEnough(row)
if self:hasData()then
for col=1,self._colNum do
local index=self:covertRowCol2Grid(row,col)
if not self.data.grid[index]then
return false
end
end
return true
end
end

function subActivityInfo_shiguangpintu:checkCompleteEnough()
if self:hasData()then
for index=1,self._gridNum do
if not self.data.grid[index]then
return false
end
end
return true
end
end

function subActivityInfo_shiguangpintu:getCompleteFlag()
if self:hasData()then
return self.data.complete
end
end

function subActivityInfo_shiguangpintu:setCompleteFlag(flag)
if self:hasData()then
self.data.complete=flag
end
end

function subActivityInfo_shiguangpintu:findCanRewardRowList()
local rows={}
for i=1,self._rowNum do
if not self:getRowFlag(i)and self:checkRowEnough(i)then
table.insert(rows,i)
end
end
return rows
end

function subActivityInfo_shiguangpintu:findCanRewardColList()
local cols={}
for i=1,self._colNum do
if not self:getColFlag(i)and self:checkColEnough(i)then
table.insert(cols,i)
end
end
return cols
end

function subActivityInfo_shiguangpintu:findCanRewardTaskList()
local tasks={}
for i,v in pairs(self.data.task)do
if v.task_state==taskModel.taskRewardState then
table.insert(tasks,i)
end
end
return tasks
end

return subActivityInfo_shiguangpintu