







local _activityData_WuXuan_BW=nil

function xianguanModel:clearData_WuXuan_BW()
_activityData_WuXuan_BW=nil
end


function xianguanModel:getActivityData_WuXuan_BW()
return _activityData_WuXuan_BW
end

function xianguanModel:initActivityData_WuXuan_BW(lastTime,groupList)
groupList=groupList or{}

if _activityData_WuXuan_BW then
lastTime=_activityData_WuXuan_BW.weekBTime
end


self:setActivityTime_WuXuan_BW(lastTime)

self:setWuXuanRegisterData(groupList)

self:setWuXuanMatchData(groupList)
end

function xianguanModel:freshActivityTime_WuXuan_BW()
if _activityData_WuXuan_BW then
xianguanModel:setActivityTime_WuXuan_BW(_activityData_WuXuan_BW.lastTime)
end
end

function xianguanModel:setActivityTime_WuXuan_BW(lastTime)
local firstTime=xianguanModel:getWuXuanFirstWeekTime()
if firstTime==nil then return end
local nowTime=timeHelper.getServerShortTime()
if firstTime>nowTime then
return
end

_activityData_WuXuan_BW={}
_activityData_WuXuan_BW.lastTime=lastTime
_activityData_WuXuan_BW.thisWeek=timeHelper.checkInSameWeek4(lastTime)

if lastTime==0 then
local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local firstTime=xianguanModel:getWuXuanFirstWeekTime()
lastTime=timeHelper.getWeekZeroTime(firstTime)
end
end

local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
_activityData_WuXuan_BW.weekBTime=timeHelper.getWeekZeroTime(lastTime)
_activityData_WuXuan_BW.weekETime=_activityData_WuXuan_BW.weekBTime+86400*7

local registerConfig=config.bw_match_sign_up_conf
_activityData_WuXuan_BW.registerBTime=_activityData_WuXuan_BW.weekBTime+(registerConfig[1]-1)*86400+registerConfig[2]*3600+registerConfig[3]*60
_activityData_WuXuan_BW.registerETime=_activityData_WuXuan_BW.weekBTime+(registerConfig[1]-1)*86400+registerConfig[4]*3600+registerConfig[5]*60

local prepareConfig=config.bw_match_prepare_conf
_activityData_WuXuan_BW.prepareBTime=_activityData_WuXuan_BW.weekBTime+(prepareConfig[1]-1)*86400+prepareConfig[2]*3600+prepareConfig[3]*60
_activityData_WuXuan_BW.prepareETime=_activityData_WuXuan_BW.weekBTime+(prepareConfig[1]-1)*86400+prepareConfig[4]*3600+prepareConfig[5]*60

local matchConfig=config.bw_match_battle_conf
local round=#matchConfig
_activityData_WuXuan_BW.matchTime={}
for i,v in ipairs(matchConfig)do
local matchTime={}
matchTime.beginTime=_activityData_WuXuan_BW.weekBTime+(v[1]-1)*86400+v[2]*3600+v[3]*60
matchTime.endTime=_activityData_WuXuan_BW.weekBTime+(v[1]-1)*86400+v[4]*3600+v[5]*60
_activityData_WuXuan_BW.matchTime[i]=matchTime
end
_activityData_WuXuan_BW.matchBTime=_activityData_WuXuan_BW.matchTime[1].beginTime
_activityData_WuXuan_BW.matchETime=_activityData_WuXuan_BW.matchTime[round].endTime


local resultConfig=config.bw_match_calc_conf
_activityData_WuXuan_BW.resultTime=_activityData_WuXuan_BW.weekBTime+(resultConfig[1]-1)*86400+resultConfig[2]*3600+resultConfig[3]*60

local calc_conf=config.calc_conf
local bw_match_open=config.bw_match_open
local bw_match_end=config.bw_match_end

_activityData_WuXuan_BW.preWaitOepnBTTime=_activityData_WuXuan_BW.weekBTime+(calc_conf[1]-1)*86400+calc_conf[2]*3600+calc_conf[3]*60
_activityData_WuXuan_BW.preWaitOpenETTime=_activityData_WuXuan_BW.weekBTime+(bw_match_open[1]-1)*86400+bw_match_open[2]*3600+bw_match_open[3]*60
_activityData_WuXuan_BW.beginTime=_activityData_WuXuan_BW.weekBTime+(bw_match_open[1]-1)*86400+bw_match_open[2]*3600+bw_match_open[3]*60
_activityData_WuXuan_BW.endTime=_activityData_WuXuan_BW.weekBTime+(bw_match_end[1]-1)*86400+bw_match_end[2]*3600+bw_match_end[3]*60

self:refreshnActivitySegmentData_WuXua_BW()

