xianguanController.delayJingXuanResultTime=10

function xianguanController:checkJingXuanResultMsg(nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local check={}
for name,campaignType in pairs(XianGuanCampaignType)do
local firstTime=self:getJingXuanFirstResultTime(campaignType)
if firstTime and nowTime>firstTime and self:checkJingXuanPlatformOpen(campaignType)then
local lastTime=xianguanModel:getJingXuanResultTime(campaignType)
if lastTime then

if xianguanController:isJingXuanWeek(campaignType)then
local startTime,endTime=xianguanController:getJingXuanResultTime(campaignType)
if lastTime<endTime and nowTime>=endTime then
xianguanModel:addMsgJingXuanResultType(campaignType)
elseif nowTime<startTime then
local config=self:getJingXuanConfig(campaignType)
local delta=nowTime-lastTime
local interval=(config.rest_week+1)*86400*7
if delta>=interval then
xianguanModel:addMsgJingXuanResultType(campaignType)
end
end
elseif xianguanController:IsInBWMatchStage_Campaign_Compatible(campaignType)then
local startTime,endTime=xianguanController:getJingXuanResultTime_Campaign_Compatible(campaignType)

if lastTime<endTime and nowTime>=endTime then
xianguanModel:addMsgJingXuanResultType(campaignType)
end
else
local config=self:getJingXuanConfig(campaignType)
local delta=nowTime-lastTime
local interval=(config.rest_week+1)*86400*7
if delta>=interval then
xianguanModel:addMsgJingXuanResultType(campaignType)
end
end
else

xianguanModel:addMsgJingXuanResultType(campaignType)
end
end
end
if xianguanModel:checkExistMsgJingXuanResultType()then
msgWinControl:addMsgWin(msgWinType.eXianGuanJingXuanResult,nil,{delay=self.delayJingXuanResultTime},true)
end
end

function xianguanController:recordJingXuanResultRefreshTime(campaignType)
local nowTime=timeHelper.getServerShortTime()
local weekZero=timeHelper.getWeekZeroTime(nowTime)
if xianguanController:isJingXuanWeek(campaignType)then
local startTime,endTime=xianguanController:getJingXuanResultTime(campaignType)
if nowTime<endTime then
xianguanModel:recordJingXuanResultTime(campaignType,weekZero,true)
else
xianguanModel:recordJingXuanResultTime(campaignType,weekZero+86400*7,true)
end
elseif xianguanController:IsInBWMatchStage_Campaign_Compatible(campaignType)then
local startTime,endTime=xianguanController:getJingXuanResultTime_Campaign_Compatible(campaignType)
if nowTime<endTime then
xianguanModel:recordJingXuanResultTime(campaignType,weekZero,true)
else
xianguanModel:recordJingXuanResultTime(campaignType,weekZero+86400*7,true)
end
else
xianguanModel:recordJingXuanResultTime(campaignType,weekZero,true)
end
end


function xianguanController:getJingXuanSegment(campaignType)
if campaignType==XianGuanCampaignType.eWuXuan then
return xianguanModel:getWuXuanActivitySegment()
elseif campaignType==XianGuanCampaignType.eWenXuan then
return xianguanModel:getWenXuanActivitySegment()
end
end


function xianguanController:getJingXuanPlayerJob(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
local job1=xianguanModel:getWenXuanPlayerJob()
if job1 and job1>0 then
return job1
end
elseif campaignType==XianGuanCampaignType.eWuXuan then
local job2=xianguanModel:getWuXuanPlayerJob()
if job2 and job2>0 then
return job2
end
end

return nil
end


function xianguanController:getJingXuanConfig(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
elseif campaignType==XianGuanCampaignType.eWuXuan then
return cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
end
return nil
end


function xianguanController:getJingXuanFreeReward(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return xianguanModel:getWenXuanFreeBits()
elseif campaignType==XianGuanCampaignType.eWuXuan then
return xianguanModel:getWuXuanPlayerFreeFlag()
end
return 0
end


function xianguanController:isJingXuanWeek(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return xianguanModel:checkWenXuanWeek()
elseif campaignType==XianGuanCampaignType.eWuXuan then
return xianguanModel:checkWuXuanWeek()
end
end


function xianguanController:getJingXuanActivityTime(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
local activityData=xianguanModel:getWenXuanActivityData()
if not activityData then
return 0,0
end
return activityData.registerBTime,activityData.voteETime
elseif campaignType==XianGuanCampaignType.eWuXuan then
local activityData=xianguanModel:getWuXuanActivityData()
if not activityData then
return 0,0
end
return activityData.registerBTime,activityData.matchETime
end
end


function xianguanController:getJingXuanResultTime(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
local activityData=xianguanModel:getWenXuanActivityData()
if not activityData then
return 0,0
end
return activityData.registerBTime,activityData.resultTime
elseif campaignType==XianGuanCampaignType.eWuXuan then
local activityData=xianguanModel:getWuXuanActivityData()
if not activityData then
return 0,0
end
return activityData.registerBTime,activityData.resultTime
end
end

function xianguanController:checkJingXuanPlatformOpen(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return xianguanModel:checkWenXuanPlatformOpen()
elseif campaignType==XianGuanCampaignType.eWuXuan then
return xianguanModel:checkWuXuanPlatformOpen()
end
end

function xianguanController:getJingXuanFirstResultTime(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
local firstTime=xianguanModel:getWenXuanFirstWeekTime()
if firstTime then
local open_week=cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"open_week")
local stage_conf=cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"stage_conf")
return firstTime+(open_week-1)*86400+stage_conf[1]+stage_conf[2]
end
elseif campaignType==XianGuanCampaignType.eWuXuan then
local firstTime=xianguanModel:getWuXuanFirstWeekTime()
if firstTime then
local calc_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"calc_conf")
return firstTime+(calc_conf[1]-1)*86400+calc_conf[2]*3600+calc_conf[3]*60
end
end
end
