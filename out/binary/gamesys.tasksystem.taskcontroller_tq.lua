





function taskController:onEnterState_TQ(isReconnect)
notifySystem:listenNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)

self.actTqLookup={}
end

function taskController:onLeaveState_TQ(isReconnect)
notifySystem:listenNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
table.clear(self.actTqLookup)
end

function taskController:onInitTQ(isReconnect)

self:onInitTQState()
self:onInitTQEffectData()
end

function taskController:onInitTQState()
self.isOpenTQ=self:checkActOpenAndHasTQEffect()
end

function taskController:getOpenTQState()
return self.isOpenTQ
end

function taskController:setOpenTQState(state)
self.isOpenTQ=state
end

function taskController:checkActOpenAndHasTQEffect()
local actSubList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengTeQuan)or{}
local isEffect=false
local info

if#actSubList>0 then
for k,actSubInfo in ipairs(actSubList)do
if actSubInfo:checkTQEffectByType(5)and actSubInfo:checkDoing()then
isEffect=true
info=actSubInfo
break
end
end
end
return isEffect,info
end

function taskController:getTqModelParams()
local state,subActInfo=self:checkActOpenAndHasTQEffect()
local params
if subActInfo then
params=subActInfo:getTqModelParams(5)
end
return params
end

function taskController:getTqSpeakList()
local state,subActInfo=self:checkActOpenAndHasTQEffect()
local params
if subActInfo then
params=subActInfo:getTqSpeakList(5)
end
return params
end

function taskController:onInitTQEffectData()

if self.isOpenTQ then
local dailyTaskDatas=taskModel:getDailyTaskData()or{}
for k,taskData in ipairs(dailyTaskDatas)do
if taskData.rewardStatus==0 or taskData.rewardStatus==1 then
taskData.finishNum=taskData.need
end
end

reddotControl.on_dailytask_changed()
UIManager:invokeUIMethod('UIDailyTaskWin','onShowArgRecv')
end
end

function taskController:onUpdateTQEffectData(ttype,taskData)
if ttype==1 then
if self.isOpenTQ then
if taskData.taskstate==1 then
taskData.taskstate=2
end
end
end
end

function taskController:setActTqLookup(actID,subid)
self.actTqLookup[actID]=subid
end

function taskController:getActTqLookup()
return self.actTqLookup
end

function taskController.onActivityStateChange(actID,state)
if state==activitiesModel.activityFinishState then
taskController:onInitTQState()
local isOpenTQ=taskController:getOpenTQState()
if isOpenTQ then
local actTqLookup=taskController:getActTqLookup()
if actTqLookup[actID]~=nil then
actTqLookup[actID]=nil
if not next(actTqLookup)then
taskController:setOpenTQState(false)
taskController:reqDailyTaskList()
end
end
end
end
end


function taskController.onSubActivityStateChange(actID,subType,subid,state)
if subType==SUB_ACTIVITY_TYPE.eXianMengTeQuan then
taskController:onInitTQState()
local isOpenTQ=taskController:getOpenTQState()
if state==activitiesModel.activityDoingState then
taskController:setActTqLookup(actID,subid)
if isOpenTQ then
taskController:onInitTQEffectData()
end
elseif state==activitiesModel.activityFinishState then
if not isOpenTQ then
taskController:reqDailyTaskList()
end
end
end
end
