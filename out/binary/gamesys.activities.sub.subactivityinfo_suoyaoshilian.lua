









local subActivityInfo_suoyaoshilian={name='suoyaoshilian'}

function subActivityInfo_suoyaoshilian:onInit()
end

function subActivityInfo_suoyaoshilian:onStart()

end

function subActivityInfo_suoyaoshilian:onDelete()

end

function subActivityInfo_suoyaoshilian:checkReddot()
local data=self.data
if data==nil then return false end

local reddot=false


if self.data.shilianFullReddot then
reddot=true
return reddot
end



local shilianCfgLen_self=#self.data.shilianSelfCfg
local shilianCfgLen_full=#self.data.shilianFullCfg
if self.data.shilianMyLen and self.data.shilianMyLen>=shilianCfgLen_self then
if self.data.shilianFullLen and self.data.shilianFullLen>=shilianCfgLen_full then

local cfg=self.data.shilianFullCfg[self.data.shilianFullLen]
local floor=cfg.clearFloor
local maxTargetCount=cfg.maxTargetCount
local isGot=self.data.shilianInfo_full and self.data.shilianInfo_full[floor].gotMaxTargetCount>=maxTargetCount or false
if isGot then

return false
end
end
end




local playerInfo=rankListModel:getPlayerInfo(eRankListType.eShiLianTa)
for i=1,shilianCfgLen_self do
local cfg=self.data.shilianSelfCfg[i]
local floor=cfg.clearFloor
local isGot=self.data.shilianInfo_self and self.data.shilianInfo_self[floor]or false
if not isGot then
local isFinish=playerInfo.data>=floor
if isFinish then
reddot=true
return reddot
end
end
end


for i=1,shilianCfgLen_full do
local cfg=self.data.shilianFullCfg[i]
local floor=cfg.clearFloor
local maxTargetCount=cfg.maxTargetCount
local gotMaxTargetCount=self.data.shilianInfo_full and self.data.shilianInfo_full[floor].gotMaxTargetCount or 0
local isGot=gotMaxTargetCount>=maxTargetCount or false
if not isGot then
local nextTargetIndex=cfg.targetIndexLookup[gotMaxTargetCount]and cfg.targetIndexLookup[gotMaxTargetCount]+1 or 1
local needCount=cfg.targetList[nextTargetIndex].needPlayerCount
local isFinish=self.data.shilianInfo_full[floor].clearCount>=needCount
if isFinish then
reddot=true
return reddot
end
end
end

return reddot
end


function subActivityInfo_suoyaoshilian:initConfigList_sort()
local data=self:getData()or{}


local rankRewardsCfg=self:getSubActConfig('shilianMon')
data.rankRewardsCfg_lookup={}
for i=1,#rankRewardsCfg do
local startIndex=rankRewardsCfg[i][1]
local endIndex=rankRewardsCfg[i][2]
local rewards=rankRewardsCfg[i][3]

for j=startIndex,endIndex do
data.rankRewardsCfg_lookup[j]=rewards
end
end


local shilianSelfCfg_lookup=self:getSubActConfig('shilianMy')
data.shilianSelfCfg={}
for k,v in pairs(shilianSelfCfg_lookup)do
local listItem={clearFloor=k,rewards=v}
table.insert(data.shilianSelfCfg,listItem)
end
table.sort(data.shilianSelfCfg,function(a,b)return a.clearFloor<b.clearFloor end)


local shilianFullCfg_lookup=self:getSubActConfig('shilianFull')
data.shilianFullCfg={}
for k,floorCfg in pairs(shilianFullCfg_lookup)do
local targetList={}
for targetCount,v in pairs(floorCfg)do
table.insert(targetList,{needPlayerCount=targetCount,rewards=v})
end
table.sort(targetList,function(a,b)return a.needPlayerCount<b.needPlayerCount end)
local targetIndexLookup={}
local maxTargetCount=targetList[#targetList].needPlayerCount
for i,v in ipairs(targetList)do
targetIndexLookup[v.needPlayerCount]=i
end
local listItem={clearFloor=k,targetList=targetList,targetIndexLookup=targetIndexLookup,maxTargetCount=maxTargetCount}
table.insert(data.shilianFullCfg,listItem)
end
table.sort(data.shilianFullCfg,function(a,b)return a.clearFloor<b.clearFloor end)

data.isInitConfig=true

self:setData(data)
end

return subActivityInfo_suoyaoshilian