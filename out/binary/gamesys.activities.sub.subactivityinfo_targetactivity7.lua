









local subActivityInfo_targetActivity7={name='subActivityInfo_targetActivity7'}

function subActivityInfo_targetActivity7:onInit()
self:listenNotify(notifyConfig.onNewDay,function(...)
self:on_new_day(...)
end)
end

function subActivityInfo_targetActivity7:onStart()
end

function subActivityInfo_targetActivity7:onDelete()
end

function subActivityInfo_targetActivity7:on_new_day(...)
if self.data and self.data.tasksData then
local tasks=self:getSubActConfig('tasks')
for taskIdx,v in pairs(self.data.tasksData)do
local taskCfg=tasks[taskIdx]
local resetType=taskCfg[4]
if resetType==1 then
v.completeCnt=0
v.rewardCnt=0
end
end

UIManager:invokeUIMethod("UISubAct_TargetActivityWin7","refreshView")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end

function subActivityInfo_targetActivity7:checkReddot()
if not self:hasData()then return false end
local data=self:getData()
local tasksData=data.tasksData
local tasks=self:getSubActConfig('tasks')
for taskIdx,taskCfg in ipairs(tasks)do
local taskData=tasksData[taskIdx]
local aimCnt=taskCfg[3]
local resetType=taskCfg[4]
local rewardCntMax=taskCfg[5]
local rewardCnt=taskData and taskData.rewardCnt or 0
local completeCnt=taskData and taskData.completeCnt or 0
local isMax=rewardCnt>=rewardCntMax and resetType~=0
local complete=completeCnt>=((rewardCnt+1)*aimCnt)
if not isMax and complete then
return true
end
end
return false
end

function subActivityInfo_targetActivity7:initData(tasksList)
if not self.data then
self.data={
tasksData={},
}
end
if tasksList then
local tasksData={}
for i,v in ipairs(tasksList)do
local taskIdx=v.param_1
local completeCnt=v.param_2
local rewardCnt=v.param_3
tasksData[taskIdx]={completeCnt=completeCnt,rewardCnt=rewardCnt}
end
self.data.tasksData=tasksData
end
end

function subActivityInfo_targetActivity7:reqGetTaskReward(taskIdx)
local json_str=jsonHelper.encode({1,taskIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_targetActivity7:reqSaveTaskProgress(taskIdx)
local json_str=jsonHelper.encode({2,taskIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_targetActivity7