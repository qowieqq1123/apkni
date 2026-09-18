
emergenciesModel={}

emergenciesType={
eBuildingOnFire=1,
eMonsterInvasion=2,
eJiQuanBuNing=3,
eYiMuCongSheng=4,
eYouHunRaoLuan=5,
eRuiShouLinMen=6,
eYiShiLaiKe=7,
eSystemZongMenSpy=8,
}

function emergenciesModel:onEnterState(...)
self.data={eventId=0}
self.repairData={}
self.productionCutList={}

end

function emergenciesModel:onLeaveState(...)
self.data=nil
self.repairData=nil
self:clearData()
end










function emergenciesModel:getEmergenciesConfig(id)

local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,id or self.data.eventId)
return cfg
end

function emergenciesModel:getOnFireBDCfgList(eventId)
local cfg=self:getEmergenciesConfig(eventId)
return cfg.event_conf.buildIdList
end

function emergenciesModel:getEventMonsterConfig(cfg,mId)
local xmcfg=cfg_guildexpconfig_get(zongmenModel:getLevel())
local wlevel=xmcfg.worldlevel
for i,v in ipairs(cfg.event_conf.wordlvMonsterlist)do
if wlevel>=v[1][1]and wlevel<=v[1][2]then
return v[2].monsterlist[mId]
end
end
end

function emergenciesModel:getKillMonsterReward(mId)
local cfg=self:getEmergenciesConfig()
local mcfg=self:getEventMonsterConfig(cfg,mId)

if mcfg then
return mcfg.rewards
end
end

function emergenciesModel:setEmergenciesData(datas)
self.data.eventId=datas[1]
self.data.oldId=datas[2]
self.data.beginTime=datas[3]
self.data.dataLen=datas[4]
self.data.eventData=datas[5]

if self.data.eventId==10 then
emergenciesModel:setMaxCount(datas[4])
end

if self.data.eventId>0 then
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,self.data.eventId)
self.data.endTime=self.data.beginTime+cfg.event_duration
self.data.eventType=cfg.event_type
else
self.data.endTime=self.data.beginTime
end

if datas[6]==1 then
self.data.isNewEvent=true
end

self.data.monLevel=datas[7]

self.data.triggerTime=datas[8]

self.data.isFinish=false

self.data.actTriggerTime=datas[9]
self.data.oldEventDataLen=datas[10]
self.data.oldEventData=datas[11]
self.data.adventureEvent=datas[12]
self.data.oldEventData_typeIndex={}
if self.data.oldEventData then
for i,v in ipairs(self.data.oldEventData)do
local eventId=v.event_id
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local eventType=cfg.event_type
self.data.oldEventData_typeIndex[eventType]=i
end
end
end

function emergenciesModel:getBeginTime()
return self.data.beginTime
end

function emergenciesModel:getTriggerTime()
return self.data.triggerTime
end

function emergenciesModel:setActTriggerTime(time)
if not self.data then return end
self.data.actTriggerTime=time
end

function emergenciesModel:getActTriggerTime()
return self.data.actTriggerTime
end

function emergenciesModel:getMonsterLevel()
return self.data.monLevel
end

function emergenciesModel:setEventHandData()




local eventList=self.data.oldEventData
self.repairData={}
for _,v in pairs(eventList)do
local eventId=v.event_id
local time=v.begin_time
local len=v.len
local arr=v.list
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
if cfg.event_type==emergenciesType.eBuildingOnFire then
local bdList=emergenciesModel:getOnFireBDCfgList(eventId)
if len>0 and bdList then

local startTime=time
for i,v in ipairs(arr)do


local guid=v.param_2
local bdData=zongmenModel:getBuildingData(guid)
if bdData then
local bcd=bdList[bdData.build_id]
if bcd then
if bcd[1]==1 then
local endtime=startTime+bcd[2]
self.repairData[guid]=endtime
elseif bcd[1]==2 then
if bdData.plant_id>0 then
self.productionCutList[guid]=bcd[2]
end
end
end
end

end
end
end
emergenciesModel:setEventHandData_YiMuCongSheng(eventId,time,cfg,arr)
emergenciesModel:setEventHandData_RuiShouLinMen(eventId,time,cfg,arr)
emergenciesModel:setEventHandData_SystemZongMenSpy(eventId,time,cfg,arr)
end
end

function emergenciesModel:getRepairData()
return self.repairData
end

function emergenciesModel:setProductionCutValue(ubdId,value)
self.productionCutList[ubdId]=value
end

function emergenciesModel:getProductionCutValue(ubdId)
return self.productionCutList[ubdId]
end

function emergenciesModel:getRepairTime(bdguid)
local time=self.repairData[bdguid]
return time
end

function emergenciesModel:isInRepairTime(bdguid)
local time=self.repairData[bdguid]
if time then
local currtime=gameUtilityModel.getServerShortTime()
if currtime<time then
return true
end
end
return false
end

function emergenciesModel:hasHandleData()

return self.data.oldEventDataLen and self.data.oldEventDataLen>0 or false
end

function emergenciesModel:isNewEvent()
return self.data.isNewEvent
end

function emergenciesModel:setNewFlag(flag)
self.data.isNewEvent=flag
end

function emergenciesModel:isInEventTime()

if self.data.eventId<=0 or self.data.isFinish then
return false
end
local currtime=timeHelper.getServerShortTime()
return currtime<self.data.endTime
end

function emergenciesModel:getCurrentEventId()
return self.data.eventId
end

function emergenciesModel:setEventFinish()
self.data.isFinish=true
end

function emergenciesModel:getCurrentEventType()
return self.data.eventType
end

function emergenciesModel:getEndTime()
return self.data.endTime
end

function emergenciesModel:getEventData()
return self.data.eventData
end

function emergenciesModel:getOldEvent()
return self.data.oldId
end

function emergenciesModel:getOldEventIdByType(eventType)
if not eventType then return 0 end
if emergenciesModel:hasHandleData()and self.data.oldEventData_typeIndex and self.data.oldEventData_typeIndex[eventType]then
local index=self.data.oldEventData_typeIndex[eventType]
local eventData=self.data.oldEventData[index]
if eventData then
return eventData.event_id
end
end
return 0
end