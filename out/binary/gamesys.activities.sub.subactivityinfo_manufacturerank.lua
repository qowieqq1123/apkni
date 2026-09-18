









local subActivityInfo_manufactureRank={name='manufactureRank'}

function subActivityInfo_manufactureRank:onInit()
end

function subActivityInfo_manufactureRank:onStart()


end

function subActivityInfo_manufactureRank:onDelete()

end

function subActivityInfo_manufactureRank:checkReddot()
local reddot=false

return reddot
end

function subActivityInfo_manufactureRank:getManufactureRankListByItemId(itemId)
if not itemId then
logErr("获取生产排行榜数据 但没有传入排行榜对应道具id")
return
end

local data=self:getData()or{}

if not data.manufactureRankList then
return{}
end

local list=data.manufactureRankList[itemId]or{}
local temp={}
local selfRankData=nil
local selfActorId=playerModel:getActorID()
for i,v in ipairs(list)do
local data={
actorId=v.actorId,
playerName=v.name,
zmName=v.zmName,
iconInfo=v.iconInfo,
zmLevel=v.zmLevel,
rankNum=v.rank,
data={
v.scNum,
}
}
table.insert(temp,data)

if v.actorId==selfActorId then
selfRankData=data
end
end

if#temp>0 then
table.sort(temp,function(a,b)
return a.rankNum<b.rankNum
end)
end

return temp,selfRankData
end

function subActivityInfo_manufactureRank:initConfigList_sort(itemId)
local data=self:getData()or{}


local rankAllTypeRewardsCfg=self:getSubActConfig('rankReward')
data.rankRewardsCfg_lookup={}
for rankTypeIndex=1,#rankAllTypeRewardsCfg do
local rankRewardsCfg=rankAllTypeRewardsCfg[rankTypeIndex]
if not data.rankRewardsCfg_lookup[rankTypeIndex]then
data.rankRewardsCfg_lookup[rankTypeIndex]={}
end

for i=1,#rankRewardsCfg do
local startIndex=rankRewardsCfg[i][1]
local endIndex=rankRewardsCfg[i][2]
local rewards=rankRewardsCfg[i][3]

for j=startIndex,endIndex do
data.rankRewardsCfg_lookup[rankTypeIndex][j]=rewards
end
end
end
data.isInitConfig=true

self:setData(data)
end

return subActivityInfo_manufactureRank