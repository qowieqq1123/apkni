




function UIXianShuControl:onAppStart_TQ()

end

function UIXianShuControl:onEnterState_TQ(isReconnect)
notifySystem:listenNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)

self.data.actTqLookup={}
end

function UIXianShuControl:onLeaveState_TQ(isReconnect)
notifySystem:listenNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
end

function UIXianShuControl:onInitTQ(isReconnect)
self:onInitTQState()
self:onInitTQEffectData()
end

function UIXianShuControl:onInitTQState()
self.data.isOpenTQ=self:checkActOpenAndHasTQEffect()
end

function UIXianShuControl:getOpenTQState()
return self.data.isOpenTQ
end

function UIXianShuControl:setOpenTQState(state)
self.data.isOpenTQ=state
end


function UIXianShuControl:checkActOpenAndHasTQEffect()
local actSubList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengTeQuan)or{}
local isEffect=false
local info
if#actSubList>0 then
for k,actSubInfo in ipairs(actSubList)do
if actSubInfo:checkTQEffectByType(6)and actSubInfo:checkDoing()then
isEffect=true
info=actSubInfo
break
end
end
end
return isEffect,info
end

function UIXianShuControl:onInitTQEffectData()
if self.data.isOpenTQ then
local dailyTaskDatas=(self.data and self.data.taskDatas and self.data.taskDatas[1])or{}
for k,taskData in ipairs(dailyTaskDatas)do
if taskData.taskstate==1 and UIXianShuControl:checkTaskOpenCondition(taskData.taskid)then
taskData.taskstate=2
end
end

UIXianShuControl:refreshReddot()
UIManager:invokeUIMethod('UIXianShuTaskWin','refresh')
end
end

function UIXianShuControl:onUpdateTQEffectData(ttype,taskData)
if ttype==1 then
if self.data.isOpenTQ then
if taskData.taskstate==1 then
taskData.taskstate=2
end
end
end
end

function UIXianShuControl:getTqModelParams()
local state,subActInfo=self:checkActOpenAndHasTQEffect()
local params
if subActInfo then
params=subActInfo:getTqModelParams(6)
end
return params
end

function UIXianShuControl:getTqSpeakList()
local state,subActInfo=self:checkActOpenAndHasTQEffect()
local params
if subActInfo then
params=subActInfo:getTqSpeakList(6)
end
return params
end

function UIXianShuControl:setActTqLookup(actID,subid)
self.data.actTqLookup[actID]=subid
end

function UIXianShuControl:getActTqLookup()
return self.data.actTqLookup
end

function UIXianShuControl.onActivityStateChange(actID,state)
if state==activitiesModel.activityFinishState then
local isOpenTQ=UIXianShuControl:getOpenTQState()
if isOpenTQ then
local actTqLookup=UIXianShuControl:getActTqLookup()
if actTqLookup[actID]~=nil then
actTqLookup[actID]=nil
if not next(actTqLookup)then
UIXianShuControl:setOpenTQState(false)
UIXianShuControl:reqInitInfo()
end
end
end
end
end

function UIXianShuControl.onSubActivityStateChange(actID,subType,subid,state)
if subType==SUB_ACTIVITY_TYPE.eXianMengTeQuan then
UIXianShuControl:onInitTQState()
local isOpenTQ=UIXianShuControl:getOpenTQState()
if state==activitiesModel.activityDoingState then
UIXianShuControl:setActTqLookup(actID,subid)
if isOpenTQ then
UIXianShuControl:onInitTQEffectData()
end
elseif state==activitiesModel.activityFinishState then
if not isOpenTQ then
UIXianShuControl:reqInitInfo()
end
end
end
end