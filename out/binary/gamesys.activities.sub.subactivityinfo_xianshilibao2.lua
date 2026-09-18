









local subActivityInfo_xianshilibao2={name='xianshilibao2'}

function subActivityInfo_xianshilibao2:onInit()

end

function subActivityInfo_xianshilibao2:onStart()

end

function subActivityInfo_xianshilibao2:onDelete()

end

function subActivityInfo_xianshilibao2:checkNewDay()
if not self.data then
return
end
local subType=SUB_ACTIVITY_TYPE.eBuyAct6
local config=activitiesModel:getSubActivityConfig(subType,self.sub_act_id)
for i,v in ipairs(config.rewards)do
local giftData=self.data[i]
if giftData then
local isZeroReset=v[5]
local buyTime=giftData.buyTime
if isZeroReset==1 and buyTime~=nil then
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(buyTime))then
self.data[i]={buyCount=0,buyTime=nil}

end
end
end

end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eBuyAct6)
end

function subActivityInfo_xianshilibao2:checkReddot()

if not self.data then
return false
end

local subType=SUB_ACTIVITY_TYPE.eBuyAct6
local config=activitiesModel:getSubActivityConfig(subType,self.sub_act_id)

for i,v in ipairs(config.rewards)do
if v[3]==0 then
local giftData=self.data[i]
local buyCount=giftData and giftData.buyCount or 0
if buyCount<v[4]then
return true
end
end
end
return false
end

return subActivityInfo_xianshilibao2