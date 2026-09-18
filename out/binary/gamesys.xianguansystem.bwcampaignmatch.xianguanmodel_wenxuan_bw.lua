







local _activityData_WenXuan_BW=nil


function xianguanModel:clearData_WenXuan_BW()
_activityData_WenXuan_BW=nil
end


function xianguanModel:getActivityData_WenXuan_BW()
return _activityData_WenXuan_BW
end



function xianguanModel:checkInitData_WenXuan()
return _activityData_WenXuan_BW~=nil
end

function xianguanModel:freshActivityTime_WenXuan_BW()
if _activityData_WenXuan_BW then
xianguanModel:setActivityTime_WenXuan_BW(_activityData_WenXuan_BW.lastTime or 0)
end
end


function xianguanModel:setActivityTime_WenXuan_BW(lastTime)
local firstTime=xianguanModel:getWenXuanFirstWeekTime()
if firstTime==nil then return end
local nowTime=timeHelper.getServerShortTime()
if firstTime>nowTime then
return
end

_activityData_WenXuan_BW={}

_activityData_WenXuan_BW.lastTime=lastTime

local conf=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
local open_week=conf.open_week
local stage_conf=conf.stage_conf
local rest_week=conf.rest_week+1
local bw_match_open=conf.bw_match_open


if lastTime==0 then
local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local firstTime=xianguanModel:getWenXuanFirstWeekTime()
lastTime=timeHelper.getWeekZeroTime(firstTime)
end
end

_activityData_WenXuan_BW.thisWeek=timeHelper.checkInSameWeek4(lastTime)
_activityData_WenXuan_BW.openTime=lastTime

local weekBTime=timeHelper.getWeekZeroTime(lastTime)

_activityData_WenXuan_BW.weekBTime=weekBTime


local beginTime=weekBTime+(open_week-1)*86400+bw_match_open*86400
local voteBTime=beginTime+stage_conf[1]
local endTime=voteBTime+stage_conf[2]

_activityData_WenXuan_BW.beginTime=weekBTime+(open_week-1)*86400+2*86400
_activityData_WenXuan_BW.endTime=endTime

_activityData_WenXuan_BW.weekBTime=weekBTime
_activityData_WenXuan_BW.weekETime=weekBTime+86400*7

_activityData_WenXuan_BW.registerBTime=beginTime
_activityData_WenXuan_BW.registerETime=voteBTime

_activityData_WenXuan_BW.voteBTime=voteBTime
_activityData_WenXuan_BW.voteETime=endTime

_activityData_WenXuan_BW.resultTime=endTime

_activityData_WenXuan_BW.preWaitOepnBTTime=weekBTime+(open_week-1)*86400+stage_conf[1]+stage_conf[2]
_activityData_WenXuan_BW.preWaitOpenETTime=weekBTime+86400*7

self:refreshActivitySegmentData_WenXuan_BW()

xianguanController:checkOpenActEnter_WenXuan_BW()
end


function xianguanModel:refreshActivitySegmentData_WenXuan_BW(nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local segmentData=_activityData_WenXuan_BW.segmentData or{}
if nowTime<_activityData_WenXuan_BW.preWaitOepnBTTime then
segmentData.status=XianGuanWenXuanSegment.eNone
segmentData.beginTime=_activityData_WenXuan_BW.weekBTime
segmentData.endTime=_activityData_WenXuan_BW.preWaitOepnBTTime
elseif nowTime<_activityData_WenXuan_BW.registerBTime then
segmentData.status=XianGuanWenXuanSegment.eBwWait
segmentData.beginTime=_activityData_WenXuan_BW.preWaitOepnBTTime
segmentData.endTime=_activityData_WenXuan_BW.preWaitOpenETTime
elseif _activityData_WenXuan_BW.registerBTime<=nowTime and nowTime<_activityData_WenXuan_BW.registerETime then
segmentData.status=XianGuanWenXuanSegment.eRegister
segmentData.beginTime=_activityData_WenXuan_BW.registerBTime
segmentData.endTime=_activityData_WenXuan_BW.registerETime
elseif _activityData_WenXuan_BW.voteBTime<=nowTime and nowTime<_activityData_WenXuan_BW.voteETime then
segmentData.status=XianGuanWenXuanSegment.eVote
segmentData.beginTime=_activityData_WenXuan_BW.voteBTime
segmentData.endTime=_activityData_WenXuan_BW.voteETime
else
segmentData.status=XianGuanWenXuanSegment.eFinish
segmentData.beginTime=_activityData_WenXuan_BW.voteETime
segmentData.endTime=_activityData_WenXuan_BW.endTime
end
_activityData_WenXuan_BW.segmentData=segmentData
end


function xianguanModel:refreshData_WenXuan_BW()
if not _activityData_WenXuan_BW then
return
end

local registerBTime=_activityData_WenXuan_BW.registerBTime or 0
local open_sec=registerBTime

local dataWenXuan=xianguanModel:getWenXuanData()

if xianguanController:isInMatchStage_enter_WenXuan_BW()then
dataWenXuan={}
dataWenXuan.free_bits=0
dataWenXuan.last_cooldown=0
dataWenXuan.attend_officer_id=0
dataWenXuan.use_vote_agree_num=0
dataWenXuan.use_vote_against_num=0
dataWenXuan.open_sec=open_sec
xianguanModel:markWenXuanShareTime(0)
end

if dataWenXuan then
xianguanModel:setActivityTime_WenXuan_BW(_activityData_WenXuan_BW.weekBTime or 0)
end

UIManager:invokeUIMethod("UIXianGuanMainWin","refreshButton")
UIManager:invokeUIMethod("UIXianGuanCampaignMainWin","refreshAll",1)
end

function xianguanModel:getActivitySegmentData_WenXuan_BW()
if _activityData_WenXuan_BW then
return _activityData_WenXuan_BW.segmentData
end
end

function xianguanModel:getActivitySegment_WenXuan_BW()
local segmentData=self:getActivitySegmentData_WenXuan_BW()
if segmentData then
return segmentData.status,segmentData.beginTime,segmentData.endTime
end
return XianGuanWenXuanSegment.eNone
end

function xianguanModel:getBWMatchJobLookUp_WenXuan()
local typeXgCfgList=xianguanConfig.getCampaignJobListConfig(XianGuanCampaignType.eWenXuan)

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

function xianguanModel:getWenXuanReddot_BW()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then return false end
return self:getWenXuanFreeReward_BW()
end

function xianguanModel:getWenXuanFreeReward_BW()
local _wenxuanData=xianguanModel:getWenXuanData()
if _wenxuanData and _activityData_WenXuan_BW then
local free_gift=cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"free_gift")
local segmentData=_activityData_WenXuan_BW.segmentData
for i,v in ipairs(free_gift)do
local flag=mathHelper.getBitValue(_wenxuanData.free_bits,i)
if not flag and segmentData.status==i then
return true
end
end
end
return false
end

function xianguanModel:getReddot_WenXuan_BW()
return xianguanController:isInMatchStage_WenXuan_BW()and xianguanModel:getWenXuanReddot_BW()
end