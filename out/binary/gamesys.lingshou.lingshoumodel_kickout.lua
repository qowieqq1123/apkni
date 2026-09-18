
function lingshouModel:getKickoutRewards(lsGuidList)
local itemLookup={}

for index,lsGuid in ipairs(lsGuidList)do
local lsData=lingshouModel:getLingShouData2(lsGuid)

local item=lsData.cfg.wxjpItems
if item==nil then
return itemLookup
else
itemLookup[item[1]]=(itemLookup[item[1]]or 0)+item[2]
end

local ShoulangId=UIShouLanModel:getShouLanUbdIdByLsGuid(lsGuid)
if ShoulangId then
local monster=UIShouLanModel:getMonsterData(ShoulangId,lsGuid)
if monster and monster.commItem then
for _,reward in ipairs(monster.commItem)do
local itemId=reward.param_1
local itemVal=reward.param_2
if itemId and itemVal then
itemLookup[itemId]=(itemLookup[itemId]or 0)+itemVal
end
end
end
end

local lookup=lingshouModel:calculateResetReturnItemLookup_ChuanGong(lsGuid)

if lookup and next(lookup)then
for itemId,itemVal in pairs(lookup)do
itemLookup[itemId]=(itemLookup[itemId]or 0)+itemVal
end
end
end

local reward=attrListHelper.transformToList(itemLookup)

return reward
end