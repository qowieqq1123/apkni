local _rewards={}
local _lookups={}

function xiaoZhuShouModel:clearAllWaitReward()
table.clear(_rewards)
table.clear(_lookups)
end

function xiaoZhuShouModel:resetWaitReward(commonPrizeSubType)
if _rewards[commonPrizeSubType]==nil then
_rewards[commonPrizeSubType]={}
_lookups[commonPrizeSubType]={}
end
end

function xiaoZhuShouModel:clearWaitReward(commonPrizeSubType)
_rewards[commonPrizeSubType]=nil
_lookups[commonPrizeSubType]=nil
end

function xiaoZhuShouModel:pushWaitReward(commonPrizeSubType,rewards)
local commonlist=_rewards[commonPrizeSubType]
local commonlookup=_lookups[commonPrizeSubType]
if commonlist and commonlookup then
for i,v in ipairs(rewards)do
showPrizeControl.insertCommon(commonlist,commonlookup,v.itemguid,v.itemid,v.num,true)
end
end
end

function xiaoZhuShouModel:getWaitReward(commonPrizeSubType)
return _rewards[commonPrizeSubType]
end

function xiaoZhuShouModel:popWaitReward(commonPrizeSubType)
local pop=_rewards[commonPrizeSubType]
xiaoZhuShouModel:clearWaitReward(commonPrizeSubType)
return pop
end