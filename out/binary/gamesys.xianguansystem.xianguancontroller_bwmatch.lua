








function xianguanController:IsInBWMatchStage_Campaign_Compatible(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return xianguanController:isInMatchStage_WenXuan_BW()
elseif campaignType==XianGuanCampaignType.eWuXuan then
return xianguanController:isInMatchStage_WuXuan_BW()
end
end

function xianguanController:getJingXuanResultTime_Campaign_Compatible(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
local activityData=xianguanModel:getActivityData_WenXuan_BW()
if not activityData then
return 0,0
end
return activityData.registerBTime,activityData.resultTime
elseif campaignType==XianGuanCampaignType.eWuXuan then
local activityData=xianguanModel:getActivityData_WuXuan_BW()
if not activityData then
return 0,0
end
return activityData.registerBTime,activityData.resultTime
end
end


function xianguanController:getActivitySegment_Enter_Campaign_Compatible(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
elseif campaignType==XianGuanCampaignType.eWuXuan then
return xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
end
end

function xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if xianguanController:isInMatchStage_enter_WenXuan_BW()then
return xianguanModel:getActivitySegment_WenXuan_BW()
else
return xianguanModel:getWenXuanActivitySegment()
end
end

function xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if xianguanController:isInMatchStage_enter_WuXuan_BW()then
return xianguanModel:getActivitySegment_WuXuan_BW()
else
return xianguanModel:getWuXuanActivitySegment()
end
end

function xianguanController:getActivitySegment_Campaign_Compatible(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
return xianguanController:getActivitySegment_WenXuan_Compatible()
elseif campaignType==XianGuanCampaignType.eWuXuan then
return xianguanController:getActivitySegment_WuXuan_Compatible()
end
end

function xianguanController:getActivitySegment_WenXuan_Compatible()
if xianguanController:isInMatchStage_WenXuan_BW()then
return xianguanModel:getActivitySegment_WenXuan_BW()
else
return xianguanModel:getWenXuanActivitySegment()
end
end

function xianguanController:getActivitySegment_WuXuan_Compatible()
if xianguanController:isInMatchStage_WuXuan_BW()then
return xianguanModel:getActivitySegment_WuXuan_BW()
else
return xianguanModel:getWuXuanActivitySegment()
end
end

function xianguanController:getActivitySegmentData_WenXuan_Compatible()
if xianguanController:isInMatchStage_enter_WenXuan_BW()then
return xianguanModel:getActivitySegmentData_WenXuan_BW()
else
return xianguanModel:getWenXuanActivitySegmentData()
end
end

function xianguanController:getActivitySegmentData_WuXuan_Compatible()
if xianguanController:isInMatchStage_enter_WuXuan_BW()then
return xianguanModel:getActivitySegmentData_WuXuan_BW()
else
return xianguanModel:getWuXuanActivitySegmentData()
end
end

function xianguanController:getWenXuanReddot_Compatible()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then return false end
if xianguanController:isInMatchStage_WenXuan_BW()then
return xianguanModel:getReddot_WenXuan_BW()
else
return xianguanModel:getWenXuanReddot()
end
end

function xianguanController:getWuXuanReddot_Compatible()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then return false end
if xianguanController:isInMatchStage_WuXuan_BW()then
return xianguanModel:getReddot_WuXuan_BW()
else
return xianguanModel:getWuXuanReddot()
end
end





















































































