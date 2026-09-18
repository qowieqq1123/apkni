limitActivityPreviewControl=gameState.addListener(table.weakCopy(sceneBaseControl))

local _dirty1={}
local _dirty2={}

function limitActivityPreviewControl:onAppStart()
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:initCfgs()
end

function limitActivityPreviewControl:onEnterState(isReconnet)
if isReconnet then return end
_dirty1={}
_dirty2={}
self.activityDatas={}
timeEventController.addNormalTimerHandler(1,'limitActivityPreviewControl',limitActivityPreviewControl)
end

function limitActivityPreviewControl:onLeaveState(isReconnet)
if isReconnet then return end
_dirty1={}
_dirty2={}
self.activityDatas={}
timeEventController.removeNormalTimerHandler(1,'limitActivityPreviewControl')
end

function limitActivityPreviewControl:onProtocolReq(...)

end

function limitActivityPreviewControl:onChangeScene_(sceneType)

end

function limitActivityPreviewControl:onChangeSceneMap_(sceneType,mapId)
self:freshData()
end

function limitActivityPreviewControl:onNormalUpdate()
self:freshData()
end

function limitActivityPreviewControl.onLimitActOpen(actID,flag)
limitActivityPreviewControl:freshData()
end

function limitActivityPreviewControl.onLimitActStateChange(actID,state)
limitActivityPreviewControl:freshData()
end

function limitActivityPreviewControl:initCfgs()
self.maxtime=cfgHelper.get2(cfg_clientxianshihuodongcommonconfig_get,1,'previewtime')

self.mapCfg={}
local mapCfg=self.mapCfg
local cfgs=cfg_xianshihuodongconfig()
for _,v in pairs(cfgs)do
if not limitActivitiesModel.checkActForbidden(v)then
local showScene=v.showScene
for _,vv in ipairs(showScene or{})do
if mapCfg[vv]==nil then mapCfg[vv]={}end
local mapCfgTable=mapCfg[vv]
mapCfgTable[#mapCfgTable+1]=v.id
end
end
end

local cfgs=cfg_clientxianshihuodongconfig()
for _,v in pairs(cfgs)do
if not limitActivitiesModel.checkActForbidden(v)then
local showScene=v.showScene
for _,vv in ipairs(showScene or{})do
if mapCfg[vv]==nil then mapCfg[vv]={}end
local mapCfgTable=mapCfg[vv]
mapCfgTable[#mapCfgTable+1]=v.id
end
end
end
end

function limitActivityPreviewControl:freshData()
local sceneType=self.sceneType
local mapId=self.mapId
table.clear(_dirty1)
for k,v in pairs(self.activityDatas)do
_dirty1[k]=v
end
table.clear(_dirty2)
if self.mapCfg[mapId]then
for _,v in ipairs(self.mapCfg[mapId])do
if self:check(v)then
_dirty2[#_dirty2+1]=v
end
end

if#_dirty2>1 then
table.sort(_dirty2,function(a,b)
local startLertTime1=limitActivitiesModel:getActStartLeftTime(a)
local startLertTime2=limitActivitiesModel:getActStartLeftTime(b)
if startLertTime1==startLertTime2 then return a<a end
return startLertTime1<startLertTime2
end)
end
end
if table.isDiffValue(_dirty1,_dirty2)then
table.clear(self.activityDatas)
for k,v in pairs(_dirty2)do
self.activityDatas[k]=v
end
notifySystem:postNotify(notifyConfig.onLimitActivityPreview,sceneType,mapId)
end
end

function limitActivityPreviewControl:check(activityId)
if limitActivitiesModel:checkActIdle(activityId)then
local left=limitActivitiesModel:getActStartLeftTime(activityId)
return left<=self.maxtime
elseif not limitActivitiesModel:checkActOpen(activityId)then
local ret,day=limitActivitiesModel:checkDayCondition(activityId)
if not ret then
return true
end
end
return false
end

function limitActivityPreviewControl:getDataList()
return self.activityDatas
end

function limitActivityPreviewControl:getActivityCfg(activityId)
if activityId>=10000 then
return cfg_clientxianshihuodongconfig_get(activityId)
end
return cfg_xianshihuodongconfig_get(activityId)
end