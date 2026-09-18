







activitiesHandle_festivalSignIn=new_activitiesHandle('activitiesHandle_festivalSignIn',activitiesHandle)

function activitiesHandle_festivalSignIn:onInit()
self.refreshTimer={}
end

function activitiesHandle_festivalSignIn:onDelete()
self:clearAllNextRefreshReddotTimer()
end


function activitiesHandle_festivalSignIn.recv_249_173(actId,subId,level,signInFlag,rewardFlag)
local subType=SUB_ACTIVITY_TYPE.eJieRiQianDao
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end
data.signInFlag=signInFlag
data.rewardFlag=rewardFlag


local config=activitiesModel:getSubActivityConfig(subType,subId)
local maxDayIndex=#config.rewards
local maxSignInDayIndex
for i=maxDayIndex,1,-1 do
local isSignIn=bitHelper.check_pos(signInFlag,i-1)
if isSignIn then
maxSignInDayIndex=i
break
end
end
data.maxSignInDayIndex=maxSignInDayIndex

activitiesModel:setSubActInfoData(actId,subType,subId,data)


UIManager:invokeUIMethod("UISubAct_FestivalSignInWin","initDate")
UIManager:invokeUIMethod("UISubAct_FestivalSignInWin","refresh")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

if maxSignInDayIndex and maxSignInDayIndex<maxDayIndex then
call_activitiesHandle_func('activitiesHandle_festivalSignIn','setNextRefreshReddotTimer',actId,subId)
end
end

function activitiesHandle_festivalSignIn:setNextRefreshReddotTimer(actId,subId)
local activityKey=FMT.fmt("{0}_{1}",actId,subId)
self:clearNextRefreshReddotTimer(activityKey)
local todayZeroTime=timeHelper.getTodayZeroStamp()
local nowTime=timeHelper.getServerLongTime()
local refreshTime=todayZeroTime+86400
local delta=refreshTime-nowTime
local subType=SUB_ACTIVITY_TYPE.eJieRiQianDao

if not self.refreshTimer then
self.refreshTimer={}
end

self.refreshTimer[activityKey]=timer.new()
self.refreshTimer[activityKey]:start(delta,function()

return activitiesController:sendProtocol(actSendType.eComonReqInfo,actId,subType,subId)
end,1)
end

function activitiesHandle_festivalSignIn:clearNextRefreshReddotTimer(activityKey)
if self.refreshTimer then
if self.refreshTimer[activityKey]then
self.refreshTimer[activityKey]:cancel()
self.refreshTimer[activityKey]=nil
end
end
end

function activitiesHandle_festivalSignIn:clearAllNextRefreshReddotTimer()
if self.refreshTimer then
for activityKey,timer in pairs(self.refreshTimer)do
timer:cancel()
self.refreshTimer[activityKey]=nil
end
end
self.refreshTimer=nil
end