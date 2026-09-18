









local subActivityInfo_targetActivity={name='targetActivity'}

function subActivityInfo_targetActivity:onInit()

end

function subActivityInfo_targetActivity:onStart()

end

function subActivityInfo_targetActivity:onDelete()

end

function subActivityInfo_targetActivity:getTaskData(taskId)
return self.data.taskData[taskId]
end

function subActivityInfo_targetActivity:getTargetProgress()
return self.data.progress
end

function subActivityInfo_targetActivity:isGroupComplete(subId,groupId)
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,subId)
local tasks=cfg.grouprewards[groupId].task_ids
for i,v in ipairs(tasks)do
local td=self.data.taskData[v]
if not td or td.taskstate~=3 then
return false
end
end
return true
end

function subActivityInfo_targetActivity:isGroupRewardReceive(groupId)
local gstate=self:getGroupState(groupId)
local receive=false
if gstate then
receive=gstate==3
end

return receive
end

function subActivityInfo_targetActivity:checkGroupReddot(subId,groupId)
local state=self.data.groupData[groupId]
if state==2 then
return true
end
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,subId)
local tasks=cfg.grouprewards[groupId].task_ids
for i,v in ipairs(tasks)do
local td=self.data.taskData[v]
if td and td.taskstate==2 then
return true
end
end
return false
end

function subActivityInfo_targetActivity:getGroupState(groupId)
return self.data.groupData[groupId]
end

function subActivityInfo_targetActivity:checkReddot()
if not self.data then
return false
end
for k,v in pairs(self.data.groupData)do
if v==2 then
return true
end
end
for k,v in pairs(self.data.taskData)do
if v.taskstate==2 then
return true
end
end
return false
end

return subActivityInfo_targetActivity