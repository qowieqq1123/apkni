









local subActivityInfo_exchangeshop={name='exchangeshop'}

function subActivityInfo_exchangeshop:onInit()
end

function subActivityInfo_exchangeshop:onStart()
end

function subActivityInfo_exchangeshop:onUpdate()
end

function subActivityInfo_exchangeshop:checkReddot()
return self:hasPrize()
end

function subActivityInfo_exchangeshop:onDelete()
end

function subActivityInfo_exchangeshop:hasPrize()
if activitiesHandle_exchangeshop:isHaveReddot(self.act_id,self.sub_act_id)then
return true
end

local reddot
local itemId
local good
local enoughMoney
local haveExchange
local isUnlock

local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2
self.activityData=activitiesModel:getSubActInfo(self.act_id,subType,self.sub_act_id)

local sub_actcfg=self:getSubActConfig()
if sub_actcfg then
good=sub_actcfg.good
reddot=sub_actcfg.reddot
itemId=sub_actcfg.money
enoughMoney=moneyModel.checkEnoughMoney(itemId,reddot)
end

local data=self.data.list or{}
if data then
local list={}
for k,v in ipairs(data)do
local idx=tostring(v.param_1)
list[idx]=v
end
data=list
end

for k,v in ipairs(good)do
if v then
local cfg=v
local num=0
local temp=data[tostring(k)]
if temp then
num=temp.param_2
end

haveExchange=self:checkExchangeTimes(num,cfg[4])
isUnlock=self:checkLock(self.activityData.start_time,cfg[5],cfg[6][2])

if enoughMoney and haveExchange and isUnlock then return true end
end
end

return false
end

function subActivityInfo_exchangeshop:checkLock(beginTime,needZMLv,limit)
local passDay=timeHelper.getPassDay(beginTime+1609430400)
local enoughDay=passDay>=limit
local enoughLv=zongmenModel:getLevel()>=needZMLv
local isUnlock=enoughLv and enoughDay or false

return isUnlock
end

function subActivityInfo_exchangeshop:checkExchangeTimes(yetBuy,allBuy)
if yetBuy<allBuy then return true end
return false
end

function subActivityInfo_exchangeshop:checkNewDay()
activitiesHandle_exchangeshop.onNewDay(self.act_id,self.sub_act_id)
end

return subActivityInfo_exchangeshop