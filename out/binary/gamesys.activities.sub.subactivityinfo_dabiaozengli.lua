









local subActivityInfo_dabiaozengli={name='dabiaozengli'}

function subActivityInfo_dabiaozengli:onInit()




end

function subActivityInfo_dabiaozengli:onStart()

end

function subActivityInfo_dabiaozengli:onUpdate()

end

function subActivityInfo_dabiaozengli:onDelete()





end

function subActivityInfo_dabiaozengli:checkNewDay()
if not self.data then

end
local subType=SUB_ACTIVITY_TYPE.eDaBiaoZengLi
local config=activitiesModel:getSubActivityConfig(subType,self.sub_act_id)
for i,v in ipairs(config.rewards)do
local giftData=self.data[i]
if giftData then
local isZeroReset=v[6]
local buyTime=giftData.buyTime
if isZeroReset==1 and buyTime~=nil then
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(buyTime))then
giftData={buyCount=0,buyTime=nil}

end
end
end

end

end


function subActivityInfo_dabiaozengli:checkReddot()
if not self.data then

end

if not self:reqDaBiaoZengLi_checkDailyRewardsIsGot()then

return true
end
local subType=SUB_ACTIVITY_TYPE.eDaBiaoZengLi
local config=activitiesModel:getSubActivityConfig(subType,self.sub_act_id)
local mydata=activitiesModel:getSubActInfoData(self.act_id,subType,self.sub_act_id)
if mydata then
local times=mydata.times
for i,v in ipairs(config.rewards)do
local giftData=self.data[i]
local iscanlock=times>=v[1]
local freebuyCount=giftData and giftData.freebuyCount or 0
if freebuyCount<1 and iscanlock then
return true
end
end
end
return false
end


function subActivityInfo_dabiaozengli:reqDaBiaoZengLi_checkDailyRewardsIsGot()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
return not FreeGiftController.GetFreeGift(giftid,data)
end


function subActivityInfo_dabiaozengli:reqDaBiaoZengLi_getDailyRewards()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local subType=self.sub_act_type
return FreeGiftController.SendFreeGift(giftid,data,function(result)
if result then

local win=UIManager:findActiveWindow('UISubAct_dabiaozengli_Win')
if win then
win:refreshDailyReward()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end)
end

return subActivityInfo_dabiaozengli