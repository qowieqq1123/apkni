









local subActivityInfo_xianshilibao={name='xianshilibao'}

function subActivityInfo_xianshilibao:onInit()

end

function subActivityInfo_xianshilibao:onStart()

end

function subActivityInfo_xianshilibao:onDelete()

end

function subActivityInfo_xianshilibao:checkNewDay()
if not self.data then
return
end
local subType=SUB_ACTIVITY_TYPE.eXianShiLiBao
local config=activitiesModel:getSubActivityConfig(subType,self.sub_act_id)
local data=self.data.data
for i,v in ipairs(config.rewards)do
local giftData=data[i]
if giftData then
local isZeroReset=v[5]
local buyTime=giftData.buyTime
if isZeroReset==1 and buyTime~=nil then
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(buyTime))then
data[i]={buyCount=0,buyTime=nil}

end
end
end

end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianShiLiBao)
end

function subActivityInfo_xianshilibao:checkReddot()
if not self.data then
return false
end
local subType=SUB_ACTIVITY_TYPE.eXianShiLiBao
local config=activitiesModel:getSubActivityConfig(subType,self.sub_act_id)
local data=self.data.data
for i,v in ipairs(config.rewards)do
if v[3]==0 then
local giftData=data[i]
local buyCount=giftData and giftData.buyCount or 0
if buyCount<v[4]then
return true
end
end
end
return false
end

return subActivityInfo_xianshilibao