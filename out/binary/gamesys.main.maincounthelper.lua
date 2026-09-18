mainCountHelper={}

function mainCountHelper:checkXMCountWin()

local check=systemModel.isOpen(SYSTEM_DEFINE.eXianMeng)
if check then
local num=xianmengModel:getInvitationCount()
if num>0 then
return true
end
end


check=systemModel.isOpen(SYSTEM_DEFINE.eYouJian)
if check then
local reddot=mailModel:checkReddot()
if reddot then
return true
end
end


local xmdg_num=xianmengdigongModel:getAllHasRewardEvent_num()
if xmdg_num>0 then
return true
end

local state=YuLingZhaiModel:getHealType()
if state==1 then
return true
end


local showGateApplyBtn=xianjieModel:checkIsShowGateApplyBtn()
if showGateApplyBtn then
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local num=xianjieModel:checkMoJieGateNotReadAskCountByGateId(selfXmOwnGateId)
return num>0
end

return false
end