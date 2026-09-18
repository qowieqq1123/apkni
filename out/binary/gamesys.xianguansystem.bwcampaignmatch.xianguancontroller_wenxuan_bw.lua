





function xianguanController:onNormalUpdate_WenXuan_BW(lastTime)
if not xianguanModel:checkWenXuanPlatformOpen()then return end

local activityData=xianguanModel:getActivityData_WenXuan_BW()
local isOpen=xianguanController:isOpen_WenXuan_BW()
if activityData and isOpen then

local segmentData=activityData.segmentData
local nowTime=timeHelper.getServerShortTime()

if nowTime>=segmentData.endTime then
local old=segmentData.status
xianguanModel:refreshData_WenXuan_BW(nowTime)
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWenXuan,old)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWenXuan)
end

if lastTime<activityData.resultTime and nowTime>=activityData.resultTime then
xianguanModel:addMsgJingXuanResultType(XianGuanCampaignType.eWenXuan)
msgWinControl:addMsgWin(msgWinType.eXianGuanJingXuanResult,nil,{delay=self.delayJingXuanResultTime,matchType=2},true)
end
end
end


function xianguanController:isInMatchStage_WenXuan_BW()

if not self:isOpen_WenXuan_BW()then
return false
end

local activityData=xianguanModel:getActivityData_WenXuan_BW()

if activityData==nil then
return false
end

local curServerTime=timeHelper.getServerShortTime()

return curServerTime>=activityData.beginTime and activityData.endTime>=curServerTime
end

function xianguanController:isInMatchStage_enter_WenXuan_BW()

local nowTime=timeHelper.getServerShortTime()
local firstTime=xianguanModel:getWenXuanFirstWeekTime()
if firstTime==nil then return false end
if firstTime>nowTime then
return false
end

if not self:isOpen_WenXuan_BW()then
return false
end

local activityData=xianguanModel:getActivityData_WenXuan_BW()

if activityData==nil then
return false
end

local curServerTime=timeHelper.getServerShortTime()

return curServerTime>=activityData.preWaitOepnBTTime and activityData.resultTime>=curServerTime
end


function xianguanController:checkOpenActEnter_WenXuan_BW()
if not self:isOpen_WenXuan_BW()then
return
end


if self:isInMatchStage_enter_WenXuan_BW()then
local activityData=xianguanModel:getActivityData_WenXuan_BW()

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianGuanWenXuan_BW,activityData.preWaitOepnBTTime,activityData.resultTime)
end
end


function xianguanController:isOpen_WenXuan_BW()
if not xianguanModel:getFinishDealServerData()then
return false
end

if self.data.isOpenWenXuanBwFlag~=nil then
return self.data.isOpenWuXuanBwFlag
end

local typeXgCfgList=xianguanConfig.getCampaignJobListConfig(XianGuanCampaignType.eWenXuan)

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

function xianguanController:isInSettleTime()
local activityData=xianguanModel:getActivityData_WenXuan_BW()

local curTime=timeHelper.getServerShortTime()

local endTime=activityData.lastTime+14*86400

return curTime>=activityData.resultTime and endTime>=activityData.resultTime
end