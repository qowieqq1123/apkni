





function xianguanController:onNormalUpdate_WuXuan_BW(lastTime)
if not xianguanModel:checkWuXuanPlatformOpen()then return end

local activityData=xianguanModel:getActivityData_WuXuan_BW()

if activityData then
local nowTime=timeHelper.getServerShortTime()
if self:isInMatchStage_enter_WuXuan_BW()then
local segmentData=activityData.segmentData

if nowTime<activityData.endTime then
if nowTime>=segmentData.endTime then
xianguanModel:refreshnActivitySegmentData_WuXua_BW(nowTime)
xianguanController:checkOpenActEnter_WuXuan_BW()
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWuXuan)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
end
else
local firstTime=xianguanModel:getWuXuanFirstWeekTime()
if nowTime>=firstTime then
local intervalWeek=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"rest_week")
local intervalSec=(intervalWeek+1)*86400*7
xianguanModel:initActivityData_WuXuan_BW(activityData.weekBTime+intervalSec)

notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWuXuan)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
end
end
if lastTime<activityData.resultTime and nowTime>=activityData.resultTime then
xianguanModel:addMsgJingXuanResultType(XianGuanCampaignType.eWuXuan)
msgWinControl:addMsgWin(msgWinType.eXianGuanJingXuanResult,nil,{delay=self.delayJingXuanResultTime,matchType=2},true)
end
end
end
end



function xianguanController:isInMatchStage_WuXuan_BW()
if not self:isOpen_WuXuan_BW()then return false end


local activityData=xianguanModel:getActivityData_WuXuan_BW()

if activityData==nil then
return false
end

local curServerTime=timeHelper.getServerShortTime()

return curServerTime>=activityData.beginTime and activityData.endTime>=curServerTime
end

function xianguanController:isInMatchStage_enter_WuXuan_BW()

local nowTime=timeHelper.getServerShortTime()
local firstTime=xianguanModel:getWuXuanFirstWeekTime()
if firstTime==nil then return false end
if firstTime>nowTime then
return false
end
if not self:isOpen_WuXuan_BW()then return false end


local activityData=xianguanModel:getActivityData_WuXuan_BW()

if activityData==nil then
return false
end

local curServerTime=timeHelper.getServerShortTime()

return curServerTime>=activityData.preWaitOepnBTTime and activityData.resultTime>=curServerTime
end


function xianguanController:checkOpenActEnter_WuXuan_BW()

if not self:isOpen_WuXuan_BW()then return end


if self:isInMatchStage_enter_WuXuan_BW()then
local activityData=xianguanModel:getActivityData_WuXuan_BW()

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianGuanWuXuan_BW,activityData.preWaitOepnBTTime,activityData.matchETime)
end
end


function xianguanController:isOpen_WuXuan_BW()
if not xianguanModel:getFinishDealServerData()then
return false
end

if self.data.isOpenWuXuanBwFlag~=nil then
return self.data.isOpenWuXuanBwFlag
end

local typeXgCfgList=xianguanConfig.getCampaignJobListConfig(XianGuanCampaignType.eWuXuan)

local isOpen=false

local jobInfo
for index,xgCfg in ipairs(typeXgCfgList)do
jobInfo=xianguanModel:getJobInfoByJobId(xgCfg.id)
if jobInfo==nil then
isOpen=true
break
end

if jobInfo.actorid==nil then
isOpen=true
break
end

if mathHelper.compareInt64(jobInfo.actorid,Int64_0)then
isOpen=true
break
end
end

self.isOpenWuXuanBwFlag=isOpen

return isOpen
end