xianguanController:checkOpenActEnter_WuXuan_BW()


end

function xianguanModel:refreshnActivitySegmentData_WuXua_BW(nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local segmentData=_activityData_WuXuan_BW.segmentData or{}
if nowTime<_activityData_WuXuan_BW.preWaitOepnBTTime then
segmentData.status=XianGuanWuXuanSegment.eNone
segmentData.beginTime=_activityData_WuXuan_BW.weekBTime
segmentData.endTime=_activityData_WuXuan_BW.preWaitOepnBTTime
elseif nowTime<_activityData_WuXuan_BW.registerBTime then
segmentData.status=XianGuanWuXuanSegment.eBwWait
segmentData.beginTime=_activityData_WuXuan_BW.preWaitOepnBTTime
segmentData.endTime=_activityData_WuXuan_BW.preWaitOpenETTime
elseif _activityData_WuXuan_BW.registerBTime<=nowTime and nowTime<_activityData_WuXuan_BW.registerETime then
segmentData.status=XianGuanWuXuanSegment.eRegister
segmentData.beginTime=_activityData_WuXuan_BW.registerBTime
segmentData.endTime=_activityData_WuXuan_BW.registerETime
elseif _activityData_WuXuan_BW.registerETime<=nowTime and nowTime<_activityData_WuXuan_BW.prepareBTime then
segmentData.status=XianGuanWuXuanSegment.eBlank
segmentData.beginTime=_activityData_WuXuan_BW.registerETime
segmentData.endTime=_activityData_WuXuan_BW.prepareBTime
elseif _activityData_WuXuan_BW.prepareBTime<=nowTime and nowTime<_activityData_WuXuan_BW.prepareETime then
segmentData.status=XianGuanWuXuanSegment.eReady
segmentData.beginTime=_activityData_WuXuan_BW.prepareBTime
segmentData.endTime=_activityData_WuXuan_BW.prepareETime
elseif _activityData_WuXuan_BW.prepareETime<=nowTime and nowTime<_activityData_WuXuan_BW.matchBTime then
segmentData.status=XianGuanWuXuanSegment.eBlank
segmentData.beginTime=_activityData_WuXuan_BW.prepareETime
segmentData.endTime=_activityData_WuXuan_BW.matchBTime
elseif _activityData_WuXuan_BW.matchBTime<=nowTime and nowTime<_activityData_WuXuan_BW.matchETime then
segmentData.status=XianGuanWuXuanSegment.eMatch
segmentData.beginTime=_activityData_WuXuan_BW.matchBTime
segmentData.endTime=_activityData_WuXuan_BW.matchETime
else
segmentData.status=XianGuanWuXuanSegment.eFinish
segmentData.beginTime=_activityData_WuXuan_BW.matchETime
segmentData.endTime=_activityData_WuXuan_BW.endTime
end
_activityData_WuXuan_BW.segmentData=segmentData
end

function xianguanModel:getActivitySegmentData_WuXuan_BW()
if _activityData_WuXuan_BW then
return _activityData_WuXuan_BW.segmentData
end
end

function xianguanModel:getActivitySegment_WuXuan_BW()
local segmentData=self:getActivitySegmentData_WuXuan_BW()
if segmentData then
return segmentData.status,segmentData.beginTime,segmentData.endTime
end
return XianGuanWuXuanSegment.eNone
end

function xianguanModel:getBWMatchJobLookUp_WuXuan()
local typeXgCfgList=xianguanConfig.getCampaignJobListConfig(XianGuanCampaignType.eWuXuan)

local lookup={}

local jobInfo
for index,xgCfg in ipairs(typeXgCfgList)do
jobInfo=xianguanModel:getJobInfoByJobId(xgCfg.id)
if jobInfo==nil then
lookup[xgCfg.id]=1
elseif jobInfo.actorid==nil then
lookup[xgCfg.id]=1
elseif mathHelper.compareInt64(jobInfo.actorid,Int64_0)then
lookup[xgCfg.id]=1
end
end

return lookup
end

function xianguanModel:getWuXuanReddot_BW()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then return false end
local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
return self:getWuXuanSegmentFreeReward_BW(segment)
end

function xianguanModel:getWuXuanSegmentFreeReward_BW(segment)
local _playerData=xianguanModel:getWuXuanPlayerData()
if _playerData and _activityData_WuXuan_BW then
local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
local flag=mathHelper.getBitValue(_playerData.free_flag,segment)
if config.free_gift[segment]~=nil and not flag then
return true
end
end
return false
end



function xianguanModel:getReddot_WuXuan_BW()
return xianguanController:isInMatchStage_WuXuan_BW()and xianguanModel:getWuXuanReddot_BW()
end
