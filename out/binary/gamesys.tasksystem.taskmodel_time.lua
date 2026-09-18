







function taskModel:checkAllTaskTime()
local tasklist=taskModel:getTaskList()
local removeLookup={}
for i,taskdata in ipairs(tasklist)do
if taskdata.timesec>0 then
local taskstate=taskModel:getTaskState_transfromstate(taskdata)
if taskstate==taskModel.taskDoingState then
if taskModel:checkTaskTimeOut(taskdata)then
local taskid=taskdata.taskid
removeLookup[taskid]=taskdata
end
end
end
end

if next(removeLookup)~=nil then
for taskid,taskdata in pairs(removeLookup)do
local taskline=taskdata.taskline
taskModel:removeTask(taskline)
notifySystem:postNotify(notifyConfig.onTaskChange,taskid,taskModel.taskFinishState)
end
end

taskModel:refreshNewNextTask_coolDown()
end