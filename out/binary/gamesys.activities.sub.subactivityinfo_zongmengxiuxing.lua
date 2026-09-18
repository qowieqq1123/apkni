









local subActivityInfo_zongmengxiuxing={name='zongmengxiuxing'}
local TempState={
eNone=0,
eRecved=1,
eNotRecv=2,
eRecv=3,
}
function subActivityInfo_zongmengxiuxing:onInit()
self.cfg_target_rewards=self:getSubActConfig('target_rewards')
self.cfg_tasks=self:getSubActConfig('tasks')
self.serverCurDay=self:getStart2NowDay()
end

function subActivityInfo_zongmengxiuxing:onStart()

end

function subActivityInfo_zongmengxiuxing:onUpdate()

end

function subActivityInfo_zongmengxiuxing:onDelete()

end

function subActivityInfo_zongmengxiuxing:checkReddot()
if not self.data then

return false
end
return self:checkTargetReddot()or self:checkTaskReddot()

end



function subActivityInfo_zongmengxiuxing:checkNewDay()
if self.serverCurDay then
self.serverCurDay=self.serverCurDay+1
end
local curDay=self:getServerCurDay()
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","sortTaskDayCfg",curDay)
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshHorContent")
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","sortTaskDayCfg",curDay)
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","refreshHorContent")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end


function subActivityInfo_zongmengxiuxing:startActTime()

end


function subActivityInfo_zongmengxiuxing:checkTargetReddot()
local stage
for i,v in ipairs(self.cfg_target_rewards)do
stage=self:getTargetState(i)
if stage==TempState.eRecv then
return true
end
end
return false
end


function subActivityInfo_zongmengxiuxing:checkTaskReddot()
local state
for i,v in ipairs(self.cfg_tasks)do
state=self:getTaskState(i)
if state==TempState.eRecv then
return true
end
end
return false
end

function subActivityInfo_zongmengxiuxing:getTargetState(index)
local targetRecvIdx=self.data.targetRecvIdx
if not targetRecvIdx then
return TempState.eNone
end
if targetRecvIdx>=index then
return TempState.eRecved
end
local cfg=self.cfg_target_rewards[index]
local targetCount=cfg[1]
local allPro=self:getAllTaskPro()
if allPro>=targetCount then
return TempState.eRecv
end
return TempState.eNotRecv
end


function subActivityInfo_zongmengxiuxing:getAllTaskPro()
local allcount=0
local state
for i,v in ipairs(self.cfg_tasks)do
state=self:getTaskState(i)
if state==TempState.eRecved then
allcount=allcount+1
end
end
return allcount
end

function subActivityInfo_zongmengxiuxing:getTaskState(index)
local taskdatalookUp=self.data.taskdatalookUp
if not taskdatalookUp then
return TempState.eNone
end
local taskdata=taskdatalookUp[index]

local taskCfg=self.cfg_tasks[index]
local taskDay=taskCfg[5]
local curday=self:getServerCurDay()
if taskdata.task_flag==0 then
return TempState.eNotRecv
elseif taskdata.task_flag==1 and taskDay<=curday then
return TempState.eRecv
elseif taskdata.task_flag==2 then
return TempState.eRecved
end
return TempState.eNone
end

function subActivityInfo_zongmengxiuxing:getServerCurDay()
return self.serverCurDay or self:getStart2NowDay()
end

return subActivityInfo_zongmengxiuxing