function welfareController:onAppStart_ActivityCalendar()
welfareModel:onAppStart_ActivityCalendar()
end

function welfareController:onEnterState_ActivityCalendar(isReconnet)
welfareModel:onEnterState_ActivityCalendar(isReconnet)
if not isReconnet then
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
end

end

function welfareController:onLeaveState_ActivityCalendar(isReconnet)
welfareModel:onLeaveState_ActivityCalendar(isReconnet)
if not isReconnet then
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)
end
end

function welfareController:onProtocolReq_ActivityCalendar(isReconnet)
welfareModel:onProtocolReq_ActivityCalendar(isReconnet)
end

function welfareController:onServerDataInitFinish_ActivityCalendar()
welfareModel:onServerDataInitFinish_ActivityCalendar()
end

function welfareController:onLostConnection_ActivityCalendar()
welfareModel:onLostConnection_ActivityCalendar()
end

function welfareController.onNewDay_ActivityCalendar()
welfareModel:initShowCalendarCfg()
UIManager:invokeUIMethod("UIActivityCalendarWin","onShow")
UIManager:invokeUIMethod("UIActivityDetailWin","onClicker",true)
end

function welfareController.on_level_change()
welfareModel:initShowCalendarCfg()
UIManager:invokeUIMethod("UIActivityCalendarWin","onShow")
UIManager:invokeUIMethod("UIActivityDetailWin","onClicker",true)
end


function welfareController:checkActivityCalendarOpen()

if verifyManager:isHideBusinessActivity()then
return false
end
return systemModel.isOpen(SYSTEM_DEFINE.eActivityCalendar)
end

function welfareController:checkActivityCalendarReddot()
if not self:checkActivityCalendarOpen()then
return false
end
local reddot=welfareModel:getActivityCalendarReddot()
return reddot==0
end

function welfareModel:getActivityCalendarReddot()
if self.data.ActivityCalendar then
if self.data.ActivityCalendar.Reddot then
return self.data.ActivityCalendar.Reddot
else
self.data.ActivityCalendar.Reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActivityCalendar,'Reddot',0)
return self.data.ActivityCalendar.Reddot
end
else
self.data.ActivityCalendar={}
self.data.ActivityCalendar.Reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActivityCalendar,'Reddot',0)
return self.data.ActivityCalendar.Reddot
end
end

function welfareModel:setActivityCalendarReddot()
if self.data.ActivityCalendar and self.data.ActivityCalendar.Reddot==0 then

self.data.ActivityCalendar.Reddot=1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActivityCalendar,'Reddot',self.data.ActivityCalendar.Reddot)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActivityCalendar)
end
end

function welfareController:checkActivtyDoing(data)
if data.actType==CalendarActType.nomarl then
local actId=data.actId
return activitiesModel:checkActOpen(actId)
elseif data.actType==CalendarActType.baolingTree then
local nowTime=timeHelper.getServerLongTime()
local isInPickUpNow=nowTime>=data.timeInfo.startTime and nowTime<data.timeInfo.endTime
return isInPickUpNow
end
return false
end

function welfareController:ActivityCalendarJump(data)
if data.actType==CalendarActType.nomarl then
activitiesController:jump(data.actId)
elseif data.actType==CalendarActType.baolingTree then
UIFullBaoLingShuControl:showBaoLingShuWindow()
end
end

function welfareController:checkInActivityCalendar(actID)
if not welfareController:checkActivityCalendarOpen()then
return false
end
local cfg=welfareModel:getShowCalendarCfg()
for k,v in pairs(cfg)do
for kk,vv in pairs(v.actList)do
if vv.actId==actID then
return true
end
end
end
return false
end
