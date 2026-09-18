





function myzsModel:initSeasonOpenStamp(openStamp)
self.seasonOpenStamp=openStamp
local time_contral=myzsModel:getBaseConfig('time_contral')
local seasonOpenStamp_Long=timeHelper.convertLongStamp(openStamp)
local date_Y,data_M=timeHelper.getDateNumber(seasonOpenStamp_Long)
local curTime_Long=timeHelper.getServerLongTime()
local cur_date_Y,cur_data_M=timeHelper.getDateNumber(curTime_Long)

local seasonNextStartStamp

if data_M==cur_data_M then
self.seasonEndStamp=timeHelper.getNextMonthDateStamp2(time_contral[3],time_contral[4],0,0)
seasonNextStartStamp=timeHelper.getNextMonthDateStamp2(time_contral[1],time_contral[2],0,0)
else
local timeInfo=timeHelper.dateServerStampData(curTime_Long)
self.seasonEndStamp=timeHelper.timeServer(timeInfo.year,timeInfo.month,time_contral[3],time_contral[4],0,0)

seasonNextStartStamp=timeHelper.timeServer(timeInfo.year,timeInfo.month,time_contral[1],time_contral[2],0,0)
end

self.seasonEndStamp=timeHelper.convertShortStamp(self.seasonEndStamp)
self.seasonNextStartStamp=timeHelper.convertShortStamp(seasonNextStartStamp)

local curTime=timeHelper.getServerShortTime()

self.delayDoUpdateEnd=timeEventController.delayDo(self.seasonEndStamp-curTime,function()
notifySystem:postNotify(notifyConfig.onMingYuanZhuShaStateChange)
end,true)

self.delayDoUpdateNextStart=timeEventController.delayDo(self.seasonNextStartStamp-curTime,function()
notifySystem:postNotify(notifyConfig.onMingYuanZhuShaStateChange)
end,true)

self:updateNextGroupUnlockTime()
end

function myzsModel:getSeasonOpenStamp()
local openStamp=self.seasonOpenStamp
if openStamp==nil then
logErr("开启时间缺失")
return
end
return openStamp
end

function myzsModel:getNextSeasonOpenStamp()
local seasonNextStartStamp=self.seasonNextStartStamp
if seasonNextStartStamp==nil then

return
end
return seasonNextStartStamp
end

function myzsModel:updateNextGroupUnlockTime()
local openStamp=self.seasonOpenStamp
local curTime=timeHelper.getServerShortTime()

local unlock_interval=myzsModel:getBaseConfig('unlock_interval')

local interValDayTime=unlock_interval*timeSecLook.eOneDaySec

local unlock_floor=myzsModel:getGroupUnlockLayer()
local maxGroupCount=myzsModel:getMaxGroupCount()

local firstUnlockFloor=unlock_floor[1]
local unlockFloorInterval=unlock_floor[2]


local unlockGroup=firstUnlockFloor
local nextUnlockGroup=0
local unlockTime=openStamp
for group=firstUnlockFloor,maxGroupCount,unlockFloorInterval do
unlockTime=unlockTime+interValDayTime
if curTime<unlockTime then
nextUnlockGroup=unlockGroup+unlockFloorInterval
nextUnlockGroup=Mathf.Min(nextUnlockGroup,maxGroupCount)
break
end
unlockGroup=unlockGroup+unlockFloorInterval
unlockGroup=Mathf.Min(unlockGroup,maxGroupCount)
end


self.curUnlockLayer=unlockGroup
self.curNextUnlockLayer=nextUnlockGroup
self.nextGroupLayerTime=unlockTime

if unlockTime>curTime then
self.delayDoUpdateNextGroup=timeEventController.delayDo(unlockTime-curTime+1,function()
myzsModel:updateNextGroupUnlockTime()
myzsModel:updateLevelType()
UIManager:invokeUIMethod("UIMingYuanZhuSha_MainWin","levelResult")
end,true)
end
end


function myzsModel:getSettlementTime()
return self.seasonEndStamp
end


function myzsModel:getNextLayerUnlockTime()
if self.nextGroupLayerTime==nil then
logErr("未更新下一组开启时间")
return
end
return self.nextGroupLayerTime
end

function myzsModel:getNextUnlockLayer()
if self.curNextUnlockLayer==nil then
logErr("未更新下一组开启时间")
return
end
return self.curNextUnlockLayer
end

function myzsModel:getCurOpenMaxLayer()
if self.curUnlockLayer==nil then
logErr("未更新下一组开启时间")
return
end
return self.curUnlockLayer
end

local _MYZS_OPENED_KEY="myzs_opened_state"
function myzsModel:readMYZSOpendState()
self.isOpened=userActorSetting.get(_MYZS_OPENED_KEY,0)
end

function myzsModel:writeMYZSOpendState()
userActorSetting.flushVal(_MYZS_OPENED_KEY,1,0)
end

function myzsModel:checkOpened()
if self.isOpened==nil then
self:readMYZSOpendState()
end
return self.isOpened==1
end

function myzsModel:checkInXiuSai()
local settlementTime=self:getSettlementTime()
local curTime=timeHelper.getServerShortTime()
return curTime>=settlementTime
end


function myzsModel:test_initOpenStamp()
myzsModel:initSeasonOpenStamp(self.seasonOpenStamp)
end