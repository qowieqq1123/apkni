
batchTaskTagNumberHandle=tagNumberHandleBase.new({classname='batchTaskTagNumberHandle'})

batchTaskTagNumberHandle.handle_type=TagNumberHandleType.eBatchTask

batchTaskTagNumberHandle.catch_list={
TagNumberCatchType.eBatchTaskAccept,
TagNumberCatchType.eBatchTaskFinish,
}

batchTaskTagNumberHandle.refresh=function()
local taskList=taskModel:getTaskList()
local count=0
for i,v in ipairs(taskList)do
if v.cfg.showInMenu~=false and v.taskline~=taskModel.lineMain and v.taskstate~=taskModel.taskFinishState and not systemZongMenModel:getTaskBelongEx(v)and(v.taskstate~=taskModel.taskAcceptState or v.cfg.accept_npc==nil)and(xjFactionNPCModel:findNPCByTask(v.taskid)==nil or v.taskstate==taskModel.taskRewardState)then
count=count+1
end
end
return count
end

tagNumberController:register_class(batchTaskTagNumberHandle)

